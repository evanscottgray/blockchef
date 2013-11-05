#
# Cookbook Name:: minecraft-server
# Recipe:: irctransport 
#

include_recipe "minecraft-server::bukkit"

# Set plugin-specific attributes
node.default["minecraft"]["bukkit"]['irctransport']['irc_server'] = "localhost"
node.default["minecraft"]["bukkit"]['irctransport']['irc_port'] = "6667"
node.default["minecraft"]["bukkit"]['irctransport']['channel'] = "#minecraft"

# Create server plugins directory
directory "#{node[:minecraft][:server_dir]}/plugins/" do
  owner node[:minecraft][:user]
  group node[:minecraft][:user]
  mode '0755'
  action :create
end

# Create specific plugin config directory
directory "#{node[:minecraft][:server_dir]}/plugins/IRCTransport/" do
  owner node[:minecraft][:user]
  group node[:minecraft][:user]
  mode '0755'
  action :create
end

# Copy plugin config
template "#{node[:minecraft][:server_dir]}/plugins/IRCTransport/config.yml" do
  source "irctransport_config.erb"
  owner node[:minecraft][:user]
  group node[:minecraft][:user]
  mode 0755
end

# Plugin path, file permissions and remote URI (see below)
remote_file "#{node[:minecraft][:server_dir]}/plugins/IRCTransport.jar" do
  owner node[:minecraft][:user]
  group node[:minecraft][:user]
  mode 0644
  source "https://github.com/downloads/hef/IRCTransport/IRCTransport-0.13.0.jar"
  action :nothing
end

# Only run above if file does not exist or has changed
http_request "HEAD #{'https://github.com/downloads/hef/IRCTransport/IRCTransport-0.13.0.jar'}" do
  message ""
  url 'https://github.com/downloads/hef/IRCTransport/IRCTransport-0.13.0.jar'
  action :head
  if File.exists?("#{node[:minecraft][:server_dir]}/plugins/IRCTransport.jar")
    headers "If-Modified-Since" => File.mtime("#{node[:minecraft][:server_dir]}/plugins/IRCTransport.jar").httpdate
  end
  notifies :create, resources(:remote_file => "#{node[:minecraft][:server_dir]}/plugins/IRCTransport.jar"), :immediately
end

