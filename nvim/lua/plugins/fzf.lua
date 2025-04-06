return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    { "<leader>bb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
    { "<leader>hk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
    { "<leader>hM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
    { "<leader>hh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
    { "<leader>fb", false },
    { "<leader>sa", false },
    { "<leader>sh", false },
    { "<leader>sk", false },
    { "<leader>sM", false },
    { "<leader>:", false },
    { "<leader>,", false },
    { "<leader><space>", false },
  },
}
