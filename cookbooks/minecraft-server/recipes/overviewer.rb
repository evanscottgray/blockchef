#
# Author:: Chris Spicer (<code@cspicer.ca>)
# Cookbook Name:: minecraft-server
# Recipe:: overviewer
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

include_recipe "apt"
include_recipe "python"

# Add official minecraft-overviewer debian repository
apt_repository "minecraft-overviewer" do
  uri "http://overviewer.org/debian"
  components ["./"]
  action :add
end

# Install package
package "minecraft-overviewer" do
  options "--force-yes"
  action :install
end

# Create minecraft server user
user "minecraft" do
  username node[:minecraft][:user]
  comment "Minecraft user"
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

# Create output directory
directory "#{node[:minecraft][:overviewer][:output_dir]}" do
  owner "#{node[:minecraft][:user]}"
  group node[:minecraft][:user]
  mode '0755'
  action :create
end

# Copy overviewer config
render_list = Array.new
overviewer = data_bag("overviewer")
overviewer.each do |worlds|
  world = data_bag_item("overviewer", worlds)
  render_list << world
end

template "#{node[:minecraft][:server_dir]}/overviewer.cfg" do
  source "overviewer.erb"
  mode 0755
  variables(:worlds => render_list)
end