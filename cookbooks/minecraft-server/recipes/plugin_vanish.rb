#
# Cookbook Name:: minecraft-server
# Recipe:: vanish 
#

include_recipe "minecraft-server::bukkit"

# Plugin path, file permissions and remote URI (see below)
remote_file "#{node[:minecraft][:server_dir]}/plugins/VanishNoPacket.jar" do
  owner node[:minecraft][:user]
  group node[:minecraft][:user]
  mode 0644
  source "http://dev.bukkit.org/media/files/658/476/VanishNoPacket.jar"
  action :nothing
  notifies :reload, resources(:service => "minecraft")
end

# Only run above if file does not exist or has changed
http_request "HEAD #{'http://dev.bukkit.org/media/files/658/476/VanishNoPacket.jar'}" do
  message ""
  url 'http://dev.bukkit.org/media/files/658/476/VanishNoPacket.jar'
  action :head
  if File.exists?("#{node[:minecraft][:server_dir]}/plugins/VanishNoPacket.jar")
    headers "If-Modified-Since" => File.mtime("#{node[:minecraft][:server_dir]}/plugins/VanishNoPacket.jar").httpdate
  end
  notifies :create, resources(:remote_file => "#{node[:minecraft][:server_dir]}/plugins/VanishNoPacket.jar"), :immediately
end