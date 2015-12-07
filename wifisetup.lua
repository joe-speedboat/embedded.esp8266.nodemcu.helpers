

-- read wifi config file and load vars and start wifi in station mode 
local cfg = {}
local wlan = {}
file.open("wlan.cfg", "r")
repeat 
   cfg.line = file.readline()
   cfg.line = string.sub(cfg.line, 1, -2) --remove line break chars
   if string.find(cfg.line, '=') then
      cfg.var = string.gsub(cfg.line, '=.*', '', 1)
      cfg.val = string.gsub(cfg.line, '.*=', '', 1)
      wlan[cfg.var]=cfg.val
      print("wlan."..cfg.var.." = "..cfg.val)
   end
until not string.find(cfg.line, '=')
file.close()

-- start wifi in station mode 
if not wlan.ssid then wlan.ssid = "ESP-"..node.chipid() end
if not wlan.pw then wlan.pw = "" end
SSID = wlan.ssid
wifi.setmode(1)
wifi.sta.config(wlan.ssid, wlan.pw, 1)
if wlan.ip then 
   print("Set Static IP: "..wlan.ip)
   cfg = { ip=wlan.ip, netmask=wlan.netmask, gateway=wlan.gateway }
   wifi.sta.setip(cfg)
   net.dns.setdnsserver(wlan.dns)
end

-- check if station mode succeeded or fallback to AP mode 
local wificount = 0
local wifimax = 10
tmr.alarm(0, 1000, 1, function() -- wait 6 second to join WiFi
   if not wifi.sta.getip() then
      if (wificount > wifimax) then
         print('WiFi station mode not succeeded after 6 seconds, starting AP Mode now') -- falling back to AP mode -------
         wifi.setmode(2)
         cfg={}
         cfg.ssid="ESP-"..node.chipid()
         wifi.ap.config(cfg)
         SSID = cfg.ssid
         tmr.stop(0)
         dofile("httpserver.lc")(80)
         wificount = nil
         wifimax = nil
      else
         print("Waiting for wifi to settle up:"..wificount)
         wificount = wificount + 1
      end
   else 
      tmr.stop(0)
      net.dns.setdnsserver("8.8.4.4", 1) -- set secondary dns for safety
      dofile("httpserver.lc")(80)
      wificount = nil
      wifimax = nil
   end
end)

cfg = nil
wlan = nil
collectgarbage()
print('END of wifisetup.lua')
