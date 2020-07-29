--[[	*** DataStore_Reputations ***
Written by : Thaoky, EU-Marécages de Zangar
June 22st, 2009
--]]
if not DataStore then return end

local addonName = "DataStore_Reputations"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"
local PARAGON_LABEL = "Paragon"

local AddonDB_Defaults = {
	global = {
		Reference = {
			UIDsRev = {},		-- ex: Reverse lookup of Faction UIDs, now in the database since opposite faction is no longer provided by the API
		},
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				guildName = nil,		-- nil = not in a guild, as returned by GetGuildInfo("player")
				Factions = {},
			}
		}
	}
}

-- ** Reference tables **
local BottomLevelNames = {
	[-42000] = FACTION_STANDING_LABEL1,	 -- "Hated"
	[-6000] = FACTION_STANDING_LABEL2,	 -- "Hostile"
	[-3000] = FACTION_STANDING_LABEL3,	 -- "Unfriendly"
	[0] = FACTION_STANDING_LABEL4,		 -- "Neutral"
	[3000] = FACTION_STANDING_LABEL5,	 -- "Friendly"
	[9000] = FACTION_STANDING_LABEL6,	 -- "Honored"
	[21000] = FACTION_STANDING_LABEL7,	 -- "Revered"
	[42000] = FACTION_STANDING_LABEL8,	 -- "Exalted"
}

local BottomLevels = { -42000, -6000, -3000, 0, 3000, 9000, 21000, 42000 }

local BF = LibStub("LibBabble-Faction-3.0"):GetUnstrictLookupTable()

--[[	*** Faction UIDs ***
These UIDs have 2 purposes: 
- avoid saving numerous copies of the same string (the faction name)
- minimize the amount of data sent across the network when sharing accounts (since both sides have the same reference table)

Note: Let the system manage the ids, DO NOT delete entries from this table, if a faction is removed from the game, mark it as OLD_ or whatever.

Since WoD, GetFactionInfoByID does not return a value when an alliance player asks for an horde faction.
Default to an english text.
--]]



local factions = {                                     --UIDs:
	{ id = 69, name = BF["Darnassus"] },               --1
	{ id = 930, name = BF["Exodar"] },                 --2 
	{ id = 54, name = BF["Gnomeregan"] },              --3
	{ id = 47, name = BF["Ironforge"] },               --4
	{ id = 72, name = BF["Stormwind"] },               --5
	{ id = 530, name = BF["Darkspear Trolls"] },       --6
	{ id = 76, name = BF["Orgrimmar"] },               --7
	{ id = 81, name = BF["Thunder Bluff"] },           --8
	{ id = 68, name = BF["Undercity"] },               --9
	{ id = 911, name = BF["Silvermoon City"] },        --10
	{ id = 509, name = BF["The League of Arathor"] },  --11
	{ id = 890, name = BF["Silverwing Sentinels"] },   --12
	{ id = 730, name = BF["Stormpike Guard"] },        --13
	{ id = 510, name = BF["The Defilers"] },           --14
	{ id = 889, name = BF["Warsong Outriders"] },      --15
	{ id = 729, name = BF["Frostwolf Clan"] },         --16
	{ id = 21, name = BF["Booty Bay"] },               --17
	{ id = 577, name = BF["Everlook"] },               --18
	{ id = 369, name = BF["Gadgetzan"] },              --19
	{ id = 470, name = BF["Ratchet"] },                --20
	{ id = 529, name = BF["Argent Dawn"] },            --21
	{ id = 87, name = BF["Bloodsail Buccaneers"] },    --22
	{ id = 910, name = BF["Brood of Nozdormu"] },      --23
	{ id = 609, name = BF["Cenarion Circle"] },        --24
	{ id = 909, name = BF["Darkmoon Faire"] },         --25 
	{ id = 92, name = BF["Gelkis Clan Centaur"] },     --26
	{ id = 749, name = BF["Hydraxian Waterlords"] },   --27
	{ id = 93, name = BF["Magram Clan Centaur"] },     --28
	{ id = 349, name = BF["Ravenholdt"] },             --29
	{ id = 809, name = BF["Shen'dralar"] },            --30
	{ id = 70, name = BF["Syndicate"] },               --31
	{ id = 59, name = BF["Thorium Brotherhood"] },     --32
	{ id = 576, name = BF["Timbermaw Hold"] },         --33
	{ id = 922, name = BF["Tranquillien"] },           --34
	{ id = 589, name = BF["Wintersaber Trainers"] },   --35
	{ id = 270, name = BF["Zandalar Tribe"] },         --36
	{ id = 469, name = BF["Alliance"] },               --37
	{ id = 67, name = BF["Horde"] },                   --38
}

local FactionUIDsRev = {} -- key: name, value: UID
local FactionIdToName = {} -- key: reputation ID, value: name

for k, v in pairs(factions) do
	if v.id and v.name then
		FactionIdToName[v.id] = v.name
		FactionUIDsRev[v.name] = k	-- ex : [BZ["Darnassus"]] = 1
	end
end

-- *** Utility functions ***

local headersState = {}
local inactive = {}

local function SaveHeaders()
	local headerCount = 0		-- use a counter to avoid being bound to header names, which might not be unique.
	
	for i = GetNumFactions(), 1, -1 do		-- 1st pass, expand all categories
		local name, _, _, _, _, _, _,	_, isHeader, isCollapsed = GetFactionInfo(i)
		if isHeader then
			headerCount = headerCount + 1
			if isCollapsed then
				ExpandFactionHeader(i)
				headersState[headerCount] = true
			end
		end
	end
	
	-- code disabled until I can find the other addon that conflicts with this and slows down the machine.
	
	-- If a header faction, like alliance or horde, has all child factions set to inactive, it will not be visible, so activate it, and deactivate it after the scan (thanks Zaphon for this)
	-- for i = GetNumFactions(), 1, -1 do
		-- if IsFactionInactive(i) then
			-- local name = GetFactionInfo(i)
			-- inactive[name] = true
			-- SetFactionActive(i)
		-- end
	-- end
end

local function RestoreHeaders()
	local headerCount = 0
	for i = GetNumFactions(), 1, -1 do
		local name, _, _, _, _, _, _,	_, isHeader = GetFactionInfo(i)
		
		-- if inactive[name] then
			-- SetFactionInactive(i)
		-- end
		
		if isHeader then
			headerCount = headerCount + 1
			if headersState[headerCount] then
				CollapseFactionHeader(i)
			end
		end
	end
	wipe(headersState)
end

local function GetLimits(earned)
	-- return the bottom & top values of a given rep level based on the amount of earned rep
	local top = 53000
	local index = #BottomLevels
	
	while (earned < BottomLevels[index]) do
		top = BottomLevels[index]
		index = index - 1
	end
	
	return BottomLevels[index], top
end

local function GetEarnedRep(character, faction)
	return character.Factions[FactionUIDsRev[faction]]
end

-- *** Scanning functions ***
local function ScanReputations()
	SaveHeaders()
	local f = addon.ThisCharacter.Factions
	wipe(f)
	
	for i = 1, GetNumFactions() do		-- 2nd pass, data collection
		local name, _, _, _, _, earned, _, _, _, _, _, _, _, factionID = GetFactionInfo(i)
		if (earned ~= nil) then		-- new in 3.0.2, headers may have rep, ex: alliance vanguard + horde expedition
			if FactionUIDsRev[name] then		-- is this a faction we're tracking ?
				f[FactionUIDsRev[name]] = earned		
			end
		end
	end

	RestoreHeaders()
	addon.ThisCharacter.lastUpdate = time()
end

-- *** Event Handlers ***
local function OnPlayerAlive()
	ScanReputations()
end

local function OnFactionChange(event, messageType, faction, amount)
	if messageType ~= "FACTION" then return end
	
	local bottom, top, earned = DataStore:GetRawReputationInfo(DataStore:GetCharacter(), faction)
	if not earned then 	-- faction not in the db, scan all
		ScanReputations()	
		return 
	end
	
	local newValue = earned + amount
	if newValue >= top then	-- rep status increases (to revered, etc..)
		ScanReputations()					-- so scan all
	else
		addon.ThisCharacter.Factions[FactionUIDsRev[faction]] = newValue
		addon.ThisCharacter.lastUpdate = time()
	end
end


-- ** Mixins **
local function _GetReputationInfo(character, faction)
	local earned = GetEarnedRep(character, faction)
	if not earned then return end

	local bottom, top = GetLimits(earned)
	local rate = (earned - bottom) / (top - bottom) * 100

	-- ex: "Revered", 15400, 21000, 73%
	return BottomLevelNames[bottom], (earned - bottom), (top - bottom), rate 
end

local function _GetRawReputationInfo(character, faction)
	-- same as GetReputationInfo, but returns raw values
	
	local earned = GetEarnedRep(character, faction)
	if not earned then return end

	local bottom, top = GetLimits(earned)
	return bottom, top, earned
end

local function _GetReputations(character)
	return character.Factions
end

local function _GetReputationLevels()
	return BottomLevels
end

local function _GetReputationLevelText(bottom)
	return BottomLevelNames[bottom]
end

local function _GetFactionName(id)
	return FactionIdToName[id]
end

local PublicMethods = {
	GetReputationInfo = _GetReputationInfo,
	GetRawReputationInfo = _GetRawReputationInfo,
	GetReputations = _GetReputations,
	GetReputationLevels = _GetReputationLevels,
	GetReputationLevelText = _GetReputationLevelText,
	GetFactionName = _GetFactionName,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetReputationInfo")
	DataStore:SetCharacterBasedMethod("GetRawReputationInfo")
	DataStore:SetCharacterBasedMethod("GetReputations")
end

function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE", OnPlayerAlive)
	addon:RegisterEvent("COMBAT_TEXT_UPDATE", OnFactionChange)
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("COMBAT_TEXT_UPDATE")
end

-- *** Utility functions ***
local PT = LibStub("LibPeriodicTable-3.1")

function addon:GetSource(searchedID)
	-- returns the faction where a given item ID can be obtained, as well as the level
	local level, repData = PT:ItemInSet(searchedID, "Reputation.Reward")
	if level and repData then
		local _, _, faction = strsplit(".", repData)		-- ex: "Reputation.Reward.Sporeggar"
	
		-- level = 7,  29150:7 where 7 means revered
		return faction, _G["FACTION_STANDING_LABEL"..level]
	end
end
