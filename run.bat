@echo off
SETLOCAL

REM ---------------------------------------------------------------
REM run.bat - Build and run the SikuliX/Jython script

REM Designed to be called by Windows Task Scheduler.
REM Set SIKULIX_JAR to the absolute path of your sikulix.jar.
REM ---------------------------------------------------------------

SET PROJECT_DIR=%~dp0
SET SIKULIX_JAR=%PROJECT_DIR%sikulix.jar
SET SCRIPT=%PROJECT_DIR%src\open_notepad.py
SET LOG_FILE=%PROJECT_DIR%logs\run.log

REM Create logs directory if it doesn't exist
IF NOT EXIST "%PROJECT_DIR%logs" mkdir "%PROJECT_DIR%logs"

REM Log start time
echo. >> "%LOG_FILE%"
echo ===================================== >> "%LOG_FILE%"
echo Run started: %DATE% %TIME% >> "%LOG_FILE%"
echo ===================================== >> "%LOG_FILE%"

REM Verify sikulix.jar exists
IF NOT EXIST "%SIKULIX_JAR%" (
    echo [ERROR] sikulix.jar not found at: %SIKULIX_JAR% >> "%LOG_FILE%"
    echo [ERROR] sikulix.jar not found at: %SIKULIX_JAR%
    exit /b 1
)

REM Step 1: Build Java sources
call "%PROJECT_DIR%build.bat" >> "%LOG_FILE%" 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Build failed. Check %LOG_FILE% >> "%LOG_FILE%"
    exit /b 1
)

REM Step 2: Run SikuliX script
echo [Run] Launching SikuliX... >> "%LOG_FILE%"
java -jar "%SIKULIX_JAR%" -r "%SCRIPT%" >> "%LOG_FILE%" 2>&1

IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] SikuliX script failed. Check %LOG_FILE%
    exit /b 1
)

echo [Run] Completed successfully. >> "%LOG_FILE%"
echo Run finished: %DATE% %TIME% >> "%LOG_FILE%"

ENDLOCAL
