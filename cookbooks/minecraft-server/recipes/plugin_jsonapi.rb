#
# Cookbook Name:: minecraft-server
# Recipe:: jsonapi 
#

include_recipe "minecraft-server::bukkit"

# Plugin path, file permissions and remote URI (see below)
remote_file "#{node[:minecraft][:server_dir]}/plugins/JSONAPI.jar" do
  owner node[:minecraft][:user]
  group node[:minecraft][:user]
  mode 0644
  source "http://mcjsonapi.com/version/latest/"
  action :nothing
end

# Only run above if file does not exist or has changed
http_request "HEAD #{'http://mcjsonapi.com/version/latest/'}" do
  message ""
  url 'http://mcjsonapi.com/version/latest/'
  action :head
  if File.exists?("#{node[:minecraft][:server_dir]}/plugins/JSONAPI.jar")
    headers "If-Modified-Since" => File.mtime("#{node[:minecraft][:server_dir]}/plugins/JSONAPI.jar").httpdate
  end
  notifies :create, resources(:remote_file => "#{node[:minecraft][:server_dir]}/plugins/JSONAPI.jar"), :immediately
end