#!/usr/bin/env bash
sudo yum -y install epel-release && yum -y update
sudo yum install -y openvpn easy-rsa

sudo mkdir -p /etc/openvpn/easy-rsa/keys
sudo cp -rf /usr/share/easy-rsa/2.0/* /etc/openvpn/easy-rsa
sudo cp /etc/openvpn/easy-rsa/openssl-1.0.0.cnf /etc/openvpn/easy-rsa/openssl.cnf
sudo tee /etc/openvpn/easy-rsa/vars << EOF
#所有凭证资料的预设值分别是：国家、省份、城市、组织、电子邮件位址、单位。
export KEY_COUNTRY="CN"
export KEY_PROVINCE="BJ"
export KEY_CITY="BEIJING"
export KEY_ORG="lenovo"
export KEY_EMAIL="noreplay@lenovo.com"
export KEY_OU="IT LENOVO."
EOF

sudo cd /etc/openvpn/easy-rsa
sudo source ./vars
sudo ./clean-all    #清除并删除 keys 目录下的所有 key
sudo ./build-ca     #生成CA的密钥及凭证，设定值不需修改的话，可以直接按Enter使用vars档案里的预设值
sudo ./build-key-server mylenovoserver   #生成 OpenVPN Server 端的密钥及凭证，同样可以使用vars档案的预设值
sudo ./build-dh     #生成 Diffie Hellman 参数，这个步骤比较久
sudo cd /etc/openvpn/easy-rsa/keys
sudo cp dh2048.pem ca.crt mylenovoserver.crt mylenovoserver.key /etc/openvpn
#生成 Client 端的密钥及凭证，文件名可以自定义
sudo /etc/openvpn/easy-rsa/build-key user01   #生成不用输入密码的凭证
#sudo /etc/openvpn/easy-rsa/build-key-pass user02    #生成需要输入密码的凭证
sudo cp /usr/share/doc/openvpn-*/sample/sample-config-files/server.conf /etc/openvpn
#sudo vim /etc/openvpn/server.conf
sudo cd /etc/openvpn
sudo openvpn --genkey --secret ta.key
sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sudo sysctl -p
sudo firewall-cmd --permanent --add-service openvpn
sudo firewall-cmd --permanent --add-masquerade
ETH_DEV=$(ip route get 223.5.5.5 | awk 'NR==1 {print $(NF-2)}' )
sudo firewall-cmd --permanent --direct --passthrough ipv4 -t nat -A POSTROUTING -s 10.8.0.0/24 -o $ETH_DEV -j MASQUERADE
sudo firewall-cmd --reload
sudo firewall-cmd --list-all
sudo systemctl restart network
sudo systemctl restart openvpn@server
sudo systemctl enable openvpn@server

##需要下载的文件
#/etc/openvpn/easy-rsa/keys/renwoleusers.crt
#/etc/openvpn/easy-rsa/keys/renwoleusers.key
#/etc/openvpn/easy-rsa/keys/ca.crt
#/etc/openvpn/ta.key
##配置client.ovpn
#ca ca.crt
#cert mylenovoserver.crt
#key user01.key
#remote-cert-tls server
#tls-auth ta.key 1
