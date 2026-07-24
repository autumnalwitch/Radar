local user = "autumnalwitch"
local repo = "radar"
local branch = "main"

local files = {
    "radar/main.lua",
    "radar/config.lua",
    "radar/renderer.lua",
    "radar/draw.lua",
    "radar/radar.lua",
    "radar/contacts.lua",
    "radar/audio.lua",
    "radar/startup.lua",
    "radar/assets/ping.dfpwm"
}

local base = ("https://raw.githubusercontent.com/%s/%s/%s/"):format(user, repo, branch)

if not fs.exists("radar") then
    fs.makeDir("radar")
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