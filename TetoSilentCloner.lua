local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- ==== CONFIGURABLE KEY (will be saved/loaded from the textbox) ====
local CURRENT_KEY = Enum.KeyCode.Q  -- default fallback

-- ====================== GUI START ======================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RGBGhostPro"
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 280, 0, 150)  -- little taller for the textbox
Frame.Position = UDim2.new(0.5, -140, 0.15, 0)
Frame.BackgroundTransparency = 0.3
Frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 20)

-- Glow / Title / Minimize same as before (shortened for readability)
local Glow = Instance.new("ImageLabel", Frame)
Glow.Name = "Glow"
Glow.BackgroundTransparency = 1
Glow.Size = UDim2.new(1.2,0,1.4,0)
Glow.Position = UDim2.new(-0.1,0,-0.2,0)
Glow.Image = "rbxassetid://4996891864"
Glow.ImageColor3 = Color3.fromRGB(130,0,255)
Glow.ImageTransparency = 0.5
Glow.ZIndex = 0

local Title = Instance.new("TextLabel", Frame)
Title.Text = "Teto Silent Cloner"
Title.Size = UDim2.new(0.75,0,0.25,0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.Arcade
Title.TextSize = 28
Title.TextStrokeTransparency = 0.7
Title.TextStrokeColor3 = Color3.fromRGB(255,0,255)
Title.ZIndex = 10

-- MINIMIZE BUTTON
local Minimize = Instance.new("TextButton", Frame)
Minimize.Size = UDim2.new(0,40,0,40)
Minimize.Position = UDim2.new(1,-45,0,5)
Minimize.BackgroundTransparency = 1
Minimize.Text = "−"
Minimize.TextColor3 = Color3.fromRGB(255,100,100)
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 30
Minimize.ZIndex = 15

local Content = Instance.new("Frame", Frame)
Content.Size = UDim2.new(1,0,1,0)
Content.BackgroundTransparency = 1
Content.ZIndex = 10

-- INSTRUCTIONS LABEL (will show current key)
local Sub = Instance.new("TextLabel", Content)
Sub.Name = "KeyLabel"
Sub.Text = "PRESS "..tostring(CURRENT_KEY):upper():match("%u%w*").." TO CLONE"
Sub.Position = UDim2.new(0,0,0.2,0)
Sub.Size = UDim2.new(1,0,0.2,0)
Sub.BackgroundTransparency = 1
Sub.TextColor3 = Color3.fromRGB(200,200,255)
Sub.Font = Enum.Font.GothamBold
Sub.TextSize = 16

-- 1-CHARACTER REBIND TEXTBOX
local KeyBox = Instance.new("TextBox", Content)
KeyBox.Size = UDim2.new(0, 50, 0, 40)
KeyBox.Position = UDim2.new(0.5, -25, 0.38, 0)
KeyBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.Font = Enum.Font.Code
KeyBox.TextSize = 24
KeyBox.PlaceholderText = "Q"
KeyBox.Text = ""
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new("UIStroke", KeyBox)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(255,100,255)

-- MAIN BUTTON (same)
local Button = Instance.new("TextButton", Content)
Button.Size = UDim2.new(0.85,0,0.28,0)
Button.Position = UDim2.new(0.075,0,0.65,0)
Button.BackgroundColor3 = Color3.fromRGB(255,0,100)
Button.Text = "SILENT CLONE!"
Button.Font = Enum.Font.Arcade
Button.TextSize = 26
Button.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Button).CornerRadius = UDim.new(0,16)
Instance.new("UIStroke", Button).Thickness = 3

-- ====================== KEY REBIND LOGIC ======================
local function updateKeybind(newKeyName)
    local success, keyEnum = pcall(function() return Enum.KeyCode[newKeyName] end)
    if success and keyEnum then
        CURRENT_KEY = keyEnum
        Sub.Text = "PRESS "..newKeyName:upper().." TO CLONE"
        KeyBox.Text = ""
        KeyBox.PlaceholderText = newKeyName:upper()
        print("Silent Clone key rebound to:", newKeyName)
    else
        Sub.Text = "INVALID KEY! → "..newKeyName
        wait(1.5)
        Sub.Text = "PRESS "..tostring(CURRENT_KEY):upper():match("%u%w*").." TO CLONE"
    end
end

KeyBox.FocusLost:Connect(function(enterPressed)
    if enterPressed and KeyBox.Text ~= "" then
        updateKeybind(KeyBox.Text)
    end
end)

-- ====================== SILENT CLONE FUNCTION ======================
local function silentClone()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local clone = hrp:Clone()
    clone.Parent = char
    clone.CFrame = hrp.CFrame + hrp.CFrame.LookVector * 3
    hrp.CFrame = clone.CFrame
    clone:Destroy()
    
    Button.Text = "Cloned!"
    Button.TextColor3 = Color3.fromRGB(0,255,0)
    task.wait(0.2)
    Button.Text = "SILENT CLONE!"
    Button.TextColor3 = Color3.new(1,1,1)
end

Button.MouseButton1Click:Connect(silentClone)

UIS.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == CURRENT_KEY then
        silentClone()
    end
end)

-- ====================== MINIMIZE + RGB + PULSE (unchanged) ======================
-- (same code you already had, just pasted quickly)
local minimized = false
Minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Size = UDim2.new(0,180,0,50)}):Play()
        Content.Visible = false
        Minimize.Text = "×"
        Title.Text = "TETO!!!"
    else
        TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Size = UDim2.new(0,280,0,150)}):Play()
        task.wait(0.3)
        Content.Visible = true
        Minimize.Text = "−"
        Title.Text = "Teto Silent Cloner"
    end
end)

-- RGB breathing
task.spawn(function()
    while task.wait(0.02) do
        for hue = 0, 1, 0.002 do
            local c = Color3.fromHSV(hue, 1, 1)
            Frame.BackgroundColor3 = c
            Glow.ImageColor3 = c
            Button.UIStroke.Color = c
            Title.TextStrokeColor3 = c
        end
    end
end)

-- Button pulse
task.spawn(function()
    while task.wait(0.7) do
        if not minimized then
            TweenService:Create(Button, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0.9,0,0.32,0)}):Play()
            task.wait(0.3)
            TweenService:Create(Button, TweenInfo.new(0.3), {Size = UDim2.new(0.85,0,0.28,0)}):Play()
        end
    end
end)
