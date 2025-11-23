-- NEXUS HUB | FINAL + APPLY BUTTONS + JUMPHEIGHT (NOT JUMPPOWER) | 100% CLEAN
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

if pgui:FindFirstChild("NexusHub") then pgui.NexusHub:Destroy() end
task.wait(0.2)

local screen = Instance.new("ScreenGui", pgui)
screen.Name = "NexusHub"
screen.ResetOnSpawn = false

local main = Instance.new("Frame", screen)
main.Size = UDim2.new(0,720,0,540)
main.Position = UDim2.new(0.5,-360,0.5,-270)
main.BackgroundColor3 = Color3.fromRGB(20,20,24)
main.Active = true
main.Draggable = true
main.ClipsDescendants = true
main.BackgroundTransparency = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

local titlebar = Instance.new("Frame", main)
titlebar.Size = UDim2.new(1,0,0,50)
titlebar.BackgroundColor3 = Color3.fromRGB(28,28,34)
Instance.new("UICorner", titlebar).CornerRadius = UDim.new(0,16)

local title = Instance.new("TextLabel", titlebar)
title.Text = "NEXUS HUB"
title.Font = Enum.Font.GothamBlack
title.TextSize = 26
title.TextColor3 = Color3.fromRGB(180,130,255)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1,-140,1,0)
title.Position = UDim2.new(0,20,0,0)
title.TextXAlignment = "Left"

local minBtn = Instance.new("TextButton", titlebar)
minBtn.Size = UDim2.new(0,40,0,40); minBtn.Position = UDim2.new(1,-85,0,5)
minBtn.BackgroundTransparency = 1; minBtn.Text = "—"; minBtn.TextColor3 = Color3.new(1,1,1)
minBtn.TextSize = 30; minBtn.Font = Enum.Font.GothamBold

local closeBtn = Instance.new("TextButton", titlebar)
closeBtn.Size = UDim2.new(0,40,0,40); closeBtn.Position = UDim2.new(1,-45,0,5)
closeBtn.BackgroundTransparency = 1; closeBtn.Text = "X"; closeBtn.TextColor3 = Color3.new(1,0.3,0.3)
closeBtn.TextSize = 24
closeBtn.MouseButton1Click:Connect(function() screen:Destroy() end)

local container = Instance.new("Frame", main)
container.Size = UDim2.new(1,0,1,-50); container.Position = UDim2.new(0,0,0,50)
container.BackgroundTransparency = 1; container.ClipsDescendants = true

local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    minBtn.Text = minimized and "≡" or "—"
    if minimized then
        main:TweenSize(UDim2.new(0,280,0,50), "Out", "Quint", 0.35, true)
        container.Visible = false
    else
        container.Visible = true
        main:TweenSize(UDim2.new(0,720,0,540), "Out", "Quint", 0.35, true)
    end
end)

local sidebar = Instance.new("Frame", container)
sidebar.Size = UDim2.new(0,190,1,0)
sidebar.BackgroundColor3 = Color3.fromRGB(15,15,19)

local content = Instance.new("Frame", container)
content.Size = UDim2.new(1,-190,1,0)
content.Position = UDim2.new(0,190,0,0)
content.BackgroundTransparency = 1

local pages = {}
local function showPage(n) for name,p in pairs(pages) do p.Visible = (name==n) end end

local tabY = 10
local function createTab(name, iconId)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1,-16,0,60); btn.Position = UDim2.new(0,8,0,tabY)
    btn.BackgroundColor3 = Color3.fromRGB(24,24,30); btn.Text = ""; btn.AutoButtonColor = false

    local icon = Instance.new("ImageLabel", btn)
    icon.Size = UDim2.new(0,36,0,36); icon.Position = UDim2.new(0,18,0.5,-18)
    icon.BackgroundTransparency = 1; icon.Image = "rbxassetid://"..iconId

    local label = Instance.new("TextLabel", btn)
    label.Text = name; label.Font = Enum.Font.GothamBold; label.TextSize = 18
    label.TextColor3 = Color3.new(1,1,1); label.BackgroundTransparency = 1
    label.Size = UDim2.new(1,-80,1,0); label.Position = UDim2.new(0,70,0,0)
    label.TextXAlignment = "Left"

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,12)
    tabY = tabY + 70

    local page = Instance.new("ScrollingFrame", content)
    page.Size = UDim2.new(1,-30,1,-20); page.Position = UDim2.new(0,15,0,10)
    page.BackgroundTransparency = 1; page.ScrollBarThickness = 6
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y; page.Visible = false
    Instance.new("UIListLayout", page).Padding = UDim.new(0,14)

    btn.MouseButton1Click:Connect(function()
        if minimized then minBtn.MouseButton1Click:Fire() end
        showPage(name)
        for _,b in pairs(sidebar:GetChildren()) do
            if b:IsA("TextButton") then
                TweenService:Create(b, TweenInfo.new(0.25), {BackgroundColor3 = b==btn and Color3.fromRGB(130,70,255) or Color3.fromRGB(24,24,30)}):Play()
            end
        end
    end)

    pages[name] = page
    return page
end

local rec   = createTab("Recommended",  "4483345998")
local quick = createTab("Quick Actions","6031079154")
local pre   = createTab("Prebuilt",     "6031097227")
local set   = createTab("Settings",     "6034832814")
showPage("Recommended")

local function addBtn(p, txt, cb)
    local b = Instance.new("TextButton", p)
    b.Size = UDim2.new(1,0,0,68); b.BackgroundColor3 = Color3.fromRGB(30,30,38)
    b.Text = "  "..txt; b.TextColor3 = Color3.new(1,1,1); b.Font = Enum.Font.GothamBold
    b.TextSize = 19; b.TextXAlignment = "Left"
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,12)
    b.MouseButton1Click:Connect(cb or function() end)
    return b
end

-- Recommended
addBtn(rec, "Infinite Yield", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end)

-- Prebuilt
for i = 1,12 do
    addBtn(pre, "Slot "..i.." - Empty", function() StarterGui:SetCore("SendNotification",{Title="Prebuilt",Text="Slot "..i.." empty!",Duration=3}) end)
end

-- QUICK ACTIONS
local humanoid, rootPart
local wsValue, jhValue, tpSpeed = 50, 100, 60          -- jhValue = JumpHeight multiplier (100 = 7.2 studs)
local tpWalk, lockWS, lockJH, noShadows = false, false, false, false

local function createSliderWithApply(page, name, min, max, default, applyCallback)
    local frame = Instance.new("Frame", page)
    frame.Size = UDim2.new(1,0,0,130); frame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1,0,0,30); label.BackgroundTransparency = 1
    label.Text = name..": "..default; label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.GothamBold; label.TextSize = 18; label.TextXAlignment = "Left"

    local box = Instance.new("TextBox", frame)
    box.Size = UDim2.new(1,0,0,40); box.Position = UDim2.new(0,0,0,40)
    box.BackgroundColor3 = Color3.fromRGB(40,40,48); box.TextColor3 = Color3.new(1,1,1)
    box.Text = tostring(default); box.ClearTextOnFocus = false
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,10)

    local apply = Instance.new("TextButton", frame)
    apply.Size = UDim2.new(1,0,0,40); apply.Position = UDim2.new(0,0,0,85)
    apply.BackgroundColor3 = Color3.fromRGB(80,180,80); apply.Text = "Apply "..name
    apply.TextColor3 = Color3.new(1,1,1); apply.Font = Enum.Font.GothamBold; apply.TextSize = 18
    Instance.new("UICorner", apply).CornerRadius = UDim.new(0,10)

    apply.MouseButton1Click:Connect(function()
        local n = tonumber(box.Text)
        if n and n >= min and n <= max then
            applyCallback(n)
            label.Text = name..": "..n
            apply.BackgroundColor3 = Color3.fromRGB(0,200,0)
            task.wait(0.2)
            apply.BackgroundColor3 = Color3.fromRGB(80,180,80)
        end
    end)
end

-- WalkSpeed (with Apply)
createSliderWithApply(quick, "WalkSpeed", 16, 500, 50, function(v)
    wsValue = v
    if humanoid then humanoid.WalkSpeed = v end
end)

-- JumpHeight (100 = 7.2 studs) (with Apply)
createSliderWithApply(quick, "JumpHeight", 50, 500, 100, function(v)
    jhValue = v
    if humanoid then humanoid.JumpHeight = (v / 100) * 7.2 end
end)

-- TP Walk Speed
createSliderWithApply(quick, "TP Walk Speed", 10, 300, 60, function(v) tpSpeed = v end)

-- TOGGLES
local tpToggle     = addBtn(quick, "TP Walk: OFF", function() end)
local lockWSBtn    = addBtn(quick, "LOCK WalkSpeed: OFF", function() end)
local lockJHBtn    = addBtn(quick, "LOCK JumpHeight: OFF", function() end)
local shadowToggle = addBtn(quick, "No Shadows: OFF", function() end)

tpToggle.MouseButton1Click:Connect(function()
    tpWalk = not tpWalk; tpToggle.Text = " TP Walk: "..(tpWalk and "ON" or "OFF")
    tpToggle.BackgroundColor3 = tpWalk and Color3.fromRGB(0,170,0) or Color3.fromRGB(30,30,38)
end)

lockWSBtn.MouseButton1Click:Connect(function()
    lockWS = not lockWS; lockWSBtn.Text = " LOCK WalkSpeed: "..(lockWS and "ON" or "OFF")
    lockWSBtn.BackgroundColor3 = lockWS and Color3.fromRGB(200,0,0) or Color3.fromRGB(30,30,38)
end)

lockJHBtn.MouseButton1Click:Connect(function()
    lockJH = not lockJH; lockJHBtn.Text = " LOCK JumpHeight: "..(lockJH and "ON" or "OFF")
    lockJHBtn.BackgroundColor3 = lockJH and Color3.fromRGB(200,0,0) or Color3.fromRGB(30,30,38)
end)

shadowToggle.MouseButton1Click:Connect(function()
    noShadows = not noShadows; shadowToggle.Text = " No Shadows: "..(noShadows and "ON" or "OFF")
    shadowToggle.BackgroundColor3 = noShadows and Color3.fromRGB(100,100,255) or Color3.fromRGB(30,30,38)
end)

-- 100% NO-CLIP-PROOF TP WALK
local function canMove(direction, distance)
    if distance <= 0 then return true end
    local origin = rootPart.Position
    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {player.Character}
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist

    local offsets = {
        Vector3.new( 2, 0,  2), Vector3.new( 2, 0, -2),
        Vector3.new(-2, 0,  2), Vector3.new(-2, 0, -2),
        Vector3.new( 2, 0,  0), Vector3.new(-2, 0,  0),
        Vector3.new( 0, 0,  2), Vector3.new( 0, 0, -2),
    }

    for _, offset in ipairs(offsets) do
        local result = workspace:Raycast(origin + offset, direction * distance, rayParams)
        if result then return false end
    end
    return true
end

RunService.Heartbeat:Connect(function(dt)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    rootPart = player.Character:FindFirstChild("HumanoidRootPart")
    if not (humanoid and rootPart) then return end

    if lockWS then humanoid.WalkSpeed = wsValue end
    if lockJH then humanoid.JumpHeight = (jhValue / 100) * 7.2 end

    if noShadows then
        Lighting.GlobalShadows = false
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then v.CastShadow = false end
        end
    end

    if tpWalk and humanoid.MoveDirection.Magnitude > 0 then
        local moveVec = humanoid.MoveDirection * tpSpeed * dt
        local dist = moveVec.Magnitude
        local dir = moveVec.Unit

        if canMove(dir, dist) then
            rootPart.CFrame += moveVec
        else
            local slideX = Vector3.new(moveVec.X, 0, 0)
            local slideZ = Vector3.new(0, 0, moveVec.Z)
            if canMove(slideX.Unit, slideX.Magnitude) then rootPart.CFrame += slideX
            elseif canMove(slideZ.Unit, slideZ.Magnitude) then rootPart.CFrame += slideZ end
        end
    end
end)

player.CharacterAdded:Connect(function(c)
    task.wait(0.5)
    humanoid = c:WaitForChild("Humanoid")
    rootPart = c:WaitForChild("HumanoidRootPart")
    humanoid.WalkSpeed = wsValue
    humanoid.JumpHeight = (jhValue / 100) * 7.2
end)

-- SETTINGS
local currentTheme = "Dark"
local translucent = false
local themeBtn = addBtn(set, "Theme: Dark")
local transBtn = addBtn(set, "Translucent: OFF")

local themes = {
    Dark  = {bg=Color3.fromRGB(20,20,24), tb=Color3.fromRGB(28,28,34), sb=Color3.fromRGB(15,15,19), btn=Color3.fromRGB(30,30,38), txt=Color3.fromRGB(240,240,240)},
    Light = {bg=Color3.fromRGB(252,252,252), tb=Color3.fromRGB(255,255,255), sb=Color3.fromRGB(240,240,245), btn=Color3.fromRGB(230,230,240), txt=Color3.fromRGB(20,20,20)},
    Blood = {bg=Color3.fromRGB(22,2,8), tb=Color3.fromRGB(40,5,12), sb=Color3.fromRGB(30,2,10), btn=Color3.fromRGB(55,8,18), txt=Color3.fromRGB(255,90,90)},
    Aqua  = {bg=Color3.fromRGB(0,28,40), tb=Color3.fromRGB(0,40,55), sb=Color3.fromRGB(0,22,38), btn=Color3.fromRGB(0,50,70), txt=Color3.fromRGB(100,255,255)}
}

local function applyTheme()
    local t = themes[currentTheme]
    main.BackgroundColor3 = t.bg; titlebar.BackgroundColor3 = t.tb; sidebar.BackgroundColor3 = t.sb
    for _,obj in pairs(content:GetDescendants()) do
        if obj:IsA("TextButton") or obj:IsA("TextBox") then
            obj.BackgroundColor3 = t.btn; obj.TextColor3 = t.txt
        end
    end
    themeBtn.Text = " Theme: "..currentTheme
end

themeBtn.MouseButton1Click:Connect(function()
    local list = {"Dark","Light","Blood","Aqua"}
    currentTheme = list[(table.find(list,currentTheme)%4)+1]
    applyTheme()
end)

transBtn.MouseButton1Click:Connect(function()
    translucent = not translucent
    local alpha = translucent and 0.52 or 0
    main.BackgroundTransparency = alpha; titlebar.BackgroundTransparency = alpha; sidebar.BackgroundTransparency = alpha
    transBtn.Text = " Translucent: "..(translucent and "ON" or "OFF")
end)

applyTheme()

StarterGui:SetCore("SendNotification", {Title="NEXUS HUB", Text="Now with Apply buttons + JumpHeight (100 = 7.2 studs). Cleanest hub alive.", Duration=8})
