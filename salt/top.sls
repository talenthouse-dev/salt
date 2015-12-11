base:
  '*':
    - salt.minion

  'roles:master':
    - match: grain
    - salt.master

  'roles:build':
    - match: grain
    - jenkins
    - nginx
    - jenkins.nginx
    - jenkins.plugins
    - jenkins.jobs
    - th.jenkins
    - sudoers
