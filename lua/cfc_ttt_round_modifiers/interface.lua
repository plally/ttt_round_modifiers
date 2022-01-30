RoundModifiers.enabledModifiers = RoundModifiers.enabledModifiers or {}

 -- returns bool success
function RoundModifiers.EnableModifier(name)
    local modifier = RoundModifiers.modifiers[name]
    if not modifier then return false end
    if modifier.Setup then modifier:Setup() end

    RoundModifiers.enabledModifiers[name] = true

    return true
end

function RoundModifiers.DisableModifier(name)
    local modifier = RoundModifiers.modifiers[name]
    if not modifier then return false end
    if modifier.Teardown then modifier:Teardown() end
    
    RoundModifiers.enabledModifiers[name] = false

    return true
end