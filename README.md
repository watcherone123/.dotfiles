# 使用方法
## 下载
```bash
git clone https://github.com/watcherone123/.dotfiles.git
```
## 配置
1. windows下需要管理员权限运行
2. 按照系统配置对应的local.toml
    - Linux: linux.toml
    - Windows: windows.toml
```bash
cp .dotter/<os>.toml local.toml
```
3. [dotter使用技巧](./docs/dotter.md)

## 运行

- Unix(x86): ./dotter
- Windows: ./dotter.exe
- Unix(arm): ./dotter.arm
```bash
./dotter deploy
```
## 软件安装
- [nushell](./docs/nushell.md) 跨平台的shell
- [wezterm](./docs/wezterm.md)跨平台终端
- [starship](./docs/starship.md)跨平台终端美化
- [laygit](./docs/lazygit.md)
- [yazi](./docs/yazi.md)终端文件管理
## 参考
1. https://github.com/SuperCuber/dotter

