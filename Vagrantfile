# -*- mode: ruby -*-
# vi: set ft=ruby :

#https://developer.hashicorp.com/vagrant/docs/providers/virtualbox/configuration
Vagrant.configure("2") do |config|

  # VagrantBox que se usara para levantar.
  config.vm.box = "ubuntu/jammy64"
  
  #Nombre de la pc dentro del Sistema Operativo
  config.vm.hostname = "MatiBelsito"
  
  # Comparto la carpeta del host donde estoy parado contra la vm
  config.vm.synced_folder '.', '/home/vagrant/carpeta_compartida'
  
  # Configuración de Red
  config.vm.network "private_network", :name => '', ip: "192.168.56.3"

  # Agrego disco rigidos Extras (Nombres distintos)
  config.vm.disk :disk, size: "3GB", name: "extra_storage_1"
  config.vm.disk :disk, size: "1GB", name: "extra_storage_2"
  config.vm.disk :disk, size: "1GB", name: "extra_storage_3"

  #Configuraciones de la VM en VirtualBox
  config.vm.provider "virtualbox" do |vb|
      #Cantidad de RAM
      vb.memory = "2048"
      #Cantidad de Procesadores
      vb.cpus = 2

      #Nombre de la VM en VirtualBox 
      vb.name = "MatiBelsito"

      # Habilitar clones enlazados en VirtualBox
      vb.linked_clone = true
      
      # Mostrar interfaz gráfica de la VM en VirtualBox
      vb.gui = false

  end

  # Puedo Ejecutar un script que esta en un archivo
  config.vm.provision "shell", path: "script_Enable_ssh_password.sh"

  # Agrega la key Privada de ssh en .vagrant/machines/default/virtualbox/private_key
  config.ssh.insert_key = true

end
