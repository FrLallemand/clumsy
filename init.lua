local clumsy = {}

battery = require("clumsy.battery")
volume = require("clumsy.volume")
brightness = require("clumsy.brightness")
memory = require("clumsy.memory")
bumblebee = require("clumsy.bumblebee")


local compteur = 1
local widgettable = {}

function clumsy.widget(wi, timing, color1, color2)
   local widget
   
   if wi == "battery" then widget = battery
   elseif wi == "volume" then widget = volume
   elseif wi == "brightness" then widget = brightness
   elseif wi == "memory"  then widget = memory
   elseif wi == "bumblebee"  then widget = bumblebee
   end

   if timing == nil then
	  timing = 5
   end

   if color1 then
	  widget.config.color1 = color1
   end

   if color2 then
	  widget.config.color2 = color2
	  widget.config.colortmp = color2
   end
   widgettable[compteur] = widget
   compteur=compteur+1
   return widget
end


function clumsy.update(widget)
   timing = 5
   mytimer = timer({timeout = timing})
   
   for count = 1, #widgettable do
	  
	  widgettable[count].update(widgettable[count])
	  
	  mytimer:connect_signal("timeout", function() widgettable[count].update(widgettable[count]) end)
	  mytimer:start()
   end
   
end


return clumsy



