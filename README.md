Hi
This are some scripts I often use to start my little projects.
Some of them are really helpfull and probalby you want also use them.
Feel free!

## Basics
As memory is limited on nodemcu, I compile all my lua scripts when starting init.lua.
This means if I call a script with dofile, I always use .lc ... just keep in mind.

## Depencies
Most of the time, I work with NodeMCU firmware from master branch at github.
There is a handy online firmware build service at [frightanic.com](http://frightanic.com/nodemcu-custom-build).
Do not forget to include the needed modules for your project. eg adc, dth11, ...

## wifisetup.lua
What it does:
* configure wifi for Station mode
* try to start up Station mode
* if Station mode not suceeded after 10 seconds, fallback to AP mode
* start different scripts for Station or AP mode

