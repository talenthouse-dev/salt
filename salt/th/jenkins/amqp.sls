include:
  - th.jenkins.docker

rabbitmq_rabbitmq-server:
  pkgrepo.absent

rabbitmq-server:
  pkg.purged: []
  dockerng.running:
    - image: 'rabbitmq:3.4.2'
    - port_bindings:
      - 5672:5672
    - require:
      - service: docker
