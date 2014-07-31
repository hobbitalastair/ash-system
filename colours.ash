# Configuration file for dircolors, a utility to help you set the
# LS_COLORS environment variable used by GNU ls with the --color option.
# Copyright (C) 1996-2014 Free Software Foundation, Inc.
# Copying and distribution of this file, with or without modification,
# are permitted provided the copyright notice and this notice are preserved.
# The keywords COLOR, OPTIONS, and EIGHTBIT (honored by the
# slackware version of dircolors) are recognized but ignored.
# Below, there should be one TERM entry for each termtype that is colorizable
TERM Eterm
TERM ansi
TERM color-xterm
TERM con132x25
TERM con132x30
TERM con132x43
TERM con132x60
TERM con80x25
TERM con80x28
TERM con80x30
TERM con80x43
TERM con80x50
TERM con80x60
TERM cons25
TERM console
TERM cygwin
TERM dtterm
TERM eterm-color
TERM gnome
TERM gnome-256color
TERM hurd
TERM jfbterm
TERM konsole
TERM kterm
TERM linux
TERM linux-c
TERM mach-color
TERM mach-gnu-color
TERM mlterm
TERM putty
TERM putty-256color
TERM rxvt
TERM rxvt-256color
TERM rxvt-cygwin
TERM rxvt-cygwin-native
TERM rxvt-unicode
TERM rxvt-unicode-256color
TERM rxvt-unicode256
TERM screen
TERM screen-256color
TERM screen-256color-bce
TERM screen-bce
TERM screen-w
TERM screen.Eterm
TERM screen.rxvt
TERM screen.linux
TERM st
TERM st-256color
TERM terminator
TERM vt100
TERM xterm
TERM xterm-16color
TERM xterm-256color
TERM xterm-88color
TERM xterm-color
TERM xterm-debian

# Below are the color init strings for the basic file types. A color init
# string consists of one or more of the following numeric codes:
# Attribute codes:
# 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
# Text color codes:
# 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
# Background color codes:
# 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white


NORMAL 00 # no color code at all
FILE 00 # regular file: use no color at all
RESET 0 # reset to "normal" color

# Directories: Blue
DIR 01;34 # directory

# Symbolic links: Cyan
LINK 01;36 # symbolic link. (If you set this to 'target' instead of a
 # numerical value, the color is as for the file pointed to.)
MULTIHARDLINK 04;36 # regular file with more than one link

# Special files: Background of some sort (default is white)
FIFO 47;33 # pipe
SOCK 47;35 # socket
DOOR 47;35 # door
BLK 47;33;01 # block device driver
CHR 47;33;01 # character device driver
ORPHAN 47;31;01 # symlink to nonexistent file, or non-stat'able file
SETUID 37;41 # file that is setuid (u+s)
SETGID 30;43 # file that is setgid (g+s)
CAPABILITY 30;41 # file with capability
STICKY_OTHER_WRITABLE 30;42 # dir that is sticky and other-writable (+t,o+w)
OTHER_WRITABLE 34;42 # dir that is other-writable (o+w) and not sticky
STICKY 37;44 # dir with the sticky bit set (+t) and not other-writable


# Executables or scripts: Green (bright for executables, dull for scripts)
EXEC 01;32
.sh 32
.csh 32
.py 32
.sed 32
.service 32


# Systemd files: Green, magenta, and yellow
.service 00;32
.socket 00;35
.target 01;33


# Document files: Dark red
.md 31
.tex 31
.txt 31
.pdf 31


# Config files (.cfg, .conf, .config): Dark magenta
.conf 00;35
.cfg 00;35
.config 00;35


# Header files, patches, other...: White
.hpp 01;37
.h 01;37
.patch 01;37
.diff 01;37
.file 01;37


# Image files, virtual machines, and databases: Yellow
.db 01;33
.img 01;33
.vdi 01;33
.qcow2 01;33


# Archives or compressed: Dark yellow (orange)
.tar 00;33
.tgz 00;33
.arc 00;33
.arj 00;33
.taz 00;33
.lha 00;33
.lz4 00;33
.lzh 00;33
.lzma 00;33
.tlz 00;33
.txz 00;33
.tzo 00;33
.t7z 00;33
.zip 00;33
.z 00;33
.Z 00;33
.dz 00;33
.gz 00;33
.lrz 00;33
.lz 00;33
.lzo 00;33
.xz 00;33
.bz2 00;33
.bz 00;33
.tbz 00;33
.tbz2 00;33
.tz 00;33
.deb 00;33
.rpm 00;33
.jar 00;33
.war 00;33
.ear 00;33
.sar 00;33
.rar 00;33
.alz 00;33
.ace 00;33
.zoo 00;33
.cpio 00;33
.7z 00;33
.rz 00;33
.cab 00;33

# Images: Magenta
.jpg 01;35
.jpeg 01;35
.gif 01;35
.bmp 01;35
.pbm 01;35
.pgm 01;35
.ppm 01;35
.tga 01;35
.xbm 01;35
.xpm 01;35
.tif 01;35
.tiff 01;35
.png 01;35
.svg 01;35
.svgz 01;35
.mng 01;35
.pcx 01;35
.mov 01;35
.mpg 01;35
.mpeg 01;35
.m2v 01;35
.mkv 01;35
.webm 01;35
.ogm 01;35
.mp4 01;35
.m4v 01;35
.mp4v 01;35
.vob 01;35
.qt 01;35
.nuv 01;35
.wmv 01;35
.asf 01;35
.rm 01;35
.rmvb 01;35
.flc 01;35
.avi 01;35
.fli 01;35
.flv 01;35
.gl 01;35
.dl 01;35
.xcf 01;35
.xwd 01;35
.yuv 01;35
.cgm 01;35
.emf 01;35

# http://wiki.xiph.org/index.php/MIME_Types_and_File_Extensions
# Video: Underscored magenta
.axv 04;35
.anx 04;35
.ogv 04;35
.ogx 04;35
# Audio: Cyan
.aac 00;36
.au 00;36
.flac 00;36
.m4a 00;36
.mid 00;36
.midi 00;36
.mka 00;36
.mp3 00;36
.mpc 00;36
.ogg 00;36
.ra 00;36
.wav 00;36

# http://wiki.xiph.org/index.php/MIME_Types_and_File_Extensions
.axa 00;36
.oga 00;36
.spx 00;36
.xspf 00;36

