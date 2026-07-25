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

    local dir = fs.getDir(file)

    if dir ~= "" and not fs.exists(dir) then
        fs.makeDir(dir)
    end

    if fs.exists(file) then
        fs.delete(file)
    end

    print("Downloading " .. file)

    local success =
        shell.run(
            "wget",
            base .. file,
            file
        )

    if not success then
        print("FAILED: " .. file)
    end

end

print("Done!")