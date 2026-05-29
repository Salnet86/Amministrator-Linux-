# ==============================================================================
# AMMINISTRAZIONE LINUX Autorere Tirocinante Platania Salvatore 
# Descrizione: comandi essenziali per  l'amministrazione di sistema, suddivisi per categorie
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. GESTIONE UTENTI, GRUPPI E PERMESSI
# ------------------------------------------------------------------------------

# Esegue un singolo comando con i privilegi del superutente (root)
sudo comando_da_eseguire

# Avvia una sessione di shell come utente root (caricando il suo ambiente)
su -

# Passa all'identità di un altro utente specifico senza disconnettersi
su - nome_utente

# Crea un nuovo account utente nel sistema
sudo useradd nuovo_utente

# Elimina un account utente (l'opzione -r rimuove anche la sua directory home)
sudo userdel -r nome_utente

# Modifica le proprietà di un utente (es. -aG aggiunge l'utente a un gruppo secondario)
sudo usermod -aG nome_gruppo nome_utente

# Cambia o imposta la password per l'utente specificato
sudo passwd nome_utente

# Mostra i gruppi a cui appartiene l'utente corrente o quello specificato
groups nome_utente

# Cambia i permessi di un file o cartella (es. 755: rwxr-xr-x)
sudo chmod 755 /percorso/del/file

# Cambia il proprietario e il gruppo di un file o di una directory
sudo chown utente:gruppo /percorso/del/file

# Cambia il proprietario in modo ricorsivo a tutto il contenuto di una cartella
sudo chown -R utente:gruppo /percorso/della/cartella


# ------------------------------------------------------------------------------
# 2. MONITORAGGIO DI SISTEMA, RISORSE E PROCESSI
# ------------------------------------------------------------------------------

# Mostra i processi in esecuzione in tempo reale e le risorse di sistema (CPU/RAM)
top

# Alternativa moderna e interattiva a top (più leggibile e colorata, se installata)
htop

# Scatta una fotografia istantanea di tutti i processi attivi nel sistema
ps aux

# Cerca un processo specifico per nome combinando ps con il filtro grep
ps aux | grep nome_processo

# Termina un processo in modo pulito inviando il segnale SIGTERM tramite il suo ID (PID)
kill PID

# Termina forzatamente e immediatamente un processo (segnale SIGKILL)
kill -9 PID

# Termina tutti i processi che corrispondono al nome specificato
pkill nome_processo

# Mostra lo spazio totale, utilizzato e disponibile sui dischi (in formato GB/MB leggibile)
df -h

# Calcola lo spazio totale occupato da una specifica cartella e dal suo contenuto
du -sh /percorso/cartella

# Mostra l'utilizzo della memoria RAM e dello spazio di Swap (in Megabyte)
free -m

# Mostra da quanto tempo il server è acceso, gli utenti connessi e il carico medio (load average)
uptime

# Mostra informazioni dettagliate sulla CPU del sistema
lscpu

# Mostra i dettagli sull'hardware e i componenti della scheda madre
sudo lshw -short


# ------------------------------------------------------------------------------
# 3. GESTIONE DEI SERVIZI (SYSTEMD)
# ------------------------------------------------------------------------------

# Verifica lo stato attuale, i log recenti e se un servizio è attivo o bloccato
systemctl status nome_servizio

# Avvia un servizio che è attualmente fermo (es. apache2, nginx, ssh)
sudo systemctl start nome_servizio

# Ferma un servizio in esecuzione
sudo systemctl stop nome_servizio

# Riavvia un servizio (utile dopo aver modificato un file di configurazione)
sudo systemctl restart nome_servizio

# Ricarica la configurazione di un servizio senza interrompere le connessioni attive
sudo systemctl reload nome_servizio

# Abilita l'avvio automatico del servizio ad ogni boot del server
sudo systemctl enable nome_servizio

# Disabilita l'avvio automatico del servizio al boot
sudo systemctl disable nome_servizio

# Elenca tutti i servizi di sistema e mostra se sono abilitati o disabilitati
systemctl list-unit-files --type=service


# ------------------------------------------------------------------------------
# 4. RETE E DIAGNOSTICA
# ------------------------------------------------------------------------------

# Mostra tutte le interfacce di rete, i relativi indirizzi IP (IPv4/IPv6) e lo stato
ip a

# Mostra la tabella di instradamento IP (routing table) del sistema
ip route

# Invia pacchetti ICMP a un host per verificare se è raggiungibile e misurare la latenza
ping -c 4 google.com

# Mostra tutte le porte TCP/UDP in ascolto (-l) con i relativi numeri PID (-p) e numeriche (-n)
sudo ss -tulnp

# Vecchio comando alternativo a ss per monitorare connessioni e porte aperte
sudo netstat -tulnp

# Traccia il percorso dei pacchetti di rete verso un host remoto (utile per trovare nodi guasti)
traceroute google.com

# Interroga i server DNS per risolvere un nome di dominio e vedere i record associati
dig google.com

# Mostra i dettagli del record DNS in modo sintetico
nslookup google.com

# Effettua una richiesta HTTP a un URL (l'opzione -I mostra solo gli header di risposta)
curl -I https://www.google.com

# Scarica un file direttamente da internet salvandolo nella cartella corrente
wget https://example.com/file.zip


# ------------------------------------------------------------------------------
# 5. GESTIONE PACCHETTI E AGGIORNAMENTI (DEBIAN / UBUNTU - APT)
# ------------------------------------------------------------------------------

# Aggiorna l'elenco locale dei pacchetti disponibili dai repository remoti
sudo apt update

# Installa gli aggiornamenti di sicurezza e software per i pacchetti già installati
sudo apt upgrade

# Installa un nuovo pacchetto/software sul sistema
sudo apt install nome_pacchetto

# Rimuove un pacchetto installato, mantenendo però i suoi file di configurazione
sudo apt remove nome_pacchetto

# Rimuove completamente un pacchetto e cancella anche tutti i suoi file di configurazione
sudo apt purge nome_pacchetto

# Rimuove automaticamente i pacchetti e le dipendenze rimaste orfane e non più necessarie
sudo apt autoremove


# ------------------------------------------------------------------------------
# 6. GESTIONE PACCHETTI E AGGIORNAMENTI (RED HAT / CENTOS / RHEL - DNF)
# ------------------------------------------------------------------------------

# Controlla se ci sono aggiornamenti disponibili per i pacchetti installati
sudo dnf check-update

# Aggiorna tutti i pacchetti di sistema all'ultima versione disponibile
sudo dnf upgrade

# Installa un software specifico tramite il gestore dnf
sudo dnf install nome_pacchetto

# Rimuove un pacchetto e le sue dipendenze non utilizzate
sudo dnf remove nome_pacchetto


# ------------------------------------------------------------------------------
# 7. ANALISI DEI LOG, FILE DI CONFIGURAZIONE E RICERCA
# ------------------------------------------------------------------------------

# Mostra i log di sistema gestiti da systemd (l'opzione -xe si posiziona alla fine e mostra dettagli)
sudo journalctl -xe

# Mostra i log in tempo reale relativi a uno specifico servizio (es. ssh)
sudo journalctl -u nome_servizio -f

# Mostra le ultime 20 righe del log di sistema principale (Debian/Ubuntu) e rimane in ascolto (-f)
sudo tail -f /var/log/syslog

# Comando equivalente a tail -f per i log principali su sistemi Red Hat / CentOS
sudo tail -f /var/log/messages

# Cerca una specifica parola o pattern all'interno di un file di testo o di log
grep "ERROR" /var/log/nginx/error.log

# Cerca file all'interno del sistema partendo dalla radice (/) in base al nome
sudo find / -name "nginx.conf"

# Cerca file più grandi di 100 Megabyte nel sistema (utile per liberare spazio)
sudo find / -type f -size +100M

# Apre l'editor di testo Nano per modificare un file (semplice e intuitivo)
nano /etc/ssh/sshd_config

# Apre l'editor di testo Vim (potente, avanzato, standard in tutti i sistemi Linux)
vim /etc/fstab


# ------------------------------------------------------------------------------
# 8. MANUTENZIONE, DISCHI E RIAVVIO
# ------------------------------------------------------------------------------

# Elenca tutti i blocchi di memoria e i dischi fisici/partizioni collegati (in modo gerarchico)
lsblk

# Mostra le partizioni dei dischi e i relativi identificativi univoci (UUID) e file system
sudo blkid

# Monta un file system o una partizione in una determinata cartella del sistema
sudo mount /dev/sdb1 /mnt/dati

# Smonta una partizione precedentemente montata
sudo umount /mnt/dati

# Riavvia immediatamente il sistema/server
sudo reboot

# Spegne immediatamente il sistema/server interrompendo l'alimentazione
sudo shutdown -h now
