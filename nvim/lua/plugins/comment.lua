return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  config = function()
    require("Comment").setup()
  end,
  keys = {
    { "<leader>;", "<Plug>(comment_toggle_linewise_current)", mode = { "n" }, desc = "Comment" },
    { "<leader>;", "<Plug>(comment_toggle_linewise_visual)", mode = { "v" }, desc = "Comment" },
  },
}
