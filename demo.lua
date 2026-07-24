local Framebuffer = require("graphics.framebuffer")
local Palette = require("graphics.palette")
local Renderer = require("graphics.renderer")
local Draw = require("graphics.draw")


--------------------------------------------------
-- Monitor setup
--------------------------------------------------

local monitor =
    peripheral.find("monitor")

if not monitor then
    error("No monitor found")
end


monitor.setTextScale(0.5)


--------------------------------------------------
-- Initialise graphics
--------------------------------------------------

Palette.setup(monitor)


local width, height =
    monitor.getSize()


local framebuffer =
    Framebuffer.new(
        width,
        height
    )


local renderer =
    Renderer.new(
        monitor,
        Palette
    )



--------------------------------------------------
-- Radar geometry
--------------------------------------------------

local cx =
    width / 2

local cy =
    height / 2


local maxRadius =
    math.min(
        cx,
        cy
    ) - 2



--------------------------------------------------
-- Animation
--------------------------------------------------

local angle = 0


local sweepSpeed =
    (math.pi * 2) / 10
    -- 10 second rotation



--------------------------------------------------
-- Main loop
--------------------------------------------------

while true do


    --
    -- Draw static rings
    --

    Draw.circle(
        framebuffer,
        cx,
        cy,
        maxRadius,
        1,
        0.15
    )


    Draw.circle(
        framebuffer,
        cx,
        cy,
        maxRadius * 0.66,
        1,
        0.12
    )


    Draw.circle(
        framebuffer,
        cx,
        cy,
        maxRadius * 0.33,
        1,
        0.10
    )



    --
    -- Draw sweep
    --

    local sx =
        cx +
        math.cos(angle)
        *
        maxRadius


    local sy =
        cy +
        math.sin(angle)
        *
        maxRadius


    Draw.line(
        framebuffer,
        cx,
        cy,
        sx,
        sy,
        1,
        2
    )



    --
    -- Render
    --

    renderer:draw(
        framebuffer
    )


    --
    -- Phosphor decay
    --

    framebuffer:decay(
        0.94
    )


    angle =
        angle +
        sweepSpeed *
        0.05


    sleep(0.05)

end