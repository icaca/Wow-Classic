local L = CEPGP_Locale:GetLocale("CEPGP")

function CEPGP_initialise()
	C_Timer.After(3, function()
		_, _, _, CEPGP_ElvUI = GetAddOnInfo("ElvUI");
		if not CEPGP_ElvUI then CEPGP_ElvUI = GetAddOnInfo("TukUI"); end
		_G["CEPGP_version_number"]:SetText("Running Version: " .. CEPGP_Info.Version .. " " .. CEPGP_Info.Build);
		
		C_ChatInfo.RegisterAddonMessagePrefix("CEPGP");
			
		if not CEPGP_notice then
			CEPGP_notice = false;
		end
		if CHANNEL == nil then
			CHANNEL = "Guild";
		end
		if CEPGP_lootChannel == nil then
			CEPGP_lootChannel = "Raid";
		end
		if MOD == nil then
			MOD = 1;
		end
		if COEF == nil then
			COEF = 4.83;
		end
		if MOD_COEF == nil then
			MOD_COEF = 2;
		end
		if BASEGP == nil then
			BASEGP = 1;
		end
		if CEPGP_min_threshold == nil then
			CEPGP_min_threshold = 2;
		end
		if CEPGP_keyword == nil then
			CEPGP_keyword = "!need";
		end
		for k, v in pairs(CEPGP_EncounterInfo.Bosses) do
			if not EPVALS[k] or not tonumber(EPVALS[k]) then -- An expected number is missing
				if k == "The Silithid Royalty" then
					EPVALS[k] = EPVALS["Silithid Royalty"] or CEPGP_EncounterInfo.Bosses["The Silithid Royalty"];
					
				elseif k == "The Twin Emperors" then
					EPVALS[k] = EPVALS["Twin Emperors"] or CEPGP_EncounterInfo.Bosses["Twin Emperors"];
					
				else
					EPVALS[k] = v;
				end
			end
			if AUTOEP[k] == nil then
				AUTOEP[k] = true;
			end
		end
		
		EPVALS["Teremus the Devourer"] = nil; -- Obsolete entries that need to be removed
		AUTOEP["Teremus the Devourer"] = nil;
		EPVALS["Emperor Vek'nilash"] = nil;
		AUTOEP["Emperor Vek'nilash"] = nil;
		EPVALS["Emperor Vek'lor"] = nil;
		AUTOEP["Emperor Vek'lor"] = nil;
		EPVALS["Vem"] = nil;
		AUTOEP["Vem"] = nil;
		EPVALS["Lord Kri"] = nil;
		AUTOEP["Lord Kri"] = nil;
		EPVALS["Princess Yauj"] = nil;
		AUTOEP["Princess Yauj"] = nil;
		EPVALS["Highlord Mograine"] = nil;
		AUTOEP["Highlord Mograine"] = nil;
		EPVALS["Thane Kor'thazz"] = nil;
		AUTOEP["Thane Kor'thazz"] = nil;
		EPVALS["Lady Blaumeux"] = nil;
		AUTOEP["Lady Blaumeux"] = nil;
		EPVALS["Sir Zeliek"] = nil;
		AUTOEP["Sir Zeliek"] = nil;
		
		local channels = {
			[1] = "Party",
			[2] = "Raid",
			[3] = "Guild",
			[4] = "Officer"
		};
		
		if not CEPGP_tContains(channels, CHANNEL) then
			CHANNEL = channels[3];
			--C_Timer.After(5, function()
				CEPGP_print("Your reporting channel has changed, please make sure it is set to the correct setting!");
			--end);
		end
		if not CEPGP_tContains(channels, CEPGP_lootChannel) then
			CEPGP_lootChannel = channels[2];
			--C_Timer.After(5, function()
				CEPGP_print("Your loot reporting channel has changed, please make sure it is set to the correct setting!");
			--end);
		end
		
		-- Localize boss names on the config UI
		local bossNames = {};
		table.insert(bossNames, _G["CEPGP_EP_options_mc"].bosses);
		table.insert(bossNames, _G["CEPGP_EP_options_bwl"].bosses);
		table.insert(bossNames, _G["CEPGP_EP_options_zg"].bosses);
		table.insert(bossNames, _G["CEPGP_EP_options_aq20"].bosses);
		table.insert(bossNames, _G["CEPGP_EP_options_aq40"].bosses);
		table.insert(bossNames, _G["CEPGP_EP_options_naxx"].bosses);
		table.insert(bossNames, _G["CEPGP_EP_options_worldboss"].bosses);
		
		if CEPGP_ntgetn(SLOTWEIGHTS) == 0 then
			SLOTWEIGHTS = {
				["2HWEAPON"] = 2,
				["WEAPONMAINHAND"] = 1.5,
				["WEAPON"] = 1.5,
				["WEAPONOFFHAND"] = 0.5,
				["HOLDABLE"] = 0.5,
				["SHIELD"] = 0.5,
				["WAND"] = 0.5,
				["RANGED"] = 2,
				["THROWN"] = 0.5,
				["RELIC"] = 0.5,
				["HEAD"] = 1,
				["NECK"] = 0.5,
				["SHOULDER"] = 0.75,
				["CLOAK"] = 0.5,
				["CHEST"] = 1,
				["ROBE"] = 1,
				["WRIST"] = 0.5,
				["HAND"] = 0.75,
				["WAIST"] = 0.75,
				["LEGS"] = 1,
				["FEET"] = 0.75,
				["FINGER"] = 0.5,
				["TRINKET"] = 0.75,
				["EXCEPTION"] = 1
			}
		end
		
		SLOTWEIGHTS["WAND"] = SLOTWEIGHTS["WAND"] or 0.5;
		SLOTWEIGHTS["RANGED"] = SLOTWEIGHTS["RANGEDRIGHT"] or SLOTWEIGHTS["RANGED"] or 2;
		SLOTWEIGHTS["RANGEDRIGHT"] = nil;
		
		if STANDBYPERCENT ==  nil then
			STANDBYPERCENT = 0;
		end
		if CEPGP_ntgetn(STANDBYRANKS) == 0 then
			for i = 1, 10 do
				STANDBYRANKS[i] = {};
				STANDBYRANKS[i][1] = GuildControlGetRankName(i);
				STANDBYRANKS[i][2] = false;
			end
		end
		if CEPGP_force_sync_rank == nil then
			CEPGP_force_sync_rank = 1;
		end
		if #CEPGP_response_buttons < 6 then
			CEPGP_response_buttons = {
				[1] = {
					true,
					"Main Spec",
					0,
					"Need"
				},
				[2] = {
					false,
					"Off Spec",
					0,
					"Greed"
				},
				[3] = {
					false,
					"Disenchant",
					0,
					"Disenchant"
				},
				[4] = {
					false,
					"Minor Upgrade",
					0,
					"Minor"
				},
				[5] = {
					false,
					"",
					100
				},
				[6] = {
					false,
					"Pass",
					100
				}
			};
		end
		
		tinsert(UISpecialFrames, "CEPGP_frame");
		tinsert(UISpecialFrames, "CEPGP_context_popup");
		tinsert(UISpecialFrames, "CEPGP_save_guild_logs");
		tinsert(UISpecialFrames, "CEPGP_restore_guild_logs");
		tinsert(UISpecialFrames, "CEPGP_settings_import");
		tinsert(UISpecialFrames, "CEPGP_override");
		tinsert(UISpecialFrames, "CEPGP_traffic");
		
		CEPGP_SendAddonMsg("version-check", "GUILD");
		for i, t in ipairs(bossNames) do
			for _, entity in pairs(t) do
				local boss = entity:GetText();
				if L[boss] then
					entity:SetText(L[boss]);
				end
			end
		end

		local kids = {_G["CEPGP_frame"]:GetChildren()};
		for _, child in ipairs(kids) do
			local function setChildText(frame)
				if frame.Text then
					if frame:GetText() then
						frame:SetText(L[frame:GetText()]);
					end
				end
				for _, subChild in ipairs({frame:GetChildren()}) do
					setChildText(subChild);
				end
			end
			setChildText(child);
		end
		
		--	Reorganising the override index to the new format
		for k, v in pairs(OVERRIDE_INDEX) do
			if string.find(k, "item:") then
				local args = CEPGP_split(k, ":");
				if tonumber(args[10]) then
					local id = CEPGP_getItemID(CEPGP_getItemString(k));
					local link = CEPGP_getItemLink(id);
					if link then
						OVERRIDE_INDEX[link] = v;
						OVERRIDE_INDEX[k] = nil;
					end
				end
			end
		end
		
		CEPGP.Attendance = CEPGP.Attendance or CEPGP_raid_logs;
		CEPGP.Backups = CEPGP.Backups or RECORDS;
		CEPGP.Channel = CEPGP.Channel or CHANNEL;
		CEPGP.Exclusions = CEPGP.Exclusions or {false,false,false,false,false,false,false,false,false,false};
		CEPGP.LootChannel = CEPGP.LootChannel or CEPGP_lootChannel;
		CEPGP.Notice = CEPGP.Notice or CEPGP_notice;
		CEPGP.Overrides = CEPGP.Overrides or OVERRIDE_INDEX;
		CEPGP.PollRate = CEPGP.PollRate or 0.0001;
		CEPGP.Sync = CEPGP.Sync or {ALLOW_FORCED_SYNC, CEPGP_force_sync_rank};
		CEPGP.Traffic = CEPGP.Traffic or TRAFFIC;
		if not CEPGP.Alt then
			CEPGP.Alt = {
				Links = {},
				BlockAwards = false,
				SyncEP = true,
				SyncGP = true,
			}
		end
		CEPGP.Alt.Links = CEPGP.Alt.Links or {};
		if not CEPGP.EP then
			CEPGP.EP = {
				AutoAward = AUTOEP,
				BossEP = EPVALS,
			}
		end
		if not CEPGP.Decay then
			CEPGP.Decay = {
				Separate = false,
			};
		end
		CEPGP.EP.AutoAward = CEPGP.EP.AutoAward or AUTOEP;
		CEPGP.EP.BossEP = CEPGP.EP.BossEP or EPVALS;
		if not CEPGP.GP then
			CEPGP.GP = {
				Base = 4.83,
				DecayFactor = false,
				Min = 1,
				Mod = 1,
				Multiplier = 2,
				SlotWeights = {
					["2HWEAPON"] = 2,
					["WEAPONMAINHAND"] = 1.5,
					["WEAPON"] = 1.5,
					["WEAPONOFFHAND"] = 0.5,
					["HOLDABLE"] = 0.5,
					["SHIELD"] = 0.5,
					["WAND"] = 0.5,
					["RANGED"] = 2,
					["RELIC"] = 0.5,
					["HEAD"] = 1,
					["NECK"] = 0.5,
					["SHOULDER"] = 0.75,
					["CLOAK"] = 0.5,
					["CHEST"] = 1,
					["ROBE"] = 1,
					["WRIST"] = 0.5,
					["HAND"] = 0.75,
					["WAIST"] = 0.75,
					["LEGS"] = 1,
					["FEET"] = 0.75,
					["FINGER"] = 0.5,
					["TRINKET"] = 0.75,
					["EXCEPTION"] = 1
				},
				Tooltips = false,
			}
		end
		CEPGP.GP.Base = COEF or CEPGP.GP.Base or 4.83;
		CEPGP.GP.Min = BASEGP or CEPGP.GP.Min or 1;
		CEPGP.GP.Mod = MOD or CEPGP.GP.Mod or 1;
		CEPGP.GP.Multiplier = MOD_COEF or CEPGP.GP.Multiplier or 2;
		
		local slotDefault = {
			["2HWEAPON"] = 2,
			["WEAPONMAINHAND"] = 1.5,
			["WEAPON"] = 1.5,
			["WEAPONOFFHAND"] = 0.5,
			["HOLDABLE"] = 0.5,
			["SHIELD"] = 0.5,
			["WAND"] = 0.5,
			["RANGED"] = 2,
			["RELIC"] = 0.5,
			["HEAD"] = 1,
			["NECK"] = 0.5,
			["SHOULDER"] = 0.75,
			["CLOAK"] = 0.5,
			["CHEST"] = 1,
			["ROBE"] = 1,
			["WRIST"] = 0.5,
			["HAND"] = 0.75,
			["WAIST"] = 0.75,
			["LEGS"] = 1,
			["FEET"] = 0.75,
			["FINGER"] = 0.5,
			["TRINKET"] = 0.75,
			["EXCEPTION"] = 1
		};
		
		CEPGP.GP.SlotWeights = CEPGP.GP.SlotWeights or {};
		
		for k, v in pairs(slotDefault) do
			if not CEPGP.GP.SlotWeights[k] then
				CEPGP.GP.SlotWeights[k] = v;
			end
		end
		
		if not CEPGP.Loot then
			CEPGP.Loot = {
				Announcement = "Whisper me for loot",
				AutoPass = CEPGP_auto_pass,
				AutoSort = CEPGP_PR_sort,
				Keyword = CEPGP_keyword,
				MinThreshold = CEPGP_min_threshold,
				MinReq = CEPGP_minEP,
				RaidVisibility = CEPGP_raid_wide_dist,
				ShowPass = CEPGP_show_passes,
				SuppressResponses = CEPGP_suppress_announcements,
				GUI = {
					Buttons = CEPGP_response_buttons,
					Enabled = CEPGP_loot_GUI,
					Timer = CEPGP_response_time
				}
			}
		end
		CEPGP.Loot.Announcement = CEPGP.Loot.Announcement or "Whisper me for loot";
		CEPGP.Loot.Keyword = CEPGP.Loot.Keyword or CEPGP_keyword;
		CEPGP.Loot.MinThreshold = CEPGP.Loot.MinThreshold or CEPGP_min_threshold;
		CEPGP.Loot.MinReq = CEPGP.Loot.MinReq or CEPGP_minEP;
		CEPGP.Loot.RaidVisibility = CEPGP.Loot.RaidVisibility or CEPGP_raid_wide_dist;
		
		if not CEPGP.Loot.GUI then
			CEPGP.Loot.GUI = {
				Buttons = CEPGP_response_buttons,
				Enabled = CEPGP_loot_GUI,
				Timer = CEPGP_response_time
			}
		end
		
		CEPGP.Loot.GUI.Buttons = CEPGP.Loot.GUI.Buttons or CEPGP_response_buttons or {[1]={true, "Main Spec", 0, "Need"},[2]={false, "Off Spec", 0, "Greed"},[3]={false, "Disenchant", 0, "Disenchant"},[4]={false, "Minor Upgrade", 0, "Minor"},[5]={false, "", 0},[6]={false, "Pass", 100}};
		for i = 1, 4 do
			if CEPGP_response_buttons[i][2] == "" or not CEPGP_response_buttons[i][2] then
				CEPGP_response_buttons[i][2] = i == 1 and "Main Spec" or i == 2 and "Off Spec" or i == 3 and "Disenchant" or i == 4 and "Minor Upgrade";
			end
			if CEPGP_response_buttons[i][4] == "" or not CEPGP_response_buttons[i][4] then
				CEPGP_response_buttons[i][4] = i == 1 and "Need" or i == 2 and "Greed" or i == 3 and "Disenchant" or i == 4 and "Minor";
			end
			
			if CEPGP.Loot.GUI.Buttons[i][2] == "" or not CEPGP.Loot.GUI.Buttons[i][2] then
				CEPGP.Loot.GUI.Buttons[i][2] = i == 1 and "Main Spec" or i == 2 and "Off Spec" or i == 3 and "Disenchant" or i == 4 and "Minor Upgrade";
			end
			if CEPGP.Loot.GUI.Buttons[i][4] == "" or not CEPGP.Loot.GUI.Buttons[i][4] then
				CEPGP.Loot.GUI.Buttons[i][4] = i == 1 and "Need" or i == 2 and "Greed" or i == 3 and "Disenchant" or i == 4 and "Minor";
			end
		end
		CEPGP.Loot.GUI.Timer = CEPGP.Loot.GUI.Timer or CEPGP_response_time;
		
		if not CEPGP.Standby then
			Standby = {
				AcceptWhispers = CEPGP_standby_accept_whispers,
				ByRank = CEPGP_standby_byrank,
				Enabled = STANDBYEP,
				Keyword = CEPGP_standby_whisper_msg,
				Manual = CEPGP_standby_manual,
				Offline = STANDBYOFFLINE,
				Percent = STANDBYPERCENT,
				Ranks = STANDBYRANKS,
				Roster = CEPGP_standbyRoster,
				Share = CEPGP_standby_share,
			}
		end
		
		CEPGP.Standby.Keyword = CEPGP.Standby.Keyword or CEPGP_standby_whisper_msg;
		CEPGP.Standby.Percent = CEPGP.Standby.Percent or STANDBYPERCENT;
		CEPGP.Standby.Ranks = CEPGP.Standby.Ranks or STANDBYRANKS;
		CEPGP.Standby.Roster = CEPGP.Standby.Roster or CEPGP_standbyRoster;
		CEPGP.Standby.Share = CEPGP.Standby.Share or CEPGP_standby_share;
		
		CEPGP_initInterfaceOptions();
		hooksecurefunc("ChatFrame_OnHyperlinkShow", CEPGP_addGPHyperlink);
		hooksecurefunc("GameTooltip_UpdateStyle", CEPGP_addGPTooltip);
		
		if not CEPGP_notice then
			CEPGP_notice_frame:Show();
		end
		
		if IsInRaid("player") and CEPGP_isML() == 0 then
			_G["CEPGP_confirmation"]:Show();
		end
		
		C_Timer.After(3, function()
			if IsInGuild() then
				for i = 1, GetNumGuildMembers() do
					local _, _, rankIndex = GetGuildRosterInfo(i);
					if CEPGP.Exclusions[rankIndex+1] then
						CEPGP_Info.NumExcluded = CEPGP_Info.NumExcluded + 1;
					end
				end
			end
			
			DEFAULT_CHAT_FRAME:AddMessage("|c00FFC100Classic EPGP Version: " .. CEPGP_Info.Version .. " " .. CEPGP_Info.Build .. " Loaded|r");
			if UnitInRaid("player") then
				CEPGP_rosterUpdate("GROUP_ROSTER_UPDATE");
			end
		end);
	end);
end

function CEPGP_initInterfaceOptions()
	local panel = {};
	panel.main = _G["CEPGP_interface_options"];
	panel.main.name = "Classic EPGP";
	
	panel.alt = _G["CEPGP_options_alt_mangement"];
	panel.alt.name = "Alt Management";
	panel.alt.parent = panel.main.name;
	
	panel.ep = _G["CEPGP_EP_options"];
	panel.ep.name = "EP Management";
	panel.ep.parent = panel.main.name;
	
	panel.gp = _G["CEPGP_gp_options"];
	panel.gp.name = "GP Management";
	panel.gp.parent = panel.main.name;
	
	panel.loot = _G["CEPGP_loot_options"];
	panel.loot.name = "Loot Distribution";
	panel.loot.parent = panel.main.name;
	
	panel.plugins = _G["CEPGP_options_plugins"];
	panel.plugins.name = "Plugin Manager";
	panel.plugins.parent = panel.main.name;	
	
	panel.standby = _G["CEPGP_standby_options"];
	panel.standby.name = "Standby EP";
	panel.standby.parent = panel.main.name;
	
	InterfaceOptions_AddCategory(panel.main);
	InterfaceOptions_AddCategory(panel.alt);
	InterfaceOptions_AddCategory(panel.ep);
	InterfaceOptions_AddCategory(panel.gp);
	InterfaceOptions_AddCategory(panel.loot);
	InterfaceOptions_AddCategory(panel.plugins);
	InterfaceOptions_AddCategory(panel.standby);
	
	_G["CEPGP_interface_options_version"]:SetText("Classic EPGP Version " .. CEPGP_Info.Version .. " " .. CEPGP_Info.Build);
end

function CEPGP_initDropdown(frame, initFunction, displayMode, level, menuList)
	frame.menuList = menuList;

	--securecall("UIDropDownMenu_InitializeHelper", frame);

	-- Set the initialize function and call it.  The initFunction populates the dropdown list.
	if ( initFunction ) then
		UIDropDownMenu_SetInitializeFunction(frame, initFunction);
		--initFunction(frame, level, frame.menuList);
	end

	--master frame
	if(level == nil) then
		level = 1;
	end

	local dropDownList = _G["DropDownList"..level];
	dropDownList.dropdown = frame;
	dropDownList.shouldRefresh = true;

	UIDropDownMenu_SetDisplayMode(frame, displayMode);
end

function CEPGP_addResponse(player, response, roll)
	
	CEPGP_itemsTable[player] = {};
	CEPGP_itemsTable[player][3] = response;
	
	if (CEPGP.Loot.PassRolls and response == 6) or response < 6 then
		CEPGP_itemsTable[player][4] = roll;
	end
	
	CEPGP_SendAddonMsg("!need;"..player..";"..CEPGP_DistID..";"..response..";"..roll, "RAID"); --!need;playername;itemID (of the item being distributed) is sent for sharing with raid assist
end

function CEPGP_calcGP(link, quantity, id)	
	local name, rarity, ilvl, itemType, subType, slot, classID, subClassID;
	if id then
		name, link, rarity, ilvl, itemType, subType, _, _, slot, _, _, classID, subClassID = GetItemInfo(id);
	elseif link then
		name, _, rarity, ilvl, itemType, subType, _, _, slot, _, _, classID, subClassID = GetItemInfo(link);
	else
		return 0;
	end
	if not name and CEPGP_itemExists(tonumber(id)) then
		local item = Item:CreateFromItemID(tonumber(id));
		item:ContinueOnItemLoad(function()
			name, link, rarity, ilvl, itemType, subType, _, _, slot, _, _, classID, subClassID = GetItemInfo(id);
			if OVERRIDE_INDEX[name] then return OVERRIDE_INDEX[name]; end
			if OVERRIDE_INDEX[CEPGP_getItemLink(id)] then return OVERRIDE_INDEX[CEPGP_getItemLink(id)]; end
			
			for _, k in pairs(CEPGP_tokens) do
				for slotName, v in pairs(k) do
					if k[slotName][tonumber(id)] then
						slot = "INVTYPE_" .. string.upper(slotName);
						ilvl = k[slotName][tonumber(id)];
						break;
					end
				end
			end
			if slot == "" or slot == nil then
				slot = "INVTYPE_EXCEPTION";
			end
			
			if slot == "INVTYPE_ROBE" then slot = "INVTYPE_CHEST"; end
			if classID == 2 and subClassID == 19 then slot = "INVTYPE_WAND" end;
			if classID == 2 and (subClassID == 2 or subClassID == 3 or subClassID == 18) then slot = "INVTYPE_RANGED" end;
			
			if CEPGP_debugMode then
				local quality = rarity == 0 and "Poor" or rarity == 1 and "Common" or rarity == 2 and "Uncommon" or rarity == 3 and "Rare" or rarity == 4 and "Epic" or "Legendary";
				CEPGP_print("Name: " .. name);
				CEPGP_print("Rarity: " .. quality);
				CEPGP_print("Item Level: " .. ilvl);
				CEPGP_print("Class ID: " .. classID);
				CEPGP_print("Subclass ID: " .. subClassID);
				CEPGP_print(GetItemSubClassInfo(classID, subClassID), false);
				CEPGP_print("Item Type: " .. itemType);
				CEPGP_print("Subtype: " .. subType);
				CEPGP_print("Slot: " .. slot);
			end
			slot = strsub(slot,strfind(slot,"INVTYPE_")+8,string.len(slot));
			slot = SLOTWEIGHTS[slot];
			if ilvl and rarity and slot then
				return math.floor((((COEF * (MOD_COEF^((ilvl/26) + (rarity-4))) * slot)*MOD)*quantity));
			else
				return 0;
			end
		end);
	else
		if not ilvl then ilvl = 0; end
		
		if OVERRIDE_INDEX[name] then return OVERRIDE_INDEX[name]; end
		if OVERRIDE_INDEX[CEPGP_getItemLink(id)] then return OVERRIDE_INDEX[CEPGP_getItemLink(id)]; end
		--local compare = "item[%-?" .. id .. ":]+";
		--return OVERRIDE_INDEX[compare];
		
		--for k, v in pairs(OVERRIDE_INDEX) do
		
			--[[local compName = GetItemInfo(k);
			if compName == name then
				return v;
			end]]
		--end
		for _, k in pairs(CEPGP_tokens) do
			for slotName, v in pairs(k) do
				if k[slotName][tonumber(id)] then
					slot = "INVTYPE_" .. string.upper(slotName);
					ilvl = k[slotName][tonumber(id)];
					break;
				end
			end
		end
		if slot == "" or slot == nil then
			slot = "INVTYPE_EXCEPTION";
		end
		
		if slot == "INVTYPE_ROBE" then slot = "INVTYPE_CHEST"; end
		if classID == 2 and subClassID == 19 then slot = "INVTYPE_WAND" end;
		if classID == 2 and (subClassID == 2 or subClassID == 3 or subClassID == 18) then slot = "INVTYPE_RANGED" end;
		
		
		if CEPGP_debugMode then
			local quality = rarity == 0 and "Poor" or rarity == 1 and "Common" or rarity == 2 and "Uncommon" or rarity == 3 and "Rare" or rarity == 4 and "Epic" or "Legendary";
			CEPGP_print("Name: " .. name);
			CEPGP_print("Rarity: " .. quality);
			CEPGP_print("Item Level: " .. ilvl);
			CEPGP_print("Class ID: " .. classID);
			CEPGP_print("Subclass ID: " .. subClassID);
			CEPGP_print(GetItemSubClassInfo(classID, subClassID), false);
			CEPGP_print("Item Type: " .. itemType);
			CEPGP_print("Subtype: " .. subType);
			CEPGP_print("Slot: " .. slot);
		end
		slot = strsub(slot,strfind(slot,"INVTYPE_")+8,string.len(slot));
		slot = SLOTWEIGHTS[slot];
		if ilvl and rarity and slot then
			return math.floor((((COEF * (MOD_COEF^((ilvl/26) + (rarity-4))) * slot)*MOD)*quantity));
		else
			return 0;
		end
	end
end

function CEPGP_addGPTooltip(frame)
	if not CEPGP_gp_tooltips or not frame:GetItem() or frame:GetItem() == nil or frame:GetItem() == "" then return; end
	local _, link = frame:GetItem();
	local id = CEPGP_getItemID(CEPGP_getItemString(link));
	if not CEPGP_itemExists(tonumber(id)) then return; end
	local name = GetItemInfo(id);
	if not name and CEPGP_itemExists(tonumber(id)) then
		local item = Item:CreateFromItemID(tonumber(id));
		item:ContinueOnItemLoad(function()
			local gp = CEPGP_calcGP(_, 1, id);
			frame:AddLine("GP Value: " .. gp, {1,1,1});	
		end);
	else
		local gp = CEPGP_calcGP(_, 1, id);
		frame:AddLine("GP Value: " .. gp, {1,1,1});
	end
	
end

function CEPGP_addGPHyperlink(self, iString)
	if not string.find(iString, "item:") or not CEPGP_gp_tooltips then return; end
	local id = CEPGP_getItemID(iString);
	local name = GetItemInfo(id);
	for i = 1, ItemRefTooltip:NumLines() do
		if string.find(_G["ItemRefTooltipTextLeft"..i]:GetText(), "GP Value:") then return end;
	end
	if not name and CEPGP_itemExists(tonumber(id)) then
		local item = Item:CreateFromItemID(tonumber(id));
		item:ContinueOnItemLoad(function()
			local gp = CEPGP_calcGP(_, 1, id);
			ItemRefTooltip:AddLine("GP Value: " .. gp, {1,1,1});
			ItemRefTooltip:Show();
		end);
	else
		local gp = CEPGP_calcGP(_, 1, id);
		ItemRefTooltip:AddLine("GP Value: " .. gp, {1,1,1});
		ItemRefTooltip:Show();
	end
end

function CEPGP_populateFrame(items)
	local subframe = nil;
	
	if CEPGP_mode == "loot" then
		CEPGP_cleanTable();
	elseif CEPGP_mode ~= "loot" then
		CEPGP_cleanTable();
	end
	local tempItems = {};
	local total;
	if CEPGP_mode == "guild" and _G["CEPGP_guild"]:IsVisible() then
		CEPGP_UpdateGuildScrollBar();
	elseif CEPGP_mode == "raid" and _G["CEPGP_raid"]:IsVisible() then
		CEPGP_UpdateRaidScrollBar();
	elseif CEPGP_mode == "loot" then
		subframe = CEPGP_loot;
		local count = 0;
		if not items then
			total = 0;
		else
			local i = 1;
			for _,value in pairs(items) do 
				tempItems[i] = value;
				i = i + 1;
				count = count + 1;
			end
			i = nil;
		end
		total = count;
	end
	if CEPGP_mode == "loot" then 
		for i = 1, total do
			local texture, name, quality, gp, colour, iString, link, slot, x, quantity;
			x = i;
			texture = tempItems[i][1];
			name = tempItems[i][2];
			colour = ITEM_QUALITY_COLORS[tempItems[i][3]];
			link = tempItems[i][4];
			iString = tempItems[i][5];
			slot = tempItems[i][6];
			quantity = tempItems[i][7];
			gp = CEPGP_calcGP(link, quantity, CEPGP_getItemID(iString));
			if _G[CEPGP_mode..'item'..i] ~= nil then
				_G[CEPGP_mode..'announce'..i]:Show();
				_G[CEPGP_mode..'announce'..i]:SetWidth(20);
				_G[CEPGP_mode..'announce'..i]:SetScript('OnClick', function()
					if CEPGP_ntgetn(CEPGP_roster) < (GetNumGuildMembers() - CEPGP_Info.NumExcluded) and CEPGP_Info.Polling then
						local callback = function() CEPGP_announce(link, x, slot, quantity) end;
						CEPGP_Info.QueuedAnnouncement = callback;
						CEPGP_print(L["This item will be announced in a moment. Please wait and keep the loot window open"]);
					else
						CEPGP_announce(link, x, slot, quantity);
						CEPGP_distribute:SetID(_G[CEPGP_mode..'announce'..i]:GetID());
					end
				end);
				_G[CEPGP_mode..'announce'..i]:SetID(slot);
				
				_G[CEPGP_mode..'icon'..i]:Show();
				_G[CEPGP_mode..'icon'..i]:SetScript('OnEnter', function() GameTooltip:SetOwner(_G[CEPGP_mode..'icon'..i], "ANCHOR_BOTTOMLEFT") GameTooltip:SetHyperlink(iString) GameTooltip:Show() end);
				_G[CEPGP_mode..'icon'..i]:SetScript('OnLeave', function() GameTooltip:Hide() end);
				
				_G[CEPGP_mode..'texture'..i]:Show();
				_G[CEPGP_mode..'texture'..i]:SetTexture(texture);
				
				_G[CEPGP_mode..'item'..i]:Show();
				_G[CEPGP_mode..'item'..i].text:SetText(link);
				_G[CEPGP_mode..'item'..i].text:SetTextColor(colour.r, colour.g, colour.b);
				_G[CEPGP_mode..'item'..i].text:SetPoint('CENTER',_G[CEPGP_mode..'item'..i]);
				_G[CEPGP_mode..'item'..i]:SetWidth(_G[CEPGP_mode..'item'..i].text:GetStringWidth());
				_G[CEPGP_mode..'item'..i]:SetScript('OnClick', function() SetItemRef(link, iString) end);
				
				_G[CEPGP_mode..'itemGP'..i]:SetText(gp);
				_G[CEPGP_mode..'itemGP'..i]:SetTextColor(colour.r, colour.g, colour.b);
				_G[CEPGP_mode..'itemGP'..i]:SetWidth(35);
				_G[CEPGP_mode..'itemGP'..i]:SetScript('OnEnterPressed', function() _G[CEPGP_mode..'itemGP'..i]:ClearFocus() end);
				_G[CEPGP_mode..'itemGP'..i]:SetAutoFocus(false);
				_G[CEPGP_mode..'itemGP'..i]:Show();
			else
				subframe.announce = CreateFrame('Button', CEPGP_mode..'announce'..i, subframe, 'UIPanelButtonTemplate');
				subframe.announce:SetHeight(20);
				subframe.announce:SetWidth(20);
				subframe.announce:SetScript('OnClick', function()
					if CEPGP_ntgetn(CEPGP_roster) < (GetNumGuildMembers() - CEPGP_Info.NumExcluded) and CEPGP_Info.Polling then
						local callback = function() CEPGP_announce(link, x, slot, quantity) end;
						CEPGP_Info.QueuedAnnouncement = callback;
						CEPGP_print(L["This item will be announced in a moment. Please wait and keep the loot window open"]);
					else
						CEPGP_announce(link, x, slot, quantity);
						CEPGP_distribute:SetID(_G[CEPGP_mode..'announce'..i]:GetID());
					end
				end);
				subframe.announce:SetID(slot);
	
				subframe.icon = CreateFrame('Button', CEPGP_mode..'icon'..i, subframe);
				subframe.icon:SetHeight(20);
				subframe.icon:SetWidth(20);
				subframe.icon:SetScript('OnEnter', function() GameTooltip:SetOwner(_G[CEPGP_mode..'icon'..i], "ANCHOR_BOTTOMLEFT") GameTooltip:SetHyperlink(link) GameTooltip:Show() end);
				subframe.icon:SetScript('OnLeave', function() GameTooltip:Hide() end);
				
				local tex = subframe.icon:CreateTexture(CEPGP_mode..'texture'..i, "BACKGROUND");
				tex:SetAllPoints();
				tex:SetTexture(texture);
				
				subframe.itemName = CreateFrame('Button', CEPGP_mode..'item'..i, subframe);
				subframe.itemName:SetHeight(20);
				
				subframe.itemGP = CreateFrame('EditBox', CEPGP_mode..'itemGP'..i, subframe, 'InputBoxTemplate');
				subframe.itemGP:SetHeight(20);
				subframe.itemGP:SetWidth(35);
				
				if i == 1 then
					subframe.announce:SetPoint('CENTER', _G['CEPGP_'..CEPGP_mode..'_announce'], 'BOTTOM', 0, -20);
					subframe.icon:SetPoint('LEFT', _G[CEPGP_mode..'announce'..i], 'RIGHT', 30, 0);
					tex:SetPoint('LEFT', _G[CEPGP_mode..'announce'..i], 'RIGHT', 30, 0);
					subframe.itemName:SetPoint('LEFT', _G[CEPGP_mode..'icon'..i], 'RIGHT', 10, 0);
					subframe.itemGP:SetPoint('CENTER', _G['CEPGP_'..CEPGP_mode..'_GP'], 'BOTTOM', 10, -20);
				else
					subframe.announce:SetPoint('CENTER', _G[CEPGP_mode..'announce'..(i-1)], 'BOTTOM', 0, -20);
					subframe.icon:SetPoint('LEFT', _G[CEPGP_mode..'announce'..i], 'RIGHT', 30, 0);
					tex:SetPoint('LEFT', _G[CEPGP_mode..'announce'..i], 'RIGHT', 30, 0);
					subframe.itemName:SetPoint('LEFT', _G[CEPGP_mode..'icon'..i], 'RIGHT', 10, 0);
					subframe.itemGP:SetPoint('CENTER', _G[CEPGP_mode..'itemGP'..(i-1)], 'BOTTOM', 0, -20);
				end
				
				subframe.icon:SetScript('OnClick', function() SetItemRef(link, iString) end);
				
				subframe.itemName.text = subframe.itemName:CreateFontString(CEPGP_mode..'EPGP_i'..name..'text', 'OVERLAY', 'GameFontNormal');
				subframe.itemName.text:SetPoint('CENTER', _G[CEPGP_mode..'item'..i]);
				subframe.itemName.text:SetText(link);
				subframe.itemName.text:SetTextColor(colour.r, colour.g, colour.b);
				subframe.itemName:SetWidth(subframe.itemName.text:GetStringWidth());
				subframe.itemName:SetScript('OnClick', function() SetItemRef(link, iString) end);
				
				subframe.itemGP:SetText(gp);
				subframe.itemGP:SetTextColor(colour.r, colour.g, colour.b);
				subframe.itemGP:SetWidth(35);
				subframe.itemGP:SetScript('OnEnterPressed', function() _G[CEPGP_mode..'itemGP'..i]:ClearFocus() end);
				subframe.itemGP:SetAutoFocus(false);
				subframe.itemGP:Show();
			end
		end
		texture, name, colour, link, iString, slot, quantity, gp, tempItems = nil;
	end
end

function CEPGP_print(str, err)
	if not str then return; end;
	if err == nil then
		DEFAULT_CHAT_FRAME:AddMessage("|c006969FFCEPGP: " .. tostring(str) .. "|r");
	else
		DEFAULT_CHAT_FRAME:AddMessage("|c006969FFCEPGP:|r " .. "|c00FF0000Error|r|c006969FF - " .. tostring(str) .. "|r");
	end
end

function CEPGP_cleanTable()
	local i = 1;
	while _G[CEPGP_mode..'member_name'..i] ~= nil do
		_G[CEPGP_mode..'member_group'..i].text:SetText("");
		_G[CEPGP_mode..'member_name'..i].text:SetText("");
		_G[CEPGP_mode..'member_rank'..i].text:SetText("");
		_G[CEPGP_mode..'member_EP'..i].text:SetText("");
		_G[CEPGP_mode..'member_GP'..i].text:SetText("");
		_G[CEPGP_mode..'member_PR'..i].text:SetText("");
		i = i + 1;
	end
	
	
	i = 1;
	while _G[CEPGP_mode..'item'..i] ~= nil do
		_G[CEPGP_mode..'announce'..i]:Hide();
		_G[CEPGP_mode..'icon'..i]:Hide();
		_G[CEPGP_mode..'texture'..i]:Hide();
		_G[CEPGP_mode..'item'..i].text:SetText("");
		_G[CEPGP_mode..'itemGP'..i]:Hide();
		i = i + 1;
	end
end

function CEPGP_toggleFrame(frame)
	for i = 1, table.getn(CEPGP_frames) do
		if CEPGP_frames[i]:GetName() == frame then
			CEPGP_frames[i]:Show();
		else
			CEPGP_frames[i]:Hide();
		end
	end
end

function CEPGP_rosterUpdate(event)
	if CEPGP_Info.IgnoreUpdates then return; end
	if event == "GUILD_ROSTER_UPDATE" then
		if CEPGP_Info.Polling then
			CEPGP_Info.Rescan = true;
			return;
		end
		--CEPGP_Info.LastUpdate = GetTime()+(CEPGP.PollRate*GetNumGuildMembers());
		CEPGP_Info.Polling = true;
		local pRate = CEPGP.PollRate;
		local quit = false;
		--local timer = CEPGP_Info.LastUpdate;
		--local numGuild = GetNumGuildMembers();
		
		if CanEditOfficerNote() then
			CEPGP_guild_add_EP:Show();
			CEPGP_guild_decay:Show();
			CEPGP_guild_reset:Show();
			CEPGP_raid_add_EP:Show();
			CEPGP_button_guild_restore:Show();
			CEPGP_button_guild_import:Show();
		else --[[ Hides context sensitive options if player cannot edit officer notes ]]--
			CEPGP_guild_add_EP:Hide();
			CEPGP_guild_decay:Hide();
			CEPGP_guild_reset:Hide();
			CEPGP_raid_add_EP:Hide();
			CEPGP_button_guild_restore:Hide();
			CEPGP_button_guild_import:Hide();
		end
		
		CEPGP_updateGuild();
		
		local tempRoster = {};
		for k, _ in pairs(CEPGP_roster) do
			tempRoster[k] = "";
		end
		
		local function update()
			--	Purges players that have been removed from the guild from CEPGP_roster
			for k, _ in pairs(tempRoster) do
				CEPGP_roster[k] = nil;
			end
			
			CEPGP_groupVersion = CEPGP_tSort(CEPGP_groupVersion, 1);
			if _G["CEPGP_guild"]:IsVisible() and IsInGuild() then
				CEPGP_UpdateGuildScrollBar();
			elseif _G["CEPGP_raid"]:IsVisible() then
				CEPGP_UpdateRaidScrollBar();
			end
			if GetNumGuildMembers() > 0 then
				CEPGP_UpdateStandbyScrollBar();
			end
			
			if CEPGP_Info.QueuedAnnouncement then
				CEPGP_Info.QueuedAnnouncement();
				CEPGP_Info.QueuedAnnouncement = nil;
			end
			
			for _, func in pairs(CEPGP_Info.RosterStack) do
				func();
			end
			CEPGP_Info.RosterStack = {};
			CEPGP_Info.Polling = false;
			if CEPGP_Info.Rescan then
				CEPGP_Info.Rescan = false;
				CEPGP_rosterUpdate("GUILD_ROSTER_UPDATE");
			end
		end
		
		
		local i = 0;
		local limit = GetNumGuildMembers();
		C_Timer.NewTicker(CEPGP.PollRate, function()
			--if timer ~= CEPGP_Info.LastUpdate then return; end
			
			if quit then return; end
			if pRate ~= CEPGP.PollRate then 
				quit = true;
				return;
			end
			if limit ~= GetNumGuildMembers() then
				quit = true;
				CEPGP_Info.Polling = false;
				CEPGP_rosterUpdate("GUILD_ROSTER_UPDATE");
				return;
			end
			i = i + 1;
			local name, rank, rankIndex, _, class, _, _, _, online, _, classFileName = GetGuildRosterInfo(i);
			if name then
				if not CEPGP.Exclusions[rankIndex+1] then
					name = Ambiguate(name, "all");
					tempRoster[name] = nil;
					local EP, GP = CEPGP_getEPGP(name, i);
					local PR = math.floor((EP/GP)*100)/100;
					CEPGP_roster[name] = {
						[1] = i,
						[2] = class,
						[3] = rank,
						[4] = rankIndex,
						[5] = officerNote,
						[6] = PR,
						[7] = classFileName,
						[8] = online
					};
				end
				if online and CEPGP_vSearch == "GUILD" then
					CEPGP_groupVersion[i] = {
						[1] = name,
						[2] = "Addon not enabled",
						[3] = class,
						[4] = classFileName
					};
				elseif CEPGP_vSearch == "GUILD" then
					CEPGP_groupVersion[i] = {
						[1] = name,
						[2] = "Offline",
						[3] = class,
						[4] = classFileName
					};
				end
			end

			if i >= limit then	--	Although i should never exceed the number of guild members normally, on login, the number of guild members returns 0 and when running this loop, i becomes 1
				update();
			end
		end, limit);
		
	elseif event == "GROUP_ROSTER_UPDATE" then
		if IsInRaid("player") then
			_G["CEPGP_button_raid"]:Show();
		else
			_G["CEPGP_button_raid"]:Hide();
			_G["CEPGP_raid"]:Hide();
			CEPGP_raidRoster = {};
		end
		--CEPGP_raidRoster = {};
		
		local tempRoster = {};
		for _, player in pairs(CEPGP_raidRoster) do
			if player[1] then
				tempRoster[player[1]] = "";
			end
		end
		
		local function update()
			for index, player in ipairs(CEPGP_raidRoster) do
				if tempRoster[player[1]] then
					table.remove(CEPGP_raidRoster, index);
				end
			end
		
			if UnitInRaid("player") then
				ShowUIPanel(CEPGP_button_raid);
			else --[[ Hides the raid and loot distribution buttons if the player is not in a raid group ]]--
				CEPGP_mode = "guild";
				CEPGP_toggleFrame("CEPGP_guild");
				
			end
			if _G["CEPGP_guild"]:IsVisible() then
				CEPGP_UpdateRaidScrollBar();
			end
		end
		
		local i = 0;
		--for i = 1, GetNumGroupMembers() do
		local limit = GetNumGroupMembers();
		C_Timer.NewTicker(CEPGP.PollRate, function()
			i = i + 1;
			local name = GetRaidRosterInfo(i);
			if name then
				tempRoster[name] = nil;
			end
			if not UnitInRaid("player") then
				CEPGP_standbyRoster = {};
				CEPGP_UpdateStandbyScrollBar();
			else
				for k, v in ipairs(CEPGP_standbyRoster) do
					if v[1] == name then
						table.remove(CEPGP_standbyRoster, k); --Removes player from standby list if they have joined the raid
						if CEPGP_isML() == 0 then
							CEPGP_SendAddonMsg("StandbyRemoved;" .. name .. ";You have been removed from the standby list because you have joined the raid.", "RAID");
						end
						CEPGP_UpdateStandbyScrollBar();
					end
				end
			end
			
			local _, _, _, _, class, classFileName = GetRaidRosterInfo(i);
			local index = CEPGP_getIndex(name);
			local rank;
			
			if index then
				
				rank = select(2, GetGuildRosterInfo(index));
				local rankIndex = select(3, GetGuildRosterInfo(index));
				
				EP, GP = CEPGP_getEPGP(name, index);
				local PR = math.floor((EP/GP)*100)/100;
				
				CEPGP_raidRoster[i] = {
					[1] = name,
					[2] = class,
					[3] = rank,
					[4] = rankIndex,
					[5] = EP,
					[6] = GP,
					[7] = PR,
					[8] = classFileName
				};
			else
				rank = "Not in Guild";
				CEPGP_raidRoster[i] = {
					[1] = name,
					[2] = class,
					[3] = rank,
					[4] = 11,
					[5] = 0,
					[6] = BASEGP,
					[7] = 0,
					[8] = classFileName
				};
			end
			if i == limit then
				update();
			end
		end, limit);
	end
end

function CEPGP_getUnit(name)
	if name == UnitName("player") then return "player"; end
	for i = 1, GetNumGroupMembers() do
		local raidn = GetRaidRosterInfo(i);
		if name == raidn then
			if i < 5 then
				return "party" .. i-1;
			else
				return "raid" .. i;
			end
		end
	end
end

function CEPGP_addToStandby(player)
	if not player then return; end
	
	if CEPGP_ntgetn(CEPGP_roster) < (GetNumGuildMembers() - CEPGP_Info.NumExcluded) and CEPGP_Info.Polling then
		CEPGP_print("Scanning guild roster, will attempt to add player to standby soon");
		local callback = function() CEPGP_addToStandby(player); end
		table.insert(CEPGP_Info.RosterStack, callback);
		return;
	end
	
	if not UnitInRaid("player") then
		CEPGP_print("You cannot add players to the standby list while not in a raid group.", true);
		return;
	end
	if player == UnitName("player") then
		CEPGP_print("You cannot add yourself to the standby list.", true);
		return;
	end
	if not CEPGP_roster[player] then
		for i = 1, GetNumGuildMembers() do
			local name = Ambiguate(GetGuildRosterInfo(i), "all");
			if string.lower(player) == string.lower(name) then
				player = name;
				break;
			end
		end
		if not CEPGP_roster[player] then
			CEPGP_print(player .. " is not a guild member", true);
			return;
		end
	end
	for _, v in pairs(CEPGP_standbyRoster) do
		if string.lower(v[1]) == string.lower(player) then
			CEPGP_print(player .. " is already in the standby roster", true);
			return;
		end
	end
	for _, v in ipairs(CEPGP_raidRoster) do
		if string.lower(player) == string.lower(v[1]) then
			CEPGP_print(player .. " is part of the raid", true);
			return;
		end
	end	
	local _, class, rank, rankIndex, _, _, classFile = CEPGP_getGuildInfo(player);
	local index = CEPGP_getIndex(CEPGP_roster[player][1]);
	local EP,GP = CEPGP_getEPGP(player, index);
	CEPGP_standbyRoster[#CEPGP_standbyRoster+1] = {
		[1] = player,
		[2] = class,
		[3] = rank,
		[4] = rankIndex,
		[5] = EP,
		[6] = GP,
		[7] = math.floor((tonumber(EP)*100/tonumber(GP)))/100,
		[8] = classFile
	};
	CEPGP_standbyRoster = CEPGP_tSort(CEPGP_standbyRoster, 1);
	if CEPGP_standby_share then CEPGP_SendAddonMsg("StandbyListAdd;"..player..";"..class..";"..rank..";"..rankIndex..";"..EP..";"..GP..";"..classFile, "RAID"); end
	CEPGP_SendAddonMsg("StandbyAdded;" .. player .. ";You have been added to the standby list.", "GUILD");
	if CEPGP_standby_options:IsVisible() then
		CEPGP_UpdateStandbyScrollBar();
	end
end

function CEPGP_standardiseString(str)
	--Returns the string with proper nouns capitalised
	if not str then return; end
	local words = {};
	
	local count = 0;
	for i in (str .. " "):gmatch("([^ ]*) ") do
		if count == 0 then
			if string.lower(i) == "the" then
				count = count + 1;
				words[count] = "The";
			else
				count = count + 1;
				words[count] = string.upper(string.sub(i, 1, 1)) .. string.lower(string.sub(i, 2, string.len(i)));
			end
		else
			if string.lower(i) == "the" or string.lower(i) == "of" then
				count = count + 1;
				words[count] = string.lower(i);
			else
				count = count + 1;
				words[count] = string.upper(string.sub(i, 1, 1)) .. string.lower(string.sub(i, 2, string.len(i)));
			end
		end
	end
	local result = "";
	for i = 1, count do
		if i == 1 then
			result = words[i];
		elseif i <= count then
			result = result .. " " .. words[i];
		end
	end
	
	return result;
end

function CEPGP_toggleStandbyRanks(show)
	if show and CEPGP_ntgetn(STANDBYRANKS) > 0 then
		for i = 1, 10 do
			STANDBYRANKS[i][1] = GuildControlGetRankName(i);
		end
		for i = 1, 10 do
			if STANDBYRANKS[i][1] then
				_G["CEPGP_options_standby_ep_rank_"..i]:Show();
				_G["CEPGP_options_standby_ep_rank_"..i]:SetText(tostring(STANDBYRANKS[i][1]));
				_G["CEPGP_options_standby_ep_check_rank_"..i]:Show();
				if STANDBYRANKS[i][2] == true then
					_G["CEPGP_options_standby_ep_check_rank_"..i]:SetChecked(true);
				else
					_G["CEPGP_options_standby_ep_check_rank_"..i]:SetChecked(false);
				end
			else
				_G["CEPGP_options_standby_ep_rank_"..i]:Hide();
				_G["CEPGP_options_standby_ep_check_rank_"..i]:Hide();
			end
			if GuildControlGetRankName(i) == "" then
				_G["CEPGP_options_standby_ep_rank_"..i]:Hide();
				_G["CEPGP_options_standby_ep_check_rank_"..i]:Hide();
				_G["CEPGP_options_standby_ep_check_rank_"..i]:SetChecked(false);
			end
		end
		CEPGP_options_standby_ep_accept_whispers_check:Hide();
		CEPGP_options_standby_ep_accept_whispers:Hide();
		CEPGP_options_standby_ep_message_val:Hide();
		CEPGP_options_standby_ep_whisper_message:Hide();
		CEPGP_standby_ep_list_add:Hide();
		CEPGP_standby_ep_list_addbyrank:Hide();
		CEPGP_standby_ep_list_purge:Hide();
		CEPGP_options_standby_ep_byrank_check:SetChecked(true);
		CEPGP_options_standby_ep_manual_check:SetChecked(false);
		CEPGP_standby_options_list_container:Hide();
	else
		for i = 1, 10 do
			_G["CEPGP_options_standby_ep_rank_"..i]:Hide();
			_G["CEPGP_options_standby_ep_check_rank_"..i]:Hide();
		end
		CEPGP_options_standby_ep_accept_whispers_check:Show();
		CEPGP_options_standby_ep_accept_whispers:Show();
		CEPGP_options_standby_ep_message_val:Show();
		CEPGP_options_standby_ep_whisper_message:Show();
		CEPGP_standby_ep_list_add:Show();
		CEPGP_standby_ep_list_addbyrank:Show();
		CEPGP_standby_ep_list_purge:Show();
		CEPGP_options_standby_ep_byrank_check:SetChecked(false);
		CEPGP_options_standby_ep_manual_check:SetChecked(true);
		CEPGP_standby_options_list_container:Show();
	end
end

function CEPGP_getGuildInfo(name)
	if CEPGP_roster[name] then
		local index = CEPGP_getIndex(name);
		local _, _, _, _, _, _, _, oNote = GetGuildRosterInfo(index);
		return index, CEPGP_roster[name][2], CEPGP_roster[name][3], CEPGP_roster[name][4], oNote, CEPGP_roster[name][6], CEPGP_roster[name][7];  -- index, class, Rank, RankIndex, OfficerNote, PR, className in English
	else
		return nil;
	end
end

function CEPGP_getVal(str)
	local val = nil;
	val = strsub(str, strfind(str, " ")+1, string.len(str));
	return val;
end

function CEPGP_getIndex(name)
	if not IsInGuild() then return nil; end
	if not name then return; end
	local index;
	
	if CEPGP_roster[name] and CEPGP_roster[name][1] <= GetNumGuildMembers() then
		index = CEPGP_roster[name][1];
	end
	
	if index then
		local temp = Ambiguate(GetGuildRosterInfo(index), "all");
		if string.lower(temp) == string.lower(name) then
			return index;
		else
			for i = 1, GetNumGuildMembers() do
				local temp = Ambiguate(GetGuildRosterInfo(i), "all");
				if string.lower(temp) == string.lower(name) then
					return i;
				end
			end
		end
	else	-- no index is supplied
		for i = 1, GetNumGuildMembers() do
			local temp = Ambiguate(GetGuildRosterInfo(i), "all");
			if string.lower(temp) == string.lower(name) then
				return i;
			end
		end
	end
end

function CEPGP_indexToName(index)
	for name,value in pairs(CEPGP_roster) do
		if value[1] == index then
			return name;
		end
	end
end

function CEPGP_getEPGP(name, index)
	if not index and not name then return; end
	local offNote;
	
	index = CEPGP_getIndex(name);
	if not index then return 0, CEPGP.GP.Min; end
	_, _, _, _, _, _, _, offNote = GetGuildRosterInfo(index);
	
	local EP, GP = nil;
	
	if not CEPGP_checkEPGP(offNote) then
		return 0, CEPGP.GP.Min;
	else
		EP = tonumber(strsub(offNote, 1, strfind(offNote, ",")-1));
		GP = tonumber(strsub(offNote, strfind(offNote, ",")+1, string.len(offNote)));
		GP = math.max(math.floor(GP), CEPGP.GP.Min);
		return EP, GP;
	end
end

function CEPGP_checkEPGP(note)
	if not note then return false; end
	
	if string.find(note, '[^0-9,-]') or #note == 0 then
		return false;
	end
	if string.find(note, '^[0-9]+,[0-9]+$') then --EPGP is positive
		return true;
	elseif string.find(note, '^%-[0-9]+,[0-9]+$') then --EP is negative
		return true;
	elseif string.find(note, '^[0-9]+,%-[0-9]+$') then --GP is negative
		return true;
	elseif string.find(note, '^%-[0-9]+,%-[0-9]+$') then --EPGP is negative
		return true;
	else
		return false;
	end
end

function CEPGP_getItemString(link)
	if not link then
		return nil;
	end
	local itemString = string.find(link, "item[%-?%d:]+");
	if not itemString then return nil; end
	itemString = strsub(link, itemString, string.len(link)-(string.len(link)-2)-6);
	return itemString;
end

function CEPGP_getItemID(iString)
	if not iString or not string.find(iString, "item:") then
		return nil;
	end
	local itemString = string.sub(iString, 6, string.len(iString)-1)--"^[%-?%d:]+");
	return string.sub(itemString, 1, string.find(itemString, ":")-1);
end

function CEPGP_getItemLink(id)
	local name, _, rarity = GetItemInfo(id);
	if not name then
		local item = Item:CreateFromItemID(tonumber(id));
		item:ContinueOnItemLoad(function()
			name, _, rarity = GetItemInfo(id);
			if rarity == 0 then -- Poor
				return "\124cff9d9d9d\124Hitem:" .. id .. ":::::::::::::\124h[" .. name .. "]\124h\124r";
			elseif rarity == 1 then -- Common
				return "\124cffffffff\124Hitem:" .. id .. ":::::::::::::\124h[" .. name .. "]\124h\124r";
			elseif rarity == 2 then -- Uncommon
				return "\124cff1eff00\124Hitem:" .. id .. ":::::::::::::\124h[" .. name .. "]\124h\124r";
			elseif rarity == 3 then -- Rare
				return "\124cff0070dd\124Hitem:" .. id .. ":::::::::::::\124h[" .. name .. "]\124h\124r";
			elseif rarity == 4 then -- Epic
				return "\124cffa335ee\124Hitem:" .. id .. ":::::::::::::\124h[" .. name .. "]\124h\124r";
			elseif rarity == 5 then -- Legendary
				return "\124cffff8000\124Hitem:" .. id .. ":::::::::::::\124h[" .. name .. "]\124h\124r";
			end
		end);
	else
		if rarity == 0 then -- Poor
			return "\124cff9d9d9d\124Hitem:" .. id .. ":::::::::::::\124h[" .. name .. "]\124h\124r";
		elseif rarity == 1 then -- Common
			return "\124cffffffff\124Hitem:" .. id .. ":::::::::::::\124h[" .. name .. "]\124h\124r";
		elseif rarity == 2 then -- Uncommon
			return "\124cff1eff00\124Hitem:" .. id .. ":::::::::::::\124h[" .. name .. "]\124h\124r";
		elseif rarity == 3 then -- Rare
			return "\124cff0070dd\124Hitem:" .. id .. ":::::::::::::\124h[" .. name .. "]\124h\124r";
		elseif rarity == 4 then -- Epic
			return "\124cffa335ee\124Hitem:" .. id .. ":::::::::::::\124h[" .. name .. "]\124h\124r";
		elseif rarity == 5 then -- Legendary
			return "\124cffff8000\124Hitem:" .. id .. ":::::::::::::\124h[" .. name .. "]\124h\124r";
		end
	end
end

function CEPGP_SlotNameToID(name)
	if name == nil then
		return nil
	end
	if name == "HEAD" then
		return 1;
	elseif name == "NECK" then
		return 2;
	elseif name == "SHOULDER" then
		return 3;
	elseif name == "CHEST" or name == "ROBE" then
		return 5;
	elseif name == "WAIST" then
		return 6;
	elseif name == "LEGS" then
		return 7;
	elseif name == "FEET" then
		return 8;
	elseif name == "WRIST" then
		return 9;
	elseif name == "HAND" then
		return 10;
	elseif name == "FINGER" then
		return 11, 12;
	elseif name == "TRINKET" then
		return 13, 14;
	elseif name == "CLOAK" then
		return 15;
	elseif name == "2HWEAPON" or name == "WEAPON" or name == "WEAPONMAINHAND" or name == "WEAPONOFFHAND" or name == "SHIELD" or name == "HOLDABLE" then
		return 16, 17;
	elseif name == "RANGED" or name == "RANGEDRIGHT" or name == "RELIC" then
		return 18;
	end
end

function CEPGP_inOverride(link)
	local id;
	id = CEPGP_getItemID(CEPGP_getItemString(link));
	if id then
		for item, _ in pairs(OVERRIDE_INDEX) do
			local temp = CEPGP_getItemID(CEPGP_getItemString(item));
			if id == temp then
				return true;
			end
		end
	else
		if OVERRIDE_INDEX[link] then
			return true;
		end
	end
	return false;
end

function CEPGP_updateOverride(id)
	if not id then return; end
	id = tonumber(id);
	local link = CEPGP_getItemLink(id);
	local name = GetItemInfo(id);
	for item, v in pairs(OVERRIDE_INDEX) do
		if string.lower(name) == string.lower(item) then
			OVERRIDE_INDEX[link] = v;
			OVERRIDE_INDEX[item] = nil;
			return;
		end
	end
end

function CEPGP_tContains(t, val, isKey)
	if not t then return; end
	
	if isKey then
		for index,_ in pairs(t) do 
			if index == val then
				return true;
			end
		end
	else
		for _,value in pairs(t) do
			if type(value) == "table" then	--	If the first tier of the table is a nested table
				for k, v in pairs(value) do
					if val == k then	--	The key can't be nil so no need to check
						return true;
					end
					if v then	--	Need to make sure the nested value isn't nil
						if val == v then
							return true;
						end
					end
				end
			else
				if value == val then	--	The first tier isn't nested, it's just a simple k, v pair
					return true;
				end
			end
		end
	end
	
	return false;
end

function CEPGP_isNumber(num)
	return not (string.find(tostring(num), '[^-0-9.]+') or string.find(tostring(num), '[^-0-9.]+$'));
end

function CEPGP_isML()
	local _, isML = GetLootMethod();
	return isML;
end

function CEPGP_updateGuild()
	if not IsInGuild() then
		HideUIPanel(CEPGP_button_guild);
		HideUIPanel(CEPGP_guild);
		return;
	else
		ShowUIPanel(CEPGP_button_guild);
		if CEPGP_ntgetn(STANDBYRANKS) > 0 then
			for i = 1, 10 do
				STANDBYRANKS[i][1] = GuildControlGetRankName(i);
			end
		end
	end
	GuildRoster();
end

function CEPGP_tSort(t, index, inverse)
	if not t then return; end
	if #t == 1 then return t; end
		
	for x = 1, #t do
		for z = x+1, #t do
			if inverse then
				if t[x][index] < t[z][index] then
					local v = t[x];
					t[x] = t[z];
					t[z] = v;
				end
			else
				if t[x][index] > t[z][index] then
					local v = t[x];
					t[x] = t[z];
					t[z] = v;
				end
			end
		end
	end
	
	return t;
end

function CEPGP_sortDistList(list)
	local temp = {
		[1] = {},
		[2] = {},
		[3] = {},
		[4] = {},
		[5] = {},
		[6] = {}
	};
	for i = 1, #list do
		local index = tonumber(list[i][11]);
		if not index then index = 5; end
		--if not temp[index] then temp[index] = {}; end
		temp[index][#temp[index]+1] = {	-- Response Index
			[1] = list[i][1],
			[2] = list[i][2],
			[3] = list[i][3],
			[4] = list[i][4],
			[5] = list[i][5],
			[6] = list[i][6],
			[7] = list[i][7],
			[8] = list[i][8],
			[9] = list[i][9],
			[10] = list[i][10],
			[12] = list[i][12]
		}
	end
	for i = 1, 6 do
		for x = 1, #temp[i] do
			for z = x+1, #temp[i] do
				if temp[i][x][7] < temp[i][z][7] then
					local v = temp[i][x];
					temp[i][x] = temp[i][z];
					temp[i][z] = v;
				end
			end
		end
	end
	local result = {};
	for i = 1, 6 do
		for x = 1, #temp[i]	do
			result[#result+1] = {
				[1] = temp[i][x][1],
				[2] = temp[i][x][2],
				[3] = temp[i][x][3],
				[4] = temp[i][x][4],
				[5] = temp[i][x][5],
				[6] = temp[i][x][6],
				[7] = temp[i][x][7],
				[8] = temp[i][x][8],
				[9] = temp[i][x][9],
				[10] = temp[i][x][10],
				[11] = i,
				[12] = temp[i][x][12]
			};
		end
	end
	return result;
end

function CEPGP_ntgetn(tbl)
	if tbl == nil then
		return 0;
	end
	local n = 0;
	for _,_ in pairs(tbl) do
		n = n + 1;
	end
	return n;
end

function CEPGP_setCriteria(sortIndex, method)
	if not method then return; end
	
	if method == "Raid" then
		if CEPGP_Info.Sorting.Raid[1] == sortIndex then
			CEPGP_Info.Sorting.Raid[2] = not CEPGP_Info.Sorting.Raid[2];
		else
			CEPGP_Info.Sorting.Raid[1] = sortIndex;
		end
		CEPGP_UpdateRaidScrollBar();
	elseif method == "Guild" then
		if CEPGP_Info.Sorting.Guild[1] == sortIndex then
			CEPGP_Info.Sorting.Guild[2] = not CEPGP_Info.Sorting.Guild[2];
		else
			CEPGP_Info.Sorting.Guild[1] = sortIndex;
		end
		CEPGP_UpdateGuildScrollBar();
	elseif method == "Loot" then
		if CEPGP_Info.Sorting.Loot[1] == sortIndex then
			CEPGP_Info.Sorting.Loot[2] = not CEPGP_Info.Sorting.Loot[2];
		else
			CEPGP_Info.Sorting.Loot[1] = sortIndex;
		end
		CEPGP_UpdateLootScrollBar(nil, true);
	elseif method == "Standby" then
		if CEPGP_Info.Sorting.Standby[1] == sortIndex then
			CEPGP_Info.Sorting.Standby[2] = not CEPGP_Info.Sorting.Standby[2];
		else
			CEPGP_Info.Sorting.Standby[1] = sortIndex;
		end
		CEPGP_UpdateStandbyScrollBar();
	elseif method == "Attendance" then
		if CEPGP_Info.Sorting.Attendance[1] == sortIndex then
			CEPGP_Info.Sorting.Attendance[2] = not CEPGP_Info.Sorting.Attendance[2];
		else
			CEPGP_Info.Sorting.Attendance[1] = sortIndex;
		end
		CEPGP_UpdateAttendanceScrollBar();
	elseif method == "Version" then
		if CEPGP_Info.Sorting.Version[1] == sortIndex then
			CEPGP_Info.Sorting.Version[2] = not CEPGP_Info.Sorting.Version[2];
		else
			CEPGP_Info.Sorting.Version[1] = sortIndex;
		end
		CEPGP_UpdateVersionScrollBar();
	end
end

function CEPGP_toggleBossConfigFrame(fName)
	for _, frame in pairs(CEPGP_boss_config_frames) do
		if frame:GetName() ~= fName then
			HideUIPanel(frame);
		else
			frame:Show();
		end;
	end
end

function CEPGP_getDebugInfo()
	local info = "<details><summary>Debug Info</summary><br />\n";
	info = info .. "Version: " .. CEPGP_Info.Version .. " " .. CEPGP_Info.Build .. "<br />\n";
	info = info .. "Locale: " .. GetLocale() .. "<br />\n";
	info = info .. "Poll Rate: " .. CEPGP.PollRate .. "<br />\n";
	info = info .. "GP Formula: (" .. COEF .. "x(" .. MOD_COEF .. "^<sup>((ilvl/26)+(rarity-4))</sup>)xSlot Modifier)x" .. MOD .. "<br />\n";
	info = info .. "Base GP: " .. BASEGP .. "<br />\n";
	info = info .. "Traffic Entries: " .. #TRAFFIC .. "<br />\n";
	if CEPGP_minGPDecayFactor then
		info = info .. "Base GP Decay Factor: true<br />\n";
	else
		info = info .. "Base GP Decay Factor: false<br />\n";
	end
	if STANDBYEP then
		info = info .. "Standby EP: True<br />\n";
	else
		info = info .. "Standby EP: False<br />\n";
	end
	if STANDBYOFFLINE then
		info = info .. "Standby Offline: True<br />\n";
	else
		info = info .. "Standby Offline: False<br />\n";
	end
	info = info .. "Standby Percent: " .. STANDBYPERCENT .. "<br />\n";
		if CEPGP_standby_accept_whispers then
		info = info .. "Standby Accept Whispers: True<br />\n";
	else
		info = info .. "Standby Accept Whispers: False<br />\n";
	end
	if CEPGP_standby_byrank then
		info = info .. "Standby EP by Rank: True<br />\n";
	else
		info = info .. "Standby EP by Rank: False<br />\n";
	end
	if CEPGP_standby_manual then
		info = info .. "Standby EP Manual Delegation: True<br />\n";
	else
		info = info .. "Standby EP Manual Delegation: False<br />\n";
	end
	info = info .. "Standby EP Whisper Keyphrase: " .. CEPGP_standby_whisper_msg .. "<br />\n";
	if CEPGP_auto_pass then
		info = info .. "Auto Pass on Ineligible Items: true<br />\n";
	else
		info = info .. "Auto Pass on Ineligible Items: false<br />\n";
	end
	if CEPGP_raid_wide_dist then
		info = info .. "Full Raid Loot Visibility: true<br />\n";
	else
		info = info .. "Full Raid Loot Visibility: false<br />\n";
	end
	if CEPGP_gp_tooltips then
		info = info .. "GP on Tooltips: true<br />\n";
	else
		info = info .. "GP on Tooltips: false<br />\n";
	end
	if CEPGP_suppress_announcements then
		info = info .. "Suppress Loot Announcements: true<br />\n";
	else
		info = info .. "Suppress Loot Announcements: false<br />\n";
	end
	if CEPGP.Loot.PassRolls then
		info = info .. "Roll for Passes: true<br />\n";
	else
		info = info .. "Roll for Passes: false<br />\n";
	end
	if CEPGP.Loot.RollAnnounce then
		info = info .. "Announce Rolls: true<br />\n";
	else
		info = info .. "Announce Rolls: true<br />\n";
	end
	if CEPGP.Loot.ResolveRolls then
		info = info .. "Resolve Duplicate Rolls: true<br />\n";
	else
		info = info .. "Resolve Duplicate Rolls: true<br />\n";
	end
	if CEPGP_minEP[1] then
		info = info .. "Minimum EP: true, " .. CEPGP_minEP[2] .. "<br />\n";
	else
		info = info .. "Minimum EP: false, " .. CEPGP_minEP[2] .. "<br />\n";
	end
	info = info .. "Reporting Channel: " .. CHANNEL .. "<br />\n";
	info = info .. "Loot Response Channel: " .. CEPGP_lootChannel .. "<br />\n";
	info = info .. "Minimum Threshold for Loot: " .. CEPGP_min_threshold .. "<br />\n";
	if ALLOW_FORCED_SYNC then
		info = info .. "Allow Force Sync: true, " .. GuildControlGetRankName(CEPGP_force_sync_rank) .. "<br />\n";
	else
		info = info .. "Allow Force Sync: false, " .. GuildControlGetRankName(CEPGP_force_sync_rank) .. "<br />\n";
	end
	if CEPGP.Loot.HideKeyphrases then
		info = info .. "Hide Keyphrase Alternatives: True<br />";
	else
		info = info .. "Hide Keyphrase Alternatives: False<br />";
	end
	info = info .. "<br /><details><summary>Auto EP</summary>\n";
	for k, v in pairs(AUTOEP) do
		if v then
			info = info .. k .. ": True<br />\n";
		else
			info = info .. k .. ": False<br />\n";
		end
	end
	info = info .. "</details>\n";
	info = info .. "<details><summary>EP Values</summary>\n";
	for k, v in pairs(EPVALS) do
		info = info .. k .. ": " .. v .. "<br />\n";
	end
	info = info .. "</details>\n";
	info = info .. "<details><summary>Loot Button Configuration</summary>\n";
	for i = 1, 4 do
		info = info .. "Loot Button " .. i .. "<br />";
		if CEPGP_response_buttons[i][1] then
			info = info .. "State: Enabled<br />";
		else
			info = info .. "State: Disabled<br />";
		end
		info = info .. "Button Text: " .. CEPGP_response_buttons[i][2] .. "<br />";
		info = info .. "Discount: " .. CEPGP_response_buttons[i][3] .. "%<br />";
		info = info .. "Keyphrase Alternative: " .. CEPGP_response_buttons[i][4] .. "<br />";
		info = info .. "<br />";
	end
	info = info .. "</details>";
	info = info .. "<details><summary>Standby Guild Ranks</summary>\n";
	for k, v in pairs(STANDBYRANKS) do
		if v[1] ~= "" and v[1] ~= nil then
			if v[2] then
				info = info .. v[1] .. ": True<br />\n";
			else
				info = info .. v[1] .. ": False<br />\n";
			end
		end
	end
	info = info .. "</details>\n";
	info = info .. "<details><summary>Slot Weights</summary>\n";
	for k, _ in pairs(SLOTWEIGHTS) do
		info = info .. k .. ": " .. SLOTWEIGHTS[k] .. "<br />\n";
	end
	info = info .. "</details>\n";
	info = info .. "<details><summary>Override List</summary>\n";
	for k, v in pairs(OVERRIDE_INDEX) do
		info = info .. k .. ": " .. v .. "<br />\n";
	end
	info = info .. "</details>\n";
	info = info .. "<details><summary>Addons List</summary>\n";
	for i = 1, GetNumAddOns() do
		local name, _, _, enabled = GetAddOnInfo(i);
		if enabled then
			info = info .. name .. "<br />\n";
		end
	end
	info = info .. "</details>\n";
	info = info .. "<details><summary>Enabled Plugins</summary>\n";
	for _, plugin in ipairs(CEPGP_plugins) do
		info = info .. plugin .. "<br />\n";
	end
	info = info .. "</details>\n";
	info = info .. "</details>";
	return info;
end

function CEPGP_getPlayerClass(name, index)
	if not index and not name then return; end
	if index then index = CEPGP_getIndex(name); end
	local class;
	if name == "Guild" then
		return _, {r=0, g=1, b=0};
	end
	if name == "Raid" then
		return _, {r=1, g=0.10, b=0.10};
	end
	if index then
		_, _, _, _, _, _, _, _, _, _, classFileName = GetGuildRosterInfo(index);
		return class, RAID_CLASS_COLORS[classFileName];
	else
		index = CEPGP_getIndex(name);
		if not index then
			return nil;
		else
			_, _, _, _, _, _, _, _, _, _, classFileName = GetGuildRosterInfo(index);
			return class, RAID_CLASS_COLORS[classFileName];
		end
	end
end

function CEPGP_recordAttendance()
	if not UnitInRaid("player") and not CEPGP_debugMode then
		CEPGP_print("You are not in a raid group", true);
		return;
	end
	CEPGP_raid_logs[#CEPGP_raid_logs+1] = {
		[1] = time()
	};
	for i = 1, GetNumGroupMembers(), 1 do
		CEPGP_raid_logs[#CEPGP_raid_logs][i+1] = {
			[1] = GetRaidRosterInfo(i),
			[2] = false --Are they a standby player? Nope.
		};
	end
	for k, v in pairs(CEPGP_standbyRoster) do
		CEPGP_raid_logs[#CEPGP_raid_logs][#CEPGP_raid_logs[#CEPGP_raid_logs]+1] = { --CEPGP_raid_logs[index][timestamp][1] = player name, [2] = bool
			[1] = v[1],
			[2] = true --Are they a standby player? YUP.
		};
	end
	CEPGP_print("Snapshot recorded");
	CEPGP_UpdateAttendanceScrollBar();
end

function CEPGP_deleteAttendance()
	local index = UIDropDownMenu_GetSelectedValue(CEPGP_attendance_dropdown);
	if not index or index == 0 then
		CEPGP_print("Select a snapshot and try again", true);
		return;
	end
	CEPGP_print("Deleted snapshot: " .. date("%d/%m/%Y %H:%M", CEPGP_raid_logs[index][1]));
	local size = CEPGP_ntgetn(CEPGP_raid_logs);
	for i = index, size-1 do
		CEPGP_raid_logs[index] = CEPGP_raid_logs[index+1];
	end
	CEPGP_raid_logs[size] = nil;
	CEPGP_snapshot = nil;
	UIDropDownMenu_SetSelectedValue(CEPGP_attendance_dropdown, 0);
	CEPGP_UpdateAttendanceScrollBar();
end

function CEPGP_formatExport()
	--form is the export format
	local temp = {};
	local text = "";
	local count = 0;
	for name, v in pairs(CEPGP_roster) do
	--for i = 1, GetNumGuildMembers() do
		local index = CEPGP_getIndex(name);
		local name = Ambiguate(GetGuildRosterInfo(index), "all");
		local EP,GP = CEPGP_getEPGP(name, index);
		temp[#temp+1] = {
			[1] = name,
			[2] = v[2], -- Class
			[3] = v[3], -- Guild Rank
			[4] = EP .. "," .. GP, -- Officer Note, processed like this incase the officer note is blank
			[5] = math.floor((EP/GP)*100)/100 -- Priority
		};
	end
	temp = CEPGP_tSort(temp, 1);
	
	local form = _G["CEPGP_export"]:GetAttribute("format");
	
	
	if form == "CSV" then
		for i = 1, #temp do
			text = text .. temp[i][1];
			if CEPGP_export_class_check:GetChecked() then
				text = text .. "," .. temp[i][2]; -- Class
			end
			if CEPGP_export_rank_check:GetChecked() then
				text = text .. "," .. temp[i][3];
			end
			text = text .. "," .. temp[i][4];
			if CEPGP_export_PR_check:GetChecked() then
				text = text .. "," .. temp[i][5];
			end
			if CEPGP_export_trailing_check:GetChecked() then
				text = text .. ",\n";
			else
				text = text .. "\n";
			end
		end
		_G["CEPGP_export_dump"]:SetText(text);
		_G["CEPGP_export_dump"]:HighlightText();
		
		
	elseif form == "JSON" then
		text = "{";
		text = text .. "\"roster\": [";
		for i = 1, #temp do
			text = text .. "[\"" .. temp[i][1] .. "\""; -- Player Name
			if CEPGP_export_class_check:GetChecked() then
				text = text .. ",\"" .. temp[i][2] .. "\""; -- Class
			end
			if CEPGP_export_rank_check:GetChecked() then
				text = text .. ",\"" .. temp[i][3] .. "\""; -- Guild Rank
			end
			text = text .. "," .. temp[i][4];
			text = text .. "," .. temp[i][5];
			if i+1 <= #temp then
				text = text .. "],";
			else
				text = text .. "]";
			end
		end
		text = text .. "],";
		text = text .. "\"timestamp\":" .. time() .. "";
		text = text .. "}";
		_G["CEPGP_export_dump"]:SetText(text);
		_G["CEPGP_export_dump"]:HighlightText();
	end
end

function CEPGP_calcAttendance(name)
	local count = 0;
	local cWeek = 0; --count week
	local cFN = 0; --count fornight
	local cMonth = 0; --count month
	local cTwoMonth = 0; --count 2 months
	local cThreeMonth = 0; --count 3 months
	for _, v in pairs(CEPGP_raid_logs) do
		for i = 2, CEPGP_ntgetn(v), 1 do
			local diff = time() - v[1];
			diff = diff/60/60/24;
			if v[i] == name then --Accommodates for the old raid attendance structure
				count = count + 1;
				if diff <= 90 then
					cThreeMonth = cThreeMonth + 1;
					if diff <= 60 then
						cTwoMonth = cTwoMonth + 1;
						if diff <= 30 then
							cMonth = cMonth + 1;
							if diff <= 14 then
								cFN = cFN + 1;
								if diff <= 7 then
									cWeek = cWeek + 1;
								end
							end
						end
					end
				end
				break;
			elseif v[i][1] == name then --Accommodates for the new raid attendance structure (i.e. [1] = name, [2] = bool for standby roster
				local diff = time() - v[1];
				diff = diff/60/60/24;
				count = count + 1;
				if diff <= 90 then
					cThreeMonth = cThreeMonth + 1;
					if diff <= 60 then
						cTwoMonth = cTwoMonth + 1;
						if diff <= 30 then
							cMonth = cMonth + 1;
							if diff <= 14 then
								cFN = cFN + 1;
								if diff <= 7 then
									cWeek = cWeek + 1;
								end
							end
						end
					end
				end
				break;
			end
		end
	end
	return count, cWeek, cFN, cMonth, cTwoMonth, cThreeMonth;
end

function CEPGP_calcAttIntervals()
	local week = 0;
	local fn = 0;
	local mon = 0;
	local twoMon = 0;
	local threeMon = 0;
	for _, v in pairs(CEPGP_raid_logs) do
		local diff = time() - v[1];
		diff = diff/60/60/24;
		if diff <= 90 then
			threeMon = threeMon + 1;
			if diff <= 60 then
				twoMon = twoMon + 1;
				if diff <= 30 then
					mon = mon + 1;
					if diff <= 14 then
						fn = fn + 1;
						if diff <= 7 then
							week = week + 1;
						end
					end
				end
			end
		end
	end
	return week, fn, mon, twoMon, threeMon;
end

function CEPGP_callItem(id, gp, buttons, timeout)
	if not id then return; end
	id = tonumber(id); -- Must be in a numerical format
	local name, link, _, _, _, _, _, _, _, tex, _, classID, subClassID = GetItemInfo(id);
	local iString;
	CEPGP_Info.LastRun.ItemCall = GetTime();
	local timestamp = CEPGP_Info.LastRun.ItemCall;
	
	local call;
	local timer = timeout-1;
	CEPGP_respond_timeout_string:Show();
	CEPGP_distribute_time:Show();
	CEPGP_respond_timeout_string:SetText("Time Remaining: " .. timer);
	CEPGP_distribute_time:SetText("Time Remaining: " .. timer);
	
	if tonumber(timeout) > 0 then
		C_Timer.NewTicker(1, function()
			if CEPGP_Info.LastRun.ItemCall ~= timestamp then
				return;
			end
			if timer == 0 then
				CEPGP_distribute_time:SetText("Response Time Expired");
				if not CEPGP_respond:IsVisible() then
					return;
				end
				CEPGP_respond:Hide();
				CEPGP_SendAddonMsg("LootRsp;6", "RAID");
				return;
			end
			timer = timer - 1;
			CEPGP_respond_timeout_string:SetText("Time Remaining: " .. timer);
			CEPGP_distribute_time:SetText("Time Remaining: " .. timer);
		end, timeout);
	else
		CEPGP_respond_timeout_string:Hide();
		CEPGP_distribute_time:Hide();
	end
	
	if not link and CEPGP_itemExists(id) then
		local item = Item:CreateFromItemID(id);
		item:ContinueOnItemLoad(function()
				_, link, _, _, _, _, _, _, _, tex, _, classID, subClassID = GetItemInfo(id)
				if not CEPGP_canEquip(GetItemSubClassInfo(classID, subClassID)) and CEPGP_auto_pass then
					CEPGP_print("Cannot equip " .. link .. "|c006969FF. Passing on item.|r");
					CEPGP_SendAddonMsg("LootRsp;6", "RAID");
					return;
				end
				iString = CEPGP_getItemString(link);
				_G["CEPGP_respond"]:Show();
				_G["CEPGP_respond_texture"]:SetTexture(tex);
				_G["CEPGP_respond_texture_frame"]:SetScript('OnEnter', function()
																		GameTooltip:SetOwner(_G["CEPGP_respond_texture_frame"], "ANCHOR_TOPLEFT")
																		GameTooltip:SetHyperlink(iString);
																		GameTooltip:Show();
																	end);
				_G["CEPGP_respond_texture_frame"]:SetScript('OnLeave', function()
																		GameTooltip:Hide();
																	end);
				_G["CEPGP_respond_item_name_frame"]:SetScript('OnClick', function() SetItemRef(iString, name); end);
				_G["CEPGP_respond_item_name"]:SetText(link);
				_G["CEPGP_respond_gp_value"]:SetText(gp);
				for i = 1, 4 do
					if buttons[i] ~= "" and buttons[i] then
						_G["CEPGP_respond_"..i]:Show();
						_G["CEPGP_respond_"..i]:SetText(buttons[i]);
					else
						_G["CEPGP_respond_"..i]:Hide();
					end
				end
			end);
	else
		if not CEPGP_canEquip(GetItemSubClassInfo(classID, subClassID)) and CEPGP_auto_pass then
			CEPGP_print("Cannot equip " .. link .. "|c006969FF. Passing on item.|r");
			CEPGP_SendAddonMsg("LootRsp;6", "RAID");
			return;
		end
		iString = CEPGP_getItemString(link);
		_G["CEPGP_respond"]:Show();
		_G["CEPGP_respond_texture"]:SetTexture(tex);
		_G["CEPGP_respond_texture_frame"]:SetScript('OnEnter', function()
																GameTooltip:SetOwner(_G["CEPGP_respond_texture_frame"], "ANCHOR_TOPLEFT")
																GameTooltip:SetHyperlink(iString);
																GameTooltip:Show();
															end);
		_G["CEPGP_respond_texture_frame"]:SetScript('OnLeave', function()
																GameTooltip:Hide();
															end);
		_G["CEPGP_respond_item_name_frame"]:SetScript('OnClick', function() SetItemRef(iString, name); end);
		_G["CEPGP_respond_item_name"]:SetText(link);
		_G["CEPGP_respond_gp_value"]:SetText(gp);
		for i = 1, 4 do
			if buttons[i] ~= "" and buttons[i] then
				_G["CEPGP_respond_"..i]:Show();
				_G["CEPGP_respond_"..i]:SetText(buttons[i]);
			else
				_G["CEPGP_respond_"..i]:Hide();
			end
		end
	end
end

function CEPGP_checkVersion(message)
	local temp = CEPGP_split(message, ";");
	local args = CEPGP_split(temp[3], ".");
	local version = {
		major = tonumber(args[1]),
		minor = tonumber(args[2]),
		revision = tonumber(args[3])
	};
	if args[4] then
		version.build = args[4];
	elseif temp[4] then
		version.build = temp[4];
	end
	
	--Current build information
	local curBuild = CEPGP_split(CEPGP_Info.Version, ".");
	local current = {
		major = tonumber(curBuild[1]),
		minor = tonumber(curBuild[2]),
		revision = tonumber(curBuild[3]),
		build = CEPGP_Info.Build
	};
	
	outMessage = "Your addon is out of date. Version " .. version.major .. "." .. version.minor .. "." .. version.revision .. " is now available for download at https://github.com/Alumian/CEPGP-Retail"
	if not CEPGP_Info.VersionNotified and (version.build == "release" or version.build == "Release") then
		if version.major > current.major then 
			CEPGP_print(outMessage);
			CEPGP_Info.VersionNotified = true;
		elseif version.major == current.major and version.minor > current.minor then
			CEPGP_print(outMessage);
			CEPGP_Info.VersionNotified = true;
		elseif version.major == current.major and version.minor == current.minor and version.revision > current.revision then
			CEPGP_print(outMessage);
			CEPGP_Info.VersionNotified = true;
		end
	end
end

function CEPGP_split(msg, delim)
	local args = {};
	local count = 1;
	for i in (msg .. delim):gmatch("([^"..delim.."]*)" .. delim) do
		args[count] = i;
		count = count + 1;
	end
	return args;
end

function CEPGP_canEquip(slot)
	local _, class = UnitClass("player");
	local temp = string.sub(class, 2, string.len(class));
	class = string.sub(class, 1, 1) .. string.lower(temp);
	if CEPGP_tContains(CEPGP_classes[class], slot) then return true; end
	return false;
end

function CEPGP_itemExists(id)
	if not id or not tonumber(id) then return false; end
	if C_Item.DoesItemExistByID(tonumber(id)) then
		return true;
	else
		return false;
	end
end

function CEPGP_getReportChannel(channel)
	local channels = {
		[1] = "Party",
		[2] = "Raid",
		[3] = "Guild",
		[4] = "Officer"
	};
	for k, v in ipairs(channels) do
		if string.upper(channel) == v then
			return string.upper(channel);
		end
	end
end

function CEPGP_sendChatMessage(msg, channel)
	if not msg then return; end
	SendChatMessage(msg, channel, CEPGP_LANGUAGE);
end

function CEPGP_toggleGPEdit(mode)
	if mode then
		CEPGP_options_coef_edit:Enable();
		CEPGP_options_coef_2_edit:Enable();
		CEPGP_options_mod_edit:Enable();
		CEPGP_options_gp_base_edit:Enable();
		CEPGP_loot_options_min_EP_check:Enable();
		CEPGP_loot_options_min_EP_amount:Enable();
		CEPGP_loot_options_show_passes_check:Enable();
		CEPGP_loot_options_enforce_PR_sorting_check:Enable();
		CEPGP_loot_options_dist_raidwide_check:Enable();
		CEPGP_loot_options_pass_roll_check:Enable();
		CEPGP_loot_options_announce_roll_check:Enable();
		CEPGP_loot_options_resolve_roll_check:Enable();
		for k, v in pairs(SLOTWEIGHTS) do
			if k ~= "ROBE" and k ~= "EXCEPTION" then
				_G["CEPGP_options_" .. k .. "_weight"]:Enable();
			end
		end
	else
		CEPGP_options_coef_edit:Disable();
		CEPGP_options_coef_2_edit:Disable();
		CEPGP_options_mod_edit:Disable();
		CEPGP_options_gp_base_edit:Disable();
		CEPGP_loot_options_min_EP_check:Disable();
		CEPGP_loot_options_min_EP_amount:Disable();
		CEPGP_loot_options_show_passes_check:Disable();
		CEPGP_loot_options_enforce_PR_sorting_check:Disable();
		CEPGP_loot_options_dist_raidwide_check:Disable();
		CEPGP_loot_options_pass_roll_check:Disable();
		CEPGP_loot_options_announce_roll_check:Disable();
		CEPGP_loot_options_resolve_roll_check:Disable();
		
		for k, v in pairs(SLOTWEIGHTS) do
			if k ~= "ROBE" and k ~= "EXCEPTION" then
				_G["CEPGP_options_" .. k .. "_weight"]:Disable();
			end
		end
	end
end

function CEPGP_saveStandings(name)
	if RECORDS[name] == nil or (CEPGP_overwritelog and name == CEPGP_recordholder) then
		RECORDS[name] = {};
		SortGuildRoster(name);
		for i = 1, GetNumGuildMembers(), 1 do
			local _, _, _, _, _, _, _, oNote = GetGuildRosterInfo(i);
			RECORDS[name][GetGuildRosterInfo(i)] = oNote;
		end
		if CEPGP_overwritelog then
			CEPGP_print("Record overwritten [" .. name .. "]");
			CEPGP_overwritelog = false;
		else
			CEPGP_print("Record saved [" .. name .. "]");
		end
		HideUIPanel(CEPGP_save_guild_logs);
	else
		CEPGP_print("Record [" .. name .. "] already exists. Click confirm again to overwrite");
		CEPGP_recordholder = name;
		CEPGP_overwritelog = true;
	end
end

function CEPGP_importStandings()
	local impString = CEPGP_import_dump:GetText();
	local frags = CEPGP_split(impString, ",");
	local output = _G["CEPGP_import_progress_dump"];
	CEPGP_import_dump:Disable();
	output:SetText("Checking import string...");
	for i = 1, #frags, 3 do
		local name, EP, GP;
		name = frags[i];
		if name then
			name = string.gsub(string.gsub(name, "\n", ""), " ", "");
			if #name == 0 or name == "" then
				frags[#frags] = nil;
				break;
			end
			EP = frags[i+1];
			GP = frags[i+2];
			if #name > 0 and #EP > 0 and #GP > 0 then
				if string.find(name, '[0-9!@#$%^&*(),.?":{}|<>]') then
					output:SetText(output:GetText() .. "\n|c00FF0000Error: Invalid name: " .. name .. ". Aborting.|r");
					CEPGP_import_dump:Enable();
					return;
				end
				if string.find(EP, '[^0-9]!@#$%^&*(),.?":{}|<>]') then
					output:SetText(output:GetText() .. "\n|c00FF0000Error: Invalid EP for " .. name .. ". Aborting.|r");
					CEPGP_import_dump:Enable();
					return;
				end
				if string.find(GP, '[^0-9]!@#$%^&*(),.?":{}|<>]') then
					output:SetText(output:GetText() .. "\n|c00FF0000Error: Invalid GP for " .. name .. ". Aborting.|r");
					CEPGP_import_dump:Enable();
					return;
				end
			else
				if #name == 0 then
					output:SetText(output:GetText() .. "\n|c00FF0000Error: Invalid name: " .. name .. ". Aborting.|r");
					CEPGP_import_dump:Enable();
					return;
				elseif #EP == 0 then
					output:SetText(output:GetText() .. "\n|c00FF0000Error: Invalid EP for " .. name .. ". Aborting.|r");
					CEPGP_import_dump:Enable();
					return;
				else
					output:SetText(output:GetText() .. "\n|c00FF0000Error: Invalid GP for " .. name .. ". Aborting.|r");
					CEPGP_import_dump:Enable();
					return;
				end
			end
		end
	end	
	output:SetText(output:GetText() .. "\nImport string is valid.\nSaving guild record...");
	local tStamp = date("%I:%M:%S%p, %a, %d %B %Y", time()) .. " (Backup)";
	CEPGP_saveStandings(tStamp);
	C_Timer.After(1, function()
		output:SetText(output:GetText() .. "\nGuild record saved.\nApplying changes...");
		CEPGP_Info.IgnoreUpdates = true;
		CEPGP_SendAddonMsg("?IgnoreUpdates;true");
		C_Timer.After(1, function()
			for i = 1, #frags, 3 do
				local index, name, EP, GP;
				name = frags[i];
				if name then
					name = string.gsub(string.gsub(name, "\n", ""), " ", "");
					if #name == 0 or name == "" then
						frags[#frags] = nil;
						break;
					end
					EP = frags[i+1];
					GP = frags[i+2];
					index = CEPGP_getIndex(name);
					if index == nil then
						output:SetText(output:GetText() .. "\nSkipping record: " .. name);
					else
						local rankIndex = select(3, GetGuildRosterInfo(index));
						if not CEPGP.Exclusions[rankIndex+1] then
							output:SetText(output:GetText() .. "\nProcessing record: " .. name);
							GuildRosterSetOfficerNote(index, EP .. "," .. GP);
							CEPGP_import_progress_scrollframe:SetVerticalScroll(CEPGP_import_progress_scrollframe:GetVerticalScroll()+12);
						end
					end
				end
			end
			C_Timer.After(3, function()
				output:SetText(output:GetText() .. "\nImport complete.");
				CEPGP_Info.IgnoreUpdates = false;
				CEPGP_SendAddonMsg("?IgnoreUpdates;false");
				CEPGP_import_dump:Enable();
			end);
		end);
	end);
end

function CEPGP_addPlugin(plugin, iPanel, enabled, func)	-- Addon name, interface panel, enabled status, function to toggle enabled status
	if not plugin then return; end
	for i = 1, GetNumAddOns() do
		local name = GetAddOnInfo(i);
		if name == plugin then
			table.insert(CEPGP_plugins, plugin);
			break;
		end
	end
	if not CEPGP_tContains(CEPGP_plugins, plugin) then
		CEPGP_print(plugin .. " couldn't be found. Plugin not loaded.", true);
		return;
	end
	
	local frame;
	if #CEPGP_plugins == 1 then
		frame = CreateFrame("Frame", "CEPGP_plugin_" .. 1, CEPGP_options_plugins, "PluginButtonTemplate");
		frame:SetPoint("TOPLEFT", CEPGP_options_plugins, "TOPLEFT", 0, -40);
	else
		frame = CreateFrame("Frame", "CEPGP_plugin_" .. #CEPGP_plugins, CEPGP_options_plugins, "PluginButtonTemplate");
		frame:SetPoint("TOPLEFT", _G["CEPGP_plugin_" .. #CEPGP_plugins-1], "BOTTOMLEFT");
	end
	local name = frame:GetName();
	_G[name .. "Name"]:SetText(iPanel.name);
	_G[name .. "Enabled"]:SetChecked(enabled);
	_G[name .. "Enabled"]:SetScript('OnClick', func);
	_G[name .. "Options"]:SetScript('OnClick', function()
		xpcall(function() InterfaceOptionsFrame_OpenToCategory(iPanel) end, geterrorhandler());
	end);
end

function CEPGP_addTraffic(target, source, desc, EPB, EPA, GPB, GPA, itemID, tStamp)
	
	if not source == UnitName("player") then return; end
	local id = time() + GetTime();
	
	EPB = EPB or "";
	EPA = EPA or "";
	GPB = GPB or "";
	GPA = GPA or "";
	itemID = itemID or "";
	tStamp = tstamp or time();
	
	
	if CEPGP_itemExists(tonumber(itemID)) then
		local itemLink = CEPGP_getItemLink(itemID);
		if not itemLink then
			local item = Item:CreateFromItemID(tonumber(itemID));
			item:ContinueOnItemLoad(function()
				itemLink = CEPGP_getItemLink(itemID);
	
				TRAFFIC[#TRAFFIC+1] = {
					[1] = target,
					[2] = source,
					[3] = desc,
					[4] = EPB,
					[5] = EPA,
					[6] = GPB,
					[7] = GPA,
					[8] = itemLink,
					[9] = tStamp,
					[10] = id,
					[11] = UnitGUID("player")
				};
				
			end);
		elseif itemLink then
			TRAFFIC[#TRAFFIC+1] = {
				[1] = target,
				[2] = source,
				[3] = desc,
				[4] = EPB,
				[5] = EPA,
				[6] = GPB,
				[7] = GPA,
				[8] = itemLink,
				[9] = tStamp,
				[10] = id,
				[11] = UnitGUID("player")
			};
		end
	else
		TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {
			[1] = target,
			[2] = source,
			[3] = desc,
			[4] = EPB,
			[5] = EPA,
			[6] = GPB,
			[7] = GPA,
			[8] = "",
			[9] = tStamp,
			[10] = id,
			[11] = UnitGUID("player")
		};
	end
	
	--[[CEPGP.Traffic[#CEPGP.Traffic+1] = {
		[1] = target,
		[2] = source,
		[3] = desc,
		[4] = EPB,
		[5] = EPA,
		[6] = GPB,
		[7] = GPA,
		[8] = item,
		[9] = tStamp,
		[10] = id,
		[11] = UnitGUID("player")
	};]]
	
	if CanEditOfficerNote() then
		CEPGP_SendAddonMsg("CEPGP_TRAFFIC;" .. target .. ";" .. source .. ";" .. desc .. ";" .. EPB .. ";" .. EPA .. ";" .. GPB .. ";" .. GPA .. ";" .. itemID .. ";" .. tStamp .. ";" .. id .. ";" .. UnitGUID("player"), "GUILD");
	end
end

function CEPGP_keyExists(t, key)
	return t[key] ~= nil;
end

function CEPGP_addCharacterLink(main, alt)
	if not CEPGP.Alt.Links then
		CEPGP.Alt.Links = {};
	end
	
	for m, t in pairs(CEPGP.Alt.Links) do
		for k, v in pairs(t) do
			if string.lower(m) == string.lower(alt) then
				CEPGP_print(alt .. " is already marked as a main character", true);
				return;
			elseif string.lower(v) == string.lower(main) then
				CEPGP_print(main .. " is marked as an alt of " .. m .. " and cannot be a main character", true);
				return;
			elseif string.lower(v) == string.lower(alt) then
				CEPGP_print(alt .. " is already linked to " .. m, true);
				return;
			end
		end
	end
	
	if not CEPGP.Alt.Links[main] then
		CEPGP.Alt.Links[main] = {};
	end
	
	CEPGP.Alt.Links[main][#CEPGP.Alt.Links[main]+1] = alt;
	
	CEPGP_print(alt .. " is now an alt of " .. main);
end

function CEPGP_removeCharacterLink(main, alt)
	if not CEPGP.Alt.Links then
		CEPGP.Alt.Links = {};
	end
	
	if not CEPGP.Alt.Links[main] then
		CEPGP_print(alt .. " is not an alt of " .. main, true);
	elseif CEPGP.Alt.Links[main] and alt then
		for k, v in ipairs(CEPGP.Alt.Links[main]) do
			if v == alt then
				table.remove(CEPGP.Alt.Links[main], k);
				CEPGP_print(alt .. " is no longer linked to " .. main);
				if #CEPGP.Alt.Links[main] == 0 then
					CEPGP.Alt.Links[main] = nil;
				end
				return;
			end
		end
	elseif CEPGP.Alt.Links[main] then
		CEPGP.Alt.Links[main] = nil;
		CEPGP_print(main .. " and all linked alts have been released");
		return;
	else
		CEPGP_print(alt .. " is not an alt of " .. main, true);
	end
end

function CEPGP_encodeClassString(class, str)
	
	local colours = {
		["DRUID"] = "00FF7D0A",
		["HUNTER"] = "00A9D271",
		["MAGE"] = "0040C7EB",
		["PALADIN"] = "00F58CBA",
		["PRIEST"] = "00FFFFFF",
		["ROGUE"] = "00FFF569",
		["SHAMAN"] = "000070DE",
		["WARLOCK"] = "008787ED",
		["WARRIOR"] = "00C79C6E"
	}
	
	if class then
		return "|c" .. colours[class] .. str .. "|r";
	else
		return "|cFFFFFFFF" .. str .. "|r";
	end
end

function CEPGP_getMain(name)
	for mainName, v in pairs(CEPGP.Alt.Links) do
		for index, altName in pairs(v) do
			if name == altName then return mainName; end
		end
	end
end

function CEPGP_syncAltStandings(main)
	if not main or not CEPGP.Alt.Links[main] then return; end
	local mainIndex;
	for k, alt in pairs(CEPGP.Alt.Links[main]) do
		if CEPGP_roster[alt] then
			mainIndex = CEPGP_getIndex(main, CEPGP_roster[main] or nil);
			
			if CEPGP_charIsExcluded(main, mainIndex) then
				CEPGP_print("Could not synchronise EPGP from " .. main .. " because they are in an excluded rank", true);
				return;
			end
			
			local index = CEPGP_getIndex(alt);
			local mEP,mGP = CEPGP_getEPGP(main, CEPGP_getIndex(main));	-- Standings of main
			local EP,GP = CEPGP_getEPGP(alt, index);	-- Standings of alt
			if CEPGP.Alt.SyncEP and CEPGP.Alt.SyncGP then
				GuildRosterSetOfficerNote(index, mEP .. "," .. mGP);
			elseif CEPGP.Alt.SyncEP then
				GuildRosterSetOfficerNote(index, mEP .. "," .. GP);
			elseif CEPGP.Alt.SyncGP then
				GuildRosterSetOfficerNote(index, EP .. "," .. mGP);
			end
		end
	end
end

function CEPGP_syncToMain(alt, index, main)
	if not alt or not main then return; end
	local mainIndex = CEPGP_getIndex(main);
	
	if CEPGP_charIsExcluded(main, mainIndex) then
		CEPGP_print("Could not synchronise EPGP with " .. main .. " because they are in an excluded rank", true);
		return;
	end
	
	local altEP, altGP = CEPGP_getEPGP(alt, index);
	local mainEP, mainGP = CEPGP_getEPGP(main, mainIndex);
	
	if CEPGP.Alt.SyncEP and CEPGP.Alt.SyncGP then
		GuildRosterSetOfficerNote(mainIndex, altEP .. "," .. altGP);
	elseif CEPGP.Alt.SyncEP then
		GuildRosterSetOfficerNote(mainIndex, altEP .. "," .. mainGP);
	elseif CEPGP.Alt.SyncGP then
		GuildRosterSetOfficerNote(mainIndex, mainEP .. "," .. altGP);
	end
	
	C_Timer.After(1, function()
		CEPGP_syncAltStandings(main);
	end);
end

function CEPGP_addAltEPGP(EP, GP, alt, main)
	local success, failMsg = pcall(function()
		if not main or CEPGP.Alt.BlockAwards then return; end
		local index = CEPGP_getIndex(alt);
		local mainEP, mainGP = CEPGP_getEPGP(main, CEPGP_roster[main][1]);
		local altEP, altGP = CEPGP_getEPGP(alt, index);
		
		mainEP = math.max(mainEP + EP, 0);
		mainGP = math.max(mainGP + GP, CEPGP.GP.Min + math.max(GP, 0));
		
		altEP = math.max(altEP + EP, 0);
		altGP = math.max(altGP + GP, CEPGP.GP.Min + math.max(GP, 0));
		
		if CEPGP.Alt.SyncEP and CEPGP.Alt.SyncGP then
			GuildRosterSetOfficerNote(index, mainEP .. "," .. mainGP);	--	Both EPGP are being synced
		elseif CEPGP.Alt.SyncEP then
			GuildRosterSetOfficerNote(index, mainEP .. "," .. altGP);	--	Only EP is being synced
		elseif CEPGP.Alt.SyncGP then
			GuildRosterSetOfficerNote(index, altEP .. "," .. mainGP);	--	Only GP is being synced
		else
			GuildRosterSetOfficerNote(index, altEP .. "," .. altGP);	--	Alt standings are not synced with main
		end
		
		C_Timer.After(1, function()
			CEPGP_syncToMain(alt, index, main);
		end);
	end);
	
	if not success then
		CEPGP_print("Could not process changes to EPGP for " .. alt, true);
		CEPGP_print(failMsg, true);
	end
end

function CEPGP_charIsExcluded(name, index)
	index = CEPGP_getIndex(name);
	local _, _, rankIndex = GetGuildRosterInfo(index);
	
	if CEPGP.Exclusions[rankIndex+1] then
		return true;
	end
	
	return false;
end