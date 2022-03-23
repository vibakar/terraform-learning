#!/bin/bash

set -ex 

# Running frontend
docker run -d -p 4200:4200 vibakar/angular-learning-project-frontend

# Running backend
docker run -d -p 3000:3000 vibakar/angular-learning-project-backend