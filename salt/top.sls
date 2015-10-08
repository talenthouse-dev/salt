base:
  '*':
    - salt.minion

  'G@roles:master':
    - salt.master

  'G@roles:build':
    - jenkins
    - nginx
    - jenkins.nginx
    - jenkins.plugins
