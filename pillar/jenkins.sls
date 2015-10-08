jenkins:
  lookup:
    user: jenkins
    group: jenkins
    pkgs:
      - java-1.8.0-openjdk

# NOTE: localhost:8080 is OK, since this is used when running jenkins-cli on the box itself
    master_url: http://localhost:8080/

  nginx:
    lookup:
      user: nginx
      group: nginx
