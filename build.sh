#!/usr/bin/env bash
set -e 
echo "> WHOAMI=`whoami`"

echo '
#!/usr/bin/env bash
set -e 
echo "> WHOAMI=`whoami`"

PROJECT="atools"
PROJECT_USER="$USER"
PROJECT_DIR="/opt/$PROJECT"
PROJECT_CACHE_DIR="/var/cache/omnibus"

source /home/vagrant/.bashrc

echo "******** SETUP ubuntu ********"
echo "PATH=$PATH"

####WARNINING####
ssh-keyscan -t rsa github.com > ~/.ssh/known_hosts

echo "> apt-get update"
sudo apt-get update

echo "> apt-get install  git -y"
sudo apt-get install build-essential git -y


cd
if [ ! -d .rbenv ]; then 
	git clone git://github.com/sstephenson/rbenv.git .rbenv
	echo "export PATH=\"$HOME/.rbenv/bin:\$PATH\"" >> ~/.bashrc
	export PATH="\$HOME/.rbenv/bin:$PATH"
	echo "eval \"\$(rbenv init -)\"" >> ~/.bashrc
fi

if [ ! -d ~/.rbenv/plugins/ruby-build ]; then 
	git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
	echo "export PATH=\"\$HOME/.rbenv/plugins/ruby-build/bin:\$PATH\"" >> ~/.bashrc
fi

if [ ! -d ~/.rbenv/plugins/rbenv-gem-rehash ]; then
	git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
if [ ! -d .rbenv ]; then 
	rbenv install 2.2.2
	rbenv global 2.2.2
fi
ruby -v


echo "> PATH=$PATH"
SUDO=""

if [ $(basename `pwd`) != "omnibus-$PROJECT" ]; then
	echo "> cd omnibus-$PROJECT"
	cd omnibus-$PROJECT
fi

echo "> $SUDO gem install bundle --no-rdoc --no-ri"
$SUDO gem install bundle --no-rdoc --no-ri
echo "> $SUDO bundle install --binstubs"
$SUDO bundle install --binstubs

echo "Create prvoject dir in $PROJECT_DIR and cache dir in $PROJECT_CACHE_DIR"
sudo mkdir -p $PROJECT_DIR
sudo mkdir -p $PROJECT_CACHE_DIR
sudo chown $PROJECT_USER $PROJECT_CACHE_DIR
sudo chown $PROJECT_USER $PROJECT_DIR
echo "> omnibus build $PROJECT"
$SUDO  /home/vagrant/omnibus-atools/bin/omnibus build $PROJECT 
' > /tmp/buid.sh
chmod +x /tmp/buid.sh
su - vagrant -c /tmp/buid.sh