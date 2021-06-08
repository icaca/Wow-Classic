
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Warchief Kargath Bladefist", 540, 569)
if not mod then return end
mod:RegisterEnableMob(16808)
-- mod.engageId = 1938
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.blade_dance = "Blade Dance"
	L.blade_dance_desc = "Warchief Kargath Bladefist enters a blade dance, charging to several random players, inflicting Physical damage to them and all nearby players."
	L.blade_dance_icon = "Ability_Warrior_Bladestorm"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"blade_dance", -- Blade Dance
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

	self:Death("Win", 16808)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 30738 then -- Blade Dance Targeting
		self:MessageOld("blade_dance", "yellow", "warning", L.blade_dance, L.blade_dance_icon)
		self:CDBar("blade_dance", 30, L.blade_dance, L.blade_dance_icon)
	end
end
