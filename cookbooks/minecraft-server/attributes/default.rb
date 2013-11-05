#
# Author:: Chris Spicer (<code@cspicer.ca>)
# Cookbook Name:: minecraft-server
# Attributes:: default
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

# General settings
default['minecraft']['user'] = "minecraft"
default['minecraft']['server_dir'] = "/home/minecraft/server/"

# Server specific settings
default['minecraft']['server_ip'] = ""
default['minecraft']['server_port'] = "25565"
default['minecraft']['min_mem'] = "1024M"
default['minecraft']['max_mem'] = "1024M"
default['minecraft']['max_players'] = "15"
default['minecraft']['rcon'] = false
default['minecraft']['snooper'] = false
default['minecraft']['online_mode'] = true
default['minecraft']['white_list'] = false
default['minecraft']['motd'] = "A minecraft server"

# Game options
default['minecraft']['main_world'] = "spawn"
default['minecraft']['nether'] = true
default['minecraft']['level_seed'] = ""
default['minecraft']['allow_flight'] = false
default['minecraft']['pvp'] = false
default['minecraft']['difficulty'] = "1"
default['minecraft']['game_mode'] = "0"
default['minecraft']['spawn_animals'] = true
default['minecraft']['spawn_npcs'] = true
default['minecraft']['spawn_monsters'] = true
default['minecraft']['generate_structures'] = true

# Bukkit
default['minecraft']['bukkit']['use_bukkit'] = true
default['minecraft']['bukkit']['bukkit_url'] = "http://dl.bukkit.org/latest-rb/craftbukkit.jar"
default['minecraft']['bukkit']['default_plugins'] = %w{
  jsonapi
}

# minecraft-overviewer
default['minecraft']['overviewer']['config_path'] = "/home/minecraft/server/"
default['minecraft']['overviewer']['terrain_path'] = "/home/minecraft/server/"
default['minecraft']['overviewer']['world_dir'] = "/home/minecraft/server/"
default['minecraft']['overviewer']['output_dir'] = "/home/minecraft/map/"

# minecraft-overviewer nginx
default['minecraft']['overviewer']['server_name'] = "minecraft"
default['minecraft']['overviewer']['port'] = "80"
default['minecraft']['overviewer']['public_dir'] = "/srv/www/public/map/"