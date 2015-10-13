{% set slugbuilder_path = "/opt/th/slugbuilder" %}

docker:
  pkg.installed:
    - names:
      - docker-io
      - python-docker-py
  service.running:
    - enable: True
    - require:
      - pkg: docker

slugbuilder:
  git.latest:
    - name: https://github.com/talenthouse-dev/slugbuilder
    - target: {{ slugbuilder_path }}
    - user: root
    # Workaround for saltstack/salt#27487
    - force_reset: True

  cmd.wait:
    - name: docker build -t th_dev/slugbuilder .
    - cwd: {{ slugbuilder_path }}
    - watch:
      - git: slugbuilder

{# Insufficient python-docker-py version
  dockerng.image_present:
    - name: th_dev/slugbuilder
    - build: {{ slugbuilder_path }}
#}
