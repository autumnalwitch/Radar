return {
    -- Monitor
    monitorSide = nil,        -- nil = peripheral.find("monitor")
    textScale = 0.5,

    -- Appearance
    background = colors.black,
    radarColour = colors.green,
    sweepColour = colors.lime,

    -- Geometry
    ringCount = 4,
    borderPadding = 2,

    -- Animation
    sweepTime = 10.0,         -- seconds per revolution
    fps = 20,

    -- Phosphor
    staticBrightness = 0.15,
    decayRate = 0.94,

    -- Contacts
    contactFade = 0.985,

    -- Audio
    pingEnabled = true,
    pingFile = "assets/ping.dfpwm",
    pingVolume = 1.0
}