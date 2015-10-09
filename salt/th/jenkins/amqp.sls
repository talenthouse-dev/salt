rabbitmq-server:
  pkg.installed: []
  service.running:
    - require:
      - pkg: rabbitmq-server
    - watch:
      - pkg: rabbitmq-server
