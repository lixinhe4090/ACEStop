# ACEStop

> Auto-config priority & CPU affinity for ACE anti-cheat processes
> **MIT License** | Copyright © 2025 Qianhe RUAEISA

## The following content is provided by Microsoft Translator. Please ignore any grammatical errors.

## Overview
- Automatically set the priority of **SGuard64.exe** and **SGuardSvc64.exe** to **Idle (lowest)**
- Force lock to the **last logical CPU core**, reducing game stutter and disk scan load
- Real-time monitoring: takes effect immediately once the process starts, no need to manually use Task Manager
- Pure Batch/PowerShell, zero dependencies, open source

## Quick Start
1. Download or clone this repository
2. Right-click `ACEover.bat` → **“Run as Administrator”**
3. Keep the window open; to exit, press `Ctrl C → Y → Enter`

## Directory Structure

ACEStop/
├── ACEStop.bat # Main script (English output, UTF-8)
├── README.md # This file
└── .gitignore # Git ignore rules

## System Requirements
- Windows 10/11 (PowerShell admin)
- Administrator privileges (required to modify process affinity)

## License
MIT License
Copyright © 2025 Qianhe RUAEISA
This project is open source under the MIT License, which means you are free to use, modify, and distribute it, but please retain the original copyright and license files.

## Contribution & Feedback
Issues or Pull Requests are welcome to help improve this project.
