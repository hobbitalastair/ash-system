###############################################################################
# Unison config for syncing ash's home directory across multiple computers
#
#
# Author: Alastair Hughes
# Contact: <hobbitalastair at yandex dot com>
# Date: 7-2-2014
###############################################################################


# Add one root only...
# The other is specified on the command line as a ssh->
root = /home/ash


#
# Paths
#

# Programming paths
path = c
path = python

# Document paths
path = documents
path = images
path = uc

# Config and data files
path = .config
path = .data


#
# Ignore
# 

# Ignore chromium's config; chromium stores a lot of data here that is not
# syncable as it only applies to one session
ignore = Path .config/chromium

# Ignore any files in Unison's storage directory
ignore = Path .config/unison

# Ignore any object files
ignore = Name *.o


# 
# Merging
#

merge = Name * -> diff3 -3 -m CURRENT1 CURRENTARCH CURRENT2 > NEW


#
# Backups
#

# Hold the backups in one spot
backuplocation = central
backupdir = /home/ash/.config/unison/backups
# Maximum of 5 backups of each file
maxbackups = 5
# Naming of the backup ($VERSION.<file>.backup)
backupprefix = $VERSION.
backupsuffix = .backup

# Keep backups of current files (for merging using diff3
backupcurrent = Name *

backup = Path documents
backup = Path uc
backup = Path python
backup = Path c

