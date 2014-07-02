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

