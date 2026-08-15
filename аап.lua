-- GOOD HUB V4 | 31 ФУНКЦИЯ
-- СДЕЛАНО МНОЙ. С НУЛЯ.

local player = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")
local ws = game:GetService("Workspace")
local cam = ws.CurrentCamera
local lighting = game:GetService("Lighting")
local run = game:GetService("RunService")
local pg = player:WaitForChild("PlayerGui")
local rs = game:GetService("ReplicatedStorage")

-- =============================================
-- ПЕРЕМЕННЫЕ
-- =============================================
local fly = false
local flybv = nil
local speed = 50
local flyspeed = 60
local killrange = 15
local flingtarget = nil
local espcolor = Color3.fromRGB(0, 255, 0)

-- =============================================
-- 31 ФУНКЦИЯ (ВСЕ В ОДНОМ)
-- =============================================
local f = {
    -- БОЙ
    killaura = false,
    instakill = false,
    aimbot = false,
    rapidfire = false,
    nospread = false,
    autostab = false,
    autoparry = false,
    
    -- ВИЗУАЛ
    esp = false,
    chams = false,
    tracers = false,
    nametags = false,
    boxesp = false,
    healthbar = false,
    fullbright = false,
    nofog = false,
    xray = false,
    
    -- АВТО
    autofarm = false,
    autocollect = false,
    autograbgun = false,
    autoshoot = false,
    autopickup = false,
    autoclaim = false,
    
    -- МОБИЛЬНОСТЬ
    noclip = false,
    flymode = false,
    speedboost = false,
    waterwalk = false,
    superjump = false,
    infinitejump = false,
    
    -- ЗАЩИТА
    antifling = false,
    godmode = false,
    nofall = false,
    invisible = false,
}

-- =============================================
-- БОЕВЫЕ (7)
-- =============================================

-- Kill Aura
spawn(function()
    while wait(0.08) do
        if f.killaura and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, plr in pairs(game.Players:GetPlayers()) do
                    if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local hum = plr.Character:FindFirstChild("Humanoid")
                        if hum and hum.Health <= 0 then continue end
                        if (hrp.Position - plr.Character.HumanoidRootPart.Position).Magnitude < killrange then
                            hrp.CFrame = plr.Character.HumanoidRootPart.CFrame
                            wait(0.04)
                            local tool = player.Character:FindFirstChildOfClass("Tool")
                            if tool then tool:Activate() end
                        end
                    end
                end
            end
        end
    end
end)

-- Instant Kill
spawn(function()
    while wait(1) do
        if f.instakill then
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                    plr.Character.Humanoid.Health = 0
                end
            end
        end
    end
end)

-- Aimbot
spawn(function()
    while wait(0.04) do
        if f.aimbot and player.Character then
            local closest = nil
            local dist = math.huge
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local pos, on = cam:WorldToScreenPoint(plr.Character.HumanoidRootPart.Position)
                    if on then
                        local d = (Vector2.new(pos.X, pos.Y) - Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)).Magnitude
                        if d < dist then
                            dist = d
                            closest = plr
                        end
                    end
                end
            end
            if closest then
                cam.CFrame = CFrame.new(cam.CFrame.Position, closest.Character.HumanoidRootPart.Position + Vector3.new(0, 2, 0))
            end
        end
    end
end)

-- Rapid Fire
spawn(function()
    while wait(0.02) do
        if f.rapidfire and player.Character then
            local tool = player.Character:FindFirstChildOfClass("Tool")
            if tool and (tool.Name:lower():find("gun") or tool.Name:lower():find("pistol")) then
                tool:Activate()
                wait(0.01)
            end
        end
    end
end)

-- No Spread
spawn(function()
    while wait(0.3) do
        if f.nospread and player.Character then
            for _, tool in pairs(player.Character:GetChildren()) do
                if tool:IsA("Tool") then
                    for _, child in pairs(tool:GetDescendants()) do
                        if child:IsA("NumberValue") and child.Name:lower():find("spread") then
                            child.Value = 0
                        end
                    end
                end
            end
        end
    end
end)

-- Auto Stab
spawn(function()
    while wait(0.1) do
        if f.autostab and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, plr in pairs(game.Players:GetPlayers()) do
                    if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        if (hrp.Position - plr.Character.HumanoidRootPart.Position).Magnitude < 8 then
                            local tool = player.Character:FindFirstChildOfClass("Tool")
                            if tool and (tool.Name:lower():find("knife") or tool.Name:lower():find("sword")) then
                                tool:Activate()
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- Auto Parry
spawn(function()
    while wait(0.1) do
        if f.autoparry and player.Character then
            local hum = player.Character:FindFirstChild("Humanoid")
            if hum and hum.Health < hum.MaxHealth * 0.3 then
                local tool = player.Character:FindFirstChildOfClass("Tool")
                if tool then tool:Activate() end
            end
        end
    end
end)

-- =============================================
-- ВИЗУАЛ (9)
-- =============================================

-- ESP
spawn(function()
    while wait(0.3) do
        if f.esp then
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    local h = plr.Character:FindFirstChild("ESP")
                    if not h then
                        h = Instance.new("Highlight")
                        h.Name = "ESP"
                        h.Parent = plr.Character
                    end
                    local tool = plr.Character:FindFirstChildOfClass("Tool")
                    if tool and tool.Name:lower():find("knife") then
                        h.FillColor = Color3.fromRGB(255, 0, 0)
                    elseif tool and (tool.Name:lower():find("gun") or tool.Name:lower():find("pistol")) then
                        h.FillColor = Color3.fromRGB(0, 100, 255)
                    else
                        h.FillColor = Color3.fromRGB(0, 255, 100)
                    end
                    h.Enabled = true
                end
            end
        else
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr.Character then
                    local h = plr.Character:FindFirstChild("ESP")
                    if h then h.Enabled = false end
                end
            end
        end
    end
end)

-- Chams
spawn(function()
    while wait(0.3) do
        if f.chams then
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    for _, part in pairs(plr.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            local c = part:FindFirstChild("Cham")
                            if not c then
                                c = Instance.new("BoxHandleAdornment")
                                c.Name = "Cham"
                                c.Size = part.Size
                                c.CFrame = part.CFrame
                                c.Color3 = Color3.fromRGB(0, 200, 255)
                                c.Transparency = 0.3
                                c.AlwaysOnTop = true
                                c.Parent = part
                            end
                            c.Enabled = true
                        end
                    end
                end
            end
        else
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr.Character then
                    for _, part in pairs(plr.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            local c = part:FindFirstChild("Cham")
                            if c then c:Destroy() end
                        end
                    end
                end
            end
        end
    end
end)

-- Tracers
spawn(function()
    while wait(0.1) do
        if f.tracers then
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local t = plr.Character:FindFirstChild("Tracer")
                    if not t then
                        t = Instance.new("LineHandleAdornment")
                        t.Name = "Tracer"
                        t.Color3 = Color3.fromRGB(255, 0, 255)
                        t.Thickness = 2
                        t.Transparency = 0.5
                        t.AlwaysOnTop = true
                        t.Parent = plr.Character
                    end
                    t.PointA = cam.CFrame.Position
                    t.PointB = plr.Character.HumanoidRootPart.Position
                    t.Enabled = true
                end
            end
        else
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr.Character then
                    local t = plr.Character:FindFirstChild("Tracer")
                    if t then t:Destroy() end
                end
            end
        end
    end
end)

-- Name Tags
spawn(function()
    while wait(0.3) do
        if f.nametags then
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") then
                    local tag = plr.Character:FindFirstChild("NameTag")
                    if not tag then
                        tag = Instance.new("BillboardGui")
                        tag.Name = "NameTag"
                        tag.Parent = plr.Character
                        tag.Size = UDim2.new(0, 120, 0, 30)
                        tag.Adornee = plr.Character.Head
                        local label = Instance.new("TextLabel")
                        label.Parent = tag
                        label.Size = UDim2.new(1, 0, 1, 0)
                        label.BackgroundTransparency = 1
                        label.Text = plr.Name
                        label.TextColor3 = Color3.fromRGB(255, 255, 255)
                        label.TextScaled = true
                        label.Font = Enum.Font.GothamBold
                    end
                    tag.Enabled = true
                end
            end
        else
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr.Character then
                    local tag = plr.Character:FindFirstChild("NameTag")
                    if tag then tag:Destroy() end
                end
            end
        end
    end
end)

-- Box ESP
spawn(function()
    while wait(0.1) do
        if f.boxesp then
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local box = plr.Character:FindFirstChild("BoxESP")
                    if not box then
                        box = Instance.new("BoxHandleAdornment")
                        box.Name = "BoxESP"
                        box.Size = Vector3.new(4, 6, 4)
                        box.Color3 = Color3.fromRGB(0, 255, 255)
                        box.Transparency = 0.6
                        box.AlwaysOnTop = true
                        box.Parent = plr.Character
                    end
                    box.Adornee = plr.Character.HumanoidRootPart
                    box.Enabled = true
                end
            end
        else
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr.Character then
                    local box = plr.Character:FindFirstChild("BoxESP")
                    if box then box:Destroy() end
                end
            end
        end
    end
end)

-- Health Bar
spawn(function()
    while wait(0.2) do
        if f.healthbar then
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                    local hum = plr.Character.Humanoid
                    local bar = plr.Character:FindFirstChild("HealthBar")
                    if not bar then
                        bar = Instance.new("BillboardGui")
                        bar.Name = "HealthBar"
                        bar.Parent = plr.Character
                        bar.Size = UDim2.new(0, 60, 0, 8)
                        bar.Adornee = plr.Character:FindFirstChild("Head")
                        local frame = Instance.new("Frame")
                        frame.Parent = bar
                        frame.Size = UDim2.new(1, 0, 1, 0)
                        frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                        local fill = Instance.new("Frame")
                        fill.Name = "Fill"
                        fill.Parent = frame
                        fill.Size = UDim2.new(1, 0, 1, 0)
                        fill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                    end
                    local fill = bar:FindFirstChild("Frame") and bar.Frame:FindFirstChild("Fill")
                    if fill then
                        fill.Size = UDim2.new(hum.Health / hum.MaxHealth, 0, 1, 0)
                    end
                    bar.Enabled = true
                end
            end
        else
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr.Character then
                    local bar = plr.Character:FindFirstChild("HealthBar")
                    if bar then bar:Destroy() end
                end
            end
        end
    end
end)

-- Full Bright
spawn(function()
    while wait(0.3) do
        if f.fullbright then
            lighting.Brightness = 10
            lighting.Ambient = Color3.fromRGB(255, 255, 255)
            lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        else
            lighting.Brightness = 1
            lighting.Ambient = Color3.fromRGB(0, 0, 0)
            lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)
        end
    end
end)

-- No Fog
spawn(function()
    while wait(0.3) do
        if f.nofog then
            lighting.FogEnd = 999999
            lighting.FogStart = 0
        else
            lighting.FogEnd = 500
            lighting.FogStart = 0
        end
    end
end)

-- XRay
spawn(function()
    while wait(0.3) do
        if f.xray then
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    for _, part in pairs(plr.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.Transparency = 0.2
                        end
                    end
                end
            end
        end
    end
end)

-- =============================================
-- АВТО (6)
-- =============================================

-- Auto Farm
spawn(function()
    while wait(0.3) do
        if f.autofarm and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, obj in pairs(ws:GetChildren()) do
                    if obj:IsA("Part") and (obj.Name:lower():find("coin") or obj.Name:lower():find("money") or obj.Name:lower():find("cash")) then
                        hrp.CFrame = obj.CFrame + Vector3.new(0, 2, 0)
                        wait(0.05)
                    end
                end
            end
        end
    end
end)

-- Auto Collect
spawn(function()
    while wait(0.3) do
        if f.autocollect and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, obj in pairs(ws:GetChildren()) do
                    if obj:IsA("Part") and (obj.Name:lower():find("coin") or obj.Name:lower():find("gem") or obj.Name:lower():find("chest")) then
                        hrp.CFrame = obj.CFrame + Vector3.new(0, 2, 0)
                        wait(0.05)
                    end
                end
            end
        end
    end
end)

-- Auto Grab Gun
spawn(function()
    while wait(0.3) do
        if f.autograbgun and player.Character then
            for _, obj in pairs(ws:GetChildren()) do
                if obj:IsA("Tool") and (obj.Name:lower():find("gun") or obj.Name:lower():find("pistol")) then
                    pcall(function()
                        player.Character.Humanoid:EquipTool(obj)
                    end)
                end
            end
        end
    end
end)

-- Auto Shoot Murderer
spawn(function()
    while wait(0.15) do
        if f.autoshoot and player.Character then
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    local tool = plr.Character:FindFirstChildOfClass("Tool")
                    if tool and tool.Name:lower():find("knife") then
                        local myTool = player.Character:FindFirstChildOfClass("Tool")
                        if myTool and (myTool.Name:lower():find("gun") or myTool.Name:lower():find("pistol")) then
                            myTool:Activate()
                            wait(0.05)
                        end
                    end
                end
            end
        end
    end
end)

-- Auto Pickup Knife
spawn(function()
    while wait(0.3) do
        if f.autopickup and player.Character then
            for _, obj in pairs(ws:GetChildren()) do
                if obj:IsA("Tool") and obj.Name:lower():find("knife") then
                    pcall(function()
                        player.Character.Humanoid:EquipTool(obj)
                    end)
                end
            end
        end
    end
end)

-- Auto Claim
spawn(function()
    while wait(1) do
        if f.autoclaim then
            for _, gui in pairs(pg:GetChildren()) do
                for _, btn in pairs(gui:GetDescendants()) do
                    if btn:IsA("TextButton") and btn.Visible then
                        local text = (btn.Text or ""):lower()
                        if text:find("claim") or text:find("collect") or text:find("reward") then
                            pcall(function() btn:Activate() end)
                            wait(0.3)
                        end
                    end
                end
            end
        end
    end
end)

-- =============================================
-- МОБИЛЬНОСТЬ (6)
-- =============================================

-- Noclip
spawn(function()
    while wait(0.08) do
        if f.noclip and player.Character then
            for _, part in pairs(player.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- Speed Boost
spawn(function()
    while wait(0.15) do
        if f.speedboost and player.Character then
            local hum = player.Character:FindFirstChild("Humanoid")
            if hum then
                hum.WalkSpeed = speed
                hum.JumpPower = 120
            end
        end
    end
end)

-- Super Jump
spawn(function()
    while wait(0.15) do
        if f.superjump and player.Character then
            local hum = player.Character:FindFirstChild("Humanoid")
            if hum then
                hum.JumpPower = 250
            end
        end
    end
end)

-- Infinite Jump
spawn(function()
    while wait(0.04) do
        if f.infinitejump and player.Character then
            local hum = player.Character:FindFirstChild("Humanoid")
            if hum then
                hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
            end
        end
    end
end)

-- Water Walk
spawn(function()
    while wait(0.08) do
        if f.waterwalk and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp and hrp.Position.Y < 3 then
                hrp.CFrame = hrp.CFrame + Vector3.new(0, 5, 0)
            end
        end
    end
end)

-- Fly Mode
local function togglefly()
    f.flymode = not f.flymode
    if f.flymode and player.Character then
        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            flybv = Instance.new("BodyVelocity")
            flybv.Name = "Fly"
            flybv.Velocity = Vector3.new(0, 0, 0)
            flybv.MaxForce = Vector3.new(100000, 100000, 100000)
            flybv.Parent = hrp
            local hum = player.Character:FindFirstChild("Humanoid")
            if hum then hum.PlatformStand = true end
        end
    else
        if flybv then flybv:Destroy() end
        if player.Character then
            local hum = player.Character:FindFirstChild("Humanoid")
            if hum then hum.PlatformStand = false end
        end
    end
end

run.RenderStepped:Connect(function()
    if f.flymode and player.Character then
        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
        if hrp and flybv then
            local move = Vector3.new(0, 0, 0)
            local fwd = cam.CFrame.LookVector
            local right = cam.CFrame.RightVector
            local up = Vector3.new(0, 1, 0)
            if uis:IsKeyDown(Enum.KeyCode.W) then move = move + fwd * flyspeed end
            if uis:IsKeyDown(Enum.KeyCode.S) then move = move - fwd * flyspeed end
            if uis:IsKeyDown(Enum.KeyCode.A) then move = move - right * flyspeed end
            if uis:IsKeyDown(Enum.KeyCode.D) then move = move + right * flyspeed end
            if uis:IsKeyDown(Enum.KeyCode.Space) then move = move + up * flyspeed end
            if uis:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - up * flyspeed end
            flybv.Velocity = move
        end
    end
end)

-- =============================================
-- ЗАЩИТА (4)
-- =============================================

-- Anti Fling
spawn(function()
    while wait(0.08) do
        if f.antifling and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp and hrp.Velocity.Y < -30 then
                hrp.CFrame = hrp.CFrame + Vector3.new(0, 20, 0)
                hrp.Velocity = Vector3.new(0, 0, 0)
            end
        end
    end
end)

-- God Mode
spawn(function()
    while wait(0.15) do
        if f.godmode and player.Character then
            local hum = player.Character:FindFirstChild("Humanoid")
            if hum then
                hum.MaxHealth = 999999
                hum.Health = 999999
                hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            end
        end
    end
end)

-- No Fall
spawn(function()
    while wait(0.08) do
        if f.nofall and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp and hrp.Velocity.Y < -50 then
                hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
            end
        end
    end
end)

-- Invisible
spawn(function()
    while wait(0.3) do
        if f.invisible and player.Character then
            for _, part in pairs(player.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                end
            end
        end
    end
end)

-- =============================================
-- GUI
-- =============================================

local screen = Instance.new("ScreenGui")
screen.Name = "GoodHubV4"
screen.Parent = pg
screen.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Parent = screen
main.Size = UDim2.new(0, 360, 0, 440)
main.Position = UDim2.new(0.01, 0, 0.02, 0)
main.BackgroundColor3 = Color3.fromRGB(8, 3, 20)
main.BackgroundTransparency = 0.05
main.Active = true
main.Draggable = true

local stroke = Instance.new("UIStroke")
stroke.Parent = main
stroke.Color = Color3.fromRGB(0, 200, 255)
stroke.Thickness = 2
stroke.Transparency = 0.2

local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "🔥 GOOD HUB V4 | 31 ФУНКЦИЙ"
title.TextColor3 = Color3.fromRGB(0, 255, 200)
title.BackgroundColor3 = Color3.fromRGB(0, 50, 150)
title.BackgroundTransparency = 0.3
title.TextScaled = true
title.Font = Enum.Font.GothamBold

local close = Instance.new("TextButton")
close.Parent = main
close.Size = UDim2.new(0, 28, 0, 28)
close.Position = UDim2.new(1, -32, 0, 5)
close.Text = "✕"
close.TextColor3 = Color3.fromRGB(255, 100, 100)
close.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
close.BackgroundTransparency = 0.3
close.Font = Enum.Font.GothamBold
close.TextSize = 16
close.MouseButton1Click:Connect(function()
    screen:Destroy()
end)

local tabs = {"⚔️БОЙ", "👁️ВИЗУАЛ", "🤖АВТО", "🏃МОБИЛ", "🛡️ЗАЩИТА"}

local tabFrame = Instance.new("Frame")
tabFrame.Parent = main
tabFrame.Size = UDim2.new(1, 0, 0, 28)
tabFrame.Position = UDim2.new(0, 0, 0, 40)
tabFrame.BackgroundTransparency = 1

local tabBtns = {}
for i, name in pairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Parent = tabFrame
    btn.Size = UDim2.new(0.2, 0, 1, 0)
    btn.Position = UDim2.new((i-1) * 0.2, 0, 0, 0)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(40, 20, 60)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 10
    tabBtns[i] = btn
end

local content = Instance.new("ScrollingFrame")
content.Parent = main
content.Size = UDim2.new(1, -10, 1, -80)
content.Position = UDim2.new(0, 5, 0, 72)
content.BackgroundTransparency = 1
content.CanvasSize = UDim2.new(0, 0, 0, 600)
content.ScrollBarThickness = 3
content.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)

local functionNames = {
    killaura = "🗡️ Kill Aura",
    instakill = "💀 Instant Kill",
    aimbot = "🎯 Aimbot",
    rapidfire = "🔫 Rapid Fire",
    nospread = "🎯 No Spread",
    autostab = "🗡️ Auto Stab",
    autoparry = "🛡️ Auto Parry",
    esp = "👁️ ESP",
    chams = "🔮 Chams",
    tracers = "📏 Tracers",
    nametags = "🏷️ Name Tags",
    boxesp = "📦 Box ESP",
    healthbar = "❤️ Health Bar",
    fullbright = "☀️ Full Bright",
    nofog = "🌫️ No Fog",
    xray = "👁️ XRay",
    autofarm = "💰 Auto Farm",
    autocollect = "📦 Auto Collect",
    autograbgun = "🔫 Auto Grab Gun",
    autoshoot = "🎯 Auto Shoot Murderer",
    autopickup = "🔪 Auto Pickup Knife",
    autoclaim = "🎁 Auto Claim",
    noclip = "🧱 Noclip",
    flymode = "✈️ Fly Mode (F)",
    speedboost = "🏃 Speed Boost",
    waterwalk = "🌊 Walk On Water",
    superjump = "🦘 Super Jump",
    infinitejump = "🦘 Infinite Jump",
    antifling = "🛡️ Anti Fling",
    godmode = "💪 God Mode",
    nofall = "🪂 No Fall",
    invisible = "👻 Invisible",
}

local featureCategories = {
    ["⚔️БОЙ"] = {"killaura", "instakill", "aimbot", "rapidfire", "nospread", "autostab", "autoparry"},
    ["👁️ВИЗУАЛ"] = {"esp", "chams", "tracers", "nametags", "boxesp", "healthbar", "fullbright", "nofog", "xray"},
    ["🤖АВТО"] = {"autofarm", "autocollect", "autograbgun", "autoshoot", "autopickup", "autoclaim"},
    ["🏃МОБИЛ"] = {"noclip", "flymode", "speedboost", "waterwalk", "superjump", "infinitejump"},
    ["🛡️ЗАЩИТА"] = {"antifling", "godmode", "nofall", "invisible"},
}

local function createButton(parent, y, key)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = UDim2.new(1, -10, 0, 26)
    btn.Position = UDim2.new(0, 5, 0, y)
    btn.Text = functionNames[key] .. " [ВЫКЛ]"
    btn.BackgroundColor3 = Color3.fromRGB(35, 15, 55)
    btn.BackgroundTransparency = 0.15
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 11
    btn.MouseButton1Click:Connect(function()
        f[key] = not f[key]
        btn.Text = functionNames[key] .. " [" .. (f[key] and "ВКЛ" or "ВЫКЛ") .. "]"
        btn.BackgroundColor3 = f[key] and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(180, 30, 30)
    end)
    return btn
end

local function fillTab(tabName)
    for _, child in pairs(content:GetChildren()) do child:Destroy() end
    local y = 5
    local keys = featureCategories[tabName] or {}
    for _, key in pairs(keys) do
        if functionNames[key] then
            createButton(content, y, key)
            y = y + 30
        end
    end
    
    if tabName == "🏃МОБИЛ" then
        y = y + 5
        local speedLabel = Instance.new("TextLabel")
        speedLabel.Parent = content
        speedLabel.Size = UDim2.new(1, -10, 0, 25)
        speedLabel.Position = UDim2.new(0, 5, 0, y)
        speedLabel.Text = "⚡ Скорость: " .. speed
        speedLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
        speedLabel.BackgroundTransparency = 1
        speedLabel.Font = Enum.Font.GothamMedium
        speedLabel.TextSize = 12
        y = y + 28
        
        local speedBox = Instance.new("TextBox")
        speedBox.Parent = content
        speedBox.Size = UDim2.new(0.3, 
