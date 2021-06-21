-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Anzu", 556, 542)
if not mod then return end
mod:RegisterEnableMob(23035)
-- mod.engageId = 1904
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Locals
--

local nextBroodWarning = 80
local addsAlive = 0
local castingScreech = false

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.cyclone = "Cyclone of Feathers"
	L.cyclone_desc = "Anzu cyclones a player, preventing all actions but making them invulnerable for 6 sec."
	L.cyclone_icon = "Spell_Nature_Cyclone"

	L.brood = "Brood of Anzu"
	L.brood_desc = "When Anzu reaches 75% and 35% remaining health, he banishes himself for 1 minute, making him immune to all damage and unable to move. While banished, Anzu will continue to use abilities and will summon the Brood of Anzu to defend him. Defeating all Brood of Anzu will cause Anzu to cancel the banish effect early."
	L.brood_icon = "INV_Feather_13"
end

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		{40184, "FLASH"}, -- Paralyzing Screech
		40303, -- Spell Bomb
		"cyclone", -- Cyclone of Feathers
		"brood", -- Brood of Anzu
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:Log("SPELL_CAST_START", "ParalyzingScreech", 40184)
	self:Log("SPELL_CAST_SUCCESS", "ParalyzingScreechStop", 40184)
	self:Log("SPELL_AURA_APPLIED", "SpellBomb", 40303)
	self:Log("SPELL_AURA_APPLIED", "CycloneOfFeathers", 40321)
	self:Death("AddDied", 23132)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:Death("Win", 23035)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:RegisterEvent("UNIT_HEALTH")
	nextBroodWarning = 80 -- 75% and 35%
	addsAlive = 0
	castingScreech = false
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:ParalyzingScreech(args)
	self:MessageOld(args.spellId, "red", "warning", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 5)
	self:Flash(args.spellId)
	castingScreech = true
end

function mod:ParalyzingScreechStop(args)
	castingScreech = false
end

function mod:SpellBomb(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow", "alarm", nil, nil, self:Dispeller("curse"))
	self:TargetBar(args.spellId, 8, args.destName)
end

function mod:CycloneOfFeathers(args)
	self:TargetMessageOld("cyclone", args.destName, "yellow", "alert", L.cyclone, L.cyclone_icon)
	self:TargetBar("cyclone", 6, args.destName, L.cyclone, L.cyclone_icon)
end

function mod:AddDied()
	addsAlive = addsAlive - 1
	self:MessageOld("brood", "green", nil, CL.add_remaining:format(addsAlive), L.brood_icon)
	if addsAlive == 0 and not castingScreech then -- doesn't unbanish if you kill the last add while he's casting
		self:StopBar(CL.onboss:format(self:SpellName(42354))) -- Banish Self
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 42354 then -- Banish Self
		self:Bar("brood", 45, CL.onboss:format(self:SpellName(spellId)), spellId)
		self:MessageOld("brood", "orange", nil, CL.incoming:format(L.brood), L.brood_icon) -- Brood of Anzu
		addsAlive = addsAlive + 7
	end
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) ~= 23035 then return end
	local hp = self:GetHealth(unit)
	if hp < nextBroodWarning then
		self:MessageOld("brood", "orange", nil, CL.soon:format(self:SpellName(42354)), 42354) -- Banish Self
		nextBroodWarning = nextBroodWarning - 40

		if nextBroodWarning < 15 then
			self:UnregisterEvent(event)
		end
	end
end
