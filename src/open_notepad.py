# open_notepad.py
# A simple SikuliX script using Jython (Python 2.7)
# Opens Notepad and types "Packaging practice."

import org.sikuli.script as sikuli

def main():
    screen = sikuli.Screen()

    # Open the Run dialog and launch Notepad
    sikuli.App.open("notepad.exe")

    # Wait for Notepad to appear (up to 10 seconds)
    screen.wait("notepad", 10)

    # Click on the Notepad text area and type the message
    screen.type("Packaging practice.")

if __name__ == "__main__":
    main()
