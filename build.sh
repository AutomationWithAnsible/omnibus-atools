#!/usr/bin/env bash
set -e 
PROJECT="atools"
PROJECT_USER="helal"
PROJECT_DIR="/opt/$PROJECT"
PROJECT_CACHE_DIR="/var/cache/omnibus"

if [ $(basename `pwd`) != "omnibus-$PROJECT" ]; then
	echo "> cd omnibus-$PROJECT"
	cd omnibus-$PROJECT
fi

#echo "> gem install bundle"
sudo gem install bundle --no-rdoc --no-ri
echo "> bundle install --binstubs"
sudo bundle install --binstubs

old_hash="d7f7dd7e3ede3e323fc0e09381f16caf"
new_hash="380df856e8f789c1af97d0da9a243769"
echo ">  find . -name cacerts*  -type f  -exec sed -i -e 's/d7f7dd7e3ede3e323fc0e09381f16caf/380df856e8f789c1af97d0da9a243769/g' {} \;"
#find / -name cacert*  -type f  -exec sed -i -e 's/d7f7dd7e3ede3e323fc0e09381f16caf/380df856e8f789c1af97d0da9a243769/g' {} \;

echo "Create prvoject dir in $PROJECT_DIR and cache dir in $PROJECT_CACHE_DIR"
sudo mkdir -p $PROJECT_DIR
sudo mkdir -p $PROJECT_CACHE_DIR
sudo chown $PROJECT_USER $PROJECT_CACHE_DIR
sudo chown $PROJECT_USER $PROJECT_DIR
echo "> omnibus build $PROJECT"
sudo omnibus build $PROJECT 