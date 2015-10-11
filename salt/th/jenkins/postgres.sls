{% set pghome = "/var/lib/pgsql/9.4" %}
{% set pgdg94_gpg_path = "/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-94" %}
pgdg94-gpg:
  file.managed:
    - name: {{ pgdg94_gpg_path }}
    - source: salt://th/jenkins/files/{{ pgdg94_gpg_path }}

pgdg94:
  pkgrepo.managed:
    - humanname: PostgreSQL 9.4 $releasever - $basearch
    - baseurl: http://yum.postgresql.org/9.4/redhat/rhel-$releasever-$basearch
    - gpgcheck: 1
    - gpgkey: file://{{ pgdg94_gpg_path }}
    - require:
      - file: pgdg94-gpg

{# Included for completeness -- It ships disabled
pgdg94-source:
  pkgrepo.managed:
    - humanname: PostgreSQL 9.4 $releasever - $basearch - Source
    - baseurl: http://yum.postgresql.org/srpms/9.4/redhat/rhel-$releasever-$basearch
    - gpgcheck: 1
    - gpgkey: file://{{ pgdg94_gpg_path }}
#}

pg_hba:
  file.managed:
    - name: {{ pghome }}/data/pg_hba.conf
    - source: salt://th/jenkins/files/var/lib/pgsql/data/pg_hba.conf
    - user: postgres
    - group: postgres
    - require:
      - cmd: pg-initdb

old-test-packages:
  pkg.purged:
    - names:
      - postgresql
      - postgresql-libs
      - postgresql-server

psql-bin:
  alternatives.install:
    - name: psql
    - link: /usr/bin/psql
    - path: /usr/pgsql-9.4/bin/psql
    - priority: 100
    - require:
      - pkg: postgresql

postgresql:
  pkg.installed:
    - names:
      - postgresql94-server
      - postgresql94-contrib
    - require:
      - pkg: old-test-packages
  service.running:
    - enable: True
    - name: postgresql-9.4
    - require:
      - pkg: postgresql
      - cmd: pg-initdb
      - file: pg_hba
    - watch:
      - file: pg_hba

pg-initdb:
  cmd.run:
    - unless: test -d {{ pghome }}/data/base
    - name: service postgresql-9.4 initdb

jenkins-postgres:
  postgres_user.present:
    - name: jenkins
    - password: ''

    # Permissions
    - createdb: True
    - login: True
    - superuser: True
    - require:
      - alternatives: psql-bin

pg-talenthouse:
  postgres_database.present:
    - name: talenthouse_test
    - owner: jenkins
    - owner_recurse: True
    - require:
      - postgres_user: jenkins
      - alternatives: psql-bin

pg-talenthouse-artfeed:
  postgres_database.present:
    - name: talenthouse_artfeed_test
    - owner: jenkins
    - owner_recurse: True
    - require:
      - postgres_user: jenkins
      - alternatives: psql-bin

uuid-ossp:
  postgres_extension.present:
    - db_user: jenkins
    - db_host: localhost
    - maintenance_db: talenthouse_test
    - require:
      - alternatives: psql-bin

pg_stat_statements:
  postgres_extension.present:
    - db_user: jenkins
    - db_host: localhost
    - maintenance_db: talenthouse_test
    - require:
      - alternatives: psql-bin
