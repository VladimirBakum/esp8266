-- Weather Station #1 init & setup Wi-Fi through enduser_setup
-- By (R)soft 4.10.2019 v2.11

function init_i2c_display()
  i2c.setup(0,6,5, i2c.SLOW)
  disp = u8g.sh1106_128x64_i2c(0x3c)
  disp:setFont(u8g.font_timB24)
  disp:setFontRefHeightExtendedText()
  disp:setDefaultForegroundColor()
end

init_i2c_display()
disp:firstPage()
repeat
  disp:drawStr(2, 26, "Setting" )
  disp:drawStr(8, 56, "Wi-Fi" )
until disp:nextPage() == false

print("Setting up Wi-Fi...")
wifi.setmode(wifi.STATIONAP)
wifi.ap.config({ssid='Weather Station #1 v2.11', pwd='12345678'})

enduser_setup.manual(true)
enduser_setup.start(
  function()
    print("Connected to wifi as:" .. wifi.sta.getip())
  end,
  function(err, str)
    print("enduser_setup: Err #" .. err .. ": " .. str)
  end)

tmr.alarm(1, 2000, 1, function() 
if wifi.sta.getip()== nil then 
  print("IP unavaiable, Waiting...") 
else 
  tmr.stop(1)
  print("Config done, IP is "..wifi.sta.getip())
--
  disp:firstPage()
  repeat
    disp:drawStr(2, 26, "Config" )
    disp:drawStr(8, 56, "Done!" )
  until disp:nextPage() == false
--
  if file.exists("sender211.lua") then
    dofile("sender211.lua")
  else 
    print("sender211.lua file exists")
  end
end
end)
