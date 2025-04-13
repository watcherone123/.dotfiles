local key_map = vim.keymap
local map_del = vim.keymap.del

-- 删除默认配置的快捷键
map_del("n", "<leader>K")
map_del("n", "<leader>L")
map_del("n", "<leader>-")
map_del("n", "<leader>|")

-- tabs
map_del("n", "<leader><tab>l")
map_del("n", "<leader><tab>o")
map_del("n", "<leader><tab>f")
map_del("n", "<leader><tab><tab>")
map_del("n", "<leader><tab>]")
map_del("n", "<leader><tab>d")
map_del("n", "<leader><tab>[")
map_del("n", "<leader>uf")
map_del("n", "<leader>uF")
map_del("n", "<leader>us")
map_del("n", "<leader>uw")
map_del("n", "<leader>uL")
map_del("n", "<leader>ud")
map_del("n", "<leader>ul")
map_del("n", "<leader>uc")
map_del("n", "<leader>uT")
map_del("n", "<leader>ub")
map_del("n", "<leader>uh")
map_del("n", "<leader>`")
map_del("n", "<leader>l")
map_del("n", "<leader>bb")
map_del("n", ";")
map_del("n", "<leader>n")
map_del("n", "<leader>?")
map_del("n", "<leader>S")
map_del("n", "<leader>.")
-- Increment/decrement
key_map.set("n", "+", "<C-a>")
key_map.set("n", "-", "<C-x>")
-- 窗口配置
key_map.set("n", "<leader>w/", "<C-W>v", { desc = "Split window Vertically" })
key_map.set("n", "<leader>w-", "<C-W>s", { desc = "Split window Below" })
key_map.set("n", "<leader>wq", ":close<CR>", { noremap = true, silent = true })
key_map.set("n", "<leader>wo", ":only<CR>", { noremap = true, silent = true })
key_map.set({ "n", "v" }, "<leader>=", function()
  LazyVim.format({ force = true })
end, { noremap = true, silent = true, desc = "Format" })
-- Select all
key_map.set("n", "<C-a>", "gg<S-v>G")

-- Paste non-linewise text above or below current line, see https://stackoverflow.com/a/1346777/6064933
key_map.set("n", "<leader>p", "m`o<ESC>p``", { desc = "paste below current line" })
key_map.set("n", "<leader>P", "m`O<ESC>p``", { desc = "paste above current line" })
-- Move the cursor based on physical lines, not the actual lines.
key_map.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
key_map.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
key_map.set("n", "^", "g^")
key_map.set("n", "0", "g0")
-- Go to start or end of line easier
key_map.set({ "n", "x" }, "gh", "^")
key_map.set({ "n", "x" }, "gl", "g_")
-- Change current working directory locally and print cwd after that,
-- see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
key_map.set("n", "<leader>fd", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", { desc = "change cwd" })
-- Change text without putting it into the vim register,
-- see https://stackoverflow.com/q/54255/6064933
key_map.set("n", "c", '"_c')
key_map.set("n", "C", '"_C')
key_map.set("n", "cc", '"_cc')
key_map.set("x", "c", '"_c')
-- Replace visual selection with text in register, but not contaminate the register,
-- see also https://stackoverflow.com/q/10723700/6064933.
key_map.set("x", "p", '"_c<Esc>p')
-- Go to beginning of command in command-line mode
key_map.set("c", "<C-A>", "<HOME>")

-- 设置 <leader>lr 快捷键来重启 LSP 服务
key_map.set("n", "<leader>lr", ":LspRestart<CR>", { noremap = true, silent = true, desc = "Restart LSP" })
-- Remove trailing whitespace characters
key_map.set("n", "<leader>c<space>", "<cmd>StripTrailingWhitespace<cr>", { desc = "remove trailing space" })
