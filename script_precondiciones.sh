#!/bin/bash

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

# 4. Instalar git si no está
if ! command -v git &>/dev/null; then
    echo "[+] Instalando Git..."
    sudo apt update && sudo apt install -y git
fi

# 5. Ejecutar como mb: clonar repo y correr script
echo "[+] Configurando entorno de examen como usuario mb..."
sudo -u mb bash << 'EOF'
cd ~
# Clonar el repositorio si no existe
if [ ! -d "UTN-FRA_SO_Examenes" ]; then
  git clone https://github.com/upszot/UTN-FRA_SO_Examenes.git
fi

# Ejecutar script de precondición
cd ~/UTN-FRA_SO_Examenes/202408
chmod +x script_Precondicion.sh
./script_Precondicion.sh

# Refrescar bashrc
source ~/.bashrc

# Crear symlink a carpeta compartida si no existe
if [ ! -L ~/carpeta_compartida ]; then
  ln -s /home/vagrant/carpeta_compartida ~/carpeta_compartida
fi
EOF

# 6. Dar permisos de la carpeta compartida a mb
echo "[+] Dando permisos de escritura a mb en carpeta compartida..."
sudo chown -R mb:mb /home/vagrant/carpeta_compartida

echo "[✔] Precondiciones completadas correctamente."
