
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Kael'thas Sunstrider MT", 585, 533)
if not mod then return end
mod:RegisterEnableMob(24664)
-- mod.engageId = 1894 - doesn't fire ENCOUNTER_END on a wipe
-- mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	L.warmup_trigger = "Don't look so smug!"

	L.flame_strike = "Flame Strike"
	L.flame_strike_desc = "Kael'thas Sunstrider calls down a pillar of flame, burning all players within 6 yards of the targeted area for Fire damage every second for 8 sec."
	L.flame_strike_icon = "Spell_Fire_SelfDestruct"

	L.shock_barrier = "Shock Barrier"
	L.shock_barrier_desc = "Kael'thas Sunstrider surrounds himself in a barrier, absorbing 10000 damage and making him immune to interrupt effects."
	L.shock_barrier_icon = "Spell_Nature_LightningShield"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		44224, -- Gravity Lapse
		44194, -- Phoenix
		"flame_strike", -- Flame Strike
		"shock_barrier", -- Shock Barrier
		36819, -- Pyroblast
	}, {
		[44224] = "general",
		["shock_barrier"] = "heroic",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")

	self:Log("SPELL_CAST_START", "GravityLapse", 44224)
	self:Log("SPELL_CAST_START", "Pyroblast", 36819)
	self:Log("SPELL_SUMMON", "Phoenix", 44194)
	self:Log("SPELL_SUMMON", "FlameStrike", 44192, 46162)
	self:Log("SPELL_AURA_APPLIED", "ShockBarrier", 46165)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:Death("Win", 24664)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:RegisterEvent("UNIT_HEALTH")
	self:UnregisterEvent("CHAT_MSG_MONSTER_YELL") -- if you engage him before killing the trash pack in front of him, he skips roleplaying
	if not self:Normal() then
		self:CDBar("shock_barrier", 60, L.shock_barrier, L.shock_barrier_icon) -- Shock Barrier
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(event, msg)
	if msg:find(L.warmup_trigger, nil, true) then
		self:UnregisterEvent(event)
		self:Bar("warmup", 36.2, CL.active, "achievement_boss_kael'thassunstrider_01")
	end
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) ~= 24664 then return end
	local hp = self:GetHealth(unit)
	if hp < 55 then
		self:UnregisterEvent(event, unit)
		self:MessageOld(44224, "green", nil, CL.soon:format(self:SpellName(44224)), false) -- Gravity Lapse
	end
end

function mod:GravityLapse(args)
	self:StopBar(L.shock_barrier) -- Shock Barrier
	self:Bar(args.spellId, 35)
end

function mod:Phoenix(args)
	self:MessageOld(args.spellId, "orange", "info", CL.spawned:format(args.spellName))
end

function mod:FlameStrike()
	self:MessageOld("flame_strike", "red", nil, L.flame_strike, L.flame_strike_icon)
end

function mod:ShockBarrier()
	self:MessageOld("shock_barrier", "yellow", nil, L.shock_barrier, L.shock_barrier_icon)
end

function mod:Pyroblast(args)
	self:CastBar(args.spellId, 4)
	self:MessageOld(args.spellId, "red", "long", CL.casting:format(args.spellName))
end
