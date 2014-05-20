#!/bin/bash

# Epel repo for pwgen
/bin/cat << EOF > /etc/yum.repos.d/epel.repo
[epel]
name=Extra Packages for Enterprise Linux 6 - \$basearch
#baseurl=http://download.fedoraproject.org/pub/epel/6/\$basearch
mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=\$basearch
failovermethod=priority
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
EOF

yum install -y --nogpgcheck sudo openssh-server pwgen

USER='clouduser'
GROUP="$USER"
HOME="/home/$USER"

useradd -m -s /bin/bash $USER
echo "$USER:$(pwgen -c -n -1 12)" | chpasswd

echo "$USER ALL=NOPASSWD: ALL" >> /etc/sudoers

mkdir $HOME/.ssh
chmod 700 $HOME{/,/.ssh}
touch $HOME/.ssh/authorized_keys
chown -R $USER.$GROUP $HOME

SSHCONF='/etc/ssh/sshd_config'
PAMCONF='/etc/pam.d/sshd'

ssh-keygen -q -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''

# NO PASSWORDS!
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' $SSHCONF

# Kerberos-related errors, but we're not using kerb
sed -i 's/GSSAPIAuthentication yes/#GSSAPIAuthentication yes/' $SSHCONF
sed -i 's/GSSAPICleanupCredentials yes/#GSSAPICleanupCredentials yes/' $SSHCONF

# Required changed to optional - Docker drops autid capabilities
sed -i 's/session    required     pam_loginuid.so/session    optional     pam_loginuid.so/' $PAMCONF

