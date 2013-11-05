Description
===========
Installs and configures a [Minecraft](http://minecraft.net) server. Recipes are included for the vanilla (Mojang) written server, as well as the [Bukkit](http://bukkit.org) open source server and it's various [plugins](http://dev.bukkit.org/server-mods/). Plugins are managed similar to the Apache cookbook - the Bukkit recipe will install all plugins specified in the node attribute `default_plugins` which can be specified in a role. 

Requirements
============
Platform
--------

* Debian, Ubuntu

Tested on:

* Debian 6 (Squeeze)

Cookbooks
---------

* screen
* java

Attributes
==========

**General settings**  
* `node['minecraft']['server_dir']`   - Location of the minecraft server directory.  
* `node['minecraft']['user']`         - User to run the server as. Default is 'minecraft'.  

**Server-specific settings**  
* `node['minecraft']['server_ip']`    - Server IP address  
* `node['minecraft']['server_port']`  - Port to run server on  
* `node['minecraft']['min_mem']`      - Minimum amount of memory to assign to server process  
* `node['minecraft']['max_mem']`      - Maximum amount of memory to assign to server process  
* `node['minecraft']['max_players']`  - Maximum number of players to allow on the server at one time  
* `node['minecraft']['rcon']`         - Enable/Disable rcon  
* `node['minecraft']['snooper']`      - Enable/Disable snooper  
* `node['minecraft']['online_mode']`  - Enable/Disable online mode  
* `node['minecraft']['white_list']`   - Enable/Disable server login whitelist  
* `node['minecraft']['motd']`         - Server MOTD  
* `node['minecraft']['ops']`          - List of users with ops privileges  

**Game options**  
* `node['minecraft']['main_world']`           - Name of the primary world file  
* `node['minecraft']['nether']`               - Enable/Disable nether  
* `node['minecraft']['level_seed']`           - Set world seed to this string  
* `node['minecraft']['allow_flight']`         - Enable/Disable flight  
* `node['minecraft']['pvp']`                  - Enable/Disable pvp  
* `node['minecraft']['difficulty']`           - Set server difficulty  
* `node['minecraft']['game_mode']`            - Set server game mode  
* `node['minecraft']['spawn_animals']`        - Enable/Disable animal spawning  
* `node['minecraft']['spawn_npcs']`           - Enable/Disable npc spawning  
* `node['minecraft']['spawn_monsters']`       - Enable/Disable monster mob spawning   
* `node['minecraft']['generate_structures']`  - Enable/Disable structure generation  

**Bukkit**  
* `node['minecraft']['bukkit']['use_bukkit']`       - Deploy bukkit server instead of vanilla  
* `node['minecraft']['bukkit']['default_plugins']`  - Default plugin recipes to install with bukkit

License and Author
==================

Author:: Chris Spicer (code@cspicer.ca)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
