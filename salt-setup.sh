#!/bin/bash

if [ -f /etc/redhat-release ] && grep "release 7\." /etc/redhat-release >/dev/null; then
    target=/tmp/SALTSTACK-GPG-KEY.pub
    curl -o "$target" https://repo.saltstack.com/yum/rhel7/SALTSTACK-GPG-KEY.pub
    rpm --import "$target"
    rm -f "$target"

    cat >/etc/yum.repos.d/saltstack.repo <<!
####################
# Enable SaltStack's package repository
[saltstack-repo]
name=SaltStack repo for RHEL/CentOS 7
baseurl=https://repo.saltstack.com/yum/rhel7
enabled=1
gpgcheck=1
gpgkey=https://repo.saltstack.com/yum/rhel7/SALTSTACK-GPG-KEY.pub
!

    yum install -y epel-release vim
    yum install -y salt-master salt-minion git python-pygit2
else
    echo "Unsupported distro" >&2
    exit 1
fi
