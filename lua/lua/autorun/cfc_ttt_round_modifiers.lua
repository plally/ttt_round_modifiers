RoundModifiers = {}
RoundModifiers.modifiers = {}

local files, directories =  file.Find("modifiers/*", "LUA")

for _, file in ipairs(files or {}) do
    MODIFIER = {}
    include(file)
    AddCSLuaFile(file)
    local name = string.sub(file, 1, #file - 4)
    if MODIFIER.name then 
        name = MODIFIER.name 
    end

    RoundModifiers.modifiers[name] = MODIFIER
    MODIFIER = nil
end

-- TODO support for serverside and clientside files
for _, dir in ipairs(dir or {}) do
    local sharedFile = dir .. "/" .. "sh_init.lua" 

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
