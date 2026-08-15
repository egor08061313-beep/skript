-- ============================================
-- MM2 XENO | 100% РАБОТАЕТ
-- ============================================
local player = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")
local ws = game:GetService("Workspace")
local cam = ws.CurrentCamera
local light = game:GetService("Lighting")
local pg = player:WaitForChild("PlayerGui")

-- ===== НАСТРОЙКИ =====
local speed = 50
local flyspeed = 65
local flying = false
local flybv = nil
local esp_on = false
local kill_on = false
local farm_on = false
local noclip_on = false
local god_on = false

-- ===== SPEED =====
spawn(function()
    while wait(0.2) do
        if player.Character then
            local hum = player.Character:FindFirstChild("Humanoid")
            if hum then hum.WalkSpeed = speed end
        end
    end
end)

-- ===== ESP =====
spawn(function()
    while wait(0.3) do
        if esp_on then
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
                    elseif tool and tool.Name:lower():find("gun") then
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

-- ===== KILL AURA =====
spawn(function()
    while wait(0.1) do
        if kill_on and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, plr in pairs(game.Players:GetPlayers()) do
                    if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local hum = plr.Character:FindFirstChild("Humanoid")
                        if hum and hum.Health <= 0 then continue end
                        if (hrp.Position - plr.Character.HumanoidRootPart.Position).Magnitude < 15 then
                            hrp.CFrame = plr.Character.HumanoidRootPart.CFrame
                            wait(0.05)
                            local tool = player.Character:FindFirstChildOfClass("Tool")
                            if tool then tool:Activate() end
                        end
                    end
                end
            end
        end
    end
end)

-- ===== FARM =====
spawn(function()
    while wait(0.3) do
        if farm_on and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, obj in pairs(ws:GetChildren()) do
                    if obj:IsA("Part") and (obj.Name:lower():find("coin") or obj.Name:lower():find("money")) then
                        hrp.CFrame = obj.CFrame + Vector3.new(0, 2, 0)
                        wait(0.05)
                    end
                end
            end
        end
    end
end)

-- ===== NOCLIP =====
spawn(function()
    while wait(0.1) do
        if noclip_on and player.Character then
            for _, part in pairs(player.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- ===== GOD MODE =====
spawn(function()
    while wait(0.2) do
        if god_on and player.Character then
            local hum = player.Character:FindFirstChild("Humanoid")
            if hum then
                hum.MaxHealth = 999999
                hum.Health = 999999
            end
        end
    end
end)

-- ===== FLY (F) =====
uis.InputBegan:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.F then
        flying = not flying
        if flying and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                flybv = Instance.new("BodyVelocity")
                flybv.Name = "Fly"
                flybv.Velocity = Vector3.new(0, 0, 0)
                flybv.MaxForce = Vector3.new(100000, 100000, 100000)
                flybv.Parent = hrp
            end
        else
            if flybv then flybv:Destroy() end
        end
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if flying and player.Character then
        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
        if hrp and flybv then
            local move = Vector3.new(0, 0, 0)
            local f = cam.CFrame.LookVector
            local r = cam.CFrame.RightVector
            if uis:IsKeyDown(Enum.KeyCode.W) then move = move + f * flyspeed end
            if uis:IsKeyDown(Enum.KeyCode.S) then move = move - f * flyspeed end
            if uis:IsKeyDown(Enum.KeyCode.A) then move = move - r * flyspeed end
            if uis:IsKeyDown(Enum.KeyCode.D) then move = move + r * flyspeed end
            if uis:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, flyspeed, 0) end
            if uis:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0, flyspeed, 0) end
            flybv.Velocity = move
        end
    end
end)

-- ===== GUI =====
local screen = Instance.new("ScreenGui")
screen.Name = "MM2Hub"
screen.Parent = pg
screen.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Parent = screen
main.Size = UDim2.new(0, 300, 0, 280)
main.Position = UDim2.new(0.02, 0, 0.05, 0)
main.BackgroundColor3 = Color3.fromRGB(10, 5, 25)
main.BackgroundTransparency = 0.1
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "⚔️ MM2 HUB"
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

local function makeBtn(y, text, var)
    local btn = Instance.new("TextButton")
    btn.Parent = main
    btn.Size = UDim2.new(1, -20, 0, 28)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.Text = text .. " [ВЫКЛ]"
    btn.BackgroundColor3 = Color3.fromRGB(35, 15, 55)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 12
    btn.MouseButton1Click:Connect(function()
        if var == "esp" then esp_on = not esp_on
        elseif var == "kill" then kill_on = not kill_on
        elseif var == "farm" then farm_on = not farm_on
        elseif var == "noclip" then noclip_on = not noclip_on
        elseif var == "god" then god_on = not god_on
        end
        local state = false
        if var == "esp" then state = esp_on
        elseif var == "kill" then state = kill_on
        elseif var == "farm" then state = farm_on
        elseif var == "noclip" then state = noclip_on
        elseif var == "god" then state = god_on
        end
        btn.Text = text .. " [" .. (state and "ВКЛ" or "ВЫКЛ") .. "]"
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(180, 30, 30)
    end)
    return btn
end

makeBtn(45, "👁️ ESP", "esp")
makeBtn(78, "🗡️ Kill Aura", "kill")
makeBtn(111, "💰 Farm", "farm")
makeBtn(144, "🧱 Noclip", "noclip")
makeBtn(177, "💪 God Mode", "god")

local speedLabel = Instance.new("TextLabel")
speedLabel.Parent = main
speedLabel.Size = UDim2.new(0.5, 0, 0, 25)
speedLabel.Position = UDim2.new(0.05, 0, 0.75, 0)
speedLabel.Text = "⚡ Скорость: 50"
speedLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
speedLabel.BackgroundTransparency = 1
speedLabel.Font = Enum.Font.GothamMedium
speedLabel.TextSize = 13

local speedBox = Instance.new("TextBox")
speedBox.Parent = main
speedBox.Size = UDim2.new(0.3, 0, 0, 25)
speedBox.Position = UDim2.new(0.55, 0, 0.73, 0)
speedBox.Text = "50"
speedBox.BackgroundColor3 = Color3.fromRGB(40, 20, 60)
speedBox.TextColor3 = Color3.new(1,1,1)
speedBox.Font = Enum.Font.GothamMedium
speedBox.TextSize = 14
speedBox.FocusLost:Connect(function()
    local num = tonumber(speedBox.Text)
    if num and num > 0 then
        speed = num
        speedLabel.Text = "⚡ Скорость: " .. num
    end
end)

local info = Instance.new("TextLabel")
info.Parent = main
info.Size = UDim2.new(1, -20, 0, 20)
info.Position = UDim2.new(0, 10, 0, 250)
info.Text = "F - Полёт"
info.TextColor3 = Color3.fromRGB(150, 150, 150)
info.BackgroundTransparency = 1
info.Font = Enum.Font.GothamMedium
info.TextSize = 11

print("✅ MM2 HUB ЗАПУЩЕН!")
