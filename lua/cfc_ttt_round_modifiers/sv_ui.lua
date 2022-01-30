util.AddNetworkString("TTT_RoundModifiers_EnableModifier")
util.AddNetworkString("TTT_RoundModifiers_SyncEnabledModifiers")
util.AddNetworkString("TTT_RoundModifiers_RequestDataUpdate")
net.Receive("TTT_RoundModifiers_RequestDataUpdate", function(len, ply)
    net.Start("TTT_RoundModifiers_SyncEnabledModifiers")
            net.WriteTable(RoundModifiers.enabledModifiers)
    net.Send(ply)
end)

net.Receive("TTT_RoundModifiers_EnableModifier", function(len, ply)
    if not ply:IsAdmin() then return end
    local modifierName = net.ReadString()
    local enabled = net.ReadBool()
    
    local modifier = RoundModifiers.modifiers[modifierName]
    if not modifier then return end
    
    if enabled and not RoundModifiers.enabledModifiers[modifierName] then
        RoundModifiers.EnableModifier(modifierName)
        net.Start("TTT_RoundModifiers_SyncEnabledModifiers")
            net.WriteTable(RoundModifiers.enabledModifiers)
        net.Broadcast()
    elseif not enabled and RoundModifiers.enabledModifiers[modifierName] then
        RoundModifiers.DisableModifier(modifierName)
        net.Start("TTT_RoundModifiers_SyncEnabledModifiers")
            net.WriteTable(RoundModifiers.enabledModifiers)
        net.Broadcast()
    end
    RoundModifiers.enabledModifiers[modifierName] = enabled
end)