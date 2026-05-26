# open_notepad.py
# SikuliX / Jython (Python 2.7) - entry point
#
# 1. Opens Notepad
# 2. Types "Packaging practice."
# 3. Closes Notepad (without saving)
# 4. Calls Java ApiCaller to fetch a random joke from a REST API

import sys
import os

# ---------------------------------------------------------------
# Add compiled Java classes (out/) to Jython's classpath at runtime
# Uses __file__ so paths resolve correctly when run from any directory
# (important for Windows Task Scheduler, which may use a different CWD)
# ---------------------------------------------------------------
script_dir = os.path.dirname(os.path.abspath(__file__))
out_dir = os.path.join(script_dir, '..', 'out')
sys.path.insert(0, os.path.normpath(out_dir))

import org.sikuli.script as sikuli
from ApiCaller import fetchRandomJoke, parseJoke


def main():
    screen = sikuli.Screen()

    # --- Step 1: Open Notepad ---
    print "[SikuliX] Opening Notepad..."
    sikuli.App.open("notepad.exe")
    screen.wait(2)

    # --- Step 2: Type the message ---
    print "[SikuliX] Typing: Packaging practice."
    screen.type("Packaging practice.")
    screen.wait(1)

    # --- Step 3: Close Notepad without saving (Alt+F4 -> Don't Save) ---
    print "[SikuliX] Closing Notepad..."
    screen.type(sikuli.Key.F4, sikuli.KeyModifier.ALT)
    screen.wait(1)
    screen.type("n")  # "Don't Save" shortcut on the dialog
    screen.wait(1)
    print "[SikuliX] Notepad closed."

    # --- Step 4: Call Java ApiCaller ---
    print "[Java]    Fetching random joke from API..."
    try:
        raw_json = fetchRandomJoke()
        joke     = parseJoke(raw_json)
        print "[Java]    Random Joke:"
        print "          " + joke.replace("\n", "\n          ")
    except Exception as e:
        print "[Java]    API call failed: " + str(e)


if __name__ == "__main__":
    main()
