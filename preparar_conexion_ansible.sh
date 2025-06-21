#!/bin/bash
set -e

echo "[*] Preparando conexión SSH con la VM nueva..."

# Dirección IP de la nueva VM
IP="192.168.56.3"

# Usuario remoto
USUARIO="mb"

# Ruta a la clave pública
CLAVE_PUB="$HOME/.ssh/id_ed25519.pub"

# Verifica si la clave existe
if [ ! -f "$CLAVE_PUB" ]; then
    echo "No se encontró la clave pública en $CLAVE_PUB"
    exit 1
fi

# Hace la copia al nuevo servidor (pedirá la contraseña una sola vez, la nisma es "vagrant")
ssh-copy-id -i "$CLAVE_PUB" "$USUARIO@$IP"

echo "[*] Conexión SSH configurada con éxito para $USUARIO@$IP"
