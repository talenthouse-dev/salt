{% set es17_gpg_path = "/etc/pki/rpm-gpg/RPM-GPG-KEY-ES-17" %}

es17-gpg:
  file.managed:
    - name: {{ es17_gpg_path }}
    - source: salt://th/jenkins/files/{{ es17_gpg_path }}

elasticsearch:
  pkgrepo.managed:
    - humanname: Elasticsearch repository for 1.7.x packages
    - baseurl: http://packages.elastic.co/elasticsearch/1.7/centos
    - gpgcheck: 1
    - gpgkey: file://{{ es17_gpg_path }}
    - require:
      - file: es17-gpg

  pkg.installed:
    - require:
      - pkgrepo: elasticsearch

  cmd.wait:
    - name: chkconfig --add elasticsearch
    - require:
      - pkg: elasticsearch

  service.running:
    - require:
      - cmd: elasticsearch
