function MODIFIER:Setup()
    hook.Add("ScalePlayerDamage", "CFC_TTTSpecialRounds_HeadshotOnly", function( ply, hitgroup, dmginfo )
        if hitgroup ~= HITGROUP_HEAD then
            dmginfo:ScaleDamage( 0 )
        end
    end)
end

function MODIFIER:Prepare()
    timer.Simple(0, function()
        self:replaceWeapons()
    end)
end

function MODIFIER:End()
end

function MODIFIER:Teardown()
    hook.Remove("ScalePlayerDamage", "CFC_TTTSpecialRounds_HeadshotOnly")
end
