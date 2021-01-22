# Sudoers file for ash

# Some extra defaults.
Defaults !env_reset
Defaults targetpw

# Don't timeout waiting for input
Defaults passwd_timeout=0

# Timeout passwords after 20 minutes, shared between all ttys
Defaults timestamp_timeout=20
Defaults timestamp_type=global

ash ALL = (ALL) ALL
