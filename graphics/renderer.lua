local Renderer = {}
Renderer.__index = Renderer


--------------------------------------------------
-- Create renderer
--------------------------------------------------

function Renderer.new(monitor, palette)

    local self =
        setmetatable({}, Renderer)


    self.monitor = monitor
    self.palette = palette


    self.width,
    self.height =
        monitor.getSize()


    self.previous = {}


    for y = 1, self.height do

        self.previous[y] = {}

        for x = 1, self.width do

            self.previous[y][x] =
                colors.black

        end

    end


    monitor.setBackgroundColour(
        colors.black
    )

    monitor.clear()


    return self

end



--------------------------------------------------
-- Render framebuffer
--------------------------------------------------

function Renderer:draw(framebuffer)


    local monitor = self.monitor
    local palette = self.palette


    for y = 1, self.height do


        for x = 1, self.width do


            local energy =
                framebuffer:get(
                    x,
                    y
                )


            local colour =
                palette.fromEnergy(
                    energy
                )


            if self.previous[y][x] ~= colour then


                monitor.setCursorPos(
                    x,
                    y
                )


                monitor.setBackgroundColour(
                    colour
                )


                monitor.write(" ")


                self.previous[y][x] =
                    colour

            end

        end

    end


end



return Renderer