return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>cm", false },
      { "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap
      keys[#keys + 1] = { "<leader>cl", false }
      keys[#keys + 1] = {
        "<leader>ll",
        function()
          Snacks.picker.lsp_config()
        end,
        desc = "Lsp Info",
      }
    end,
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- required by nvim-ufo
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
    end,
  },
}
