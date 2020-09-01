local L = CEPGP_Locale:GetLocale("CEPGP")

function CEPGP_IncAddonMsg(message, sender, channel)
	if sender ~= UnitName("player") then
		table.insert(CEPGP.Log, {time(), "received", sender, UnitName("player"), message, channel});	--	os.time, time since pc turned on (useful for millisecond precision)
	end
	
	local args = CEPGP_split(message, ";"); -- The broken down message, delimited by semi-colons
	if sender == UnitName("player") then
		for i = 1, #CEPGP_Info.MessageStack do
			if CEPGP_Info.MessageStack[i] == message then
				table.remove(CEPGP_Info.MessageStack, i);
			end
		end
	end
	
	if args[1] == "table" then
		return;
	end
	
	if args[1] == "Import" then
		local option = args[2];
		CEPGP_ExportConfig(option, sender, channel);
		return;
	end
	
	if args[1] == "ImportStart" then
		CEPGP_settings_import_confirm:Disable();
	end
	
	if args[1] == "ImportEnd" then
		CEPGP_settings_import_confirm:Enable();
	end
	
	if args[1] == "SyncStart" then
		if sender == UnitName("player") then return; end
		local rank = select(4, CEPGP_getGuildInfo(sender));
		if not rank then return; end
		if rank + 1 > CEPGP_force_sync_rank then --Index obtained by GetGuildRosterInfo starts at 0 whereas GuildControlGetRankName starts at 1 for some reason
			return;
		end
		CEPGP.Alt.Links = {};
		if CEPGP_options_alt_mangement:IsVisible() then
			CEPGP_UpdateAltScrollBar();
		end
		
		OVERRIDE_INDEX = {};
		CEPGP.Overrides = {};
		if CEPGP_override:IsVisible() then
			CEPGP_UpdateOverrideScrollBar();
		end
		
		CEPGP_standbyRoster = {};
		CEPGP.Standby.Roster = {};
		if CEPGP_standby_options:IsVisible() then
			CEPGP_UpdateStandbyScrollBar();
		end
		
		CEPGP_settings_import_confirm:Disable();
		CEPGP_print(sender .. " 正在更新您的CEPGP配置");
	end
	
	if args[1] == "SyncEnd" then
		if sender == UnitName("player") then return; end
		local rank = select(4, CEPGP_getGuildInfo(sender));
		if not rank then return; end
		if rank + 1 > CEPGP_force_sync_rank then
			return;
		end
		CEPGP_settings_import_confirm:Enable();
		CEPGP_print("您的配置已更新");
	end
	
	if args[1] == "ExportConfig" then
		CEPGP_OverwriteOption(args, sender, channel);
		return;
	end
	
	if args[1] == "message" and args[2] == UnitName("player") then
		CEPGP_print(args[3]);
	end
	
	if args[1] == "CEPGP_setDistID" then
		CEPGP_DistID = args[2];
		
	elseif args[1] == "CEPGP_setLootGUID" then
		CEPGP_Info.LootGUID = args[2];
	
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
			[4] = tonumber(roll)
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
		
		
	elseif args[1] == "!need" then
		local player = args[2];
		if player == UnitName("player") then
			CEPGP_respond:Hide();
		end
		local response = tonumber(args[4]) or CEPGP_getResponse(args[4]) or CEPGP_getResponseIndex(args[4]) or CEPGP_indexToLabel(args[4]);
		local roll = args[5];
		if sender ~= UnitName("player") then
			CEPGP_Info.LootRespondants = CEPGP_Info.LootRespondants + 1;
		end
		if sender ~= UnitName("player") and ((CEPGP_show_passes and response == 6) or response ~= 6) then
			CEPGP_itemsTable[player] = {};
			CEPGP_itemsTable[player][3] = response;
			if roll then
				CEPGP_itemsTable[player][4] = tonumber(roll);
			end
			CEPGP_UpdateLootScrollBar(sort);
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
		
	elseif args[1] == "lootschema" then
		for i = 2, #args, 2 do
			CEPGP_Info.LootSchema[tonumber(args[i])] = args[i+1];
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
		local GUID = args[3] or "";
		CEPGP_handleComms("CHAT_MSG_WHISPER", nil, sender, response, GUID);
	
	elseif args[1] == "CEPGP_TRAFFICSyncStart" and sender ~= UnitName("player") then
		CEPGP_Info.SharingTraffic = true;
		CEPGP_traffic_share:Disable();
		CEPGP_print(sender .. "正在与您共享他们的EPGP明细日志记录。此过程将在10秒后开始");
		CEPGP_traffic_share_status:SetText("准备接收交换记录");
		CEPGP_Info.TrafficImport = {};
	
	elseif args[1] == "CEPGP_TRAFFICSyncStop" and sender ~= UnitName("player") and CEPGP_Info.SharingTraffic then
		local success, failMsg = pcall(function()
			CEPGP_print(#CEPGP_Info.TrafficImport .. "收到交换记录。处理中。。");
			local sigs = {}; 	--	signatures
			for _, v in ipairs(TRAFFIC) do
				if v[9] and v[10] and v[11] then
					if not sigs[v[10]] then
						sigs[v[10]] = {[1] = v[11]};
					else
						table.insert(sigs[v[10]], v[11]);
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
							CEPGP_traffic_share_status:SetText("处理 " .. count .. " 属于 " .. limit .. " 记录");
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
				CEPGP_traffic_share_status:SetText("处理 " .. count .. " 属于 " .. limit .. " 记录");
				if count >= limit then
					CEPGP_Info.SharingTraffic = false;
					CEPGP_traffic_share_status:SetText("已完成处理共享记录");
					CEPGP_print("EPGP明细记录导入已完成");
					CEPGP_traffic_share:Enable();
					CEPGP_UpdateTrafficScrollBar();
					CEPGP_Info.TrafficImport = {};
				end
				
				count = count + 1;
			end, limit);
		end);
		
		if not success then
			CEPGP_print("无法处理导入的共享记录", true);
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
				CEPGP_traffic_share_status:SetText(#CEPGP_Info.TrafficImport .. " 收到的记录");
			end
		end);
		
		if not success then
			CEPGP_print("无法从交换数据导入 " .. sender, true);
			CEPGP_print(failMsg);
		end
	end
end

function CEPGP_ExportConfig(option, player)
	if not CEPGP[option] then return; end
	
	local success, failMsg = pcall(function()
		local channel = "GUILD";
		
		if player then channel = "WHISPER"; end

		if option == "Overrides" then
			if CEPGP_ntgetn(CEPGP.Overrides) == 0 then return; end
			
			local Overrides = {};
			
			for link, gp in pairs(CEPGP.Overrides) do
				table.insert(Overrides, {link, gp});
			end
			
			local limit = CEPGP_ntgetn(Overrides);
			local i = 1;
			C_Timer.NewTicker(0.1, function()
				CEPGP_SendAddonMsg("ExportConfig;Overrides;" .. Overrides[i][1] .. ";" .. Overrides[i][2], channel, player);
				i = i + 1;
			end, limit);		
			
		elseif option == "Alt" then
			for key, state in pairs(CEPGP.Alt) do
				if key == "Links" then
					for main, alts in pairs(state) do
						for i = 1, #alts do
							CEPGP_SendAddonMsg("ExportConfig;Alt;" .. key .. ";" .. main .. ";" .. alts[i], channel, player);
						end
					end
				else
					CEPGP_SendAddonMsg("ExportConfig;Alt;" .. key .. ";" .. (state and "true" or "false"), channel, player);
				end
			end
		
		elseif option == "Decay" then
			CEPGP_SendAddonMsg("ExportConfig;Decay;Separate;" .. (CEPGP.Decay.Separate and "true" or "false"), channel, player);
		
		elseif option == "EP" then
			local bossEP = {};
			for boss, EP in pairs(CEPGP.EP.BossEP) do
				table.insert(bossEP, boss);
			end
			
			local limit = #bossEP;
			local i = 1;
			C_Timer.NewTicker(0.1, function()
				CEPGP_SendAddonMsg("ExportConfig;EP;BossEP;" .. bossEP[i] .. ";" .. CEPGP.EP.BossEP[bossEP[i]], channel, player);
				CEPGP_SendAddonMsg("ExportConfig;EP;AutoAward;" .. bossEP[i] .. ";" .. (CEPGP.EP.AutoAward[bossEP[i]] and "true" or "false"), channel, player);
				i = i + 1;
			end, limit);
			
		elseif option == "GP" then
			CEPGP_SendAddonMsg("ExportConfig;GP;Base;" .. CEPGP.GP.Base, channel, player);
			CEPGP_SendAddonMsg("ExportConfig;GP;DecayFactor;" .. (CEPGP.GP.DecayFactor and "true" or "false"), channel, player);
			CEPGP_SendAddonMsg("ExportConfig;GP;Min;" .. CEPGP.GP.Min, channel, player);
			CEPGP_SendAddonMsg("ExportConfig;GP;Mod;" .. CEPGP.GP.Mod, channel, player);
			CEPGP_SendAddonMsg("ExportConfig;GP;Multiplier;" .. CEPGP.GP.Multiplier, channel, player);
			CEPGP_SendAddonMsg("ExportConfig;GP;Tooltips;" .. (CEPGP.GP.Tooltips and "true" or "false"), channel, player);
			
			
			for raid, value in pairs(CEPGP.GP.RaidModifiers) do
				CEPGP_SendAddonMsg("ExportConfig;GP;RaidModifiers;" .. raid .. ";" .. value, channel, player);
			end
			
			for slot, weight in pairs(CEPGP.GP.SlotWeights) do
				CEPGP_SendAddonMsg("ExportConfig;GP;SlotWeights;" .. slot .. ";" .. weight, channel, player);
			end
		
		elseif option == "Loot" then
			CEPGP_SendAddonMsg("ExportConfig;Loot;Announcement;" .. CEPGP.Loot.Announcement, channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Loot;AutoPass;" .. (CEPGP.Loot.AutoPass and "true" or "false"), channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Loot;AutoShow;" .. (CEPGP.Loot.AutoShow and "true" or "false"), channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Loot;AutoSort;" .. (CEPGP.Loot.AutoSort and "true" or "false"), channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Loot;DelayResponses;" .. (CEPGP.Loot.DelayResponses and "true" or "false"), channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Loot;ExtraKeywords;Enabled;" .. (CEPGP.Loot.ExtraKeywords.Enabled and "true" or "false"), channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Loot;HideKeyphrases;" .. (CEPGP.Loot.HideKeyphrases and "true" or "false"), channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Loot;MinThreshold;" .. CEPGP.Loot.MinThreshold, channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Loot;MinReq;" .. (CEPGP.Loot.MinReq[1] and "true" or "false") .. ";" .. CEPGP.Loot.MinReq[2], channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Loot;PassRolls;" .. (CEPGP.Loot.PassRolls and "true" or "false"), channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Loot;PRWithDelay;" .. (CEPGP.Loot.PRWithDelay and "true" or "false"), channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Loot;RaidVisibility;" .. (CEPGP.Loot.RaidVisibility[1] and "true" or "false") .. ";" .. (CEPGP.Loot.RaidVisibility[2] and "true" or "false"), channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Loot;RaidWarning;" .. (CEPGP.Loot.RaidWarning and "true" or "false"), channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Loot;ResolveRolls;" .. (CEPGP.Loot.ResolveRolls and "true" or "false"), channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Loot;RollAnnounce;" .. (CEPGP.Loot.RollAnnounce and "true" or "false"), channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Loot;RollWithDelay;" .. (CEPGP.Loot.RollWithDelay and "true" or "false"), channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Loot;ShowPass;" .. (CEPGP.Loot.ShowPass and "true" or "false"), channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Loot;SuppressResponses;" .. (CEPGP.Loot.SuppressResponses and "true" or "false"), channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Loot;GUI;Timer;" .. CEPGP.Loot.GUI.Timer, channel, player);
			
			for index = 1, 4 do
				local data = CEPGP.Loot.GUI.Buttons[index];
				local enabled = data[1] and "true" or "false";
				local buttonText = data[2];
				local discount = data[3];
				local keyphrase = data[4];
				local msg = "ExportConfig;Loot;GUI;Buttons;" .. index .. ";" .. enabled .. ";" .. buttonText .. ";" .. discount .. ";" .. keyphrase;
				if #msg > 249 then
					msg = "ExportConfig;Loot;GUI;Buttons;" .. index;
				end
				CEPGP_SendAddonMsg(msg, channel, player);
			end
			
			for label, data in pairs(CEPGP.Loot.ExtraKeywords.Keywords) do
				for keyword, discount in pairs(data) do
					CEPGP_SendAddonMsg("ExportConfig;Loot;ExtraKeywords;Keywords;" .. label .. ";" .. keyword .. ";" .. discount, channel, player);
				end
			end
			
		
		elseif option == "Standby" then
			CEPGP_SendAddonMsg("ExportConfig;Standby;AcceptWhispers;" .. (CEPGP.Standby.AcceptWhispers and "true" or "false"), channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Standby;ByRank;" .. (CEPGP.Standby.ByRank and "true" or "false"), channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Standby;Enabled;" .. (CEPGP.Standby.Enabled and "true" or "false"), channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Standby;Keyword;" .. CEPGP.Standby.Keyword, channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Standby;Manual;" .. (CEPGP.Standby.Manual and "true" or "false"), channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Standby;Offline;" .. (CEPGP.Standby.Offline and "true" or "false"), channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Standby;Percent;" .. CEPGP.Standby.Percent, channel, player);
			CEPGP_SendAddonMsg("ExportConfig;Standby;Share;" .. (CEPGP.Standby.Share and "true" or "false"), channel, player);
			
			for index, data in ipairs(STANDBYRANKS) do
				CEPGP_SendAddonMsg("ExportConfig;Standby;Ranks;" .. index .. ";" .. data[1] .. ";" .. (data[2] and "true" or "false"), channel, player);
			end
			
			if #CEPGP_standbyRoster == 0 or not CEPGP.Standby.Share then return; end
			local roster = {};
			
			for index, data in ipairs(CEPGP_standbyRoster) do
				table.insert(roster, data[1]);	--	Player name
			end
			
			local i = 1;
			C_Timer.NewTicker(0.1, function()
				CEPGP_SendAddonMsg("ExportConfig;Standby;Roster;" .. roster[i], channel, player);
				i = i + 1;
			end, #roster);
		
		elseif option == "Channel" then
			CEPGP_SendAddonMsg("ExportConfig;Channel;" .. CEPGP.Channel, channel, player);
		
		elseif option == "LootChannel" then
			CEPGP_SendAddonMsg("ExportConfig;LootChannel;" .. CEPGP.LootChannel, channel, player);
		end
	end);
	
	if not success then
		CEPGP_print("将配置发送到时遇到问题 " .. (player and player or "the Guild"), true);
		CEPGP_print(failMsg);
	end
end

function CEPGP_OverwriteOption(args, sender, channel)
	if sender == UnitName("player") then return; end
	
	local success, failMsg = pcall(function()
		if channel == "GUILD" then
			local rank = select(4, CEPGP_getGuildInfo(sender));
			if not rank then return; end
			if rank + 1 > CEPGP_force_sync_rank then
				return;
			end
		end
		
		local option = args[2];
		local setting = args[3];
		
		
		local function sanitise(value)
			if value == "true" then
				return true;
			elseif value == "false" then
				return false;
			elseif tonumber(value) then
				return tonumber(value);
			else
				return value;
			end
		end
		
		if option == "Overrides" then
			local item, GP = args[3], args[4];
			OVERRIDE_INDEX[item] = GP;	--	Will be updated to new saved var structure when the changeover happens
			if CEPGP_override:IsVisible() then
				CEPGP_UpdateOverrideScrollBar();
			end
		
		elseif option == "Alt" then
			if setting == "Links" then
				CEPGP.Alt.Links[args[4]] = CEPGP.Alt.Links[args[4]] or {};
				table.insert(CEPGP.Alt.Links[args[4]], args[5]);
				if CEPGP_options_alt_mangement:IsVisible() then
					CEPGP_UpdateAltScrollBar();
				end
			else
				CEPGP.Alt[setting] = sanitise(args[4]);
			end
			
		elseif option == "Decay" then
			CEPGP.Decay[setting] = sanitise(args[4]);
		
		elseif option == "EP" then
			local boss = args[4];
			local state = setting == "BossEP" and tonumber(args[5]) or (args[5] == "true" and true or false);
			if setting == "AutoAward" then
				AUTOEP[boss] = state;
				_G["CEPGP_options_" .. boss .. "_auto_check"]:SetChecked(state);
			else
				EPVALS[boss] = state;
				_G["CEPGP_options_" .. boss .. "_EP_value"]:SetText(state);
			end
			CEPGP.EP[setting][boss] = state;
			
		elseif option == "GP" then
			local index;
			local value;
			if type(CEPGP.GP[setting]) == "table" then
				index = args[4];
				value = args[5];
				CEPGP.GP[setting][index] = value;
				if setting == "SlotWeights" then
					SLOTWEIGHTS[index] = value;
				end
			else
				value = sanitise(args[4]);
				CEPGP.GP[setting] = value;
			end
			
		elseif option == "Loot" then
			local value;
			if type(CEPGP.Loot[setting]) == "table" then
				if setting == "GUI" then
					if args[4] == "Buttons" then
						local index = sanitise(args[5]);
						local state = sanitise(args[6]);
						local text = sanitise(args[7]);
						local discount = sanitise(args[8]);
						local keyword = sanitise(args[9]);
						
						if text then					
							CEPGP.Loot.GUI.Buttons[index][1] = state;
							CEPGP_response_buttons[index][1] = state;
							CEPGP.Loot.GUI.Buttons[index][2] = text;
							CEPGP_response_buttons[index][2] = text;
							CEPGP.Loot.GUI.Buttons[index][3] = discount;
							CEPGP_response_buttons[index][3] = discount;
							CEPGP.Loot.GUI.Buttons[index][4] = keyword;
							CEPGP_response_buttons[index][4] = keyword;
						else
							CEPGP_print("导入响应按钮的数据时出现问题 " .. index .. ". 您需要手动配置此按钮。", true);
							return;
						end
						
					elseif args[4] == "Timer" then
						CEPGP.Loot.GUI.Timer = sanitise(args[5]);
					end
				
				elseif setting == "ExtraKeywords" then
					if args[4] == "Enabled" then
						CEPGP.Loot.ExtraKeywords.Enabled = sanitise(args[5]);
					else
						local label = sanitise(args[5]);
						local keyword = sanitise(args[6]);
						local discount = sanitise(args[7]);
						
						CEPGP.Loot.ExtraKeywords.Keywords[label] = {[keyword] = discount};
					end
					if CEPGP_loot_options:IsVisible() then
						CEPGP_UpdateKeywordScrollBar();
					end
				
				elseif setting == "MinReq" or setting == "RaidVisibility" then
					args[4] = sanitise(args[4]);
					args[5] = sanitise(args[5]);
					value = {args[4], args[5]};
					
					CEPGP.Loot[setting] = value;
				end
			else
				value = sanitise(args[4]);
				CEPGP.Loot[setting] = value;
			end
		
		elseif option == "Standby" then
			if setting == "Ranks" then
				local index = sanitise(args[4]);
				local rank = sanitise(args[5]);
				local state = sanitise(args[6]);
				
				CEPGP.Standby.Ranks[index] = {[rank] = state};
				STANDBYRANKS[index] = {[rank] = state};
			elseif setting == "Roster" then
				local player = sanitise(args[4]);
				CEPGP_addToStandby(player);
			else
				local value = sanitise(args[4]);
				CEPGP.Standby[setting] = value;
			end
		end
		CEPGP_refreshOptions();
	end);
end

function CEPGP_SendAddonMsg(message, channel, player, logged)
	local status = "unsent";
	
	local conditions = {
		["CallItem"] = function(id)
			return (id == CEPGP_DistID and CEPGP_distributing);
		end,
		["LootClosed"] = function()
			return CEPGP_frame:IsVisible();
		end,
		["RaidAssistLootDist"] = function()
			return CEPGP_distributing;
		end,
		["RaidAssistLootClosed"] = function()
			return not CEPGP_distributing;
		end,
		["IgnoreUpdates"] = function(state)
			return CEPGP_Info.IgnoreUpdates == state;
		end,
		["LootRsp"] = function(GUID)
			if #CEPGP_Info.LootGUID > 0 then
				return GUID == CEPGP_Info.LootGUID;
			elseif CEPGP_Info.LootGUID == "" then
				return true;
			else
				return false;
			end
		end,
		["CEPGP_setLootGUID"] = function(GUID)
			return GUID == CEPGP_Info.LootGUID;
		end
	}
	
	local function send()
		local sent = true;
		local args = CEPGP_split(message, ";");
		if conditions[args[1]] then
			local func = conditions[args[1]];
			if args[1] == "LootRsp" then args[2] = args[3]; end
			if not func(args[2]) then
				for i = 1, #CEPGP_Info.MessageStack do
					if CEPGP_Info.MessageStack[i] == message then
						table.remove(CEPGP_Info.MessageStack, i);
						status = "abandoned";
						return;
					end
				end
			end
		end
		if channel == "GUILD" and IsInGuild() then
			sent = C_ChatInfo.SendAddonMessage("CEPGP", message, "GUILD");
		elseif (channel == "RAID" or not channel) and IsInRaid() then --Player is in a raid group
			sent = C_ChatInfo.SendAddonMessage("CEPGP", message, "RAID");
		elseif channel == "WHISPER" and player and logged then
			sent = C_ChatInfo.SendAddonMessageLogged("CEPGP", message, "WHISPER", player);
		elseif channel == "WHISPER" and player then
			sent = C_ChatInfo.SendAddonMessage("CEPGP", message, "WHISPER", player);
		elseif GetNumGroupMembers() > 0 and not IsInRaid() then --Player is in a party but not a raid
			sent = C_ChatInfo.SendAddonMessage("CEPGP", message, "PARTY");
		elseif IsInGuild() then --If channel is not specified then assume guild
			sent = C_ChatInfo.SendAddonMessage("CEPGP", message, "GUILD");
		else	--None of the above conditions are met, such as not being in a guild and trying to request a version check. Ditch the message!
			for i = 1, #CEPGP_Info.MessageStack do
				if CEPGP_Info.MessageStack[i] == message then
					table.remove(CEPGP_Info.MessageStack, i);
					status = "abandoned";
					return;
				end
			end
		end
		if not sent and ((channel == "GUILD" and IsInGuild()) or (channel == "RAID" and IsInRaid())) then
			send();
		end
	end
	
	local function hasSent()
		for i = 1, #CEPGP_Info.MessageStack do
			if CEPGP_Info.MessageStack[i] == message then
				return false;
			end
		end
		return true;
	end
	

	if not hasSent() then return; end
	
	if channel ~= "WHISPER" then
		table.insert(CEPGP_Info.MessageStack, message);
	end
	
	send();
	
	local callback;
	
	--		Necessary to include as the sent bool for SendAddonMessage returns true even if a message is throttled
	C_Timer.After(0.1, function()
		callback = C_Timer.NewTicker(1, function()
			if status == "abandoned" then
				callback._remainingIterations = 1;
				table.insert(CEPGP.Log, {time(), status, UnitName("player"), player, message, channel});
				return;
			end
			if hasSent() then
				callback._remainingIterations = 1;
				status = "sent";
				table.insert(CEPGP.Log, {time(), status, UnitName("player"), player, message, channel});
			else
				callback._remainingIterations = 2;
				status = "attempt";
				table.insert(CEPGP.Log, {time(), status, UnitName("player"), player, message, channel});
				send();
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
		if #str > 249 then
			CEPGP_print("无法与该ID共享记录 " .. ID .. " / GUID " .. GUID .. ". 超过字符限制！", true);
			return;
		end
		
		CEPGP_SendAddonMsg("CEPGP_TRAFFIC;" .. player .. ";" .. issuer .. ";" .. action .. ";" .. EPB .. ";" .. EPA .. ";" .. GPB .. ";" .. GPA .. ";" .. itemID .. ";" .. tStamp .. ";" .. ID .. ";" .. GUID, "GUILD");
	end);
	
	if not success then
		CEPGP_print("共享交换ID时遇到错误 " .. ID .. " / GUID " .. GUID, true);
		CEPGP_print(failMsg);
	end
	
end

	--	group = party|assists
function CEPGP_messageGroup(msg, group, logged)
	if group == "party" then
		if not IsInGroup() then
			return;
		end
		local names = {};
		for i = 1, GetNumGroupMembers() do
			local player = select(1, GetRaidRosterInfo(i));
			local online = select(8, GetRaidRosterInfo(i));
			if online then
				table.insert(names, player);
			end
		end
		for _, name in ipairs(names) do
			CEPGP_SendAddonMsg(msg, "WHISPER", name, logged);
		end
		
	elseif group == "assists" then
		if not IsInRaid() then
			return;
		end
		local names = {};
		for i = 1, GetNumGroupMembers() do
			--	rank : 1 = assist, 2  = leader
			local player, rank = GetRaidRosterInfo(i);
			local leader = (rank == 2);
			local assist = (rank == 1);
			local online = select(8, GetRaidRosterInfo(i));
			if player ~= UnitName("player") and (leader or assist) and online then
				table.insert(names, player);
			end
		end
		for _, name in ipairs(names) do
			CEPGP_SendAddonMsg(msg, "WHISPER", name, logged);
		end
	end
end