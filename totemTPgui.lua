-- Load Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Create the main UI window
local Window = Library.CreateLib("Teleport GUI", "DarkTheme")

-- Add a teleportation tab
local TeleportTab = Window:NewTab("Teleport")

-- Add a section for teleport locations
local LocationSection = TeleportTab:NewSection("Teleport Locations")

-- Define the teleport locations
local locations = {
    Sundial = Vector3.new(-1148, 135, -1075),
    Aurora = Vector3.new(-1811, -137, -3282),
    Windset = Vector3.new(2849, 178, 2702),
    Smokescreen = Vector3.new(2789, 140, -625),
    Tempest = Vector3.new(35, 133, 1943)
}

-- Loop through each location to create teleport buttons
for name, position in pairs(locations) do
    LocationSection:NewButton(name, "Teleport to " .. name, function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        humanoidRootPart.CFrame = CFrame.new(position)
    end)
end

-- Optional: Add a toggle to hide/show UI
LocationSection:NewKeybind("Toggle UI", "Toggles the teleport UI", Enum.KeyCode.RightShift, function()
    Library:ToggleUI()
end)
