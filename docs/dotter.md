# 介绍

dotter是一个dotfiles管理软件

## 基础

1. 如果配置文件中含有`{{}}`模板符号，配置文件需要如下：

   ```toml
   [lazygit.files]
   "lazygit/config.yml" = { target = "~/.config/lazygit/config.yml", type = "symbolic" }
   ```

   config.yml文件中包含{{}}模板符号

2. dotter自动识别{{}}符号为模板文件

