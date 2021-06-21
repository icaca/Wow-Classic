-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mekgineer Steamrigger", 545, 574)
if not mod then return end
mod:RegisterEnableMob(17796)
-- mod.engageId = 1943
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Locals
--

local nextAddWarning = 80

-------------------------------------------------------------------------------
--  Localization
--

local L = mod:GetLocale()
if L then
	L.mech_trigger = "Tune 'em up good, boys!"

	L.mechanics = "Steamrigger Mechanics"
	L.mechanics_desc = "When Mekgineer Steamrigger reaches 75%, 50% and 25% remaining health, he summons Steamrigger Mechanics to repair him."
end

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		31485, -- Super Shrink Ray
		"mechanics", -- Steamrigger Mechanics
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "SuperShrinkRay", 31485)

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL") -- no locale-independent events

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:Death("Win", 17796)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:RegisterEvent("UNIT_HEALTH")
	nextAddWarning = 80 -- 75%, 50% and 25%
end

-------------------------------------------------------------------------------
--  Event Handlers


do
	local playerList = mod:NewTargetList()
	function mod:SuperShrinkRay(args)
		playerList[#playerList+1] = args.destName
		if #playerList == 1 then
			self:ScheduleTimer("TargetMessageOld", 0.3, args.spellId, playerList, "orange", "alert")
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg == L.mech_trigger or msg:find(L.mech_trigger, nil, true) then
		self:MessageOld("mechanics", "yellow", nil, CL.incoming:format(L.mechanics), false)
	end
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) ~= 17796 then return end
	local hp = self:GetHealth(unit)
	if hp < nextAddWarning then
		nextAddWarning = nextAddWarning - 25
		self:MessageOld("mechanics", "red", nil, CL.soon:format(L.mechanics), false)

		while nextAddWarning >= 25 and hp < nextAddWarning do
			-- account for high-level characters hitting multiple thresholds
			nextAddWarning = nextAddWarning - 25
		end

		if nextAddWarning < 25 then
			self:UnregisterEvent(event)
		end
	end
end
