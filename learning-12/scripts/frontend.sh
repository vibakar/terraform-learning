#!/bin/bash

set -ex

# Update the installed packages and package cache on your instance.
yum update -y

# Install the most recent Docker Engine package.
# Amazon Linux 2
amazon-linux-extras install docker

# Start the Docker service.
service docker start

# On Amazon Linux 2, to ensure that the Docker daemon starts after each system reboot, run the following command:
systemctl enable docker

# Add the ec2-user to the docker group so you can execute Docker commands without using sudo.
usermod -a -G docker ec2-user

# Running frontend
docker run -d -p 80:4200 -e SERVER_ENDPOINT="http:\/\/${BACKEND_SERVER_ENDPOINT}" vibakar/angular-learning-project-frontend:latest
