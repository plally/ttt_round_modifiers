RoundModifiers = {}
RoundModifiers.modifiers = {}

local files, directories =  file.Find("modifiers/*", "LUA")

for _, f in ipairs(files or {}) do
    filename = "modifiers/" .. f
    MODIFIER = {}
    include(filename)
    AddCSLuaFile(filename)
    local name = string.sub(filename, 1, #filename - 4)
    if MODIFIER.name then 
        name = MODIFIER.name 
    end

    RoundModifiers.modifiers[name] = MODIFIER
    MODIFIER = nil
end

-- TODO support for serverside and clientside files
for _, dir in ipairs(directories or {}) do
    local sharedFile = "modifiers/" .. dir .. "/" .. "sh_init.lua" 

    MODIFIER = {}
    include(sharedFile)
    AddCSLuaFile(sharedFile)
    local name = dir
    if MODIFIER.name then 
        name = MODIFIER.name 
    end

    RoundModifiers.modifiers[name] = MODIFIER
    MODIFIER = nil
end
