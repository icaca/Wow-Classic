--[[	*** DataStore_Crafts ***
Written by : Thaoky, EU-Marécages de Zangar
June 23rd, 2009

======
2020/03/04: 
There was an issue that has been resolved where some characters would have the same profession showing for Slot 1 and Slot 2.
To fix this, either delete the character and re-scan it, or run this macro:
    /run for _,c in pairs(DataStore_Crafts.Characters) do if (c.Prof1==c.Prof2) then c.Prof2=nil end end
======
--]]
if not DataStore then return end

local addonName = "DataStore_Crafts"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0", "AceSerializer-3.0", "AceTimer-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"
local L = LibStub("AceLocale-3.0"):GetLocale("DataStore_Crafts")

local AddonDB_Defaults = {
	global = {
		Guilds = {
			['*'] = {			-- ["Account.Realm.Name"] 
				Members = {
					['*'] = {				-- ["MemberName"] 
						lastUpdate = nil,
						Version = nil,
						Professions = {},		-- 4 profession links : [1] & [2] for the 2 primary professions, [3] for cooking, [4] for first aid
					}
				}
			},
		},
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				Professions = {
					['*'] = {
						--FullLink = nil,		-- Tradeskill link
                        Name = nil,
						Rank = 0,
						MaxRank = 0,
						Icon = nil,
						Crafts = {},
						Cooldowns = { ['*'] = nil },		-- list of active cooldowns
					}
				},
			}
		}
	}
}

local ReferenceDB_Defaults = {
	global = {
		Reagents = {},		-- [recipeID] = "itemID1,count1 | itemID2,count2 | ..."
		ResultItems = {},	-- [recipeID] = itemID
        ResultItemNames = {}, -- [recipeID] = itemName
		Recipes = {},		-- [recipeID] = 
		RecipeCategoryNames = {},		-- [categoryID] = name
	}
}


local SPELL_ID_ALCHEMY = 2259
local SPELL_ID_BLACKSMITHING = 3100
local SPELL_ID_ENCHANTING = 7411
local SPELL_ID_ENGINEERING = 4036
local SPELL_ID_LEATHERWORKING = 2108
local SPELL_ID_TAILORING = 3908
local SPELL_ID_SKINNING = 8613
local SPELL_ID_MINING = 2575
local SPELL_ID_HERBALISM = 2366
local SPELL_ID_SMELTING = 2656
local SPELL_ID_COOKING = 2550
local SPELL_ID_FIRSTAID = 3273
local SPELL_ID_FISHING = 7733

local ProfessionSpellID = {
	-- GetSpellInfo with this value will return localized spell name
	["Alchemy"] = SPELL_ID_ALCHEMY,
	["Blacksmithing"] = SPELL_ID_BLACKSMITHING,
	["Enchanting"] = SPELL_ID_ENCHANTING,
	["Engineering"] = SPELL_ID_ENGINEERING,
	["Leatherworking"] = SPELL_ID_LEATHERWORKING,
	["Tailoring"] = SPELL_ID_TAILORING,
	["Skinning"] = SPELL_ID_SKINNING,
	["Mining"] = SPELL_ID_MINING,
	["Herbalism"] = SPELL_ID_HERBALISM,
	["Smelting"] = SPELL_ID_SMELTING,
	["Cooking"] = SPELL_ID_COOKING,
    ["First Aid"] = SPELL_ID_FIRSTAID,
	["Fishing"] = SPELL_ID_FISHING,
}

-- *** Utility functions ***
local bAnd = bit.band
local LShift = bit.lshift
local RShift = bit.rshift

local function TestBit(value, pos)
	-- note: this function works up to bit 51
	local mask = 2 ^ pos		-- 0-based indexing
	return value % (mask + mask) >= mask
end

local function GetOption(option)
	return addon.db.global.Options[option]
end

local function GetProfessionID(profession)
	-- profession = localized profession name "Cooking" or "Cuisine", "Alchemy"...
	-- note: we're not using a reverse lookup table because of the localization issue.
	
	if ProfessionSpellID[profession] then
		return ProfessionSpellID[profession]
	end

	for _, id in pairs( ProfessionSpellID ) do
		if profession == GetSpellInfo(id) then		-- profession found ?
			ProfessionSpellID[profession] = id		-- cache the result to speed up future searches
			return id
		end
	end
end

local function GetThisGuild()
	local key = DataStore:GetThisGuildKey()
	return key and addon.db.global.Guilds[key] 
end

local function GetVersion()
	local _, version = GetBuildInfo()
	return tonumber(version)
end

local function ClearExpiredProfessions()
	-- this function will clear all the guild profession links that were saved with a build number anterior to the current one (they're invalid after a patch anyway)
	
	local thisGuild = GetThisGuild()
	if not thisGuild then return end
		
	local version = GetVersion()
	
	for name, member in pairs(thisGuild.Members) do
		if member.Version ~= version then
			thisGuild.Members[name] = nil		-- clear this member's entry if version is outdated
		end
	end
end

local function LocalizeProfessionSpellIDs()
	-- this function adds localized entries in the ProfessionSpellID table
	
	local localizedSpells = {}		-- avoid infinite loop by storing in a temp table first
	local localizedName
	for englishName, spellID in pairs(ProfessionSpellID) do
		localizedName = GetSpellInfo(spellID)
		localizedSpells[localizedName] = spellID
	end
	
	for name, id in pairs(localizedSpells) do
		ProfessionSpellID[name] = id
	end
end

local function GetRecipeRank(info)
    return 1, 1, 1
end

-- *** Scanning functions ***

local function ClassicProfessionLevelToLevelName(level)
    if level < 76 then
        return "Journeyman"
    elseif level < 151 then
        return "Expert"
    elseif level < 226 then
        return "Artisian"
    end 
    return "Master"
end

local SkillTypeToColor = {
	["trivial"] = 0,		-- grey
	["easy"] = 1,			-- green
	["medium"] = 2,		-- yellow
	["optimal"] = 3,		-- orange
}

local function GetTradeSkillHeaders()
    local headers = {}
    for i = 1, GetNumTradeSkills() do
        local _, skillType = GetTradeSkillInfo(i)
        if (skillType == "header") then
            table.insert(headers, i)
        end
    end
    return headers
end

local function ScanRecipeCategories(profession, useCraftInstead)
    if (not useCraftInstead) and (#GetTradeSkillHeaders() == 0) then return end
    
	-- clear storage
	profession.Categories = profession.Categories or {}
	wipe(profession.Categories)
    
    if useCraftInstead then
        table.insert(profession.Categories, {id = 1})
        return
    else
        profession.Rank = select(2, GetTradeSkillLine())
	    profession.MaxRank = select(3, GetTradeSkillLine())
    end
	
	local names = addon.ref.global.RecipeCategoryNames
	             
	-- loop through this profession's categories
	for _, headerID in ipairs( GetTradeSkillHeaders() ) do

		names[headerID] = GetTradeSkillInfo(headerID)
		table.insert(profession.Categories, { 
			id = headerID,   
		})
	end
end

local function GenerateSpellID(recipeID, professionName)
    -- first 14 bits: professionID
    -- remaining bits: recipe ID
    return ProfessionSpellID[professionName] + LShift(recipeID, 14)
end

--local function RetrieveSpellIDFromHash(hash)
--    return RShift(hash, 14)
--end

local function GetItemNameFromLink(link)
    return GetItemInfo(link)
end

local function ScanRecipes(useCraftInstead)
    local tradeskillName
    if (useCraftInstead) then
        tradeskillName = GetCraftDisplaySkillLine()
    else
        tradeskillName = GetTradeSkillLine()
    end
    
    -- Update 2020/03/07: code gets to here when Poisons levels up, adding a catch to make it exit if poisons craft window is open             
	if (not tradeskillName) or (tradeskillName == "UNKNOWN") or (tradeskillName == L["Poisons"]) then return end	-- may happen after a patch, or under extreme lag, so do not save anything to the db !
                                   
	local char = addon.ThisCharacter
	local profession = char.Professions[tradeskillName]
    profession.Name = tradeskillName

	ScanRecipeCategories(profession, useCraftInstead)
		
	local numRecipes 
    if (useCraftInstead) then
        numRecipes = GetNumCrafts();
    else
        numRecipes = GetNumTradeSkills(); --C_TradeSkillUI.GetAllRecipeIDs()
    end
    
	if (not numRecipes) or (numRecipes == 0) then return end
	                           
    -- Moved this down here because, for some reason, the first time opening a profession book after a reload doesn't make any of them visible to addons?
    local crafts = profession.Crafts
	wipe(crafts)
    
	local resultItems = addon.ref.global.ResultItems
    local resultItemNames = addon.ref.global.ResultItemNames
	local reagentsDB = addon.ref.global.Reagents
	
	addon.ref.global.Recipes[tradeskillName] = addon.ref.global.Recipes[tradeskillName] or {}
	local recipesDB = addon.ref.global.Recipes[tradeskillName]
	local reagentsInfo = {}
	
	wipe(profession.Cooldowns)
    
    -- Setting the default to 1 because enchanting doesn't have categories
    local categoryID = 1
	
    local firstTradeSkillNum = 1
    if (not useCraftInstead) then
        firstTradeSkillNum = GetFirstTradeSkill()
    end    
    
	for recipeIndex = firstTradeSkillNum, numRecipes do
        local recipeID = GenerateSpellID(recipeIndex, profession.Name)
        local skillType, itemLink, itemName
        if (useCraftInstead) then
            skillType = select(3, GetCraftInfo(recipeIndex))
            itemLink = GetCraftItemLink(recipeIndex)
            itemName = GetCraftInfo(recipeIndex)
        else
            skillType = select(2, GetTradeSkillInfo(recipeIndex))
            itemLink = GetTradeSkillItemLink(recipeIndex) --C_TradeSkillUI.GetRecipeItemLink(recipeID)
            if (itemLink) then  --exclude headers
                itemName = GetItemNameFromLink(itemLink)
            end
        end
		if (skillType == "header") then
            categoryID = recipeIndex
        else
    		-- scan reagents for all recipes (even unlearned)
    		wipe(reagentsInfo)
    		
    		local numReagents 
            if (useCraftInstead) then
                numReagents = GetCraftNumReagents(recipeIndex)
            else
                numReagents = GetTradeSkillNumReagents(recipeIndex) --C_TradeSkillUI.GetRecipeNumReagents(recipeID)
            end
    		for reagentIndex = 1, numReagents do
                local count, link
                if (useCraftInstead) then
    			     _, _, count = GetCraftReagentInfo(recipeIndex, reagentIndex)
    			     link = GetCraftReagentItemLink(recipeIndex, reagentIndex) 
                else
                     _, _, count = GetTradeSkillReagentInfo(recipeIndex, reagentIndex) --C_TradeSkillUI.GetRecipeReagentInfo(recipeID, reagentIndex)
    			     link = GetTradeSkillReagentItemLink(recipeIndex, reagentIndex) --C_TradeSkillUI.GetRecipeReagentItemLink(recipeID, reagentIndex)
    			end
                
    			if link and count then
    				local itemID = tonumber(link:match("item:(%d+)"))
    				if itemID then
    					table.insert(reagentsInfo, format("%s,%s", itemID, count))
    				end
    			end
    		end
    		
    		reagentsDB[recipeID] = table.concat(reagentsInfo, "|")
    
    		-- Resulting item ID
    		if itemLink then
                -- there does not seem to be an equivalent Craft function to GetTradeSkillNumMade. Presuming its always 1 for those windows. I mean its enchanting so it must be.
    			local maxMade = 1
                if (not useCraftInstead) then
                    _, maxMade = GetTradeSkillNumMade(recipeIndex) --C_TradeSkillUI.GetRecipeNumItemsProduced(recipeID)
                end
    			if maxMade > 255 then maxMade = 255 end
    			          
    			local itemID = tonumber(itemLink:match("item:(%d+)"))
                          
    			if itemID then
    				resultItems[recipeID] = maxMade + LShift(itemID, 8) 	-- bits 0-7 = maxMade, bits 8+ = item id
                    resultItemNames[recipeID] = itemName
                elseif itemName then
                    resultItemNames[recipeID] = itemName
    			end
    		end
    		
    		-- Get recipe info
    		--local info = C_TradeSkillUI.GetRecipeInfo(recipeID)
            -- only one rank in Classic
    		local recipeRank = 1;
            local totalRanks = 1;
            local highestRankID = 1;
    		
    		-- if we are rank 2 out of 3 for a recipe, do not save rank 1 and rank 3
    		--if recipeID == highestRankID then
    		
                -- Classic: The actual spellID of the recipeID cannot be retrieved by addons, so we have to convert the recipeID into something we can store that will still be unique
    			-- save the recipe
    			crafts[categoryID] = crafts[categoryID] or {}
    			table.insert(crafts[categoryID], 
    				SkillTypeToColor[skillType]
                    -- Classic: you can't see unlearned recipes in the tradeskill window 
    			    + LShift(1, 2) 	-- bit 2 => 1 = learned, 0 = not learned     --[[(info.learned == true) and 1 or 0]]--
    				+ LShift(recipeRank, 3)		-- bits 3-4 = recipe rank
    				+ LShift(totalRanks, 5)		-- bits 5-6 = max rank
    				+ LShift(recipeID, 7))		-- bits 7+ = recipeID
    		--end
    		
    		-- scan cooldown
    		local cooldown = nil
            if (not useCraftInstead) then
                cooldown = GetTradeSkillCooldown(recipeIndex)--C_TradeSkillUI.GetRecipeCooldown(recipeID)
            end
    		if cooldown then
    			-- ex: "Hexweave Cloth|86220|1533539676" expire at "now + cooldown"
    			table.insert(profession.Cooldowns, format("%s|%d|%d", GetTradeSkillInfo(recipeIndex), cooldown, cooldown + time()))
    		end
        end
	end
	
	addon:SendMessage("DATASTORE_RECIPES_SCANNED", char, tradeskillName)
end

local function ScanTradeSkills(useCraftInstead)
	ScanRecipes(useCraftInstead)	
	addon.ThisCharacter.lastUpdate = time()
end

-- Updating ScanProfessionInfo with a version for Classic that scans the currently open tradeskill window
local function ClassicScanProfessionInfo(useCraftInstead)
    -- arguments should be: index and mainIndex ... wtf are these even?
    local profName
    
    if (useCraftInstead) then
        profName = GetCraftDisplaySkillLine();
        -- TODO: Ignore Beast Training window, which is programmed as a "craft"
    else
        profName = GetTradeSkillLine();
    end
    if (profName == "UNKNOWN") then
        print("DataStore_Crafts error: profName is UNKNOWN")
        return
    elseif (profName == nil) then
        -- This should handle the beast training case, but I don't have a hunter to test it with
        return
    end
    
	local char = addon.ThisCharacter
    local index = 0
    local mainIndex = false
    
    -- 1.13-012: adding a check to remove duplicate professions incorrectly saved in previous versions of this addon
    if (char["Prof"..1]) and (char["Prof"..2]) and (char["Prof"..1] == char["Prof"..2]) then
        char["Prof"..2] = nil
    end
    
    if (profName == L["Cooking"]) then
        index = 3
    elseif (profName == L["Poisons"]) then
        return -- Don't scan Poisons
    elseif (profName == L["Beast_Training"]) then
        return
    elseif (profName == L["First Aid"]) then    
        index = 4
    elseif (char["Prof"..1] == profName) or (char["Prof"..1] == nil) or (char["Prof"..1] == "UNKNOWN") then
        index = 1
        mainIndex = true
    elseif (char["Prof"..2] == profName) or (char["Prof"..2] == nil) or (char["Prof"..2] == "UNKNOWN") then
        index = 2
        mainIndex = true
    else
        return
    end
       
	if not char or not index then return end
                     
    local _, rank, maxRank
    if (useCraftInstead) then
        _, rank, maxRank = GetCraftDisplaySkillLine();
    else
        _, rank, maxRank = GetTradeSkillLine();        
    end
	local profession = char.Professions[profName]
	profession.CurrentLevelName = ClassicProfessionLevelToLevelName(rank)
	
	if mainIndex then
		char["Prof"..index] = profName
	end
                          
    profession.Rank = rank
	profession.MaxRank = maxRank
                          
    ScanTradeSkills(useCraftInstead)
end

-- *** Event Handlers ***
local function OnPlayerAlive()
    -- Grab the player's fishing and gathering skills from the Skills API
    local char = addon.ThisCharacter
    for i = 1, GetNumSkillLines() do
        local name, _, _, skillLevel, _, _, maxSkillLevel = GetSkillLineInfo(i)
        if (name == L["Fishing"]) then
            if (not addon.ThisCharacter.Professions["Fishing"]) then addon.ThisCharacter.Professions["Fishing"] = {} end
            char.Professions["Fishing"].Rank = skillLevel
            char.Professions["Fishing"].Name = name
            char.Professions["Fishing"].MaxRank = maxSkillLevel
            char.lastUpdate = time()
        end
        for _, s in ipairs({L["Herbalism"], L["Skinning"], L["Mining"]}) do
            if (name == s) then
                for j = 1, 2 do
                    local p = char["Prof"..j]
                    if (p == nil) or (p == "UNKNOWN") then
                        char["Prof"..j] = name
                        break
                    elseif p == s then
                        break
                    end
                end
                char.Professions[s].Rank = skillLevel
                char.Professions[s].Name = name
                char.Professions[s].MaxRank = maxSkillLevel
                char.lastUpdate = time()
            end
        end
    end
end

local function OnTradeSkillClose()
	addon:UnregisterEvent("TRADE_SKILL_CLOSE")
	addon.isOpen = nil
end

local function OnTradeSkillShow()
    -- can't link tradeskills from other players in Classic, so this line is not needed
	-- if C_TradeSkillUI.IsTradeSkillLinked() or C_TradeSkillUI.IsTradeSkillGuild() or C_TradeSkillUI.IsNPCCrafting() then return end
    
    if (addon.isOpen) then return end
              
	addon:RegisterEvent("TRADE_SKILL_CLOSE", OnTradeSkillClose)
	addon.isOpen = true
    ClassicScanProfessionInfo();
end

local function OnCraftClose()
	addon:UnregisterEvent("CRAFT_CLOSE")
	addon.isOpen = nil
end

-- This one is for Enchanting. For some reason Enchanting isn't programmed as a "tradeskill"
local function OnCraftShow()
    -- To prevent issues caused by players jumping from one open profession window to another without closing the original first.
    if (addon.isOpen) then return end
     
    addon:RegisterEvent("CRAFT_CLOSE", OnCraftClose)
	addon.isOpen = true
    ClassicScanProfessionInfo(true);
end

-- this turns
--	"Your skill in %s has increased to %d."
-- into
--	"Your skill in (.+) has increased to (%d+)."
local arg1pattern, arg2pattern
if GetLocale() == "deDE" then		
	-- ERR_SKILL_UP_SI = "Eure Fertigkeit '%1$s' hat sich auf %2$d erhöht.";
	arg1pattern = "'%%1%$s'"
	arg2pattern = "%%2%$d"
else
	arg1pattern = "%%s"
	arg2pattern = "%%d"
end

local skillUpMsg = gsub(ERR_SKILL_UP_SI, arg1pattern, "(.+)")
skillUpMsg = gsub(skillUpMsg, arg2pattern, "(%%d+)")

local function OnChatMsgSkill(self, msg)
	if msg and addon.isOpen then	-- point gained while ts window is open ? rescan
		local skill = msg:match(skillUpMsg)
        -- TODO: check if the skillup was for the currently open profession pane
		if skill then -- and skill == --C_TradeSkillUI.GetTradeSkillLine() then	-- if we gained a skill point in the currently opened profession pane, rescan
			ScanTradeSkills()
		end
	end
--	ScanProfessionLinks() -- added to update skills upon firing of skillup event 
end


local unlearnMsg = gsub(ERR_SPELL_UNLEARNED_S, arg1pattern, "(.+)")

local function OnChatMsgSystem(self, msg)
	if msg then
		local skillLink = msg:match(unlearnMsg)
		if skillLink then
			local skillName = skillLink:match("%[(.+)%]")
			if skillName then		-- clear the list of recipes
				local char = addon.ThisCharacter
				wipe(char.Professions[skillName])
				char.Professions[skillName] = nil
			end
			
			-- this won't help, as GetProfessions does not return the right values right after the profession has been abandonned.
			-- The problem of listing Prof1 & Prof2 with potentially the same value fixes itself after the next logon though.
			-- Until I find more time to work around this issue, we will live with it .. it's not like players are abandonning professions 100x / day :)
			-- ScanProfessionLinks()	
		end
	end
end

local function OnDataSourceChanged(self)
	if C_TradeSkillUI.IsTradeSkillLinked() or C_TradeSkillUI.IsTradeSkillGuild() or C_TradeSkillUI.IsNPCCrafting() then return end
	
	ScanTradeSkills()
end


-- ** Mixins **
local function _GetProfession(character, name)
	if name then
		return character.Professions[name]
	end
end
	
local function _GetProfessions(character)
	return character.Professions
end

-- RETURNS: rank, maxRank, spellID
local function _GetProfessionInfo(profession)
	-- accepts a pointer (type == table)to the profession table, as returned by addon:GetProfession()
	
	local rank, maxRank, spellID

    if (not profession) then
        return 0, 0, nil
    end

	if type(profession) == "table" then
		rank = profession.Rank
		maxRank = profession.MaxRank 
	elseif type(profession) == "string" then
        print("Error in DataStore_Crafts - professions cannot be linked in classic, so this function should not have been called this way")
	end
    
    spellID = ProfessionSpellID[profession.Name]
	
	return tonumber(rank) or 0, tonumber(maxRank) or 0, tonumber(spellID)
end
	
local function _GetNumRecipeCategories(profession)
	return (profession.Categories) and #profession.Categories or 0
end

local function GetCategoryName(id)
	return addon.ref.global.RecipeCategoryNames[id]
end

local function _GetRecipeCategoryInfo(profession, index)
	local category = profession.Categories[index]
	return category.id, GetCategoryName(category.id), category.Rank, category.MaxRank
end

local function _GetNumRecipeCategorySubItems(profession, index)
    return 0
end

local function _GetRecipeInfo(recipeData)
	local color = bAnd(recipeData, 3)			-- Bits 0-1 = color
	local isLearned = TestBit(recipeData, 2) 	-- Bit 2 = isLearned
	local recipeRank = bAnd(RShift(recipeData, 3), 3)		-- bits 3-4 = recipe rank
	local totalRanks = bAnd(RShift(recipeData, 5), 3)		-- bits 5-6 = max rank
	-- local minMade = bAnd(RShift(recipeData, 7), 255)		-- bits 7-14 = minMade (8 bits)
	-- local maxMade = bAnd(RShift(recipeData, 15), 255)		-- bits 15-22 = maxMade (8 bits)
	local recipeID = RShift(recipeData, 7)		-- bits 7+ = recipeID
	
	return color, recipeID, isLearned, recipeRank, totalRanks, minMade, maxMade
end

-- Iterate through all recipes, and callback a function for each of them
local function _IterateRecipes(profession, mainCategory, subCategory, callback)
    if (subCategory ~= 0) then
        print("Error in DataStore_Crafts - subCategory is not zero, subCategories do not exist in Classic")
        return
    end
         
	-- mainCategory : category index (or 0 for all)
	-- subCategory : sub-category index (or 0 for all)
	local crafts = profession.Crafts
    
    -- bugfix for error thrown when the player hasn't registered this profession at all yet
	if(profession.Categories == nil) then return; end

	-- loop through categories
	for _, catIndex in pairs(profession.Categories) do -- = 1, _GetNumRecipeCategories(profession) do
        local catID = catIndex.id
		-- if there is no filter on main category, or if it is just the one we want to see
		if (mainCategory == 0) or (mainCategory == catID) then
            
			local recipes = profession.Crafts[catID]
			if type(recipes) == "table" then
						-- loop through recipes
				for i = 1, #recipes do
					local stop = callback(recipes[i])
							
							-- exit if the callback returns true
					if stop then return end
				end
			end
		end
	end
end

local function _GetCraftCooldownInfo(profession, index)
	local cooldown = profession.Cooldowns[index]
	local name, resetsIn, expiresAt = strsplit("|", cooldown)
	
	resetsIn = tonumber(resetsIn)
	expiresAt = tonumber(expiresAt)	
	local expiresIn = expiresAt - time()
	
	return name, expiresIn, resetsIn, expiresAt
end

local function _GetNumActiveCooldowns(profession)
	assert(type(profession) == "table")		-- this is the pointer to a profession table, obtained through addon:GetProfession()
	return #profession.Cooldowns
end

local function _ClearExpiredCooldowns(profession)
	assert(type(profession) == "table")		-- this is the pointer to a profession table, obtained through addon:GetProfession()
	
	for i = #profession.Cooldowns, 1, -1 do		-- from last to first, to avoid messing up indexes when removing entries
		local _, expiresIn = _GetCraftCooldownInfo(profession, i)
		if expiresIn <= 0 then		-- already expired ? remove it
			table.remove(profession.Cooldowns, i)
		end
	end
end

local function _GetNumRecipesByColor(profession)
	-- counts the number of orange, yellow, green and grey recipes.
	local counts = { [0] = 0, [1] = 0, [2] = 0, [3] = 0 }
	
	_IterateRecipes(profession, 0, 0, function(recipeData) 
		local color = _GetRecipeInfo(recipeData)
		counts[color] = counts[color] + 1
	end)
	
	return counts[3], counts[2], counts[1], counts[0]		-- orange, yellow, green, grey
end

local function _IsCraftKnown(profession, spellID)
	-- returns true if a given spell ID is known in the profession passed as first argument
	local isKnown = false
    local spellName = GetSpellInfo(spellID)
    
    if (not profession) then return false end                
         
	_IterateRecipes(profession, 0, 0, function(recipeData)
		local _, recipeID, isLearned = _GetRecipeInfo(recipeData) 

		if addon.ref.global.ResultItemNames[recipeID] == spellName and isLearned then
            isKnown = true
			return true	-- stop iteration
		end
	end)

	return isKnown
end

local function _GetGuildCrafters(guild)
	return guild.Members
end

local function _GetGuildMemberProfession(guild, member, index)
	local m = guild.Members[member]
	local profession = m.Professions[index]
	
	if type(profession) == "string" then
		local spellID = profession:match("trade:(%d+):")
		return tonumber(spellID), profession, m.lastUpdate	-- return the profession spell ID + full link
	elseif type(profession) == "number" then
		return profession, nil, m.lastUpdate					-- return the profession spell ID
	end
end

local function _GetProfessionSpellID(name)
	-- name can be either the english name or the localized name
	return ProfessionSpellID[name]
end

local function _GetProfession1(character)
	local profession = _GetProfession(character, character.Prof1)
	if profession then
		local rank, maxRank, spellID = _GetProfessionInfo(profession)
		return rank or 0, maxRank or 0, spellID, character.Prof1
	end
	return 0, 0, nil, nil
end

local function _GetProfession2(character)
	local profession = _GetProfession(character, character.Prof2)
	if profession then
		local rank, maxRank, spellID = _GetProfessionInfo(profession)
		return rank or 0, maxRank or 0, spellID, character.Prof2
	end
	return 0, 0, nil, nil
end

local function _GetCookingRank(character)
	local profession = _GetProfession(character, GetSpellInfo(SPELL_ID_COOKING))
	if profession then
		return _GetProfessionInfo(profession)
	end
end

local function _GetFirstAidRank(character)
    local profession = _GetProfession(character, GetSpellInfo(SPELL_ID_FIRSTAID))
    if profession then
        return _GetProfessionInfo(profession)
    end
end

local function _GetFishingRank(character)
	local profession = _GetProfession(character, "Fishing")
	if profession then
		return _GetProfessionInfo(profession)
	end
end

local function _GetCraftReagents(recipeID)
	return addon.ref.global.Reagents[recipeID]
end

local function _GetResultItemName(recipeID)
    return addon.ref.global.ResultItemNames[recipeID]
end

local function _GetCraftResultItem(recipeID)
	local itemData = addon.ref.global.ResultItems[recipeID]
	local itemID, maxMade
	
	if itemData then
		maxMade = bAnd(itemData, 255)		-- bits 0-7 = maxMade (8 bits)
		itemID = RShift(itemData, 8)		-- bits 8+ = recipeID
	end

	return itemID, maxMade
end


local PublicMethods = {
	GetProfession = _GetProfession,
	GetProfessions = _GetProfessions,
	GetProfessionInfo = _GetProfessionInfo,
	GetCraftCooldownInfo = _GetCraftCooldownInfo,
	GetNumActiveCooldowns = _GetNumActiveCooldowns,
	ClearExpiredCooldowns = _ClearExpiredCooldowns,
	GetNumRecipesByColor = _GetNumRecipesByColor,
	GetNumRecipeCategories = _GetNumRecipeCategories,
	GetRecipeCategoryInfo = _GetRecipeCategoryInfo,
	GetNumRecipeCategorySubItems = _GetNumRecipeCategorySubItems,
	GetRecipeInfo = _GetRecipeInfo,
	IterateRecipes = _IterateRecipes,
	IsCraftKnown = _IsCraftKnown,		-- needs update
	GetGuildCrafters = _GetGuildCrafters,
	GetGuildMemberProfession = _GetGuildMemberProfession,
	GetProfessionSpellID = _GetProfessionSpellID,
	GetProfession1 = _GetProfession1,
	GetProfession2 = _GetProfession2,
	GetCookingRank = _GetCookingRank,
	GetFishingRank = _GetFishingRank,
    GetFirstAidRank = _GetFirstAidRank,
	GetCraftReagents = _GetCraftReagents,
	GetCraftResultItem = _GetCraftResultItem,
    GetResultItemName = _GetResultItemName
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)
	addon.ref = LibStub("AceDB-3.0"):New(addonName .. "RefDB", ReferenceDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetProfession")
	DataStore:SetCharacterBasedMethod("GetProfessions")
	
	DataStore:SetCharacterBasedMethod("GetProfession1")
	DataStore:SetCharacterBasedMethod("GetProfession2")
	DataStore:SetCharacterBasedMethod("GetCookingRank")
	DataStore:SetCharacterBasedMethod("GetFishingRank")
    DataStore:SetCharacterBasedMethod("GetFirstAidRank")
	
	DataStore:SetGuildBasedMethod("GetGuildCrafters")
	DataStore:SetGuildBasedMethod("GetGuildMemberProfession")
end

function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ENTERING_WORLD", OnPlayerAlive)
	addon:RegisterEvent("TRADE_SKILL_UPDATE", OnTradeSkillShow)
    addon:RegisterEvent("CRAFT_UPDATE", OnCraftShow)
	addon:RegisterEvent("CHAT_MSG_SKILL", OnChatMsgSkill)
	addon:RegisterEvent("CHAT_MSG_SYSTEM", OnChatMsgSystem)
	addon:RegisterEvent("TRADE_SKILL_DATA_SOURCE_CHANGED", OnDataSourceChanged)
	
--	addon:SetupOptions()
	ClearExpiredProfessions()	-- automatically cleanup guild profession links that are from an older version
	LocalizeProfessionSpellIDs()
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ENTERING_WORLD")
	addon:UnregisterEvent("TRADE_SKILL_UPDATE")
    addon:UnregisterEvent("CRAFT_UPDATE")
	addon:UnregisterEvent("CHAT_MSG_SKILL")
	addon:UnregisterEvent("CHAT_MSG_SYSTEM")
	addon:UnregisterEvent("TRADE_SKILL_DATA_SOURCE_CHANGED")
end

function addon:IsTradeSkillWindowOpen()
	-- note : maybe there's a function in the WoW API to test this, but I did not find it :(
	return addon.isOpen
end
