#!/usr/bin/env bash
sudo yum -y install epel-release curl vim policycoreutils-python openssh-server
#https://docs.gitlab.com/omnibus/settings/smtp.html
#sudo yum install postfix
#sudo systemctl start postfix
#sudo systemctl enable postfix
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash
sudo yum install gitlab-ce
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload
sudo vim /etc/gitlab/gitlab.rb
#external_url 'https://gitlab.example.com'
#letsencrypt['enable'] = true
#letsencrypt['contact_emails'] = ['admin@example.com'] # This should be an array of email addresses to add as contacts
sudo gitlab-ctl reconfigure