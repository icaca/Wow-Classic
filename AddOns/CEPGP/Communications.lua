local L = CEPGP_Locale:GetLocale("CEPGP")

function CEPGP_IncAddonMsg(message, sender, sync)
	local args = CEPGP_split(message, ";"); -- The broken down message, delimited by semi-colons
	
	if args[1] == "message" and args[2] == UnitName("player") then
		CEPGP_print(args[3]);
	end
	
	if args[1] == "CEPGP_setDistID" then
		CEPGP_DistID = args[2];
	
	elseif args[1] == UnitName("player") and args[2] == "distslot" then
		--Recipient should see this
		local slot = args[3];
		if slot then --string.len(slot) > 0 and slot ~= nil then
			local slotName = string.sub(slot, 9);
			local slotid, slotid2 = CEPGP_SlotNameToID(slotName);
			local currentItem;
			local currentItem2;
			local itemID;
			local itemID2;
			
			if slotid then
				currentItem = GetInventoryItemLink("player", slotid);
			end
			if slotid2 then
				currentItem2 = GetInventoryItemLink("player", slotid2);
			end
			
			if currentItem then
				itemID = CEPGP_getItemID(CEPGP_getItemString(currentItem));
			else
				itemID = "noitem";
			end
			
			if currentItem2 then
				itemID2 = CEPGP_getItemID(CEPGP_getItemString(currentItem2));
			else
				itemID2 = "noitem";
			end
			
			if itemID2 then
				CEPGP_SendAddonMsg(sender..";receiving;"..itemID..";"..itemID2);
			else
				CEPGP_SendAddonMsg(sender..";receiving;"..itemID);
			end
			
		elseif slot == "" then
			CEPGP_SendAddonMsg(sender..";receiving;noslot");
		elseif itemID == "noitem" then
			CEPGP_SendAddonMsg(sender..";receiving;noitem");
		end
		
		
	elseif args[2] == "receiving" then
		table.insert(CEPGP_responses, sender);
		local itemID = args[3];
		local itemID2 = args[4];
		local response;
		if CEPGP_itemsTable[sender] then
			response = CEPGP_itemsTable[sender][3];
		end
		if not response and not CEPGP_show_passes then return; end
		CEPGP_itemsTable[sender] = {};
		CEPGP_itemsTable[sender] = {
			[1] = itemID,
			[2] = itemID2,
			[3] = response
		};
		CEPGP_UpdateLootScrollBar(true);
	end
		
	if args[1] == UnitName("player") and args[2] == "versioncheck" then
		local index = CEPGP_ntgetn(CEPGP_groupVersion);
		if not index then index = 0; end
		for i=1, index do
			if CEPGP_groupVersion[i][1] == sender then
				CEPGP_groupVersion[i][2] = args[3];
				if CEPGP_roster[sender] then
					CEPGP_groupVersion[i][3] = CEPGP_roster[sender][2];
				else
					for x = 1, GetNumGroupMembers() do
						if GetRaidRosterInfo(x) == sender then
							_, _, _, _, CEPGP_groupVersion[i][3], CEPGP_groupVersion[i][4] = GetRaidRosterInfo(x);
							break;
						end
					end
				end
				break;
			end
		end
		CEPGP_vInfo[sender] = args[3];
		CEPGP_checkVersion(message);
		CEPGP_UpdateVersionScrollBar();
		
		
	elseif message == "version-check" then
		if not sender then return; end
		CEPGP_updateGuild();
		if CEPGP_roster[sender] then
			CEPGP_SendAddonMsg(sender .. ";versioncheck;" .. CEPGP_Info.Version .. "." .. CEPGP_Info.Build, "GUILD");
		else
			CEPGP_SendAddonMsg(sender .. ";versioncheck;" .. CEPGP_Info.Version .. "." .. CEPGP_Info.Build, "RAID");
		end
	end
		
		
	if strfind(message, "RaidAssistLoot") and sender ~= UnitName("player")	then
		if args[1] == "RaidAssistLootDist" then
			if args[4] == "true" then
				CEPGP_RaidAssistLootDist(args[2], args[3], true);
			else
				CEPGP_RaidAssistLootDist(args[2], args[3], false);
			end
		else
			CEPGP_RaidAssistLootClosed();
		end
		
		
		--Raid assists receiving !need responses in the format of !need;playername;itemID (of item being distributed)
	elseif args[1] == "!need" and sender ~= UnitName("player") then
		local response = tonumber(args[4]);
		if not response then response = 5; end
		if (CEPGP_show_passes and response == 6) or response < 6 then
			CEPGP_itemsTable[args[2]] = {};
			CEPGP_itemsTable[args[2]][3] = response;
			CEPGP_UpdateLootScrollBar(sort);
		end
		
	elseif args[1] == "LootClosed" then
		_G["CEPGP_respond"]:Hide();		
		
	elseif args[1] == "STANDBYEP" and args[2] == UnitName("player") then
		CEPGP_print(args[3]);
		
	elseif args[1] == "StandbyListAdd" and (UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) and sender ~= UnitName("player") then
		for _, t in pairs(CEPGP_standbyRoster) do -- Is the player already in the standby roster?
			if t[1] == args[2] then
				return;
			end
		end
		for _, v in ipairs(CEPGP_raidRoster) do -- Is the player part of your raid group?
			if args[2] == v[1] then
				return;
			end
		end
		if not CEPGP_roster[args[2]] then -- Player might not be part of your guild. This could happen if you're pugging with another guild and they use CEPGP
			return;
		end
		local player, class, rank, rankIndex, EP, GP, classFile = args[2], args[3], args[4], args[5], args[6], args[7], args[8];
		CEPGP_standbyRoster[#CEPGP_standbyRoster+1] = {
			[1] = player,
			[2] = class,
			[3] = rank,
			[4] = rankIndex,
			[5] = EP,
			[6] = GP,
			[7] = math.floor((tonumber(EP)/tonumber(GP))*100)/100,
			[8] = classFile
		};
		CEPGP_UpdateStandbyScrollBar();
		
	elseif args[1] == "StandbyListRemove" and (UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) and sender ~= UnitName("player") then
		for i, v in ipairs(CEPGP_standbyRoster) do
			if v[1] == args[2] then
				table.remove(CEPGP_standbyRoster, i);
			end
			break;
		end
	
	elseif (args[1] == "StandbyRemoved" or args[1] == "StandbyAdded") and args[2] == UnitName("player") then
		CEPGP_print(args[3]);	
		
	elseif args[1] == "!info" and args[2] == UnitName("player") then--strfind(message, "!info"..UnitName("player")) then
		CEPGP_print(args[3]);
		
		
		
		--[[	IMPORTS		]]--
	
	elseif (args[1] == UnitName("player") and args[2] == "import") or (args[1] == "?forceSync" and not args[2]) then
		if time() - CEPGP_Info.LastImport < 2 then
			CEPGP_SendAddonMsg("message;" .. sender .. ";" .. UnitName("player") .. " has received too many import requests. Please try again.", "GUILD");
			return;
		end
		local lane = "GUILD";
		local target = sender;
		if args[1] == "?forceSync" then
			target = "?forceSync";
			CEPGP_print("Synchronising CEPGP settings with Guild members.");
			CEPGP_SendAddonMsg(target..";impresponse;SYNCHRONISING;"..UnitName("player"), lane);
		end
		
		
		
		CEPGP_SendAddonMsg(target..";impresponse;CHANNEL;"..CHANNEL, lane);
		CEPGP_SendAddonMsg(target..";impresponse;CEPGP_lootChannel;"..CEPGP_lootChannel, lane);
		CEPGP_SendAddonMsg(target..";impresponse;CEPGP_min_threshold;"..CEPGP_min_threshold, lane);
		
		
			--	GP Options Page 1	--
		CEPGP_SendAddonMsg(target..";impresponse;MOD;"..MOD, lane);
		CEPGP_SendAddonMsg(target..";impresponse;COEF;"..COEF, lane);
		CEPGP_SendAddonMsg(target..";impresponse;MOD_COEF;"..MOD_COEF, lane);
		CEPGP_SendAddonMsg(target..";impresponse;BASEGP;"..BASEGP, lane);
		CEPGP_SendAddonMsg(target..";impresponse;WHISPERMSG;"..CEPGP_standby_whisper_msg, lane);
		CEPGP_SendAddonMsg(target..";impresponse;KEYWORD;"..CEPGP_keyword, lane);
		if CEPGP_minGPDecayFactor then
			CEPGP_SendAddonMsg(target..";impresponse;BASEGPFACTOR;true", lane);
		else
			CEPGP_SendAddonMsg(target..";impresponse;BASEGPFACTOR;false", lane);
		end
		
			--	Loot GUI Options	--
		if CEPGP_loot_GUI then
			CEPGP_SendAddonMsg(target..";impresponse;CEPGP_loot_GUI;true", lane);
		else
			CEPGP_SendAddonMsg(target..";impresponse;CEPGP_loot_GUI;false", lane);
		end
		for index, v in ipairs(CEPGP_response_buttons) do
			if v[1] then
				CEPGP_SendAddonMsg(target..";impresponse;LOOTGUIBUTTON;"..index..";true;"..v[2]..";"..v[3]);
			else
				CEPGP_SendAddonMsg(target..";impresponse;LOOTGUIBUTTON;"..index..";false;"..v[2]..";"..v[3]);
			end
		end
		CEPGP_SendAddonMsg(target..";impresponse;LOOTGUIBUTTONTIMEOUT;"..CEPGP_response_time);
		
			--	Slot Weights	--
		for k, v in pairs(SLOTWEIGHTS) do
			CEPGP_SendAddonMsg(target..";impresponse;SLOTWEIGHTS;"..k..";"..v, lane);
		end
		if CEPGP_standby_byrank then --Implies result for both byrank and manual standby designation
			CEPGP_SendAddonMsg(target..";impresponse;STANDBYBYRANK;1", lane);
		else
			CEPGP_SendAddonMsg(target..";impresponse;STANDBYBYRANK;0", lane);
		end
		
			--	Standby EP	--		
		if STANDBYEP then
			CEPGP_SendAddonMsg(target..";impresponse;STANDBYEP;1", lane);
		else
			CEPGP_SendAddonMsg(target..";impresponse;STANDBYEP;0", lane);
		end
		if STANDBYOFFLINE then
			CEPGP_SendAddonMsg(target..";impresponse;STANDBYOFFLINE;1", lane);
		else
			CEPGP_SendAddonMsg(target..";impresponse;STANDBYOFFLINE;0", lane);
		end
		if CEPGP_standby_share then
			CEPGP_SendAddonMsg(target..";impresponse;STANDBYSHARE;true", lane);
		else
			CEPGP_SendAddonMsg(target..";impresponse;STANDBYSHARE;false", lane);
		end
		CEPGP_SendAddonMsg(target..";impresponse;STANDBYPERCENT;"..STANDBYPERCENT, lane);
		if CEPGP_standby_accept_whispers then
			CEPGP_SendAddonMsg(target..";impresponse;STANDBYALLOWWHISPERS;1", lane);
		else
			CEPGP_SendAddonMsg(target..";impresponse;STANDBYALLOWWHISPERS;0", lane);
		end
		for k, v in pairs(STANDBYRANKS) do
			if STANDBYRANKS[k][2] then
				CEPGP_SendAddonMsg(target..";impresponse;STANDBYRANKS;"..k..";1", lane);
			else
				CEPGP_SendAddonMsg(target..";impresponse;STANDBYRANKS;"..k..";0", lane);
			end
		end
		
		
			--	Boss EP Settings	--
		for k, v in pairs(EPVALS) do
			CEPGP_SendAddonMsg(target..";impresponse;EPVALS;"..k..";"..v, lane);
		end
		for k, v in pairs(AUTOEP) do
			if AUTOEP[k] then
				CEPGP_SendAddonMsg(target..";impresponse;AUTOEP;"..k..";1", lane);
			else
				CEPGP_SendAddonMsg(target..";impresponse;AUTOEP;"..k..";0", lane);
			end
		end
		for k, v in pairs(OVERRIDE_INDEX) do
			CEPGP_SendAddonMsg(target..";impresponse;OVERRIDE;"..k..";"..v, lane);
		end
		
		
			--	Page 2	--
		if CEPGP_auto_pass then
			CEPGP_SendAddonMsg(target..";impresponse;CEPGP_auto_pass;true", lane);
		else
			CEPGP_SendAddonMsg(target..";impresponse;CEPGP_auto_pass;false", lane);
		end
		if CEPGP_raid_wide_dist then
			CEPGP_SendAddonMsg(target..";impresponse;CEPGP_raid_wide_dist;true", lane);
		else
			CEPGP_SendAddonMsg(target..";impresponse;CEPGP_raid_wide_dist;false", lane);
		end
		if CEPGP_gp_tooltips then
			CEPGP_SendAddonMsg(target..";impresponse;CEPGP_gp_tooltips;true", lane);
		else
			CEPGP_SendAddonMsg(target..";impresponse;CEPGP_gp_tooltips;false", lane)
		end
		if CEPGP_suppress_announcements then
			CEPGP_SendAddonMsg(target..";impresponse;CEPGP_suppress_announcements;true", lane);
		else
			CEPGP_SendAddonMsg(target..";impresponse;CEPGP_suppress_announcements;false", lane)
		end
		
		if CEPGP_minEP[1] then
			CEPGP_SendAddonMsg(target..";impresponse;CEPGP_minEP;true;" .. CEPGP_minEP[2], lane);
		else
			CEPGP_SendAddonMsg(target..";impresponse;CEPGP_minEP;false;" .. CEPGP_minEP[2], lane);	
		end
		
		if CEPGP_show_passes then
			CEPGP_SendAddonMsg(target..";impresponse;CEPGP_show_passes;true", lane);
		else
			CEPGP_SendAddonMsg(target..";impresponse;CEPGP_show_passes;false", lane)
		end
		if CEPGP_PR_sort then
			CEPGP_SendAddonMsg(target..";impresponse;CEPGP_PR_sort;true", lane);
		else
			CEPGP_SendAddonMsg(target..";impresponse;CEPGP_PR_sort;false", lane)
		end
		
		CEPGP_SendAddonMsg(target..";impresponse;COMPLETE;", lane);
		
		CEPGP_Info.LastImport = time();
		
		
		
	elseif (args[1] == UnitName("player") or (args[1] == "?forceSync" and sender ~= UnitName("player"))) and args[2] == "impresponse" then
		if args[1] == "?forceSync" then
			local _, _, _, rIndex = CEPGP_getGuildInfo(sender); --rank index
			if not rIndex then return; end
			if rIndex + 1 > CEPGP_force_sync_rank then --Index obtained by GetGuildRosterInfo starts at 0 whereas GuildControlGetRankName starts at 1 for some reason
				return;
			end
		end
		
		local option = args[3];
		if option == "SYNCHRONISING" then
			CEPGP_print(sender .. " is synchronising your settings with theirs");
		end		
		
		if option == "CEPGP_loot_GUI" then
			if args[4] == "true" then
				CEPGP_loot_GUI = true;
			else
				CEPGP_loot_GUI = false;
			end
		end
		
		if option == "LOOTGUIBUTTON" then
			if args[5] == "true" then
				CEPGP_response_buttons[tonumber(args[4])] = {
					[1] = true,
					[2] = args[6],
					[3] = tonumber(args[7])
				}
			else
				CEPGP_response_buttons[tonumber(args[4])] = {
					[1] = false,
					[2] = args[6],
					[3] = tonumber(args[7])
				}
			end
		end
		
		if option == "CEPGP_minEP" then
			if args[4] == "true" then
				CEPGP_minEP = {true, tonumber(args[5])};
			else
				CEPGP_minEP = {false, tonumber(args[5])};
			end
		end
		
		if option == "LOOTGUIBUTTONTIMEOUT" then
			CEPGP_response_time = tonumber(args[4]);
		end
		
		if option == "SLOTWEIGHTS" or option == "STANDBYRANKS" or option == "EPVALS" or option == "AUTOEP" or option == "OVERRIDE" or option == "STANDBYSHARE" then
			local field = args[4];
			local val = args[5];
			
			if option == "SLOTWEIGHTS" then
				SLOTWEIGHTS[field] = tonumber(val);
			elseif option == "STANDBYRANKS" then
				if val == "1" then
					STANDBYRANKS[tonumber(field)][2] = true;
				else
					STANDBYRANKS[tonumber(field)][2] = false;
				end
			elseif option == "STANDBYSHARE" then
				if val == "true" then
					CEPGP_standby_share = true;
				else
					CEPGP_standby_share = false;
				end
			elseif option == "EPVALS" then
				EPVALS[field] = tonumber(val);
			elseif option == "AUTOEP" then
				if val == "1" then
					AUTOEP[field] = true;
				else
					AUTOEP[field] = false;
				end
			elseif option == "OVERRIDE" then
				if not CEPGP_inOverride(field) then
					OVERRIDE_INDEX[field] = val;
				end
			end
		else
			local val = args[4];
			if option == "CHANNEL" then
				CHANNEL = val;
			elseif option == "CEPGP_lootChannel" then
				CEPGP_lootChannel = val;
			elseif option == "KEYWORD" then
				CEPGP_keyword = val;
			elseif option == "MOD" then
				MOD = tonumber(val);
			elseif option == "COEF" then
				COEF = tonumber(val);
			elseif option == "MOD_COEF" then
				MOD_COEF = tonumber(val);
			elseif option == "BASEGP" then
				BASEGP = tonumber(val);
			elseif option == "CEPGP_min_threshold" then
				CEPGP_min_threshold = tonumber(val);
			elseif option == "BASEGPFACTOR" then
				if val == "true" then
					CEPGP_minGPDecayFactor = true;
				else
					CEPGP_minGPDecayFactor = false;
				end
			elseif option == "STANDBYBYRANK" then
				if val == "1" then
					CEPGP_standby_byrank = true;
					CEPGP_standby_manual = false;
				else
					CEPGP_standby_byrank = false;
					CEPGP_standby_manual = true;
				end
			elseif option == "STANDBYALLOWWHISPERS" then
				if val == "1" then
					CEPGP_standby_accept_whispers = true;
					CEPGP_options_standby_ep_accept_whispers_check:SetChecked(true);
				else
					CEPGP_standby_accept_whispers = false;
					CEPGP_options_standby_ep_accept_whispers_check:SetChecked(false);
				end
			elseif option == "WHISPERMSG" then
				CEPGP_standby_whisper_msg = val;
				CEPGP_options_standby_ep_message_val:SetText(val);
			elseif option == "STANDBYEP" then
				if tonumber(val) == 1 then
					STANDBYEP = true;
				else
					STANDBYEP = false;
				end
			elseif option == "STANDBYOFFLINE" then
				if tonumber(val) == 1 then
					STANDBYOFFLINE = true;
				else
					STANDBYOFFLINE = false;
				end
			elseif option == "STANDBYPERCENT" then
				STANDBYPERCENT = tonumber(val);
				
			elseif option == "CEPGP_auto_pass" then
			if args[4] == "true" then
				CEPGP_auto_pass = true;
			else
				CEPGP_auto_pass = false;
			end
		
			elseif option == "CEPGP_raid_wide_dist" then
				if args[4] == "true" then
					CEPGP_raid_wide_dist = true;
				else
					CEPGP_raid_wide_dist = false;
				end
			
			elseif option == "CEPGP_gp_tooltips" then
				if args[4] == "true" then
					CEPGP_gp_tooltips = true;
				else
					CEPGP_gp_tooltips = false;
				end
			
			elseif option == "CEPGP_suppress_announcements" then
				if args[4] == "true" then
					CEPGP_suppress_announcements = true;
				else
					CEPGP_suppress_announcements = false;
				end
			
			elseif option == "CEPGP_show_passes" then
				if args[4] == "true" then
					CEPGP_show_passes = true;
				else
					CEPGP_show_passes = false;
				end
			
			elseif option == "CEPGP_PR_sort" then
				if args[4] == "true" then
					CEPGP_PR_sort = true;
				else
					CEPGP_PR_sort = false;
				end
				
			elseif option == "COMPLETE" then
				CEPGP_print("Import complete");
				CEPGP_button_options_OnClick();
			end
		end
		
		CEPGP_button_options_OnClick();
		
	elseif args[1] == "?IgnoreUpdates" and sender ~= UnitName("player") then
		if args[2] == "true" then
			CEPGP_Info.IgnoreUpdates = true;
		else
			CEPGP_Info.IgnoreUpdates = false;
			CEPGP_rosterUpdate("GUILD_ROSTER_UPDATE");
		end
	
	elseif args[1] == "CallItem" and sender ~= UnitName("player") then
		local id = args[2];
		local gp = args[3];
		local buttons = {args[4], args[5], args[6], args[7]};
		local timeout = args[8];
		CEPGP_callItem(id, gp, buttons, timeout);
		
	elseif strfind(message, "MainSpec") or args[1] == "LootRsp" then
		local response = args[2];
		CEPGP_handleComms("CHAT_MSG_WHISPER", CEPGP_keyword, sender, response);	
	
	elseif args[1] == "CEPGP_TRAFFIC" then
		if string.find(sender, "-") then
			sender = string.sub(sender, 0, string.find(sender, "-")-1);
		end
		if (sender == UnitName("player") or sender ~= args[3]) and not sync then return; end
		local player = args[2];
		local issuer = args[3];
		local action = args[4];
		local EPB = args[5];
		local EPA = args[6];
		local GPB = args[7];
		local GPA = args[8];
		local itemID = args[9];
		if itemID == "" then itemID = 0; end
		local tStamp = args[10];
		if not tStamp or tStamp == "" then
			tStamp = time();
		end
		if CEPGP_itemExists(tonumber(itemID)) then
			local itemLink = CEPGP_getItemLink(itemID);
			if not itemLink then
				local item = Item:CreateFromItemID(tonumber(itemID));
				item:ContinueOnItemLoad(function()
					itemLink = CEPGP_getItemLink(itemID);
					TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {
					[1] = player,
					[2] = issuer,
					[3] = action,
					[4] = EPB,
					[5] = EPA,
					[6] = GPB,
					[7] = GPA,
					[8] = itemLink,
					[9] = tStamp
				};
				end);
			elseif itemLink then
				TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {
					[1] = player,
					[2] = issuer,
					[3] = action,
					[4] = EPB,
					[5] = EPA,
					[6] = GPB,
					[7] = GPA,
					[8] = itemLink,
					[9] = tStamp
				};
			end
		else
			TRAFFIC[CEPGP_ntgetn(TRAFFIC)+1] = {
				[1] = player,
				[2] = issuer,
				[3] = action,
				[4] = EPB,
				[5] = EPA,
				[6] = GPB,
				[7] = GPA,
				[9] = tStamp
			};
		end
		CEPGP_UpdateTrafficScrollBar();
	end
end

function CEPGP_SendAddonMsg(message, channel)
	if channel == "GUILD" and IsInGuild() then
		C_ChatInfo.SendAddonMessage("CEPGP", message, "GUILD");
	elseif (channel == "RAID" or not channel) and IsInRaid("player") then --Player is in a raid group
		C_ChatInfo.SendAddonMessage("CEPGP", message, "RAID");
	elseif GetNumGroupMembers() > 0 and not IsInRaid("player") then --Player is in a party but not a raid
		C_ChatInfo.SendAddonMessage("CEPGP", message, "PARTY");
	elseif IsInGuild() then --If channel is not specified then assume guild
		C_ChatInfo.SendAddonMessage("CEPGP", message, "GUILD");
	end
end

function CEPGP_ShareTraffic(player, issuer, action, EPB, EPA, GPB, GPA, itemID, tStamp)
	if not player or not action then return; end
	if not itemID then
		itemID = "";
	end
	if not issuer then
		issuer = "";
	end
	if not EPB then
		EPB = "";
	end
	if not EPA then
		EPA = "";
	end
	if not GPB then
		GPB = "";
	end
	if not GPA then
		GPA = "";
	end
	if not tstamp then
		tStamp = time();
	end
	if CanEditOfficerNote() then
		CEPGP_SendAddonMsg("CEPGP_TRAFFIC;" .. player .. ";" .. issuer .. ";" .. action .. ";" .. EPB .. ";" .. EPA .. ";" .. GPB .. ";" .. GPA .. ";" .. itemID .. ";" .. tStamp, "GUILD");
	end
end