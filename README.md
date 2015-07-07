atools Omnibus project
======================
This project creates full-stack platform-specific packages for
`atools` apphome tools

Installation atools
-----------------------
Check release for your platform. Then download and install :)

Packages included atools
-----------------------
- python 
- ansible
- kitchen
- aeco
- other for more info look at config/software

Kitchen-based Build Environment
-------------------------------

Currently atools will build on "ubuntu" using kitchen-vagrant. And "mac" using kitchen-localhost requires you run it from a mac
To install required development/build pakcages. You must also have ansible installed

### Prepare environment 
```shell
$ bundle install --binstubs --path vendor/bundle"
```

### Mac
```shell
$ bundle exec kitchen conv mac
```

### Ubuntu
```shell
$ bundle exec kitchen conv ubuntu
```

Then login to the instance and build the project as described in the Usage
section:

```shell
$ bundle exec kitchen login ubuntu-1204
[vagrant@ubuntu...] $ cd atools
[vagrant@ubuntu...] $ bundle install
[vagrant@ubuntu...] $ ...
[vagrant@ubuntu...] $ bin/omnibus build atools
```

For a complete list of all commands and platforms, run `kitchen list` or
`kitchen help`.
Installation for developers 
-----------------------
You must have a sane Ruby 1.9+ environment with Bundler installed. Ensure all
the required gems are installed:

```shell
$ bundle install --binstubs
```

Usage 
-----
### Build

You create a platform-specific package using the `build project` command:

```shell
$ bin/omnibus build atools
```

The platform/architecture type of the package created will match the platform
where the `build project` command is invoked. For example, running this command
on a MacBook Pro will generate a Mac OS X package. After the build completes
packages will be available in the `pkg/` folder.

### Clean

You can clean up all temporary files generated during the build process with
the `clean` command:

```shell
$ bin/omnibus clean atools
```

Adding the `--purge` purge option removes __ALL__ files generated during the
build including the project install directory (`/opt/atools`) and
the package cache directory (`/var/cache/omnibus/pkg`):

```shell
$ bin/omnibus clean atools --purge
```

### Publish

Omnibus has a built-in mechanism for releasing to a variety of "backends", such
as Amazon S3. You must set the proper credentials in your `omnibus.rb` config
file or specify them via the command line.

```shell
$ bin/omnibus publish path/to/*.deb --backend s3
```

### Help

Full help for the Omnibus command line interface can be accessed with the
`help` command:

```shell
$ bin/omnibus help
```


