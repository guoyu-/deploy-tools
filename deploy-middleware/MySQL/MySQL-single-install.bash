#!/usr/bin/env bash
###################
#guoyu.cn@outlook.com
####################
function max_dir() {
df_lines=$(df -P | wc -l)

max_dir=''
max_siz=0

for i in $(seq 2 $df_lines)
do
    temp_siz=$(df -P | awk -v i=$i 'NR==i{print $4}')
    if [ $temp_siz -gt $max_siz ];then
        max_siz=$temp_siz
        max_dir=$(df -P | awk -v i=$i 'NR==i{print $NF}')
    fi
done

echo $max_dir
}

sudo yum install https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
#install MySQL 8.0
sudo yum install mysql-community-server
#install MySQL 5.7
sudo yum-config-manager --disable mysql80-community
sudo yum-config-manager --enable mysql57-community
sudo yum install mysql-community-server
#install MySQL 5.6
sudo yum-config-manager --disable mysql80-community
sudo yum-config-manager --enable mysql56-community
sudo yum install mysql-community-server
#config MySQL
sudo rsync -avz /var/lib/mysql max_dir/
sudo sed -i "s#datadir=/var/lib#datadir=${max_dir}"
#enable MySQL server
sudo systemctl restart mysqld
sudo systemctl enable mysqld
sudo grep tempor /var/log/mysqld.log

#mysql -u root -p

#mysql>GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;
#mysql>FLUSH PRIVILEGES;
#mysql>exit