local L = CEPGP_Locale:GetLocale("CEPGP")

function CEPGP_IncAddonMsg(message, sender)
	local args = CEPGP_split(message, ";"); -- The broken down message, delimited by semi-colons
	if sender == UnitName("player") then
		for index, msg in pairs(CEPGP_Info.MessageStack) do
			if message == msg[1] then
				CEPGP_Info.MessageStack[index] = nil;
			end
		end
	end
	
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
		local response, roll;
		if CEPGP_itemsTable[sender] then
			response = CEPGP_itemsTable[sender][3];
			roll = CEPGP_itemsTable[sender][4];
		end
		if not response and not CEPGP_show_passes then return; end
		CEPGP_itemsTable[sender] = {};
		CEPGP_itemsTable[sender] = {
			[1] = itemID,
			[2] = itemID2,
			[3] = response,
			[4] = roll
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
	elseif args[1] == "!need" then
		if args[2] == UnitName("player") then
			CEPGP_respond:Hide();
		else
			local player = args2;
			local response = tonumber(args[4]) or CEPGP_getResponse(args[4]);
			local roll = args[5];
			if (response and (not tonumber(response)) or tonumber(response) > 6) or (CEPGP_show_passes and response == 6) or response < 6 then
				CEPGP_itemsTable[args[2]] = {};
				CEPGP_itemsTable[args[2]][3] = response;
				if roll then
					CEPGP_itemsTable[args[2]][4] = roll;
				end
				CEPGP_UpdateLootScrollBar(sort);
			end
		end
		
	elseif args[1] == "LootClosed" then
		_G["CEPGP_distribute"]:Hide();		
		_G["CEPGP_button_loot_dist"]:Hide();
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
			[7] = math.floor((tonumber(EP)*100/tonumber(GP)))/100,
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
	
	elseif (args[1] == UnitName("player") and args[2] == "import") or (args[1] == "?forceSync" and not args[2] and sender == UnitName("player")) then
		if CEPGP_Info.SyncInProgress then
			if args[1] == "?forceSync" then
				CEPGP_print("Already exporting sending settings. Please wait until the previous request has completed and try again.", true);
			else
				CEPGP_SendAddonMsg("message;" .. sender .. ";" .. UnitName("player") .. " has received too many import requests. Please wait and then try again.", "GUILD");
			end
			return;
		end
		CEPGP_Info.SyncInProgress = true;
		local lane = "GUILD";
		local target = sender;
		CEPGP_print(sender .. " is importing settings from you");
		local success, failMsg = pcall(function()
			if args[1] == "?forceSync" then
				target = "?forceSync";
				CEPGP_print("Synchronising CEPGP settings with Guild members.");
				CEPGP_SendAddonMsg(target..";impresponse;SYNCHRONISING;"..UnitName("player"), lane);
			end
			
			
			
			CEPGP_SendAddonMsg(target..";impresponse;Reporting;", lane);
			CEPGP_SendAddonMsg(target..";impresponse;CHANNEL;"..CHANNEL, lane);
			CEPGP_SendAddonMsg(target..";impresponse;CEPGP_lootChannel;"..CEPGP_lootChannel, lane);
			CEPGP_SendAddonMsg(target..";impresponse;CEPGP_min_threshold;"..CEPGP_min_threshold, lane);
			CEPGP_SendAddonMsg(target..";impresponse;Done;", lane);
			
			
			
				--	GP Options Page 1	--
			CEPGP_SendAddonMsg(target..";impresponse;GP;", lane);	
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
			CEPGP_SendAddonMsg(target..";impresponse;Done;", lane);
			
			C_Timer.After(1, function()
					--	Loot GUI Options	--
				CEPGP_SendAddonMsg(target..";impresponse;GUI;", lane);
				for i = 1, 4 do
					local v = CEPGP_response_buttons[i];
					if v[1] then
						CEPGP_SendAddonMsg(target..";impresponse;LOOTGUIBUTTON;"..i..";true;"..v[2]..";"..v[3]..";"..v[4]);
					else
						CEPGP_SendAddonMsg(target..";impresponse;LOOTGUIBUTTON;"..i..";false;"..v[2]..";"..v[3]..";"..v[4]);
					end
				end
				CEPGP_SendAddonMsg(target..";impresponse;LOOTGUIBUTTONTIMEOUT;"..CEPGP_response_time);
				if CEPGP.Loot.HideKeyphrases then
					CEPGP_SendAddonMsg(target..";impresponse;LOOTHIDEKEYPHRASES;true");
				else
					CEPGP_SendAddonMsg(target..";impresponse;LOOTHIDEKEYPHRASES;false");
				end
				CEPGP_SendAddonMsg(target..";impresponse;LootAnnounce;"..CEPGP.Loot.Announcement);
				if CEPGP.Loot.PassRolls then
					CEPGP_SendAddonMsg(target..";impresponse;PassRoll;true");
				else
					CEPGP_SendAddonMsg(target..";impresponse;PassRoll;true");
				end
				if CEPGP.Loot.RollAnnounce then
					CEPGP_SendAddonMsg(target..";impresponse;RollAnnounce;true");
				else
					CEPGP_SendAddonMsg(target..";impresponse;RollAnnounce;false");
				end
				
				CEPGP_SendAddonMsg(target..";impresponse;Done;", lane);
				
				C_Timer.After(1, function()
						--	Slot Weights	--
					CEPGP_SendAddonMsg(target..";impresponse;SlotWeights;", lane);
					for k, v in pairs(SLOTWEIGHTS) do
						CEPGP_SendAddonMsg(target..";impresponse;SLOTWEIGHTS;"..k..";"..v, lane);
					end
					CEPGP_SendAddonMsg(target..";impresponse;Done;", lane);
					C_Timer.After(1, function()
						CEPGP_SendAddonMsg(target..";impresponse;Alts;", lane);
						for k, v in pairs(CEPGP.Alt.Links) do
							for i = 1, #v do
								CEPGP_SendAddonMsg(target..";impresponse;altLinks;" .. k .. ";" .. v[i], lane);
							end
						end
						local block = CEPGP.Alt.BlockAwards and "true" or "false";
						local ep = CEPGP.Alt.SyncEP and "true" or "false";
						local gp = CEPGP.Alt.SyncGP and "true" or "false";
						
						CEPGP_SendAddonMsg(target..";impresponse;altSync;block;" .. block, lane);
						CEPGP_SendAddonMsg(target..";impresponse;altSync;ep;" .. ep, lane);
						CEPGP_SendAddonMsg(target..";impresponse;altSync;gp;" .. gp, lane);
						CEPGP_SendAddonMsg(target..";impresponse;Done;", lane);
						
						C_Timer.After(1, function()
								--	Standby EP	--
							CEPGP_SendAddonMsg(target..";impresponse;Standby;", lane);
							if CEPGP_standby_byrank then --Implies result for both byrank and manual standby designation
								CEPGP_SendAddonMsg(target..";impresponse;STANDBYBYRANK;1", lane);
							else
								CEPGP_SendAddonMsg(target..";impresponse;STANDBYBYRANK;0", lane);
							end
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
							CEPGP_SendAddonMsg(target..";impresponse;Done;", lane);
				
							C_Timer.After(1, function()
									--	Boss EP Settings	--
								CEPGP_SendAddonMsg(target..";impresponse;EP;", lane);
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
								CEPGP_SendAddonMsg(target..";impresponse;Done;", lane);
								
								
								C_Timer.After(1, function()
									CEPGP_SendAddonMsg(target..";impresponse;Overrides;", lane);
									local temp = {};
									for k, v in pairs(OVERRIDE_INDEX) do
										temp[#temp+1] = {k, v};
									end
									
									local i = 0;
									C_Timer.NewTicker(0.01, function()
										i = i + 1;
										if #temp > 0 then
											CEPGP_SendAddonMsg(target..";impresponse;OVERRIDE;"..temp[i][1]..";"..temp[i][2], lane);
										end
										
										if i >= #temp then
											CEPGP_SendAddonMsg(target..";impresponse;Done;", lane);
											C_Timer.After(1, function()
													--	Page 2	--
												CEPGP_SendAddonMsg(target..";impresponse;Excl;", lane);	
												for i = 1, 10 do
													if CEPGP.Exclusions[i] then
														CEPGP_SendAddonMsg(target..";impresponse;Exclusions;"..i..";1", lane);
													else
														CEPGP_SendAddonMsg(target..";impresponse;Exclusions;"..i..";0", lane);
													end
												end
												CEPGP_SendAddonMsg(target..";impresponse;Done;", lane);
												CEPGP_SendAddonMsg(target..";impresponse;Misc;", lane);
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
												CEPGP_SendAddonMsg(target..";impresponse;Done;", lane);
												
												CEPGP_SendAddonMsg(target..";impresponse;COMPLETE;", lane);
												
												if target == "?forceSync" then
													CEPGP_print("Guild Synchronisation complete!");
												else
													CEPGP_print("Settings finished sending to " .. target);
												end
												
												CEPGP_Info.LastImport = time();
												CEPGP_Info.SyncInProgress = false;
											end);										
										end
									end, #temp);
								end);
							end);
						end);
					end);
				end);
			end);
		end);
	
	if not success then
		CEPGP_print("Failed to complete import request from " .. target .. "!", true);
		CEPGP_print(failMsg, true);
	end
		
		
		
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
		
		if CEPGP_Info.VerboseLogging then
			if option == "Reporting" then
				CEPGP_print("Importing reporting channels..");
			end
			if option == "GP" then
				CEPGP_print("Importing GP configuration..");
			end
			if option == "SlotWeights" then
				CEPGP_print("Importing slot weights..");
			end
			if option == "GUI" then
				CEPGP_print("Importing loot GUI configuration..");
			end
			if option == "Alts" then
				CEPGP_print("Import alt settings..");
			end
			if option == "Standby" then
				CEPGP_print("Importing standby settings..");
			end
			if option == "Excl" then
				CEPGP_print("Importing rank exclusions..");
			end
			if option == "Misc" then
				CEPGP_print("Importing miscellaneous settings..");
			end
			if option == "EP" then
				CEPGP_print("Importing boss EP settings..");
			end
			if option == "Overrides" then
				CEPGP_print("Importing overrides..");
			end
			if option == "Done" then
				CEPGP_print("Done.");
			end
		end
		
		if option == "Overrides" then
			OVERRIDE_INDEX = {};
			CEPGP.Overrides = {};
		end
		if option == "Alts" then
			CEPGP.Alt.Links = {};
		end
		
		if option == "LOOTGUIBUTTON" then
			if not args[8] then args[8] = args[4] == "1" and "Need" or args[4] == "2" and "Greed" or args[4] == "3" and "Minor Upgrade" or args[4] == "4" and "Offspec"; end
			if args[5] == "true" then
				CEPGP_response_buttons[tonumber(args[4])] = {
					[1] = true,
					[2] = args[6],
					[3] = tonumber(args[7]),
					[4] = args[8]
				}
			else
				CEPGP_response_buttons[tonumber(args[4])] = {
					[1] = false,
					[2] = args[6],
					[3] = tonumber(args[7]),
					[4] = args[8]
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
		
		if option == "LOOTHIDEKEYPHRASES" then
			CEPGP.Loot.HideKeyphrases = args[4] == "true";
		end
		
		if option == "SLOTWEIGHTS" or option == "STANDBYRANKS" or option == "EPVALS" or option == "AUTOEP" or option == "OVERRIDE" or option == "STANDBYSHARE" or option == "altLinks" or option == "altSync" then
			local field = args[4];
			local val = args[5];
			
			if option == "SLOTWEIGHTS" then
				SLOTWEIGHTS[field] = tonumber(val);
			elseif option == "altLinks" then
				if not CEPGP.Alt.Links[field] then CEPGP.Alt.Links[field] = {}; end
				table.insert(CEPGP.Alt.Links[field], val);
				--CEPGP.Alt.Links[field] = val;
			elseif option == "altSync" then
				if field == "block" then
					CEPGP.Alt.BlockAwards = val == "true" and true or false;
				elseif field == "ep" then
					CEPGP.Alt.SyncEP = val == "true" and true or false;
				elseif field == "gp" then
					CEPGP.Alt.SyncGP = val == "true" and true or false;
				end
			elseif option == "STANDBYRANKS" then
				if val == "1" then
					STANDBYRANKS[tonumber(field)][2] = true;
				else
					STANDBYRANKS[tonumber(field)][2] = false;
				end
			elseif option == "Exclusions" then
				if val == "1" then
					CEPGP.Exclusions[tonumber(field)] = true;
				else
					CEPGP.Exclusions[tonumber(field)] = false;
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
				local item = field;
				local iString = CEPGP_getItemString(item);
				if not iString then iString = item; end
				if string.find(iString, "item:") then
					local id = CEPGP_getItemID(iString);
					local link = CEPGP_getItemLink(id);
					local name = GetItemInfo(id);
					
					if name then
						if link then
							OVERRIDE_INDEX[link] = val;
							CEPGP.Overrides[link] = val;
						end
						
						if OVERRIDE_INDEX[name] then
							OVERRIDE_INDEX[name] = nil;
						end
						
						if CEPGP.Overrides[name] then
							CEPGP.Overrides[name] = nil;
						end
					else
						local item = Item:CreateFromItemID(tonumber(id));
						item:ContinueOnItemLoad(function()
							link = CEPGP_getItemLink(id);
							name = GetItemInfo(id);
							if link then
								OVERRIDE_INDEX[link] = val;
								CEPGP.Overrides[link] = val;
							end
							
							if OVERRIDE_INDEX[name] then
								OVERRIDE_INDEX[name] = nil;
							end
							
							if CEPGP.Overrides[name] then
								CEPGP.Overrides[name] = nil;
							end							
						end);
					end
					
				else
					OVERRIDE_INDEX[item] = val;
					CEPGP.Overrides[item] = val;
				end
			end
		else
			local val = args[4];
			if option == "CHANNEL" then
				CHANNEL = val;
				CEPGP.Channel = val;
			elseif option == "CEPGP_lootChannel" then
				CEPGP_lootChannel = val;
				CEPGP.LootChannel = val;
			elseif option == "KEYWORD" then
				CEPGP_keyword = val;
				CEPGP.Loot.Keyword = val;
			elseif option == "MOD" then
				MOD = tonumber(val);
				CEPGP.GP.Mod = tonumber(val);
			elseif option == "COEF" then
				COEF = tonumber(val);
				CEPGP.GP.Base = tonumber(val);
			elseif option == "MOD_COEF" then
				MOD_COEF = tonumber(val);
				CEPGP.GP.Multiplier = tonumber(val);
			elseif option == "BASEGP" then
				BASEGP = tonumber(val);
				CEPGP.GP.Min = tonumber(val);
			elseif option == "CEPGP_min_threshold" then
				CEPGP_min_threshold = tonumber(val);
				CEPGP.Loot.MinThreshold = tonumber(val);
			elseif option == "BASEGPFACTOR" then
				if val == "true" then
					CEPGP_minGPDecayFactor = true;
					CEPGP.GP.DecayFactor = true;
				else
					CEPGP_minGPDecayFactor = false;
					CEPGP.GP.DecayFactor = false;
				end
			elseif option == "STANDBYBYRANK" then
				if val == "1" then
					CEPGP_standby_byrank = true;
					CEPGP_standby_manual = false;
					CEPGP.Standby.ByRank = true;
					CEPGP.Standby.Manual = false;
				else
					CEPGP_standby_byrank = false;
					CEPGP_standby_manual = true;
					CEPGP.Standby.ByRank = false;
					CEPGP.Standby.Manual = true;
				end
				
			elseif option == "STANDBYALLOWWHISPERS" then
				if val == "1" then
					CEPGP_standby_accept_whispers = true;
					CEPGP.Standby.AcceptWhispers = true;
				else
					CEPGP_standby_accept_whispers = false;
					CEPGP.Standby.AcceptWhispers = false;
				end
				
			elseif option == "WHISPERMSG" then
				CEPGP_standby_whisper_msg = val;
				CEPGP.Standby.Keyword = val;
				
			elseif option == "STANDBYEP" then
				if tonumber(val) == 1 then
					STANDBYEP = true;
					CEPGP.Standby.Enabled = true;
				else
					STANDBYEP = false;
					CEPGP.Standby.Enabled = false;
				end
				
			elseif option == "STANDBYOFFLINE" then
				if tonumber(val) == 1 then
					STANDBYOFFLINE = true;
					CEPGP.Standby.Offline = true;
				else
					STANDBYOFFLINE = false;
					CEPGP.Standby.Offline = false;
				end
				
			elseif option == "STANDBYPERCENT" then
				STANDBYPERCENT = tonumber(val);
				CEPGP.Standby.Percent = tonumber(val);
				
			elseif option == "CEPGP_auto_pass" then
			if args[4] == "true" then
				CEPGP_auto_pass = true;
				CEPGP.Loot.AutoPass = true;
			else
				CEPGP_auto_pass = false;
				CEPGP.Loot.AutoPass = false;
			end
		
			elseif option == "CEPGP_raid_wide_dist" then
				if args[4] == "true" then
					CEPGP_raid_wide_dist = true;
					CEPGP.Loot.RaidVisibility = true;
				else
					CEPGP_raid_wide_dist = false;
					CEPGP.Loot.RaidVisibility = false;
				end
			
			elseif option == "CEPGP_suppress_announcements" then
				if args[4] == "true" then
					CEPGP_suppress_announcements = true;
					CEPGP.Loot.SuppressResponses = true;
				else
					CEPGP_suppress_announcements = false;
					CEPGP.Loot.SuppressResponses = false;
				end
			
			elseif option == "CEPGP_show_passes" then
				if args[4] == "true" then
					CEPGP_show_passes = true;
					CEPGP.Loot.ShowPass = true;
				else
					CEPGP_show_passes = false;
					CEPGP.Loot.ShowPass = false;
				end
			
			elseif option == "CEPGP_PR_sort" then
				if args[4] == "true" then
					CEPGP_PR_sort = true;
					CEPGP.Loot.AutoSort = true;
				else
					CEPGP_PR_sort = false;
					CEPGP.Loot.AutoSort = false;
				end
			
			elseif option == "LootAnnounce" then
				CEPGP.Loot.Announcement = args[4];
			
			elseif option == "PassRoll" then
				if args[4] == "true" then
					CEPGP.Loot.PassRolls = true;
				else
					CEPGP.Loot.PassRolls = false;
				end
			
			elseif option == "RollAnnounce" then
				if args[4] == "true" then
					CEPGP.Loot.RollAnnounce = true;
				else
					CEPGP.Loot.RollAnnounce = false;
				end
			
			
			elseif option == "COMPLETE" then
				CEPGP_print("Import complete");
				CEPGP_Info.VerboseLogging = false;
			end
		end
		
		
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
		CEPGP_handleComms("CHAT_MSG_WHISPER", nil, sender, response);	
	
	elseif args[1] == "CEPGP_TRAFFICSyncStart" and sender ~= UnitName("player") then
		CEPGP_Info.SharingTraffic = true;
		CEPGP_traffic_share:Disable();
		CEPGP_print(sender .. " is sharing their traffic log with you. This process will start in 10 seconds");
		CEPGP_traffic_share_status:SetText("Preparing to receive traffic entries");
		CEPGP_Info.TrafficImport = {};
	
	elseif args[1] == "CEPGP_TRAFFICSyncStop" and sender ~= UnitName("player") and CEPGP_Info.SharingTraffic then
		local success, failMsg = pcall(function()
			CEPGP_print(#CEPGP_Info.TrafficImport .. " Traffic Entries Received. Processing..");
			local sigs = {}; 	--	signatures
			for _, v in ipairs(TRAFFIC) do
				if v[9] and v[10] and v[11] then
					if not sigs[v[10]] then
						sigs[v[10]] = {[1] = v[11]};
					else
						table.insert(sigs[10], v[11]);
					end
				end
			end
			local limit = #CEPGP_Info.TrafficImport;
			local logs = CEPGP_Info.TrafficImport;
			local count = 1;
			local index;
			
			C_Timer.NewTicker(0.1, function()
				local entry = logs[count];
				local newEntry = {};
				local tStamp = tonumber(entry[9]);
				local id = tonumber(entry[10]);
				local GUID = entry[11];
				
				if sigs[entry[10]] then
					for k, v in ipairs(sigs[entry[10]]) do
						if v == GUID then
							count = count + 1;
							CEPGP_traffic_share_status:SetText("Processed " .. count .. " of " .. limit .. " entries");
							return;
						end
					end
				end
				
				for i = #TRAFFIC, 1, -1 do
					if TRAFFIC[i][9] and TRAFFIC[i][10] and TRAFFIC[i][11] then
						if i > 1 then
							if TRAFFIC[i-1][9] then
								if tStamp < tonumber(TRAFFIC[i][9]) and tStamp > tonumber(TRAFFIC[i-1][9]) then
									index = i;
									break;
								elseif tStamp > tonumber(TRAFFIC[i][9]) then
									index = i+1;
									break;
								end
							else
								if tStamp > tonumber(TRAFFIC[i][9]) then
									index = i;
									break;
								end
							end
						else
							if tStamp < tonumber(TRAFFIC[i][9]) then
								index = 1;
								break;
							end
						end
					end
				end
				
				local player = entry[1];
				local issuer = entry[2];
				local action = entry[3];
				local EPB = entry[4];
				local EPA = entry[5];
				local GPB = entry[6];
				local GPA = entry[7];
				local itemID = tonumber(entry[8]);
				
				if CEPGP_itemExists(tonumber(itemID)) then
					local itemLink = CEPGP_getItemLink(itemID);
					if not itemLink then
						local item = Item:CreateFromItemID(tonumber(itemID));
						item:ContinueOnItemLoad(function()
							itemLink = CEPGP_getItemLink(itemID);
							newEntry = {
								[1] = player,
								[2] = issuer,
								[3] = action,
								[4] = EPB,
								[5] = EPA,
								[6] = GPB,
								[7] = GPA,
								[8] = itemLink,
								[9] = tStamp,
								[10] = id,
								[11] = GUID
							};
							if not index and #TRAFFIC == 0 then
								table.insert(TRAFFIC, 1, newEntry);
								if not sigs[newEntry[10]] then
									sigs[newEntry[10]] = {[1] = newEntry[11]};
								else
									table.insert(sigs[10], newEntry[11]);
								end
							elseif index then
								table.insert(TRAFFIC, index, newEntry);
								if not sigs[newEntry[10]] then
									sigs[newEntry[10]] = {[1] = newEntry[11]};
								else
									table.insert(sigs[10], newEntry[11]);
								end
							end
						end);
					elseif itemLink then
						newEntry = {
							[1] = player,
							[2] = issuer,
							[3] = action,
							[4] = EPB,
							[5] = EPA,
							[6] = GPB,
							[7] = GPA,
							[8] = itemLink,
							[9] = tStamp,
							[10] = id,
							[11] = GUID
						};
						if not index and #TRAFFIC == 0 then
							table.insert(TRAFFIC, 1, newEntry);
							if not sigs[newEntry[10]] then
								sigs[newEntry[10]] = {[1] = newEntry[11]};
							else
								table.insert(sigs[10], newEntry[11]);
							end
						elseif index then
							table.insert(TRAFFIC, index, newEntry);
							if not sigs[newEntry[10]] then
								sigs[newEntry[10]] = {[1] = newEntry[11]};
							else
								table.insert(sigs[10], newEntry[11]);
							end
						end
					end
				else
					newEntry = {
						[1] = player,
						[2] = issuer,
						[3] = action,
						[4] = EPB,
						[5] = EPA,
						[6] = GPB,
						[7] = GPA,
						[8] = "",
						[9] = tStamp,
						[10] = id,
						[11] = GUID
					};
					if not index and #TRAFFIC == 0 then
						table.insert(TRAFFIC, 1, newEntry);
						if not sigs[newEntry[10]] then
							sigs[newEntry[10]] = {[1] = newEntry[11]};
						else
							table.insert(sigs[10], newEntry[11]);
						end
					elseif index then
						table.insert(TRAFFIC, index, newEntry);
						if not sigs[newEntry[10]] then
							sigs[newEntry[10]] = {[1] = newEntry[11]};
						else
							table.insert(sigs[10], newEntry[11]);
						end
					end
				end
				CEPGP_traffic_share_status:SetText("Processed " .. count .. " of " .. limit .. " entries");
				if count >= limit then
					CEPGP_Info.SharingTraffic = false;
					CEPGP_traffic_share_status:SetText("Finished processing traffic entries");
					CEPGP_print("Traffic import has completed");
					CEPGP_traffic_share:Enable();
					CEPGP_UpdateTrafficScrollBar();
					CEPGP_Info.TrafficImport = {};
				end
				
				count = count + 1;
			end, limit);
		end);
		
		if not success then
			CEPGP_print("Failed to process imported traffic entries", true);
			CEPGP_print(failMsg);
		end
	
	elseif args[1] == "CEPGP_TRAFFIC" and sender ~= UnitName("player") then
		local success, failMsg = pcall(function()
			local player = args[2];
			local issuer = args[3];
			local action = args[4];
			local EPB = args[5];
			local EPA = args[6];
			local GPB = args[7];
			local GPA = args[8];
			local itemID = tonumber(args[9]);
			local tStamp = tonumber(args[10]);
			local id = tonumber(args[11]);
			local GUID = args[12];
			
			local index;
			local entry = {};
			
			if tonumber(id) <= tStamp then return; end	--	Protects against malformed entries. Some have been seen where tStamp is on 9 and 10, invalidating the ID
			
			if not CEPGP_Info.SharingTraffic then
				for i = #TRAFFIC, 1, -1 do
					if TRAFFIC[i][10] and TRAFFIC[i][11] then
						if TRAFFIC[i][10] == id and TRAFFIC[i][11] == GUID then return; end
						if i > 1 then
							if TRAFFIC[i-1][9] then
								if tStamp < tonumber(TRAFFIC[i][9]) and tStamp > tonumber(TRAFFIC[i-1][9]) then
									index = i;
									break;
								elseif tStamp > tonumber(TRAFFIC[i][9]) then
									index = i+1;
									break;
								end
							else
								if tStamp > tonumber(TRAFFIC[i][9]) then
									index = i;
									break;
								end
							end
						else
							if tStamp < tonumber(TRAFFIC[i][9]) then
								index = 1;
								break;
							end
						end
					end
				end
			end
			
			if not index then index = #TRAFFIC > 0 and #TRAFFIC or 1; end
			
			if itemID == "" then itemID = 0; end
			
			entry = {
				[1] = player,
				[2] = issuer,
				[3] = action,
				[4] = EPB,
				[5] = EPA,
				[6] = GPB,
				[7] = GPA,
				[8] = itemID,
				[9] = tStamp,
				[10] = id,
				[11] = GUID
			};
			
			if not CEPGP_Info.SharingTraffic then
				if CEPGP_itemExists(tonumber(itemID)) then
					local itemLink = CEPGP_getItemLink(itemID);
					if not itemLink then
						local item = Item:CreateFromItemID(tonumber(itemID));
						item:ContinueOnItemLoad(function()
							itemLink = CEPGP_getItemLink(itemID);
							entry = {
								[1] = player,
								[2] = issuer,
								[3] = action,
								[4] = EPB,
								[5] = EPA,
								[6] = GPB,
								[7] = GPA,
								[8] = itemLink,
								[9] = tStamp,
								[10] = id,
								[11] = GUID
							};
							table.insert(TRAFFIC, index, entry);
							CEPGP_UpdateTrafficScrollBar();
						end);
					elseif itemLink then
						entry = {
							[1] = player,
							[2] = issuer,
							[3] = action,
							[4] = EPB,
							[5] = EPA,
							[6] = GPB,
							[7] = GPA,
							[8] = itemLink,
							[9] = tStamp,
							[10] = id,
							[11] = GUID
						};
						table.insert(TRAFFIC, index, entry);
						CEPGP_UpdateTrafficScrollBar();
					end
				else
					entry = {
						[1] = player,
						[2] = issuer,
						[3] = action,
						[4] = EPB,
						[5] = EPA,
						[6] = GPB,
						[7] = GPA,
						[8] = "",
						[9] = tStamp,
						[10] = id,
						[11] = GUID
					};
					table.insert(TRAFFIC, index, entry);
					CEPGP_UpdateTrafficScrollBar();
				end
			end
			
			if CEPGP_Info.SharingTraffic and tStamp and id and GUID then
				table.insert(CEPGP_Info.TrafficImport, entry);
				CEPGP_traffic_share_status:SetText(#CEPGP_Info.TrafficImport .. " entries received");
			end
		end);
		
		if not success then
			CEPGP_print("Failed to import traffic entry from " .. sender, true);
			CEPGP_print(failMsg);
		end
	end
end

function CEPGP_SendAddonMsg(message, channel)

	local function hasSent()
		for index, msg in ipairs(CEPGP_Info.MessageStack) do
			if msg[1] == message then
				return false;
			end
		end
		return true;
	end
	
	local function send()
			--	Changed from C_ChatInfo.SendAddonMessage to C_ChatInfo.SendAddonMessageLogged in 1.12.17 Alpha 5
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
	
	
	if #CEPGP_Info.MessageStack == 0 then
		table.insert(CEPGP_Info.MessageStack, {message, channel});
		send();
	else
		for _, msg in ipairs(CEPGP_Info.MessageStack) do
			if message == msg[1] then
				return;
			end
		end
		table.insert(CEPGP_Info.MessageStack, {message, channel});
		send();
	end
	
	local callback;
	
	C_Timer.After(2, function()
		callback = C_Timer.NewTicker(1, function()
			if hasSent() then
				callback._remainingIterations = 1;
			else
				send();
				callback._remainingIterations = 2;			
			end
		end, 1);
	end);
end

function CEPGP_ShareTraffic(ID, GUID)
	if not ID or not GUILD then return; end
	
	local success, failMsg = pcall(function()
		local player, issuer, action, EPB, EPA, GPB, GPA, itemID, tStamp;
		for i = #TRAFFIC, 1, -1 do
			if TRAFFIC[i][10] == ID and TRAFFIC[i][11] == GUID then
				player = TRAFFIC[i][1];
				issuer = TRAFFIC[i][2];
				action = TRAFFIC[i][3];
				EPB = TRAFFIC[i][4] or "";
				EPA = TRAFFIC[i][5] or "";
				GPB = TRAFFIC[i][6] or "";
				GPA = TRAFFIC[i][7] or "";
				itemID = CEPGP_getItemID(CEPGP_getItemString(TRAFFIC[i][8])) or "";
				tStamp = TRAFFIC[i][9];
				break;
			end
		end
		
		local str = player .. ";" .. issuer .. ";" .. action .. ";" .. EPB .. ";" .. EPA .. ";" .. GPB .. ";" .. GPA .. ";" .. itemID .. ";" .. tStamp .. ";" .. ID .. ";" .. GUID;
		if #str > 255 then
			CEPGP_print("Could not share traffic entry with ID " .. ID .. " / GUID " .. GUID .. ". Character limit exceeded!", true);
			return;
		end
		
		CEPGP_SendAddonMsg("CEPGP_TRAFFIC;" .. player .. ";" .. issuer .. ";" .. action .. ";" .. EPB .. ";" .. EPA .. ";" .. GPB .. ";" .. GPA .. ";" .. itemID .. ";" .. tStamp .. ";" .. ID .. ";" .. GUID, "GUILD");
	end);
	
	if not success then
		CEPGP_print("Error encountered while sharing traffic ID " .. ID .. " / GUID " .. GUID, true);
		CEPGP_print(failMsg);
	end
	
end