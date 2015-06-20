name "apphome_python"

build do
	build_env = {
      "PATH" => "/#{install_dir}/embedded/bin:#{ENV['PATH']}",
      "LDFLAGS" => "-L/#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
      "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include/"
    }
    mkdir "#{install_dir}/embedded/apphome_python"
    erb source: "requirements.txt.erb",
      dest: "#{install_dir}/embedded/apphome_python/requirements.txt",
      mode: 0755,
      vars: { install_dir: install_dir }

    command "#{install_dir}/embedded/bin/pip install -r #{install_dir}/embedded/apphome_python/requirements.txt", :env => build_env
end
