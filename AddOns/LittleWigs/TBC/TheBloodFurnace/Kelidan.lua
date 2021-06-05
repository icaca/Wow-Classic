-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Keli'dan the Breaker", 542, 557)
if not mod then return end
mod:RegisterEnableMob(17377)
-- mod.engageId = 1923 -- no boss frames, no ENCOUNTER_END on a wipe
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.burning_nova = "Burning Nova"
	L.burning_nova_desc = "Keli'dan the Breaker banishes himself, making him invulnerable, and begins to cast a Fire Nova. Fire Nova inflicts Fire damage to all players within 20 yards of Keli'dan when he completes his cast."
	L.burning_nova_icon = "Spell_Shadow_Cripple"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"burning_nova", -- Burning Nova
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "BurningNova", 30940) -- the buff that he applies to himself before casting the spell (37371) that does the damage

	self:Death("Win", 17377)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:BurningNova(args)
	self:MessageOld("burning_nova", "red", nil, CL.casting:format(args.spellName), L.burning_nova_icon)
	self:CastBar("burning_nova", 6, L.burning_nova, L.burning_nova_icon)
end
