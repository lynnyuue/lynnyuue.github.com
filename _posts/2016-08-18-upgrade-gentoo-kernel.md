---
layout: post
title: "upgrade gentoo kernel"
description: "Gentoo Kernel/Upgrade"
category: linux 
tags: [linux,gentoo,kernel]
---
{% include JB/setup %}

### make a backup of the current kernel configuration

It is wise to make a backup of the kernel configuration so that the previous
configurations are not lost. After all, many users devote considerable time to
figure out the best configuration for the system, and losing that information
is definitely not wanted.

It is easy to make a backup of the current kernel configuration:

    root #cd /usr/src/linux
    root #cp .config ~/kernel-config-`uname -r`

Provided that the symlink to the kernel sources has been set correctly, this
copies the configuration of the currently used kernel to the home directory of
root, renaming the configuration to kernel-config- followed by the version of
the current running Linux kernel.

### Set symlink to new kernel sources

The symlink /usr/src/linux should always point to the directory that holds the
sources of the kernel which currently runs. This can be done in one of three
ways:

>Installing the kernel sources with USE="symlink"
Setting the link with eselect
Manually updating the symbolic link
Installing the kernel sources with the symlink USE flag
This will make the /usr/src/linux point to the newly installed kernel sources.

If necessary, it can still be modified later with one of the other two methods.

Setting the link with eselect
To set the symlink with eselect:

    root #eselect kernel list
    Available kernel symlink targets:
     [1] linux-3.14.14-gentoo *
     [2] linux-3.16.3-gentoo

  This outputs the available kernel sources. The asterisk indicates the chosen
  sources.

  To change the kernel sources, e.g. to the second entry, do:

    root #eselect kernel set 2
    Manually updating the symbolic link
    To set the symbolic link manually:

    root #ln -sf /usr/src/linux-3.16.3 /usr/src/linux
    root #ls -l /usr/src/linux
    lrwxrwxrwx 1 root root 19 Oct  4 10:21 /usr/src/linux -> linux-3.16.3-gentoo
    
### Copy previous kernel configuration
    The configuration of the old kernel needs to be copied to the new one. It can be found in several places:

  * In the procfs filesystem, if the kernel option Enable access to .config
  through /proc/config.gz was activated in the present kernel:


        root #zcat /proc/config.gz > /usr/src/linux/.config


  * In the /boot directory, if the configuration was installed there:


        root #cp /boot/config-3.14.14-gentoo /usr/src/linux/.config

  * In the kernel directory of the currently-running kernel:


        root #cp /usr/src/linux-3.14.14-gentoo/.config /usr/src/linux/

  * In the /etc/kernels/ directory, if SAVE_CONFIG="yes" is set in
  /etc/genkernel.conf and genkernel was previously used:
    

        root #cp /etc/kernels/kernel-config-x86_64-3.14.14-gentoo
  /usr/src/linux/.config
    
### Configure the new kernel
  To use the configuration of the old kernel with the new kernel, it needs to
  be converted. The conversion can be done by running either make
  silentoldconfig or make olddefconfig. Use either, not both.

####  make silentoldconfig
  The following configuration is like the text based configuration with make
  config. For new configuration options, the user is asked for a decision. For
  example:

    root #cd /usr/src/linux
    root #make silentoldconfig
    Anticipatory I/O scheduler (IOSCHED_AS) [Y/n/m/?] (NEW)

  The string (NEW) at the end of the line marks this option as new. Left to the
  string in square brackets are the possible answers: Yes, no, module or ? to
  show the help. The recommend (i.e. default) answer is capitalized (here Y).
  The help explains the option or driver.

  Unfortunately make silentoldconfig doesn't show - next to the help - a lot
  more information for each option, like the context, so that it is sometimes
  difficult to give the right answer. In this case the best way to go is to
  remember the option name and revise it afterwards through one of the
  graphical kernel configuration tools.

#### make olddefconfig
  If all new configuration options should be set to their recommended (i.e.
  default) values use make olddefconfig:

    root #cd /usr/src/linux
    root #make olddefconfig

### Compiling and installing
With the configuration now done, it is time to compile and install the kernel.
Exit the configuration and start the compilation process:

    root #make && make modules_install

 >Note
 >It is possible to enable parallel builds using make -jX with X being an
 integer number of parallel tasks that the build process is allowed to launch.
 This is similar to the instructions about /etc/portage/make.conf earlier, with
 the MAKEOPTS variable.

 When the kernel has finished compiling, copy the kernel image to /boot/. This
 is handled by the make install command:

    root #make install

 This will copy the kernel image into /boot/ together with the System.map file
 and the kernel configuration file.

### Generate the GRUB2 configuration

    root # grub-mkconfig -o /boot/grub/grub.cfg

### Optional: Building an initramfs

In certain cases it is necessary to build an initramfs - an initial ram-based
file system. The most common reason is when important file system locations
(like /usr/ or /var/) are on separate partitions. With an initramfs, these
partitions can be mounted using the tools available inside the initramfs.

Without an initramfs, there is a huge risk that the system will not boot up
properly as the tools that are responsible for mounting the file systems need
information that resides on those file systems. An initramfs will pull in the
necessary files into an archive which is used right after the kernel boots, but
before the control is handed over to the init tool. Scripts on the initramfs
will then make sure that the partitions are properly mounted before the system
continues booting.

To install an initramfs, install sys-kernel/genkernel first, then have it
generate an initramfs:

    root #emerge --ask sys-kernel/genkernel
    root #genkernel --install initramfs

In order to enable specific support in the initramfs, such as lvm or raid, add
in the appropriate options to genkernel. See genkernel --help for more
information. In the next example we enables support for LVM and software raid
(mdadm):

    root #genkernel --lvm --mdadm --install initramfs

The initramfs will be stored in /boot/. The resulting file can be found by
simply listing the files starting with initramfs:

    root #ls /boot/initramfs*

### Alternative: Using genkernel

If a manual configuration looks too daunting, then using genkernel is
recommended. It will configure and build the kernel automatically.

genkernel works by configuring a kernel nearly identically to the way the
installation CD kernel is configured. This means that when genkernel is used to
build the kernel, the system will generally detect all hardware at boot-time,
just like the installation CD does. Because genkernel doesn't require any
manual kernel configuration, it is an ideal solution for those users who may
not be comfortable compiling their own kernels.

Now, let's see how to use genkernel. First, emerge the sys-kernel/genkernel
ebuild:

    root #emerge --ask sys-kernel/genkernel

Next, edit the /etc/fstab file so that the line containing /boot/ as second
field has the first field pointing to the right device. If the partitioning
example from the handbook is followed, then this device is most likely
/dev/sda2 with the ext2 file system. This would make the entry in the file look
like so:

    root #nano -w /etc/fstab

>FILE /etc/fstab Configuring the /boot mountpoint
>/dev/sda2   /boot   ext2    defaults    0 2

Note
Further in the Gentoo installation, /etc/fstab will be configured again. The
/boot setting is needed right now as the genkernel application reads in this
configuration.

Now, compile the kernel sources by running genkernel all. Be aware though, as
genkernel compiles a kernel that supports almost all hardware, this compilation
will take quite a while to finish!

Note
If the boot partition doesn't use ext2 or ext3 as filesystem it might be
necessary to manually configure the kernel using genkernel --menuconfig all and
add support for this particular filesystem in the kernel (i.e. not as a
module). Users of LVM2 will probably want to add --lvm as an argument as well.

    root #genkernel all

Once genkernel completes, a kernel, full set of modules and initial ram disk
(initramfs) will be created. We will use the kernel and initrd when configuring
a boot loader later in this document. Write down the names of the kernel and
initrd as this information is used when the boot loader configuration file is
edited. The initrd will be started immediately after booting to perform
hardware autodetection (just like on the installation CD) before the "real"
system starts up.

    root #ls /boot/kernel* /boot/initramfs*
