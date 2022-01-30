hook.Add("TTTPrepareRound", "TTT_RoundModifiers_CallPrepare", function()
    for name, enabled in pairs( RoundModifiers.enabledModifiers or {} ) do
        timer.Simple(0, function()
        if enabled then
            local modifier = RoundModifiers.modifiers[name]
            if modifier and modifier.Prepare then
                modifier:Prepare()
            end
        end
        end)
    end
end)

hook.Add("TTTEndRound", "TTT_RoundModifiers_CallEnd", function(result)
    for name, enabled in pairs( RoundModifiers.enabledModifiers or {} ) do
        if enabled then
            local modifier = RoundModifiers.modifiers[name]
            if modifier and modifier.End then
                modifier:End(result)
            end
        end
    end
end)
