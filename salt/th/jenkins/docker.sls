docker:
  pkg.installed:
    - names:
      - docker-io
      - python-docker-py
  service.running:
    - require:
      - pkg: docker
