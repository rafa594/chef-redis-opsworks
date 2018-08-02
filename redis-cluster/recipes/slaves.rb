#
# Cookbook:: redis-cluster
# Recipe:: slaves
#
# Copyright:: 2018, The Authors, All Rights Reserved.



priority = 100
instance = search("aws_opsworks_instance", "hostname:redishost").first
node.default[:redis][:master_server] = "#{instance['private_ip']}"
#port = default[:redis][:slaves][:port]


node.default[:redis][:slave] = "yes"
node.default[:redis][:pid_file] = "/var/run/redis.pid"
node.default[:redis][:server][:port] = port
node.default[:redis][:log_dir] = "/var/log/redis"
node.default[:redis][:data_dir] = "/var/lib/redis"

directory node[:redis][:log_dir] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

directory node[:redis][:data_dir] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template "#{node[:redis][:conf_dir]}/redis.conf" do
  source        "default.erb"
  owner         "root"
  group         "root"
  mode          "0644"
  variables     :redis => node[:redis], :redis_server => node[:redis][:server]
end

execute 'redis-server' do
  command "redis-server #{node[:redis][:conf_dir]}/redis.conf"
  user 'root'
end

  