local cfg = require("config")
local Renderer = require("renderer")

local mon

if cfg.monitorSide then
    mon = peripheral.wrap(cfg.monitorSide)
else
    mon = peripheral.find("monitor")
end

assert(mon, "No monitor found")

mon.setTextScale(cfg.textScale)

local r = Renderer.new(mon, colors.black)

while true do

    r:clear()

    for y = 1, r:height() do
        r:setPixel(math.floor(r:width()/2), y, colors.green)
    end

    r:present()

    sleep(0.05)

end