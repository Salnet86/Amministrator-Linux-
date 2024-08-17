sudo apt update


sudo apt install default-jdk

java -version


sudo useradd -r -m -U -d /opt/tomcat -s /bin/false tomcat


wget -c https://downloads.apache.org/tomcat/tomcat-9/v9.0.34/bin/apache-tomcat-9.0.34.tar.gz


sudo tar xf apache-tomcat-9.0.34.tar.gz -C /opt/tomcat


sudo ln -s /opt/tomcat/apache-tomcat-9.0.34 /opt/tomcat/updated

sudo chown -R tomcat: /opt/tomcat/*


sudo sh -c 'chmod +x /opt/tomcat/updated/bin/*.sh'


sudo nano /etc/systemd/system/tomcat.service






[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment="JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64"
Environment="CATALINA_PID=/opt/tomcat/updated/temp/tomcat.pid"
Environment="CATALINA_HOME=/opt/tomcat/updated/"
Environment="CATALINA_BASE=/opt/tomcat/updated/"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
Environment="JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"

ExecStart=/opt/tomcat/updated/bin/startup.sh
ExecStop=/opt/tomcat/updated/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target





