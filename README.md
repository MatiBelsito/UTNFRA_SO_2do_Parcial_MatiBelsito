# Examen de Sistemas Operativos - UTN FRA  
**Alumno:** Matías Belsito  
**División:** 318  
**Fecha:** 24/06/2025  

## Contenido del repositorio

```bash
UTNFRA_SO_2do_Parcial_MatiBelsito/
├── Lista_URL.txt
├── README.md
├── script_precondiciones_belsito.sh      # Prepara la VM para el examen
├── crear_estructura_ansible.sh           # Crea estructura de carpetas y archivos de Ansible
├── preparar_conexion_ansible.sh          # Prepara la conexión SSH para Ansible
├── belsito_check_URL.sh                  # Script para verificar URLs (Punto B)
├── docker/                               # Archivos de Docker (Punto C)
│   ├── Dockerfile
│   ├── docker-compose.yml
│   └── web/
│       ├── index.html
│       ├── file/info.txt
│       └── scripts/*.js
├── RTA_Examen_20250617/                  # Scripts principales del examen
│   ├── Punto_A.sh
│   ├── Limpiar_Punto_A.sh
│   ├── Punto_B.sh
│   ├── Punto_C.sh
│   └── Punto_D.sh
└── ansible/                              # Estructura de Ansible (Punto D)
    ├── inventory.ini
    ├── playbook.yml
    └── roles/
        ├── 2do_parcial/
        ├── Alta_Usuarios_belsito/
        ├── Sudoers_belsito/
        └── Instala_tools_belsito/

Como ejecutar el examen en una nueva VM

    Levantar la VM con el Vagrantfile proporcionado en este repositorio.

    Ingresar como vagrant (el usuario inicial configurado).

    Ejecutar el script de precondiciones:

chmod +x script_precondiciones_belsito.sh
./script_precondiciones_belsito.sh

Esto:

    Crea el usuario mb con sudo y Docker sin contraseña.

    Instala Git, Docker (última versión oficial) y Ansible.

    Clona el repositorio del profesor.

    Ejecuta el script de precondición del profesor.

    Crea estructura de roles Ansible.

    Prepara la conexión SSH para Ansible.

    Cerrar sesión y volver a ingresar como usuario mb para que se apliquen los permisos correctamente.

    Por ultimo ejecutar los scripts punto por punto desde la carpeta RTA_Examen_20250617:

cd ~/UTNFRA_SO_2do_Parcial_MatiBelsito/RTA_Examen_20250617
sudo ./Punto_A.sh
sudo ./Punto_B.sh
sudo ./Punto_C.sh
sudo ./Punto_D.sh
