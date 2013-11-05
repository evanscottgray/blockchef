#
# Cookbook Name:: minecraft-server
# Recipe:: lockette 
#

include_recipe "minecraft-server::bukkit"

# Plugin path, file permissions and remote URI (see below)
remote_file "#{node[:minecraft][:server_dir]}/plugins/Lockette.jar" do
  owner node[:minecraft][:user]
  group node[:minecraft][:user]
  mode 0644
  source "http://members.shaw.ca/acru/Lockette.jar"
  action :nothing
end

# Only run above if file does not exist or has changed
http_request "HEAD #{'http://members.shaw.ca/acru/Lockette.jar'}" do
  message ""
  url 'http://members.shaw.ca/acru/Lockette.jar'
  action :head
  if File.exists?("#{node[:minecraft][:server_dir]}/plugins/Lockette.jar")
    headers "If-Modified-Since" => File.mtime("#{node[:minecraft][:server_dir]}/plugins/Lockette.jar").httpdate
  end
  notifies :create, resources(:remote_file => "#{node[:minecraft][:server_dir]}/plugins/Lockette.jar"), :immediately
end