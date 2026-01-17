-- 🔥 STICKY INSTA STEAL 🔥
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local savedPosition = nil
local espLines = {}

-- Supprime ancien GUI
pcall(function()
    player.PlayerGui:FindFirstChild("StickyInstaSteal"):Destroy()
end)

-- GUI comme l'image
local gui = Instance.new("ScreenGui")
gui.Name = "StickyInstaSteal"
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 120)
frame.Position = UDim2.new(0.5, -150, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Coins arrondis
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

-- Titre exact comme l'image
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Sticky Insta Steal 🔥"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- Sous-titre
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 0, 35)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Stealing In Progress..."
subtitle.TextColor3 = Color3.fromRGB(150, 150, 150)
subtitle.TextSize = 12
subtitle.Font = Enum.Font.Gotham
subtitle.Parent = frame

-- Bouton Set Position avec coche verte
local setBtn = Instance.new("TextButton")
setBtn.Size = UDim2.new(0.8, 0, 0, 35)
setBtn.Position = UDim2.new(0.1, 0, 0, 70)
setBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
setBtn.Text = "Set Position ✅"
setBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
setBtn.TextSize = 14
setBtn.Font = Enum.Font.GothamBold
setBtn.Parent = frame

local setBtnCorner = Instance.new("UICorner")
setBtnCorner.CornerRadius = UDim.new(0, 8)
setBtnCorner.Parent = setBtn

-- Fonction pour créer les lignes ESP
local function createESPLine(targetPos)
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local line = Instance.new("Part")
    line.Name = "ESPLine"
    line.Anchored = true
    line.CanCollide = false
    line.Material = Enum.Material.Neon
    line.BrickColor = BrickColor.new("Bright orange")
    line.Size = Vector3.new(0.2, 0.2, (char.HumanoidRootPart.Position - targetPos).Magnitude)
    line.CFrame = CFrame.lookAt(char.HumanoidRootPart.Position:Lerp(targetPos, 0.5), targetPos)
    line.Parent = workspace
    
    table.insert(espLines, line)
    
    -- Supprime la ligne après 3 secondes
    spawn(function()
        wait(3)
        if line and line.Parent then
            line:Destroy()
        end
    end)
end

-- Fonction TP instantané
local function stickySteal()
    if savedPosition then
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            -- Crée la ligne ESP orange
            createESPLine(savedPosition)
            
            -- TP instantané
            char.HumanoidRootPart.CFrame = CFrame.new(savedPosition)
            
            -- Animation du texte
            subtitle.Text = "🔥 STOLEN! Teleporting..."
            subtitle.TextColor3 = Color3.fromRGB(255, 100, 0)
            
            wait(1)
            subtitle.Text = "Stealing In Progress..."
            subtitle.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
    end
end

-- Set Position
setBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        savedPosition = char.HumanoidRootPart.Position
        setBtn.Text = "Position Set ✅"
        setBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        
        wait(1.5)
        setBtn.Text = "Set Position ✅"
        setBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

-- Auto steal quand tu ramasses
player.Backpack.ChildAdded:Connect(function(child)
    if child:IsA("Tool") then
        stickySteal()
    end
end)

if player.Character then
    player.Character.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            stickySteal()
        end
    end)
end

player.CharacterAdded:Connect(function(char)
    char.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            stickySteal()
        end
    end)
end)

print("🔥 STICKY INSTA STEAL LOADED!")
