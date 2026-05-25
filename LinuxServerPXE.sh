# 1. Installazione
sudo apt update
sudo apt install dnsmasq syslinux pxelinux -y

# 2. Cartelle e file di boot
sudo mkdir -p /srv/tftp/pxelinux.cfg
sudo mkdir -p /srv/tftp/ubuntu
sudo cp /usr/lib/PXELINUX/pxelinux.0 /srv/tftp/
sudo cp /usr/lib/syslinux/modules/bios/{ldlinux.c32,menu.c32,libutil.c32} /srv/tftp/

# 3. Estrazione file dalla ISO (Sostituisci percorso_tua_iso)
sudo mkdir -p /mnt/iso
sudo mount -o loop percorso_tua_iso.iso /mnt/iso
sudo cp /mnt/iso/casper/vmlinuz /srv/tftp/ubuntu/
sudo cp /mnt/iso/casper/initrd /srv/tftp/ubuntu/initrd.gz
sudo umount /mnt/iso

# 4. Configurazione Server (Sovrascrive tutto)
echo -e "interface=eth0\ndhcp-range=qui metto il renge ip,12h\nenable-tftp\ntftp-root=/srv/tftp\npxe-service=x86PC,\"Boot\",pxelinux" | sudo tee /etc/dnsmasq.conf

# 5. Creazione Menu
echo -e "DEFAULT menu.c32\nMENU TITLE PXE\nLABEL ubuntu\nKERNEL ubuntu/vmlinuz\nAPPEND initrd=ubuntu/initrd.gz" | sudo tee /srv/tftp/pxelinux.cfg/default

# 6. Avvio finale
sudo chown -R root:root /srv/tftp
sudo systemctl restart dnsmasq
