# Debian-Latest-Kernel-Automation
Automate the latest Kernel download from kernel.org and create Debian Packages for the installation. It only has been tested with Debian 12 Bookworm so far.
Important: some of it is copied from other sources, so this isn't my unique idea, but the combination is.


Required packages to download and build the kernel:

```
apt-get update  
apt-get upgrade  
apt-get install libncurses-dev fakeroot wget bzip2 build-essential build-essential bc python-is-python3 2to3 bison flex rsync libelf-dev libssl-dev libncurses-dev dwarves git debhelper ncurses-dev fakeroot wget bzip2
```
