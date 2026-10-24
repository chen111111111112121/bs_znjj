# 智能家居 Demo · R01

开发方式：STM32CubeMX 配置硬件，Keil5 编写和编译代码。R01 开发分支为 `feature/r01`，主工程使用同一仓库的 `develop` 分支。

## 工程入口

- [CubeMX 配置](firmware/SmartHomeDemo/SmartHomeDemo.ioc)
- [Keil5 工程](firmware/SmartHomeDemo/MDK-ARM/SmartHomeDemo.uvprojx)，目标 `SmartHomeDemo`
- [启动与主循环](firmware/SmartHomeDemo/Core/Src/main.c)
- [R01 配置、编译及接板步骤](docs/03_R01_工程说明.md)
- [项目需求](docs/01_项目需求.md) / [引脚规划](docs/02_引脚规划与检查.md)

在 Keil 中选择 Rebuild；也可以在仓库目录运行：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build.ps1
```

脚本调用本机 `D:\Keil_v5\UV4\UV4.exe`，可通过 `-UV4` 指定其他安装位置。编译日志在 `artifacts/keil-build.log`；HEX 和 AXF 在 `firmware/SmartHomeDemo/MDK-ARM/SmartHomeDemo/`，构建产物不纳入版本控制。

当前已通过 Keil 全量编译。主控板暂未连接，下载、串口心跳和实机时钟仍待验证，因此尚未成为通过实机验证的绿色基线。
