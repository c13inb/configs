#!/bin/bash

apt install nis portmap


echo "Primero modificamos detalles de UID del primer usuario que es sudo"
firstuser=`getent group sudo | cut -d: -f4`
newUID=5000
echo "  Cambiando de lugar el home del primer usuario ($firstuser) a /localhome/${firstuser}"
mkdir /localhome
usermod -d /localhome/$firstuser -m $firstuser
newUID=5000
echo "  Cambiando UID del usuario $firstuser a $newUID"
usermod -u $newUID $firstuser


echo "Editando archivos passwd, group y shadow"
cp -v /etc/passwd /etc/passwd.original
cp -v /etc/group /etc/group.original
cp -v /etc/shadow /etc/shadow.original

echo "+::::::" >> /etc/passwd
echo "+:::"    >> /etc/group
echo "+::::::::" >> /etc/shadow


echo "Editando /etc/nsswitch"
fmrilab_nsswitch=./fmrilab_nsswitch
mv -v /etc/nsswitch.conf /etc/nsswitch.conf.original
cp -v $fmrilab_nsswitch /etc/nsswitch.conf


echo "Editando /etc/yp.conf"
echo "ypserver 172.24.80.102" >> /etc/yp.conf


echo "Editando /etc/profile"
cat ./fmrilab_profile >> /etc/profile

echo "Editando /lib/systemd/system/systemd-logind.service "

sed -i 's/^IPAddressDeny=any/#IPAddressDeny=any/' /lib/systemd/system/systemd-logind.service
chmod -w /lib/systemd/system/systemd-logind.service
chmod o-r /lib/systemd/system/systemd-logind.service
# la linea debe ir comentada, siguiendo instrucciones de 
# https://askubuntu.com/questions/1031022/using-nis-client-in-ubuntu-18-04-crashes-both-gnome-and-unity

# al parecer instalar nscd tambien ayuda a quitar el problema de systemd
# https://www.bountysource.com/issues/50217346-systemd-logind-s-ip-sandbox-breaks-nss-nis-and-suchlike
apt install nscd


systemctl daemon-reload
systemctl restart systemd-logind.service
service nis restart


