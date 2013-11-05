#
# Cookbook Name:: minecraft-server
# Recipe:: tcp 
#

include_recipe "minecraft-server::bukkit"

# Plugin path, file permissions and remote URI (see below)
remote_file "#{node[:minecraft][:server_dir]}/plugins/TPC.jar" do
  owner node[:minecraft][:user]
  group node[:minecraft][:user]
  mode 0644
  source "http://dev.bukkit.org/media/files/565/411/TPC.jar"
  action :nothing
end

# Only run above if file does not exist or has changed
http_request "HEAD #{'http://dev.bukkit.org/media/files/565/411/TPC.jar'}" do
  message ""
  url 'http://dev.bukkit.org/media/files/565/411/TPC.jar'
  action :head
  if File.exists?("#{node[:minecraft][:server_dir]}/plugins/TPC.jar")
    headers "If-Modified-Since" => File.mtime("#{node[:minecraft][:server_dir]}/plugins/TPC.jar").httpdate
  end
  notifies :create, resources(:remote_file => "#{node[:minecraft][:server_dir]}/plugins/TPC.jar"), :immediately
end