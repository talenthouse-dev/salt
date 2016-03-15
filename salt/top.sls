base:
  '*':
    - salt.minion

  'roles:cron':
    - match: grain
    - th.cron

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
