#!/bin/bash
# Automated script to download the latest kernel and compile it for Debian 12 (bookworm)
# Copied several of the lines from other sources on the internet to get it working
# roland huber, 2024-08

KERNELDIR="$HOME/kernel"
CURRENT=$(uname -r)
wget=$(wget --output-document - --quiet https://www.kernel.org/ | grep -A 1 "latest_link")
wget=${wget##*.tar.xz\">}
version=${wget%</a>}
kconfig="https://salsa.debian.org/kernel-team/linux/-/blob/master/debian/config/config"

echo "Your Kernel version  : $CURRENT"
echo "Latest Kernel version: $version"
echo "Kernel Downloading to: $KERNELDIR"
echo "Kernel Config from:    $kconfig"
echo "Want to continue with downloading the latest stable Kernel (y/N) "
read -r -p "Continue? [y/N] " response
response=${response,,}    # tolower
if [[ "$response" =~ ^(yes|y)$ ]]
then
	mkdir -p $KERNELDIR
	cd $KERNELDIR
	wget=$(wget --output-document - --quiet https://www.kernel.org/ | grep -A 1 "latest_link")
	wget=${wget##*<a href=\"}
	wget=${wget%\">*}
	echo "Link for Download    : $wget"

	mkdir -p $KERNELDIR
	cd $KERNELDIR
	wget $wget
	rm -rf linux-$version
	tar xvfJ linux-$version.tar.xz
	rm linux-$version.tar.xz
	cd $KERNELDIR/linux-$version
	wget $kconfig
	mv $KERNELDIR/linux-$version/config $KERNELDIR/linux-$version/.config
	make olddefconfig 

	make bindeb-pkg -j `nproc` LOCALVERSION=-debian 

	echo "New Kernel Ready to be installed from:  $KERNELDIR"
	echo "Common example command to install:"
	echo "sudo dpkg -i $KERNELDIR/linux-image-$version-debian_$version-1_amd64.deb $KERNELDIR/linux-headers-$version-debian_$version-1_amd64.deb"
else
	exit 0
fi
