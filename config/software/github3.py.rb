name "github3.py"
default_version "1.0.0a1"

dependency "pip"

build do
  build_env = {
      "PATH" => "/#{install_dir}/embedded/bin:#{ENV['PATH']}",
      "LDFLAGS" => "-L/#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
      "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include/"
  }
  command "#{install_dir}/embedded/bin/pip install -I --build #{project_dir} #{name}==#{default_version}", :env => build_env
end
