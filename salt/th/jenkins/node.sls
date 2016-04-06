node_packages:
  pkg.installed:
    - names:
      - nodejs
      - npm

nvm_repo:
  git.latest:
    - name: https://github.com/creationix/nvm.git
    - user: jenkins
    - target: "${HOME}/.nvm"
    - fetch_tags : True
    - rev: 0.31.0
