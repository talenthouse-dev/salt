include:
  - jenkins

oldjava:
  pkg.purged:
    - names:
      - java-1.6.0-openjdk
      - java-1.6.0-openjdk-devel
      - java-1.7.0-openjdk
      - java-1.7.0-openjdk-devel
    - require_in:
      - service: jenkins

sbt:
  pkgrepo.managed:
    - name: bintray--sbt-rpm
    - humanname: bintray--sbt-rpm
    - baseurl: http://dl.bintray.com/sbt/rpm
    - gpgcheck: 0

  pkg.installed:
    - required:
      - pkgrepo: sbt
