name "atools"
default_version "0.2.4"

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
  version_file = "#{embedded_bin_path}/whichversion"
  #Deploy whichversion
  erb source: "whichversion.erb",
      dest: "#{version_file}",
      mode: 0755,
      vars: { whichversion_path: whichversion_path, 
              embedded_bin_path: embedded_bin_path,
              version_file: version_file,
            }

  erb source: "atools_version.erb",
      dest: "#{embedded_path}/version",
      mode: 0755,
      vars: { default_version: default_version }

  erb source: "atools.py",
      dest: "#{embedded_bin_path}/atools",
      mode: 0755,
      vars: { whichversion_path: whichversion_path, 
              embedded_bin_path: embedded_bin_path,
              version_file: version_file,
            }

end