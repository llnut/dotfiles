return {
  "olimorris/codecompanion.nvim",
  opts = {
    strategies = {
      chat = {
        adapter = "dashscope",
      },
      inline = {
        adapter = "dashscope",
        keymaps = {
          accept_change = {
            modes = { n = "<LocalLeader>a" },
            description = "Accept the suggested change",
          },
          reject_change = {
            modes = { n = "<LocalLeader>r" },
            description = "Reject the suggested change",
          },
        },
      },
      cmd = {
        adapter = "dashscope",
      },
    },
    opts = {
      stream = true,
      tools = true,
      log_level = "TRACE",
      language = "Chinese",
    },
    extensions = {
      history = {
        enabled = true,
        opts = {
          keymap = "gh",
          save_chat_keymap = "sc",
          auto_save = false,
          auto_generate_title = true,
          continue_last_chat = false,
          delete_on_clearing_chat = false,
          picker = "snacks",
          enable_logging = false,
          dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
        },
      },
    },
    adapters = {
      --opts = {
        --  allow_insecure = true,
        --  proxy = "socks://127.0.0.1:9999"
        --},
        http = {
          deepseek = function()
            return require("codecompanion.adapters").extend("deepseek", {
              env = {
                api_key = "cmd:llnut-keys deepseek-apikey",
              },
              schema = {
                model = {
                  default = "deepseek-reasoner",
                  choices = {
                    ["deepseek-reasoner"] = {
                      opts = { can_reason = true }
                    },
                    "deepseek-chat"
                  }
                },
              },
            })
          end,
          dashscope = function()
            local log = require("codecompanion.utils.log")
            local openai = require("codecompanion.adapters.http.openai")
            local utils = require("codecompanion.utils.adapters")

            ---@class CodeCompanion.HTTPAdapter.DashScope: CodeCompanion.HTTPAdapter
            return {
              name = "dashscope",
              formatted_name = "DashScope",
              roles = {
                llm = "assistant",
                user = "user",
              },
              opts = {
                stream = true,
                tools = true,
                vision = false,
              },
              features = {
                text = true,
                tokens = true,
              },
              url = "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions",
              env = {
                --api_key = "DASHSCOPE_API_KEY",
                api_key = "cmd:llnut-keys dashscope-apikey",
              },
              headers = {
                ["Content-Type"] = "application/json",
                Authorization = "Bearer ${api_key}",
              },
              handlers = {
                --- Use the OpenAI adapter for the bulk of the work
                setup = function(self)
                  return openai.handlers.setup(self)
                end,
                tokens = function(self, data)
                  return openai.handlers.tokens(self, data)
                end,
                form_parameters = function(self, params, messages)
                  return openai.handlers.form_parameters(self, params, messages)
                end,
                form_tools = function(self, tools)
                  local model = self.schema.model.default
                  local model_opts = self.schema.model.choices[model]

                  if model_opts.opts and model_opts.opts.can_use_tools == false then
                    if tools and vim.tbl_count(tools) > 0 then
                      log:warn("Tools are not supported for this model")
                    end
                    return
                  end
                  return openai.handlers.form_tools(self, tools)
                end,

                ---Set the format of the role and content for the messages from the chat buffer
                ---@param self CodeCompanion.HTTPAdapter
                ---@param messages table Format is: { { role = "user", content = "Your prompt here" } }
                ---@return table
                form_messages = function(self, messages)
                  messages = utils.merge_messages(messages)
                  messages = utils.merge_system_messages(messages)

                  -- Ensure that all messages have a content field
                  messages = vim
                  .iter(messages)
                  :map(function(msg)
                    local content = msg.content
                    if content and type(content) == "table" then
                      msg.content = table.concat(content, "\n")
                    elseif not content then
                      msg.content = ""
                    end
                    return msg
                  end)
                  :totable()

                  return { messages = messages }
                end,

                ---Output the data from the API ready for insertion into the chat buffer
                ---@param self CodeCompanion.HTTPAdapter
                ---@param data table The streamed JSON data from the API, also formatted by the format_data handler
                ---@param tools? table The table to write any tool output to
                ---@return { status: string, output: { role: string, content: string, reasoning: string? } } | nil
                chat_output = function(self, data, tools)
                  local output = {}

                  if data and data ~= "" then
                    local data_mod = utils.clean_streamed_data(data)
                    local ok, json = pcall(vim.json.decode, data_mod, { luanil = { object = true } })

                    if ok and json.choices and #json.choices > 0 then
                      local choice = json.choices[1]
                      local delta = (self.opts and self.opts.stream) and choice.delta or choice.message

                      if delta then
                        output.role = delta.role
                        output.content = delta.content

                        if delta.reasoning_content then
                          output.reasoning = output.reasoning or {}
                          output.reasoning.content = delta.reasoning_content
                        end

                        -- Process tools
                        if self.opts.tools and delta.tool_calls and tools then
                          for _, tool in ipairs(delta.tool_calls) do
                            if self.opts.stream then
                              local index = tool.index
                              local found = false

                              for i, existing_tool in ipairs(tools) do
                                if existing_tool._index == index then
                                  tools[i]["function"].arguments = (tools[i]["function"].arguments or "")
                                  .. (tool["function"]["arguments"] or "")
                                  found = true
                                  break
                                end
                              end

                              if not found then
                                table.insert(tools, {
                                  ["function"] = {
                                    name = tool["function"]["name"],
                                    arguments = tool["function"]["arguments"] or "",
                                  },
                                  id = tool.id,
                                  type = "function",
                                  _index = index,
                                })
                              end
                            else
                              table.insert(tools, {
                                _index = tool.index,
                                ["function"] = {
                                  name = tool["function"]["name"],
                                  arguments = tool["function"]["arguments"],
                                },
                                id = tool.id,
                                type = "function",
                              })
                            end
                          end
                        end

                        return {
                          status = "success",
                          output = output,
                        }
                      end
                    end
                  end
                end,
                inline_output = function(self, data, context)
                  return openai.handlers.inline_output(self, data, context)
                end,
                tools = {
                  format_tool_calls = function(self, tools)
                    return openai.handlers.tools.format_tool_calls(self, tools)
                  end,
                  output_response = function(self, tool_call, output)
                    return openai.handlers.tools.output_response(self, tool_call, output)
                  end,
                },
                on_exit = function(self, data)
                  return openai.handlers.on_exit(self, data)
                end,
              },
              schema = {
                ---@type CodeCompanion.Schema
                model = {
                  order = 1,
                  mapping = "parameters",
                  type = "enum",
                  desc = "ID of the model to use.",
                  ---@type string|fun(): string
                  default = "qwen-plus",
                  choices = {
                    ["qwen-plus"] = { formatted_name = "DashScope", opts = { can_reason = true, can_use_tools = false } },
                    ["qwen-flash"] = { formatted_name = "DashScope", opts = { can_reason = true, can_use_tools = true } },
                    ["qwen3-max"] = { formatted_name = "DashScope", opts = { can_use_tools = true } },
                    ["qwen3-coder-plus"] = { formatted_name = "DashScope", opts = { can_use_tools = true } },
                  },
                },
                ---@type CodeCompanion.Schema
                temperature = {
                  order = 2,
                  mapping = "parameters",
                  type = "number",
                  optional = true,
                  default = 0.7,
                  desc = "Sampling temperature, controlling the diversity of the model's generated text. A higher temperature increases the diversity of the output, while a lower temperature makes it more deterministic. Range: [0, 2). Since both temperature and top_p can control the diversity of generated text, it is recommended to set only one of them.",
                  validate = function(n)
                    return n >= 0 and n < 2, "Must be between 0 and 2"
                  end,
                },
                ---@type CodeCompanion.Schema
                top_p = {
                  order = 3,
                  mapping = "parameters",
                  type = "number",
                  optional = true,
                  default = 0.95,
                  desc = "The probability threshold for nucleus sampling, controlling the diversity of text generated by the model. Higher top_p values result in more diverse outputs, while lower values produce more deterministic text. Range: (0 and 1]. 0.01 is recommended for qwen3-coder model",
                  validate = function(n)
                    return n > 0 and n <= 1, "Must be between 0 and 1"
                  end,
                },
                ---@type CodeCompanion.Schema
                top_k = {
                  order = 3,
                  mapping = "parameters",
                  type = "number",
                  optional = true,
                  default = 20,
                  desc = "The size of the candidate set for sampling during generation. For example, when set to 50, only the top 50 highest-scoring tokens from a single generation are included in the random sampling candidate set. A higher value increases the randomness of the output, while a lower value enhances determinism. When set to None or when top_k exceeds 100, the top_k strategy is disabled, and only the top_p strategy takes effect.",
                  validate = function(n)
                    return n >= 0, "Must be greater than or equal to 0"
                  end,
                },
                ---@type CodeCompanion.Schema
                presence_penalty = {
                  order = 4,
                  mapping = "parameters",
                  type = "number",
                  optional = true,
                  default = 0,
                  desc = "Controlling the repetition of content in model-generated text. Range: [-2.0, 2.0]. Positive values reduce repetition, while negative values increase it.",
                  validate = function(n)
                    return n >= -2 and n <= 2, "Must be between -2 and 2"
                  end,
                },
                ---@type CodeCompanion.Schema
                max_tokens = {
                  order = 5,
                  mapping = "parameters",
                  type = "integer",
                  optional = true,
                  default = 16384,
                  desc = "The maximum number of tokens to generate in the chat completion. The total length of input tokens and generated tokens is limited by the model's context length.",
                  validate = function(n)
                    return n > 0, "Must be greater than 0"
                  end,
                },
                ---@type CodeCompanion.Schema
                enable_thinking = {
                  order = 6,
                  mapping = "parameters",
                  type = "boolean",
                  optional = true,
                  default = true,
                  desc = "Whether to activate the thinking mode.",
                  subtype_key = {
                    type = "integer",
                  },
                },
                ---@type CodeCompanion.Schema
                thinking_budget = {
                  order = 7,
                  mapping = "parameters",
                  type = "integer",
                  optional = true,
                  default = nil,
                  desc = "The maximum length of the thinking process takes effect only when enable_thinking is true.",
                  validate = function(n)
                    return n > 0, "Must be greater than 0"
                  end,
                },
                ---@type CodeCompanion.Schema
                seed = {
                  order = 8,
                  mapping = "parameters",
                  type = "integer",
                  optional = true,
                  default = nil,
                  desc = "Setting the seed parameter makes the text generation process more deterministic, typically used to ensure consistent results across model runs. By passing the same seed value in each model call while keeping other parameters unchanged, the model will attempt to return identical results. Range: [0 to 2147483647].",
                  validate = function(n)
                    return n >= 0 and n <= 2147483647, "Must be between 0 and 2147483647"
                  end,
                },
                ---@type CodeCompanion.Schema
                logprobs = {
                  order = 9,
                  mapping = "parameters",
                  type = "boolean",
                  optional = true,
                  default = nil,
                  desc = "Whether to return log probabilities of the output tokens or not.",
                  subtype_key = {
                    type = "integer",
                  },
                },
                ---@type CodeCompanion.Schema
                top_logprobs = {
                  order = 10,
                  mapping = "parameters",
                  type = "integer",
                  optional = true,
                  default = nil,
                  desc = "Number of top candidate tokens to return per step. Range: [0, 5]. It takes effect only when logprobs is true.",
                  validate = function(n)
                    return n >= 0 and n <= 5, "Must be between 0 and 5"
                  end,
                },
                ---@type CodeCompanion.Schema
                stop = {
                  order = 11,
                  mapping = "parameters",
                  type = "list",
                  optional = true,
                  default = nil,
                  subtype = {
                    type = "string",
                  },
                  desc = "Generation will automatically stop when the text generated by the model is about to contain the specified string or token_id.",
                  validate = function(l)
                    return #l >= 1 and #l <= 256, "Must have between 1 and 256 elements"
                  end,
                },
                ---@type CodeCompanion.Schema
                enable_search = {
                  order = 12,
                  mapping = "parameters",
                  type = "boolean",
                  optional = true,
                  default = true,
                  desc = "Whether the model uses Internet search results as a reference when generating text.",
                  subtype_key = {
                    type = "integer",
                  },
                },
                ---@type CodeCompanion.Schema
                search_options = {
                  order = 13,
                  mapping = "parameters",
                  type = "object",
                  optional = true,
                  default = {
                    forced_search = true,
                    search_strategy = "turbo", --turbo / max
                    enable_search_extension = false,
                  },
                  desc = "The strategy of online search. It takes effect only when enable_search is true.",
                },
                ---@type CodeCompanion.Schema
                user = {
                  order = 14,
                  mapping = "parameters",
                  type = "string",
                  optional = true,
                  default = nil,
                  desc = "A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse. Learn more.",
                  validate = function(u)
                    return u:len() < 100, "Cannot be longer than 100 characters"
                  end,
                },
              },
            }
          end,
        }
      },
      prompt_library = {
        ["Code Explain In Chinese"] = {
          strategy = "chat",
          description = "中文解释代码",
          opts = {
            index = 5,
            is_default = true,
            is_slash_cmd = false,
            modes = { "v" },
            short_name = "explain in chinese",
            auto_submit = true,
            user_prompt = false,
            stop_context_insertion = true,
          },
          prompts = {
            {
              role = "system",
              content = [[当被要求解释代码时，请遵循以下步骤：
              1. 识别编程语言。
              2. 描述代码的目的，并引用该编程语言的核心概念。
              3. 解释每个函数或重要的代码块，包括参数和返回值。
              4. 突出说明使用的任何特定函数或方法及其作用。
              5. 如果适用，提供该代码如何融入更大应用程序的上下文。]],
              opts = {
                visible = false,
              },
            },
            {
              role = "user",
              content = function(context)
                local input = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                return string.format(
                  [[请解释 buffer %d 中的这段代码:
                  ```%s
                  %s
                  ```
                  ]],
                  context.bufnr,
                  context.filetype,
                  input
                )
              end,
              opts = {
                contains_code = true,
              },
            },
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
    },
  }
