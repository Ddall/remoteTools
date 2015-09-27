#!/bin/bash

GIT_BRANCH="master"
GIT_REPO="https://github.com/Ddall/remoteTools.git"
GIT_EMAIL="root@localhost"
GIT_USERNAME="rootKeeper"
LOCAL_PREFIX="rt"

apt-get install ssh git wget build-essential ruby-dev -y
gem install librarian-puppet

sudo ssh-keygen -t rsa -b 2048 -N "" -f ~/.ssh/id_rsa
passwd -l root

#@docs:https://docs.puppetlabs.com/guides/install_puppet/install_debian_ubuntu.html
cd /root
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
sudo dpkg -i puppetlabs-release-trusty.deb
sudo apt-get update
sudo apt-get install puppet -y

cd /etc/puppet
git init

git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_USERNAME"

ssh -oStrictHostKeyChecking=no github.com
git remote add origin "$GIT_REPO"
git fetch
git reset --hard origin/"$GIT_BRANCH"
git branch --set-upstream-to=origin/"$GIT_BRANCH" "$GIT_BRANCH"

librarian-puppet install
bash /etc/puppet/environments/main/modules/"$LOCAL_PREFIX"_/files/"$LOCAL_PREFIX"-puppet-apply.sh