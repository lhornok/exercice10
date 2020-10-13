Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/bionic64"

  config.vm.define "mycreator" do | mycreator |
    # shell provisionning
    mycreator.vm.provision :shell, path: "bootstrap.sh"
    #Network
    mycreator.vm.network "private_network", ip: "192.168.100.10"
    # Sync Folders
    mycreator.vm.synced_folder '.', '/vagrant', disabled: true
    mycreator.vm.synced_folder './sfolder', '/srv'
  end

end
