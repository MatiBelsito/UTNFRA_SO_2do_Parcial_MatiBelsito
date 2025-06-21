#!/bin/bash
set -e

echo "[*] Iniciando Punto B ..."

# Copiar el script al destino requerido
sudo cp /home/mb/UTNFRA_SO_2do_Parcial_MatiBelsito/belsito_check_URL.sh /usr/local/bin/belsito_check_URL.sh
sudo chmod +x /usr/local/bin/belsito_check_URL.sh

# Ejecutar el script pasándole el archivo de URLs
sudo /usr/local/bin/belsito_check_URL.sh /home/mb/UTNFRA_SO_2do_Parcial_MatiBelsito/Lista_URL.txt

echo "[*] Punto B completado con éxito."

