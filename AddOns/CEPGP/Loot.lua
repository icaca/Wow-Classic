function CEPGP_LootFrame_Update()
	local items = {};
	local count = 0;
	if CEPGP_ElvUI then
		local numLootItems = GetNumLootItems();
		local texture, item, quantity, quality;
		for index = 1, numLootItems do
			if ( index <= numLootItems ) then	
				texture, item, quantity, _, quality = GetLootSlotInfo(index);
				if (tostring(GetLootSlotLink(index)) ~= "nil" or CEPGP_inOverride(item)) and item ~= nil then
					items[index-count] = {};
					items[index-count][1] = texture;
					items[index-count][2] = item;
					items[index-count][3] = quality;
					items[index-count][4] = GetLootSlotLink(index);
					local link = GetLootSlotLink(index);
					local itemString = string.find(link, "item[%-?%d:]+");
					itemString = strsub(link, itemString, string.len(link)-string.len(item)-6);
					items[index-count][5] = itemString;
					items[index-count][6] = index;
					items[index-count][7] = quantity;
				else
					count = count + 1;
				end
			end
		end
	else
		local numLootItems = LootFrame.numLootItems;
		local texture, item, quantity, quality;
		for index = 1, numLootItems do
			local slot = index;
			if ( slot <= numLootItems ) then	
				if (LootSlotHasItem(slot)) then
					texture, item, quantity, _, quality = GetLootSlotInfo(slot);
					if tostring(GetLootSlotLink(slot)) ~= "nil" or CEPGP_inOverride(item) then
						items[index-count] = {};
						items[index-count][1] = texture;
						items[index-count][2] = item;
						items[index-count][3] = quality;
						items[index-count][4] = GetLootSlotLink(slot);
						local link = GetLootSlotLink(index);
						local itemString = string.find(link, "item[%-?%d:]+");
						itemString = strsub(link, itemString, string.len(link)-string.len(item)-6);
						items[index-count][5] = itemString;
						items[index-count][6] = slot;
						items[index-count][7] = quantity;
					else
						count = count + 1;
					end
				end
			end
		end
	end
	for k, v in pairs(items) do -- k = loot slot number, v is the table result
		if (UnitInRaid("player") or CEPGP_debugMode) and (v[3] >= CEPGP_min_threshold) or (CEPGP_inOverride(v[2]) or CEPGP_inOverride(v[4])) then
			if CEPGP_isML() == 0 then
				CEPGP_frame:Show();
				CEPGP_mode = "loot";
				CEPGP_toggleFrame("CEPGP_loot");
			end
			break;
		end
	end
	CEPGP_populateFrame(items);
end

function CEPGP_announce(link, x, slotNum, quantity)
	if (GetLootMethod() == "master" and CEPGP_isML() == 0) or CEPGP_debugMode then
		local iString = CEPGP_getItemString(link);
		local name, _, _, _, _, _, _, _, slot, tex = GetItemInfo(iString);
		local id = CEPGP_getItemID(iString);
		CEPGP_distributing = true;
		CEPGP_toggleGPEdit(false);
		CEPGP_itemsTable = {};
		CEPGP_distItemLink = link;
		CEPGP_DistID = id;
		CEPGP_SendAddonMsg("CEPGP_setDistID;" .. id, "RAID");
		CEPGP_distSlot = slot;
		gp = _G[CEPGP_mode..'itemGP'..x]:GetText();
		CEPGP_lootSlot = slotNum;
		CEPGP_responses = {};
		CEPGP_UpdateLootScrollBar();		
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
		local rank = 0;
		for i = 1, GetNumGroupMembers() do
			if UnitName("player") == GetRaidRosterInfo(i) then
				_, rank = GetRaidRosterInfo(i);
			end
		end
		if CEPGP_raid_wide_dist then
			CEPGP_SendAddonMsg("RaidAssistLootDist;"..link..";"..gp..";true", "RAID");
		else
			CEPGP_SendAddonMsg("RaidAssistLootDist;"..link..";"..gp..";false", "RAID");
		end
		SendChatMessage("--------------------------", "RAID", CEPGP_LANGUAGE);
		if rank > 0 then
			if quantity > 1 then
				if CEPGP.Loot.RaidWarning then
					SendChatMessage("NOW DISTRIBUTING: x" .. quantity .. " " .. link, "RAID_WARNING", CEPGP_LANGUAGE);
				else
					SendChatMessage("NOW DISTRIBUTING: x" .. quantity .. " " .. link, "RAID", CEPGP_LANGUAGE);
				end
			else
				if CEPGP.Loot.RaidWarning then
					SendChatMessage("NOW DISTRIBUTING: " .. link, "RAID_WARNING", CEPGP_LANGUAGE);
				else
					SendChatMessage("NOW DISTRIBUTING: " .. link, "RAID", CEPGP_LANGUAGE);
				end
			end
		else
			if quantity > 1 then
				SendChatMessage("NOW DISTRIBUTING: x" .. quantity .. " " .. link, "RAID", CEPGP_LANGUAGE);
			else
				SendChatMessage("NOW DISTRIBUTING: " .. link, "RAID", CEPGP_LANGUAGE);
			end
		end
		if quantity > 1 then
			SendChatMessage("GP Value: " .. gp .. " (~" .. math.floor(gp/quantity) .. "GP per unit)", "RAID", CEPGP_LANGUAGE);
		else
			SendChatMessage("GP Value: " .. gp, "RAID", CEPGP_LANGUAGE);
		end

		SendChatMessage(CEPGP.Loot.Announcement, "RAID", CEPGP_LANGUAGE);
		if not CEPGP.Loot.HideKeyphrases then
			SendChatMessage(CEPGP_response_buttons[1][4] .. " : " .. CEPGP_response_buttons[1][2], "RAID", CEPGP_LANGUAGE);
			if CEPGP_response_buttons[2][1] then
				SendChatMessage(CEPGP_response_buttons[2][4] .. " : " .. CEPGP_response_buttons[2][2], "RAID", CEPGP_LANGUAGE);
			end
			if CEPGP_response_buttons[3][1] then
				SendChatMessage(CEPGP_response_buttons[3][4] .. " : " .. CEPGP_response_buttons[3][2], "RAID", CEPGP_LANGUAGE);
			end
			if CEPGP_response_buttons[4][1] then
				SendChatMessage(CEPGP_response_buttons[4][4] .. " : " .. CEPGP_response_buttons[4][2], "RAID", CEPGP_LANGUAGE);
			end
		end
		
		local keywords = {};
	
		for label, v in pairs(CEPGP.Loot.ExtraKeywords.Keywords) do
			local entry = {};
			for key, disc in pairs(v) do
				entry = {[1] = label, [2] = key, [3] = disc};
			end
			table.insert(keywords, entry);
		end
		
		keywords = CEPGP_tSort(keywords, 3, true);
		
		for k, v in ipairs(keywords) do
			SendChatMessage(v[1] .. " : " .. v[2], "RAID", CEPGP_LANGUAGE);
		end
	
		SendChatMessage("--------------------------", "RAID", CEPGP_LANGUAGE);
		
		
		local call = "CallItem;"..id..";"..gp;
		local buttons = {};
		if CEPGP_response_buttons[1][1] then
			call = call .. ";" .. CEPGP_response_buttons[1][2];
			buttons[1] = CEPGP_response_buttons[1][2];
		else
			call = call .. ";";
		end
		if CEPGP_response_buttons[2][1] then
			call = call .. ";" .. CEPGP_response_buttons[2][2];
			buttons[2] = CEPGP_response_buttons[2][2];
		else
			call = call .. ";";
		end
		if CEPGP_response_buttons[3][1] then
			call = call .. ";" .. CEPGP_response_buttons[3][2];
			buttons[3] = CEPGP_response_buttons[3][2];
		else
			call = call .. ";";
		end
		if CEPGP_response_buttons[4][1] then
			call = call .. ";" .. CEPGP_response_buttons[4][2];
			buttons[4] = CEPGP_response_buttons[4][2];
		else
			call = call .. ";";
		end
		call = call .. ";" .. tostring(CEPGP_response_time);
		CEPGP_callItem(id, gp, buttons, CEPGP_response_time);
		CEPGP_SendAddonMsg(call, "RAID");
			
		CEPGP_distribute:Show();
		CEPGP_loot:Hide();
		_G["CEPGP_distribute_item_name"]:SetText(link);
		_G["CEPGP_distribute_item_name_frame"]:SetScript('OnClick', function() SetItemRef(iString, name) end);
		_G["CEPGP_distribute_item_tex"]:SetScript('OnEnter', function() GameTooltip:SetOwner(_G["CEPGP_distribute_item_tex"], "ANCHOR_TOPLEFT") GameTooltip:SetHyperlink(iString) GameTooltip:Show() end);
		_G["CEPGP_distribute_item_texture"]:SetTexture(tex);
		_G["CEPGP_distribute_item_tex"]:SetScript('OnLeave', function() GameTooltip:Hide() end);
		_G["CEPGP_distribute_GP_value"]:SetText(gp);
	elseif GetLootMethod() == "master" then
		CEPGP_print("You are not the Loot Master.", 1);
		return;
	elseif GetLootMethod() ~= "master" then
		CEPGP_print("The loot method is not Master Looter", 1);
	end
end