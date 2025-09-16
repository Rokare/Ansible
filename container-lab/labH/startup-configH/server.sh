#!/bin/sh

echo "root:root" | chpasswd
apk add openrc
rc-status
touch /run/openrc/softlevel
apk add openssh
echo 'PermitRootLogin yes' >> etc/ssh/sshd_config
rc-update add sshd
rc-service sshd start

apk add rsyslog
rc-update add rsyslog
rc-service rsyslog start
## tail -f /var/log/messages

apk add --no-cache python3 py3-pip
apk add networkmanager
apk add networkmanager-cli
rc-service networkmanager start
rc-update add networkmanager default
adduser root plugdev


apk add alpine-conf
mount -t devtmpfs none /dev
setup-devd udev

rc-update add udev sysinit
rc-update add udev-trigger sysinit
rc-update add udev-settle sysinit
rc-update add udev-postmount default

# rc-service udev start
# rc-service udev-trigger start
# rc-service udev-settle start
# rc-service udev-postmount start
rc-service udev restart
rc-service networkmanager restart
mount -t devpts devpts /dev/pts