local user = "autumnalwitch"
local repo = "radar"
local branch = "main"

local files = {
    "radar/main.lua",
    "radar/config.lua",
    "radar/graphics/framebuffer.lua",
    "radar/graphics/palette.lua",
    "radar/graphics/renderer.lua",
    "radar/graphics/draw.lua",
    "radar/radar/contacts.lua",
    "radar/radar/engine.lua",
    "radar/radar/sweep.lua",
    "radar/audio/ping.lua",
    "radar/startup.lua",
    "radar/assets/ping.dfpwm",
    "radar/demo.lua"
}

local base = ("https://raw.githubusercontent.com/%s/%s/%s/"):format(user, repo, branch)

if not fs.exists("radar") then
    fs.makeDir("radar")
end

if not fs.exists("radar/graphics") then
    fs.makeDir("radar/graphics")
end

if not fs.exists("radar/assets") then
    fs.makeDir("radar/assets")
end

for _, file in ipairs(files) do
    if fs.exists(file) then
        fs.delete(file)
    end

    print("Downloading " .. file)
    shell.run("wget", base .. file, file)
end

print("Done!")