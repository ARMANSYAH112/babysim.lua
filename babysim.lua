-- 🌀 XPERIA XAO LOADING SCREEN
local player = game.Players.LocalPlayer
local loadingGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
loadingGui.Name = "XperiaXAO_Loading"
local bg = Instance.new("Frame", loadingGui)
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(15,15,40)

local label = Instance.new("TextLabel", bg)
label.Size = UDim2.new(0.6, 0, 0.1, 0)
label.Position = UDim2.new(0.2, 0, 0.45, 0)
label.Text = "🔷 XPERIA XAO LOADING..."
label.TextColor3 = Color3.fromRGB(0, 200, 255)
label.BackgroundTransparency = 1
label.TextScaled = true
label.Font = Enum.Font.GothamBlack

wait(2.5)
loadingGui:Destroy()

-- === GUI START ===
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local mainGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
mainGui.Name = "XPERIA_XAO_GUI"
mainGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 320, 0, 460)
mainFrame.Position = UDim2.new(0, 30, 0, 100)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 80)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "🍼 XPERIA XAO - BABY SIMULATOR"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundColor3 = Color3.fromRGB(80, 0, 150)
title.TextScaled = true
title.Font = Enum.Font.GothamBlack

local minimize = Instance.new("TextButton", mainFrame)
minimize.Size = UDim2.new(0, 30, 0, 30)
minimize.Position = UDim2.new(1, -35, 0, 5)
minimize.Text = "−"
minimize.TextColor3 = Color3.new(1,1,1)
minimize.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
minimize.Font = Enum.Font.GothamBold
minimize.TextScaled = true

local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Position = UDim2.new(0, 0, 0, 45)
contentFrame.Size = UDim2.new(1, 0, 1, -45)
contentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 60)

local minimized = false
minimize.MouseButton1Click:Connect(function()
	minimized = not minimized
	contentFrame.Visible = not minimized
	minimize.Text = minimized and "+" or "−"
end)

-- AREA LIST
local areaList = {
	"Spawn", "Candy Land", "Toy Land", "Beach", "Snow Land",
	"Lava World", "Moon", "Heaven"
}
local areaCFrames = {
	["Spawn"] = CFrame.new(0, 3, 0),
	["Candy Land"] = CFrame.new(250, 10, 100),
	["Toy Land"] = CFrame.new(500, 10, 100),
	["Beach"] = CFrame.new(750, 10, 100),
	["Snow Land"] = CFrame.new(1000, 10, 100),
	["Lava World"] = CFrame.new(1250, 10, 100),
	["Moon"] = CFrame.new(1500, 10, 100),
	["Heaven"] = CFrame.new(1750, 10, 100)
}

local currentArea = 1
local tpDropdown = Instance.new("TextButton", contentFrame)
tpDropdown.Size = UDim2.new(1, -10, 0, 40)
tpDropdown.Position = UDim2.new(0, 5, 0, 10)
tpDropdown.Text = "🌍 Teleport Area (Click)"
tpDropdown.BackgroundColor3 = Color3.fromRGB(60, 0, 120)
tpDropdown.TextColor3 = Color3.new(1,1,1)
tpDropdown.Font = Enum.Font.GothamBold
tpDropdown.TextScaled = true
tpDropdown.MouseButton1Click:Connect(function()
	currentArea = currentArea % #areaList + 1
	local selected = areaList[currentArea]
	tpDropdown.Text = "🌍 Teleport: " .. selected
	local cf = areaCFrames[selected]
	if cf and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		player.Character.HumanoidRootPart.CFrame = cf
	end
end)

-- BUTTONS & FLAGS
local autoFarm, autoRebirth, autoKill = false, false, false

local function createButton(name, posY, color, toggleCallback)
	local btn = Instance.new("TextButton", contentFrame)
	btn.Size = UDim2.new(1, -10, 0, 40)
	btn.Position = UDim2.new(0, 5, 0, posY)
	btn.Text = name .. ": OFF"
	btn.BackgroundColor3 = color
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	btn.TextScaled = true
	btn.MouseButton1Click:Connect(function()
		_G[name] = not _G[name]
		btn.Text = name .. (_G[name] and ": ON" or ": OFF")
		toggleCallback(_G[name])
	end)
end

createButton("🍶 Auto Farm", 0.15, Color3.fromRGB(0,150,255), function(v) autoFarm = v end)
createButton("🔁 Auto Rebirth", 0.26, Color3.fromRGB(255,100,0), function(v) autoRebirth = v end)
createButton("💥 Auto Kill", 0.37, Color3.fromRGB(255,0,100), function(v) autoKill = v end)

-- TP TO PLAYER
local tpPlayerBtn = Instance.new("TextButton", contentFrame)
tpPlayerBtn.Size = UDim2.new(1, -10, 0, 40)
tpPlayerBtn.Position = UDim2.new(0, 5, 0.48, 0)
tpPlayerBtn.Text = "📍 TP to Player (First)"
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

-- AUTO KICK
local kickBtn = Instance.new("TextButton", contentFrame)
kickBtn.Size = UDim2.new(1, -10, 0, 40)
kickBtn.Position = UDim2.new(0, 5, 0.59, 0)
kickBtn.Text = "🦶 Kick Player (First)"
kickBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
kickBtn.TextColor3 = Color3.new(1,1,1)
kickBtn.Font = Enum.Font.GothamBold
kickBtn.TextScaled = true
kickBtn.MouseButton1Click:Connect(function()
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= player then
			pcall(function()
				plr:Kick("Kicked by XPERIA XAO")
			end)
			break
		end
	end
end)

-- MAIN LOOP
RunService.RenderStepped:Connect(function()
	if autoFarm then
		local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
		if tool and tool:FindFirstChild("RemoteEvent") then
			pcall(function()
				tool.RemoteEvent:FireServer()
			end)
		end
	end
	if autoRebirth then
		local rebirthRemote = player:FindFirstChild("RebirthEvent", true)
		if rebirthRemote then
			pcall(function()
				rebirthRemote:FireServer()
			end)
		end
	end
	if autoKill then
		for _, target in pairs(Players:GetPlayers()) do
			if target ~= player and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
				player.Character:MoveTo(target.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0))
				wait(0.3)
				if not autoKill then break end
			end
		end
	end
end)
