local L = CEPGP_Locale:GetLocale("CEPGP")

function CEPGP_handleComms(event, arg1, arg2, response)
	if arg1 then
		for i = 1, 4 do
			if string.lower(arg1) == string.lower(CEPGP_response_buttons[i][4]) then
				response = i;
				break;
			end
		end
	end
	response = tonumber(response);
	
	local index = CEPGP_getIndex(arg2);

	--if not response then response = 5; end

	if event == "CHAT_MSG_WHISPER" and response then
		if not CEPGP_distributing then return; end
		for _, name in ipairs(CEPGP_responses) do
			if name == arg2 then return; end
		end
		
		if CEPGP_debugMode then
			CEPGP_print(arg2 .. " registered (" .. CEPGP_keyword .. ")");
		end
		local _, _, _, _, _, _, _, _, slot = GetItemInfo(CEPGP_DistID);
		
		if not slot and CEPGP_itemExists(CEPGP_DistID) then
			local item = Item:CreateFromItemID(CEPGP_DistID);
			item:ContinueOnItemLoad(function()
				local _, _, _, _, _, _, _, _, slot = GetItemInfo(CEPGP_DistID)
				local EP, GP = nil;
				local inGuild = false;
				if CEPGP_roster[arg2] then 
					EP, GP = CEPGP_getEPGP(arg2, index);
					class = CEPGP_roster[arg2][2];
					inGuild = true;
				elseif index then
					EP, GP = CEPGP_getEPGP(arg2, index);
					class = select(5, GetGuildRosterInfo(index));
					inGuild = true; 
				end
				if (CEPGP_show_passes and response == 6) or response < 6 then
					CEPGP_SendAddonMsg(arg2..";distslot;"..CEPGP_distSlot, "RAID");
				end
				if inGuild and not CEPGP_suppress_announcements then
					if response < 5 then	-- 5 means they're not using the addon or they're using an outdated version that doesn't support responses
						CEPGP_sendChatMessage(arg2 .. " (" .. class .. ") needs (" .. CEPGP_response_buttons[response][2] .. "). (" .. math.floor((EP/GP)*100)/100 .. " PR)", CEPGP_lootChannel);
					elseif response == 5 or not response then
						CEPGP_sendChatMessage(arg2 .. " (" .. class .. ") needs (" .. math.floor((EP/GP)*100)/100 .. " PR)", CEPGP_lootChannel);
					end
				elseif not CEPGP_suppress_announcements then
					local total = GetNumGroupMembers();
					for i = 1, total do
						if arg2 == GetRaidRosterInfo(i) then
							_, _, _, _, class = GetRaidRosterInfo(i);
						end
					end
					if response < 5 then
						CEPGP_sendChatMessage(arg2 .. " (" .. class .. ") needs (" .. CEPGP_response_buttons[response][2] .. "). (Non-guild member)", CEPGP_lootChannel);
					elseif response == 5 then
						CEPGP_sendChatMessage(arg2 .. " (" .. class .. ") needs (Non-guild Member)", CEPGP_lootChannel);
					end
				end
				if (CEPGP_show_passes and response == 6) or response < 6 then --If you are the master looter
					if not response then response = 5; end
					CEPGP_SendAddonMsg("!need;"..arg2..";"..CEPGP_DistID..";"..response, "RAID"); --!need;playername;itemID (of the item being distributed) is sent for sharing with raid assist
					CEPGP_itemsTable[arg2] = {};
					CEPGP_itemsTable[arg2][3] = response;
				end
				CEPGP_UpdateLootScrollBar(true);
			end);
		else

			local EP, GP = nil;
			local inGuild = false;
			if CEPGP_roster[arg2] then 
					local index = CEPGP_getIndex(arg2);
					EP, GP = CEPGP_getEPGP(arg2, index);
					--[[if CEPGP.Loot.MinReq[1] and CEPGP.Loot.MinReq[2] > tonumber(EP) then
						CEPGP_print(arg2 .. " is interested in this item but doesn't have enough EP.");
					end]]
					class = CEPGP_roster[arg2][2];
					inGuild = true;
				else
					local index = CEPGP_getIndex(arg2);
					if index then
						EP, GP = CEPGP_getEPGP(arg2, index);
						class = select(5, GetGuildRosterInfo(index));
						inGuild = true; 
					end
				end
			if (CEPGP_show_passes and response == 6) or response < 6 then
				CEPGP_SendAddonMsg(arg2..";distslot;"..CEPGP_distSlot, "RAID");
			end
			if inGuild and not CEPGP_suppress_announcements then
				if response < 5 then
					CEPGP_sendChatMessage(arg2 .. " (" .. class .. ") needs (" .. CEPGP_response_buttons[response][2] .. "). (" .. math.floor((EP/GP)*100)/100 .. " PR)", CEPGP_lootChannel);
				elseif response == 5 then
					CEPGP_sendChatMessage(arg2 .. " (" .. class .. ") needs (" .. math.floor((EP/GP)*100)/100 .. " PR)", CEPGP_lootChannel);
				end
			elseif not CEPGP_suppress_announcements then
				local total = GetNumGroupMembers();
				for i = 1, total do
					if arg2 == GetRaidRosterInfo(i) then
						_, _, _, _, class = GetRaidRosterInfo(i);
					end
				end
				if response < 5 then
					CEPGP_sendChatMessage(arg2 .. " (" .. class .. ") needs (" .. CEPGP_response_buttons[response][2] .. "). (Non-guild member)", CEPGP_lootChannel);
				elseif response == 5 then
					CEPGP_sendChatMessage(arg2 .. " (" .. class .. ") needs (Non-guild Member)", CEPGP_lootChannel);
				end
			end
			if (CEPGP_show_passes and response == 6) or response < 6 then --If you are the master looter
				CEPGP_SendAddonMsg("!need;"..arg2..";"..CEPGP_DistID..";"..response, "RAID"); --!need;playername;itemID (of the item being distributed) is sent for sharing with raid assist
				CEPGP_itemsTable[arg2] = {};
				CEPGP_itemsTable[arg2][3] = response;						
			end
			CEPGP_UpdateLootScrollBar(true);
		end
		
	elseif event == "CHAT_MSG_WHISPER" and string.lower(arg1) == "!info" then
		if CEPGP_getGuildInfo(arg2) ~= nil then
			local index = CEPGP_getIndex(arg2);
			EP, GP = CEPGP_getEPGP(arg2, index);
			if not CEPGP_vInfo[arg2] then
				SendChatMessage("EPGP Standings - EP: " .. EP .. " / GP: " .. GP .. " / PR: " .. math.floor((EP/GP)*100)/100, "WHISPER", CEPGP_LANGUAGE, arg2);
			else
				CEPGP_SendAddonMsg("!info;" .. arg2 .. ";EPGP Standings - EP: " .. EP .. " / GP: " .. GP .. " / PR: " .. math.floor((EP/GP)*100)/100, "GUILD");
			end
		end
	elseif event == "CHAT_MSG_WHISPER" and (string.lower(arg1) == "!infoguild" or string.lower(arg1) == "!inforaid" or string.lower(arg1) == "!infoclass") then
		if CEPGP_getGuildInfo(arg2) ~= nil then
			sRoster = {};
			CEPGP_updateGuild();
			local gRoster = {};
			local rRoster = {};
			local name, _, class, oNote, EP, GP;
			for i = 1, GetNumGuildMembers() do
				gRoster[i] = {};
				name , _, _, _, class = GetGuildRosterInfo(i);
				EP, GP = CEPGP_getEPGP(name, i);
				if string.find(name, "-") then
					name = string.sub(name, 0, string.find(name, "-")-1);
				end
				gRoster[i] = {
					[1] = name,
					[2] = EP,
					[3] = GP,
					[4] = math.floor((EP/GP)*100)/100,
					[5] = class
				};
			end
			if string.lower(arg1) == "!infoguild" then
				if CEPGP_critReverse then
					gRoster = CEPGP_tSort(gRoster, 4);
					for i = 1, CEPGP_ntgetn(gRoster) do
						if gRoster[i][1] == arg2 then
							if not CEPGP_vInfo[arg2] then
								SendChatMessage("EP: " .. gRoster[i][2] .. " / GP: " .. gRoster[i][3] .. " / PR: " .. gRoster[i][4] .. " / PR rank in guild: #" .. i, "WHISPER", CEPGP_LANGUAGE, arg2);
							else
								CEPGP_SendAddonMsg("!info;" .. arg2 .. ";EP: " .. gRoster[i][2] .. " / GP: " .. gRoster[i][3] .. " / PR: " .. gRoster[i][4] .. " / PR rank in guild: #" .. i, "GUILD");
							end
						end
					end
				else
					CEPGP_critReverse = true;
					gRoster = CEPGP_tSort(gRoster, 4);
					for i = 1, table.getn(gRoster) do
						if gRoster[i][1] == arg2 then
							if not CEPGP_vInfo[arg2] then
								SendChatMessage("EP: " .. gRoster[i][2] .. " / GP: " .. gRoster[i][3] .. " / PR: " .. gRoster[i][4] .. " / PR rank in guild: #" .. i, "WHISPER", CEPGP_LANGUAGE, arg2);
							else
								CEPGP_SendAddonMsg("!info;" .. arg2 .. ";EP: " .. gRoster[i][2] .. " / GP: " .. gRoster[i][3] .. " / PR: " .. gRoster[i][4] .. " / PR rank in guild: #" .. i, "GUILD");
							end
						end
					end
					CEPGP_critReverse = false;
				end
			else
				local count = 0;
				local compClass; -- Comparative Class
				if string.lower(arg1) == "!infoclass" then
					local name;
					count = 1;
					for i = 1, GetNumGroupMembers() do
						if GetRaidRosterInfo(i) == arg2 then
							name = GetRaidRosterInfo(i);
							compClass = UnitClass("raid"..i);
							break;
						end
					end
					local index = CEPGP_getIndex(arg2);
					EP, GP = CEPGP_getEPGP(arg2, index);
					class = CEPGP_roster[name][2];
					rRoster[count] = {
						[1] = arg2,
						[2] = EP,
						[3] = GP,
						[4] = math.floor((EP/GP))*100/100,
						[5] = compClass
					};
					for i = 1, GetNumGroupMembers() do
						name = GetRaidRosterInfo(i);
						if string.find(name, "-") then
							name = string.sub(name, 0, string.find(name, "-")-1);
						end
						if not CEPGP_roster[name] then
							EP, GP = 0, BASEGP;
							class = UnitClass("raid"..i);
						else
							local index = CEPGP_getIndex(arg2);
							EP, GP = CEPGP_getEPGP(arg2, index);
							class = CEPGP_roster[name][2];
						end
						if class == compClass and name ~= arg2 then
							count = count + 1;
							rRoster[count] = {
								[1] = name,
								[2] = EP,
								[3] = GP,
								[4] = math.floor((EP/GP)*100)/100,
								[5] = class
							};
						end
					end
				else --Raid
					for i = 1, GetNumGroupMembers() do
						name = GetRaidRosterInfo(i);
						if string.find(name, "-") then
							name = string.sub(name, 0, string.find(name, "-")-1);
						end
						if not CEPGP_roster[name] then
							EP, GP = 0, BASEGP;
							class = UnitClass("raid"..i);
						else
							local index = CEPGP_getIndex(arg2);
							EP, GP = CEPGP_getEPGP(arg2, index);
							class = CEPGP_roster[name][2];
						end
						count = count + 1;
						rRoster[count] = {
							[1] = name,
							[2] = EP,
							[3] = GP,
							[4] = math.floor((EP/GP)*100)/100,
							[5] = class
						};
					end
				end
				if CEPGP_critReverse then
					rRoster = CEPGP_tSort(rRoster, 4);
				else
					CEPGP_critReverse = true;
					rRoster = CEPGP_tSort(rRoster, 4);
					CEPGP_critReverse = false;
				end
				if count >= 1 then
					for i = 1, #rRoster do
						if rRoster[i][1] == arg2 then
							if string.lower(arg1) == "!infoclass" then
								if not CEPGP_vInfo[arg2] then
									SendChatMessage("EP: " .. rRoster[i][2] .. " / GP: " .. rRoster[i][3] .. " / PR: " .. rRoster[i][4] .. " / PR rank among " .. compClass .. "s in raid: #" .. i, "WHISPER", CEPGP_LANGUAGE, arg2);
								else
									CEPGP_SendAddonMsg("!info;" .. arg2 .. ";EP: " .. rRoster[i][2] .. " / GP: " .. rRoster[i][3] .. " / PR: " .. rRoster[i][4] .. " / PR rank among " .. compClass .. "s in raid: #" .. i, "GUILD");
								end
							else
								if not CEPGP_vInfo[arg2] then
									SendChatMessage("EP: " .. rRoster[i][2] .. " / GP: " .. rRoster[i][3] .. " / PR: " .. rRoster[i][4] .. " / PR rank in raid: #" .. i, "WHISPER", CEPGP_LANGUAGE, arg2);
								else
									CEPGP_SendAddonMsg("!info;" .. arg2 .. ";EP: " .. rRoster[i][2] .. " / GP: " .. rRoster[i][3] .. " / PR: " .. rRoster[i][4] .. " / PR rank in raid: #" .. i, "GUILD");
								end
							end
						end
					end
				end
			end
		end
	end
end

function CEPGP_handleCombat(name)
	if (((GetLootMethod() == "master" and CEPGP_isML() == 0) or (GetLootMethod() == "group" and UnitIsGroupLeader("player"))) and CEPGP_ntgetn(CEPGP_roster) > 0) or CEPGP_debugMode then
		local localName = L[name];
		local EP = EPVALS[name];
		local plurals = name == "The Four Horsemen" or name == "Silithid Royalty" or name == "Twin Emperors";
		local message = format(L["%s " .. (plurals and "have" or "has") .. " been defeated! %d EP has been awarded to the raid"], localName, EP);
		local callback = function()
			local function awardEP(localName, EP, message)
				CEPGP_AddRaidEP(EP, message, localName);
			end
			
			local success, failMsg = pcall(awardEP, localName, EP, message);
			
			if not success then
				CEPGP_print("Failed to award raid EP for " .. name, true);
				CEPGP_print(failMsg);
			end
			
			local function awardStandbyEP(localName, EP)
				if STANDBYEP and tonumber(STANDBYPERCENT) > 0 then
					CEPGP_addStandbyEP(EP*(tonumber(STANDBYPERCENT)/100), localName);
				end
			end
			
			success, failMsg = pcall(awardStandbyEP, localName, EP);
			
			if not success then
				CEPGP_print("Failed to award standby EP for " .. name, true);
				CEPGP_print(failMsg);
			end
		end
		
		if CEPGP_ntgetn(CEPGP_roster) < (GetNumGuildMembers() - CEPGP_Info.NumExcluded) and CEPGP_Info.Polling then
			table.insert(CEPGP_Info.RosterStack, callback);
		else
			callback();
		end
		
		CEPGP_UpdateStandbyScrollBar();
	end
end

function CEPGP_handleLoot(event, arg1, arg2)
	if event == "LOOT_CLOSED" then
		if CEPGP_isML() == 0 then
			CEPGP_SendAddonMsg("LootClosed;", "RAID");
		end
		CEPGP_distributing = false;
		CEPGP_toggleGPEdit(true);
		CEPGP_distItemLink = nil;
		CEPGP_Info.IgnoreUpdates = false;
		_G["CEPGP_distributing_button"]:Hide();
		if CEPGP_mode == "loot" then
			CEPGP_cleanTable();
			if CEPGP_isML() == 0 then
				CEPGP_SendAddonMsg("RaidAssistLootClosed", "RAID");
			end
			HideUIPanel(CEPGP_frame);
		end
		HideUIPanel(CEPGP_distribute_popup);
		--HideUIPanel(CEPGP_button_loot_dist);
		HideUIPanel(CEPGP_loot);
		HideUIPanel(CEPGP_distribute);
		HideUIPanel(CEPGP_loot_distributing);
		HideUIPanel(CEPGP_button_loot_dist);
		if UnitInRaid("player") then
			CEPGP_toggleFrame(CEPGP_raid);
		elseif GetGuildRosterInfo(1) then
			CEPGP_toggleFrame(CEPGP_guild);
		else
			HideUIPanel(CEPGP_frame);
			if CEPGP_isML() == 0 then
				CEPGP_distributing_button:Hide();
			end
		end
		
		if CEPGP_distribute:IsVisible() == 1 then
			HideUIPanel(CEPGP_distribute);
			ShowUIPanel(CEPGP_loot);
			CEPGP_responses = {};
			CEPGP_UpdateLootScrollBar();
		end
		
	elseif event == "LOOT_OPENED" then --and (UnitInRaid("player") or CEPGP_debugMode) then
		CEPGP_Info.IgnoreUpdates = true;	--	Prevents the CEPGP roster from rebuilding while distributing loot
		CEPGP_LootFrame_Update();
		ShowUIPanel(CEPGP_button_loot_dist);

	elseif event == "LOOT_SLOT_CLEARED" then
		if CEPGP_distributing and arg1 == CEPGP_lootSlot then --Confirms that an item is currently being distributed and that the item taken is the one in question
			local callback = function()
				if CEPGP_distPlayer ~= "" and CEPGP_award then
					CEPGP_distributing = false;
					CEPGP_toggleGPEdit(true);
					if CEPGP_isML() == 0 then
						CEPGP_SendAddonMsg("RaidAssistLootClosed", "RAID");
						CEPGP_SendAddonMsg("LootClosed;", "RAID");
					end
					local response;
					if CEPGP_distribute_popup:GetAttribute("responseName") then
						response = CEPGP_distribute_popup:GetAttribute("responseName");
						if response == "" then response = nil; end
					end
					if CEPGP_distGP then
						if response then
							local message = "Awarded " .. _G["CEPGP_distribute_item_name"]:GetText() .. " to ".. CEPGP_distPlayer .. " for " .. CEPGP_distribute_GP_value:GetText()*CEPGP_rate .. " GP (" .. response .. ")";
							SendChatMessage(message, CHANNEL, CEPGP_LANGUAGE);
						else
							local message = "Awarded " .. _G["CEPGP_distribute_item_name"]:GetText() .. " to ".. CEPGP_distPlayer .. " for " .. CEPGP_distribute_GP_value:GetText()*CEPGP_rate .. " GP";
							SendChatMessage(message, CHANNEL, CEPGP_LANGUAGE);
						end
						CEPGP_addGP(CEPGP_distPlayer, CEPGP_distribute_GP_value:GetText()*CEPGP_rate, CEPGP_DistID, CEPGP_distItemLink, nil, response);
					else
						if CEPGP_roster[CEPGP_distPlayer] then
							local index = CEPGP_roster[CEPGP_distPlayer][1];
							local EP, GP = CEPGP_getEPGP(CEPGP_distPlayer, index);
							SendChatMessage("Awarded " .. _G["CEPGP_distribute_item_name"]:GetText() .. " to ".. CEPGP_distPlayer .. " for free", CHANNEL, CEPGP_LANGUAGE);
							CEPGP_addTraffic(CEPGP_distPlayer, UnitName("player"), "Given for Free", EP, EP, GP, GP, CEPGP_DistID, time());
						else
							local index = CEPGP_getIndex(CEPGP_distPlayer);
							if index then
								SendChatMessage("Awarded " .. _G["CEPGP_distribute_item_name"]:GetText() .. " to ".. CEPGP_distPlayer .. " for free (Exclusion List)", CHANNEL, CEPGP_LANGUAGE);
								CEPGP_addTraffic(CEPGP_distPlayer, UnitName("player"), "Given for Free (Exclusion List)", nil, nil, nil, nil, CEPGP_DistID, time());
							end
						end
					end
					CEPGP_distPlayer = "";
					CEPGP_distribute_popup:Hide();
					CEPGP_distribute:Hide();
					_G["CEPGP_distributing_button"]:Hide();
					CEPGP_loot:Show();
				else
					CEPGP_distributing = false;
					CEPGP_toggleGPEdit(true);
					SendChatMessage(_G["CEPGP_distribute_item_name"]:GetText() .. " has been distributed without EPGP", CHANNEL, CEPGP_LANGUAGE);
					CEPGP_addTraffic("", UnitName("player"), "Manually Awarded", "", "", "", "", CEPGP_DistID, time());
					CEPGP_distribute_popup:Hide();
					CEPGP_distribute:Hide();
					_G["CEPGP_distributing_button"]:Hide();
					CEPGP_loot:Show();
				end
			end;
			if CEPGP_ntgetn(CEPGP_roster) < (GetNumGuildMembers() - CEPGP_Info.NumExcluded) and CEPGP_Info.Polling then
				table.insert(CEPGP_Info.RosterStack, callback);
			else
				callback();
			end
		end
		
		CEPGP_LootFrame_Update();
	end	
end