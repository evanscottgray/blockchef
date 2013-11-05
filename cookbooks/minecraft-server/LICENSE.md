Description
===========
Installs and configures a Minecraft server, either the vanilla server provided by [Mojang](http://minecraft.net/donwload) or a custom [Bukkit](http://bukkit.org) server including plugins.   

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

* `node['minecraft']['server_dir']` - Location of the minecraft server directory.
* `node['minecraft']['user']`       - User to run the server as. Default is 'minecraft'.

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
