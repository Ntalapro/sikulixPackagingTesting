# Setting Up Windows Task Scheduler

This guide explains how to schedule `run.bat` to run automatically on Windows.

---

## Prerequisites

1. Unzip the package to a fixed directory, e.g.:
   ```
   C:\tasks\sikulixPackagingTesting\
   ```
2. Place `sikulix.jar` inside that folder.
3. Make sure **Java 8 JDK** is installed and `java` is on the system PATH.

---

## Steps

### 1. Open Task Scheduler
- Press `Win + R`, type `taskschd.msc`, press Enter.

### 2. Create a New Task
- Click **"Create Task"** (not Basic Task — this gives full control).

### 3. General Tab
| Setting | Value |
|---------|-------|
| Name | `SikuliX Packaging Test` |
| Run whether user is logged on or not | ✅ checked |
| Run with highest privileges | ✅ checked |
| Configure for | Windows 10 / Windows 11 |

> ⚠️ "Run whether user is logged on or not" is required for SikuliX since it needs a desktop session.
> Use **"Run only when user is logged on"** if SikuliX has trouble finding the screen.

### 4. Triggers Tab
- Click **New** and set your desired schedule (e.g., Daily at 9:00 AM).

### 5. Actions Tab
- Click **New**.

| Field | Value |
|-------|-------|
| Action | Start a program |
| Program/script | `C:\tasks\sikulixPackagingTesting\run.bat` |
| Start in (optional) | `C:\tasks\sikulixPackagingTesting\` |

> ⚠️ The **"Start in"** field is important — it sets the working directory so relative paths in `run.bat` resolve correctly.

### 6. Conditions Tab
- Uncheck **"Start the task only if the computer is on AC power"** if running on a laptop.

### 7. Save
- Click OK and enter your Windows password when prompted.

---

## Logs

Each run appends output to:
```
C:\tasks\sikulixPackagingTesting\logs\run.log
```

Check this file if the task runs but produces no visible result.

---

## Quick Test

Right-click the task in Task Scheduler and click **"Run"** to test it immediately.
