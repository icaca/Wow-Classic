
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Warbringer O'mrogg", 540, 568)
if not mod then return end
mod:RegisterEnableMob(16809)
-- mod.engageId = 1937
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.beatdown = "Beatdown"
	L.beatdown_desc = "Warbringer O'mrogg chooses a random player and beats them down, clearing all threat and giving a large amount of threat to his Beatdown target."
	L.beatdown_icon = "Ability_Warrior_FocusedRage"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{"beatdown", "SAY", "FLASH"}, -- Beatdown
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

	self:Death("Win", 16809)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function announce(self, target, guid)
		if self:Me(guid) then
			self:Say("beatdown", L.beatdown)
			self:Flash("beatdown", L.beatdown_icon)
		end
		self:TargetMessageOld("beatdown", target, "yellow", "warning", L.beatdown, L.beatdown_icon, true)
	end

	function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, spellId)
		if spellId == 30618 then -- Beatdown
			self:GetUnitTarget(announce, 0.4, self:UnitGUID(unit))
		end
	end
end
