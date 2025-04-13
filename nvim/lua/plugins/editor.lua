--- 快速交换选中的行或者文本
return {
  {
    "gbprod/substitute.nvim",
    config = function()
      require("substitute").setup()
      vim.keymap.set("n", ",x", require("substitute.exchange").operator, { noremap = true })
      vim.keymap.set("n", ",xx", require("substitute.exchange").line, { noremap = true })
      vim.keymap.set("x", "X", require("substitute.exchange").visual, { noremap = true })
      vim.keymap.set("n", ",xc", require("substitute.exchange").cancel, { noremap = true })
      vim.keymap.set("n", ",r", require("substitute").operator, { noremap = true })
      vim.keymap.set("x", ",r", require("substitute").visual, { noremap = true })
    end,
  },
  {
    "folke/flash.nvim",
    opts = {
      char = {
        keys = { "f", "F", "t", "T", ";" },
      },
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
  },
  {
    "stevearc/conform.nvim",
    opts = function()
      ---@type conform.setupOpts
      local opts = {
        formatters_by_ft = {
          python = function(bufnr)
            if require("conform").get_formatter_info("ruff_format", bufnr).available then
              return { "ruff_format" }
            else
              return { "isort", "black" }
            end
          end,
          c = { "clang-format" },
          lua = { "stylua" },
          fish = { "fish_indent" },
          sh = { "shfmt" },
          toml = { "taplo" },
          cmake = { "cmake_format" },
          gn = { "gn" },
          zig = { "zig" },
        },
      }
      return opts
    end,
  },
  { "jdhao/whitespace.nvim", event = "VeryLazy" },
  {
    "mcauley-penney/visual-whitespace.nvim",
    opts = {
      highlight = { link = "Visual" },
      space_char = "·",
      tab_char = " ",
      nl_char = " ",
      cr_char = " ",
      enabled = true,
      excluded = {
        filetypes = {},
        buftypes = {},
      },
    },
  },
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "folke/trouble.nvim",
    optional = true,
    keys = {
      { "<leader>cs", false },
    },
  },
  {
    "liuchengxu/vista.vim",
    enabled = function()
      local utils = require("config.utils")
      return utils.executable("ctags")
    end,
    cmd = "Vista",
    init = function()
      vim.g.vista_echo_cursor = false
      vim.g.vista_stay_on_open = false
    end,
    keys = { { "<leader>cs", "<cmd>Vista!!<cr>", desc = "Toggle Outline" } },
  },
  {
    "mbbill/undotree",
    init = function()
      vim.g.undotree_DiffCommand = "difft"
    end,
    keys = { { "<leader><F5>", "<cmd>UndotreeToggle<cr>", desc = "Undotree" } },
  },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      require("config.nvim-statuscol")
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "VeryLazy",
    opts = {},
    init = function()
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function()
      require("config.nvim-ufo")
    end,
  },
  {
    "tpope/vim-sleuth",
    event = "VeryLazy",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    keys = {
      { "<c-=>", desc = "Increment Selection" },
      { "<bs>", desc = "Decrement Selection", mode = "x" },
    },
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "make",
        "meson",
        "nu",
        "powershell",
        "proto",
        "tcl",
        "zig",
        "ini",
        "gn",
        "cpp",
        "asm",
      },
      incremental_selection = {
        keymaps = {
          init_selection = "<C-=>",
          node_incremental = "<C-=>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
  },
}
