pg_hba:
  file.managed:
    - name: /var/lib/pgsql/data/pg_hba.conf
    - source: salt://th/jenkins/files/var/lib/pgsql/data/pg_hba.conf
    - user: postgres
    - group: postgres

test-packages:
  pkg.installed:
    - names:
      - postgresql-server
  service.running:
    - names:
      - postgresql
    - require:
      - pkg: test-packages
      - cmd: pg-initdb
      - file: pg_hba
    - watch:
      - file: pg_hba

pg-initdb:
  cmd.wait:
    - name: service postgresql initdb
    - watch:
      - pkg: test-packages

jenkins-postgres:
  postgres_user.present:
    - name: jenkins
    - password: ''

    # Permissions
    - createdb: True
    - login: True

  postgres_database.present:
    - name: talenthouse_test
    - owner: jenkins
    - owner_recurse: True
    - require:
      - postgres_user: jenkins
