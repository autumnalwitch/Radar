local Framebuffer = {}
Framebuffer.__index = Framebuffer


--------------------------------------------------
-- Create a new framebuffer
--------------------------------------------------

function Framebuffer.new(width, height)

    local self = setmetatable({}, Framebuffer)

    self.width = width
    self.height = height

    self.pixels = {}

    for y = 1, height do

        self.pixels[y] = {}

        for x = 1, width do
            self.pixels[y][x] = 0
        end

    end

    return self

end



--------------------------------------------------
-- Clear everything
--------------------------------------------------

function Framebuffer:clear()

    for y = 1, self.height do

        for x = 1, self.width do

            self.pixels[y][x] = 0

        end

    end

end



--------------------------------------------------
-- Add energy to a pixel
--------------------------------------------------

function Framebuffer:add(x, y, amount)

    x = math.floor(x)
    y = math.floor(y)

    if x < 1 or x > self.width then
        return
    end

    if y < 1 or y > self.height then
        return
    end


    self.pixels[y][x] =
        math.min(
            1,
            self.pixels[y][x] + amount
        )

end



--------------------------------------------------
-- Set a pixel directly
--------------------------------------------------

function Framebuffer:set(x, y, value)

    x = math.floor(x)
    y = math.floor(y)

    if x < 1 or x > self.width then
        return
    end

    if y < 1 or y > self.height then
        return
    end


    self.pixels[y][x] =
        math.max(
            0,
            math.min(
                1,
                value
            )
        )

end



--------------------------------------------------
-- Read a pixel
--------------------------------------------------

function Framebuffer:get(x, y)

    if x < 1 or x > self.width then
        return 0
    end

    if y < 1 or y > self.height then
        return 0
    end

    return self.pixels[y][x]

end



--------------------------------------------------
-- Apply phosphor decay
--------------------------------------------------

function Framebuffer:decay(rate)

    for y = 1, self.height do

        for x = 1, self.width do

            self.pixels[y][x] =
                self.pixels[y][x] * rate


            -- remove tiny floating point leftovers

            if self.pixels[y][x] < 0.01 then
                self.pixels[y][x] = 0
            end

        end

    end

end



--------------------------------------------------
-- Iterate over pixels
--------------------------------------------------

function Framebuffer:each(callback)

    for y = 1, self.height do

        for x = 1, self.width do

            callback(
                x,
                y,
                self.pixels[y][x]
            )

        end

    end

end



return Framebuffer