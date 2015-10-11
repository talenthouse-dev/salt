rabbitmq-server:
  pkg.installed: []
  service.running:
    - enable: True
    - require:
      - pkg: rabbitmq-server
    - watch:
      - pkg: rabbitmq-server
