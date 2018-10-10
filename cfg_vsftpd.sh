#!/bin/bash
#
# root saves time && assume on Ubuntu server
#
# Refer to https://www.digitalocean.com/community/tutorials/how-to-set-up-vsftpd-for-a-user-s-directory-on-ubuntu-16-04

set -euo pipefail

# Install vsftpd
apt update && apt install vsftpd

# Prepare account and directory to put files
[[ $(id netalgo > /dev/null 2>&1; echo $?) -gt 0 ]] && useradd --create-home --password meiy0umima
mkdir -p /home/netalgo/ftp
chown nobody:nogroup /home/netalgo/ftp
chmod a-w /home/netalgo/ftp

# HW1 will be write-only
mkdir -p /home/netalgo/ftp/HW1
chown netalgo:netalgo /home/netalgo/ftp/HW1

# In vsftpd.conf, I use FTP's PASV mode that should map some ports on server's
# gateway: 20-21, 60000-65535.
mv /etc/vsftpd.conf{,.bak} && cp vsftpd.conf /etc/
cp -f vsftpd.user_list /etc/
systemctl restart vsftpd

# If success, we can use `ftp://netalgo@222.195.92.204 -p meiy0umima` to access FTP.

exit 0
