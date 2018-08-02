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