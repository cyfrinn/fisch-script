local SolarisLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/cyfrinn/Roblox/refs/heads/main/solarislib.lua"))()

local win = SolarisLib:New({
    Name = "Totem and Area TP",
    FolderToSave = "SolarisLibStuff"
})

-- Function to teleport the player
local function teleport(position)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(position)
end

-- Tab for Totem TP
local totemTab = win:Tab("Totem TP")
local totemSection = totemTab:Section("Totem Locations")
local totemLocations = {
    Sundial = Vector3.new(-1148, 135, -1075),
    Aurora = Vector3.new(-1811, -137, -3282),
    Windset = Vector3.new(2849, 178, 2702),
    Smokescreen = Vector3.new(2789, 140, -625),
    Tempest = Vector3.new(35, 133, 1943)
}

for name, position in pairs(totemLocations) do
    totemSection:Button(name, function()
        teleport(position)
    end)
end

-- Tab for Area Teleport
local areaTab = win:Tab("Area Teleport")
local areaSection = areaTab:Section("Area Locations")
local areaLocations = {
    Arch = Vector3.new(998.97, 131.32, -1237.14),
    Sunstone = Vector3.new(-933.26, 138.15, -1119.52),
    Volcano = Vector3.new(-1888.52, 172.73, 329.24),
    Trident = Vector3.new(-1479.49, -218.54, -2391.39),
    Moosewood = Vector3.new(383.10, 140.59, 243.93),
    Keepers = Vector3.new(1296.32, -805.29, -298.94),
    Mushgrove = Vector3.new(2501.49, 137.09, -720.70),
    Statue = Vector3.new(72.88, 147.71, -1028.42),
    Deepshop = Vector3.new(-979.20, -239.71, -2699.87),
    Executive = Vector3.new(-29.84, -246.58, 199.12),
    Roslit = Vector3.new(-1476.51, 140.72, 671.69),
    Snowcap = Vector3.new(2648.68, 147.48, 2521.30),
    Vertigo = Vector3.new(-112.01, -508.93, 1040.33),
    Birch = Vector3.new(1742.32, 148.52, -2502.24),
    Brine = Vector3.new(-1794.11, -135.83, -3302.92),
    Deep = Vector3.new(-1510.89, -227.26, -2852.91),
    Spike = Vector3.new(-1254.80, 144.06, 1554.20),
    Wilson = Vector3.new(2938.81, 283.85, 2567.13),
    Terrapin = Vector3.new(-143.88, 149.78, 1909.61),
    Swamp = Vector3.new(2499.57, 137.37, -719.90)
}

for name, position in pairs(areaLocations) do
    areaSection:Button(name, function()
        teleport(position)
    end)
end

-- Optional: Add a notification to indicate script load completion
SolarisLib:Notification("Script Loaded", "Teleportation features are ready to use!", 5)
