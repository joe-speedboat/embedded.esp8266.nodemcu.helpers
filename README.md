Hi
This are some scripts I often use to start my little projects.
Some of them are really helpfull and probalby you want also use them.
Feel free!

Basics
------
As memory is limited on nodemcu, I compile all my lua scripts when starting init.lua.
This means if I call a script with dofile, I always use .lc ... just keep in mind.

wificonfig.lua
--------------
What it does:
* configure wifi for Station mode
* try to start up Station mode
* if Station mode not startet after 6 seconds, fallback to AP mode
* start different scripts for Station or AP mode

