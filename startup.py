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
    history_len = readline.get_history_length()
except FileNotFoundError:
    open(histfile, 'wb').close()
    history_len = 0

def save(prev_history_len, histfile):
    """ Append new history onto the file. """
    new_history_len = readline.get_history_length()
    # We cap the history length.
    readline.set_history_length(HISTLENGTH)
    readline.append_history_file(new_history_len - prev_history_len, \
            histfile)

# Register the handler.
atexit.register(save, history_len, histfile)
