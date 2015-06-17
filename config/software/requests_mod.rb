name "requests"
version "1.2.3"

dependency "pip"
requests_version="1.2.3"

build do
  command "echo version=====#{requests_version} version=='#{version}'."
  command "#{install_dir}/embedded/bin/pip install -I --build #{project_dir} --install-option=\"--install-scripts=#{install_dir}/bin\" #{name}==#{requests_version}"
end
