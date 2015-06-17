name "ansible"
version "1.9.1"

dependency "python"
dependency "pip"

relative_path "ansible-#{version}"

build do
  new_version="1.9.1"
  build_env = {
      "PATH" => "/#{install_dir}/embedded/bin:#{ENV['PATH']}",
      "LDFLAGS" => "-L/#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
      "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include/"
  }
  command "#{install_dir}/embedded/bin/pip install -I --build #{project_dir} ansible==#{new_version}", :env => build_env
end
