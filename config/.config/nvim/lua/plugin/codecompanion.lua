return {
  "olimorris/codecompanion.nvim",
  opts = {
    strategies = {
      chat = {
        adapter = "deepseek",
      },
      inline = {
        adapter = "deepseek",
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
        adapter = "deepseek",
      },
    },
    opts = {
      stream = true,
      -- tools = true,
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
            --temperature = {
            --  default = 0.4,
            --},
          },
        })
      end,
    },
    prompt_library = {
      ["DeepSeek Explain In Chinese"] = {
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
