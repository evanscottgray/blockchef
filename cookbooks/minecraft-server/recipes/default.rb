#
# Author:: Chris Spicer (<code@cspicer.ca>)
# Cookbook Name:: minecraft-server
# Recipe:: default
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

user node[:minecraft][:user] do
  home node[:minecraft][:dir]
end

directory "#{node[:minecraft][:dir]}" do
  owner "#{node[:minecraft][:user]}"
  action :create
end

remote_file "#{node[:minecraft][:dir]}/minecraft_server.jar" do
  owner "#{node[:minecraft][:user]}"
  mode 0644
  source "http://s3.amazonaws.com/MinecraftDownload/launcher/minecraft_server.jar"
end

template "/etc/init.d/minecraft" do
  source "minecraft_service.erb"
  mode 0755
end

execute "starting minecraft server" do 
  command "/home/minecraft/start.sh"
  user "#{node[:minecraft][:user]}"
  action :run
end
