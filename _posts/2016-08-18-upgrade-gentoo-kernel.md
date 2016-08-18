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
