#
# Cookbook Name:: minecraft-server
# Recipe:: cleanroom 
#

include_recipe "minecraft-server::bukkit"

plugin_url = "http://dev.bukkit.org/media/files/584/81/CleanroomGenerator.jar"

# Plugin path, file permissions and remote URI (see below)
remote_file "#{node[:minecraft][:server_dir]}/plugins/CleanroomGenerator.jar" do
  owner node[:minecraft][:user]
  group node[:minecraft][:user]
  mode 0644
  source "#{plugin_url}"
  action :nothing
end

# Only run above if file does not exist or has changed
http_request "HEAD #{plugin_url}" do
  message ""
  url "#{plugin_url}"
  action :head
  if File.exists?("#{node[:minecraft][:server_dir]}/plugins/CleanroomGenerator.jar")
    headers "If-Modified-Since" => File.mtime("#{node[:minecraft][:server_dir]}/plugins/CleanroomGenerator.jar").httpdate
  end
  notifies :create, resources(:remote_file => "#{node[:minecraft][:server_dir]}/plugins/CleanroomGenerator.jar"), :immediately
end