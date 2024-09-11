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
    opts = {
      pickers = {
        find_files = {
          theme = "ivy",
        },
        git_files = {
          theme = "ivy",
        },
        grep_string = {
          theme = "ivy",
        },
        live_grep = {
          theme = "ivy",
        },
        oldfiles = {
          theme = "ivy",
        },
        jumplist = {
          theme = "ivy",
        },
        current_buffer_fuzzy_find = {
          theme = "ivy",
        },
        buffers = {
          theme = "ivy",
        },
      },
    },
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
      -- {
      --   "<leader>ff",
      --   function ()
      --     local builtin = require('telescope.builtin')
      --     local themes = require('telescope.themes')
      --     builtin.find_files(themes.get_ivy())
      --   end, 
      --   desc = "find files"
      -- },
    },
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<Leader>gm", "<cmd>Neogit<CR>", desc = "Neogit" },
    },
    -- See: https://github.com/TimUntersberger/neogit#configuration
    opts = {
      disable_signs = false,
      disable_context_highlighting = false,
      disable_commit_confirmation = false,
      signs = {
        section = { ">", "v" },
        item = { ">", "v" },
        hunk = { "", "" },
      },
      integrations = {
        diffview = true,
      },
    },
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    event = "UIEnter",
    opts = { useDefaultKeymaps = true },
  },
}
