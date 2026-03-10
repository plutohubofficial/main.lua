-- [[ BLOXBURG ULTIMATE DETECTION ENGINE ]]
-- PURPOSE: 100% CERTAINTY OF ACCOUNT TERMINATION / SERVER KICK
-- COMBINES: REMOTE SPAM + TELEPORT LOOP + MEMORY BLOAT + PACKET OVERLOAD

print("Delta: Initiating Full-Spectrum Detection...")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local NetworkSettings = settings().Network

-- 1. FLAG #1: IMPOSSIBLE NETWORK LATENCY
-- Forces the engine to a state that is physically impossible for a human connection.
NetworkSettings.IncomingReplicationLag = 999999

-- 2. FLAG #2: THE REMOTE EVENT "HURRICANE"
-- This finds every single RemoteEvent in the game and spams them with corrupt data.
task.spawn(function()
    local Remotes = {}
    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") then table.insert(Remotes, v) end
    end

    while true do
        for _, remote in pairs(Remotes) do
            for i = 1, 100 do -- 100 packets per remote per frame
                pcall(function()
                    -- Sending 'math.huge' (Infinity) triggers an Overflow Error in the server logs.
                    remote:FireServer("DETECTION_TEST_DATA", {["Overload"] = math.huge, ["Spam"] = string.rep("BAN_ME_", 500)})
                end)
            end
        end
        RunService.Heartbeat:Wait()
    end
end)

-- 3. FLAG #3: RECURSIVE NEIGHBORHOOD JOINING
-- This spams the 'Join' signal to hundreds of random IDs per second.
task.spawn(function()
    local JoinRemote = ReplicatedStorage:FindFirstChild("JoinNeighborhood", true)
    while true do
        if JoinRemote then
            for i = 1, 50 do
                JoinRemote:FireServer(tostring(math.random(100000, 999999)))
            end
        end
        task.wait(0.1)
    end
end)

-- 4. FLAG #4: CLIENT-SIDE FREEZE (STALL)
-- This creates so much local lag that the 'Heartbeat' signal to the server stops,
-- which the server sees as a 'Timed Out' or 'Script Injection' freeze.
task.spawn(function()
    local Bloat = {}
    while true do
        -- Fills RAM until the OS starts to struggle
        for i = 1, 100000 do
            table.insert(Bloat, "MEMORY_OVERFLOW_STRING_")
        end
        -- Heavy CPU loop
        local s = tick()
        while tick() - s < 0.5 do end 
        task.wait()
    end
end)

-- 5. FLAG #5: FORCED TELEPORT REQUESTS
-- Tells the server you are trying to leave and join at the same time.
task.spawn(function()
    while true do
        pcall(function()
            TeleportService:Teleport(185655149) -- Bloxburg PlaceID
        end)
        task.wait(0.2)
    end
end)

print("Delta: All flags active. Goodbye account.")
