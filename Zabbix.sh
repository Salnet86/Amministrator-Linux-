


#Diventa utente root

sudo -s


#Installa il repository Zabbix

# wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-2+ubuntu24.04_all.deb
# dpkg -i zabbix-release_7.0-2+ubuntu24.04_all.deb
# apt update


#Installare il server Zabbix, il frontend, l'agente




 apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent


#Creare il database iniziale



mysql -u root -p



create database zabbix character set utf8mb4 collate utf8mb4_bin

create user zabbix@localhost identified by 'password'

grant all privileges on zabbix.* to zabbix@localhost;

set global log_bin_trust_function_creators = 1;

quit;


#Sul server Zabbix l'host importa lo schema iniziale e i dati. Ti verrà chiesto di inserire la password appena creata.

 zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix


##Disabilitare l'opzione log_bin_trust_function_creators dopo importazione dello schema del database.


mysql -uroot -p
set global log_bin_trust_function_creators = 0;

quit;


#Configurare il database per il server Zabbix

# Modifica file

nano /etc/zabbix/zabbix_server.con

DBPassword=password


#Avviare i processi del server e dell'agente Zabbix

systemctl restart zabbix-server zabbix-agent apache2

systemctl enable zabbix-server zabbix-agent apache2











