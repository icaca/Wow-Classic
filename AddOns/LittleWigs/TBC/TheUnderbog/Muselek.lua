-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Swamplord Musel'ek", 546, 578)
if not mod then return end
mod:RegisterEnableMob(17826, 17827) -- Swamplord Musel'ek, Claw <Swamplord Musel'ek's Pet>
-- mod.engageId = 1947
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L.warmup_trigger = "Don't look so smug!"

	L.claw = "Claw"
end

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		31615, -- Hunter's Mark
		{34971, "TANK_HEALER"}, -- Frenzy
		31429, -- Echoing Roar
	}, {
		[31615] = "general",
		[34971] = L.claw, -- Claw
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "HuntersMark", 31615)
	self:Log("SPELL_AURA_REMOVED", "HuntersMarkRemoved", 31615)
	self:Log("SPELL_AURA_APPLIED", "Frenzy", 34971)
	self:Log("SPELL_AURA_APPLIED", "EchoingRoar", 31429)

	self:Death("Win", 17826)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:HuntersMark(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow", "alarm", nil, nil, self:Dispeller("magic"))
	self:TargetBar(args.spellId, 20, args.destName)
end

function mod:HuntersMarkRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:Frenzy(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange", "long", nil, nil, true)
	self:TargetBar(args.spellId, 20, args.destName)
end

do
	local playerList = mod:NewTargetList()

	function mod:EchoingRoar(args)
		if self:Me(args.destGUID) and not self:Healer() then
			self:TargetMessageOld(args.spellId, args.destName, "blue", "warning")
		elseif self:Healer() then
			playerList[#playerList+1] = args.destName
			if #playerList == 1 then
				self:ScheduleTimer("TargetMessageOld", 0.3, args.spellId, playerList, "red", "warning", nil, nil, true)
			end
		end
	end
end
