#!/usr/bin/env bash
set -e 
echo "******** SETUP ubuntu ********"
echo "PATH=$PATH"
echo "> apt-get install curl git -y"
sudo apt-get install curl git -y
echo "> curl -sSL https://rvm.io/mpapis.asc | gpg --import -"
sudo curl -sSL https://rvm.io/mpapis.asc | gpg --import -
echo "> curl -sSL https://get.rvm.io | bash -s stable"
sudo curl -sSL https://get.rvm.io | bash -s stable

if [ -d "/opt/vagrant_ruby/" ]; then
	sudo mv /opt/vagrant_ruby/ /opt/vagrant_ruby.old
fi

PROJECT="atools"
echo "******** BUILD ubuntu ********"
echo "> WHOAMI=`whoami`"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

echo "> rvm reload"
rvm reload
echo "> rvm get head"
rvm get head
echo "> rvm install 2.2"
rvm install 2.2
rvm reset
rvm use ruby-2.2.2


