local user = "autumnalwitch"
local repo = "radar"
local branch = "main"

local files = {
    "main.lua",
    "config.lua",
    "graphics/framebuffer.lua",
    "graphics/palette.lua",
    "graphics/renderer.lua",
    "graphics/draw.lua",
    "radar/contacts.lua",
    "radar/engine.lua",
    "radar/sweep.lua",
    "audio/ping.lua",
    "startup.lua",
    "assets/radar.dfpwm",
    "demo.lua"
}

local base = ("https://raw.githubusercontent.com/%s/%s/"):format(user, repo, branch)

if not fs.exists("radar/radar") then
    fs.makeDir("radar/radar")
end

if not fs.exists("radar/graphics") then
    fs.makeDir("radar/graphics")
end

if not fs.exists("radar/audio") then
    fs.makeDir("radar/graphics")
end

if not fs.exists("radar/assets") then
    fs.makeDir("radar/assets")
end

for _, file in ipairs(files) do

    local url = base .. file

    print("")
    print("FILE:")
    print(file)

    print("URL:")
    print(url)

    local dir = fs.getDir(file)

    if dir ~= "" and not fs.exists(dir) then
        print("Creating directory: " .. dir)
        fs.makeDir(dir)
    end

    print("Downloading...")

    local result = shell.run(
        "wget",
        url,
        file
    )

    print("Result:")
    print(tostring(result))

    if fs.exists(file) then
        print("SUCCESS: " .. file)
    else
        print("MISSING AFTER DOWNLOAD: " .. file)
    end

end

print("Done!")