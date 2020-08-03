#!/usr/bin/env bash
######################
#guoyu.cn@outlook.com
######################
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum makecache fast
sudo yum-config-manager --disable docker-ce-nightly
sudo yum-config-manager --disable docker-ce-test
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker
sudo systemctl start docker
#dockerenv
#--insecure-registry
#--graph
#sudo systemctl daemon-reload
#sudo systemctl restart docker
#install a specific version of Docker Engine
#yum list docker-ce --showduplicates | sort -r
#sudo yum install docker-ce-<VERSION_STRING> docker-ce-cli-<VERSION_STRING> containerd.io