#!/bin/bash
set -e


#IP_VM=$(ip addr show enp0s8 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)
IP_VM="192.168.56.3"


# === Generar info.txt con los datos del sistema ===
MODELO=$(grep "model name" /proc/cpuinfo | head -n1 | awk -F: '{print $2}')
FRECUENCIA=$(grep "cpu MHz" /proc/cpuinfo | head -n1 | awk -F: '{print $2}')

echo "Modelo:$MODELO" > /home/mb/UTNFRA_SO_2do_Parcial_MatiBelsito/docker/web/file/info.txt
echo "Frecuencia:$FRECUENCIA MHz" >> /home/mb/UTNFRA_SO_2do_Parcial_MatiBelsito/docker/web/file/info.txt



echo "Levantando el contenedor con docker compose..."
docker compose -f /home/mb/UTNFRA_SO_2do_Parcial_MatiBelsito/docker/docker-compose.yml up -d

echo
echo "Contenedores activos:"
docker ps


echo "¡Listo! Accedé a la web en http://$IP_VM:8081"
echo
echo "http://192.168.56.3:8081/"
echo "http://192.168.56.3:8081/file/info.txt"



