-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Hungarfen", 546, 576)
if not mod then return end
mod:RegisterEnableMob(17770)
-- mod.engageId = 1946 -- doesn't fire ENCOUNTER_END on a wipe
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.foul_spores = "Foul Spores"
	L.foul_spores_desc = "When Hungarfen reaches 20% health remaining he releases foul spores, leeching 400 health from all players within 15 yards every second for 11 sec."
	L.foul_spores_icon = "Spell_Nature_StrangleVines"

	L.mushroom = "Underbog Mushroom"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"foul_spores", -- Foul Spores
		{31689, "ME_ONLY"}, -- Spore Cloud
	}, {
		["foul_spores"] = "general",
		[31689] = L.mushroom, -- Underbog Mushroom
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "SporeCloud", 31689)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SporeCloud", 31689)
	self:Log("SPELL_AURA_REMOVED", "SporeCloudRemoved", 31689)

	self:Log("SPELL_AURA_APPLIED", "FoulSpores", 31673) -- channel that can be offensively dispelled
	self:Log("SPELL_AURA_REMOVED", "FoulSporesRemoved", 31673)
	self:Log("SPELL_DAMAGE", "FoulSporesDamage", 31697)
	self:Log("SPELL_MISSED", "FoulSporesDamage", 31697)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:Death("Win", 17770)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:RegisterEvent("UNIT_HEALTH")
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:SporeCloud(args)
	self:StackMessage(args.spellId, args.destName, args.amount, "orange", self:Me(args.destGUID) and "warning" or "info")
	self:TargetBar(args.spellId, 20, args.destName)
end

function mod:SporeCloudRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:FoulSpores(args)
	self:MessageOld("foul_spores", "yellow", "alarm", CL.casting:format(args.spellName), L.foul_spores_icon)
	self:CastBar("foul_spores", 11, L.foul_spores, L.foul_spores_icon)
end

function mod:FoulSporesRemoved(args)
	self:StopBar(CL.cast:format(L.foul_spores))
end

do
	local prev = 0
	function mod:FoulSporesDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > (self:Melee() and 4 or 1.5) then -- melees/tank can't hit the boss while he's casting that but they are still healing the boss taking this damage and he's immobile, so not throttling for the entire cast
				prev = t
				self:MessageOld("foul_spores", "blue", "alert", CL.you:format(args.spellName), L.foul_spores_icon)
			end
		end
	end
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) ~= 17770 then return end
	local hp = self:GetHealth(unit)
	if hp < 25 then
		self:UnregisterEvent(event)
		self:MessageOld("foul_spores", "orange", nil, CL.soon:format(L.foul_spores), L.foul_spores_icon)
	end
end
