name "atools"
default_version "0.2.3"

if windows?
  dependency "ruby-windows"
  dependency "ruby-windows-devkit"
else
  dependency "ruby"
  dependency "rubygems"
end

build do
  whichversion_path = "/usr/local/bin"
  embedded_path = "/opt/atools/embedded/"
  embedded_bin_path = "#{embedded_path}/bin/"
  
  #Deploy whichversion
  erb source: "whichversion.erb",
      dest: "#{embedded_bin_path}/whichversion",
      mode: 0755,
      vars: { whichversion_path: whichversion_path, embedded_bin_path: embedded_bin_path  }

  erb source: "atools_version.erb",
      dest: "#{embedded_path}/version",
      mode: 0755,
      vars: { default_version: default_version }
end