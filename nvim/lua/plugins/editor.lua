return {
  --file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>fE",
        false,
      },
      {
        "<leader>fe",
        false,
      },
      {
        "<leader>E",
        false,
      },
      {
        "<leader>e",
        false,
      },
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
  },
  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  {
    "folke/which-key.nvim",
    opts = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>u", hidden = true },
        { "<leader>:", hidden = true },
        { "<leader>e", hidden = true },
        { "<leader>h", group = "help", icon = { icon = "󰋖", color = "cyan" } },
      })
    end,
    keys = {
      {
        "<leader>h?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
      {
        "<leader>?",
        false,
      },
    },
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader><space>",
        false,
      },
      {
        "<leader>:",
        false,
      },
      {
        "<leader>,",
        false,
      },
      {
        "<leader>fb",
        false,
      },
    },
  },
}
