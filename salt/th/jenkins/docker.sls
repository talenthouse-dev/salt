{% set slugbuilder_path = "/opt/th/slugbuilder" %}

deprecated-deps:
  pkg.purged:
    - name: python-docker-py

docker:
  pkg.installed:
    - names:
      - docker-io
      - python-pip
    - reload_modules: True
  pip.installed:
    - name: docker-py == 1.4.0
    - require:
      - pkg: docker
    - reload_modules: True
  service.running:
    - enable: True
    - require:
      - pkg: docker

slugbuilder:
  file.absent:
    - name: {{ slugbuilder_path }}

slugbuilder-cache:
  file.absent:
    - name: /opt/th-public-cache
