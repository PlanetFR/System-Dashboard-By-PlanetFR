# 🖥️ System Dashboard v3.2

A lightweight, modular Windows automation tool built using **Batch** and **PowerShell**. This dashboard provides a central command center for hardware monitoring, system maintenance, and quick access to Windows utilities without the need for heavy third-party software.

---

## ✨ Features

- **Hardware Detection:** Real-time retrieval of CPU model, RAM capacity (corrected for 64-bit systems), and GPU name.
- **Advanced Task Manager:** View the top 12 processes by memory usage and terminate unresponsive apps by Name or PID.
- **System Maintenance:** One-click cleanup to empty the Recycle Bin and wipe temporary system files.
- **Quick Links:** Instant access to the hidden Windows "All Apps" folder and the System Settings menu.
- **UI Customization:** Cycle through various terminal color themes directly from the menu.
- **Power Controls:** Clean shortcuts for Shutdown, Restart, and Sleep modes.

## 🚀 How to Use

1. **Download** the `System Dashboard_v3.2.bat` file from this repository.
2. **Right-click** the file and select **Run as Administrator** (Required for Maintenance and Task Killing features).
3. Use the keyboard to select an option (1-8) from the main menu.

## 🛠️ Built With

* **Batch (CMD):** For the core logic, menu interface, and user input handling.
* **PowerShell:** Used as a backend engine for hardware queries and advanced system calls.

## 🔒 Privacy & Security

This script is designed with privacy in mind:
* **No Data Collection:** The script does not log or send your system information anywhere.
* **No Hardcoded Data:** It pulls information dynamically; your specific hardware are never stored in the code.
* **Safe Paths:** Uses environment variables like `%temp%` to ensure it only interacts with standard system directories.

---
*Created by PlanetFR*
