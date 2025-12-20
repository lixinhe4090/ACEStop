# ACEover

&gt; Auto-config priority & CPU affinity for ACE anti-cheat processes  
&gt; **MIT License** | Copyright © 2025 千河RUAEISA

## 功能概述
- 自动将 **SGuard64.exe** 与 **SGuardSvc64.exe** 的优先级设为 **Idle（最低）**
- 强制锁定到 **最后一个逻辑 CPU 核心**，减少游戏卡顿与硬盘扫盘负载
- 实时监控，进程一旦启动立即生效，无需手动操作任务管理器
- 纯 Batch + PowerShell，零依赖，开源

## 快速使用
1. 下载或克隆本仓库  
2. 右键 `ACEover.bat` → **“以管理员身份运行”**  
3. 保持窗口开启；退出请按 `Ctrl+C → Y → Enter`

## 目录结构

ACEover/
├── ACEover.bat      # 主脚本（英文输出，UTF-8）
├── README.md        # 本文件
└── .gitignore       # Git 忽略规则

## 系统需求
- Windows 10/11（PowerShell 5+）
- 管理员权限（修改进程亲和性必需）

## 开源许可
MIT License  
Copyright © 2025 千河RUAEISA  
此项目为MIT协议开源，意味着您可自由使用、修改、分发，但请保留原始版权与许可证文件。

## 贡献与反馈
欢迎提交 Issue 或 Pull Request，共同完善此项目。