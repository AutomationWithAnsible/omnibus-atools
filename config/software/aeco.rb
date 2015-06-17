name "aeco"
default_version "master"
relative_path "aeco"

source :git => "git@github.com:yetu/aeco.git"

build do
  command "#{install_dir}/embedded/bin/python setup.py install
end
