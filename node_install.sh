#!/bin/bash -i
yum update -y
sed -i -e s/enforcing/disabled/g /etc/sysconfig/selinux
sed -i -e s/permissive/disabled/g /etc/sysconfig/selinux
setenforce 0
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
systemctl stop firewalld
systemctl disable firewalld
modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
yum -y install ntp epel-release
systemctl start ntpd
systemctl enable ntpd
ntpdate -u -s 10.0.0.24 10.0.0.224
systemctl restart ntpd
yum install ansible -y
yum install centos-release-scl -y
yum install rh-python36 -y
easy_install pip
/opt/rh/rh-python36/root/usr/bin/pip3 install jinja2 --upgrade
echo 'source /opt/rh/rh-python36/enable' >> ~/.bashrc
exec bash