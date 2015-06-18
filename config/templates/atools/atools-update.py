#!/opt/atools/embedded/bin/python
# -*- coding: utf-8 -*-

"""
atools 

Usage:
  atools update
  atools -v | --version
  atools -h | --help
Options:
  -h --help     Show this screen.
  -v --version  Show version.
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

def get_releases():
    try: 
        return requests.get(repo_url)
    except:
        print "error"


def main():
    arguments = docopt(__doc__)
    if arguments.get("--version"):
        print "atools version: ", get_my_version()
    elif arguments.get("update"):
        current_version = get_my_version()
        releases = get_releases().json()
        for release in releases:
            print "Checking github for new releases....."
            print "Release = ", release.get("tag_name")
            if release.get("prerelease",False):
                "This is a prerelease is that ok?"
            else:
                print "Upditing"

if __name__ == '__main__':
  main()