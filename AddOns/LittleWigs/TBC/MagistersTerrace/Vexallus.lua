
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Vexallus", 585, 531)
if not mod then return end
mod:RegisterEnableMob(24744)
-- mod.engageId = 1898
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.energy_discharged = "%s discharged" -- %s = Pure Energy (npc ID = 24745)

	L.pure_energy = "Pure Energy"
	L.pure_energy_desc = "Vexallus summons a Pure Energy whenever his remaining health is reduced by 15%."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"pure_energy", -- Pure Energy
		44335, -- Energy Feedback
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

	self:Log("SPELL_AURA_APPLIED", "EnergyFeedback", 44335)
	self:Log("SPELL_AURA_APPLIED_DOSE", "EnergyFeedback", 44335)
	self:Log("SPELL_AURA_REMOVED", "EnergyFeedbackRemoved", 44335)

	self:Win("Death", 24744)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EnergyFeedback(args)
	self:StackMessage(args.spellId, args.destName, args.amount, "orange")
	self:TargetBar(args.spellId, 30, args.destName)
end

function mod:EnergyFeedbackRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 44322 or spellId == 46154 then -- Summon Pure Energy (normal / heroic)
		self:MessageOld("pure_energy", "red", nil, L.energy_discharged:format(L.pure_energy), false)
	end
end
