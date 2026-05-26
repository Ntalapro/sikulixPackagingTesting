#!/bin/bash
# Run the SikuliX script using the SikuliX IDE/runner
# Adjust the path to sikulix.jar as needed

SIKULIX_JAR="sikulix.jar"

java -jar $SIKULIX_JAR -r src/open_notepad.py
