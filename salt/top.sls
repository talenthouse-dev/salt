base:
  '*':
    - salt.minion

  'G@roles:master':
    - salt.master

  'G@roles:build':
    - jenkins
