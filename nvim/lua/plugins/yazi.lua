return {
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {
      -- check the installation instructions at
      -- https://github.com/folke/snacks.nvim
      "folke/snacks.nvim",
    },
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>fy",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>fY",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig | {}
    opts = {
      {
        "nvim-neo-tree/neo-tree.nvim",
        opts = {
          filesystem = {
            hijack_netrw_behavior = "disabled",
          },
        },
      },
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },

      integrations = {
        --- What should be done when the user wants to grep in a directory
        grep_in_directory = "fzf-lua",
        grep_in_selected_files = "fzf-lua",
        --- Similarly, search and replace in the files in the directory
        replace_in_directory = function(directory)
          -- default: grug-far.nvim
        end,
        replace_in_selected_files = function(selected_files)
          -- default: grug-far.nvim
        end,
        -- `grealpath` on OSX, (GNU) `realpath` otherwise
        resolve_relative_path_application = "",
      },
      ---@diagnostic disable-next-line: missing-fields
      hooks = {
        yazi_closed_successfully = function(chosen_file, config, state)
          if chosen_file == nil and state.last_directory.filename then
            vim.notify("Changing directory to " .. state.last_directory.filename)
            vim.fn.chdir(state.last_directory.filename)
          end
        end,
      },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      -- vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
  },
  {
    -- example: a yazi plugin monorepo which provides multiple plugins for
    -- yazi. To use it, you need to specify the sub_dir for the plugin you want
    -- to install.
    "redbeardymcgee/yazi-plugins",
    lazy = true,
    build = function(plugin)
      -- This is a plugin like flash.nvim in neovim - it allows you to jump to
      -- a line by typing the first few characters of the line.
      -- https://github.com/redbeardymcgee/yazi-plugins
      require("yazi.plugin").build_plugin(plugin, { sub_dir = "easyjump.yazi" })
    end,
  },
}
