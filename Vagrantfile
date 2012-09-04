# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box       = "centOS-6.3"
  config.vm.box_url   = 'https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box'
  config.vm.host_name = 'my-box'

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port 80, 8080
  config.vm.forward_port 443, 8433 

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # NOTE: If httpd has trouble installing, try commenting this line out,
  # reload, then bring it back after apache is setup
  config.vm.share_folder "www", "/var/www/", "./www"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "./puppet/manifests"
    puppet.manifest_file  = "default.pp"
    puppet.module_path = "./puppet/modules"
  end
end
