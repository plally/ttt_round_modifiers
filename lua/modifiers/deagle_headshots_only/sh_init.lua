local allowedWeapons = {
    weapon_zm_carry = true,
    weapon_ttt_unarmed = true,
}

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

function MODIFIER:replaceWeapons()
    for _, ent in pairs(ents.GetAll()) do
        if ent:IsWeapon() and not IsValid(ent:GetOwner()) then
            local newEnt = ents.Create("weapon_zm_revolver")
            newEnt:SetPos(ent:GetPos())
            newEnt:SetAngles(ent:GetAngles())
            ent:Remove()
            newEnt:Spawn()
        elseif ent:IsWeapon() and not allowedWeapons[ent:GetClass()] then
            ent:Remove()
        elseif ent.Base == "base_ammo_ttt" then
            local newEnt = ents.Create("item_ammo_smg1_ttt")
            newEnt:SetPos(ent:GetPos())
            newEnt:SetAngles(ent:GetAngles())
            ent:Remove()
            newEnt:Spawn()
        end
    end
end

function MODIFIER:Teardown()
    hook.Remove("ScalePlayerDamage", "CFC_TTTSpecialRounds_HeadshotOnly")
end
