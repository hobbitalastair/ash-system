#!/usr/bin/perl
# From oldach.net/palmtime.html
# This appears to be broken...

use strict;
use Palm::Raw;
use ColdSync;
use ColdSync::SPC;

&Palm::PDB::RegisterPRCHandlers("Palm::Raw", "");

StartConduit("sync");

# This doesn't actually work...
my ($sec, $min, $hour, $day, $month, $year) = localtime();
$year += 1900; # Year correction
++$month; # Month correction

dlp_SetSysDateTime($year, $month, $day, $hour, $min, $sec) &&
    die "501 Cannot SetSysDateTime";

EndConduit();
