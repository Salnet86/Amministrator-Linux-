java -version

sudo apt-get update && sudo apt-get install default-jdk

sudo groupadd tomcat


sudo useradd -s /bin/false -g tomcat -d /usr/local/tomcat tomcat



cd /usr/local


wget
https://apache.panu.it/tomcat/tomcat-9/v9.0.33/bin/apache-tomcat-9.0.33.tar.gz


tar xzvf apache-tomcat-9.0.33.tar.gz && mv apache-tomcat-9.0.33 tomcat

sudo chgrp -R tomcat tomcat
sudo chmod -R g+r  tomcat/conf
sudo chmod g+x  tomcat/conf
sudo chown -R tomcat tomcat/work/ tomcat/logs/ tomcat/webapps/ tomcat/temp/ 

update-java-alternatives -l

sudo nano /etc/systemd/system/tomcat.service


""""
[Unit]

Description=Apache Tomcat

After=network.target
                [Service]

Type=forking
                Environment=JAVA_HOME=PERCORSO_JAVA

Environment=CATALINA_PID=/usr/local/tomcat/temp/tomcat.pid

Environment=CATALINA_HOME=/usr/local/tomcat

Environment=CATALINA_BASE=/usr/local/tomcat

Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'

Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'
                ExecStart=/usr/local/tomcat/bin/startup.sh

ExecStop=/usr/local/tomcat/bin/shutdown.sh
                User=tomcat

Group=tomcat

UMask=0007

RestartSec=10

Restart=always
                [Install]

WantedBy=multi-user.target

"""


Servizi 
Tutorial > Come installare Apache Tomcat su Ubuntu 18.04
cerca un tutorial....
Search
Come installare Apache Tomcat su Ubuntu 18.04Pubblicato il: 06 ottobre 2019 Java Tomcat Ubuntu
Prova i nostri prodotti, hai fino a  1 anno di servizi gratuiti!
Apache Tomcat è un web server usato per gestire applicazioni web basate sulla tecnologia Java. In questo tutorial trovi tutte le istruzioni necessarie per installare Tomcat su Linux Ubuntu 18.04.

Per prima cosa dovrai connetterti al tuo server tramite una connessione SSH. Se non l’hai ancora fatto, ti consigliamo di seguire la nostra guida per connetterti in sicurezza con il protocollo SSH. In caso di server locale puoi passare al punto successivo e aprire il terminale del tuo server.

Installazione Java
Verifica se Java è già installato sul tuo sistema tramite il comando:

$ java -version
Se Java risulta installato allora puoi passare al prossimo step, in caso contrario procedi alla sua installazione.

Aggiorna i repository di apt e quindi procedi con l'installazione del Java Development Kit:

$  sudo apt-get update && sudo apt-get install default-jdk
Installazione Tomcat
Per prima cosa crea un nuovo utente e un nuovo gruppo che avrà il compito di lanciare il servizio Tomcat.

Crea il gruppo "tomcat":

$ sudo groupadd tomcat
E crea il relativo utente "tomcat", che per ragioni di sicurezza non avrà l'accesso al terminale:

$ sudo useradd -s /bin/false -g tomcat -d /usr/local/tomcat tomcat
Ora che l'utente e il gruppo sono stati creati puoi passare all'installazione vera e propria di Tomcat.

Spostati nella cartella /usr/local:

$ cd /usr/local
Visita la pagina https://tomcat.apache.org/download-90.cgi per accertarti di scaricare l'ultima versione di Tomcat. Ad oggi l'ultima versione rilasciata è la 9.0.33, quindi procedi con il download del pacchetto tar.gz utilizzando uno dei mirror che trovi sulla pagina indicata:

$ wget 
https://apache.panu.it/tomcat/tomcat-9/v9.0.33/bin/apache-tomcat-9.0.33.tar.gz
Scompatta il file scaricato e cambia il nome alla cartella appena estratta in "tomcat":

$ tar xzvf 
apache-tomcat-9.0.33.tar.gz
 && mv 
apache-tomcat-9.0.33
 tomcat
Prosegui configurando i permessi della suddetta cartella per l'utente e il gruppo "tomcat" creati in precedenza:

$ sudo chgrp -R tomcat tomcat

$ sudo chmod -R g+r  tomcat/conf

$ sudo chmod g+x  tomcat/conf

$ sudo chown -R tomcat tomcat/work/ tomcat/logs/ tomcat/webapps/ tomcat/temp/ 
A questo punto l'installazione di Tomcat è completata, quindi prosegui con la creazione di un servizio per avviarlo.

Per prima cosa segnati il percorso relativo alla tua installazione di Java, che potrai ottenere tramite il comando:

$ update-java-alternatives -l
Come puoi vedere dall'immagine seguente, sarà stampato il percorso dell'installazione di Java che ti servirà per creare il tuo servizio.

image1.png

Crea il file tomcat.service nella cartella /etc/systemd/system/

$ sudo nano /etc/systemd/system/tomcat.service
Il file dovrà avere il seguente contenuto, facendo attenzione a sostituire, nel punto indicato, il percorso della tua installazione di Java precedentemente appuntato:

[Unit]

Description=Apache Tomcat

After=network.target
                [Service]

Type=forking
                Environment=JAVA_HOME=PERCORSO_JAVA

Environment=CATALINA_PID=/usr/local/tomcat/temp/tomcat.pid

Environment=CATALINA_HOME=/usr/local/tomcat

Environment=CATALINA_BASE=/usr/local/tomcat

Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'

Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'
                ExecStart=/usr/local/tomcat/bin/startup.sh

ExecStop=/usr/local/tomcat/bin/shutdown.sh
                User=tomcat

Group=tomcat

UMask=0007

RestartSec=10

Restart=always
                [Install]

WantedBy=multi-user.target
Ad esempio in questo caso il file avrà il seguente contenuto:

[Unit]

Description=Apache Tomcat

After=network.target
                [Service]

Type=forking
                Environment=JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64

Environment=CATALINA_PID=/usr/local/tomcat/temp/tomcat.pid

Environment=CATALINA_HOME=/usr/local/tomcat

Environment=CATALINA_BASE=/usr/local/tomcat

Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'

Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'
                ExecStart=/usr/local/tomcat/bin/startup.sh

ExecStop=/usr/local/tomcat/bin/shutdown.sh
                User=tomcat

Group=tomcat

UMask=0007

RestartSec=10

Restart=always
                [Install]

WantedBy=multi-user.target




