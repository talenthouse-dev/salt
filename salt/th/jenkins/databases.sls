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
      - postgresql-server

test-packages:
  pkg.installed:
    - names:
      - postgresql94-server
    - require:
      - pkg: old-test-packages
  service.running:
    - names:
      - postgresql-9.4
    - require:
      - pkg: test-packages
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

  postgres_database.present:
    - name: talenthouse_test
    - owner: jenkins
    - owner_recurse: True
    - require:
      - postgres_user: jenkins
