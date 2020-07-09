local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

Altoholic.Sharing = {}
Altoholic.Sharing.Clients = {}		-- authorized clients
Altoholic.Sharing.Content = {}		-- shared content
Altoholic.Sharing.AvailableContent = {}		-- available content
Altoholic.Sharing.Ongoing = {}

local THIS_ACCOUNT = "Default"

local AUTH_AUTO	= 1
local AUTH_ASK		= 2
local AUTH_NEVER	= 3

local function FirstCap(s)
	return strupper(s:sub(1,1)) .. strlower(s:sub(2))	-- first letter in cap, the rest lowercase
end

local function GetNumClients()
	return #Altoholic.db.global.Sharing.Clients
end

local function GetClientInfo(index)
	local info = Altoholic.db.global.Sharing.Clients[index]
	if info then
		local name, auth = strsplit("|", info)
		return name, tonumber(auth)
	end
end

local function GetSizeInKB(size)
	return format("%2.1f KB", size / 1024)
end

-- *** Authorized Clients ***

local ClientsScrollFrame_Desc = {
	NumLines = 6,
	LineHeight = 18,
	Frame = "AltoholicFrameSharingClients",
	GetSize = function()
			return #Altoholic.db.global.Sharing.Clients 
		end,
	Update = function(self, offset, entry, desc)
			for i=1, desc.NumLines do
				local line = i + offset
				if line <= desc:GetSize() then
					local name, auth = GetClientInfo(line)
					_G[ entry..i.."NameNormalText" ].name = name
					
					if auth == AUTH_NEVER then
						name = colors.red..name
					elseif auth == AUTH_AUTO then
						name = colors.green..name
					end
					
					_G[ entry..i.."NameNormalText" ]:SetText(name)
					_G[ entry..i.."Never" ]:SetChecked((auth == AUTH_NEVER) and 1 or nil)
					_G[ entry..i.."Ask" ]:SetChecked((auth == AUTH_ASK) and 1 or nil)
					_G[ entry..i.."Auto" ]:SetChecked((auth == AUTH_AUTO) and 1 or nil)
				
					_G[ entry..i ]:SetID(line)
					_G[ entry..i ]:Show()
				else
					_G[ entry..i.."NameNormalText" ].name = nil
				end
			end
		end,
}

function Altoholic.Sharing.Clients:Update()
	Altoholic:ScrollFrameUpdate(ClientsScrollFrame_Desc)
end

function Altoholic.Sharing.Clients:Add(name)
	if type(name) ~= "string" then return end
	if strlen(name) == 0 then return end
	
	name = FirstCap(name)
	
	local clients = Altoholic.db.global.Sharing.Clients
	local alreadyExists
	
	for _, clientInfo in pairs(clients) do
		local clientName = strsplit("|", clientInfo)
		if clientName == name then
			alreadyExists = true
		end
	end
	
	if not alreadyExists then			-- if this character does not exist, add it
		table.insert(clients, format("%s|%s", name, AUTH_ASK))
	end
end

function Altoholic.Sharing.Clients:Delete(name)
	if type(name) ~= "string" then return end
	
	name = FirstCap(name)
	local clients = Altoholic.db.global.Sharing.Clients
	
	for index, clientInfo in pairs(clients) do
		local clientName = strsplit("|", clientInfo)
		if clientName == name then			-- clear the name if found in the table
			table.remove(clients, index)
			break
		end
	end
end

function Altoholic.Sharing.Clients:Auth_OnClick(self)
	local line = self:GetParent():GetID()
	local name = GetClientInfo(line)
	local clients = Altoholic.db.global.Sharing.Clients
	
	clients[line] = format("%s|%s", name, self:GetID())
	Altoholic.Sharing.Clients:Update()
end

function Altoholic.Sharing.Clients:GetRights(name)
	-- returns the right of a given player
	local clients = Altoholic.db.global.Sharing.Clients
	
	for i = 1, GetNumClients() do
		local clientName, auth = GetClientInfo(i)
		if clientName == name then
			return auth
		end
	end
end


-- *** Shared Content ***

local mandatoryModules = {		-- mandatory modules are sent anyway (if the character is shared, of course)
	"DataStore_Characters",
}

local optionalModules = {		-- this defines the order in which modules should be listed
	"DataStore_Auctions",
	"DataStore_Containers",
	"DataStore_Crafts",
	"DataStore_Inventory",
	"DataStore_Mails",
	"DataStore_Quests",
	"DataStore_Reputations",
}

local moduleLabels = {		-- these are the labels
	["DataStore_Auctions"] = format("%s & %s", AUCTIONS, BIDS),
	["DataStore_Containers"] = L["Containers"],
	["DataStore_Crafts"] = TRADE_SKILLS,
	["DataStore_Inventory"] = L["Equipment"],
	["DataStore_Mails"] = L["Mails"],
	["DataStore_Quests"] = L["Quests"],
	["DataStore_Reputations"] = L["Reputations"],
}


local GUILD_HEADER_LINE				= 1
local CHARACTER_HEADER_LINE		= 3
local CHARACTER_DATASTORE_LINE	= 4
local CLASS_REFDATA_LINE			= 5		-- only for available content, not for shared content view
local CRAFT_REFDATA_LINE = 6

local function isGuildShared(realm, name)
	local sc = Altoholic.db.global.Sharing.SharedContent
	local index = format("%s.%s.%s", THIS_ACCOUNT, realm, name)

	return sc[index]
end

local function isCharacterShared(key)
	local sc = Altoholic.db.global.Sharing.SharedContent
	return sc[key]
end

local function isCharacterDataShared(key, module)
	local sc = Altoholic.db.global.Sharing.SharedContent
	local index = key .. "." .. module
	
	return sc[index]
end



local ContentCollapsedHeaders			-- a table containing the collapsed headers (character keys)

local ContentScrollFrame_Desc = {
	NumLines = 14,
	LineHeight = 18,
	Frame = "AltoholicFrameSharedContent",
	GetSize = function()
			return #Altoholic.Sharing.Content.view
		end,
	Update = function(self, offset, entry, desc)
			local line, LineDesc
			
			for i=1, desc.NumLines do
				line = i + offset
				local lineData = Altoholic.Sharing.Content.view[line]
				if line <= desc:GetSize() then
					LineDesc = desc.Lines[lineData.linetype]
					LineDesc:DrawCollapseButton(lineData, entry..i)
					LineDesc:DrawCheckBox(lineData, entry..i)
					_G[entry..i.."CheckText"]:SetText(LineDesc:GetText(lineData))
					_G[entry..i.."Check"]:SetPoint("TOPLEFT", LineDesc:GetOffset(lineData), 0)
					_G[ entry..i ]:SetID(line)
					_G[ entry..i ]:Show()
				end
			end
		end,
	Lines = {
		[CHARACTER_HEADER_LINE] = {
			GetText = function(self, line)
					local _, realm, name = strsplit(".", line.key)
					return format("%s|r / %s", colors.white..realm, DataStore:GetColoredCharacterName(line.key))
				end,
			GetOffset = function(self, line)
					return 20
				end,
			DrawCollapseButton = function(self, line, entry)
					local item = _G[ entry.."Collapse" ]
					if not ContentCollapsedHeaders[line.key] then
						item:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					else
						item:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					end
					item:Show()
				end,
			DrawCheckBox = function(self, line, entry)
					_G[ entry.."Check" ]:SetChecked(isCharacterShared(line.key))
				end,
		},
		[CHARACTER_DATASTORE_LINE] = {
			GetText = function(self, line)
					return moduleLabels[line.module]
				end,
			GetOffset = function(self, line)
					return 40
				end,
			DrawCollapseButton = function(self, line, entry)
					_G[ entry.."Collapse" ]:Hide()
				end,
			DrawCheckBox = function(self, line, entry)
					_G[ entry.."Check" ]:SetChecked(isCharacterDataShared(line.key, line.module))
				end,
		},
	},
}


function Altoholic.Sharing.Content:BuildView()
	ContentCollapsedHeaders = ContentCollapsedHeaders or {}
	self.view = self.view or {}
	wipe(self.view)
	
	local DS = DataStore
	for realm in pairs(DS:GetRealms()) do			-- all realms on this account	
		for characterName, character in pairs(DS:GetCharacters(realm)) do
			table.insert(self.view, { linetype = CHARACTER_HEADER_LINE, key = character } )
			
			if not ContentCollapsedHeaders[character] then
				for _, v in pairs(optionalModules) do
					table.insert(self.view, { linetype = CHARACTER_DATASTORE_LINE, key = character, module = v } )
				end
			end
		end
	end
end

function Altoholic.Sharing.Content:Update()
	Altoholic:ScrollFrameUpdate(ContentScrollFrame_Desc)
end

function Altoholic.Sharing.Content:Collapse_OnClick(self, button)
	local id = self:GetParent():GetID()
	local self = Altoholic.Sharing.Content
	local line = self.view[id]
	
	local index
	if line.linetype == GUILD_HEADER_LINE then
		index = format("%s.%s.%s", THIS_ACCOUNT, line.realm, line.name)
	elseif line.linetype == CHARACTER_HEADER_LINE then
		index = line.key
	end
	
	if not ContentCollapsedHeaders[index] then
		ContentCollapsedHeaders[index] = true
	else
		ContentCollapsedHeaders[index] = nil
	end
	self:BuildView()
	self:Update()
end

function Altoholic.Sharing.Content:Check_OnClick(self, button)
	local id = self:GetParent():GetID()
	local isChecked = self:GetChecked()
	
	local self = Altoholic.Sharing.Content
	local line = self.view[id]
	
	local sc = Altoholic.db.global.Sharing.SharedContent
	local index
	
    if line.linetype == CHARACTER_HEADER_LINE then
		index = line.key
	else
		index = line.key .. "." .. line.module
        -- Code added 2020/03/12:
        -- if we just checked a child option, check the parent option, too
        if isChecked and line.linetype == CHARACTER_DATASTORE_LINE then
            sc[line.key] = isChecked
        end
	end
	sc[index] = isChecked
	self:BuildView()
	self:Update()
end

function Altoholic.Sharing.Content:ToggleAll(self, button)
	local tex
	
	if not self.isCollapsed then			-- are all entries collapsed or not ?
		self.isCollapsed = true
		tex = "Interface\\Buttons\\UI-PlusButton-Up"
	else
		self.isCollapsed = nil
		tex = "Interface\\Buttons\\UI-MinusButton-Up"
	end
	self:SetNormalTexture(tex); 
	
	local DS = DataStore
	for realm in pairs(DS:GetRealms()) do			-- all realms on this account
		for guildName, _ in pairs(DS:GetGuilds(realm)) do
			local index = format("%s.%s.%s", THIS_ACCOUNT, realm, guildName)
			ContentCollapsedHeaders[index] = self.isCollapsed
		end
	
		for characterName, character in pairs(DS:GetCharacters(realm)) do
			ContentCollapsedHeaders[character] = self.isCollapsed
		end
	end
		
	local self = Altoholic.Sharing.Content
	self:BuildView()
	self:Update()
end

function Altoholic.Sharing.Content:CheckAll(self, button)
	local sc = Altoholic.db.global.Sharing.SharedContent

	if not self.isChecked then			-- are all entries collapsed or not ?
		self.isChecked = true
	else
		self.isChecked = nil
	end
	self:SetChecked(self.isChecked);
	
	local DS = DataStore
	for realm in pairs(DS:GetRealms()) do			-- all realms on this account
		-- guilds
		for guildName, guild in pairs(DS:GetGuilds(realm)) do
			local index = format("%s.%s.%s", THIS_ACCOUNT, realm, guildName)
			sc[index] = self.isChecked
			
		end
	
		-- characters
		for characterName, character in pairs(DS:GetCharacters(realm)) do
			sc[character] = self.isChecked
			
			for _, v in pairs(optionalModules) do
				sc[character .. "." .. v] = self.isChecked
			end
		end
	end

	local self = Altoholic.Sharing.Content
	self:BuildView()
	self:Update()
end

local TOC_SETREALM				= "1"
local TOC_SETGUILD				= "2"
--local TOC_BANKTAB					= "3"
local TOC_SETCHAR					= "4"
local TOC_DATASTORE				= "5"
local TOC_REFDATA					= "6"
local TOC_CRAFT_REFDATA        = "7"

function Altoholic.Sharing.Content:GetOptionalModuleName(index)
	return optionalModules[index]
end

function Altoholic.Sharing.Content:GetSourceTOC()
	-- prepares the table of content that will be sent to the user requesting account sharing
	
	-- This method adds all realms, all guilds, all characters on the current account, assuming they are shared
	-- Reference data (available classes) is always sent, and mandatory modules in datastore are not sent (they're implicit, if a character is shared, they must be sent)
	
	-- on the receiving side, display mandatory items as part of the list, but greyed out/disabled and automatically selected for transfer
	
	local DS = DataStore
	local serializedData, lastUpdate
	local toc = {}

	for realm in pairs(DS:GetRealms()) do			-- all realms on this account
	    table.insert(toc, format("%s|%s", TOC_SETREALM, realm))
			
		for guildName, guild in pairs(DS:GetGuilds(realm)) do		-- add guilds
		    if isGuildShared(realm, guildName) then
			    table.insert(toc, format("%s|%s", TOC_SETGUILD, guildName))
			end
		end
	
		for characterName, character in pairs(DS:GetCharacters(realm)) do
		    if isCharacterShared(character) then
			    -- get the size of mandatory modules
				local size = 0
				for k, module in pairs(mandatoryModules) do
					serializedData = Altoholic:Serialize(DS:GetCharacterTable(module, characterName, realm))
					size = size + strlen(serializedData)
				end
				
				local _, class = DS:GetCharacterClass(character)
				lastUpdate = DS:GetModuleLastUpdate("DataStore_Characters", characterName, realm)
				table.insert(toc, format("%s|%s|%s|%s|%s", TOC_SETCHAR, characterName, class, size, lastUpdate or 0))
				
				for k, module in pairs(optionalModules) do

					-- DataStore_Spells and DataStore_Talents aren't working yet
					if (module ~= "DataStore_Spells" and module ~= "DataStore_Talents") then
					    if isCharacterDataShared(character, module) then
    						-- evaluate the size of transferred data
                            local characterTable = DS:GetCharacterTable(module, characterName, realm)
	    					if (module == "DataStore_Crafts") then
                                characterTable = DS:CraftsPrepareCharacterTableForSharing(characterTable)
                            end
                            serializedData = Altoholic:Serialize(characterTable)
		    				lastUpdate = DS:GetModuleLastUpdate(module, characterName, realm)
					    end
					
						-- only pass the key to the right datastore module (ex 4 for DataStore_Crafts)
						table.insert(toc, format("%s|%s|%s|%s", TOC_DATASTORE, k, strlen(serializedData), lastUpdate or 0))
					end
				end
			end
		end
	end
	
	-- share the crafting reference database
    -- the structure is:
    -- refDB -> ResultItems -> ID = {name = string, [itemID = int, maxmade = int]} the last two are not used by enchanting
    -- -------> Reagents -> ID = string, where the string is a list joined using | characters 
    --for k, v in pairs(DS:GetCraftsReferenceTable()) do
    --    serializedData = Altoholic:Serialize(v)
    --    table.insert(toc, format("%s|%s", TOC_CRAFT_REFDATA, k, strlen(serializedData)))
    --end	
	return toc
end




-- *** Available Content ***
local AvailableContentCollapsedHeaders			-- a table containing the collapsed headers (character keys)
local AvailableContentCheckedItems				-- a table containing the items checked in the TOC (index = true)

local AvailableContentScrollFrame_Desc = {
	NumLines = 10,
	LineHeight = 18,
	Frame = "AltoholicFrameAvailableContent",
	GetSize = function()
			return #Altoholic.Sharing.AvailableContent.view
		end,
	Update = function(self, offset, entry, desc)
			local line, LineDesc
			
			for i=1, desc.NumLines do
				line = i + offset
				local lineData = Altoholic.Sharing.AvailableContent.view[line]
				if line <= desc:GetSize() then
					LineDesc = desc.Lines[lineData.linetype]
					LineDesc:DrawCollapseButton(lineData, entry..i)
					_G[entry..i.."CheckText"]:SetText(LineDesc:GetText(lineData))
					_G[entry..i.."Check"]:SetPoint("TOPLEFT", LineDesc:GetOffset(lineData), 0)
					_G[entry..i.."Check"]:SetID(lineData.parentID)
					_G[entry..i.."Check"]:SetChecked(AvailableContentCheckedItems[lineData.parentID])
					
					if lineData.size then
						_G[entry..i.."Size"]:SetText(colors.lightBlue..GetSizeInKB(lineData.size))
						_G[entry..i.."Size"]:Show()
					else
						_G[entry..i.."Size"]:Hide()
					end
					
					if lineData.lastUpdate then
						local text
						if lineData.lastUpdate == 0 then
							text = colors.red..NEVER
						else
							text = LineDesc:GetDate(lineData)
						end
					
						_G[entry..i.."Date"]:SetText(text)
						_G[entry..i.."Date"]:Show()
					else
						_G[entry..i.."Date"]:Hide()
					end
					
					_G[ entry..i ]:SetID(line)
					_G[ entry..i ]:Show()
				end
			end
		end,
	Lines = {
		[CHARACTER_HEADER_LINE] = {
			GetText = function(self, line)
					local _, realm, name = strsplit(".", line.key)
					name = DataStore:GetClassColor(line.class) ..name
					return format("%s|r / %s", colors.white..realm, name)
				end,
			GetOffset = function(self, line)
					return 20
				end,
			DrawCollapseButton = function(self, line, entry)
					local item = _G[ entry.."Collapse" ]
					if not AvailableContentCollapsedHeaders[line.key] then
						item:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					else
						item:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					end
					item:Show()
				end,
			GetDate = function(self, line)
					local account, realm, name = strsplit(".", line.key)
					local last = DataStore:GetModuleLastUpdate("DataStore_Characters", name, realm, account)
					
					if last == line.lastUpdate then
						return colors.green.."Up-to-date"
					else
						return colors.lightBlue..date("%m/%d/%Y %H:%M", line.lastUpdate)
					end
				end,
		},
		[CHARACTER_DATASTORE_LINE] = {
			GetText = function(self, line)
					return moduleLabels[line.module]
				end,
			GetOffset = function(self, line)
					return 40
				end,
			DrawCollapseButton = function(self, line, entry)
					_G[ entry.."Collapse" ]:Hide()
				end,
			GetDate = function(self, line)
					local account, realm, name = strsplit(".", line.key)
					local last = DataStore:GetModuleLastUpdate(line.module, name, realm, account)
					
					if last == line.lastUpdate then
						return colors.green.."Up-to-date"
					else
						return colors.lightBlue..date("%m/%d/%Y %H:%M", line.lastUpdate)
					end
				end,
		},
		[CLASS_REFDATA_LINE] = {
			GetText = function(self, line)
					return "Talent Tree Reference : " .. FirstCap(line.class)
				end,
			GetOffset = function(self, line)
					return 20
				end,
			DrawCollapseButton = function(self, line, entry)
					_G[ entry.."Collapse" ]:Hide()
				end,
			GetDate = function(self, line)
					return colors.lightBlue..date("%m/%d/%Y %H:%M", line.lastUpdate)
				end,
		},
        [CRAFT_REFDATA_LINE] = {
            GetText = function(self, line)
                return "Datastore_Crafts Reference Data"
            end,
            GetOffset = function(self, line)
                return 20
            end,
            DrawCollapseButton = function(self, line, entry)
					_G[ entry.."Collapse" ]:Hide()
				end,            
            GetData = function(self, line)
                return line.key
            end,
        },
	},
}


function Altoholic.Sharing.AvailableContent:BuildView()
	AvailableContentCollapsedHeaders = AvailableContentCollapsedHeaders or {}
	AvailableContentCheckedItems = AvailableContentCheckedItems or {}
	self.view = self.view or {}
	wipe(self.view)
	
	local sharing = Altoholic.Comm.Sharing
	self.ToC = sharing.DestTOC
	if not self.ToC then return end
	
	local account = sharing:GetAccount()
	local realm, character, guildName
	
	for i = 1, #self.ToC do
		local tocType, arg1, arg2, arg3, arg4 = strsplit("|", self.ToC[i])
		
		if tocType == TOC_SETREALM then
			realm = arg1
		elseif tocType == TOC_SETCHAR then
			character = format("%s.%s.%s", account, realm, arg1)
			table.insert(self.view, { 
				linetype = CHARACTER_HEADER_LINE, 
				key = character, 
				class = arg2, 
				size = tonumber(arg3),
				lastUpdate = tonumber(arg4),
				parentID = i,
			} )
		elseif tocType == TOC_DATASTORE then
			if not AvailableContentCollapsedHeaders[character] then
				table.insert(self.view, { 
					linetype = CHARACTER_DATASTORE_LINE, 
					key = character, 
					module = optionalModules[tonumber(arg1)],
					size = tonumber(arg2),
					lastUpdate = tonumber(arg3),
					parentID = i,
				} )
			end
		elseif tocType == TOC_REFDATA then
			if not DataStore:IsClassKnown(arg1) then		-- filter to only list classes that are not yet available
				table.insert(self.view, { linetype = CLASS_REFDATA_LINE, class = arg1, size = tonumber(arg2), parentID = i } )
			end
        elseif tocType == TOC_CRAFT_REFDATA then
            table.insert(self.view, {linetype = CRAFT_REFDATA_LINE, key = arg1, size = tonumber(arg2), parentID = i } )
		end
	end
end

function Altoholic.Sharing.AvailableContent:Update()
	Altoholic:ScrollFrameUpdate(AvailableContentScrollFrame_Desc)
end

function Altoholic.Sharing.AvailableContent:Collapse_OnClick(self, button)
	local id = self:GetParent():GetID()
	local content = Altoholic.Sharing.AvailableContent
	local line = content.view[id]
	
	local index
    
    if line.linetype == CHARACTER_HEADER_LINE then
		index = line.key
	end
	
	if not AvailableContentCollapsedHeaders[index] then
		AvailableContentCollapsedHeaders[index] = true
	else
		AvailableContentCollapsedHeaders[index] = nil
	end
	content:BuildView()
	content:Update()
end

function Altoholic.Sharing.AvailableContent:Check_OnClick(self, button)
	local id = self:GetID()
	
	if not AvailableContentCheckedItems[id] then
		AvailableContentCheckedItems[id] = true
        
        -- if a header was just checked, check everything underneath it
        local content = Altoholic.Sharing.AvailableContent
    	if not content.view then return end
    	
    	for k, v in pairs(content.view) do			-- parse the whole view
    		local index
    		if v.parentID == id then
                if v.linetype == CHARACTER_HEADER_LINE then
                    local started = false
                    for k2, v2 in pairs(content.view) do
                        if started then
                            if v2.linetype == CHARACTER_HEADER_LINE then
                                break
                            else
                                AvailableContentCheckedItems[v2.parentID] = true
                            end
                        else
                            if (k == k2) and (v == v2) then
                                started = true
                            end
                        end
                    end
                end
                break
    		end
    	end
	else
		AvailableContentCheckedItems[id] = nil
	end
    
    local content = Altoholic.Sharing.AvailableContent
    content:BuildView()
	content:Update()
end

function Altoholic.Sharing.AvailableContent:ToggleAll(self, button)
	local tex
	
	if not self.isCollapsed then			-- are all entries collapsed or not ?
		self.isCollapsed = true
		tex = "Interface\\Buttons\\UI-PlusButton-Up"
	else
		self.isCollapsed = nil
		tex = "Interface\\Buttons\\UI-MinusButton-Up"
	end
	self:SetNormalTexture(tex); 
	
	local content = Altoholic.Sharing.AvailableContent
	if not content.view then return end
	
	for k, v in pairs(content.view) do			-- parse the whole view
		local index
		if v.linetype == CHARACTER_HEADER_LINE then
			index = v.key
		end

		if index then
			AvailableContentCollapsedHeaders[index] = self.isCollapsed
		end
	end
		
	content:BuildView()
	content:Update()
end

function Altoholic.Sharing.AvailableContent:CheckAll(self, button)
	if not self.isChecked then			-- are all entries collapsed or not ?
		self.isChecked = true
	else
		self.isChecked = nil
	end
	self:SetChecked(self.isChecked);
	
	local content = Altoholic.Sharing.AvailableContent
	if not content.view then return end
	
	for k, v in pairs(content.view) do			-- parse the whole view
		AvailableContentCheckedItems[v.parentID] = self.isChecked	-- check or uncheck all
	end

	local self = Altoholic.Sharing.AvailableContent
	self:BuildView()
	self:Update()
end

function Altoholic.Sharing.AvailableContent:IsItemChecked(index)
	if self.ToC then
		local TocData = self.ToC[index]
		if TocData then
			local TocType = strsplit("|", TocData)
					
			if TocType == TOC_SETREALM then
				-- until I have more time to implement a fancier solution, always return true for realm lines, necessary to correctly switch realms when importing data from foreign realms
				return true
			end
		end
	end

	return AvailableContentCheckedItems[index]
end

function Altoholic.Sharing.AvailableContent:Clear()
	-- clear command, after a successful transfer
	
	wipe(AvailableContentCollapsedHeaders)
	wipe(AvailableContentCheckedItems)
	
	self:BuildView()
	self:Update()
end

--====================================
-- Begin code for Ongoing Sharing tab
--====================================
-- handles receiving an alert from DataStore
local function OnContainerChangesSingleReceived(self, changes)
    local serializedData = Altoholic:Serialize("OnContainerChangeSingle", changes)
    
    for entry = 1, addon:GetOption("UI.Sharing.Ongoing.NumTargets") do
        if _G["AltoholicFrameOngoingAltListEntry"..entry.."Check"]:GetChecked() then
            local targetName = addon:GetOption("UI.Sharing.Ongoing.Target"..entry..".Character")
            local realmName = addon:GetOption("UI.Sharing.Ongoing.Target"..entry..".Realm")
    	    Altoholic:SendCommMessage("AltoOngoing", serializedData, "WHISPER", targetName.."-"..realmName)
        end
    end
end

-- handles receiving an addon message communication from another player
local function OngoingCommHandler(prefix, message, distribution, sender)
	local success, msgType, arg1, arg2, arg3 = addon:Deserialize(message)

	if success and msgType then
        if msgType == "OnContainerChangeSingle" then
            sender = Ambiguate(sender, "mail")
            local senderName, senderRealm = strsplit("-", sender)
            
            for entry = 1, addon:GetOption("UI.Sharing.Ongoing.NumTargets") do
                if string.lower(senderName) == string.lower(addon:GetOption("UI.Sharing.Ongoing.Target"..entry..".Character")) then
                    -- find what account the character is saved as
                    for accountName in pairs(DataStore:GetAccounts()) do
                        for characterName, character in pairs(DataStore:GetCharacters(senderRealm, accountName)) do
                            if characterName and (string.lower(characterName) == string.lower(senderName)) then
                                DataStore:ImportBagChanges(character, arg1)
                                addon:SendMessage("ALTOHOLIC_CONTAINER_CHANGES_COMPLETE")
                                return
                            end
                        end
                    end
                end
            end
        end
	end
end

local function updateOngoingScrollFrame()
    local numTargets = addon:GetOption("UI.Sharing.Ongoing.NumTargets")
    if not numTargets then numTargets = 0 end
    
    for i = 1, 10 do
        if i <= numTargets then    
            _G["AltoholicFrameOngoingAltListEntry"..i]:Show()
            _G["AltoholicFrameOngoingAltListEntry"..i.."CharacterName"]:SetText(addon:GetOption("UI.Sharing.Ongoing.Target"..i..".Character"))
            _G["AltoholicFrameOngoingAltListEntry"..i.."RealmName"]:SetText(addon:GetOption("UI.Sharing.Ongoing.Target"..i..".Realm"))
            _G["AltoholicFrameOngoingAltListEntry"..i.."DeleteButton"]:Show()
        else
            _G["AltoholicFrameOngoingAltListEntry"..i]:Hide()
        end
    end
end

local function ongoingAddButtonClicked()
    local numTargets = addon:GetOption("UI.Sharing.Ongoing.NumTargets")
    if not numTargets then numTargets = 0 end
    
    local characterName = AltoAccountSharingTab2_CharacterNameEditBox:GetText()
    local realmName = AltoAccountSharingTab2_RealmNameEditBox:GetText()
    
    if (not characterName) or (characterName == "") then return end
    if (not realmName) or (realmName == "") then return end
    
    numTargets = numTargets + 1
    addon:SetOption("UI.Sharing.Ongoing.NumTargets", numTargets)
    addon:SetOption("UI.Sharing.Ongoing.Target"..numTargets..".Character", characterName)
    addon:SetOption("UI.Sharing.Ongoing.Target"..numTargets..".Realm", realmName)
    
    updateOngoingScrollFrame()
end

local function initialization()
    AltoAccountSharingOngoingDisclaimer:SetText("Share the entire database using the other tab FIRST.\nActivate this on ALL characters, pointing at each other.\nThe scroll bar isn't implemented yet.")
    AltoAccountSharingOngoingText1:SetText("Character name to share to.")
    AltoAccountSharing_AddOngoingButton:SetText("Add character")
    AltoAccountSharing_AddOngoingButton:SetScript("OnClick", ongoingAddButtonClicked)
    AltoAccountSharingOngoingText2:SetText("Character Name")
    AltoAccountSharingOngoingText3:SetText("Realm")
    AltoAccountSharingOngoingText4:SetText("Delete")
    AltoAccountSharingOngoingText5:SetText("Realm (no spaces)")
    AltoAccountSharingTab2_RealmNameEditBox:SetText(GetNormalizedRealmName())
    
    addon:RegisterMessage("DATASTORE_CONTAINER_CHANGES_SINGLE", OnContainerChangesSingleReceived)
    addon:RegisterComm("AltoOngoing", OngoingCommHandler)
    
    if not addon:GetOption("UI.Sharing.Ongoing.NumTargets") then
        addon:SetOption("UI.Sharing.Ongoing.NumTargets", 0)
    end
    
    updateOngoingScrollFrame()     
end
hooksecurefunc(Altoholic, "OnEnable", initialization)

function Altoholic.Sharing.Ongoing:CheckAll(self, button)
    local numTargets = addon:GetOption("UI.Sharing.Ongoing.NumTargets")
    if not numTargets then numTargets = 0 end
    
    for i = 1, numTargets do
        _G["AltoholicFrameOngoingAltListEntry"..i.."Check"]:SetChecked(self:GetChecked())
    end
end

function Altoholic.Sharing.Ongoing:DeleteClicked(self, button)
    local entry = self:GetParent():GetID()
    
    local numTargets = addon:GetOption("UI.Sharing.Ongoing.NumTargets")
    
    if entry > numTargets then return end
    
    for i = 1, numTargets do
        if i == numTargets then
            -- the last item in the list, nil it
            addon:SetOption("UI.Sharing.Ongoing.Target"..i..".Character", nil)
            addon:SetOption("UI.Sharing.Ongoing.Target"..i..".Realm", nil)
        elseif i >= entry then
            -- bump everything up in the list
            addon:SetOption("UI.Sharing.Ongoing.Target"..i..".Character", addon:GetOption("UI.Sharing.Ongoing.Target"..(i+1)..".Character"))
            addon:SetOption("UI.Sharing.Ongoing.Target"..i..".Realm", addon:GetOption("UI.Sharing.Ongoing.Target"..(i+1)..".Realm"))
        end
    end                
    
    numTargets = numTargets - 1
    addon:SetOption("UI.Sharing.Ongoing.NumTargets", numTargets)
    
    updateOngoingScrollFrame()    
end

function Altoholic.Sharing.Ongoing:ShareCheckButtonClicked(self, button)
    local entry = self:GetParent():GetID()
    
    local characterName = addon:GetOption("UI.Sharing.Ongoing.Target"..entry..".Character")
    local realmName = addon:GetOption("UI.Sharing.Ongoing.Target"..entry..".Realm") 

    if (not characterName) or (characterName == "") then return end
    if (not realmName) or (realmName == "") then return end
end