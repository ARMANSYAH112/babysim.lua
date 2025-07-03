local Players = game:GetService("Players")
local player = Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- GUI
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "XPERIA_XAO_GUI"

local mainFrame = Instance.new("Frame", ScreenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0, 30, 0, 100)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 100)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "🍼 XPERIA XAO - BABY SIMULATOR"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(80, 0, 150)
title.TextScaled = true
title.Font = Enum.Font.GothamBlack

local minimize = Instance.new("TextButton", mainFrame)
minimize.Size = UDim2.new(0, 30, 0, 30)
minimize.Position = UDim2.new(1, -35, 0, 5)
minimize.Text = "-"
minimize.TextColor3 = Color3.new(1,1,1)
minimize.BackgroundColor3 = Color3.fromRGB(150,0,0)
minimize.Font = Enum.Font.GothamBold
minimize.TextScaled = true

local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Position = UDim2.new(0, 0, 0, 45)
contentFrame.Size = UDim2.new(1, 0, 1, -45)
contentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 60)

-- Toggle
local minimized = false
minimize.MouseButton1Click:Connect(function()
	minimized = not minimized
	contentFrame.Visible = not minimized
	minimize.Text = minimized and "+" or "-"
end)

-- Area Dropdown
local areaList = {
	"Spawn", "Candy Land", "Toy Land", "Beach", "Snow Land",
	"Lava World", "Moon", "Heaven"
}

local tpDropdown = Instance.new("TextButton", contentFrame)
tpDropdown.Size = UDim2.new(1, -10, 0, 40)
tpDropdown.Position = UDim2.new(0, 5, 0, 10)
tpDropdown.Text = "🌍 Teleport Area (Click to Cycle)"
tpDropdown.BackgroundColor3 = Color3.fromRGB(60, 0, 120)
tpDropdown.TextColor3 = Color3.new(1,1,1)
tpDropdown.Font = Enum.Font.GothamBold
tpDropdown.TextScaled = true

local currentArea = 1
tpDropdown.MouseButton1Click:Connect(function()
	currentArea = currentArea % #areaList + 1
	tpDropdown.Text = "🌍 Teleport: " .. areaList[currentArea]
	-- Ganti ini dengan koordinat asli tiap area jika tersedia
	player.Character:MoveTo(Vector3.new(0, 3, currentArea * 100))
end)

-- Auto Farm Toggle
local autoFarm = false
local farmButton = Instance.new("TextButton", contentFrame)
farmButton.Size = UDim2.new(1, -10, 0, 40)
farmButton.Position = UDim2.new(0, 5, 0, 60)
farmButton.Text = "🍶 Auto Farm: OFF"
farmButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
farmButton.TextColor3 = Color3.new(1,1,1)
farmButton.Font = Enum.Font.GothamBold
farmButton.TextScaled = true

farmButton.MouseButton1Click:Connect(function()
	autoFarm = not autoFarm
	farmButton.Text = autoFarm and "🍶 Auto Farm: ON" or "🍶 Auto Farm: OFF"
end)

-- Auto Rebirth
local autoRebirth = false
local rebirthBtn = Instance.new("TextButton", contentFrame)
rebirthBtn.Size = UDim2.new(1, -10, 0, 40)
rebirthBtn.Position = UDim2.new(0, 5, 0, 110)
rebirthBtn.Text = "🔁 Auto Rebirth: OFF"
rebirthBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
rebirthBtn.TextColor3 = Color3.new(1,1,1)
rebirthBtn.Font = Enum.Font.GothamBold
rebirthBtn.TextScaled = true

rebirthBtn.MouseButton1Click:Connect(function()
	autoRebirth = not autoRebirth
	rebirthBtn.Text = autoRebirth and "🔁 Auto Rebirth: ON" or "🔁 Auto Rebirth: OFF"
end)

-- Auto Kill
local autoKill = false
local killBtn = Instance.new("TextButton", contentFrame)
killBtn.Size = UDim2.new(1, -10, 0, 40)
killBtn.Position = UDim2.new(0, 5, 0, 160)
killBtn.Text = "💥 Auto Kill: OFF"
killBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
killBtn.TextColor3 = Color3.new(1,1,1)
killBtn.Font = Enum.Font.GothamBold
killBtn.TextScaled = true

killBtn.MouseButton1Click:Connect(function()
	autoKill = not autoKill
	killBtn.Text = autoKill and "💥 Auto Kill: ON" or "💥 Auto Kill: OFF"
end)

-- TP to Player
local tpPlayerBtn = Instance.new("TextButton", contentFrame)
tpPlayerBtn.Size = UDim2.new(1, -10, 0, 40)
tpPlayerBtn.Position = UDim2.new(0, 5, 0, 210)
tpPlayerBtn.Text = "📍 TP to Player (First Found)"
tpPlayerBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
tpPlayerBtn.TextColor3 = Color3.new(1,1,1)
tpPlayerBtn.Font = Enum.Font.GothamBold
tpPlayerBtn.TextScaled = true

tpPlayerBtn.MouseButton1Click:Connect(function()
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			player.Character:MoveTo(plr.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0))
			break
		end
	end
end)

-- Auto Loops
RunService.RenderStepped:Connect(function()
	if autoFarm then
		local milk = player.Character:FindFirstChild("Milk") or player.Character:FindFirstChildOfClass("Tool")
		if milk then
			fireclickdetector(milk:FindFirstChildWhichIsA("ClickDetector") or milk:FindFirstChild("Click"))
		end
	end

	if autoRebirth then
		local remote = player:FindFirstChild("RebirthEvent", true)
		if remote then
			remote:FireServer()
		end
	end

	if autoKill then
		for _, target in pairs(Players:GetPlayers()) do
			if target ~= player and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
				player.Character:MoveTo(target.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0))
				wait(0.5)
			end
		end
	end
end)
