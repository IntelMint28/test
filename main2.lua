local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Teto Teleporter",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Teto Teleporter",
   LoadingSubtitle = "by Kasane Teto",
   ShowText = "Rayfield", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Teto TP"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local TeleporterTab = Window:CreateTab("The whole hub", nil) -- Title, Image
local MainSection = TeleporterTab:CreateSection("Main")
local MiscSection = TeleporterTab:CreateSection("Misc / Other cool scripts")

Rayfield:Notify({
   Title = "Teto Teleporter",
   Content = "Welcome! Probably a very broken script.",
   Duration = 6.5,
   Image = nil,
})

local RecordPositionButton = MainTab:CreateButton({
   Name = "Save Players position",
   Callback = function()
    local part = Instance.new("Part")
    part.Name = LocalPlayer.Name .. "_TeleportPart"
    part.Size = Vector3.new(4, 1, 4)
    part.Anchored = true
    part.CanCollide = false
    part.CanTouch = false
    part.Transparency = 1
    part.CFrame = charCFrame
    part.Parent = Workspace

    createdPart = part
   end,
})

local TpPositionButton = MainTab:CreateButton({
   Name = "Teleport to saved position",
   Callback = function()
    if createdPart and createdPart.Parent then
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        character:PivotTo(createdPart.CFrame)
   end,
})
