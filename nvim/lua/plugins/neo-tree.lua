return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>e", ":Neotree reveal_force_cwd<CR>", desc = "NeoTree", silent = true },
    { "<leader>fe", ":Neotree reveal_force_cwd<CR>", desc = "NeoTree", silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ["<leader>e"] = "close_window",
          ["l"] = function(state)
            require("neo-tree.sources.filesystem.commands").open(state)
          end,
          ["h"] = "navigate_up",
        },
      },
    },
    buffers = {
      window = {
        mappings = {
          ["h"] = "navigate_up",
          ["l"] = function(state)
            require("neo-tree.sources.filesystem.commands").open(state)
          end,
        },
      },
    },
  },
}
