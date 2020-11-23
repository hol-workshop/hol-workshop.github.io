#!/bin/sh

echo "UBUNTU - INSTALLATION DATE $(date -R)!" >> /home/ubuntu/install.log
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
echo "UBUNTU - postgre repo is downloaded $(date -R)!" >> /home/ubuntu/install.log

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
echo "UBUNTU - postgre repo is updated $(date -R)!" >> /home/ubuntu/install.log

sudo apt-get update -y 
echo "UBUNTU - ubuntu is updated $(date -R)!" >> /home/ubuntu/install.log

sudo apt install unzip -y 
echo "UBUNTU - unzip is installed $(date -R)!" >> /home/ubuntu/install.log

sudo apt-get install postgresql -y 
echo "UBUNTU - postgresql 13 is now installed $(date -R)!" >> /home/ubuntu/install.log

sudo sed -i 's/#listen_addresses/listen_addresses/g' /etc/postgresql/13/main/postgresql.conf
sudo sed -i 's/localhost/*/g' /etc/postgresql/13/main/postgresql.conf
echo "POSTGRE - Remote access parameter is enabled $(date -R)!" >> /home/ubuntu/install.log

line_old='host    all             all             127.0.0.1/32            md5'
line_new='host    all             all             0.0.0.0/0               md5'

sudo sed -i "s%$line_old%$line_new%g" /etc/postgresql/13/main/pg_hba.conf
echo "POSTGRE - Remote access parameter in pg_hba file is updated $(date -R)!" >> /home/ubuntu/install.log

line_old='#wal_level = replica'
line_new='wal_level = logical'
sudo sed -i "s%$line_old%$line_new%g" /etc/postgresql/13/main/postgresql.conf

line_old='#max_replication_slots = 10'
line_new='max_replication_slots = 10'
sudo sed -i "s%$line_old%$line_new%g" /etc/postgresql/13/main/postgresql.conf

line_old='#max_wal_senders = 10'
line_new='max_wal_senders = 10'
sudo sed -i "s%$line_old%$line_new%g" /etc/postgresql/13/main/postgresql.conf

echo "POSTGRE - Replication parameters in postgresql file is updated $(date -R)!" >> /home/ubuntu/install.log

sudo systemctl stop postgresql
echo "POSTGRE - postgresql stopped $(date -R)!" >> /home/ubuntu/install.log

sudo systemctl start postgresql
echo "POSTGRE - postgresql started $(date -R)!" >> /home/ubuntu/install.log

sudo -H -u postgres psql -c "CREATE DATABASE dvdrental;"
echo "POSTGRE - dvdrental is created $(date -R)!" >> /home/ubuntu/install.log

sudo -H -u postgres psql -c "CREATE ROLE ogg1 WITH REPLICATION LOGIN PASSWORD 'ogg1'"
echo "POSTGRE - ogg1 user is created $(date -R)!" >> /home/ubuntu/install.log

sudo curl -O https://sp.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip >> /home/ubuntu/install.log
echo "POSTGRE - DVD RENTAL ZIP is downloaded $(date -R)!" >> /home/ubuntu/install.log

sudo unzip dvdrental.zip
echo "POSTGRE - UNZIPPED DVD RENTAL  $(date -R)!" >> /home/ubuntu/install.log

sudo -H -u postgres bash -c 'pg_restore --dbname=dvdrental --verbose dvdrental.tar'
echo "POSTGRE - imported dvdrental database $(date -R)!" >> /home/ubuntu/install.log

sudo -H -u postgres psql -d dvdrental -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public to ogg1;"
sudo -H -u postgres psql -d dvdrental -c "GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public to ogg1;"
sudo -H -u postgres psql -d dvdrental -c "GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public to ogg1;"

echo "POSTGRE - GRANT dvdrental/public database access to ogg1 $(date -R)!" >> /home/ubuntu/install.log

sudo iptables -P INPUT ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -F

echo "UBUNTU - iptables flushed $(date -R)!" >> /home/ubuntu/install.log