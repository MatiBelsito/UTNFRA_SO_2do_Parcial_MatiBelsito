#!/bin/bash
set -e

echo "[*] Limpiando configuraciones anteriores..."

# Apagar swap
sudo swapoff -a || true

# Desmontar puntos de montaje si están activos
sudo umount /var/lib/docker || true
sudo umount /Multimedia || true

# Eliminar volúmenes lógicos si existen
sudo lvremove -f /dev/vg_datos/lv_docker || true
sudo lvremove -f /dev/vg_datos/lv_multimedia || true
sudo lvremove -f /dev/vg_temp/lv_swap || true

# Eliminar grupos de volúmenes si existen
sudo vgremove -f vg_datos || true
sudo vgremove -f vg_temp || true

# Eliminar volúmenes físicos si existen
sudo pvremove -f /dev/sdc2 || true
sudo pvremove -f /dev/sdd1 || true
sudo pvremove -f /dev/sde1 || true

# Limpiar tablas de particiones con fdisk
for disk in /dev/sdc /dev/sdd /dev/sde; do
  echo -e "o\nw" | sudo fdisk $disk
done

# Restaurar fstab si existe backup
if [ -f /etc/fstab.bak ]; then
    sudo mv /etc/fstab.bak /etc/fstab
    echo "Archivo /etc/fstab restaurado desde backup."
else
    echo "No se encontró backup de /etc/fstab para restaurar."
fi

echo "[*] Limpieza completada."
