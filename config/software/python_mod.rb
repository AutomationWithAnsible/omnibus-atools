name "python"
default_version "2.7.9"

dependency "gdbm"
dependency "ncurses"
dependency "zlib"
dependency "openssl"
dependency "bzip2_mod"

version("2.7.5") { source md5: "b4f01a1d0ba0b46b05c73b2ac909b1df" }
version("2.7.9") { source md5: "5eebcaa0030dc4061156d3429657fb83" }

source url: "http://python.org/ftp/python/#{version}/Python-#{version}.tgz"

relative_path "Python-#{version}"

build do
  source_lib="/usr/lib"
  source_include="/usr/inlude"
  #"LDFLAGS" => "-Wl,-rpath,#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib",

  #LDFLAGS" => "-Wl,-rpath,#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib",
  env = {
    "CFLAGS" => "-I#{install_dir}/embedded/include -O3 -g -pipe",
    "LDFLAGS" => "-Wl -L#{install_dir}/embedded/lib",
  }
  command "ln -sf #{source_lib}/libgcc_s.1.dylib /opt/atools/embedded/lib"
  #command "ln -s #{source_lib}/libpthread.dylib /opt/test1/embedded/lib"
  #command "ln -s #{source_include}/stdio.h #{install_dir}/embedded/include/"
  #command "ln -s #{source_include}/stdlib.h #{install_dir}/embedded/include/"
  #command "ln -s #{source_include}/include/sys #{install_dir}/embedded/include/"

  command "./configure" \
          " --prefix=#{install_dir}/embedded" \
          " --enable-shared" \
          " --with-dbmliborder=gdbm", env: env

  make env: env
  make "install", env: env

  # There exists no configure flag to tell Python to not compile readline
  delete "#{install_dir}/embedded/lib/python2.7/lib-dynload/readline.*"

  # Remove unused extension which is known to make healthchecks fail on CentOS 6
  delete "#{install_dir}/embedded/lib/python2.7/lib-dynload/_bsddb.*"
end