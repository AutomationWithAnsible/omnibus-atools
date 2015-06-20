#!/usr/bin/env bash
set -e 
su vagrant -c '
PROJECT="atools"
PROJECT_USER="$USER"
PROJECT_DIR="/opt/$PROJECT"
PROJECT_CACHE_DIR="/var/cache/omnibus"
echo "******** SETUP ubuntu ********"
echo "PATH=$PATH"

####WARNINING####
ssh-keyscan -t rsa github.com > ~/.ssh/known_hosts

echo "> apt-get update"
sudo apt-get update

echo "> apt-get install ruby git -y"
sudo apt-get install ruby ruby-dev build-essential git -y

PROJECT="atools"
echo "******** BUILD ubuntu ********"
echo "> WHOAMI=`whoami`"


echo "> PATH=$PATH"
SUDO="sudo"

if [ $(basename `pwd`) != "omnibus-$PROJECT" ]; then
	echo "> cd omnibus-$PROJECT"
	cd omnibus-$PROJECT
fi

echo "> $SUDO gem install bundle --no-rdoc --no-ri"
$SUDO gem install bundle --no-rdoc --no-ri
echo "> $SUDO bundle install --binstubs"
$SUDO bundle install --binstubs

old_hash="d7f7dd7e3ede3e323fc0e09381f16caf"
new_hash="380df856e8f789c1af97d0da9a243769"

#TODO: FIX FOR MAC AND LINUX
#echo ">  find / -name cacerts*.pem  -type f  -exec sed -i -e 's/d7f7dd7e3ede3e323fc0e09381f16caf/380df856e8f789c1af97d0da9a243769/g' {} \;"
#sudo find / -name cacert.pem -type f  -exec sed -i -e 's/d7f7dd7e3ede3e323fc0e09381f16caf/380df856e8f789c1af97d0da9a243769/g' {} \;
#sed -i.bak  -e 's/d7f7dd7e3ede3e323fc0e09381f16caf/380df856e8f789c1af97d0da9a243769/g' /var/cache/omnibus/cache/cacert.pem

echo "Create prvoject dir in $PROJECT_DIR and cache dir in $PROJECT_CACHE_DIR"
sudo mkdir -p $PROJECT_DIR
sudo mkdir -p $PROJECT_CACHE_DIR
sudo chown $PROJECT_USER $PROJECT_CACHE_DIR
sudo chown $PROJECT_USER $PROJECT_DIR
echo "> omnibus build $PROJECT"
$SUDO  /home/vagrant/omnibus-atools/bin/omnibus build $PROJECT 
'