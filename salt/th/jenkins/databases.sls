test-packages:
  pkg.installed:
    - names:
      - postgresql-server
  service.running:
    - names:
      - postgresql
    - require:
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
