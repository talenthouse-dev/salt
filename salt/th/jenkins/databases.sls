test-packages:
  pkg.installed:
    - names:
      - postgresql-server

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
