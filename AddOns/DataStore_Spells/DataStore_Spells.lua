--[[	*** DataStore_Spells ***
Written by : Thaoky, EU-Marécages de Zangar
July 6th, 2009
--]]
if not DataStore then return end

local addonName = "DataStore_Spells"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"

local AddonDB_Defaults = {
	global = {
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				SpellTabs = {},
				Spells = {
					['*'] = {		-- "General", "Arcane", "Fire", etc...
						['*'] = nil
					}
				},
			}
		}
	}
}

-- *** Utility functions ***
local bAnd = bit.band

local function LeftShift(value, numBits)
	return value * (2 ^ numBits)
end

local function RightShift(value, numBits)
	-- for bits beyond bit 31
	return math.floor(value / 2^numBits)
end

-- *** Scanning functions ***
local function ScanSpellTab(tabID)
	local tabName, _, offset, numSpells = GetSpellTabInfo(tabID);
	if not tabName then return end
	
	addon.ThisCharacter.SpellTabs[tabID] = tabName
	
	local spells = addon.ThisCharacter.Spells
	local newSpells = {}
	-- wipe(spells[tabName])
	
	local spellType, spellID
	for index = offset + 1, offset + numSpells do
		local spellType, spellID = GetSpellBookItemInfo(index, BOOKTYPE_SPELL)
		
		if spellID then
			local _, rank = GetSpellBookItemName(index, BOOKTYPE_SPELL)
			-- all info on this spell can be retrieved with GetSpellInfo()
			if rank then
				table.insert(newSpells, format("%s|%s", spellID, rank))		-- ex: "43017|Rank 1",
			end
		end
	end
	
	-- if the spells were not properly loaded after logon, there is a risk that ranks will not properly be read
	-- thus newspells will contain nothing .. so update only if we could read something
	if #newSpells > 0 then
		spells[tabName] = newSpells
	end
end

local function ScanSpells()
	wipe(addon.ThisCharacter.SpellTabs)
	for tabID = 1, GetNumSpellTabs() do
		ScanSpellTab(tabID)
	end
	addon.ThisCharacter.lastUpdate = time()
end

-- *** Event Handlers ***
local function OnPlayerAlive()
	ScanSpells()
end

local function OnLearnedSpellInTab()
	ScanSpells()
end

-- ** Mixins **
local function _GetNumSpells(character, school)
	return #character.Spells[school]
end
	
local function _GetSpellInfo(character, school, index)
	local spellID, rank = strsplit("|", character.Spells[school][index])
	return tonumber(spellID), rank
end

local function _IsSpellKnown(character, spellID)
	for schoolName, _ in pairs(character.Spells) do
		for i = 1, _GetNumSpells(character, schoolName) do
			local id = _GetSpellInfo(character, schoolName, i)
			if id == spellID then
				return true
			end
		end
	end
end

local function _GetSpellTabs(character)
	return character.SpellTabs
end

local PublicMethods = {
	GetNumSpells = _GetNumSpells,
	GetSpellInfo = _GetSpellInfo,
	IsSpellKnown = _IsSpellKnown,
	GetSpellTabs = _GetSpellTabs,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetNumSpells")
	DataStore:SetCharacterBasedMethod("GetSpellInfo")
	DataStore:SetCharacterBasedMethod("IsSpellKnown")
	DataStore:SetCharacterBasedMethod("GetSpellTabs")
end
	
function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE", OnPlayerAlive)
	addon:RegisterEvent("LEARNED_SPELL_IN_TAB", OnLearnedSpellInTab)
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("LEARNED_SPELL_IN_TAB")
end
