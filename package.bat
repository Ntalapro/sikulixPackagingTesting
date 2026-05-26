@echo off
SETLOCAL

REM ---------------------------------------------------------------
REM package.bat
REM Compiles Java sources and bundles the entire project into
REM a distributable ZIP file ready to deploy and schedule.
REM
REM Output: dist\sikulixPackagingTesting.zip
REM ---------------------------------------------------------------

SET PROJECT_DIR=%~dp0
SET DIST_DIR=%PROJECT_DIR%dist
SET PACKAGE_DIR=%DIST_DIR%\sikulixPackagingTesting

REM Step 1: Build Java sources
echo [Package] Building Java sources...
call "%PROJECT_DIR%build.bat"
IF %ERRORLEVEL% NEQ 0 exit /b 1

REM Step 2: Create package folder
IF NOT EXIST "%PACKAGE_DIR%" mkdir "%PACKAGE_DIR%"
IF NOT EXIST "%PACKAGE_DIR%\src" mkdir "%PACKAGE_DIR%\src"
IF NOT EXIST "%PACKAGE_DIR%\out" mkdir "%PACKAGE_DIR%\out"
IF NOT EXIST "%PACKAGE_DIR%\logs" mkdir "%PACKAGE_DIR%\logs"

REM Step 3: Copy files
echo [Package] Copying project files...
copy "%PROJECT_DIR%src\open_notepad.py" "%PACKAGE_DIR%\src\" >nul
copy "%PROJECT_DIR%src\ApiCaller.java"  "%PACKAGE_DIR%\src\" >nul
copy "%PROJECT_DIR%out\ApiCaller.class" "%PACKAGE_DIR%\out\" >nul
copy "%PROJECT_DIR%run.bat"             "%PACKAGE_DIR%\"     >nul
copy "%PROJECT_DIR%build.bat"           "%PACKAGE_DIR%\"     >nul
copy "%PROJECT_DIR%README.md"           "%PACKAGE_DIR%\"     >nul

REM Step 4: Copy sikulix.jar if it exists
IF EXIST "%PROJECT_DIR%sikulix.jar" (
    echo [Package] Including sikulix.jar...
    copy "%PROJECT_DIR%sikulix.jar" "%PACKAGE_DIR%\" >nul
) ELSE (
    echo [Package] WARNING: sikulix.jar not found - you must add it to the package manually.
)

REM Step 5: Create ZIP using PowerShell (built into Windows 8+)
echo [Package] Creating ZIP archive...
powershell -Command "Compress-Archive -Path '%PACKAGE_DIR%' -DestinationPath '%DIST_DIR%\sikulixPackagingTesting.zip' -Force"

IF %ERRORLEVEL% NEQ 0 (
    echo [Package] ZIP creation failed.
    exit /b 1
)

echo.
echo [Package] Done! Distributable package created at:
echo           %DIST_DIR%\sikulixPackagingTesting.zip
echo.
echo [Package] To schedule on Windows Task Scheduler, point the action to:
echo           run.bat (inside the unzipped folder)

ENDLOCAL
