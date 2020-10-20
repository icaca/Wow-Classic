--[[	*** DataStore_Containers ***
Written by : Thaoky, EU-Marécages de Zangar
June 21st, 2009

This modules takes care of scanning & storing player bags + bank
--]]
if not DataStore then return end

local addonName = "DataStore_Containers"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0", "AceSerializer-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"
local MAIN_BANK_SLOTS = 100		-- bag id of the 28 main bank slots

local AddonDB_Defaults = {
	global = {
		Characters = {
			['*'] = {					-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				numBagSlots = 0,
				numFreeBagSlots = 0,
				numBankSlots = 0,
				numFreeBankSlots = 0,
				Containers = {
					['*'] = {					-- Containers["Bag0"]
						icon = nil,				-- Containers's texture
						link = nil,				-- Containers's itemlink
						size = 0,
						freeslots = 0,
						bagtype = 0,
						ids = {},
						links = {},
						counts = {},
						cooldowns = {}
					}
				}
			}
		}
	}
}

local function GetDBVersion()
	return addon.db.global.Version or 0
end

local function SetDBVersion(version)
	addon.db.global.Version = version
end

local DBUpdaters = {
	-- Table of functions, each one updates to its index's version
	--	ex: [3] = the function that upgrades from v2 to v3
	[1] = function(self)
	
			local function CopyTable(src, dest)
				for k, v in pairs (src) do
					if type(v) == "table" then
						dest[k] = {}
						CopyTable(v, dest[k])
					else
						dest[k] = v
					end
				end
			end
		end,
}

local function UpdateDB()
	local version = GetDBVersion()
	
	for i = (version+1), #DBUpdaters do		-- start from latest version +1 to the very last
		DBUpdaters[i]()
		SetDBVersion(i)
	end
	
	DBUpdaters = nil
	GetDBVersion = nil
	SetDBVersion = nil
end

-- *** Utility functions ***

local function IsEnchanted(link)
	if not link then return end
	
	if not string.find(link, "item:%d+:0:0:0:0:0:0:%d+:%d+:0:0") then	-- 7th is the UniqueID, 8th LinkLevel which are irrelevant
		-- enchants/jewels store values instead of zeroes in the link, if this string can't be found, there's at least one enchant/jewel
		return true
	end
end

local BAGS			= 1		-- All bags, 0 to 11, and keyring ( id -2 )
local BANK			= 2		-- 28 main slots

local ContainerTypes = {
	[BAGS] = {
		GetSize = function(self, bagID)
				return GetContainerNumSlots(bagID)
			end,
		GetFreeSlots = function(self, bagID)
				local freeSlots, bagType = GetContainerNumFreeSlots(bagID)
				return freeSlots, bagType
			end,
		GetLink = function(self, slotID, bagID)
				return GetContainerItemLink(bagID, slotID)
			end,
		GetCount = function(self, slotID, bagID)
				local _, count = GetContainerItemInfo(bagID, slotID)
				return count
			end,
		GetCooldown = function(self, slotID, bagID)
				local startTime, duration, isEnabled = GetContainerItemCooldown(bagID, slotID)
				return startTime, duration, isEnabled
			end,
	},
	[BANK] = {
		GetSize = function(self)
				return NUM_BANKGENERIC_SLOTS or 28		-- hardcoded in case the constant is not set
			end,
		GetFreeSlots = function(self)
				local freeSlots, bagType = GetContainerNumFreeSlots(-1)		-- -1 = player bank
				return freeSlots, bagType
			end,
		GetLink = function(self, slotID)
				-- return GetInventoryItemLink("player", slotID)
				return GetContainerItemLink(-1, slotID)
			end,
		GetCount = function(self, slotID)
				-- return GetInventoryItemCount("player", slotID)
				return select(2, GetContainerItemInfo(-1, slotID))
			end,
		GetCooldown = function(self, slotID, bagID)
				local startTime, duration, isEnabled = GetContainerItemCooldown(bagID, slotID)
				return startTime, duration, isEnabled
			end,
	},
}

local function detectBagChanges(originalBag, newBag)
    local changes = {}

    for slotID = 1, originalBag.size do
        local itemID = originalBag.ids[slotID]
        if itemID == nil then
            -- slot was originally empty
            if newBag.ids[slotID] ~= nil then
                -- an item has been moved into this slot
                table.insert(changes, {["changeType"] = "insert", ["slotID"] = slotID, ["itemID"] = newBag.ids[slotID], ["count"] = newBag.counts[slotID] })
            end
        else
            -- slot originally had an item
            if newBag.ids[slotID] == nil then
                -- an item has been removed from this slot
                table.insert(changes, {["changeType"] = "delete", ["slotID"] = slotID, ["itemID"] = itemID})
            else
                if (itemID ~= newBag.ids[slotID]) or (originalBag.counts[slotID] ~= newBag.counts[slotID]) then
                    -- a different item is now in this slot OR its count changed
                    table.insert(changes, { 
                        ["changeType"] = "changed", 
                        ["slotID"] = slotID, 
                        ["originalItemID"] = itemID, 
                        ["newItemID"] = newBag.ids[slotID], 
                        ["originalCount"] = originalBag.counts[slotID], 
                        ["newCount"] = newBag.counts[slotID], 
                    } )
                end
            end
        end
    end

    return changes
end

-- Credit to Arkoniel and Eliot from the WoW Addons discord for this code.
-- Something to do with the time returned by GetItemCooldown being bugged if your machine has been fully restarted since using the item
local function GetCooldownLeft(start, duration)
    if start <= GetTime()+1 then
        local cdEndTime = start + duration
        local cdLeftDuration = cdEndTime - GetTime()        
        return cdLeftDuration
    end
    local time = time()
    local startupTime = time - GetTime()    
    local cdTime = (2 ^ 32) / 1000 - start
    local cdStartTime = startupTime - cdTime
    local cdEndTime = cdStartTime + duration
    local cdLeftDuration = cdEndTime - time    
    return cdLeftDuration
end

-- *** Scanning functions ***
-- This is a fix for item cooldown icons displaying incorrectly when the computer has been rebooted
-- Not really relevant to DataStore, just thought it would be helpful to leave it here anyway
-- Basically a bugfix for problems on Blizzards end
hooksecurefunc( getmetatable(CreateFrame("Cooldown")).__index, "SetCooldown", function(s,c,d,r)
    if c <= GetTime()+1 then return end
    local e = (GetTime() + ( (2^32) / 1000  - c ))
    s:SetCooldownUNIX(time()-e,d, 1/1000)
end)


local function ScanContainer(bagID, containerType)
	local Container = ContainerTypes[containerType]
	
	local originalBag = addon.ThisCharacter.Containers["Bag" .. bagID]
    
    local newBag = {}
    addon.ThisCharacter.Containers["Bag"..bagID] = newBag
    newBag.cooldowns = {}
    newBag.ids = {}
    newBag.counts = {}
    newBag.links = {}
    newBag.icon = originalBag.icon
    newBag.link = originalBag.link
	
	local link, count
	local startTime, duration, isEnabled
	
	newBag.size = Container:GetSize(bagID)
	newBag.freeslots, newBag.bagtype = Container:GetFreeSlots(bagID)
	
	-- Scan from 1 to bagsize for normal bags, but from 40 to 67 for main bank slots
	-- local baseIndex = (containerType == BANK) and 39 or 0
	local baseIndex = 0
	local index
	
	for slotID = baseIndex + 1, baseIndex + newBag.size do
		index = slotID - baseIndex
		link = Container:GetLink(slotID, bagID)
		if link then
			newBag.ids[index] = tonumber(link:match("item:(%d+)"))
			
			if IsEnchanted(link) then
				newBag.links[index] = link
			end
		
			count = Container:GetCount(slotID, bagID)
			if count and count > 1  then
				newBag.counts[index] = count	-- only save the count if it's > 1 (to save some space since a count of 1 is extremely redundant)
			end
		end
		
		startTime, duration, isEnabled = Container:GetCooldown(slotID, bagID)
        
		if startTime and startTime > 0 then
            startTime = time() + GetCooldownLeft(startTime, duration) - duration
			newBag.cooldowns[index] = format("%s|%s|1", startTime, duration)
		end
	end
	
	addon.ThisCharacter.lastUpdate = time()
	addon:SendMessage("DATASTORE_CONTAINER_UPDATED", bagID, containerType)
    
    local changes = detectBagChanges(originalBag, newBag)
    
    -- detect if the table is empty
    local next = next
    if next(changes) == nil then
        return nil
    else
        changes.bagID = bagID
        return changes
    end
end

local function ScanBagSlotsInfo()
	local char = addon.ThisCharacter

	local numBagSlots = 0
	local numFreeBagSlots = 0

	for bagID = 0, NUM_BAG_SLOTS do
		local bag = char.Containers["Bag" .. bagID]
		numBagSlots = numBagSlots + bag.size
		numFreeBagSlots = numFreeBagSlots + bag.freeslots
	end
	
	char.numBagSlots = numBagSlots
	char.numFreeBagSlots = numFreeBagSlots
end

local function ScanBankSlotsInfo()
	local char = addon.ThisCharacter
	
	local numBankSlots = NUM_BANKGENERIC_SLOTS
	local numFreeBankSlots = char.Containers["Bag"..MAIN_BANK_SLOTS].freeslots

	for bagID = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do		-- 5 to 11
		local bag = char.Containers["Bag" .. bagID]
		
		numBankSlots = numBankSlots + bag.size
		numFreeBankSlots = numFreeBankSlots + bag.freeslots
	end
	
	char.numBankSlots = numBankSlots
	char.numFreeBankSlots = numFreeBankSlots
end

local function ScanBag(bagID)
    -- The keyring bagID is -2, so allow it!
	if (bagID < -2) or (bagID == -1) then return end

	local char = addon.ThisCharacter
	local bag = char.Containers["Bag" .. bagID]
	
	if bagID == 0 then	-- Bag 0	
		bag.icon = "Interface\\Buttons\\Button-Backpack-Up";
		bag.link = nil;
	elseif bagID == -2 then
        bag.icon = "ICONS\\INV_Misc_Key_04.blp"
        bag.link = nil
    else						-- Bags 1 through 11
		bag.icon = GetInventoryItemTexture("player", ContainerIDToInventoryID(bagID))
		bag.link = GetInventoryItemLink("player", ContainerIDToInventoryID(bagID))
		if bag.link then
			local _, _, rarity = GetItemInfo(bag.link)
			if rarity then	-- in case rarity was known from a previous scan, and GetItemInfo returns nil for some reason .. don't overwrite
				bag.rarity = rarity
			end
		end
	end
    local changes = ScanContainer(bagID, BAGS)
	ScanBagSlotsInfo()
    return changes
end

local bagUpdateQueue = {}
-- *** Event Handlers ***
local function OnBagUpdate(event, bag)
	if bag < 0 then
		return
	end
	
	if (bag >= 5) and (bag <= 11) and not addon.isBankOpen then
		return
	end

    table.insert(bagUpdateQueue, bag)
end

local function OnBagUpdateDelayed(event)
    if #bagUpdateQueue == 0 then return end

    for _, v in ipairs(bagUpdateQueue) do
        local changes = ScanBag(v)
        if changes then
            addon:SendMessage("DATASTORE_CONTAINER_CHANGES_SINGLE", changes)
        end        
    end
    
    wipe(bagUpdateQueue)
end

local function OnBankFrameClosed()
	addon.isBankOpen = nil
	addon:UnregisterEvent("BANKFRAME_CLOSED")
	addon:UnregisterEvent("PLAYERBANKSLOTS_CHANGED")
end

local function OnPlayerBankSlotsChanged(event, slotID)
	-- from top left to bottom right, slotID = 1 to 28for main slots, and 29 to 35 for the additional bags
	if (slotID >= 29) and (slotID <= 35) then
		ScanBag(slotID - 24)		-- bagID for bank bags goes from 5 to 11, so slotID - 24
	else
        local changes = ScanContainer(MAIN_BANK_SLOTS, BANK) 
        if changes then
            addon:SendMessage("DATASTORE_CONTAINER_CHANGES_SINGLE", changes)
        end
		ScanBankSlotsInfo()
	end
end

local function OnBankFrameOpened()
	addon.isBankOpen = true
	for bagID = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do		-- 5 to 11
		ScanBag(bagID)
	end
	ScanContainer(MAIN_BANK_SLOTS, BANK)
	ScanBankSlotsInfo()
	addon:RegisterEvent("BANKFRAME_CLOSED", OnBankFrameClosed)
	addon:RegisterEvent("PLAYERBANKSLOTS_CHANGED", OnPlayerBankSlotsChanged)
end

local function OnAuctionMultiSellStart()
	-- if a multi sell starts, unregister bag updates.
	addon:UnregisterEvent("BAG_UPDATE")
    addon:UnregisterEvent("BAG_UPDATE_DELAYED")
end

local function OnAuctionMultiSellUpdate(event, current, total)
	if current == total then	-- ex: multisell = 8 items, if we're on the 8th, resume bag updates.
		addon:RegisterEvent("BAG_UPDATE", OnBagUpdate)
        addon:RegisterEvent("BAG_UPDATE_DELAYED", OnBagUpdateDelayed)
	end
end

local function OnAuctionHouseClosed()
	addon:UnregisterEvent("AUCTION_MULTISELL_START")
	addon:UnregisterEvent("AUCTION_MULTISELL_UPDATE")
	addon:UnregisterEvent("AUCTION_HOUSE_CLOSED")
	
	addon:RegisterEvent("BAG_UPDATE", OnBagUpdate)	-- just in case things went wrong
    addon:RegisterEvent("BAG_UPDATE_DELAYED", OnBagUpdateDelayed)
end

local function OnAuctionHouseShow()
	-- when going to the AH, listen to multi-sell
	addon:RegisterEvent("AUCTION_MULTISELL_START", OnAuctionMultiSellStart)
	addon:RegisterEvent("AUCTION_MULTISELL_UPDATE", OnAuctionMultiSellUpdate)
	addon:RegisterEvent("AUCTION_HOUSE_CLOSED", OnAuctionHouseClosed)
end

-- ** Mixins **
local function _GetContainer(character, containerID)
	-- containerID can be number or string
	if type(containerID) == "number" then
		return character.Containers["Bag" .. containerID]
	end
	return character.Containers[containerID]
end

local function _GetContainers(character)
	return character.Containers
end

local BagTypeStrings = {
	[1] = "Quiver",
	[2] = "Ammo Pouch",
	[4] = GetItemSubClassInfo(LE_ITEM_CLASS_CONTAINER, 1), -- "Soul Bag",
	[8] = GetItemSubClassInfo(LE_ITEM_CLASS_CONTAINER, 7), -- "Leatherworking Bag",
	[16] = GetItemSubClassInfo(LE_ITEM_CLASS_CONTAINER, 8), -- "Inscription Bag",
	[32] = GetItemSubClassInfo(LE_ITEM_CLASS_CONTAINER, 2), -- "Herb Bag"
	[64] = GetItemSubClassInfo(LE_ITEM_CLASS_CONTAINER, 3), -- "Enchanting Bag",
	[128] = GetItemSubClassInfo(LE_ITEM_CLASS_CONTAINER, 4), -- "Engineering Bag",
	[512] = GetItemSubClassInfo(LE_ITEM_CLASS_CONTAINER, 5), -- "Gem Bag",
	[1024] = GetItemSubClassInfo(LE_ITEM_CLASS_CONTAINER, 6), -- "Mining Bag",
	
}

local function _GetContainerInfo(character, containerID)
	local bag = _GetContainer(character, containerID)
	
	local icon = bag.icon
	local size = bag.size
	
	if containerID == MAIN_BANK_SLOTS then	-- main bank slots
		icon = "Interface\\Icons\\inv_misc_enggizmos_17"
	end
	
	return icon, bag.link, size, bag.freeslots, BagTypeStrings[bag.bagtype]
end

local function _GetContainerSize(character, containerID)
	-- containerID can be number or string
	if type(containerID) == "number" then
		return character.Containers["Bag" .. containerID].size
	end
	return character.Containers[containerID].size
end

local rarityColors = {
	[2] = "|cFF1EFF00",
	[3] = "|cFF0070DD",
	[4] = "|cFFA335EE"
}

local function _GetColoredContainerSize(character, containerID)
	local bag = _GetContainer(character, containerID)
	local size = _GetContainerSize(character, containerID)
	
	if bag.rarity and rarityColors[bag.rarity] then
		return format("%s%s", rarityColors[bag.rarity], size)
	end
	
	return format("%s%s", "|cFFFFFFFF", size)
end

local function _GetSlotInfo(bag, slotID)
	assert(type(bag) == "table")		-- this is the pointer to a bag table, obtained through addon:GetContainer()
	assert(type(slotID) == "number")

	local link = bag.links[slotID]
	
	return bag.ids[slotID], link, bag.counts[slotID] or 1
end

local function _GetContainerCooldownInfo(bag, slotID)
	assert(type(bag) == "table")		-- this is the pointer to a bag table, obtained through addon:GetContainer()
	assert(type(slotID) == "number")

	local cd = bag.cooldowns[slotID]
	if cd then
		local startTime, duration, isEnabled = strsplit("|", bag.cooldowns[slotID])
		local remaining = duration - (GetTime() - startTime)
		
		if remaining > 0 then		-- valid cd ? return it
			return tonumber(startTime), tonumber(duration), tonumber(isEnabled)
		end
		-- cooldown expired ? clean it from the db
		bag.cooldowns[slotID] = nil
	end
end

local function _GetContainerItemCount(character, searchedID)
	local bagCount = 0
	local bankCount = 0
	local id
		
	for containerName, container in pairs(character.Containers) do
		for slotID = 1, container.size do
			id = container.ids[slotID]
			
			if (id) and (id == searchedID) then
				local itemCount = container.counts[slotID] or 1
				if (containerName == "Bag"..MAIN_BANK_SLOTS) then
					bankCount = bankCount + itemCount
				elseif (containerName == "Bag-2") then
					bagCount = bagCount + itemCount
				else
					local bagNum = tonumber(string.sub(containerName, 4))
					if (bagNum >= 0) and (bagNum <= 4) then
						bagCount = bagCount + itemCount
					else
						bankCount = bankCount + itemCount
					end
				end
			end
		end
	end

	return bagCount, bankCount
end

local function _GetNumBagSlots(character)
	return character.numBagSlots
end

local function _GetNumFreeBagSlots(character)
	return character.numFreeBagSlots
end

local function _GetNumBankSlots(character)
	return character.numBankSlots
end

local function _GetNumFreeBankSlots(character)
	return character.numFreeBankSlots
end

local function _ImportBagChanges(character, changes)
    -- first, integrity checks...
    if not character then return end
    if not changes then return end
    if type(changes) ~= "table" then return end
    if not changes.bagID then return end
    local container = _GetContainer(character, changes.bagID) 
    if not container then return end
    
    for _, change in pairs(changes) do
        if type(change) == "table" then
            if change.changeType == "insert" then
                if change.slotID and change.itemID then
                    local existingItem = container.ids[change.slotID]
                    container.ids[change.slotID] = change.itemID
                    local item = Item:CreateFromItemID(change.itemID)
                    item:ContinueOnItemLoad(function()
	                    container.links[change.slotID] = item:GetItemLink()
                    end)
                    container.counts[change.slotID] = change.count
                end
            elseif change.changeType == "delete" then
                if change.slotID and change.itemID then
                    local existingItem = container.ids[change.slotID]
                    container.ids[change.slotID] = nil
                    container.links[change.slotID] = nil
                    container.counts[change.slotID] = nil
                end
            elseif change.changeType == "changed" then
                if change.slotID and change.originalItemID and change.newItemID then
                    local existingItem = container.ids[change.slotID]
                    container.ids[change.slotID] = change.newItemID
                    local item = Item:CreateFromItemID(change.newItemID)
                    item:ContinueOnItemLoad(function()
	                    container.links[change.slotID] = item:GetItemLink()
                    end)
                    container.counts[change.slotID] = change.newCount
                end
            end
        end
    end
end

local PublicMethods = {
	GetContainer = _GetContainer,
	GetContainers = _GetContainers,
	GetContainerInfo = _GetContainerInfo,
	GetContainerSize = _GetContainerSize,
	GetColoredContainerSize = _GetColoredContainerSize,
	GetSlotInfo = _GetSlotInfo,
	GetContainerCooldownInfo = _GetContainerCooldownInfo,
	GetContainerItemCount = _GetContainerItemCount,
	GetNumBagSlots = _GetNumBagSlots,
	GetNumFreeBagSlots = _GetNumFreeBagSlots,
	GetNumBankSlots = _GetNumBankSlots,
	GetNumFreeBankSlots = _GetNumFreeBankSlots,
    ImportBagChanges = _ImportBagChanges,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)
	UpdateDB()

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	
	DataStore:SetCharacterBasedMethod("GetContainer")
	DataStore:SetCharacterBasedMethod("GetContainers")
	DataStore:SetCharacterBasedMethod("GetContainerInfo")
	DataStore:SetCharacterBasedMethod("GetContainerSize")
	DataStore:SetCharacterBasedMethod("GetColoredContainerSize")
	DataStore:SetCharacterBasedMethod("GetContainerItemCount")
	DataStore:SetCharacterBasedMethod("GetNumBagSlots")
	DataStore:SetCharacterBasedMethod("GetNumFreeBagSlots")
	DataStore:SetCharacterBasedMethod("GetNumBankSlots")
	DataStore:SetCharacterBasedMethod("GetNumFreeBankSlots")
    DataStore:SetCharacterBasedMethod("ImportBagChanges")
end

function addon:OnEnable()
	-- manually update bags 0 to 4, then register the event, this avoids reacting to the flood of BAG_UPDATE events at login
	for bagID = 0, NUM_BAG_SLOTS do
		ScanBag(bagID)
	end
    
    if HasKey() then
        ScanBag(-2)
    end
	
	addon:RegisterEvent("BAG_UPDATE", OnBagUpdate)
    addon:RegisterEvent("BAG_UPDATE_DELAYED", OnBagUpdateDelayed)
	addon:RegisterEvent("BANKFRAME_OPENED", OnBankFrameOpened)
	
	-- disable bag updates during multi sell at the AH
	addon:RegisterEvent("AUCTION_HOUSE_SHOW", OnAuctionHouseShow)
end

function addon:OnDisable()
	addon:UnregisterEvent("BAG_UPDATE")
    addon:UnregisterEvent("BAG_UPDATE_DELAYED")
	addon:UnregisterEvent("BANKFRAME_OPENED")
	addon:UnregisterEvent("AUCTION_HOUSE_SHOW")
end
