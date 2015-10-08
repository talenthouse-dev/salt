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
      - git://github.com/blast-hardcheese/jenkins-formula:
        - base: merged
      - git://github.com/saltstack-formulas/nginx-formula
      - git://github.com/blast-hardcheese/salt-formula:
        - base: bugfix/178_master-configs-in-minion
