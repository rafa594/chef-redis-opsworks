#
# Cookbook:: redis-cluster
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.


# Add redis repository
apt_repository 'redis-server' do
    uri          'ppa:chris-lea/redis-server'
  end
  
  # Update OS repositories
  execute "update" do
    command "apt-get update"
    action :run
  end
  
  # Install redis-server
  package 'redis-server'
  
  # Configure master node template
  template "#{node[:redis][:conf_dir]}/redis.conf" do
    source        "default.erb"
    owner         "root"
    group         "root"
    mode          "0644"
    variables     :redis => node[:redis], :redis_server => node[:redis][:server]
  end
  
  execute 'redis-server-master' do
    command "redis-server #{node[:redis][:conf_dir]}/redis.conf"
    user 'root'
  end
  