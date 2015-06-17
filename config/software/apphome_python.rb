name "apphome_python"


build do
	mkdir "#{install_dir}/embedded/apphome_python"
	erb source: "requirements.txt.erb",
      dest: "#{install_dir}/embedded/apphome_python/requirements.txt",
      mode: 0755,
      vars: { install_dir: install_dir }
	command "#{install_dir}/embedded/bin/pip install -r #{install_dir}/embedded/apphome_python/requirements.txt"
end
