local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Fisch Script",
    SubTitle = "by wisteria",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "layout-grid"}),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "map" }),
    Miscellaneous = Window:AddTab({ Title = "Miscellaneous", Icon = "box" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}

local function teleport(position)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(position)
end

local totemLocations = {
    Sundial = Vector3.new(-1148, 135, -1075),
    Aurora = Vector3.new(-1811, -137, -3282),
    Windset = Vector3.new(2849, 178, 2702),
    Smokescreen = Vector3.new(2789, 140, -625),
    Tempest = Vector3.new(35, 133, 1943)
}

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

Tabs.Teleport:AddParagraph({
    Title = "Totem Locations",
    Content = "Click a button to teleport to the selected totem."
})

for name, position in pairs(totemLocations) do
    Tabs.Teleport:AddButton({
        Title = name,
        Callback = function()
            teleport(position)
        end
    })
end

Tabs.Teleport:AddParagraph({
    Title = "Area Locations",
    Content = "Click a button to teleport to the selected area."
})

for name, position in pairs(areaLocations) do
    Tabs.Teleport:AddButton({
        Title = name,
        Callback = function()
            teleport(position)
        end
    })
end

Tabs.Miscellaneous:AddParagraph({
    Title = "Mod Detection",
    Content = "Enable or customize mod detection settings below."
})

-- Mod Detection Section
local DetectionToggle = Tabs.Miscellaneous:AddToggle("EnableDetection", {
    Title = "Enable Detection",
    Default = enabled
})

DetectionToggle:OnChanged(function()
    enabled = DetectionToggle.Value
    _G.enabled = enabled
    print("Enable Detection changed to:", enabled)
end)

local KickToggle = Tabs.Miscellaneous:AddToggle("InstantKick", {
    Title = "Instant Kick",
    Default = kick
})

KickToggle:OnChanged(function()
    kick = KickToggle.Value
    _G.kick = kick
    print("Instant Kick changed to:", kick)
end)

local NotifyToggle = Tabs.Miscellaneous:AddToggle("NotifyDetection", {
    Title = "Notify on Detection",
    Default = notify
})

NotifyToggle:OnChanged(function()
    notify = NotifyToggle.Value
    _G.notify = notify
    print("Notify on Detection changed to:", notify)
end)

-- Initializing toggle values
DetectionToggle:SetValue(enabled)
KickToggle:SetValue(kick)
NotifyToggle:SetValue(notify)

-- Mod detection script
local groups = {
    7381705 -- Example group IDs, customize as needed
}

local defaultRoles = { 
    "moderator", "admin", "junior moderator", "junior mod", "senior moderator", "senior mod",
    -- Add other roles here
}

local customRoles = {}
local players = game:GetService("Players")
local localplayer = players.LocalPlayer
local sent = false

function getMods()
    for _, v in next, players:GetPlayers() do
        for _, group in next, groups do
            if v and v ~= localplayer then
                local role = v:GetRoleInGroup(group):lower()
                if table.find(defaultRoles, role) or table.find(customRoles, role) then
                    return true, role, group
                end
            end
        end
    end
    return false
end

function detectMods()
    local detected, role, group = getMods()

    if detected and _G.kick then
        localplayer:Kick("[Automod Detector] A blacklisted role has been detected in your game! Role name: " .. role .. " | Group ID: " .. group)

    elseif detected and _G.notify and not sent then
        local function callbackkick()
            localplayer:Kick()
        end
        local bindable = Instance.new("BindableFunction")
        bindable.OnInvoke = callbackkick

        game.StarterGui:SetCore("SendNotification", {
            Title = "[Automod Detector]",
            Text = "A blacklisted role has been detected in your game! Role name: " .. role .. " | Group ID: " .. group,
            Duration = 12,
            Button1 = "Click me to leave game",
            Callback = bindable
        })
        if not sent then sent = true else sent = false end
    end
end

task.spawn(function()
    while _G.enabled do
        task.wait()
        detectMods()
        players.PlayerAdded:Connect(function()
            detectMods()
        end)
    end
end)

Tabs.Settings:AddParagraph({
    Title = "Settings",
    Content = "Customize your experience below."
})

Fluent:Notify({
    Title = "Script Loaded",
    Content = "Teleportation and mod detection features are ready to use.",
    Duration = 5
})

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
InterfaceManager:SetFolder("WisteriaFischScript")
SaveManager:SetFolder("WisteriaFischScript")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
