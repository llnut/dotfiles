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
                default = "deepseek-chat",
              },
              --temperature = {
              --  default = 0.4,
              --},
            },
          })
        end,
      },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim",
  },
}
