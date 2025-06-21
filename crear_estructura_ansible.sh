#!/bin/bash
set -e

echo "[*] Creando estructura Ansible para el Punto D..."

mkdir -p ~/UTNFRA_SO_2do_Parcial_MatiBelsito/ansible

# Crear playbook e inventario
touch ~/UTNFRA_SO_2do_Parcial_MatiBelsito/ansible/inventory.ini
touch ~/UTNFRA_SO_2do_Parcial_MatiBelsito/ansible/playbook.yml

# Crear estructura para el rol 2do_parcial
mkdir -p ~/UTNFRA_SO_2do_Parcial_MatiBelsito/ansible/roles/2do_parcial/tasks
touch ~/UTNFRA_SO_2do_Parcial_MatiBelsito/ansible/roles/2do_parcial/tasks/main.yml

# Crear estructura para el rol Alta_Usuarios_belsito
mkdir -p ~/UTNFRA_SO_2do_Parcial_MatiBelsito/ansible/roles/Alta_Usuarios_belsito/tasks
touch ~/UTNFRA_SO_2do_Parcial_MatiBelsito/ansible/roles/Alta_Usuarios_belsito/tasks/main.yml

# Crear estructura para el rol Sudoers_belsito
mkdir -p ~/UTNFRA_SO_2do_Parcial_MatiBelsito/ansible/roles/Sudoers_belsito/tasks
touch ~/UTNFRA_SO_2do_Parcial_MatiBelsito/ansible/roles/Sudoers_belsito/tasks/main.yml

# Crear estructura para el rol Instala_tools_belsito
mkdir -p ~/UTNFRA_SO_2do_Parcial_MatiBelsito/ansible/roles/Instala_tools_belsito/tasks
touch ~/UTNFRA_SO_2do_Parcial_MatiBelsito/ansible/roles/Instala_tools_belsito/tasks/main.yml

echo "[*] Estructura creada exitosamente."


