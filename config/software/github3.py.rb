name "github3.py"
default_version "0.9.3"

dependency "pip"

build do
  command "#{install_dir}/embedded/bin/pip install -I --build #{project_dir} #{name}==#{default_version}"
end
