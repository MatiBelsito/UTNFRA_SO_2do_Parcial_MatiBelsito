#!/bin/bash
set -e

echo "[*] Iniciando Punto A ..."

# Particionar /dev/sdc:
# 1) 512MB swap física (tipo 82)
# 2) resto para LVM (tipo 8e)
(
echo o      # crear tabla de particiones nueva DOS
echo n      # nueva particion 1
echo p
echo 1
echo      # default inicio sector
echo +512M
echo t      # cambiar tipo particion 1
echo 82     # swap
echo n      # nueva particion 2
echo p
echo 2
echo      # default inicio sector
echo      # default final (resto disco)
echo t      # cambiar tipo particion 2
echo 2
echo 8e     # Linux LVM
echo w      # guardar y salir
) | sudo fdisk /dev/sdc

# Particionar /dev/sdd (todo disco para LVM)
(
echo o
echo n
echo p
echo 1
echo
echo
echo t
echo 8e
echo w
) | sudo fdisk /dev/sdd

# Particionar /dev/sde (todo disco para LVM)
(
echo o
echo n
echo p
echo 1
echo
echo
echo t
echo 8e
echo w
) | sudo fdisk /dev/sde

# Crear PVs
sudo pvcreate /dev/sdc2 /dev/sdd1 /dev/sde1

# Crear VGs
sudo vgcreate vg_datos /dev/sdc2
sudo vgcreate vg_temp /dev/sdd1 /dev/sde1

# Crear LVs
sudo lvcreate -L 10M -n lv_docker vg_datos
sudo lvcreate -L 1.5G -n lv_multimedia vg_datos
sudo lvcreate -L 1.9G -n lv_swap vg_temp

# Formatear LVs
sudo mkfs.ext4 /dev/vg_datos/lv_docker
sudo mkfs.ext4 /dev/vg_datos/lv_multimedia

# Configurar swap física y swap LVM
sudo mkswap /dev/sdc1
sudo mkswap /dev/vg_temp/lv_swap

# Crear puntos de montaje
sudo mkdir -p /var/lib/docker
sudo mkdir -p /Multimedia

# Montar LVs
sudo mount /dev/vg_datos/lv_docker /var/lib/docker
sudo mount /dev/vg_datos/lv_multimedia /Multimedia

# Activar swap
sudo swapon /dev/sdc1
sudo swapon /dev/vg_temp/lv_swap

# Respaldar fstab original
sudo cp /etc/fstab /etc/fstab.bak

# Añadir al fstab (evitar duplicados con grep)
if ! grep -q "/var/lib/docker" /etc/fstab; then
    echo "/dev/mapper/vg_datos-lv_docker /var/lib/docker ext4 defaults 0 2" | sudo tee -a /etc/fstab
fi

if ! grep -q "/Multimedia" /etc/fstab; then
    echo "/dev/mapper/vg_datos-lv_multimedia /Multimedia ext4 defaults 0 2" | sudo tee -a /etc/fstab
fi

if ! grep -q "/dev/sdc1" /etc/fstab; then
    echo "/dev/sdc1 none swap sw 0 0" | sudo tee -a /etc/fstab
fi

if ! grep -q "lv_swap" /etc/fstab; then
    echo "/dev/mapper/vg_temp-lv_swap none swap sw 0 0" | sudo tee -a /etc/fstab
fi

echo "[*] Punto A completado con éxito."
