#
# Cookbook:: redis-cluster
# Recipe:: sentinel
#
# Copyright:: 2018, The Authors, All Rights Reserved.


# Install redis_server
package 'redis-sentinel'



masterInstance = search("aws_opsworks_instance", "hostname:redishost").first
masteradress = "#{masterInstance['private_ip']}"
instance = search("aws_opsworks_instance", "self:true").first
slaveaddress = "#{instance['private_ip']}"



template "#{node[:redis][:conf_dir]}/sentinel.conf" do
  source        "sentinel.erb"
  owner         "root"
  group         "root"
  mode          "0644"
  variables     :sentinel_port => node[:sentinel][:sentinel_port], :master_name => node[:sentinel][:master_name], :redis => node[:redis], :ma = masteradress, :sla = slaveaddress
end

execute 'redis-sentinel-run' do
  command "redis-sentinel #{node[:redis][:conf_dir]}/sentinel.conf"
  user 'root'
end


