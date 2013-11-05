#
# Author:: Chris Spicer (<code@cspicer.ca>)
# Cookbook Name:: minecraft-server
# Recipe:: bukkit
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "screen"
include_recipe "java::oracle"

# Minecraft service init.d template
template "/etc/init.d/minecraft" do
  source "minecraft_service.erb"
  mode 0755
end

# Enable and start Minecraft service
service "minecraft" do
  service_name "minecraft"
  restart_command "/usr/sbin/service minecraft restart"
  reload_command "/usr/sbin/service minecraft reload"
  supports [ :restart, :reload ]
  action [ :enable, :start ]
end

# Create minecraft server user
user "minecraft" do
   username node[:minecraft][:user]
#  comment "Minecraft user"
   home "/home/#{node[:minecraft][:user]}"
   shell "/bin/bash"
   supports :manage_home => true
end

# Create server directory
directory "#{node[:minecraft][:server_dir]}" do
  owner node[:minecraft][:user]
  group node[:minecraft][:user]
  mode '0755'
  action :create
end

# Create server plugins directory
directory "#{node[:minecraft][:server_dir]}/plugins/" do
  owner node[:minecraft][:user]
  group node[:minecraft][:user]
  mode '0755'
  action :create
end

# Download latest Bukkit Recommended Build (only if not exist/updated)
remote_file "#{node[:minecraft][:server_dir]}/craftbukkit-dev.jar" do
  owner node[:minecraft][:user]
  group node[:minecraft][:user]
  mode 0644
  source "#{node[:minecraft][:bukkit][:bukkit_url]}"
  action :nothing
  notifies :restart, resources(:service => "minecraft")
end

http_request "HEAD #{node[:minecraft][:bukkit][:bukkit_url]}" do
  message ""
  url "#{node[:minecraft][:bukkit][:bukkit_url]}"
  action :head
  if File.exists?("#{node[:minecraft][:server_dir]}/craftbukkit-dev.jar")
    headers "If-Modified-Since" => File.mtime("#{node[:minecraft][:server_dir]}/craftbukkit-dev.jar").httpdate
  end
  notifies :create, resources(:remote_file => "#{node[:minecraft][:server_dir]}/craftbukkit-dev.jar"), :immediately
end

# Vanilla server settings
template "#{node[:minecraft][:server_dir]}/server.properties" do
  source "server_properties.erb"
  owner node[:minecraft][:user]
  group node[:minecraft][:user]
  mode 0755
end

# Server ops
ops_databag = {'users' => {'name' => 'egray2'}}
ops_user_list = Array.new
ops_user_list << ops_databag['users']['name']

template "#{node[:minecraft][:server_dir]}/ops.txt" do
  source "ops.erb"
  owner node[:minecraft][:user]
  group node[:minecraft][:user]
  mode 0755
  variables(:ops => ops_user_list)
end

# Bukkit settings
template "#{node[:minecraft][:server_dir]}/bukkit.yml" do
  source "bukkit.erb"
  owner node[:minecraft][:user]
  group node[:minecraft][:user]
  mode 0755
end

# Bukkit permissions
template "#{node[:minecraft][:server_dir]}/permissions.yml" do
  source "permissions.erb"
  owner node[:minecraft][:user]
  group node[:minecraft][:user]
  mode 0755
end

template "#{node[:minecraft][:server_dir]}/start.sh" do
  source "serverstart.erb"
  owner node[:minecraft][:user]
  group node[:minecraft][:user]
  mode 0777
end


# Symlink craftbukkit.jar to server.jar
link "#{node[:minecraft][:server_dir]}/server.jar" do
  to "#{node[:minecraft][:server_dir]}/craftbukkit-dev.jar"
end

# Enable plugins as defined by attributes
node['minecraft']['bukkit']['default_plugins'].each do |plugin|
  recipe_name = plugin =~ /^plugin_/ ? plugin : "plugin_#{plugin}"
  include_recipe "minecraft-server::#{recipe_name}"
end

execute "/home/minecraft/start.sh" do
	command "#{node[:minecraft][:server_dir]}/start.sh"
	user "#{node[:minecraft][:user]}"
	action :run
end
