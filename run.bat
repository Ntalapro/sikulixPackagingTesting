@echo off
REM Run the SikuliX script using the SikuliX IDE/runner
REM Adjust the path to sikulix.jar as needed

set SIKULIX_JAR=sikulix.jar

java -jar %SIKULIX_JAR% -r src/open_notepad.py
