#
# Cookbook:: redis-cluster
# Recipe:: sentinel
#
# Copyright:: 2018, The Authors, All Rights Reserved.


# Install redis_server
package 'redis-sentinel'


sentinel_port = 0
template "#{node[:redis][:conf_dir]}/sentinel.conf" do
  source        "sentinel.erb"
  owner         "root"
  group         "root"
  mode          "0644"
  variables     :sentinel_port => sentinel_port, :port => node[:redis][:server][:port], :master_name => node[:sentinel][:master_name], :redis => node[:redis]
end

execute 'redis-sentinel-run' do
  command "redis-sentinel #{node[:redis][:conf_dir]}/sentinel.conf"
  user 'root'
end


# node[:redis][:ports].each do |port|

#   sentinel_port = 20000 + port.to_i
#   node.default[:redis][:server][:port] = port
#   node.default[:sentinel][:master_name] = "slave-#{port}"

#   template "#{node[:redis][:conf_dir]}/sentinel#{port}.conf" do
#     source        "sentinel.erb"
#     owner         "root"
#     group         "root"
#     mode          "0644"
#     variables     :sentinel_port => sentinel_port, :port => node[:redis][:server][:port], :master_name => node[:sentinel][:master_name]
#   end

#   execute 'redis-sentinel-run' do
#     command "redis-sentinel #{node[:redis][:conf_dir]}/sentinel#{port}.conf"
#     user 'root'
#   end
# end
