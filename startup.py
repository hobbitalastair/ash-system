# Python startup code for interactive sessions.
# Based of code in the documentation for the readline module.

import atexit
import os
import readline

XDG = 'XDG_DATA_HOME'
HISTLENGTH = 200

# Find the history file path.
if XDG in os.environ and os.environ[XDG] != "":
    xdg_data_home = os.environ[XDG]
else:
    xdg_data_home = os.path.join(os.path.expanduser('~'), ".local", "share")
histfile = os.path.join(xdg_data_home, "python.history")

# Open/create the file.
try:
    readline.read_history_file(histfile)
    readline.set_history_length(HISTLENGTH)
    print("Read the history file")
except FileNotFoundError:
    open(histfile, 'wb').close()
    readline.add_history("quit()")
    print("Created a new history file")

# Register the handler.
atexit.register(readline.write_history_file, histfile)
