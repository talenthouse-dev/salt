/etc/nginx/sites-available/jenkins.conf:
  file.managed:
    - template: jinja
    - source: salt://jenkins/files/nginx.conf
    - user: nginx
    - group: nginx
    - mode: 440
    - require:
      - pkg: jenkins

/etc/nginx/sites-enabled/jenkins.conf:
  file.symlink:
    - target: /etc/nginx/sites-available/jenkins.conf
    - user: nginx
    - group: nginx

extend:
  nginx:
    service:
      - watch:
        - file: /etc/nginx/sites-available/jenkins.conf
      - require:
        - file: /etc/nginx/sites-enabled/jenkins.conf
