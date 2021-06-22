-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Darkweaver Syth", 556, 541)
if not mod then return end
mod:RegisterEnableMob(18472)
-- mod.engageId = 1903
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Locals
--

local elementalsWarnings = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.elementals = "Summon Elementals"
	L.elementals_desc = "When Darkweaver Syth reaches 90%, 55% and 15% remaining health, he summons 4 elementals to defend him."
	L.elementals_icon = "Spell_Nature_ElementalPrecision_2"
end

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		{15659, "SAY", "ICON"}, -- Chain Lightning
		12548, -- Frost Shock
		"elementals", -- Summon Elementals
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ChainLightning", 15659, 15305) -- normal, heroic
	self:Log("SPELL_CAST_SUCCESS", "ChainLightningSuccess", 15659, 15305)
	self:Log("SPELL_AURA_APPLIED", "FrostShock", 12548, 21401) -- normal, heroic
	self:Log("SPELL_AURA_REMOVED", "FrostShockRemoved", 12548, 21401)
	self:Log("SPELL_SUMMON", "SummonElementals", 33538) -- 33538 is the spell summoning the Arcane one but he spawns 4 simultaneously

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:Death("Win", 18472)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:RegisterEvent("UNIT_HEALTH")
	elementalsWarnings = 1
end

-------------------------------------------------------------------------------
--  Event Handlers
--

do
	local function announce(self, target, guid)
		if self:Me(guid) then
			self:Say(15659)
		end
		self:TargetMessageOld(15659, target, "yellow")
		self:PrimaryIcon(15659, target)
	end

	function mod:ChainLightning(args)
		self:GetBossTarget(announce, 0.4, args.sourceGUID)
		self:CastBar(15659, 3)
	end

	function mod:ChainLightningSuccess()
		self:PrimaryIcon(15659)
	end
end

function mod:FrostShock(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessageOld(12548, args.destName, "orange")
		self:TargetBar(12548, 8, args.destName)
	end
end

function mod:FrostShockRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:SummonElementals()
	self:MessageOld("elementals", "red", nil, CL.spawned:format(CL.adds), L.elementals_icon)
end

do
	local warnAt = { 95, 60, 20 }
	function mod:UNIT_HEALTH(event, unit)
		if self:MobId(self:UnitGUID(unit)) ~= 18472 then return end
		local hp = self:GetHealth(unit)
		if hp < warnAt[elementalsWarnings] then
			elementalsWarnings = elementalsWarnings + 1
			self:MessageOld("elementals", "red", nil, CL.soon:format(L.elementals), L.elementals_icon) -- Summon Elementals

			while elementalsWarnings <= #warnAt and hp < warnAt[elementalsWarnings] do
				-- account for high-level characters hitting multiple thresholds
				elementalsWarnings = elementalsWarnings + 1
			end

			if elementalsWarnings > #warnAt then
				self:UnregisterEvent(event, unit)
			end
		end
	end
end
