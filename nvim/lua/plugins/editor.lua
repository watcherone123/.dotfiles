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
      jump = { nohlsearch = true },
      prompt = {
        win_config = {
          border = "none",
          -- Place the prompt above the statusline.
          row = -3,
        },
      },
      search = {
        exclude = {
          "notify",
          "cmp_menu",
          "noice",
          "flash_prompt",
          "qf",
          function(win)
            -- Floating windows from bqf.
            if vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win)):match("BqfPreview") then
              return true
            end

            -- Non-focusable windows.
            return not vim.api.nvim_win_get_config(win).focusable
          end,
        },
      },
      modes = {
        -- Enable flash when searching with ? or /
        search = { enabled = true },
      },
    },
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
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      vim.defer_fn(function()
        require("nvim-treesitter.install").update({ with_sync = true })
      end, 0)
    end,
  },
  {
    "nmac427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup({})
    end,
  },
  {
    "gbprod/yanky.nvim",
    opts = {
      ring = { history_length = 20 },
      highlight = { timer = 250 },
    },
    keys = {
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
      { "<leader>p", "<Plug>(YankyPutAfterLinewise)", desc = "Put yanked text in line below" },
      { "<leader>P", "<Plug>(YankyPutBeforeLinewise)", desc = "Put yanked text in line above" },
      { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
      { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
      { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yanky yank" },
    },
  },
  -- {
  --   "folke/which-key.nvim",
  --   config = function()
  --     -- local wk_reg = require("which-key.plugins.registers")
  --     -- wk_reg.mappings = {
  --     --   icon = { icon = "󰅍 ", color = "blue" },
  --     --   plugin = "registers",
  --     --   { '"', mode = { "n", "x" }, desc = "registers" },
  --     --   { "<c-r>", mode = { "i", "c" }, desc = "registers" },
  --     -- }
  --   end,
  -- },
}
