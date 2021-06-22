-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Exarch Maladaar", 558, 524)
if not mod then return end
mod:RegisterEnableMob(18373)
-- mod.engageId = 1889 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L.avatar = "Avatar of the Martyred"
	L.avatar_desc = "When Exarch Maladaar reaches 25% remaining health, he summons an Avatar of the Martyred."
	L.avatar_icon = "Spell_Shadow_RaiseDead"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		32346, -- Stolen Soul
		"avatar", -- Summon Avatar
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "StolenSoul", 32346)
	self:Log("SPELL_CAST_SUCCESS", "AvatarOfTheMartyred", 32424)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:Death("Win", 18373)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:RegisterEvent("UNIT_HEALTH")
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:StolenSoul(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange")
end

function mod:AvatarOfTheMartyred(args)
	self:MessageOld("avatar", "red", "info", CL.spawned:format(L.avatar), args.spellId)
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) ~= 18373 then return end
	local hp = mod:GetHealth(unit)
	if hp < 30 then
		self:UnregisterEvent(event)
		self:MessageOld("avatar", "yellow", nil, CL.soon:format(L.avatar), 32424)
	end
end
