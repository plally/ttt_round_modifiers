local allowedWeapons = {
    weapon_zm_carry = true,
    weapon_ttt_unarmed = true,
}

function MODIFIER:Prepare()
    hook.Add("ScalePlayerDamage", "CFC_TTTSpecialRounds_HeadshotOnly", function( ply, hitgroup, dmginfo )
        if hitgroup ~= HITGROUP_HEAD then
            dmginfo:ScaleDamage( 0 )
        end
    end)

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

function MODIFIER:Cleanup()
    hook.Remove("ScalePlayerDamage", "CFC_TTTSpecialRounds_HeadshotOnly")
end
