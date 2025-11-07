return(local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TetoHubGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = false
frame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 10)
frameCorner.Parent = frame

local frameStroke = Instance.new("UIStroke")
frameStroke.Thickness = 4
frameStroke.Color = Color3.fromRGB(255, 0, 0)
frameStroke.Parent = frame

coroutine.wrap(function()
        local t = 0
        while true do
                t = t + 0.5 * task.wait()
                local hue = (tick() % 5) / 5
                frameStroke.Color = Color3.fromHSV(hue, 1, 1)
        end
end)()

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Teto Hub"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 24
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = frame

local announceLabel = Instance.new("TextLabel")
announceLabel.Size = UDim2.new(1, -20, 0, 32)
announceLabel.Position = UDim2.new(0, 10, 0, 42)
announceLabel.BackgroundTransparency = 0.5
announceLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
announceLabel.Text = ""
announceLabel.Font = Enum.Font.SourceSansBold
announceLabel.TextSize = 20
announceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
announceLabel.Visible = false
announceLabel.Parent = frame

local announceCorner = Instance.new("UICorner")
announceCorner.CornerRadius = UDim.new(0.5, 0)
announceCorner.Parent = announceLabel

local function announce(text)
        announceLabel.Text = text
        announceLabel.Visible = true
        announceLabel.TextTransparency = 1
        announceLabel.BackgroundTransparency = 1
        for i = 0, 10 do
                announceLabel.TextTransparency = 1 - i/10
                announceLabel.BackgroundTransparency = 1 - i/20
                task.wait(0.02)
        end
        task.wait(1)
        for i = 0, 10 do
                announceLabel.TextTransparency = i/10
                announceLabel.BackgroundTransparency = 0.5 + i/20
                task.wait(0.02)
        end
        announceLabel.Visible = false
end

local minimizeButton = Instance.new("ImageButton")
minimizeButton.Size = UDim2.new(0, 32, 0, 32)
minimizeButton.Position = UDim2.new(1, -40, 0, 8)
minimizeButton.BackgroundTransparency = 1
minimizeButton.Image = "rbxassetid://3926307971"
minimizeButton.ImageRectOffset = Vector2.new(884, 284)
minimizeButton.ImageRectSize = Vector2.new(36, 36)
minimizeButton.Parent = frame

local restoreButton = Instance.new("ImageButton")
restoreButton.Size = UDim2.new(0, 48, 0, 48)
restoreButton.Position = frame.Position
restoreButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
restoreButton.BackgroundTransparency = 0.2
restoreButton.Visible = false
restoreButton.Image = "http://www.roblox.com/asset/?id=72136351377328"
restoreButton.Parent = screenGui

local restoreCorner = Instance.new("UICorner")
restoreCorner.CornerRadius = UDim.new(0.5, 0)
restoreCorner.Parent = restoreButton

local restoreStroke = Instance.new("UIStroke")
restoreStroke.Thickness = 3
restoreStroke.Color = Color3.fromHSV((tick() % 5) / 5, 1, 1)
restoreStroke.Parent = restoreButton

coroutine.wrap(function()
        while true do
                local hue = (tick() % 5) / 5
                restoreStroke.Color = Color3.fromHSV(hue, 1, 1)
                task.wait(0.05)
        end
end)()

local dragging = false
local dragStart, startPos

frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position
                input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                                dragging = false
                        end
                end)
        end
end)

UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dragStart
                frame.Position = UDim2.new(
                        startPos.X.Scale,
                        startPos.X.Offset + delta.X,
                        startPos.Y.Scale,
                        startPos.Y.Offset + delta.Y
                )
        end
end)

local restoreDragging = false
local restoreDragStart, restoreStartPos

restoreButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                restoreDragging = true
                restoreDragStart = input.Position
                restoreStartPos = restoreButton.Position
                input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                                restoreDragging = false
                        end
                end)
        end
end)

UserInputService.InputChanged:Connect(function(input)
        if restoreDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - restoreDragStart
                restoreButton.Position = UDim2.new(
                        restoreStartPos.X.Scale,
                        restoreStartPos.X.Offset + delta.X,
                        restoreStartPos.Y.Scale,
                        restoreStartPos.Y.Offset + delta.Y
                )
        end
end)

minimizeButton.MouseButton1Click:Connect(function()
        frame.Visible = false
        restoreButton.Position = frame.Position
        restoreButton.Visible = true
end)

restoreButton.MouseButton1Click:Connect(function()
        frame.Visible = true
        restoreButton.Visible = false
        frame.Position = restoreButton.Position
end)

local createdPart = nil

local createPartButton = Instance.new("TextButton")
createPartButton.Size = UDim2.new(0, 120, 0, 40)
createPartButton.Position = UDim2.new(0.5, -60, 1, -100)
createPartButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
createPartButton.Text = "Save position"
createPartButton.Font = Enum.Font.SourceSans
createPartButton.TextSize = 20
createPartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
createPartButton.Parent = frame

local button1Corner = Instance.new("UICorner")
button1Corner.CornerRadius = UDim.new(0.5, 0)
button1Corner.Parent = createPartButton

local button1Stroke = Instance.new("UIStroke")
button1Stroke.Thickness = 2
button1Stroke.Color = Color3.fromRGB(100, 100, 255)
button1Stroke.Parent = createPartButton

local teleportButton = Instance.new("TextButton")
teleportButton.Size = UDim2.new(0, 120, 0, 40)
teleportButton.Position = UDim2.new(0.5, -60, 1, -50)
teleportButton.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
teleportButton.Text = "Teleport"
teleportButton.Font = Enum.Font.SourceSans
teleportButton.TextSize = 20
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.Parent = frame

local button2Corner = Instance.new("UICorner")
button2Corner.CornerRadius = UDim.new(0.5, 0)
button2Corner.Parent = teleportButton

local button2Stroke = Instance.new("UIStroke")
button2Stroke.Thickness = 2
button2Stroke.Color = Color3.fromRGB(100, 255, 100)
button2Stroke.Parent = teleportButton

createPartButton.MouseButton1Click:Connect(function()
        if createdPart and createdPart.Parent then
                createdPart:Destroy()
        end

        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local charCFrame = character:GetPivot()

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

        coroutine.wrap(function()
                announce("Position Saved!")
        end)()
end)

teleportButton.MouseButton1Click:Connect(function()
        if createdPart and createdPart.Parent then
                local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                character:PivotTo(createdPart.CFrame)
                coroutine.wrap(function()
                        announce("Teleported!")
                end)()
        end
end)
)
