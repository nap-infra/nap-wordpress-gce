#!/bin/bash

DOCKER_VERSION=20.10.9
DOCKER_COMPOSE_VERSION=v2.0.1
DOCKER_COMPOSE_PATH=/usr/bin/docker-compose

# Docker
sudo yum -y install yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce-${DOCKER_VERSION} docker-ce-cli-${DOCKER_VERSION}

# Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
    -o ${DOCKER_COMPOSE_PATH}
sudo chmod +x ${DOCKER_COMPOSE_PATH}

sudo systemctl start docker
sudo systemctl enable docker
sudo chown root:docker /var/run/docker.sock

# unzip
sudo yum -y install unzip
