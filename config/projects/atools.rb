#
# Copyright 2015 YOUR NAME
#
# All Rights Reserved.
#

name "atools"
maintainer "Adham Helal"
homepage "https://github.com/yetu/atools/"

install_dir "/opt/#{name}"

build_version Omnibus::BuildVersion.semver
build_iteration 1

# Creates required build directories
dependency "preparation"

dependency "kitchen"
dependency "python_mod"
dependency "pip"
dependency "python_readline"
dependency "requests_mod"
dependency "apphome_python"
dependency "ansible"
dependency "aeco"
dependency "atools"

# Version manifest file
dependency "version-manifest"

exclude "**/.git"
exclude "**/bundler/git"