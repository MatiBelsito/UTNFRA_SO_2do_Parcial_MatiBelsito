#!/bin/bash
set -e

echo "[*] Ejecutando Punto D..."

cd ~/UTNFRA_SO_2do_Parcial_MatiBelsito/ansible

ansible-playbook -i inventory.ini playbook.yml

echo "[*] Punto D completado con éxito."
