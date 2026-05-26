@echo off
SETLOCAL

REM ---------------------------------------------------------------
REM build.bat - Compile Java 8 sources into out/
REM ---------------------------------------------------------------

SET PROJECT_DIR=%~dp0
SET SRC_DIR=%PROJECT_DIR%src
SET OUT_DIR=%PROJECT_DIR%out

IF NOT EXIST "%OUT_DIR%" mkdir "%OUT_DIR%"

echo [Build] Compiling Java 8 sources...
javac -source 8 -target 8 -encoding UTF-8 -d "%OUT_DIR%" "%SRC_DIR%\ApiCaller.java"

IF %ERRORLEVEL% NEQ 0 (
    echo [Build] FAILED. Make sure Java 8 JDK is installed and on PATH.
    exit /b 1
)

echo [Build] Success. Classes written to: %OUT_DIR%
ENDLOCAL
