#
# Cookbook:: redis-cluster
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.


# Add redis repository
apt_repository 'redis-server' do
    uri 'ppa:chris-lea/redis-server'
  end
  
  # Update OS repositories
  execute "update" do
    command "apt-get update"
    action :run
  end
  
  # Install redis-server
  package 'redis-server'
  
  # Configure master node template
