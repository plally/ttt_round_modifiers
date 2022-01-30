RoundModifiers.enabledModifiers = RoundModifiers.enabledModifiers or {}
net.Start("TTT_RoundModifiers_RequestDataUpdate")
net.SendToServer()

net.Receive("TTT_RoundModifiers_SyncEnabledModifiers", function(len, ply)
    RoundModifiers.enabledModifiers = net.ReadTable()
end)

concommand.Add("ttt_roundmodifiers", function( ply, cmd, args )
    local frame = vgui.Create( "DFrame" )
    frame:SetSize( 300, 500 )
    frame:Center()
    frame:MakePopup()
    
    local scrollArea = vgui.Create( "DScrollPanel", frame )
    scrollArea:Dock( FILL )
    
    for k, v in pairs(RoundModifiers.modifiers) do
        local checkboxLabel = vgui.Create( "DCheckBoxLabel" )
        checkboxLabel:SetPos( 25, 50 )
        checkboxLabel:SetText(k)
        checkboxLabel:SetValue( RoundModifiers.enabledModifiers[k] or false )
        checkboxLabel:SizeToContents()
        checkboxLabel.OnChange = function(self, val)
            net.Start("TTT_RoundModifiers_EnableModifier")
                net.WriteString(k)
                net.WriteBool(val)
            net.SendToServer()
        end
        scrollArea:AddItem(checkboxLabel)
    end
end)