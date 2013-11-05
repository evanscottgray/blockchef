#
# Cookbook Name:: minecraft-server
# Recipe:: worldborder 
#

include_recipe "minecraft-server::bukkit"

# Plugin path, file permissions and remote URI (see below)
remote_file "#{node[:minecraft][:server_dir]}/plugins/WorldBorder.jar" do
  owner node[:minecraft][:user]
  group node[:minecraft][:user]
  mode 0644
  source "http://dev.bukkit.org/media/files/583/607/WorldBorder.jar"
  action :nothing
end

# Only run above if file does not exist or has changed
http_request "HEAD #{'http://dev.bukkit.org/media/files/583/607/WorldBorder.jar'}" do
  message ""
  url 'http://dev.bukkit.org/media/files/583/607/WorldBorder.jar'
  action :head
  if File.exists?("#{node[:minecraft][:server_dir]}/plugins/WorldBorder.jar")
    headers "If-Modified-Since" => File.mtime("#{node[:minecraft][:server_dir]}/plugins/WorldBorder.jar").httpdate
  end
  notifies :create, resources(:remote_file => "#{node[:minecraft][:server_dir]}/plugins/WorldBorder.jar"), :immediately
end