source 'https://rubygems.org'

# Install omnibus software
gem 'omnibus', github: 'chef/omnibus'
gem 'omnibus-software', :git => 'git://github.com/opscode/omnibus-software.git', :branch => 'master'

group :development do
  # Use Berkshelf for resolving cookbook dependencies
  gem 'berkshelf', '~> 3.0'

  # Use Test Kitchen with Vagrant for converging the build environment
  gem "addressable"
  gem 'test-kitchen'
  gem 'kitchen-vagrant'
  gem 'kitchen-ansiblepush'
  gem 'kitchen-localhost'
end