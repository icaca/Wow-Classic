--[[ Globals ]]--

CEPGP_VERSION = "1.12.19.Release"
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
CEPGP_frames = {CEPGP_guild, CEPGP_raid, CEPGP_loot, CEPGP_distribute, CEPGP_context_popup};
CEPGP_boss_config_frames = {CEPGP_EP_options_mc, CEPGP_EP_options_bwl, CEPGP_EP_options_zg, CEPGP_EP_options_aq20, CEPGP_EP_options_aq40, CEPGP_EP_options_naxx, CEPGP_EP_options_worldboss};
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
CHANNEL = "Guild";
CEPGP_lootChannel = "Raid";
MOD = 1;
COEF = 4.83;
MOD_COEF = 2;
BASEGP = 1;
STANDBYEP = false;
STANDBYOFFLINE = false;
CEPGP_min_threshold = 2;
ALLOW_FORCED_SYNC = false;
CEPGP_force_sync_rank = 1;
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
STANDBYPERCENT = 100;
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
CEPGP_response_buttons = {[1]={true, "Main Spec", 0, "Need"},[2]={false, "Off Spec", 0, "Greed"},[3]={false, "Disenchant", 0, "Disenchant"},[4]={false, "Minor Upgrade", 0, "Minor"},[5]={false, "", 0},[6]={false, "Pass", 100}};
CEPGP_response_time = 0;
CEPGP_show_passes = false;
CEPGP_PR_sort = true;

CEPGP_Info = {
	Version = 				"1.12.19",
	Build = 				"Release",
	Active = 				{false, false},	--	Active state, queried for current raid
	SharingTraffic = 		false,
	ImportingTraffic = 		false,
	NumExcluded = 			0,
	IgnoreUpdates = 		false,
	LastImport = 			time(),
	SyncInProgress = 		false,
	LastUpdate = 			GetTime(),
	QueuedAnnouncement = 	nil,
	QueuedAward = 			nil,
	Polling = 				false,
	Rescan = 				false,
	MessageStack =			{},
	RosterStack = 			{},
	Sorting = {	--	Sorting index, reverse
		Attendance = 		{1, false},
		Guild = 			{4, false},
		Loot = 				{4, false},
		Raid = 				{4, false},
		Standby = 			{1, false},
		Version = 			{1, false},
	},
	VersionNotified = 		false,
	VerboseLogging = 		false,
	TrafficImport = 		{},
	TrafficScope = 			1,
	LastRun = {
		GuildSB = 			0,
		RaidSB = 			0,
		TrafficSB = 		0,
		VersionSB = 		0,
		ItemCall = 			time()
	}
};

CEPGP = {
	Attendance = 			CEPGP_raid_logs,
	Backups = 				RECORDS,
	Channel = 				CHANNEL,
	Exclusions = 			{false,false,false,false,false,false,false,false,false,false},
	ChangelogVersion =		CEPGP_Info.Version,
	LootChannel = 			CEPGP_lootChannel,
	Notice = 				CEPGP_notice,
	Overrides = 			OVERRIDE_INDEX,
	PollRate = 				0.0001,
	Sync = 					{ALLOW_FORCED_SYNC, CEPGP_force_sync_rank},
	Traffic = 				TRAFFIC,
	Alt = {		
							Links = {},
							BlockAwards = false,
							SyncEP = true,
							SyncGP = true,
	},		
	Decay = 				{Separate = false},
	EP = {		
							AutoAward = AUTOEP,
							BossEP = EPVALS,
							Keyword = CEPGP_keyword,
	},		
	GP = {		
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
								["TRINKET"] = 0.75
							},
							Tooltips = false,
	},
	Loot = {
		Announcement = 		"Whisper me for loot",
		AutoPass = 			CEPGP_auto_pass,
		AutoSort = 			CEPGP_PR_sort,
		ExtraKeywords = 	{Keywords = {}},
		Keyword = 			CEPGP_keyword,
		HideKeyphrases = 	false,
		MinThreshold = 		CEPGP_min_threshold,
		MinReq = 			CEPGP_minEP,
		RaidVisibility = 	CEPGP_raid_wide_dist,
		RaidWarning = 		false,
		ShowPass = 			CEPGP_show_passes,
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

local L = CEPGP_Locale:GetLocale("CEPGP")

--[[ EVENT AND COMMAND HANDLER ]]--
function CEPGP_OnEvent(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17)
	
	local function isLootKeyword()
		for i = 1, 4 do
			if string.lower(arg1) == string.lower(CEPGP_response_buttons[i][4]) then
				return true;
			end
		end
		for _, v in pairs(CEPGP.Loot.ExtraKeywords.Keywords) do
			for key, _ in pairs(v) do
				if string.lower(arg1) == string.lower(key) then
					return true;
				end
			end
		end
		return false;
	end
	
	if event == "ADDON_LOADED" and arg1 == "CEPGP" then --arg1 = addon name
		local success, failMsg = pcall(function()
			CEPGP_initialise();
			return;
		end);
		
		C_Timer.After(6, function()
			if not success then
				CEPGP_print("Addon failed to initialise!", true);
				CEPGP_print(failMsg);
			end
		end);
		
	elseif event == "GUILD_ROSTER_UPDATE" or event == "GROUP_ROSTER_UPDATE" then
		CEPGP_rosterUpdate(event);
		return;
	
	elseif event == "GET_ITEM_INFO_RECEIVED" then
		local id, success = arg1, arg2;
		if success then
			CEPGP_updateOverride(id);
		end
		return;
		
	elseif event == "PARTY_LOOT_METHOD_CHANGED" or event == "PLAYER_ROLES_ASSIGNED" then
		if GetLootMethod() == "master" and IsInRaid("player") and (CEPGP_isML() == 0 or CEPGP_debugMode) and not CEPGP_Info.Active[2] then
			_G["CEPGP_confirmation"]:Show();
		else
			_G["CEPGP_confirmation"]:Hide();
		end
		
		if GetLootMethod() ~= "master" or not IsInRaid("player") or CEPGP_isML() ~= 0 then
			CEPGP_Info.Active[1] = false;
			CEPGP_Info.Active[2] = false;	--	Whenever the loot method, loot master or group type is changed, this will enable the check again
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
				elseif (isLootKeyword() and CEPGP_distributing) or
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
			
	elseif (event == "CHAT_MSG_WHISPER" and isLootKeyword() and CEPGP_distributing) or
		(event == "CHAT_MSG_WHISPER" and string.lower(arg1) == "!info") or
		(event == "CHAT_MSG_WHISPER" and (string.lower(arg1) == "!infoguild" or string.lower(arg1) == "!inforaid" or string.lower(arg1) == "!infoclass")) then
			--	arg1 - message | arg5 - sender
			CEPGP_handleComms(event, arg1, arg5);
			return;
	
	elseif (event == "CHAT_MSG_ADDON") or (event == "CHAT_MSG_ADDON_LOGGED") then
		if (arg1 == "CEPGP")then
			if string.find(arg4, "-") then
				arg4 = string.sub(arg4, 0, string.find(arg4, "-")-1);
			end
			CEPGP_IncAddonMsg(arg2, arg4);
		end
		return;
	end
	
	if CEPGP_Info.Active[1] or CEPGP_debugMode then --EPGP and loot distribution related 
		--	An encounter has been defeated
		local function handleEncounter(event, arg1, arg5)
			
			if event == "ENCOUNTER_END" and arg5 == 1 then
				local id = tonumber(arg1);
				local name = CEPGP_EncounterInfo.ID[id];
				if name then
					if AUTOEP[name] and tonumber(EPVALS[name]) > 0 then
						CEPGP_handleCombat(name);
					end
				end
				return;
			end
		end
		
		local success, failMsg = pcall(handleEncounter, event, arg1, arg5);
		
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
	if ((UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) and CEPGP_isML ~= 0) or raidwide then --Only returns true if the unit is raid ASSIST, not raid leader
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
	local function callback()
		local total = GetNumGroupMembers();
		CEPGP_Info.IgnoreUpdates = true;
		CEPGP_SendAddonMsg("?IgnoreUpdates;true");
		
		local roster = {};
		
		for k, v in pairs(CEPGP_raidRoster) do
			roster[k] = "";
		end
		
		local function update()
			if msg ~= "" and msg ~= nil or encounter then
				if encounter then -- a boss was killed
					CEPGP_addTraffic("Raid", UnitName("player"), "Add Raid EP +" .. amount .. " - " .. encounter, "", "", "", "", "", time());
					CEPGP_sendChatMessage(msg, CHANNEL);
				else -- EP was manually given, could be either positive or negative, and a message was written
					if tonumber(amount) <= 0 then
						CEPGP_addTraffic("Raid", UnitName("player"), "Subtract Raid EP +" .. amount .. " (" .. msg .. ")", "", "", "", "", "", time());
						CEPGP_sendChatMessage(amount .. " EP taken from all raid members (" .. msg .. ")", CHANNEL);
					else
						CEPGP_addTraffic("Raid", UnitName("player"), "Add Raid EP +" .. amount .. " (" .. msg .. ")", "", "", "", "", "", time());
						CEPGP_sendChatMessage(amount .. " EP awarded to all raid members (" .. msg .. ")", CHANNEL);
					end
				end
			else -- no message was written
				if tonumber(amount) <= 0 then
					amount = string.sub(amount, 2, string.len(amount));
					CEPGP_addTraffic("Raid", UnitName("player"), "Subtract Raid EP -" .. amount, "", "", "", "", "", time());
					CEPGP_sendChatMessage(amount .. " EP taken from all raid members", CHANNEL);
				else
					CEPGP_addTraffic("Raid", UnitName("player"), "Add Raid EP +" .. amount, "", "", "", "", "", time());
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
		local mains = {};
		C_Timer.NewTicker(0.0001, function()
			i = i + 1;
			local name = GetRaidRosterInfo(i);
			local EP, GP, EPB;
			if CEPGP_roster[name] then
				local index = CEPGP_getIndex(name);
				local main = CEPGP_getMain(name);
				
				if main then
					for v, _ in pairs(mains) do
						if v == main then
							return;
						end
					end
					if not roster[main] then
						mains[main] = name;
					end
				else
					EP, GP = CEPGP_getEPGP(name, index);
					EPB = EP;
					EP = math.max(math.floor(EP + amount), 0);
					GP = math.max(math.floor(GP), CEPGP.GP.Min);
					GuildRosterSetOfficerNote(index, EP .. "," .. GP);
					if CEPGP.Alt.Links[name] and not mains[name] then
						mains[name] = {};
					end
				end
			end
			if i == total then
				C_Timer.After(2, function()
					for main, alt in pairs(mains) do
						if #mains[main] == 0 then
							CEPGP_syncAltStandings(main);
						else
							CEPGP_addAltEPGP(amount, 0, alt, main);
						end
					end
				end);
				update();
			end
		end, total);
	end
	
	if CEPGP_ntgetn(CEPGP_roster) < (GetNumGuildMembers() - CEPGP_Info.NumExcluded) and CEPGP_Info.Polling then
		CEPGP_print("Scanning guild roster. Raid EP will be applied soon.");
		if encounter then
			CEPGP_Info.RosterStack["BossEP"] = callback;
		else
			CEPGP_Info.RosterStack["RaidEP"] = callback;
		end
	else
		callback();
	end
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
				CEPGP_addTraffic("Guild", UnitName("player"), "Subtract Guild EP -" .. amount .. " (" .. msg .. ")", "", "", "", "", "", time());
			else
				CEPGP_sendChatMessage(amount .. " EP taken from all guild members", CHANNEL);
				CEPGP_addTraffic("Guild", UnitName("player"), "Subtract Guild EP -" .. amount, "", "", "", "", "", time());
			end
		else
			if msg ~= "" and msg ~= nil then
				CEPGP_sendChatMessage(amount .. " EP awarded to all guild members (" .. msg .. ")", CHANNEL);
				CEPGP_addTraffic("Guild", UnitName("player"), "Add Guild EP +" .. amount .. " (" .. msg .. ")", "", "", "", "", "", time());
			else
				CEPGP_sendChatMessage(amount .. " EP awarded to all guild members", CHANNEL);
				CEPGP_addTraffic("Guild", UnitName("player"), "Add Guild EP +" .. amount, "", "", "", "", "", time());
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
	local mains = {};
	for k, _ in pairs(CEPGP_roster) do
		table.insert(temp, k);
	end
	local i = 0;
	C_Timer.After(0.1, function()
		C_Timer.NewTicker(0.0001, function()
			i = i + 1;
			local name = temp[i];
			local main = CEPGP_getMain(name);
			
			if main then
				for _, v in ipairs(mains) do
					if v == main then
						return;
					end
				end
				
				table.insert(mains, main);
			else
				local index = CEPGP_getIndex(name);
				
				EP, GP = CEPGP_getEPGP(name, index);
				EP = math.max(math.floor(EP + amount), 0);
				GP = math.max(math.floor(GP), CEPGP.GP.Min);
				
				if index then
					if main then
						CEPGP_addAltEPGP(amount, 0, name, main);
					else
						GuildRosterSetOfficerNote(index, EP .. "," .. GP);
						C_Timer.After(1, function()
							CEPGP_syncAltStandings(player);
						end);
					end
				end
			end
			if i == #temp then
				C_Timer.After(2, function()
					for _, name in ipairs(mains) do
						CEPGP_syncAltStandings(name);
					end
				end);
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
	
	local function callback()
		local function update()
			if tonumber(amount) > 0 then
				CEPGP_addTraffic("Guild", UnitName("player"), "Standby EP +" .. amount);
			elseif tonumber(amount) < 0 then
				CEPGP_addTraffic("Guild", UnitName("player"), "Standby EP " .. amount);
			end
			if _G["CEPGP_traffic"]:IsVisible() then
				CEPGP_UpdateTrafficScrollBar();
			end
			if _G["CEPGP_standby_options"]:IsVisible() then
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
		local mains = {};
		
		local roster = {};
		
		for k, v in pairs(CEPGP_raidRoster) do
			roster[k] = "";
		end
		
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
						local main = CEPGP_getMain(name);
						if main then							
							for v, _ in pairs(mains) do
								if v == main then
									return;
								end
							end
							if not roster[main] then
								mains[main] = name;
							end
						else
							local index = CEPGP_getIndex(name);
							local _, rank, rankIndex, _, _, _, _, _, online = GetGuildRosterInfo(index);
							local EP,GP = CEPGP_getEPGP(name, index);
							
							EP = math.max(math.floor(EP + amount), 0);
							GP = math.max(math.floor(GP), CEPGP.GP.Min);
								
							for i = 1, #STANDBYRANKS do
								if STANDBYRANKS[i][1] == rank then
									if STANDBYRANKS[i][2] == true and (online or STANDBYOFFLINE) then
										if main then
											CEPGP_addAltEPGP(amount, 0, name, main);
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
					local main = CEPGP_getMain(name);
					local index = CEPGP_getIndex(name);
					local online = select(9, GetGuildRosterInfo(index));
					
					if online or STANDBYOFFLINE then
						local EP,GP = CEPGP_getEPGP(name, index);
						
						if main then
							for v, _ in pairs(mains) do
								if v == main then
									return;
								end
							end
							if not roster[main] then
								mains[main] = name;
							end
						else
							EP = math.max(math.floor(EP + amount), 0);
							GP = math.max(math.floor(GP), CEPGP.GP.Min);
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
						C_Timer.After(2, function()
							for main, alt in pairs(mains) do
								if #mains[main] == 0 then
									CEPGP_syncAltStandings(main);
								else
									CEPGP_addAltEPGP(amount, 0, alt, main);
								end
							end
						end);
						update();
					end
				end, #CEPGP_standbyRoster);
			end
		end);
	end
	
	if CEPGP_ntgetn(CEPGP_roster) < (GetNumGuildMembers() - CEPGP_Info.NumExcluded) and CEPGP_Info.Polling then
		CEPGP_print("Scanning guild roster. Standby EP will be applied soon.");
		CEPGP_Info.RosterStack["StandbyEP"] = callback;
	else
		callback();
	end
end

function CEPGP_addGP(player, amount, itemID, itemLink, msg, response)
	if amount == nil then
		CEPGP_print("Please enter a valid number", 1);
		return;
	end
	local EP, GP = nil;
	local GPB, GPA;
	
	amount = math.floor(amount);
	if CEPGP_roster[player] then
		local index = CEPGP_getIndex(player);
		local main = CEPGP_getMain(player);
		
		EP, GP = CEPGP_getEPGP(player, index);
		GPB = GP;
		
		GP = math.max(math.floor(GP + amount), CEPGP.GP.Min + amount);
		EP = math.max(math.floor(EP), 0);		
		
		if main then
			CEPGP_addAltEPGP(0, amount, player, main);
			if CEPGP.Alt.BlockAwards then
				if itemID then
					CEPGP_addTraffic(player, UnitName("player"), "Awarded for free (Alt)", nil, nil, nil, nil, itemID);
					return;
				else
					CEPGP_print("Cannot award GP directly to " .. player .. " because they are an alt and you have blocked alt EPGP modifications", true);
					return;
				end
			end
		else
			GuildRosterSetOfficerNote(index, EP .. "," .. GP);
			C_Timer.After(1, function()
				CEPGP_syncAltStandings(player);
			end);
		end
		if not itemID then
			if tonumber(amount) < 0 then -- Number is negative
				amount = string.sub(amount, 2, string.len(amount));
				if msg ~= "" and msg ~= nil then
					CEPGP_sendChatMessage(amount .. " GP taken from " .. player .. " (" .. msg .. ")", CHANNEL);
					CEPGP_addTraffic(player, UnitName("player"), "Subtract GP -" .. amount .. " (" .. msg .. ")", EP, EP, GPB, GP);
				else
					CEPGP_sendChatMessage(amount .. " GP taken from " .. player, CHANNEL);
					CEPGP_addTraffic(player, UnitName("player"), "Subtract GP -" .. amount, EP, EP, GPB, GP);
				end
			else -- Number is positive
				if msg ~= "" and msg ~= nil then
					CEPGP_sendChatMessage(amount .. " GP added to " .. player .. " (" .. msg .. ")", CHANNEL);
					CEPGP_addTraffic(player, UnitName("player"), "Add GP +" .. amount .. " (" .. msg .. ")", EP, EP, GPB, GP);
				else
					CEPGP_sendChatMessage(amount .. " GP added to " .. player, CHANNEL);
					CEPGP_addTraffic(player, UnitName("player"), "Add GP +" .. amount, EP, EP, GPB, GP);
				end
			end
		else -- If an item is associated with the message then the number cannot be negative
			if not itemLink then
				_, itemLink = GetItemInfo(tonumber(itemID));
			end
			if response then
				CEPGP_addTraffic(player, UnitName("player"), "Add GP " .. amount .. " (" .. response .. ")", EP, EP, GPB, GP, itemID);
			else
				CEPGP_addTraffic(player, UnitName("player"), "Add GP " .. amount, EP, EP, GPB, GP, itemID);
			end
		end
		CEPGP_UpdateTrafficScrollBar();
	else
		local index = CEPGP_getIndex(player);
		if index then
			CEPGP_addTraffic(player, UnitName("player"), "Awarded for free (Exclusion List)", nil, nil, nil, nil, itemID);
		else
			CEPGP_print(player .. " not found in guild roster - no GP given");
			CEPGP_print("If this was a mistake, you can manually award them GP via the CEPGP guild menu");
		end
	end
end

function CEPGP_addEP(player, amount, msg)
	if amount == nil then
		CEPGP_print("Please enter a valid number", 1);
		return;
	end
	amount = math.floor(amount);
	local EP, GP, EPB = nil;
	if CEPGP_roster[player] then
		local index = CEPGP_getIndex(player);
		local main = CEPGP_getMain(player);
		
		EP, GP = CEPGP_getEPGP(player, index);
		EPB = EP;
		
		EP = math.max(math.floor(EP + amount), 0);
		GP = math.max(math.floor(GP), CEPGP.GP.Min);
		
		if main then
			if CEPGP.Alt.BlockAwards then
				CEPGP_print("Cannot award EP directly to " .. player .. " because they are an alt and you have blocked alt EPGP modifications", true);
				return;
			end
			CEPGP_addAltEPGP(amount, 0, player, main);
		else
			GuildRosterSetOfficerNote(index, math.floor(EP) .. "," .. GP);
			C_Timer.After(1, function()
				CEPGP_syncAltStandings(player);
			end);
		end
		if tonumber(amount) <= 0 then
			if msg ~= "" and msg ~= nil then
				amount = string.sub(amount, 2, string.len(amount));
				CEPGP_sendChatMessage(amount .. " EP taken from " .. player .. " (" .. msg .. ")", CHANNEL);
				CEPGP_addTraffic(player, UnitName("player"), "Subtract EP -" .. amount .. " (" .. msg .. ")", EPB, EP, GP, GP);
			else
				amount = string.sub(amount, 2, string.len(amount));
				CEPGP_sendChatMessage(amount .. " EP taken from " .. player, CHANNEL);
				CEPGP_addTraffic(player, UnitName("player"), "Subtract EP -" .. amount, EPB, EP, GP, GP);
			end
		else
			if msg ~= "" and msg ~= nil then
				CEPGP_sendChatMessage(amount .. " EP added to " .. player .. " (" .. msg .. ")", CHANNEL);
				CEPGP_addTraffic(player, UnitName("player"), "Add EP +" .. amount .. " (" .. msg ..")", EPB, EP, GP, GP);
			else
				CEPGP_sendChatMessage(amount .. " EP added to " .. player, CHANNEL);
				CEPGP_addTraffic(player, UnitName("player"), "Add EP +" .. amount, EPB, EP, GP, GP);
			end
		end
		CEPGP_UpdateTrafficScrollBar();
	else
		local index = CEPGP_getIndex(player);
		if not index then
			CEPGP_print("Player not found in guild roster.", true);
		end
	end
end

function CEPGP_decay(amount, msg, decayEP, decayGP, fixed)
	if amount == nil then
		CEPGP_print("Please enter a valid number", 1);
		return;
	end
	
	local function callback()
		local function update()
			if tonumber(amount) <= 0 then
				amount = string.sub(amount, 2, string.len(amount));
				if msg ~= "" and msg ~= nil then
					if decayEP then
						CEPGP_sendChatMessage("Guild EP inflated by " .. amount .. (fixed and " " or "% ") .. "(" .. msg .. ")", CHANNEL);
						CEPGP_addTraffic("Guild", UnitName("player"), "Inflated EP +" .. amount .. (fixed and " " or "% ") .. "(" .. msg .. ")");
					elseif decayGP then
						CEPGP_sendChatMessage("Guild GP inflated by " .. amount .. (fixed and " " or "% ") .. "(" .. msg .. ")", CHANNEL);
						CEPGP_addTraffic("Guild", UnitName("player"), "Inflated GP +" .. amount .. (fixed and " " or "% ") .. "(" .. msg .. ")");
					else
						CEPGP_sendChatMessage("Guild EPGP inflated by " .. amount .. (fixed and " " or "% ") .. "(" .. msg .. ")", CHANNEL);
						CEPGP_addTraffic("Guild", UnitName("player"), "Inflated EPGP +" .. amount .. (fixed and " " or "% ") .. "(" .. msg .. ")");
					end
				else
					if decayEP then
						CEPGP_sendChatMessage("Guild EP inflated by " .. amount .. (fixed and "" or "%"), CHANNEL);
						CEPGP_addTraffic("Guild", UnitName("player"), "Inflated EP +" .. amount .. (fixed and "" or "%"));
					elseif decayGP then
						CEPGP_sendChatMessage("Guild GP inflated by " .. amount .. (fixed and "" or "%"), CHANNEL);
						CEPGP_addTraffic("Guild", UnitName("player"), "Inflated GP +" .. amount .. (fixed and "" or "%"));
					else
						CEPGP_sendChatMessage("Guild EPGP inflated by " .. amount .. (fixed and "" or "%"), CHANNEL);
						CEPGP_addTraffic("Guild", UnitName("player"), "Inflated EPGP +" .. amount .. (fixed and "" or "%"));
					end
				end
			else
				if msg ~= "" and msg ~= nil then
					if decayEP then
						CEPGP_sendChatMessage("Guild EP decayed by " .. amount .. (fixed and " " or "% ") .. "(" .. msg .. ")", CHANNEL);
						CEPGP_addTraffic("Guild", UnitName("player"), "Decayed EP -" .. amount .. (fixed and " " or "% ") .. "(" .. msg .. ")");
					elseif decayGP then
						CEPGP_sendChatMessage("Guild GP decayed by " .. amount .. (fixed and " " or "% ") .. "(" .. msg .. ")", CHANNEL);
						CEPGP_addTraffic("Guild", UnitName("player"), "Decayed GP -" .. amount .. (fixed and " " or "% ") .. "(" .. msg .. ")");
					else
						CEPGP_sendChatMessage("Guild EPGP decayed by " .. amount .. (fixed and " " or "% ") .. "(" .. msg .. ")", CHANNEL);
						CEPGP_addTraffic("Guild", UnitName("player"), "Decayed EPGP -" .. amount .. (fixed and " " or "% ") .. "(" .. msg .. ")");
					end
				else
					if decayEP then
						CEPGP_sendChatMessage("Guild EP decayed by " .. amount .. (fixed and "" or "%"), CHANNEL);
						CEPGP_addTraffic("Guild", UnitName("player"), "Decayed EP -" .. amount .. (fixed and "" or "%"));
					elseif decayGP then
						CEPGP_sendChatMessage("Guild GP decayed by " .. amount .. (fixed and "" or "% "), CHANNEL);
						CEPGP_addTraffic("Guild", UnitName("player"), "Decayed GP -" .. amount .. (fixed and "" or "%"));
					else
						CEPGP_sendChatMessage("Guild EPGP decayed by " .. amount .. (fixed and "" or "%"), CHANNEL);
						CEPGP_addTraffic("Guild", UnitName("player"), "Decayed EPGP -" .. amount .. (fixed and "" or "%"));
					end
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
				local index = CEPGP_getIndex(name);
				local rankIndex = select(3, GetGuildRosterInfo(index));
				local main = CEPGP_getMain(name);
				if not CEPGP.Exclusions[rankIndex+1] and not main then
					EP, GP = CEPGP_getEPGP(name, index);
					if decayEP or (not decayEP and not decayGP) then
						if fixed then
							EP = math.max(math.floor(tonumber(EP)-amount), 0);
						else
							EP = math.max(math.floor(tonumber(EP)*(1-(amount/100))), 0);
						end
					end
					if decayGP or (not decayEP and not decayGP) then
						if CEPGP_minGPDecayFactor then
							if fixed then
								GP = math.max(math.floor((tonumber(GP-BASEGP)-amount)+BASEGP), CEPGP.GP.Min);
							else
								GP = math.max(math.floor((tonumber(GP-BASEGP)*(1-(amount/100)))+BASEGP), CEPGP.GP.Min);
							end
						else
							if fixed then
								GP = math.max(math.floor(tonumber(GP)-amount), CEPGP.GP.Min);
							else
								GP = math.max(math.floor((tonumber(GP)*(1-(amount/100)))), CEPGP.GP.Min);
							end
						end
					end
					GuildRosterSetOfficerNote(index, EP .. "," .. GP);
				end
				if i == #temp then
					C_Timer.After(2, function()
						for name, _ in pairs(CEPGP.Alt.Links) do
							CEPGP_syncAltStandings(name);
						end
					end);
					update();
				end
			end, #temp);
		end);
	end
	
	if CEPGP_ntgetn(CEPGP_roster) < (GetNumGuildMembers() - CEPGP_Info.NumExcluded) and CEPGP_Info.Polling then
		CEPGP_print("Scanning guild roster. Decay will be applied soon.");
		CEPGP_Info.RosterStack["Decay"] = callback;
	else
		callback();
	end
end

function CEPGP_resetAll(msg)
	
	local function update()
		if msg ~= "" and msg ~= nil then
			CEPGP_addTraffic("Guild", UnitName("player"), "Cleared EPGP standings (" .. msg .. ")");
			CEPGP_sendChatMessage("All EPGP standings have been cleared! (" .. msg .. ")", CHANNEL);
		else
			CEPGP_addTraffic("Guild", UnitName("player"), "Cleared EPGP standings");
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
			local rankIndex = select(3, GetGuildRosterInfo(i));
			if not CEPGP.Exclusions[rankIndex+1] then
				GuildRosterSetOfficerNote(i, "0,"..BASEGP);
			end
			if i == GetNumGuildMembers() then
				update();
			end
		end, GetNumGuildMembers());
	end);
	
end