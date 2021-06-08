--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Commander Sarannis", 553, 558)
if not mod then return end
mod:RegisterEnableMob(17976)
-- mod.engageId = 1925
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L.mender = "Bloodwarder Mender"

	L.reinforcements = "Summon Reinforcements"
	L.reinforcements_desc = "Commander Sarannis summons 3 Bloodwarder Reservists and a Bloodwarder Mender every minute."
	L.reinforcements_icon = "Ability_Warrior_BattleShout"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		34794, -- Arcane Resonance
		"reinforcements", -- Summon Reinforcements
		35096, -- Greater Heal
	}, {
		[34794] = "general",
		[35096] = L.mender, -- Bloodwarder Mender
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

	self:Log("SPELL_AURA_APPLIED", "ArcaneResonance", 34794)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ArcaneResonance", 34794)
	self:Log("SPELL_CAST_START", "GreaterHeal", 35096)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:Death("Win", 17976)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	-- Summon Reinforcements:
	if self:Normal() then -- at 55%
		self:RegisterEvent("UNIT_HEALTH")
	else -- every minute
		self:CDBar("reinforcements", 60, L.reinforcements, L.reinforcements_icon)
		self:DelayedMessage("reinforcements", 55, "yellow", CL.soon:format(L.reinforcements), L.reinforcements_icon)
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ArcaneResonance(args)
	self:StackMessage(args.spellId, args.destName, args.amount or 1, "red")
end

function mod:GreaterHeal(args)
	self:MessageOld(args.spellId, "orange", self:Interrupter() and "warning" or "alarm", CL.casting:format(args.spellName))
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) ~= 17976 then return end
	local hp = self:GetHealth(unit)
	if hp < 60 then
		self:UnregisterEvent(event)
		self:MessageOld("reinforcements", "yellow", nil, CL.soon:format(L.reinforcements), L.reinforcements_icon)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 34803 then -- Summon Reinforcements
		self:MessageOld("reinforcements", "yellow", "info", L.reinforcements, L.reinforcements_icon)
		if not self:Normal() then
			self:CDBar("reinforcements", 60, L.reinforcements, L.reinforcements_icon)
			self:DelayedMessage("reinforcements", 55, "yellow", CL.soon:format(L.reinforcements), L.reinforcements_icon)
		end
	end
end
