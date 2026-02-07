-- LocalScript (StarterPlayer > StarterPlayerScripts)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GrassFarmGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 220)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainFrame

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 65)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 35))
}
gradient.Rotation = 45
gradient.Parent = mainFrame

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundTransparency = 1
titleBar.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "GRASS INCREMENTAL"
title.TextColor3 = Color3.fromRGB(0, 255, 150)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 2.5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

local farmBtn = Instance.new("TextButton")
farmBtn.Size = UDim2.new(0.43, 0, 0, 50)
farmBtn.Position = UDim2.new(0.035, 0, 0, 50)
farmBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
farmBtn.Text = "ATIVAR FARM"
farmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
farmBtn.TextScaled = true
farmBtn.Font = Enum.Font.GothamBold
farmBtn.Parent = mainFrame

local farmCorner = Instance.new("UICorner")
farmCorner.CornerRadius = UDim.new(0, 12)
farmCorner.Parent = farmBtn

local upgradeBtn = Instance.new("TextButton")
upgradeBtn.Size = UDim2.new(0.43, 0, 0, 50)
upgradeBtn.Position = UDim2.new(0.525, 0, 0, 50)
upgradeBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 255)
upgradeBtn.Text = "MAX UPGRADES"
upgradeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
upgradeBtn.TextScaled = true
upgradeBtn.Font = Enum.Font.GothamBold
upgradeBtn.Parent = mainFrame

local upgradeCorner = Instance.new("UICorner")
upgradeCorner.CornerRadius = UDim.new(0, 12)
upgradeCorner.Parent = upgradeBtn

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0.9, 0, 0, 35)
statusLabel.Position = UDim2.new(0.05, 0, 0, 115)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status: Parado"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = mainFrame

local farmEnabled = false
local connection

local function increasePop()
    local args = {true}
    pcall(function()
        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("IncreasePop"):FireServer(unpack(args))
    end)
end

local function collectGrass()
    local args = {
        {
            normal = 1,
            ruby = 1,
            silver = 1,
            golden = 1,
            diamond = 1
        }
    }
    pcall(function()
        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("GrassCollect"):FireServer(unpack(args))
    end)
end

local function executeCodeUpgrades()
    local remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Upgrade")
    
    local codeUpgrades = {
        
        {currencyName = "Code", amount = 999999999999999, max = 999999999999999, upgradeValue = "GrassCode"},
        {currencyName = "Pop", amount = 1e+42, max = 1e+42, upgradeValue = "Programmers"},
        {currencyName = "Code", amount = 999999999999999, max = 999999999999999, upgradeValue = "RebirthCode"}
    }
    
    for i, upgrade in ipairs(codeUpgrades) do
        local args = {
            {
                {
                    currencyName = upgrade.currencyName,
                    autoBuy = false,
                    amount = upgrade.amount,
                    max = upgrade.amount,
                    upgradeValue = upgrade.upgradeValue,
                    cost = 0
                }
            }
        }
        pcall(function()
            remote:FireServer(unpack(args))
        end)
        task.wait(0.1)
    end
end

local function maxUpgrades()
    local remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Upgrade")
    
    local upgrades = {
        -- Grass upgrades
        {currencyName = "Grass", amount = 7, max = 7, upgradeValue = "SpawnRate1"},
        {currencyName = "Grass", amount = 99, max = 99, upgradeValue = "GrassValue"},
        {currencyName = "Grass", amount = 49, max = 49, upgradeValue = "GrassAmount"},
        -- Rebirth upgrades
        {currencyName = "Rebirth", amount = 5, max = 5, upgradeValue = "BladeRadius"},
        {currencyName = "Rebirth", amount = 8, max = 8, upgradeValue = "SpawnRate2"},
        {currencyName = "Rebirth", amount = 6, max = 6, upgradeValue = "GrassValue2"},
        -- Pop upgrades
        {currencyName = "Pop", amount = 10, max = 10, upgradeValue = "GrassValue4"},
        {currencyName = "Pop", amount = 10, max = 10, upgradeValue = "AutoClick"},
        {currencyName = "Pop", amount = 10, max = 10, upgradeValue = "RebirthValue2"},
        -- NOVOS CODE UPGRADES (INTEGRADOS)
        {currencyName = "Code", amount = 9.99e666, max = 9.99e666, upgradeValue = "GrassCode"},
        {currencyName = "Pop", amount = 9.99e666, max = 9.99e666, upgradeValue = "Programmers"},
        {currencyName = "Code", amount = 9.99e666, max = 9.99e666, upgradeValue = "RebirthCode"}
    }
    
    for i, upgrade in ipairs(upgrades) do
        local args = {
            {
                {
                    currencyName = upgrade.currencyName,
                    autoBuy = false,
                    amount = upgrade.amount,
                    max = upgrade.max,
                    upgradeValue = upgrade.upgradeValue,
                    cost = 0
                }
            }
        }
        pcall(function()
            remote:FireServer(unpack(args))
        end)
        task.wait(0.1)
    end
end


farmBtn.MouseButton1Click:Connect(function()
    farmEnabled = not farmEnabled
    
    if farmEnabled then
        farmBtn.Text = "STOP FARM"
        farmBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
        statusLabel.Text = "FARM ON"
        statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
        
       
        executeCodeUpgrades()
        
        connection = RunService.Heartbeat:Connect(function()
            if farmEnabled then
                collectGrass()
                task.wait(0.001)
                increasePop()
                task.wait(0.01)
            end
        end)
    else
        farmBtn.Text = "AUTO FARM"
        farmBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        statusLabel.Text = "Status: OFF"
        statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        
        if connection then
            connection:Disconnect()
        end
    end
end)

upgradeBtn.MouseButton1Click:Connect(function()
    statusLabel.Text = "EXECUTING..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    
    spawn(function()
        maxUpgrades()
        statusLabel.Text = "CLAIMED!"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        
        task.wait(2)
        if not farmEnabled then
            statusLabel.Text = "Status: OFF"
            statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
    end)
end)

closeBtn.MouseButton1Click:Connect(function()
    farmEnabled = false
    if connection then
        connection:Disconnect()
    end
    screenGui:Destroy()
end)

local dragging = false
local dragStart = nil
local startPos = nil

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        mainFrame.ZIndex = 10
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

local function addHover(button)
    local originalSize = button.Size
    local originalPos = button.Position
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            Size = UDim2.new(originalSize.X.Scale * 1.05, originalSize.X.Offset, originalSize.Y.Scale * 1.05, originalSize.Y.Offset),
            Position = UDim2.new(originalPos.X.Scale, originalPos.X.Offset - 2, originalPos.Y.Scale, originalPos.Y.Offset - 2)
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            Size = originalSize,
            Position = originalPos
        }):Play()
    end)
end

addHover(farmBtn)
addHover(upgradeBtn)
addHover(closeBtn)

mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame.BackgroundTransparency = 1
TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
    Size = UDim2.new(0, 320, 0, 220),
    BackgroundTransparency = 0
}):Play()
