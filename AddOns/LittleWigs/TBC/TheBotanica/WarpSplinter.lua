--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Warp Splinter", 553, 562)
if not mod then return end
mod:RegisterEnableMob(17977)
-- mod.engageId = 1929
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Locals
--

local addsAlive = 0

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L.mender = "Bloodwarder Mender"

	L.saplings = "Summon Saplings"
	L.saplings_desc = "Warp Splinter raises 6 Saplings to life to aid him in battle. After 25 sec, the Saplings will sacrifice themselves, healing Warp Splinter for an amount equal to their remaining health."
	L.saplings_icon = "SPELL_NATURE_HEALINGWAY"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		34716, -- Stomp
		"saplings", -- Summon Saplings
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Stomp", 34716)

	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:Death("AddDeath", 19949)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:Death("Win", 17977)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	addsAlive = 0
	self:CDBar("saplings", 15, L.saplings, L.saplings_icon) -- Summon Saplings
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local playerList = mod:NewTargetList()
	function mod:Stomp(args)
		playerList[#playerList+1] = args.destName
		if #playerList == 1 then
			self:ScheduleTimer("TargetMessageOld", 0.3, args.spellId, playerList, "orange", "alert", nil, nil, self:Healer())
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 34741 then -- Summon Saplings
		addsAlive = 6 -- when they despawn to heal him, they don't fire any events; fortunately, no 2 waves can be alive at the same time
		self:MessageOld("saplings", "red", "alarm", L.saplings, L.saplings_icon)
		self:Bar("saplings", 25, CL.onboss:format(self:SpellName(2060)), 38658) -- text is "Heal on BOSS", icon is that of druids' Healing Touch
		self:CDBar("saplings", 45, L.saplings, L.saplings_icon)
	end
end

function mod:AddDeath()
	addsAlive = addsAlive - 1
	self:MessageOld("saplings", "green", "info", CL.add_remaining:format(addsAlive), L.saplings_icon)
	if addsAlive == 0 then
		self:StopBar(CL.onboss:format(self:SpellName(2060))) -- "Heal on BOSS"
	end
end
