# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "oradb" do |oracle|
    oracle.vm.provider "docker" do |docker|
      docker.image = "container-registry.oracle.com/database/free:latest" 
      docker.ports = ["1521:1521", "22:1022"]
      docker.env = {
        "ORACLE_PWD":"ABCabc123!!!"
      }
    end
  end
end

