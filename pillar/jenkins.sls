jenkins:
  lookup:
    user: jenkins
    group: jenkins
    nginx_user: nginx
    nginx_group: nginx
    pkgs:
      - java-1.8.0-openjdk-devel

    privkey: /var/lib/jenkins/.ssh/id_rsa
# NOTE: localhost:8080 is OK, since this is used when running jenkins-cli on the box itself
    master_url: http://localhost:8080/
    plugins:
      installed:
        - ansicolor
        - envinject
        - git
        - github-oauth
        - nodejs
        - sbt
        - slack
        - ws-cleanup
      disabled:
        - ant
        - cvs
        - javadoc
        - maven-plugin
        - pam-auth
        - ssh-slaves
        - subversion
        - translation
        - windows-slaves
    jobs:
      installed:
        TH-Master: /srv/extra/jenkins/jobs/TH-Master.xml
        TH-Tasks: /srv/extra/jenkins/jobs/TH-Tasks.xml
        TH-Publish: /srv/extra/jenkins/jobs/TH-Publish.xml

  nginx:
    lookup:
      user: nginx
      group: nginx
