RoundModifiers = {}
RoundModifiers.modifiers = {}

local files, directories =  file.Find("modifiers/")

for _, file in ipairs(files) do
    MODIFIER = {}
    include(file)
    AddCSLuaFile(file)
    local name = string.sub(file, 1, #file - 4)
    if MODIFIER.name then 
        name = MODIFIER.name 
    end

    RoundModifiers.modifiers[name] = MODIFIER
end

-- TODO support for serverside and clientside files
for _, dir in ipairs(dir) do
    local sharedFile = dir .. "/" .. "init.lua" 

    MODIFIER = {}
    include(file)
    AddCSLuaFile(file)
    local name = dir
    if MODIFIER.name then 
        name = MODIFIER.name 
    end

    RoundModifiers.modifiers[name] = MODIFIER
end
