
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Wrath-Scryer Soccothrates", 552, 550)
if not mod then return end
mod:RegisterEnableMob(20886)
-- mod.engageId = 1915
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.felfire = "Felfire"
	L.felfire_desc = "Wrath-Scryer Soccothrates knocks all players within 10 yards away. After knocking all players away, Wrath-Scryer Soccothrates charges a player, leaving a wall of Felfire in his wake. Felfire inflicts Fire damage every second to all players in it."
	L.felfire_icon = "Spell_Fire_FelFlameBreath"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{"felfire", "SAY"}, -- Felfire
		35759, -- Felfire Shock
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

	self:Log("SPELL_CAST_SUCCESS", "FelfireKnockback", 36512) -- Knockback before the charge that leaves a trail of fire
	self:Log("SPELL_AURA_APPLIED", "FelfireShock", 35759, 39006) -- normal, heroic
	self:Log("SPELL_AURA_REMOVED", "FelfireShockRemoved", 35759, 39006)

	self:Death("Win", 20886)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FelfireKnockback()
	self:MessageOld("felfire", "red", nil, CL.incoming:format(L.felfire), L.felfire_icon)
	self:CastBar("felfire", 4.9, L.felfire, L.felfire_icon)
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say("felfire", 100) -- 100 = Charge
		end
		self:TargetMessageOld("felfire", player, "orange", nil, 100, L.felfire_icon)
	end

	function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, spellId)
		if spellId == 36038 then -- Charge Targeting
			self:GetUnitTarget(printTarget, 0.4, self:UnitGUID(unit))
		end
	end
end

function mod:FelfireShock(args)
	if self:Me(args.destGUID) or (args.spellId == 35759 and self:Dispeller("magic")) then -- heroic version can't be dispelled
		self:TargetMessageOld(35759, args.destName, "yellow")
		self:TargetBar(35759, 6, args.destName)
	end
end

function mod:FelfireShockRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
