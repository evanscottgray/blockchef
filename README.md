blockchef
=========

**craftmine...**_shamelessly stolen from like 5 other minecraft chef scripts on github..._

## how2use ##
1. have knife solo
2. have a server
3. knife solo prepare $USER@$SERVERIP
4. copy the relevant values from mc.evanscottgray.json to your $SERVERIP.json
5. knife solo cook $USER@$SERVERIP

***

### disclaimer ###

I borrowed pieces of this from all over and spent only a few minutes hacking it together. There were a few key changes that I had to make though...
- add a new start script, the old init style script didn't want to work
- change bukkit to the latest version, otherwise the minecraft client would barf
- hard code a few things here and there. perhaps someday I'll come back and fix it for those who want to use this
- also, I added a murmur (mumble) server to my config, you can have it too.
