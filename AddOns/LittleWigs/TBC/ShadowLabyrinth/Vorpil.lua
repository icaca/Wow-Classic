-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Grandmaster Vorpil", 555, 546)
if not mod then return end
mod:RegisterEnableMob(18732)
-- mod.engageId = 1911 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.draw_shadows = "Draw Shadows"
	L.draw_shadows_desc = "Grandmaster Vorpil teleports to his platform and summons all players to him. After summoning all players, Grandmaster Vorpil calls down a Rain of Fire, burning all players on the platform for Fire damage every second for 6 sec."
	L.draw_shadows_icon = "Spell_Shadow_SummonVoidWalker"
end

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		"draw_shadows", -- Draw Shadows
		38791, -- Banish
	},{
		["draw_shadows"] = "general",
		[38791] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "DrawShadows", 33563)
	self:Log("SPELL_AURA_APPLIED", "Banish", 38791)
	self:Log("SPELL_AURA_REMOVED", "BanishRemoved", 38791)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:Death("Win", 18732)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:CDBar("draw_shadows", 44, L.draw_shadows, L.draw_shadows_icon) -- Draw Shadows
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:DrawShadows()
	self:MessageOld("draw_shadows", "orange", nil, L.draw_shadows, L.draw_shadows_icon)
	self:CDBar("draw_shadows", 41, L.draw_shadows, L.draw_shadows_icon)
end

function mod:Banish(args)
	self:TargetMessageOld(args.spellId, args.destName, "red")
	self:TargetBar(args.spellId, 8, args.destName)
end

function mod:BanishRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
