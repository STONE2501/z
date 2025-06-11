local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "GrowGUI"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 200)
frame.Position = UDim2.new(0.5, -120, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🌱 Grow a Garden Hub"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = frame

local seedBtn = Instance.new("TextButton")
seedBtn.Size = UDim2.new(0.9, 0, 0, 40)
seedBtn.Position = UDim2.new(0.05, 0, 0.4, -20)
seedBtn.Text = "Start Seed Duplication"
seedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
seedBtn.TextColor3 = Color3.new(1,1,1)
seedBtn.Font = Enum.Font.SourceSansBold
seedBtn.TextSize = 16
seedBtn.Parent = frame

local petBtn = Instance.new("TextButton")
petBtn.Size = UDim2.new(0.9, 0, 0, 40)
petBtn.Position = UDim2.new(0.05, 0, 0.7, -20)
petBtn.Text = "Start Pet Duplication"
petBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 180)
petBtn.TextColor3 = Color3.new(1,1,1)
petBtn.Font = Enum.Font.SourceSansBold
petBtn.TextSize = 16
petBtn.Parent = frame

-- 🌀 ตัวแปรควบคุม Loop
local seedLoop = false
local petLoop = false

-- 📦 เตรียม Remote
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EquipPet = ReplicatedStorage:WaitForChild("EquipPet")
local seedEvent = nil -- ใส่ชื่อ Event จริงที่จับได้จาก Sniffer (ถ้ามี)

-- 🧪 กำหนดชื่อสัตว์เลี้ยงที่คุณมีจริง
local petName = "Raccoon" -- เปลี่ยนตามสัตว์ที่คุณมี

-- 🌱 ปุ่ม Seed Duplication
seedBtn.MouseButton1Click:Connect(function()
    seedLoop = not seedLoop
    seedBtn.Text = seedLoop and "Stop Seed Duplication" or "Start Seed Duplication"
    if seedLoop then
        spawn(function()
            while seedLoop do
                if seedEvent then
                    pcall(function()
                        seedEvent:FireServer("CarrotSeed") -- ใส่ชื่อ seed ที่คุณมี
                    end)
                end
                wait(0.15)
            end
        end)
    end
end)

-- 🐾 ปุ่ม Pet Duplication
petBtn.MouseButton1Click:Connect(function()
    petLoop = not petLoop
    petBtn.Text = petLoop and "Stop Pet Duplication" or "Start Pet Duplication"
    if petLoop then
        spawn(function()
            while petLoop do
                pcall(function()
                    EquipPet:FireServer(petName)
                end)
                wait(0.2)
            end
        end)
    end
end)

