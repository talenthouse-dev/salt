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
      - git://github.com/saltstack-formulas/salt-formula
