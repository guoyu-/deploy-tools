#!/usr/bin/env bash
###################
#guoyu.cn@outlook.com
###################
sudo mkdir -p /data/mysqldata
sudo chmod o+w -R /data/mysqldata
sudo docker run --name mysql -p 3306:3306 --privileged=true --restart=always -v /data/mysqldata:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -d mysql:5.7