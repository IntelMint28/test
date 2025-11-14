-- Roblox Fly, Speed, Jump, Infinite Jump & Infinite Yield Loader
-- Using Rayfield Interface Library
-- Paste this into your executor (e.g., Synapse, Fluxus, etc.)

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
    Name = "Grok's Utility Hub",
    LoadingTitle = "Loading Grok's Script...",
    LoadingSubtitle = "by xAI",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "GrokHub",
        FileName = "Config"
    },
})

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Fly Variables
local FlyEnabled = false
local FlySpeed = 50
local FlyBodyVelocity = nil
local FlyBodyGyro = nil
local FlyConnection = nil

-- Infinite Jump
local InfiniteJumpEnabled = false

-- WalkSpeed & JumpPower
local DefaultWalkSpeed = 16
local DefaultJumpPower = 50
local CurrentWalkSpeed = DefaultWalkSpeed
local CurrentJumpPower = DefaultJumpPower

-- Tabs
local MainTab = Window:CreateTab("Movement", 4483362458)
local ToolsTab = Window:CreateTab("Tools", 4483362458)

-- Fly Function
local function StartFly()
    if not FlyEnabled then return end
    if not RootPart then return end

    FlyBodyVelocity = Instance.new("BodyVelocity")
    FlyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
    FlyBodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
    FlyBodyVelocity.Parent = RootPart

    FlyBodyGyro = Instance.new("BodyGyro")
    FlyBodyGyro.P = 9000
    FlyBodyGyro.MaxTorque = Vector3.new(40000, 40000, 40000)
    FlyBodyGyro.CFrame = RootPart.CFrame
    FlyBodyGyro.Parent = RootPart

    FlyConnection = RunService.RenderStepped:Connect(function()
        if not FlyEnabled or not RootPart or not RootPart.Parent then
            StopFly()
            return
        end

        local Camera = workspace.CurrentCamera
        local MoveDirection = Vector3.new(0, 0, 0)

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then MoveDirection = MoveDirection + Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then MoveDirection = MoveDirection - Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then MoveDirection = MoveDirection - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then MoveDirection = MoveDirection + Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then MoveDirection = MoveDirection + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then MoveDirection = MoveDirection - Vector3.new(0, 1, 0) end

        if MoveDirection.Magnitude > 0 then
            MoveDirection = MoveDirection.Unit
        end

        FlyBodyVelocity.Velocity = MoveDirection * FlySpeed
        FlyBodyGyro.CFrame = Camera.CFrame
    end)
end

local function StopFly()
    if FlyConnection then FlyConnection:Disconnect() FlyConnection = nil end
    if FlyBodyVelocity then FlyBodyVelocity:Destroy() FlyBodyVelocity = nil end
    if FlyBodyGyro then FlyBodyGyro:Destroy() FlyBodyGyro = nil end
end

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if InfiniteJumpEnabled and LocalPlayer.Character then
        local Hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if Hum then
            Hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Character Reset Handler
LocalPlayer.CharacterAdded:Connect(function(NewChar)
    Character = NewChar
    Humanoid = NewChar:WaitForChild("Humanoid")
    RootPart = NewChar:WaitForChild("HumanoidRootPart")
    Humanoid.WalkSpeed = CurrentWalkSpeed
    Humanoid.JumpPower = CurrentJumpPower
end)

-- === UI ELEMENTS ===

-- Fly Toggle
MainTab:CreateToggle({
    Name = "Enable Fly",
    CurrentValue = false,
    Callback = function(Value)
        FlyEnabled = Value
        if FlyEnabled then
            StartFly()
        else
            StopFly()
        end
    end,
})

-- Fly Speed Slider
MainTab:CreateSlider({
    Name = "Fly Speed",
    Range = {10, 200},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(Value)
        FlySpeed = Value
    end,
})

-- WalkSpeed Slider
MainTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 300},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(Value)
        CurrentWalkSpeed = Value
        if Humanoid then
            Humanoid.WalkSpeed = Value
        end
    end,
})

-- Jump Power Slider
MainTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 300},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(Value)
        CurrentJumpPower = Value
        if Humanoid then
            Humanoid.JumpPower = Value
        end
    end,
})

-- Infinite Jump Toggle
MainTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(Value)
        InfiniteJumpEnabled = Value
    end,
})

-- Reset to Default Button
MainTab:CreateButton({
    Name = "Reset Speed & Jump",
    Callback = function()
        CurrentWalkSpeed = DefaultWalkSpeed
        CurrentJumpPower = DefaultJumpPower
        if Humanoid then
            Humanoid.WalkSpeed = DefaultWalkSpeed
            Humanoid.JumpPower = DefaultJumpPower
        end
        Rayfield:Notify({
            Title = "Reset",
            Content = "WalkSpeed and JumpPower reset to default.",
            Duration = 3,
        })
    end,
})

-- Infinite Yield Loader
ToolsTab:CreateButton({
    Name = "Load Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        Rayfield:Notify({
            Title = "Success",
            Content = "Infinite Yield has been loaded!",
            Duration = 5,
        })
    end,
})

-- Destroy GUI Button
ToolsTab:CreateButton({
    Name = "Destroy GUI",
    Callback = function()
        Rayfield:Destroy()
        StopFly()
    end,
})

-- Notification
Rayfield:Notify({
    Title = "Grok's Utility Hub Loaded!",
    Content = "Fly, speed, jump, and Infinite Yield ready.",
    Duration = 6,
})