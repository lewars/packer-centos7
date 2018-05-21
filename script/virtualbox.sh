#!/bin/bash -eux

SSH_USER=${SSH_USERNAME:-vagrant}
SSH_USER_HOME=${SSH_USER_HOME:-/home/${SSH_USER}}

if [[ ! -f 'VBoxGuestAdditions.iso' ]];then
    VBOX_VERSION=$(curl -L http://download.virtualbox.org/virtualbox/LATEST.TXT)
    curl -L http://download.virtualbox.org/virtualbox/${VBOX_VERSION}/VBoxGuestAdditions_${VBOX_VERSION}.iso -o 'VBoxGuestAdditions.iso'
fi
mount -o loop $SSH_USER_HOME/VBoxGuestAdditions.iso /mnt
sh /mnt/VBoxLinuxAdditions.run --nox11
umount /mnt
rm -rf $SSH_USER_HOME/VBoxGuestAdditions.iso
