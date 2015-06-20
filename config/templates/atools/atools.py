#!/opt/atools/embedded/bin/python
# -*- coding: utf-8 -*-

"""
atools 

Usage:
  atools update [ -p | --prerelease ] [ -f | --force ] [ -y | --yes ]
  atools check-updates [ -p | --prerelease ]
  atools -v | --version
  atools -h | --help

Options:
  -p --prerelease   Allow prereleases.
  -f --force        Force unstall the latest version.
  -y --yes          Answer yes to update.
  -h --help         Show this screen.
  -v --version      Show version.

"""

import platform
import github3
import os
from docopt import docopt


class Atools:
    def __init__(self):
        self.arguments = docopt(__doc__)
        self.current_version_file = "/opt/atools/embedded/version"
        self.download_path = "/tmp/"
        self.__get_platform()
        self.__get_my_version()
        self.repository = None
        
        self.remote_version = None
        self.remote_assets = None
        
    def __get_platform(self):
        self.platform_system = platform.system()
        self.linux_distribution = platform.linux_distribution()
        if self.platform_system == "Darwin":
            self.pkg = "pkg"
        elif self.platform_system == "Linux":
            if "Ubuntu" in self.linux_distribution:
                self.pkg = "deb"
        else:
            print "Your platform is not supporteted please do a manual update"
            exit(1)

    def __get_my_version(self):
        with open(self.current_version_file, 'r') as content_file:
            try:
                self.installed_version = content_file.read()
            except:
                print "Error while reading version file"
                exit(1)
    
    def check_release(self):
        prerelease = self.arguments.get("--prerelease")
        repository = github3.repository('yetu', 'atools')
        releases = repository.releases()
        # Get the first Release
        for release in releases:
            if release.draft == False and release.prerelease == prerelease:
                self.remote_version = release.tag_name
                if self.remote_version[0] == "v":
                    self.remote_version = self.remote_version[1:]
                self.remote_assets = release.assets(-1)

    def confirm(self, msg):
        answer = self.arguments.get("--yes")
        if answer == True:
            print "Going ahead with update"
        else:
            print(msg), 
            while True:
                n = raw_input("Do you want to proceed (yes/no): ")
                if n[0] == "y":
                    break
                elif n[0] == "n":
                    print "You choose to abort, Bye"
                    exit(1)

    def install(self):
        found_package = False
        for asset in self.remote_assets:
            if self.pkg in asset.name:
                found_package = True
                self.download_path += asset.name
                break
        
        if found_package == False:
            print "Error did not find a suitable package '%s' in this release '%s'" % self.pkg, self.remote_version
            exit(1)
        
        # Download
        print "Downloading file to '%s'" % self.download_path
        asset.download(self.download_path)
        print "Installing package"
        if self.pkg == "pkg":
            command_to_install = "sudo installer -pkg %s -target /" % self.download_path                    
        elif self.pkg == "deb":
            command_to_install = "sudo dpkg -i %s" % self.download_path
        # Install
        rc = os.system(command_to_install) 
        exit(rc)

    def check_update(self):
        print "Checking github for new releases....."
        self.check_release()
        if self.remote_version == None:
            print "No suitable version to update."
            return False
        if self.arguments.get("--force"):
            return "Your running '%s' and '%s' will be force installed." % (self.installed_version, self.remote_version)
        elif self.remote_version == self.installed_version:
            print "Your running the latest version '%s'" % self.remote_version
            return False
        else:
            return ("A new update is available version '%s'." % self.remote_version)

    def main(self):
        #print arguments
        if self.arguments.get("--version"):
            print "atools version: ", self.installed_version
        elif self.arguments.get("check-updates"):
            # Return 0 if no updates and 3 if updates are avaible
            update_msg = self.check_update()
            if update_msg:
                print update_msg
                exit(3)
            else:
                print "Your up to date."
                exit(0)
        elif self.arguments.get("update"):
            update_msg = self.check_update()
            if update_msg:
                self.confirm(update_msg)
                self.install()

if __name__ == '__main__':
  Atools().main()