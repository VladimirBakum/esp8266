print("Setting up Wi-Fi...")
wifi.setmode(wifi.STATION)
--modify according your wireless router settings
wifi.sta.config("SSID","Password")
wifi.sta.connect()
tmr.alarm(1, 1000, 1, function() 
if wifi.sta.getip()== nil then 
  print("IP unavaiable, Waiting...") 
else 
  tmr.stop(1)
  print("Config done, IP is "..wifi.sta.getip())
  dofile("sender.lua")
end
end)
