name "requests"
default_version "2.6.0"

dependency "pip"

build do
  build_env = {
      "PATH" => "/#{install_dir}/embedded/bin:#{ENV['PATH']}",
      "LDFLAGS" => "-L/#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
      "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include/"
  }
  command "#{install_dir}/embedded/bin/pip install -I --build #{project_dir} --install-option=\"--install-scripts=#{install_dir}/bin\" #{name}==#{default_version}", :env => build_env
end
