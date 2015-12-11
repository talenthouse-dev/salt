{%- set admin_un = 'guest' -%}
{%- set admin_pw = 'guest' -%}
include:
  - th.jenkins.docker

rabbitmq_rabbitmq-server:
  pkgrepo.absent

rabbitmq-image-present:
  cmd.run:
    - name: docker pull rabbitmq:3.4.2-management
    - unless: docker inspect rabbitmq:3.4.2-management

rabbitmq-server:
  pkg.purged: []
  dockerng.running:
    - image: 'rabbitmq:3.4.2-management'
    - port_bindings:
      - 5672:5672
      - 15672:15672
    - require:
      - service: docker

rabbitmqadmin:
  cmd.wait:
    {# rabbitmq doesn't immediately start serving connections, unfortunately.
       Wait a couple seconds even after the port is open to avoid issues.
     #}
    - name: "timeout 30 bash -c 'until nc -z localhost 15672; do sleep 1; done'; sleep 5"
    - watch:
      - dockerng: rabbitmq-server
  file.managed:
    - name: /usr/local/bin/rabbitmqadmin
    - source: http://localhost:15672/cli/rabbitmqadmin
    - source_hash: md5=cb218bbcb3f06b28e18402e9d727a34a
    - mode: 755
    - require:
      - cmd: rabbitmqadmin
      - dockerng: rabbitmq-server

devteam-account:
  cmd.wait:
    - name: "rabbitmqadmin -u {{ admin_un }} -p {{ admin_pw }} -H localhost -P 15672 declare user name=devteam password=devteam tags="
    - watch:
      - dockerng: rabbitmq-server
    - require:
      - file: rabbitmqadmin

devteam-permissions:
  cmd.wait:
    - name: "rabbitmqadmin -u {{ admin_un }} -p {{ admin_pw }} -H localhost -P 15672 declare permission vhost=/ user=devteam configure='.*' write='.*' read='.*'"
    - watch:
      - cmd: devteam-account
