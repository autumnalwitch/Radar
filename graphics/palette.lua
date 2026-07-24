local Palette = {}


--------------------------------------------------
-- Radar palette
--------------------------------------------------

-- We use the 16 CC colours as brightness levels.
-- Each colour is redefined to be a shade of green.

local levels =
{
    colors.black,
    colors.gray,
    colors.lightGray,
    colors.green,
    colors.lime,

    colors.white,

    -- extra slots will be filled dynamically
}



--------------------------------------------------
-- Build phosphor green palette
--------------------------------------------------

function Palette.setup(monitor)

    for i = 0, 15 do

        local brightness = i / 15


        -- Slightly warm CRT green
        local r =
            0.02 * brightness

        local g =
            0.65 * brightness +
            0.05

        local b =
            0.02 * brightness


        local colour =
            2 ^ i


        monitor.setPaletteColour(
            colour,
            r,
            g,
            b
        )

    end

end



--------------------------------------------------
-- Convert energy to colour
--------------------------------------------------

function Palette.fromEnergy(energy)

    if energy <= 0 then
        return colors.black
    end


    if energy >= 1 then
        return colors.white
    end


    local level =
        math.floor(
            energy * 15
        )


    if level < 0 then
        level = 0
    end


    if level > 15 then
        level = 15
    end


    return 2 ^ level

end



--------------------------------------------------
-- Optional: direct brightness lookup
--------------------------------------------------

function Palette.level(value)

    value =
        math.max(
            0,
            math.min(
                15,
                math.floor(value)
            )
        )

    return 2 ^ value

end



return Palette