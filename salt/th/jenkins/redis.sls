{% set remi_gpg_path = "/etc/pki/rpm-gpg/RPM-GPG-KEY-remi" %}

remi-gpg:
  file.managed:
    - name: {{ remi_gpg_path }}
    - source: salt://th/jenkins/files/{{ remi_gpg_path }}

remi:
  pkgrepo.managed:
    - humanname: Remi's RPM repository for Enterprise Linux 6 - $basearch
    - mirrorlist: http://rpms.remirepo.net/enterprise/6/remi/mirror
    - gpgcheck: 1
    - gpgkey: file://{{ remi_gpg_path }}
    - require:
      - file: remi-gpg

redis:
  pkg.installed:
    - version: 3*
    - require:
      - pkgrepo: remi

  service.running:
    - enable: True
    - require:
      - pkg: redis
    - watch:
      - pkg: redis
