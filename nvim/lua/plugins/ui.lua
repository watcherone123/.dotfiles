return {
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local LazyVim = require("lazyvim.util")
      opts.sections.lualine_c[4] = {
        LazyVim.lualine.pretty_path({
          length = 0,
          relative = "cwd",
          modified_hl = "MatchParen",
          directory_hl = "",
          filename_hl = "Bold",
          modified_sign = "",
          readonly_icon = " 󰌾 ",
        }),
      }
      opts.sections.lualine_z = {}
    end,
  },
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    init = function()
      -- foreground option can be material, mix, or original
      vim.g.gruvbox_material_foreground = "original"
      --background option can be hard, medium, soft
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_visual = "reverse"
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
  { "folke/snacks.nvim", opts = { dashboard = { enabled = false } } },
  {
    "HiPhish/rainbow-delimiters.nvim",
  },
}
