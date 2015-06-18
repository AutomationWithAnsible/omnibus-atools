name "atools"
default_version "master"



if windows?
  dependency "ruby-windows"
  dependency "ruby-windows-devkit"
else
  dependency "ruby"
  dependency "rubygems"
end



build do
	whichversion_path = "/usr/local/bin"
	embedded_path = "/opt/atools/embedded/bin/"
	#Deploy whichversion
	erb source: "whichversion.erb",
      dest: "#{whichversion_path}/whichversion",
      mode: 0755,
      vars: { whichversion_path: whichversion_path, embedded_path: embedded_path  }

    # aeco path
	command "ln -s #{whichversion_path}/whichversion #{whichversion_path}/aeco"
end