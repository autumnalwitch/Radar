local Renderer = {}
Renderer.__index = Renderer

function Renderer.new(mon, bg)
    local self = setmetatable({}, Renderer)

    self.mon = mon
    self.bg = bg or colors.black

    self.w, self.h = mon.getSize()

    self.current = {}
    self.previous = {}

    for y = 1, self.h do
        self.current[y] = {}
        self.previous[y] = {}

        for x = 1, self.w do
            self.current[y][x] = self.bg
            self.previous[y][x] = -1 -- force first draw
        end
    end

    mon.setBackgroundColour(self.bg)
    mon.clear()

    return self
end

function Renderer:width()
    return self.w
end

function Renderer:height()
    return self.h
end

function Renderer:clear(colour)
    colour = colour or self.bg

    for y = 1, self.h do
        local row = self.current[y]

        for x = 1, self.w do
            row[x] = colour
        end
    end
end

function Renderer:setPixel(x, y, colour)

    x = math.floor(x + 0.5)
    y = math.floor(y + 0.5)

    if x < 1 or x > self.w then return end
    if y < 1 or y > self.h then return end

    self.current[y][x] = colour
end

function Renderer:present()

    local mon = self.mon

    for y = 1, self.h do

        local runColour = nil
        local runStart = 1
        local runLength = 0

        for x = 1, self.w + 1 do

            local colour

            if x <= self.w then
                colour = self.current[y][x]
            end

            if colour ~= runColour then

                if runColour ~= nil then

                    local changed = false

                    for i = runStart, runStart + runLength - 1 do
                        if self.previous[y][i] ~= runColour then
                            changed = true
                            break
                        end
                    end

                    if changed then
                        mon.setCursorPos(runStart, y)
                        mon.setBackgroundColour(runColour)
                        mon.write(string.rep(" ", runLength))

                        for i = runStart, runStart + runLength - 1 do
                            self.previous[y][i] = runColour
                        end
                    end
                end

                runColour = colour
                runStart = x
                runLength = 1

            else
                runLength = runLength + 1
            end

        end
    end
end

return Renderer