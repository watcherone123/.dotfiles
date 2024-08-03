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
## 运行
- Unix(x86): ./dotter
- Windows: ./dotter.exe
- Unix(arm): ./dotter.arm
```bash
./dotter deploy
```
