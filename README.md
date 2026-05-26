# SikuliX Packaging Testing

A simple Jython project using SikuliX to automate opening Notepad and typing text.

## Requirements

| Tool | Version |
|------|---------|
| Java | 8 |
| Python (Jython) | 2.7 |
| SikuliX | 2.x |

## Project Structure

```
sikulixPackagingTesting/
├── src/
│   └── open_notepad.py   # Main SikuliX/Jython script
├── run.bat               # Windows launcher
├── run.sh                # Linux/macOS launcher
└── README.md
```

## Setup

1. Download the latest `sikulix.jar` from [SikuliX releases](https://github.com/RaiMan/SikuliX1/releases).
2. Place `sikulix.jar` in the root of this project.
3. Make sure Java 8 is installed and on your PATH.

## Run

**Windows:**
```bat
run.bat
```

**Linux/macOS:**
```bash
bash run.sh
```

## What it does

1. Launches `notepad.exe`.
2. Waits for the Notepad window to appear.
3. Types `Packaging practice.` into the text area.
