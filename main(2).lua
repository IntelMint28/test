-- // RGB GHOST CLONE - MINIMIZABLE GOD EDITION 2025 \\ --
-- Now with sexy minimize button (click top-right X to collapse)

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RGBGhostPro"
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 280, 0, 110)
Frame.Position = UDim2.new(0.5, -140, 0.15, 0)
Frame.BackgroundTransparency = 0.3
Frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner", Frame)
MainCorner.CornerRadius = UDim.new(0, 20)

-- GLOW
local Glow = Instance.new("ImageLabel", Frame)
Glow.Name = "Glow"
Glow.BackgroundTransparency = 1
Glow.Size = UDim2.new(1.2, 0, 1.4, 0)
Glow.Position = UDim2.new(-0.1, 0, -0.2, 0)
Glow.Image = "rbxassetid://4996891864"
Glow.ImageColor3 = Color3.fromRGB(130, 0, 255)
Glow.ImageTransparency = 0.5
Glow.ZIndex = 0

-- TITLE
local Title = Instance.new("TextLabel", Frame)
Title.Text = "GHOST CLONE"
Title.Size = UDim2.new(0.75,0,0.35,0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.Arcade
Title.TextSize = 28
Title.TextStrokeTransparency = 0.7
Title.TextStrokeColor3 = Color3.fromRGB(255,0,255)
Title.ZIndex = 10

-- MINIMIZE BUTTON (top-right X)
local Minimize = Instance.new("TextButton", Frame)
Minimize.Size = UDim2.new(0, 40, 0, 40)
Minimize.Position = UDim2.new(1, -45, 0, 5)
Minimize.BackgroundTransparency = 1
Minimize.Text = "−"  -- becomes × when minimized
Minimize.TextColor3 = Color3.fromRGB(255,100,100)
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 30
Minimize.ZIndex = 15

-- MAIN CONTENT (will be hidden when minimized)
local Content = Instance.new("Frame", Frame)
Content.Size = UDim2.new(1,0,1,0)
Content.BackgroundTransparency = 1
Content.ZIndex = 10

local Sub = Instance.new("TextLabel", Content)
Sub.Text = "RGB EDITION - PRESS Q OR CLICK"
Sub.Position = UDim2.new(0,0,0.28,0)
Sub.Size = UDim2.new(1,0,0.2,0)
Sub.BackgroundTransparency = 1
Sub.TextColor3 = Color3.fromRGB(200,200,255)
Sub.Font = Enum.Font.Gotham
Sub.TextSize = 14

local Button = Instance.new("TextButton", Content)
Button.Size = UDim2.new(0.85,0,0.38,0)
Button.Position = UDim2.new(0.075,0,0.55,0)
Button.BackgroundColor3 = Color3.fromRGB(255,0,100)
Button.Text = "SILENT +2 STUDS"
Button.Font = Enum.Font.Arcade
Button.TextSize = 26
Button.TextColor3 = Color3.new(1,1,1)

local ButtonCorner = Instance.new("UICorner", Button)
ButtonCorner.CornerRadius = UDim.new(0, 16)
local ButtonStroke = Instance.new("UIStroke", Button)
ButtonStroke.Thickness = 3
ButtonStroke.Color = Color3.fromRGB(255,255,255)
ButtonStroke.Transparency = 0.3

-- MINIMIZE LOGIC (smooth af)
local minimized = false
Minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    
    if minimized then
        TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 180, 0, 50)}):Play()
        TweenService:Create(Glow, TweenInfo.new(0.4), {ImageTransparency = 0.8}):Play()
        Content.Visible = false
        Minimize.Text = "×"
        Title.Text = "GHOST"
    else
        TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 280, 0, 110)}):Play()
        TweenService:Create(Glow, TweenInfo.new(0.4), {ImageTransparency = 0.5}):Play()
        wait(0.3)
        Content.Visible = true
        Minimize.Text = "−"
        Title.Text = "GHOST CLONE"
    end
end)

-- RGB LOOP (still breathing hard)
spawn(function()
    while wait() do
        for hue = 0, 1, 0.001 do
            local color = Color3.fromHSV(hue, 1, 1)
            TweenService:Create(Frame, TweenInfo.new(0.1), {BackgroundColor3 = color}):Play()
            TweenService:Create(Glow, TweenInfo.new(0.1), {ImageColor3 = color}):Play()
            TweenService:Create(ButtonStroke, TweenInfo.new(0.1), {Color = color}):Play()
            Title.TextStrokeColor3 = color
            wait()
        end
    end
end)

-- PULSE ONLY WHEN OPEN
spawn(function()
    while wait(0.7) do
        if not minimized then
            TweenService:Create(Button, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0.9,0,0.42,0)}):Play()
            wait(0.3)
            TweenService:Create(Button, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0.85,0,0.38,0)}):Play()
        end
    end
end)

-- SILENT CLONE (unchanged god tier)
local function silentClone()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    
    local clone = hrp:Clone()
    clone.Parent = char
    clone.CFrame = hrp.CFrame + hrp.CFrame.LookVector * 2
    hrp.CFrame = clone.CFrame
    clone:Destroy()
    
    Button.Text = "GHOSTED"
    Button.TextColor3 = Color3.fromRGB(0,255,0)
    wait(0.2)
    Button.Text = "SILENT +2 STUDS"
    Button.TextColor3 = Color3.new(1,1,1)
end

Button.MouseButton1Click:Connect(silentClone)
UIS.InputBegan:Connect(function(i,gp)
    if not gp and i.KeyCode == Enum.KeyCode.Q then
        silentClone()
    end
end)

print("RGB GHOST CLONE PRO LOADED")
print("Q = Silent Clone | Click X to minimize | Pure aura activated")