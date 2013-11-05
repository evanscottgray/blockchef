#
# Cookbook Name:: minecraft-server
# Recipe:: flight 
#

include_recipe "minecraft-server::bukkit"

# Plugin path, file permissions and remote URI (see below)
remote_file "#{node[:minecraft][:server_dir]}/plugins/Flight.jar" do
  owner node[:minecraft][:user]
  group node[:minecraft][:user]
  mode 0644
  source "http://dev.bukkit.org/media/files/613/882/Flight.jar"
  action :nothing
end

# Only run above if file does not exist or has changed
http_request "HEAD #{'http://dev.bukkit.org/media/files/613/882/Flight.jar'}" do
  message ""
  url 'http://dev.bukkit.org/media/files/613/882/Flight.jar'
  action :head
  if File.exists?("#{node[:minecraft][:server_dir]}/plugins/Flight.jar")
    headers "If-Modified-Since" => File.mtime("#{node[:minecraft][:server_dir]}/plugins/Flight.jar").httpdate
  end
  notifies :create, resources(:remote_file => "#{node[:minecraft][:server_dir]}/plugins/Flight.jar"), :immediately
end