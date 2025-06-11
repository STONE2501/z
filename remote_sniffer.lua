
-- 🔧 RemoteEvent / RemoteFunction Sniffer Script (Spy Tool)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local mt = getrawmetatable(game)
setreadonly(mt, false)

local oldNamecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if method == "FireServer" or method == "InvokeServer" then
        if typeof(self) == "Instance" and (self:IsA("RemoteEvent") or self:IsA("RemoteFunction")) then
            warn("====[ Remote Called ]====")
            print("🔹 Name:", self:GetFullName())
            print("🔸 Method:", method)
            for i,v in ipairs(args) do
                print("   Arg["..i.."]:", v)
            end
            warn("=========================")
        end
    end
    return oldNamecall(self, ...)
end)

print("[✅] Remote Sniffer Loaded - Trigger GUI actions and check F9 console.")
