#!/bin/bash
set -e

echo "[*] Ejecutando script de precondiciones..."

# 1. Crear usuario mb si no existe
if ! id "mb" &>/dev/null; then
    echo "[+] Creando usuario mb..."
    sudo adduser --disabled-password --gecos "" mb
fi

# 2. Agregarlo al grupo sudo
echo "[+] Agregando usuario mb a grupo sudo..."
sudo usermod -aG sudo mb

# 3. Dar permisos sudo sin contraseña
echo "[+] Configurando sudo sin contraseña..."
echo "mb ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/mb > /dev/null
sudo chmod 0440 /etc/sudoers.d/mb

# 4. Instalar Git si no está
if ! command -v git &>/dev/null; then
    echo "[+] Instalando Git..."
    sudo apt update && sudo apt install -y git
fi

# 5. Instalar Docker desde repositorio oficial
if ! command -v docker &>/dev/null; then
    echo "[+] Instalando Docker desde repositorio oficial..."
    sudo apt update
    sudo apt install -y ca-certificates curl gnupg lsb-release

    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
        sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Agregar usuario mb al grupo docker
    sudo usermod -aG docker mb
fi

# 6. Instalar Ansible si no está
if ! command -v ansible &>/dev/null; then
    echo "[+] Instalando Ansible..."
    sudo apt update
    sudo apt install -y ansible
fi

# 7. Ejecutar como mb: clonar repo del profe y preparar entorno de trabajo
echo "[+] Configurando entorno de examen como usuario mb..."
sudo -u mb bash << 'EOF'
cd ~

# Clonar repo del profe si no existe
if [ ! -d "UTN-FRA_SO_Examenes" ]; then
  git clone https://github.com/upszot/UTN-FRA_SO_Examenes.git
fi

# Ejecutar script del profe
cd ~/UTN-FRA_SO_Examenes/202408
chmod +x script_Precondicion.sh
./script_Precondicion.sh

# Volver al repo del parcial y preparar Ansible
cd ~/UTNFRA_SO_2do_Parcial_MatiBelsito
chmod +x crear_estructura_ansible.sh preparar_conexion_ansible.sh
./crear_estructura_ansible.sh
./preparar_conexion_ansible.sh
EOF

# 8. Dar permisos de la carpeta compartida
echo "[+] Dando permisos de escritura a mb en carpeta compartida..."
sudo chown -R mb:mb /home/vagrant/carpeta_compartida || true

echo "[✔] Precondiciones completadas correctamente."
echo "[!] Recordá cerrar y volver a abrir la sesión de 'mb' para que se apliquen los grupos correctamente (sudo, docker)."
