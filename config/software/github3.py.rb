name "github3.py"
default_version "0.9.3"

dependency "pip"

build do
  command "#{install_dir}/embedded/bin/pip install -I --build #{project_dir} --install-option=\"--install-scripts=#{install_dir}/bin\" #{name}==#{default_version}"
end
