jenkins:
  lookup:
    user: jenkins
    group: jenkins
    pkgs:
      - java-1.8.0-openjdk

  nginx:
    lookup:
      user: nginx
      group: nginx
