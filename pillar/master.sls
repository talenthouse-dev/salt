salt:
  master:
    fileserver_backend:
      - roots
      - git

    file_roots:
      base:
        - /srv/salt

    pillar_roots:
      base:
        - /srv/pillar

    gitfs_provider: pygit2

    gitfs_remotes:
      - git://github.com/saltstack-formulas/jenkins-formula
      - git://github.com/saltstack-formulas/nginx-formula
      - git://github.com/saltstack-formulas/salt-formula:
        - base: a33937d9e85b577ac1e944a25ef9fe6fae770a47
      - git://github.com/saltstack-formulas/sudoers-formula
