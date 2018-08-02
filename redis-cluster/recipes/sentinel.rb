#
# Cookbook:: redis-cluster
# Recipe:: sentinel
#
# Copyright:: 2018, The Authors, All Rights Reserved.


# Install redis_server
package 'redis-sentinel'



template "#{node[:redis][:conf_dir]}/sentinel.conf" do
  source        "sentinel.erb"
  owner         "root"
  group         "root"
  mode          "0644"
  variables     :sentinel_port => default[:sentinel][:sentinel_port], :port => node[:redis][:server][:port], :master_name => node[:sentinel][:master_name], :redis => node[:redis]
end

execute 'redis-sentinel-run' do
  command "redis-sentinel #{node[:redis][:conf_dir]}/sentinel.conf"
  user 'root'
end


