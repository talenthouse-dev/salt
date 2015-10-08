{% set sbt_version = "0.13.9" %}

include:
  - jenkins
  - th.jenkins.amqp
  - th.jenkins.elasticsearch
  - th.jenkins.postgres
  - th.jenkins.redis

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
  archive.extracted:
    - name: /var/lib/jenkins/.bin
    - source: https://dl.bintray.com/sbt/native-packages/sbt/{{ sbt_version }}/sbt-{{ sbt_version }}.tgz
    - source_hash: https://dl.bintray.com/sbt/native-packages/sbt/{{ sbt_version }}/sbt-{{ sbt_version }}.tgz.md5
    - archive_format: tar
    - tar_options: z
    - user: jenkins
    - group: jenkins

th-jenkins:
  git.latest:
    - name: git@github.com:talenthouse-dev/th-jenkins.git
    - target: /srv/extra/jenkins
    - user: root
    - identity: /var/lib/jenkins/.ssh/id_rsa
    # Workaround for saltstack/salt#27487
    - force_reset: True
