local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Grass Incremental Hub",
   LoadingTitle = "Rayfield Interface Suite",
   LoadingSubtitle = "by Sirius",
   KeySystem = true,
   KeySettings = {
      Title = "Grass Incremental Hub",
      Subtitle = "Key System",
      Note = "67",
      FileName = "GrassKey",
      SaveKey = false,
      GrabKeyFromSite = false,
      Key = {"feldlena"}
   },
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil,
      FileName = "GrassHub"
   }
})

local Tab = Window:CreateTab("Main", nil)
Tab:CreateSection("Features")

local farmEnabled = false

-- Auto Farm Toggle
Tab:CreateToggle({
   Name = "Auto Farm",
   CurrentValue = false,
   Flag = "AutoFarm",
   Callback = function(Value)
      farmEnabled = Value
   end,
})

-- Max Upgrades Button
Tab:CreateButton({
   Name = "Max Upgrades",
   Callback = function()
      spawn(function()
         local remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Upgrade")
         
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
             -- Code upgrades
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
      end)
   end,
})

print("🌿 Grass Incremental Hub")

-- Main Loop
spawn(function()
   while task.wait(0.001) do
      if farmEnabled then
         -- Collect Grass
         pcall(function()
            local args = {
               {
                  normal = 1,
                  ruby = 1,
                  silver = 1,
                  golden = 1,
                  diamond = 1
               }
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("GrassCollect"):FireServer(unpack(args))
         end)
         
         task.wait(0.001)
         
         -- Increase Pop
         pcall(function()
            local args = {true}
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("IncreasePop"):FireServer(unpack(args))
         end)
      end
   end
end)      }):Play()
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
