#!/usr/bin/env bash

export GITLAB_HOME=/srv/gitlab
sudo docker run --detach \
  --hostname gitlab.example.com \
  --publish 443:443 --publish 80:80 --publish 22:22 \
  --name gitlab \
  --restart always \
  --volume $GITLAB_HOME/config:/etc/gitlab \
  --volume $GITLAB_HOME/logs:/var/log/gitlab \
  --volume $GITLAB_HOME/data:/var/opt/gitlab \
  gitlab/gitlab-ce:latest
  
 #If you are on SELinux, then run this instead
##sudo docker run --detach \
##--hostname gitlab.example.com \
##--publish 443:443 --publish 80:80 --publish 22:22 \
##--name gitlab \
##--restart always \
##--volume $GITLAB_HOME/config:/etc/gitlab:Z \
##--volume $GITLAB_HOME/logs:/var/log/gitlab:Z \
##--volume $GITLAB_HOME/data:/var/opt/gitlab:Z \
##gitlab/gitlab-ce:latest