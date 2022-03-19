#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

# Configure yum repo for nginx
cat <<EOF>> /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/mainline/rhel/7/x86_64/
gpgcheck=0
enabled=1
EOF

# install nginx
yum install nginx -y

# make sure nginx is started
systemctl start nginx