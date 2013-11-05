maintainer       "Chris Spicer"
maintainer_email "code@cspicer.ca"
license          "All rights reserved"
description      "Installs/configures a Minecraft server"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"
recipe           "minecraft-server", "Installs a minecraft server"

%w{ screen java }.each do |cb|
  depends cb
end

%w{ debian ubuntu }.each do |os|
  supports os
end
