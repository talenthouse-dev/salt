# If we've gotten this far, it's probably safe to get rid of the bootstrap salt configuration
bootstrap-config:
  file.absent:
    - name: /etc/salt/master
  service.running:
    - name: salt-master
    - watch:
      - file: bootstrap-config
