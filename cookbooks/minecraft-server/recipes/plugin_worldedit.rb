#
# Cookbook Name:: minecraft-server
# Recipe:: worldedit 
#

include_recipe "minecraft-server::bukkit"

# Plugin path, file permissions and remote URI (see below)
remote_file "#{node[:minecraft][:server_dir]}/plugins/worldedit.zip" do
  owner node[:minecraft][:user]
  group node[:minecraft][:user]
  mode 0644
  source "http://dev.bukkit.org/media/files/639/583/worldedit-5.4.3.zip"
  action :nothing
end

# Only run above if file does not exist or has changed
http_request "HEAD #{'http://dev.bukkit.org/media/files/639/583/worldedit-5.4.3.zip'}" do
  message ""
  url "http://dev.bukkit.org/media/files/639/583/worldedit-5.4.3.zip"
  action :head
  if File.exists?("#{node[:minecraft][:server_dir]}/plugins/worldedit.zip")
    headers "If-Modified-Since" => File.mtime("#{node[:minecraft][:server_dir]}/plugins/worldedit.zip").httpdate
  end
  notifies :create, resources(:remote_file => "#{node[:minecraft][:server_dir]}/plugins/worldedit.zip"), :immediately
end

# Unzip compressed plugin archive (skip help docs)
execute "unzip-plugin" do
  cwd "#{node[:minecraft][:server_dir]}/plugins/"
  user node[:minecraft][:user]
  group node[:minecraft][:user]
  command "unzip #{node[:minecraft][:server_dir]}/plugins/worldedit.zip -x *.txt *.html"
  creates "#{node[:minecraft][:server_dir]}/plugins/WorldEdit.jar"
  not_if do
    File.exists?("#{node[:minecraft][:server_dir]}/plugins/WorldEdit.jar")
  end
end