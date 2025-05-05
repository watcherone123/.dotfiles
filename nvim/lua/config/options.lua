if vim.g.neovide then
  -- 开启neovide帧率测试
  vim.g.neovide_profiler = false
  -- 设置刷新帧率
  vim.g.neovide_refresh_rate = 60
  -- vim.o.guifont = "BlexMono Nerd Font Text:h14"
  --
  vim.g.neovide_transparency = 1.0
  vim.g.neovide_cursor_animation_length = 0.1
  vim.g.neovide_cursor_trail_size = 0.3
  vim.g.neovide_cursor_vfx_mode = ""
  vim.g.neovide_cursor_vfx_particle_density = 10.0
  vim.g.neovide_cursor_vfx_opacity = 150.0
end

if vim.g.nvy then
  vim.o.guifont = "FiraCode Nerd Font:h12"
end
-- 性能优化设置
vim.opt.updatetime = 100 -- 减少更新延迟
vim.opt.timeoutlen = 300 -- 减少等待时间
vim.opt.ttimeoutlen = 10 -- 减少终端等待时间
vim.opt.synmaxcol = 200 -- 限制语法高亮列数
vim.opt.hidden = true -- 允许隐藏缓冲区
vim.opt.history = 100 -- 命令历史记录
vim.opt.undolevels = 1000 -- 撤销历史记录

-- 文件系统优化
vim.opt.swapfile = false -- 禁用交换文件
vim.opt.backup = false -- 禁用备份文件
vim.opt.writebackup = false -- 禁用写入备份

-- 内存优化
vim.opt.maxmempattern = 2000 -- 限制模式匹配内存使用

-- 设置空行（end of buffer）的填充字符为空格，去除默认的 ~ 符号
vim.opt.fillchars = { eob = " " }
-- 搜索时忽略大小写
vim.opt.ignorecase = true
-- 如果搜索包含大写字母，则变为大小写敏感
vim.opt.smartcase = true
-- 启用永久撤销历史，关闭文件后保存撤销历史
vim.opt.undofile = true
--将 Neovim 的跳转列表行为设置为“栈”模式，使得最近的跳转位置更容易通过 Ctrl-o 和 Ctrl-i 访问
vim.opt.jumpoptions = "stack"
-- 设置编码格式
vim.o.fileencodings = "utf-8"
vim.o.enc = "utf8"

vim.g.lazyvim_picker = "fzf"
vim.g.loaded_perl_provider = 0 -- Disable perl provider
vim.g.loaded_ruby_provider = 0 -- Disable ruby provider
vim.g.loaded_node_provider = 0 -- Disable node provider
-- vim.opt.shell = "nu"
vim.g.lazyvim_python_lsp = "pyright"
vim.opt.list = false
-- vim.opt.listchars:append("space:.")

vim.g.lazyvim_cmp = "blink.cmp"
-- 设置 tab 为 4 个空格
vim.opt.tabstop = 4 -- tab 宽度为 4 个字符
vim.opt.shiftwidth = 4 -- 缩进宽度为 4 个字符
vim.opt.expandtab = true -- 将 tab 转换为空格
vim.opt.softtabstop = 4 -- 按 tab 时插入 4 个空格
