rabbitmq_rabbitmq-server:
  pkgrepo.managed:
    - humanname: packagecloud RabbitMQ
    - baseurl: https://packagecloud.io/rabbitmq/rabbitmq-server/el/6/$basearch
    - enabled: 1
    - gpgcheck: 0
    - gpgkey: https://packagecloud.io/gpg.key
    - repo_gpgcheck: 1
    - sslcacert: /etc/pki/tls/certs/ca-bundle.crt
    - sslverify: 1

rabbitmq-server:
  pkg.installed: []
  service.running:
    - enable: True
    - require:
      - pkg: rabbitmq-server
    - watch:
      - pkg: rabbitmq-server
