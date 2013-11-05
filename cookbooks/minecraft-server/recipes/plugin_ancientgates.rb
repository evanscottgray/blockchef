#
# Cookbook Name:: minecraft-server
# Recipe:: ancientgates
#

include_recipe "minecraft-server::bukkit"

# Plugin path, file permissions and remote URI (see below)
remote_file "#{node[:minecraft][:server_dir]}/plugins/Ancient_Gates.jar" do
  owner node[:minecraft][:user]
  group node[:minecraft][:user]
  mode 0644
  source "http://dev.bukkit.org/media/files/634/376/Ancient_Gates.jar"
  action :nothing
end

# Only run above if file does not exist or has changed
http_request "HEAD #{'http://dev.bukkit.org/media/files/634/376/Ancient_Gates.jar'}" do
  message ""
  url 'http://dev.bukkit.org/media/files/634/376/Ancient_Gates.jar'
  action :head
  if File.exists?("#{node[:minecraft][:server_dir]}/plugins/Multiverse-Core.jar")
    headers "If-Modified-Since" => File.mtime("#{node[:minecraft][:server_dir]}/plugins/Ancient_Gates.jar").httpdate
  end
  notifies :create, resources(:remote_file => "#{node[:minecraft][:server_dir]}/plugins/Ancient_Gates.jar"), :immediately
end