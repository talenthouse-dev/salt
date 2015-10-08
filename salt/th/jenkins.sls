sbt:
  pkgrepo.managed:
    - name: bintray--sbt-rpm
    - humanname: bintray--sbt-rpm
    - baseurl: http://dl.bintray.com/sbt/rpm
    - gpgcheck: 0

  pkg.installed:
    - required:
      - pkgrepo: sbt
