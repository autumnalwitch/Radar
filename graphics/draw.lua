local Draw = {}


--------------------------------------------------
-- Utility
--------------------------------------------------

local function clamp(value, low, high)

    if value < low then
        return low
    end

    if value > high then
        return high
    end

    return value

end



--------------------------------------------------
-- Anti-aliased point
--------------------------------------------------

function Draw.point(fb, x, y, energy)

    local ix = math.floor(x)
    local iy = math.floor(y)

    local fx = x - ix
    local fy = y - iy


    -- distribute energy over four pixels

    fb:add(
        ix,
        iy,
        energy *
        (1-fx) *
        (1-fy)
    )


    fb:add(
        ix+1,
        iy,
        energy *
        fx *
        (1-fy)
    )


    fb:add(
        ix,
        iy+1,
        energy *
        (1-fx) *
        fy
    )


    fb:add(
        ix+1,
        iy+1,
        energy *
        fx *
        fy
    )

end



--------------------------------------------------
-- Anti-aliased circle
--------------------------------------------------

function Draw.circle(
    fb,
    cx,
    cy,
    radius,
    thickness,
    energy
)


    thickness =
        thickness or 1


    energy =
        energy or 0.2



    local minX =
        math.floor(
            cx-radius-thickness
        )

    local maxX =
        math.ceil(
            cx+radius+thickness
        )


    local minY =
        math.floor(
            cy-radius-thickness
        )

    local maxY =
        math.ceil(
            cy+radius+thickness
        )



    for y=minY,maxY do

        for x=minX,maxX do


            local dx =
                x-cx

            local dy =
                y-cy


            local distance =
                math.sqrt(
                    dx*dx+
                    dy*dy
                )


            local difference =
                math.abs(
                    distance-radius
                )


            local intensity =
                1 -
                (difference/thickness)


            if intensity > 0 then

                Draw.point(
                    fb,
                    x,
                    y,
                    energy*intensity
                )

            end

        end

    end

end



--------------------------------------------------
-- Anti-aliased line
--------------------------------------------------

function Draw.line(
    fb,
    x1,
    y1,
    x2,
    y2,
    energy,
    width
)


    width =
        width or 1


    local dx =
        x2-x1

    local dy =
        y2-y1


    local distance =
        math.sqrt(
            dx*dx+
            dy*dy
        )


    local steps =
        math.ceil(
            distance
        )


    if steps == 0 then
        return
    end



    for i=0,steps do


        local t =
            i/steps


        local x =
            x1 + dx*t


        local y =
            y1 + dy*t



        for ox=-width,width do

            for oy=-width,width do


                local falloff =
                    1 /
                    (
                        1 +
                        math.abs(ox)+
                        math.abs(oy)
                    )


                Draw.point(
                    fb,
                    x+ox,
                    y+oy,
                    energy*falloff
                )

            end

        end

    end

end



--------------------------------------------------
-- Filled circle (contacts)
--------------------------------------------------

function Draw.filledCircle(
    fb,
    cx,
    cy,
    radius,
    energy
)


    for y=-radius,radius do

        for x=-radius,radius do


            local distance =
                math.sqrt(
                    x*x+y*y
                )


            if distance <= radius then

                local falloff =
                    1 -
                    (distance/radius)


                Draw.point(
                    fb,
                    cx+x,
                    cy+y,
                    energy*falloff
                )

            end

        end

    end

end



return Draw