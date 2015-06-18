#!/opt/atools/embedded/bin/python
# -*- coding: utf-8 -*-

"""
atools 

Usage:
  atools update [ -p | --prerelease ] [ -f | --force ] [ -y | --yes ]
  atools -v | --version
  atools -h | --help

Options:
  -p --prerelease   Allow prereleases.
  -f --force        Force unstall the latest version.
  -y --yes          Answer yes to update.
  -h --help         Show this screen.
  -v --version      Show version.

"""


import requests
import json
from docopt import docopt

repo_url = "https://api.github.com/repos/yetu/atools/releases"
current_version_file = "/opt/atools/embedded/version"

def get_my_version():
    with open(current_version_file, 'r') as content_file:
        try:
            content = content_file.read()
        except:
            print "Error while reading version file"
            exit(1)
    return content

def check_release(prerelease=False):
    try: 
        r = requests.get(repo_url)
        # Get the first Release
        releases = r.json()
        for release in releases:
            if release.get("draft") == False and release.get("prerelease") == prerelease:
                version = release.get("tag_name")
                if version[0] == "v":
                    version = version[1:]
                assets_url = release.get("assets_url")
                return version, assets_url
        return False, False
    except:
        print "error"
        exit(1)

def get_release():
    pass

def confirm(msg="", answer=False):
    print(msg), 
    if answer == True:
        pass
    else:
        while True:
            n = raw_input("Do you want to proceed (yes/no): ")
            if n[0] == "y":
                break
            elif n[0] == "n":
                print "You choose to abort, Bye"
                exit(1)
    return True

def main():
    arguments = docopt(__doc__)
    #print arguments
    if arguments.get("--version"):
        print "atools version: ", get_my_version()
    elif arguments.get("update"):
        installed_version = get_my_version()
        print "Checking github for new releases....."
        version, assets_url = check_release(arguments.get("--prerelease"))
        if arguments.get("--force"):
            if version == False:
                print "No suitable version to force."
                exit(1)
            confirm("Your running '%s' and '%s' will be force installed." % (installed_version, version), arguments.get("--yes"))
        elif version == installed_version:
            print "Your running the latest version '%s'" % version
            exit(0)
        else:
            confirm("A new update is available version '%s'." % version, arguments.get("--yes"))

if __name__ == '__main__':
  main()