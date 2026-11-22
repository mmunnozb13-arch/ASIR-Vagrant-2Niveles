Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"

  # Máquina de BBDD (sin Internet)
  config.vm.define "mysql" do |mysql|
    mysql.vm.hostname = "MarcosMunozBarrosoMysql"
    mysql.vm.network "private_network", ip: "192.168.56.11",
                     virtualbox__intnet: "red_interna"
    mysql.vm.provision "shell", path: "mysql.sh"
    mysql.vm.provision "shell", path: "sin_internet.sh", run: "always"
  end

  # Máquina Apache (con NAT y port forwarding)
  config.vm.define "apache" do |apache|
    apache.vm.hostname = "MarcosMunozBarrosoApache"
    apache.vm.network "forwarded_port", guest: 80, host: 8080
    apache.vm.network "private_network", ip: "192.168.56.10",
                      virtualbox__intnet: "red_interna"
    apache.vm.provision "shell", path: "apache.sh"
  end
end
