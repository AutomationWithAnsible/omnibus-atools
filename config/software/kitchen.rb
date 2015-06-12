name "kitchen"
default_version "master"
source git: "https://github.com/ahelal/kitchen-ansiblepush.git"

if windows?
  dependency "ruby-windows"
  dependency "ruby-windows-devkit"
else
  dependency "ruby"
  dependency "rubygems"
end

dependency 'nokogiri'
dependency "bundler"
#dependency 'kitchen-ansiblepush'

build do
  env = with_standard_compiler_flags(with_embedded_path)

  gem "instal test-kitchen" \
      " --no-ri --no-rdoc", env: env

  bundle "install --without development guard test", env: env
  gem "build kitchen-ansiblepush.gemspec", env: env
  gem "install kitchen-ansiblepush-*.gem" \
      " --no-ri --no-rdoc", env: env

  gem "instal kitchen-joyent" \
      " --no-ri --no-rdoc", env: env

  gem "instal kitchen-vagrant" \
      " --no-ri --no-rdoc", env: env

  command "ln -sf #{install_dir}/embedded/bin/kitchen #{install_dir}/bin"
  command "ln -sf #{install_dir}/embedded/bin/kitchen-ansible-inventory #{install_dir}/bin"
end