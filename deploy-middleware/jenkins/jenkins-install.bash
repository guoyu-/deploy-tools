#!/usr/bin/env bash
#Long Term Support release
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade
sudo yum install jenkins java-1.8.0-openjdk-devel
#Weekly release
#sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
#sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
#sudo yum upgrade
#sudo yum install jenkins java-1.8.0-openjdk-devel
sudo systemctl start jenkins
sudo systemctl enable jenkins
YOURPORT=8080
PERM="--permanent"
SERV="$PERM --service=jenkins"

sudo firewall-cmd $PERM --new-service=jenkins
sudo firewall-cmd $SERV --set-short="Jenkins ports"
sudo firewall-cmd $SERV --set-description="Jenkins port exceptions"
sudo firewall-cmd $SERV --add-port=$YOURPORT/tcp
sudo firewall-cmd $PERM --add-service=jenkins
sudo firewall-cmd --zone=public --add-service=http --permanent
sudo firewall-cmd --reload