
-- wifi config vars
local cfg = {}
local wlan = {}

wlan.ssid = "MYWLAN"
wlan.pw = "secret3"
wlan.dns2 = 8.8.4.4 -- fallback dns server

-- wlan.ip = 192.168.1.101
-- wlan.netmask = 255.255.255.0
-- wlan.gateway = 192.168.1.254
-- wlan.dns = 8.8.8.8

-- start wifi in station mode 
wifi.setmode(1)
wifi.sta.config(wlan.ssid, wlan.pw, 1)
if wlan.ip then -- if static ip is set
   print("Set Static IP: "..wlan.ip)
   cfg = { ip=wlan.ip, netmask=wlan.netmask, gateway=wlan.gateway }
   wifi.sta.setip(cfg)
   net.dns.setdnsserver(wlan.dns)
end

-- check if station mode succeeded or fallback to AP mode 
tmr.alarm(0, 6000, 0, function() -- wait 6 second to join WiFi
   if not wifi.sta.getip() then
      print('WiFi station mode not succeeded after 6 seconds, starting AP Mode now') -- falling back to AP mode
      wifi.setmode(2)
      cfg={}
      cfg.ssid="ESP-"..node.chipid()
      wifi.ap.config(cfg)
      dofile("telnet-server.lc")
   else 
      net.dns.setdnsserver(wlan.dns2, 1) -- set secondary dns for safety
      dofile("main-prog.lc")
   end
end)

cfg = nil
wlan = nil
collectgarbage()
print('END of wifisetup.lua')
