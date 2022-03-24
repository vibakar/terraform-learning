#!/bin/bash

set -ex 

# Running backend
docker run -d -p 3000:3000 vibakar/angular-learning-project-backend:latest

# Running frontend
PUBLIC_IP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
docker run -d -p 80:4200 -e SERVER_ENDPOINT="http:\/\/$PUBLIC_IP:3000" vibakar/angular-learning-project-frontend:latest
