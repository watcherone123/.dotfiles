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
}
