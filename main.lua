-- Teto Hub v3.0 - VARIABLE TP (NO PARTS, UNDETECTABLE)
-- Drop in LocalScript

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TetoHubGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- MAIN FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 250)
frame.Position = UDim2.new(0.5, -150, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = false
frame.Parent = screenGui

-- BACKGROUND TEXTURE
local bgImage = Instance.new("ImageLabel")
bgImage.Size = UDim2.new(1, 0, 1, 0)
bgImage.BackgroundTransparency = 1
bgImage.Image = "rbxassetid://2151782136"
bgImage.ImageColor3 = Color3.fromRGB(50, 50, 50)
bgImage.ScaleType = Enum.ScaleType.Tile
bgImage.TileSize = UDim2.new(0, 100, 0, 100)
bgImage.ZIndex = 0
bgImage.Parent = frame

-- FRAME CORNER & STROKE
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 10)
frameCorner.Parent = frame

local frameStroke = Instance.new("UIStroke")
frameStroke.Thickness = 4
frameStroke.Color = Color3.fromRGB(255, 0, 0)
frameStroke.Parent = frame

-- Rainbow border
coroutine.wrap(function()
	while true do
		local hue = (tick() % 5) / 5
		frameStroke.Color = Color3.fromHSV(hue, 1, 1)
		task.wait(0.05)
	end
end)()

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -80, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Teto Hub"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 24
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.ZIndex = 2
title.Parent = frame

-- ANNOUNCE
local announceLabel = Instance.new("TextLabel")
announceLabel.Size = UDim2.new(1, -20, 0, 32)
announceLabel.Position = UDim2.new(0, 10, 0, 42)
announceLabel.BackgroundTransparency = 1
announceLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
announceLabel.Text = ""
announceLabel.Font = Enum.Font.SourceSansBold
announceLabel.TextSize = 20
announceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
announceLabel.Visible = false
announceLabel.ZIndex = 3
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

-- TOP BAR
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(0, 80, 0, 40)
topBar.Position = UDim2.new(1, -80, 0, 0)
topBar.BackgroundTransparency = 1
topBar.ZIndex = 3
topBar.Parent = frame

-- MINIMIZE
local minimizeButton = Instance.new("ImageButton")
minimizeButton.Size = UDim2.new(0, 32, 0, 32)
minimizeButton.Position = UDim2.new(0, 4, 0, 4)
minimizeButton.BackgroundTransparency = 1
minimizeButton.Image = "rbxassetid://3926307971"
minimizeButton.ImageRectOffset = Vector2.new(884, 284)
minimizeButton.ImageRectSize = Vector2.new(36, 36)
minimizeButton.ZIndex = 4
minimizeButton.Parent = topBar

-- CLOSE
local closeButton = Instance.new("ImageButton")
closeButton.Size = UDim2.new(0, 32, 0, 32)
closeButton.Position = UDim2.new(0, 44, 0, 4)
closeButton.BackgroundTransparency = 1
closeButton.Image = "rbxassetid://3926305904"
closeButton.ImageRectOffset = Vector2.new(284, 4)
closeButton.ImageRectSize = Vector2.new(24, 24)
closeButton.ZIndex = 4
closeButton.Parent = topBar

-- RESTORE BUTTON
local restoreButton = Instance.new("ImageButton")
restoreButton.Size = UDim2.new(0, 48, 0, 48)
restoreButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
restoreButton.BackgroundTransparency = 0.2
restoreButton.Visible = false
restoreButton.Image = "http://www.roblox.com/asset/?id=91426973036003"
restoreButton.ZIndex = 10
restoreButton.Parent = screenGui

local restoreCorner = Instance.new("UICorner")
restoreCorner.CornerRadius = UDim.new(0.5, 0)
restoreCorner.Parent = restoreButton

local restoreStroke = Instance.new("UIStroke")
restoreStroke.Thickness = 3
restoreStroke.Color = Color3.fromHSV(0, 1, 1)
restoreStroke.Parent = restoreButton

coroutine.wrap(function()
	while true do
		local hue = (tick() % 5) / 5
		restoreStroke.Color = Color3.fromHSV(hue, 1, 1)
		task.wait(0.05)
	end
end)()

-- DRAGGING
local function makeDraggable(gui)
	local dragging, dragStart, startPos
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
			local conn
			conn = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
					if conn then conn:Disconnect() end
				end
			end)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			gui.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)
end

makeDraggable(frame)
makeDraggable(restoreButton)

-- MINIMIZE / RESTORE
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

-- === CONFIRMATION POPUP ===
local confirmFrame = nil
local function showConfirm()
	if confirmFrame then return end

	confirmFrame = Instance.new("Frame")
	confirmFrame.Size = UDim2.new(0, 200, 0, 100)
	confirmFrame.Position = UDim2.new(0.5, -100, 0.5, -50)
	confirmFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	confirmFrame.BorderSizePixel = 0
	confirmFrame.ZIndex = 20
	confirmFrame.Parent = screenGui

	local cfCorner = Instance.new("UICorner")
	cfCorner.CornerRadius = UDim.new(0, 12)
	cfCorner.Parent = confirmFrame

	local cfStroke = Instance.new("UIStroke")
	cfStroke.Thickness = 3
	cfStroke.Color = Color3.fromRGB(255, 80, 80)
	cfStroke.Parent = confirmFrame

	local cfTitle = Instance.new("TextLabel")
	cfTitle.Size = UDim2.new(1, 0, 0, 30)
	cfTitle.BackgroundTransparency = 1
	cfTitle.Text = "Close Teto Hub?"
	cfTitle.Font = Enum.Font.SourceSansBold
	cfTitle.TextSize = 18
	cfTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	cfTitle.ZIndex = 21
	cfTitle.Parent = confirmFrame

	local yesButton = Instance.new("TextButton")
	yesButton.Size = UDim2.new(0, 80, 0, 30)
	yesButton.Position = UDim2.new(0, 20, 1, -50)
	yesButton.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
	yesButton.Text = "Yes"
	yesButton.Font = Enum.Font.SourceSans
	yesButton.TextSize = 16
	yesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	yesButton.ZIndex = 21
	yesButton.Parent = confirmFrame

	local noButton = Instance.new("TextButton")
	noButton.Size = UDim2.new(0, 80, 0, 30)
	noButton.Position = UDim2.new(1, -100, 1, -50)
	noButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	noButton.Text = "No"
	noButton.Font = Enum.Font.SourceSans
	noButton.TextSize = 16
	noButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	noButton.ZIndex = 21
	noButton.Parent = confirmFrame

	local yCorner = Instance.new("UICorner")
	yCorner.CornerRadius = UDim.new(0, 8)
	yCorner.Parent = yesButton

	local nCorner = Instance.new("UICorner")
	nCorner.CornerRadius = UDim.new(0, 8)
	nCorner.Parent = noButton

	-- Fade in
	confirmFrame.BackgroundTransparency = 1
	for i = 1, 10 do
		confirmFrame.BackgroundTransparency = 1 - i/10
		task.wait(0.02)
	end

	yesButton.MouseButton1Click:Connect(function()
		screenGui:Destroy()
	end)

	noButton.MouseButton1Click:Connect(function()
		for i = 1, 10 do
			confirmFrame.BackgroundTransparency = i/10
			task.wait(0.02)
		end
		confirmFrame:Destroy()
		confirmFrame = nil
	end)
end

closeButton.MouseButton1Click:Connect(showConfirm)

-- BUTTON CONTAINER
local buttonContainer = Instance.new("Frame")
buttonContainer.Size = UDim2.new(1, -20, 0, 120)
buttonContainer.Position = UDim2.new(0, 10, 1, -140)
buttonContainer.BackgroundTransparency = 1
buttonContainer.ZIndex = 2
buttonContainer.Parent = frame

local layout = Instance.new("UIListLayout")
layout.FillDirection = Enum.FillDirection.Vertical
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 10)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Parent = buttonContainer

local function addHover(button, normal, hover)
	button.MouseEnter:Connect(function() button.BackgroundColor3 = hover end)
	button.MouseLeave:Connect(function() button.BackgroundColor3 = normal end)
end

-- === NEW VARIABLE-BASED TP SYSTEM ===
local savedPosition = nil  -- STORES SAVED CFRAME (NO PARTS)
local originalPosition = nil  -- STORES PRE-TP POSITION

-- SAVE BUTTON
local createPartButton = Instance.new("TextButton")
createPartButton.Size = UDim2.new(0, 120, 0, 40)
createPartButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
createPartButton.Text = "Save Position"
createPartButton.Font = Enum.Font.SourceSans
createPartButton.TextSize = 20
createPartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
createPartButton.LayoutOrder = 1
createPartButton.ZIndex = 3
createPartButton.Parent = buttonContainer

local b1Corner = Instance.new("UICorner")
b1Corner.CornerRadius = UDim.new(0.5, 0)
b1Corner.Parent = createPartButton

local b1Stroke = Instance.new("UIStroke")
b1Stroke.Thickness = 2
b1Stroke.Color = Color3.fromRGB(100, 100, 255)
b1Stroke.Parent = createPartButton

addHover(createPartButton, Color3.fromRGB(70, 130, 180), Color3.fromRGB(100, 150, 200))

-- TELEPORT BUTTON
local teleportButton = Instance.new("TextButton")
teleportButton.Size = UDim2.new(0, 120, 0, 40)
teleportButton.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
teleportButton.Text = "Teleport"
teleportButton.Font = Enum.Font.SourceSans
teleportButton.TextSize = 20
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.LayoutOrder = 2
teleportButton.ZIndex = 3
teleportButton.Parent = buttonContainer

local b2Corner = Instance.new("UICorner")
b2Corner.CornerRadius = UDim.new(0.5, 0)
b2Corner.Parent = teleportButton

local b2Stroke = Instance.new("UIStroke")
b2Stroke.Thickness = 2
b2Stroke.Color = Color3.fromRGB(100, 255, 100)
b2Stroke.Parent = teleportButton

addHover(teleportButton, Color3.fromRGB(34, 139, 34), Color3.fromRGB(50, 160, 50))

-- RETURN BUTTON
local returnButton = Instance.new("TextButton")
returnButton.Size = UDim2.new(0, 120, 0, 40)
returnButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
returnButton.Text = "Return"
returnButton.Font = Enum.Font.SourceSans
returnButton.TextSize = 20
returnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
returnButton.LayoutOrder = 3
returnButton.ZIndex = 3
returnButton.Parent = buttonContainer

local b3Corner = Instance.new("UICorner")
b3Corner.CornerRadius = UDim.new(0.5, 0)
b3Corner.Parent = returnButton

local b3Stroke = Instance.new("UIStroke")
b3Stroke.Thickness = 2
b3Stroke.Color = Color3.fromRGB(255, 100, 100)
b3Stroke.Parent = returnButton

addHover(returnButton, Color3.fromRGB(220, 20, 60), Color3.fromRGB(240, 50, 80))

-- === NEW LOGIC (VARIABLES ONLY) ===
createPartButton.MouseButton1Click:Connect(function()
	local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	savedPosition = character:GetPivot()  -- JUST STORE CFRAME
	originalPosition = nil  -- Reset return
	coroutine.wrap(function() announce("Position Saved!") end)()
end)

teleportButton.MouseButton1Click:Connect(function()
	if savedPosition then
		local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		originalPosition = character:GetPivot()  -- Save current before TP
		character:PivotTo(savedPosition)  -- TP to saved
		coroutine.wrap(function() announce("Teleported! (Return ready)") end)()
	else
		coroutine.wrap(function() announce("Save a position first!") end)()
	end
end)

returnButton.MouseButton1Click:Connect(function()
	if originalPosition then
		local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		character:PivotTo(originalPosition)
		coroutine.wrap(function() announce("Returned to spawn!") end)()
	else
		coroutine.wrap(function() announce("Teleport first to return!") end)()
	end
end)

-- CLEANUP (NO PARTS TO CLEAN)
LocalPlayer.AncestryChanged:Connect(function()
	savedPosition = nil
	originalPosition = nil
end)
