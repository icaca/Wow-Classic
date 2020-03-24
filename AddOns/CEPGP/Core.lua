--[[ Globals ]]--

CEPGP_VERSION = "1.12.9.release";
SLASH_CEPGP1 = "/CEPGP";
SLASH_CEPGP2 = "/cep";
CEPGP_VERSION_NOTIFIED = false;
CEPGP_mode = "guild";
CEPGP_recordholder = "";
CEPGP_distPlayer = "";
CEPGP_distGP = false;
CEPGP_lootSlot = nil;
CEPGP_target = nil;
CEPGP_DistID = nil;
CEPGP_distSlot = nil;
CEPGP_distItemLink = nil;
CEPGP_debugMode = false;
CEPGP_critReverse = false; --Criteria reverse
CEPGP_distributing = false;
CEPGP_overwritelog = false;
CEPGP_override_confirm = false;
CEPGP_confirmrestore = false;
CEPGP_looting = false;
CEPGP_traffic_clear = false;
CEPGP_criteria = 4;
CEPGP_frames = {CEPGP_guild, CEPGP_raid, CEPGP_loot, CEPGP_distribute, CEPGP_options, CEPGP_options_page_2, CEPGP_options_page_3, CEPGP_distribute_popup, CEPGP_context_popup, CEPGP_save_guild_logs, CEPGP_restore_guild_logs, CEPGP_settings_import, CEPGP_override, CEPGP_traffic, CEPGP_standby, CEPGP_options_plugins};
CEPGP_boss_config_frames = {CEPGP_options_page_3_mc, CEPGP_options_page_3_bwl, CEPGP_options_page_3_zg, CEPGP_options_page_3_aq20, CEPGP_options_page_3_aq40, CEPGP_options_page_3_naxx, CEPGP_options_page_3_worldboss};
CEPGP_LANGUAGE = GetDefaultLanguage("player");
CEPGP_responses = {};
CEPGP_itemsTable = {};
CEPGP_roster = {};
CEPGP_raidRoster = {};
CEPGP_vInfo = {};
CEPGP_vSearch = "GUILD";
CEPGP_ElvUI = nil;
CEPGP_groupVersion = {};
CEPGP_snapshot = nil;
CEPGP_use = false;
CEPGP_award = false;
CEPGP_rate = 1;
CEPGP_plugins = {};

--[[ SAVED VARIABLES ]]--
CHANNEL = nil;
CEPGP_lootChannel = nil;
MOD = nil;
COEF = nil;
MOD_COEF = nil;
BASEGP = nil;
STANDBYEP = false;
STANDBYOFFLINE = false;
CEPGP_min_threshold = nil;
ALLOW_FORCED_SYNC = false;
CEPGP_force_sync_rank = nil;
CEPGP_standby_accept_whispers = false;
CEPGP_standby_share = false;
CEPGP_standby_whisper_msg = "standby";
CEPGP_keyword = nil;
CEPGP_standby_byrank = true;
CEPGP_standby_manual = false;
CEPGP_notice = false;
CEPGP_loot_GUI = false;
CEPGP_auto_pass = false;
CEPGP_raid_wide_dist = false;
CEPGP_gp_tooltips = false;
CEPGP_suppress_announcements = false;
STANDBYPERCENT = nil;
STANDBYRANKS = {};
SLOTWEIGHTS = {};
DEFSLOTWEIGHTS = {["2HWEAPON"] = 2,["WEAPONMAINHAND"] = 1.5,["WEAPON"] = 1.5,["WEAPONOFFHAND"] = 0.5,["HOLDABLE"] = 0.5,["SHIELD"] = 0.5,["RANGED"] = 0.5,["RANGEDRIGHT"] = 0.5,["RELIC"] = 0.5,["HEAD"] = 1,["NECK"] = 0.5,["SHOULDER"] = 0.75,["CLOAK"] = 0.5,["CHEST"] = 1,["ROBE"] = 1,["WRIST"] = 0.5,["HAND"] = 0.75,["WAIST"] = 0.75,["LEGS"] = 1,["FEET"] = 0.75,["FINGER"] = 0.5,["TRINKET"] = 0.75};
AUTOEP = {};
EPVALS = {};
RECORDS = {};
OVERRIDE_INDEX = {};
TRAFFIC = {};
CEPGP_raid_logs = {};
CEPGP_standbyRoster = {};
CEPGP_minEP = {false, 0};
CEPGP_response_buttons = {[1]={true, "Main Spec", 0},[2]={false, "Off Spec", 0},[3]={false, "Disenchant", 0},[4]={false, "", 0},[5]={false, "", 0},[6]={false, "Pass", 100}};
CEPGP_response_time = 60;
CEPGP_show_passes = false;
CEPGP_PR_sort = true;

CEPGP = {};
CEPGP_Info = {
	Version = "1.12.9",
	Build = "release",
	IgnoreUpdates = false,
	LastImport = time(),
	LastUpdate = GetTime(),
	QueuedAnnouncement = nil,
	RosterStack = {},
	VersionNotified = false,
	Defaults = {
		SlotWeights = {
			["2HWEAPON"] = 2,
			["WEAPONMAINHAND"] = 1.5,
			["WEAPON"] = 1.5,
			["WEAPONOFFHAND"] = 0.5,
			["HOLDABLE"] = 0.5,
			["SHIELD"] = 0.5,
			["RANGED"] = 0.5,
			["RANGEDRIGHT"] = 0.5,
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
			["TRINKET"] = 0.75
		}
	}
};
local L = CEPGP_Locale:GetLocale("CEPGP")


--[[ EVENT AND COMMAND HANDLER ]]--
function CEPGP_OnEvent(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17)
	
	if event == "ADDON_LOADED" and arg1 == "CEPGP" then --arg1 = addon name
		--	Translating from old structure to new
		CEPGP = {
			Attendance = CEPGP_raid_logs,
			Backups = RECORDS,
			Channel = CHANNEL,
			LootChannel = CEPGP_lootChannel,
			Notice = CEPGP_notice,
			Overrides = OVERRIDE_INDEX,
			Sync = {ALLOW_FORCED_SYNC, CEPGP_force_sync_rank},
			Traffic = TRAFFIC,
			EP = {
				AutoAward = AUTOEP,
				BossEP = EPVALS,
				Keyword = CEPGP_keyword,
			},
			GP = {
				Base = COEF,
				Mod = MOD,
				Multiplier = MOD_COEF,
				SlotWeights = SLOTWEIGHTS,
				Tooltips = CEPGP_gp_tooltips
			},
			Loot = {
				AutoPass = CEPGP_auto_pass,
				AutoSort = CEPGP_PR_sort,
				Keyword = CEPGP_keyword,
				MinThreshold = CEPGP_minEP,
				RaidVisibility = CEPGP_raid_wide_dist,
				SuppressResponses = CEPGP_suppress_announcements,
				GUI = {
					Buttons = CEPGP_response_buttons,
					Enabled = CEPGP_loot_GUI,
					Timer = CEPGP_response_time
				}
			},
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
		}
		CEPGP_initialise();
		return;
		
	elseif event == "GUILD_ROSTER_UPDATE" or event == "GROUP_ROSTER_UPDATE" then
		CEPGP_rosterUpdate(event);
		return;
	
	elseif event == "GET_ITEM_INFO_RECEIVED" then
		local id, success = arg1, arg2;
		if success then CEPGP_updateOverride(id); end
		return;
		
	elseif event == "PARTY_LOOT_METHOD_CHANGED" then
		if GetLootMethod() == "master" and IsInRaid("player") and CEPGP_isML() == 0 then
			_G["CEPGP_confirmation"]:Show();
		else
			_G["CEPGP_confirmation"]:Hide();
		end
		return;
		
	elseif event == "CHAT_MSG_BN_WHISPER" then
		local sender = arg2;
		if not UnitInRaid("player") then return; end
		for i = 1, BNGetNumFriends() do
			local _, accName, _, _, name = BNGetFriendInfo(i);
			local inRaid = false;
			for x = 1, GetNumGroupMembers() do
				if CEPGP_raidRoster[x][1] == name then
					inRaid = true;
					break;
				end
			end
			if sender == accName then --Behaves the same way for both Battle Tag and RealID friends
				if string.lower(arg1) == string.lower(CEPGP_standby_whisper_msg) then
					if (CEPGP_standby_manual and CEPGP_standby_accept_whispers) and
						not CEPGP_tContains(CEPGP_standbyRoster, name) and not inRaid and CEPGP_roster[name] then
						CEPGP_addToStandby(name);
					end
				elseif (string.lower(arg1) == string.lower(CEPGP_keyword) and CEPGP_distributing) or
						(string.lower(arg1) == "!info" or string.lower(arg1) == "!infoguild" or
						string.lower(arg1) == "!inforaid" or string.lower(arg1) == "!infoclass") then
						CEPGP_handleComms("CHAT_MSG_WHISPER", arg1, name);
				end
				return;
			end
		end
		return;
	
	elseif event == "CHAT_MSG_WHISPER" and string.lower(arg1) == string.lower(CEPGP_standby_whisper_msg) and CEPGP_standby_manual and CEPGP_standby_accept_whispers then
		if not CEPGP_tContains(CEPGP_standbyRoster, arg5)
		and not CEPGP_tContains(CEPGP_raidRoster, arg5, true)
		and CEPGP_roster[arg5] then
			CEPGP_addToStandby(arg5);
		end
		return;
			
	elseif (event == "CHAT_MSG_WHISPER" and string.lower(arg1) == string.lower(CEPGP_keyword) and CEPGP_distributing) or
		(event == "CHAT_MSG_WHISPER" and string.lower(arg1) == "!info") or
		(event == "CHAT_MSG_WHISPER" and (string.lower(arg1) == "!infoguild" or string.lower(arg1) == "!inforaid" or string.lower(arg1) == "!infoclass")) then
			CEPGP_handleComms(event, arg1, arg5);
			return;
	
	elseif (event == "CHAT_MSG_ADDON") then
		if (arg1 == "CEPGP")then
			if string.find(arg4, "-") then
				arg4 = string.sub(arg4, 0, string.find(arg4, "-")-1);
			end
			CEPGP_IncAddonMsg(arg2, arg4);
		end
		return;
	end
	
	if CEPGP_use then --EPGP and loot distribution related 
		--	An encounter has been defeated
		local function handleEncounter(event, arg2, arg5)
			if event == "ENCOUNTER_END" and arg5 == 1 then
				local bossName = L[arg2];
				if bossNameIndex[bossName] and AUTOEP[bossName] and tonumber(EPVALS[bossName]) > 0 then
					CEPGP_handleCombat(arg2);
				end
				return;
			end
		end
		
		local success, failMsg = pcall(handleEncounter, event, arg2, arg5);
		
		if not success then
			CEPGP_print("Failed to award GP for encounter!", true);
			CEPGP_print(failMsg, true);
		end
		
		if (event == "LOOT_OPENED" or event == "LOOT_CLOSED" or event == "LOOT_SLOT_CLEARED") then
			CEPGP_handleLoot(event, arg1, arg2);
		end
	end
	
end

function SlashCmdList.CEPGP(msg, editbox)
	msg = string.lower(msg);
	
	if msg == "" then
		CEPGP_print("Classic EPGP Usage");
		CEPGP_print("|cFF80FF80show|r - |cFFFF8080Manually shows the CEPGP window|r");
		CEPGP_print("|cFF80FF80version|r - |cFFFF8080Checks the version of the addon everyone in your raid is running|r");
		
	elseif msg == "show" then
		CEPGP_populateFrame();
		ShowUIPanel(CEPGP_frame);
		CEPGP_toggleFrame("");
		CEPGP_updateGuild();
	
	elseif msg == "version" then
		CEPGP_vInfo = {};
		CEPGP_vSearch = "GUILD";
		CEPGP_SendAddonMsg("version-check", "GUILD");
		CEPGP_groupVersion = {};
		for i = 1, GetNumGuildMembers() do
			local name, _, _, _, class, _, _, _, online, _, classFileName = GetGuildRosterInfo(i);
			if string.find(name, "-") then
				name = string.sub(name, 0, string.find(name, "-")-1);
			end
			if online then
				CEPGP_groupVersion[i] = {
					[1] = name,
					[2] = "Addon not enabled",
					[3] = class,
					[4] = classFileName
				};
			else
				CEPGP_groupVersion[i] = {
					[1] = name,
					[2] = "Offline",
					[3] = class,
					[4] = classFileName
				};
			end
		end
		CEPGP_groupVersion = CEPGP_tSort(CEPGP_groupVersion, 1);
		ShowUIPanel(CEPGP_version);
		CEPGP_UpdateVersionScrollBar();
	
	elseif strfind(msg, "currentchannel") then
		CEPGP_print("Current channel to report: " .. getCurChannel());
		
	elseif strfind(msg, "debugmode") then
		CEPGP_debugMode = not CEPGP_debugMode;
		if CEPGP_debugMode then
			CEPGP_print("Debug Mode Enabled");
		else
			CEPGP_print("Debug Mode Disabled");
		end
		
	elseif strfind(msg, "debug") then
		CEPGP_debuginfo:Show();
	
	else
		CEPGP_print("|cFF80FF80" .. msg .. "|r |cFFFF8080is not a valid request. Type /CEPGP to check addon usage|r", true);
	end
end

--[[ LOOT COUNCIL FUNCTIONS ]]--

function CEPGP_RaidAssistLootClosed()
		HideUIPanel(CEPGP_distribute_popup);
		HideUIPanel(CEPGP_distributing_button);
		HideUIPanel(CEPGP_loot_distributing);
		HideUIPanel(CEPGP_distributing_button);
		CEPGP_distribute_item_tex:SetBackdrop(nil);
		_G["CEPGP_distribute_item_tex"]:SetScript('OnEnter', function() end);
		_G["CEPGP_distribute_item_name_frame"]:SetScript('OnClick', function() end);
end

function CEPGP_RaidAssistLootDist(link, gp, raidwide) --raidwide refers to whether or not the ML would like everyone in the raid to be able to see the distribution window
	if UnitIsGroupAssistant("player") or raidwide then --Only returns true if the unit is raid ASSIST, not raid leader
		ShowUIPanel(CEPGP_distributing_button);
		CEPGP_itemsTable = {};
		CEPGP_UpdateLootScrollBar();
		local name, iString, _, _, _, _, _, _, slot, tex = GetItemInfo(CEPGP_DistID);
		CEPGP_distSlot = slot;
		if not name and CEPGP_itemExists(CEPGP_DistID) then
			local item = Item:CreateFromItemID(tonumber(CEPGP_DistID));
			item:ContinueOnItemLoad(function()
				name, iString, _, _, _, _, _, _, slot, tex = GetItemInfo(CEPGP_DistID);	
				CEPGP_responses = {};
				_G["CEPGP_distribute_item_name"]:SetText(link);
				if iString then
					_G["CEPGP_distribute_item_tex"]:SetScript('OnEnter', function()
																			GameTooltip:SetOwner(_G["CEPGP_distribute_item_tex"], "ANCHOR_TOPLEFT") GameTooltip:SetHyperlink(iString)
																			GameTooltip:Show()
																		end);
					_G["CEPGP_distribute_item_texture"]:SetTexture(tex);
					_G["CEPGP_distribute_item_name_frame"]:SetScript('OnClick', function() SetItemRef(iString) end);
				else
					_G["CEPGP_distribute_item_tex"]:SetScript('OnEnter', function() end);
					_G["CEPGP_distribute_item_texture"]:SetTexture(nil);
				end
				_G["CEPGP_distribute_item_tex"]:SetScript('OnLeave', function() GameTooltip:Hide() end);
				_G["CEPGP_distribute_GP_value"]:SetText(gp);				
			end);
		else
			CEPGP_responses = {};
			_G["CEPGP_distribute_item_name"]:SetText(link);
			if iString then
				_G["CEPGP_distribute_item_tex"]:SetScript('OnEnter', function()
																		GameTooltip:SetOwner(_G["CEPGP_distribute_item_tex"], "ANCHOR_TOPLEFT") GameTooltip:SetHyperlink(iString)
																		GameTooltip:Show()
																	end);
				_G["CEPGP_distribute_item_texture"]:SetTexture(tex);
				_G["CEPGP_distribute_item_name_frame"]:SetScript('OnClick', function() SetItemRef(iString) end);
			else
				_G["CEPGP_distribute_item_tex"]:SetScript('OnEnter', function() end);
				_G["CEPGP_distribute_item_texture"]:SetTexture(nil);
			end
			_G["CEPGP_distribute_item_tex"]:SetScript('OnLeave', function() GameTooltip:Hide() end);
			_G["CEPGP_distribute_GP_value"]:SetText(gp);
		end
	end
end

--[[ ADD EPGP FUNCTIONS ]]--

function CEPGP_AddRaidEP(amount, msg, encounter)
	amount = math.floor(amount);
	local total = GetNumGroupMembers();
	CEPGP_Info.IgnoreUpdates = true;
	CEPGP_SendAddonMsg("?IgnoreUpdates;true");
	local function update()
		if msg ~= "" and msg ~= nil or encounter then
			if encounter then -- a boss was killed
				TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {"Raid", UnitName("player"), "Add Raid EP +" .. amount .. " - " .. encounter, "", "", "", "", "", time()};
				CEPGP_ShareTraffic("Raid", UnitName("player"), "Add Raid EP +" .. amount .. " - " .. encounter);
				CEPGP_sendChatMessage(msg, CHANNEL);
			else -- EP was manually given, could be either positive or negative, and a message was written
				if tonumber(amount) <= 0 then
					TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {"Raid", UnitName("player"), "Subtract Raid EP +" .. amount .. " (" .. msg .. ")", "", "", "", "", "", time()};
					CEPGP_ShareTraffic("Raid", UnitName("player"), "Subtract Raid EP " .. amount .. " (" .. msg .. ")");
					CEPGP_sendChatMessage(amount .. " EP taken from all raid members (" .. msg .. ")", CHANNEL);
				else
					TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {"Raid", UnitName("player"), "Add Raid EP +" .. amount .. " (" .. msg .. ")", "", "", "", "", "", time()};
					CEPGP_ShareTraffic("Raid", UnitName("player"), "Add Raid EP +" .. amount .. " (" .. msg .. ")");
					CEPGP_sendChatMessage(amount .. " EP awarded to all raid members (" .. msg .. ")", CHANNEL);
				end
			end
		else -- no message was written
			if tonumber(amount) <= 0 then
				amount = string.sub(amount, 2, string.len(amount));
				TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {"Raid", UnitName("player"), "Subtract Raid EP -" .. amount, "", "", "", "", "", time()};
				CEPGP_ShareTraffic("Raid", UnitName("player"), "Subtract Raid EP -" .. amount);	
				CEPGP_sendChatMessage(amount .. " EP taken from all raid members", CHANNEL);
			else
				TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {"Raid", UnitName("player"), "Add Raid EP +" .. amount, "", "", "", "", "", time()};
				CEPGP_ShareTraffic("Raid", UnitName("player"), "Add Raid EP +" .. amount);
				CEPGP_sendChatMessage(amount .. " EP awarded to all raid members", CHANNEL);
			end
		end
		if _G["CEPGP_traffic"]:IsVisible() then
			CEPGP_UpdateTrafficScrollBar();
		end
		C_Timer.After(2, function()
			CEPGP_Info.IgnoreUpdates = false;
			CEPGP_SendAddonMsg("?IgnoreUpdates;false");
			CEPGP_rosterUpdate("GUILD_ROSTER_UPDATE");
		end);
	end
	
	local i = 0;
	C_Timer.NewTicker(0.0001, function()
		i = i + 1;
		local name = GetRaidRosterInfo(i);
		if CEPGP_roster[name] then
			local index = CEPGP_getIndex(name, CEPGP_roster[name][1]);
			local _, _, _, _, _, _, _, oNote = GetGuildRosterInfo(index);
			EP,GP = CEPGP_getEPGP(name, index);
			EP = tonumber(EP);
			GP = tonumber(GP);
			EP = EP + amount;
			if GP < BASEGP then
				GP = BASEGP;
			end
			if EP < 0 then
				EP = 0;
			end
			GuildRosterSetOfficerNote(index, math.floor(EP) .. "," .. GP);
		end
		if i == total then
			update();
		end
	end, total);
end

function CEPGP_addGuildEP(amount, msg)
	if amount == nil then
		CEPGP_print("Please enter a valid number", 1);
		return;
	end

	local EP, GP = nil;
	amount = math.floor(amount);
	
	local function update()
		if tonumber(amount) <= 0 then
			amount = string.sub(amount, 2, string.len(amount));
			if msg ~= "" and msg ~= nil then
				CEPGP_sendChatMessage(amount .. " EP taken from all guild members (" .. msg .. ")", CHANNEL);
				TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {"Guild", UnitName("player"), "Subtract Guild EP -" .. amount .. " (" .. msg .. ")", "", "", "", "", "", time()};
				CEPGP_ShareTraffic("Guild", UnitName("player"), "Subtract Guild EP -" .. amount .. " (" .. msg .. ")");
			else
				CEPGP_sendChatMessage(amount .. " EP taken from all guild members", CHANNEL);
				TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {"Guild", UnitName("player"), "Subtract Guild EP -" .. amount, "", "", "", "", "", time()};
				CEPGP_ShareTraffic("Guild", UnitName("player"), "Subtract Guild EP -" .. amount);
			end
		else
			if msg ~= "" and msg ~= nil then
				CEPGP_sendChatMessage(amount .. " EP awarded to all guild members (" .. msg .. ")", CHANNEL);
				TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {"Guild", UnitName("player"), "Add Guild EP +" .. amount .. " (" .. msg .. ")", "", "", "", "", "", time()};
				CEPGP_ShareTraffic("Guild", UnitName("player"), "Add Guild EP +" .. amount .. " (" .. msg .. ")");
			else
				CEPGP_sendChatMessage(amount .. " EP awarded to all guild members", CHANNEL);
				TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {"Guild", UnitName("player"), "Add Guild EP +" .. amount, "", "", "", "", "", time()};
				CEPGP_ShareTraffic("Guild", UnitName("player"), "Add Guild EP +" .. amount);
			end
		end
		if _G["CEPGP_traffic"]:IsVisible() then
			CEPGP_UpdateTrafficScrollBar();
		end
		C_Timer.After(2, function()
			CEPGP_Info.IgnoreUpdates = false;
			CEPGP_SendAddonMsg("?IgnoreUpdates;false");
			CEPGP_rosterUpdate("GUILD_ROSTER_UPDATE");
		end);
	end
	
	CEPGP_Info.IgnoreUpdates = true;
	CEPGP_SendAddonMsg("?IgnoreUpdates;true");
	local temp = {};
	for k, _ in pairs(CEPGP_roster) do
		table.insert(temp, k);
	end
	local i = 0;
	C_Timer.After(0.1, function()
		C_Timer.NewTicker(0.0001, function()
			i = i + 1;
			local name = temp[i];
			local index = CEPGP_getIndex(name, CEPGP_roster[name][1]);
			EP,GP = CEPGP_getEPGP(name, index);
			EP = tonumber(EP) + tonumber(amount);
			GP = tonumber(GP);
			if GP < BASEGP then
				GP = BASEGP;
			end
			if EP < 0 then
				EP = 0;
			end
			GuildRosterSetOfficerNote(index, math.floor(EP) .. "," .. GP);
			if i == #temp then
				update();
			end
		end, #temp);
	end);
end

function CEPGP_addStandbyEP(amount, boss, msg)
	if amount == nil then
		CEPGP_print("Please enter a valid number", 1);
		return;
	end
	
	local function update()
		if tonumber(amount) > 0 then
			TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {"Guild", UnitName("player"), "Standby EP +" .. amount, "", "", "", "", "", time()};
		elseif tonumber(amount) < 0 then
			TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {"Guild", UnitName("player"), "Standby EP " .. amount, "", "", "", "", "", time()};
		end
		if tonumber(amount) > 0 then
			CEPGP_ShareTraffic("Guild", UnitName("player"), "Standby EP +" .. amount);
		elseif tonumber(amount) < 0 then
			CEPGP_ShareTraffic("Guild", UnitName("player"), "Standby EP " .. amount);
		end
		if _G["CEPGP_traffic"]:IsVisible() then
			CEPGP_UpdateTrafficScrollBar();
		end
		if _G["CEPGP_standby"]:IsVisible() then
			CEPGP_UpdateStandbyScrollBar();
		end
		C_Timer.After(2, function()
			CEPGP_Info.IgnoreUpdates = false;
			CEPGP_SendAddonMsg("?IgnoreUpdates;false");
			CEPGP_rosterUpdate("GUILD_ROSTER_UPDATE");
		end);
	end
	
	CEPGP_Info.IgnoreUpdates = true;
	CEPGP_SendAddonMsg("?IgnoreUpdates;true");
	
	local i = 0;
	
	C_Timer.After(0.1, function()
		local temp = {};
		if CEPGP_standby_byrank then
			local inRaid = false;
			for k, _ in pairs(CEPGP_roster) do
				table.insert(temp, k);
			end
			C_Timer.NewTicker(0.0001, function()
				i = i + 1;
				local name = temp[i];
				inRaid = false;
				for _, v in ipairs(CEPGP_raidRoster) do
					if name == v[1] then
						inRaid = true;
						break;
					end
				end
				if not inRaid then
					local index = CEPGP_getIndex(name, CEPGP_roster[name][1]);
					local _, rank, _, _, _, _, _, _, online = GetGuildRosterInfo(index);
					local EP,GP = CEPGP_getEPGP(name, index);
					EP = math.floor(tonumber(EP) + amount);
					GP = math.floor(tonumber(GP));
					if GP < BASEGP then
						GP = BASEGP;
					end
					if EP < 0 then
						EP = 0;
					end				
					for i = 1, #STANDBYRANKS do
						if STANDBYRANKS[i][1] == rank then
							if STANDBYRANKS[i][2] == true and (online or STANDBYOFFLINE) then
								local index = CEPGP_getIndex(name, CEPGP_roster[name][1]);
								GuildRosterSetOfficerNote(index, EP .. "," .. GP);
								if boss then
									CEPGP_SendAddonMsg("STANDBYEP;"..name..";You have been awarded "..amount.." standby EP for encounter " .. boss, "GUILD");
								elseif msg ~= "" and msg ~= nil then
									if tonumber(amount) > 0 then
										CEPGP_SendAddonMsg("STANDBYEP;"..name..";You have been awarded "..amount.." standby EP - "..msg, "GUILD");
									elseif tonumber(amount) < 0 then
										CEPGP_SendAddonMsg("STANDBYEP;"..name..";"..amount.." standby EP has been taken from you - "..msg, "GUILD");
									end
								else
									if tonumber(amount) > 0 then
										CEPGP_SendAddonMsg("STANDBYEP;"..name..";You have been awarded "..amount.." standby EP", "GUILD");
									elseif tonumber(amount) < 0 then
										CEPGP_SendAddonMsg("STANDBYEP;"..name..";"..amount.." standby EP has been taken from you", "GUILD");
									end
								end
							end
						end
					end
				end
				if i == #temp then
					update();
				end
			end, #temp);
			
		elseif CEPGP_standby_manual and #CEPGP_standbyRoster > 0 then
			C_Timer.NewTicker(0.0001, function()
				i = i + 1;
				local name = CEPGP_standbyRoster[i][1];
				local index = CEPGP_getIndex(name, CEPGP_roster[name][1]);
				local _, rank, _, _, _, _, _, _, online = GetGuildRosterInfo(index);
				if online or STANDBYOFFLINE then
					local EP,GP = CEPGP_getEPGP(name, index);
					EP = math.floor(tonumber(EP) + amount);
					GP = math.floor(tonumber(GP));
					if GP < BASEGP then
						GP = BASEGP;
					end
					if EP < 0 then
						EP = 0;
					end

					if offNote == "" or offNote == "Click here to set an Officer's Note" then
						GuildRosterSetOfficerNote(index, EP .. "," .. BASEGP);
					else
						GuildRosterSetOfficerNote(index, EP .. "," .. GP);
					end
					if boss then
						CEPGP_SendAddonMsg("STANDBYEP;"..name..";You have been awarded "..amount.." standby EP for encounter " .. boss, "GUILD");
					elseif msg ~= "" and msg ~= nil then
						if tonumber(amount) > 0 then
							CEPGP_SendAddonMsg("STANDBYEP;"..name..";You have been awarded "..amount.." standby EP - "..msg, "GUILD");
						elseif tonumber(amount) < 0 then
							CEPGP_SendAddonMsg("STANDBYEP;"..name..";"..amount.." standby EP has been taken from you - "..msg, "GUILD");
						end
					else
						if tonumber(amount) > 0 then
							CEPGP_SendAddonMsg("STANDBYEP;"..name..";You have been awarded "..amount.." standby EP", "GUILD");
						elseif tonumber(amount) < 0 then
							CEPGP_SendAddonMsg("STANDBYEP;"..name..";"..amount.." standby EP has been taken from you", "GUILD");
						end
					end
				end
				if i == #CEPGP_standbyRoster then
					update();
				end
			end, #CEPGP_standbyRoster);
		end
	end);
end

function CEPGP_addGP(player, amount, itemID, itemLink, msg, response)
	if amount == nil then
		CEPGP_print("Please enter a valid number", 1);
		return;
	end
	local EP, GP = nil;
	amount = math.floor(amount);
	if CEPGP_roster[player] then
		local index = CEPGP_getIndex(player, CEPGP_roster[player][1]);
		EP,GP = CEPGP_getEPGP(player, index);
		GPB = GP;
		GP = tonumber(GP) + amount;
		EP = tonumber(EP);
		if GP < BASEGP then
			GP = BASEGP;
		end
		if EP < 0 then
			EP = 0;
		end
		GuildRosterSetOfficerNote(index, EP .. "," .. GP);
		if not itemID then
			if tonumber(amount) < 0 then -- Number is negative
				amount = string.sub(amount, 2, string.len(amount));
				if msg ~= "" and msg ~= nil then
					CEPGP_sendChatMessage(amount .. " GP taken from " .. player .. " (" .. msg .. ")", CHANNEL);
					CEPGP_ShareTraffic(player, UnitName("player"), "Subtract GP " .. amount .. " (" .. msg .. ")", EP, EP, GP - amount, GPB);
					TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {
						[1] = player,
						[2] = UnitName("player"),
						[3] = "Subtract GP " .. amount .. " (" .. msg .. ")",
						[4] = EP,
						[5] = EP,
						[6] = GPB,
						[7] = GP,
						[9] = time()
					};
				else
					CEPGP_sendChatMessage(amount .. " GP taken from " .. player, CHANNEL);
					CEPGP_ShareTraffic(player, UnitName("player"), "Subtract GP " .. amount, EP, EP, GP - amount, GPB);
					TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {
						[1] = player,
						[2] = UnitName("player"),
						[3] = "Subtract GP " .. amount,
						[4] = EP,
						[5] = EP,
						[6] = GPB,
						[7] = GP,
						[9] = time()
					};
				end
			else -- Number is positive
				if msg ~= "" and msg ~= nil then
					CEPGP_sendChatMessage(amount .. " GP added to " .. player .. " (" .. msg .. ")", CHANNEL);
					CEPGP_ShareTraffic(player, UnitName("player"), "Add GP " .. amount .. " (" .. msg .. ")", EP, EP, GPB, GP);
					TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {
						[1] = player,
						[2] = UnitName("player"),
						[3] = "Add GP " .. amount .. " (" .. msg .. ")",
						[4] = EP,
						[5] = EP,
						[6] = GPB,
						[7] = GP,
						[9] = time()
					};
				else
					CEPGP_sendChatMessage(amount .. " GP added to " .. player, CHANNEL);
					CEPGP_ShareTraffic(player, UnitName("player"), "Add GP " .. amount, EP, EP, GPB, GP);
					TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {
						[1] = player,
						[2] = UnitName("player"),
						[3] = "Add GP " .. amount,
						[4] = EP,
						[5] = EP,
						[6] = GPB,
						[7] = GP,
						[9] = time()
					};
				end
			end
		else -- If an item is associated with the message then the number cannot be negative
			if not itemLink then
				_, itemLink = GetItemInfo(tonumber(itemID));
			end
			if response then
				TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {
					[1] = player,
					[2] = UnitName("player"),
					[3] = "Add GP " .. amount .. " (" .. response .. ")",
					[4] = EP,
					[5] = EP,
					[6] = GPB,
					[7] = GP,
					[8] = itemLink,
					[9] = time()
					};
			else
				TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {
					[1] = player,
					[2] = UnitName("player"),
					[3] = "Add GP " .. amount,
					[4] = EP,
					[5] = EP,
					[6] = GPB,
					[7] = GP,
					[8] = itemLink,
					[9] = time()
				};
			end
			if response then
				CEPGP_ShareTraffic(player, UnitName("player"), "Add GP " .. amount .. " (" .. response .. ")", EP, EP, GPB, GP, itemID);
			else
				CEPGP_ShareTraffic(player, UnitName("player"), "Add GP " .. amount, EP, EP, GPB, GP, itemID);
			end
		end
		CEPGP_UpdateTrafficScrollBar();
	else
		CEPGP_print(player .. " not found in guild roster - no GP given");
		CEPGP_print("If this was a mistake, you can manually award them GP via the CEPGP guild menu");
	end
end

function CEPGP_addEP(player, amount, msg)
	if amount == nil then
		CEPGP_print("Please enter a valid number", 1);
		return;
	end
	amount = math.floor(amount);
	local EP, GP = nil;
	if CEPGP_roster[player] then
		local index = CEPGP_getIndex(player, CEPGP_roster[player][1]);
		EP,GP = CEPGP_getEPGP(player, index);
		EPB = EP;
		EP = tonumber(EP) + amount;
		GP = tonumber(GP);
		if GP < BASEGP then
			GP = BASEGP;
		end
		if EP < 0 then
			EP = 0;
		end
		GuildRosterSetOfficerNote(index, EP .. "," .. GP);
		if tonumber(amount) <= 0 then
			if msg ~= "" and msg ~= nil then
				amount = string.sub(amount, 2, string.len(amount));
				CEPGP_sendChatMessage(amount .. " EP taken from " .. player .. " (" .. msg .. ")", CHANNEL);
				TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {
					[1] = player,
					[2] = UnitName("player"),
					[3] = "Subtract EP " .. amount .. " (" .. msg .. ")",
					[4] = EPB,
					[5] = EP,
					[6] = GP,
					[7] = GP,
					[9] = time()
				};
				CEPGP_ShareTraffic(player, UnitName("player"), "Subtract EP -" .. amount .. " (" .. msg .. ")", EPB, EP, GP, GP);
			else
				amount = string.sub(amount, 2, string.len(amount));
				CEPGP_sendChatMessage(amount .. " EP taken from " .. player, CHANNEL);
				TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {
					[1] = player,
					[2] = UnitName("player"),
					[3] = "Subtract EP -" .. amount,
					[4] = EPB,
					[5] = EP,
					[6] = GP,
					[7] = GP,
					[9] = time()
				};
				CEPGP_ShareTraffic(player, UnitName("player"), "Subtract EP -" .. amount, EPB, EP, GP, GP);
			end
		else
			if msg ~= "" and msg ~= nil then
				CEPGP_sendChatMessage(amount .. " EP added to " .. player .. " (" .. msg .. ")", CHANNEL);
				TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {
					[1] = player,
					[2] = UnitName("player"),
					[3] = "Add EP +" .. amount .. " (" .. msg .. ")",
					[4] = EPB,
					[5] = EP,
					[6] = GP,
					[7] = GP,
					[9] = time()
				};
				CEPGP_ShareTraffic(player, UnitName("player"), "Add EP +" .. amount .. " (" .. msg ..")", EPB, EP, GP, GP);
			else
				CEPGP_sendChatMessage(amount .. " EP added to " .. player, CHANNEL);
				TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {
					[1] = player,
					[2] = UnitName("player"),
					[3] = "Add EP +" .. amount,
					[4] = EPB,
					[5] = EP,
					[6] = GP,
					[7] = GP,
					[9] = time()
				};
				CEPGP_ShareTraffic(player, UnitName("player"), "Add EP " .. amount, EPB, EP, GP, GP);
			end
		end
		CEPGP_UpdateTrafficScrollBar();
	else
		CEPGP_print("Player not found in guild CEPGP_roster.", true);
	end
end

function CEPGP_decay(amount, msg)
	if amount == nil then
		CEPGP_print("Please enter a valid number", 1);
		return;
	end
	
	local function update()
		if tonumber(amount) <= 0 then
			amount = string.sub(amount, 2, string.len(amount));
			if msg ~= "" and msg ~= nil then
				CEPGP_sendChatMessage("Guild EPGP inflated by " .. amount .. "% (" .. msg .. ")", CHANNEL);
				TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {"Guild", UnitName("player"), "Inflated EPGP +" .. amount .. "% (" .. msg .. ")", "", "", "", "", "", time()}; 
				CEPGP_ShareTraffic("Guild", UnitName("player"), "Inflated EPGP +" .. amount .. "% (" .. msg .. ")");
			else
				CEPGP_sendChatMessage("Guild EPGP inflated by " .. amount .. "%", CHANNEL);
				TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {"Guild", UnitName("player"), "Inflated EPGP +" .. amount .. "%", "", "", "", "", "", time()}; 
				CEPGP_ShareTraffic("Guild", UnitName("player"), "Inflated EPGP +" .. amount .. "%");
			end
		else
			if msg ~= "" and msg ~= nil then
				CEPGP_sendChatMessage("Guild EPGP decayed by " .. amount .. "% (" .. msg .. ")", CHANNEL);
				TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {"Guild", UnitName("player"), "Decay EPGP -" .. amount .. "% (" .. msg .. ")", "", "", "", "", "", time()}; 
				CEPGP_ShareTraffic("Guild", UnitName("player"), "Decayed EPGP -" .. amount .. "% (" .. msg .. ")");
			else
				CEPGP_sendChatMessage("Guild EPGP decayed by " .. amount .. "%", CHANNEL);
				TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {"Guild", UnitName("player"), "Decay EPGP -" .. amount .. "%", "", "", "", "", "", time()}; 
				CEPGP_ShareTraffic("Guild", UnitName("player"), "Decayed EPGP -" .. amount .. "%");
			end
		end
		if _G["CEPGP_traffic"]:IsVisible() then
			CEPGP_UpdateTrafficScrollBar();
		end
		C_Timer.After(2, function()
			CEPGP_Info.IgnoreUpdates = false;
			CEPGP_SendAddonMsg("?IgnoreUpdates;false");
			CEPGP_rosterUpdate("GUILD_ROSTER_UPDATE");
		end);
	end
	
	local EP, GP = nil;
	CEPGP_Info.IgnoreUpdates = true;
	CEPGP_SendAddonMsg("?IgnoreUpdates;true");
	
	local temp = {};
	local i = 0;
	
	for k, _ in pairs(CEPGP_roster) do
		table.insert(temp, k);
	end
	C_Timer.After(0.1, function()
		C_Timer.NewTicker(0.0001, function()
			i = i + 1;
			local name = temp[i];
			local index = CEPGP_getIndex(name, CEPGP_roster[name][1]);
			EP, GP = CEPGP_getEPGP(name, index);
			EP = math.floor(tonumber(EP)*(1-(amount/100)));
			if CEPGP_minGPDecayFactor then
				GP = math.floor((tonumber((GP-BASEGP))*(1-(amount/100)))+BASEGP);
			else
				GP = math.floor((tonumber(GP)*(1-(amount/100))));
			end
			if GP < BASEGP then
				GP = BASEGP;
			end
			if EP < 0 then
				EP = 0;
			end
			GuildRosterSetOfficerNote(index, EP .. "," .. GP);
			if i == #temp then
				update();
			end
		end, #temp);
	end);
end

function CEPGP_resetAll(msg)
	
	local function update()
		if msg ~= "" and msg ~= nil then
			TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {"Guild", UnitName("player"), "Cleared EPGP standings (" .. msg .. ")", "", "", "", "", "", time()};
			CEPGP_ShareTraffic("Guild", UnitName("player"), "Cleared EPGP standings (" .. msg .. ")");
			CEPGP_sendChatMessage("All EPGP standings have been cleared! (" .. msg .. ")", CHANNEL);
		else
			TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {"Guild", UnitName("player"), "Cleared EPGP standings", "", "", "", "", "", time()};
			CEPGP_ShareTraffic("Guild", UnitName("player"), "Cleared EPGP standings");
			CEPGP_sendChatMessage("All EPGP standings have been cleared!", CHANNEL);
		end
		C_Timer.After(2, function()
			CEPGP_Info.IgnoreUpdates = false;
			CEPGP_SendAddonMsg("?IgnoreUpdates;false");
			CEPGP_rosterUpdate("GUILD_ROSTER_UPDATE");
		end);
	end
	
	CEPGP_Info.IgnoreUpdates = true;
	CEPGP_SendAddonMsg("?IgnoreUpdates;true");
	
	local i = 0;
	
	C_Timer.After(0.1, function()
		C_Timer.NewTicker(0.0001, function()
			i = i + 1;
			GuildRosterSetOfficerNote(i, "0,"..BASEGP);
			if i == GetNumGuildMembers() then
				update();
			end
		end, GetNumGuildMembers());
	end);
	
end