sudoers:
  includedir: /etc/sudoers.d
  users:
    root:
      - 'ALL=(ALL:ALL) ALL'
    jenkins:
      - 'ALL=(root) NOPASSWD: /usr/bin/docker'
  defaults:
    generic:
      - requiretty
      - '!visiblepw'
      - always_set_home
      - env_reset
      - env_keep =  "COLORS DISPLAY HOSTNAME HISTSIZE INPUTRC KDEDIR LS_COLORS"
      - env_keep += "MAIL PS1 PS2 QTDIR USERNAME LANG LC_ADDRESS LC_CTYPE"
      - env_keep += "LC_COLLATE LC_IDENTIFICATION LC_MEASUREMENT LC_MESSAGES"
      - env_keep += "LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE"
      - env_keep += "LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET XAUTHORITY"
      - secure_path = /sbin:/bin:/usr/sbin:/usr/bin
