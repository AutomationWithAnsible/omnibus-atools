#
# Copyright 2015 YOUR NAME
#
# All Rights Reserved.
#

name "atools"
maintainer "Adham Helal"
homepage "https://CHANGE-ME.com"


# Defaults to C:/atools on Windows
# and /opt/atools on all other platforms
install_dir "/opt/#{name}"

build_version Omnibus::BuildVersion.semver
build_iteration 1


# Creates required build directories
dependency "preparation"


dependency "atools"
dependency "kitchen"


# Version manifest file
dependency "version-manifest"



exclude "**/.git"
exclude "**/bundler/git"