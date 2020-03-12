local L = CEPGP_Locale:GetLocale("CEPGP");

function CEPGP_ListButton_OnClick(obj)
	if strfind(obj, "CEPGP_guild_reset") then
		CEPGP_context_popup_desc:SetPoint("TOP", CEPGP_context_popup_title, "BOTTOM", 0, -5);
	else
		CEPGP_context_popup_desc:SetPoint("TOP", CEPGP_context_popup_title, "BOTTOM", 0, -15);
	end
	if strfind(obj, "CEPGP_standby_ep_list_add") then
		_G["CEPGP_context_reason"]:Hide();
		_G["CEPGP_context_popup_reason"]:Hide();
	else
		_G["CEPGP_context_reason"]:Show();
		_G["CEPGP_context_popup_reason"]:Show();
	end
	
	if strfind(obj, "Delete") then
		
		local name = _G[_G[obj]:GetParent():GetName() .. "item"]:GetText();
		OVERRIDE_INDEX[name] = nil;
		CEPGP_print(name .. " |c006969FFremoved from the GP override list");
		CEPGP_UpdateOverrideScrollBar();
		return;
	end
	
	if strfind(obj, "TrafficButton") and strfind(obj, "Remove") then
		local id = string.sub(obj, 14, string.find(obj, "Remove")-1);
		local frame = _G["TrafficButton" .. id];
		if frame:GetAttribute("delete_confirm") == "true" then
			table.remove(TRAFFIC, tonumber(id));
			CEPGP_print("Traffic entry " .. id .. " purged.");
			CEPGP_UpdateTrafficScrollBar();
		else
			CEPGP_print("You are attempting to purge the following entry:");
			id = tonumber(id);
			if TRAFFIC[id][8] and string.find(TRAFFIC[id][8], "item:") then -- If an item is associated with the log
				CEPGP_print("Issuer: " .. TRAFFIC[id][2] .. ", Action: " .. TRAFFIC[id][3] .. ", Item: " .. TRAFFIC[id][8] .. " |c006969FF, Recipient: " .. TRAFFIC[id][1] .. "|r");
			else
				CEPGP_print("Issuer: " .. TRAFFIC[id][2] .. ", Action: " .. TRAFFIC[id][3] .. ", Recipient: " .. TRAFFIC[id][1]);
			end
			CEPGP_print("This action cannot be undone. To proceed, press the delete button again.");
			frame:SetAttribute("delete_confirm", "true");
		end
	end
	
	if obj == "CEPGP_options_standby_ep_award" then
		ShowUIPanel(CEPGP_context_popup);
		ShowUIPanel(CEPGP_context_amount);
		ShowUIPanel(CEPGP_context_popup_EP_check);
		HideUIPanel(CEPGP_context_popup_GP_check);
		_G["CEPGP_context_popup_EP_check_text"]:Show();
		_G["CEPGP_context_popup_GP_check_text"]:Hide();
		CEPGP_context_popup_EP_check:SetChecked(1);
		CEPGP_context_popup_GP_check:SetChecked(nil);
		CEPGP_context_popup_header:SetText("替补 EPGP 调节");
		CEPGP_context_popup_title:SetText("修改替补列表的EP");
		CEPGP_context_popup_desc:SetText("加/减 EP");
		CEPGP_context_amount:SetText("0");
		CEPGP_context_popup_confirm:SetScript('OnClick', function()
															if string.find(CEPGP_context_amount:GetText(), '[^0-9%-]') then
																CEPGP_print("输入有效数字", true);
															else
																PlaySound(799);
																HideUIPanel(CEPGP_context_popup);
																if CEPGP_context_popup_EP_check:GetChecked() then
																	CEPGP_addStandbyEP(tonumber(CEPGP_context_amount:GetText()), _, CEPGP_context_reason:GetText());
																end
															end
														end);
		return;
	
	elseif strfind(obj, "StandbyButton") then
		local name = _G[_G[_G[obj]:GetName()]:GetParent():GetName() .. "Info"]:GetText();
		for i = 1, CEPGP_ntgetn(CEPGP_standbyRoster) do
			if CEPGP_standbyRoster[i][1] == name then
				table.remove(CEPGP_standbyRoster, i);
				if CEPGP_isML() == 0 and CEPGP_standby_share then
					CEPGP_SendAddonMsg("StandbyListRemove;" .. CEPGP_standbyRoster[i][1]);
				end
				break;
			end
		end
		CEPGP_UpdateStandbyScrollBar();
		return;
	end
	
	if obj == "CEPGP_standby_ep_list_add" and (CanEditOfficerNote() or CEPGP_debugMode) then
		ShowUIPanel(CEPGP_context_popup);
		CEPGP_context_popup_EP_check:Hide();
		CEPGP_context_popup_GP_check:Hide();
		_G["CEPGP_context_popup_EP_check_text"]:Hide();
		_G["CEPGP_context_popup_GP_check_text"]:Hide();
		CEPGP_context_popup_header:SetText("添加到替补");
		CEPGP_context_popup_title:Hide();
		CEPGP_context_popup_desc:SetText("添加一个公会成员到替补");
		CEPGP_context_amount:SetText("");
		CEPGP_context_popup_confirm:SetScript('OnClick', function()
															PlaySound(799);
															HideUIPanel(CEPGP_context_popup);
															CEPGP_addToStandby(CEPGP_context_amount:GetText());
														end);
		return;
	end
	
	if obj == "CEPGP_standby_ep_list_addbyrank" then
		CEPGP_standby_addRank:Show();
	end
	if obj == "CEPGP_standby_addRank_confirm" then
		local ranks = {};
		for i = 1, 10 do
			if _G["CEPGP_standby_addRank_" .. i .. "_check"]:GetChecked() then
				ranks[i] = true;
			else
				ranks[i] = false;
			end
		end
		for i = 1, GetNumGuildMembers() do
			local name, _, rIndex = GetGuildRosterInfo(i);
			if string.find(name, "-") then
				name = string.sub(name, 0, string.find(name, "-")-1);
			end
			if ranks[rIndex+1] and not CEPGP_tContains(CEPGP_standbyRoster, name) and name ~= UnitName("player") then
				local _, class, rank, _, oNote, _, classFile = CEPGP_getGuildInfo(name);
				local EP,GP = CEPGP_getEPGP(oNote);
				CEPGP_standbyRoster[#CEPGP_standbyRoster+1] = {
					[1] = name,
					[2] = class,
					[3] = rank,
					[4] = rIndex,
					[5] = EP,
					[6] = GP,
					[7] = math.floor((tonumber(EP)/tonumber(GP))*100)/100,
					[8] = classFile
				};
				if CEPGP_standby_share then CEPGP_SendAddonMsg("StandbyListAdd;"..name..";"..class..";"..rank..";"..rIndex..";"..EP..";"..GP..";"..classFile, "RAID"); end
			end
		end
		CEPGP_UpdateStandbyScrollBar();
		CEPGP_standby_addRank:Hide();
	end
	if obj == "CEPGP_standby_ep_list_purge" then
		CEPGP_standbyRoster = {};
		CEPGP_UpdateStandbyScrollBar();
	end
	
	if not CanEditOfficerNote() and not CEPGP_debugMode then
		CEPGP_print("你没有权限修改EPGP", 1);
		return;
	end
	
	--[[ Distribution Menu ]]--
	if strfind(obj, "LootDistButton") then --A player in the distribution menu is clicked
		local discount;
		if _G[obj]:GetAttribute("response") then
			discount = CEPGP_response_buttons[tonumber(_G[obj]:GetAttribute("response"))][3];
			response = _G[obj]:GetAttribute("responseName");
			CEPGP_distribute_popup:SetAttribute("responseName", response);
			CEPGP_distribute_popup:SetAttribute("response", tonumber(_G[obj]:GetAttribute("response")));
		else
			discount = 0;
			CEPGP_distribute_popup:SetAttribute("responseName", nil);
			CEPGP_distribute_popup:SetAttribute("response", nil);
		end
		local gp = math.floor(CEPGP_distribute_GP_value:GetText());
		local discGP = math.floor(gp*((discount)/100));
		local player = _G[_G[obj]:GetName() .. "Info"]:GetText();
		ShowUIPanel(CEPGP_distribute_popup);
		if _G[obj]:GetAttribute("response") then
			CEPGP_distribute_popup_title:SetText(player .. " (" .. response .. ")");
			CEPGP_distribute_popup_gp_full:SetText("给予" .. gp .. "\n(全价)");
			if discount > 0 then
				CEPGP_distribute_popup_gp:SetText("给予" .. discGP .. "\n(" .. response .. ")");
				CEPGP_distribute_popup_gp:Show();
			else
				CEPGP_distribute_popup_gp:Hide();
			end
		else
			CEPGP_distribute_popup_title:SetText(player);
			CEPGP_distribute_popup_gp_full:SetText("给予" .. gp .. "\n(全价)");
			CEPGP_distribute_popup_gp:Hide();
		end
		CEPGP_distPlayer = _G[_G[obj]:GetName() .. "Info"]:GetText();
		CEPGP_distribute_popup:SetID(CEPGP_distribute:GetID()); --CEPGP_distribute:GetID gets the ID of the LOOT SLOT. Not the player.
		CEPGP_distribute_popup_gp:SetScript('OnClick', function()
			CEPGP_rate = (discount)/100;
			CEPGP_distGP = true;
			CEPGP_award = true;
			PlaySound(799);
			CEPGP_distribute_popup_give();
		end);
		CEPGP_distribute_popup_gp_full:SetScript('OnClick', function()
			CEPGP_rate = 1;
			CEPGP_distGP = true;
			CEPGP_award = true;
			PlaySound(799);
			CEPGP_distribute_popup_give();
		end);
		return;
	
		--[[ Guild Menu ]]--
	elseif strfind(obj, "GuildButton") then --A player from the guild menu is clicked (awards EP)
		local name = _G[_G[obj]:GetName() .. "Info"]:GetText();
		ShowUIPanel(CEPGP_context_popup);
		ShowUIPanel(CEPGP_context_amount);
		ShowUIPanel(CEPGP_context_popup_EP_check);
		ShowUIPanel(CEPGP_context_popup_GP_check);
		_G["CEPGP_context_popup_EP_check_text"]:Show();
		_G["CEPGP_context_popup_GP_check_text"]:Show();
		CEPGP_context_popup_EP_check:SetChecked(1);
		CEPGP_context_popup_GP_check:SetChecked(nil);
		CEPGP_context_popup_header:SetText("公会 调节");
		CEPGP_context_popup_title:SetText("修改 EP/GP：" .. name);
		CEPGP_context_popup_desc:SetText("加/减 EP");
		CEPGP_context_amount:SetText("0");
		CEPGP_context_popup_confirm:SetScript('OnClick', function()
															if string.find(CEPGP_context_amount:GetText(), '[^0-9%-]') then
																CEPGP_print("输入有效数字", true);
															else
																PlaySound(799);
																HideUIPanel(CEPGP_context_popup);
																if CEPGP_context_popup_EP_check:GetChecked() then
																	CEPGP_addEP(name, tonumber(CEPGP_context_amount:GetText()), CEPGP_context_reason:GetText());
																else
																	CEPGP_addGP(name, tonumber(CEPGP_context_amount:GetText()), nil, nil, CEPGP_context_reason:GetText());
																end
															end
														end);
		return;
		
	elseif strfind(obj, "CEPGP_guild_add_EP") then --Click the Add Guild EP button in the Guild menu
		ShowUIPanel(CEPGP_context_popup);
		ShowUIPanel(CEPGP_context_amount);
		ShowUIPanel(CEPGP_context_popup_EP_check);
		HideUIPanel(CEPGP_context_popup_GP_check);
		_G["CEPGP_context_popup_EP_check_text"]:Show();
		_G["CEPGP_context_popup_GP_check_text"]:Hide();
		CEPGP_context_popup_EP_check:SetChecked(1);
		CEPGP_context_popup_GP_check:SetChecked(nil);
		CEPGP_context_popup_header:SetText("公会 调节");
		CEPGP_context_popup_title:SetText("修改公会EP/GP");
		CEPGP_context_popup_desc:SetText("加减 EP 为所有公会成员");
		CEPGP_context_amount:SetText("0");
		CEPGP_context_popup_confirm:SetScript('OnClick', function()
															if string.find(CEPGP_context_amount:GetText(), '[^0-9%-]') then
																CEPGP_print("输入有效数字", true);
															else
																PlaySound(799);
																HideUIPanel(CEPGP_context_popup);
																CEPGP_addGuildEP(tonumber(CEPGP_context_amount:GetText()), CEPGP_context_reason:GetText());
															end
														end);
		return;
	
	elseif strfind(obj, "CEPGP_guild_decay") then --Click the Decay Guild EPGP button in the Guild menu
		ShowUIPanel(CEPGP_context_popup);
		ShowUIPanel(CEPGP_context_amount);
		HideUIPanel(CEPGP_context_popup_EP_check);
		HideUIPanel(CEPGP_context_popup_GP_check);
		_G["CEPGP_context_popup_EP_check_text"]:Hide();
		_G["CEPGP_context_popup_GP_check_text"]:Hide();
		CEPGP_context_popup_EP_check:SetChecked(nil);
		CEPGP_context_popup_GP_check:SetChecked(nil);
		CEPGP_context_popup_header:SetText("公会 调节");
		CEPGP_context_popup_title:SetText("衰减公会EPGP");
		CEPGP_context_popup_desc:SetText("使EPGP分数衰减/上升一个百分比");
		CEPGP_context_amount:SetText("0");
		CEPGP_context_popup_confirm:SetScript('OnClick', function()
															if string.find(CEPGP_context_amount:GetText(), '^[0-9]+$') or string.find(CEPGP_context_amount:GetText(), '^[0-9]+.[0-9]+$') or
																string.find(CEPGP_context_amount:GetText(), '^-[0-9]+$') or string.find(CEPGP_context_amount:GetText(), '^-[0-9]+.[0-9]+$') then
																PlaySound(799);
																HideUIPanel(CEPGP_context_popup);
																CEPGP_decay(tonumber(CEPGP_context_amount:GetText()), CEPGP_context_reason:GetText());
															else
																CEPGP_print("输入有效数字", true);
															end
														end);
		return;
		
	elseif strfind(obj, "CEPGP_guild_reset") then --Click the Reset All EPGP Standings button in the Guild menu
		ShowUIPanel(CEPGP_context_popup);
		HideUIPanel(CEPGP_context_amount);
		HideUIPanel(CEPGP_context_popup_EP_check);
		HideUIPanel(CEPGP_context_popup_GP_check);
		_G["CEPGP_context_popup_EP_check_text"]:Hide();
		_G["CEPGP_context_popup_GP_check_text"]:Hide();
		CEPGP_context_popup_EP_check:SetChecked(nil);
		CEPGP_context_popup_GP_check:SetChecked(nil);
		CEPGP_context_popup_header:SetText("公会 调节");
		CEPGP_context_popup_title:SetText("重置公会EPGP");
		CEPGP_context_popup_desc:SetText("重置公会EPGP积分\n|c00FF0000你确定这就是你想做的吗？\n这是不可逆的！\n注意：这将向公会聊天频道报告|r");
		CEPGP_context_popup_confirm:SetScript('OnClick', function()
															PlaySound(799);
															HideUIPanel(CEPGP_context_popup);
															CEPGP_resetAll(CEPGP_context_reason:GetText());
														end)
		return;
		
		--[[ Raid Menu ]]--
	elseif strfind(obj, "RaidButton") then --A player from the raid menu is clicked (awards EP)
		local name = _G[_G[obj]:GetName() .. "Info"]:GetText();
		if not CEPGP_getGuildInfo(name) then
			CEPGP_print(name .. " 不是公会成员 - 无法奖惩EPGP", true);
			return;
		end
		ShowUIPanel(CEPGP_context_popup);
		ShowUIPanel(CEPGP_context_amount);
		ShowUIPanel(CEPGP_context_popup_EP_check);
		ShowUIPanel(CEPGP_context_popup_GP_check);
		_G["CEPGP_context_popup_EP_check_text"]:Show();
		_G["CEPGP_context_popup_GP_check_text"]:Show();
		CEPGP_context_popup_EP_check:SetChecked(1);
		CEPGP_context_popup_GP_check:SetChecked(nil);
		CEPGP_context_popup_header:SetText("团队 调节");
		CEPGP_context_popup_title:SetText("修改 EP/GP : " .. name);
		CEPGP_context_popup_desc:SetText("加/减 EP");
		CEPGP_context_amount:SetText("0");
		CEPGP_context_popup_confirm:SetScript('OnClick', function()
															if string.find(CEPGP_context_amount:GetText(), '[^0-9%-]') then
																CEPGP_print("Enter a valid number", true);
															else
																PlaySound(799);
																HideUIPanel(CEPGP_context_popup);
																if CEPGP_context_popup_EP_check:GetChecked() then
																	CEPGP_addEP(name, tonumber(CEPGP_context_amount:GetText()), CEPGP_context_reason:GetText());
																else
																	CEPGP_addGP(name, tonumber(CEPGP_context_amount:GetText()), nil, nil, CEPGP_context_reason:GetText());
																end
															end
														end);
		return;
	
	elseif strfind(obj, "CEPGP_raid_add_EP") then --Click the Add Raid EP button in the Raid menu
		ShowUIPanel(CEPGP_context_popup);
		ShowUIPanel(CEPGP_context_amount);
		HideUIPanel(CEPGP_context_popup_EP_check);
		HideUIPanel(CEPGP_context_popup_GP_check);
		_G["CEPGP_context_popup_EP_check_text"]:Hide();
		_G["CEPGP_context_popup_GP_check_text"]:Hide();
		CEPGP_context_popup_EP_check:SetChecked(nil);
		CEPGP_context_popup_GP_check:SetChecked(nil);
		CEPGP_context_popup_header:SetText("团队 调节");
		CEPGP_context_popup_title:SetText("修改团队 EP");
		CEPGP_context_popup_desc:SetText("为整个RAID添加/减去一定数量的EP");
		CEPGP_context_amount:SetText("0");
		CEPGP_context_popup_confirm:SetScript('OnClick', function()
															if string.find(CEPGP_context_amount:GetText(), '[^0-9%-]') then
																CEPGP_print("Enter a valid number", true);
															else
																PlaySound(799);
																HideUIPanel(CEPGP_context_popup);
																CEPGP_AddRaidEP(tonumber(CEPGP_context_amount:GetText()), CEPGP_context_reason:GetText());
															end
														end);
		return;
	end
end

function CEPGP_setOverrideLink(frame, event)
	
	if event == "enter" then
		local _, link = GetItemInfo(frame:GetText());
		GameTooltip:SetOwner(frame, "ANCHOR_TOPLEFT");
		GameTooltip:SetHyperlink(link);
		GameTooltip:Show()
	else
		GameTooltip:Hide();
	end
end

function CEPGP_distribute_popup_give()
	for i = 1, 40 do
		if GetMasterLootCandidate(CEPGP_lootSlot, i) == CEPGP_distPlayer then
			GiveMasterLoot(CEPGP_lootSlot, i);
			return;
		end
	end
	CEPGP_print(CEPGP_distPlayer .. " 不在战利品候选名单上", true);
end

function CEPGP_distribute_popup_OnEvent(event, msg, name)
	if CEPGP_distributing then
		if event == "UI_ERROR_MESSAGE" and arg1 == "物品栏已满。" and CEPGP_distPlayer ~= "" then
			CEPGP_print(CEPGP_distPlayer .. "的物品栏已满。", 1);
			CEPGP_distribute_popup:Hide();
			CEPGP_award = false;
		elseif event == "UI_ERROR_MESSAGE" and arg1 == "你不能再携带那件装备了。" and CEPGP_distPlayer ~= "" then
			CEPGP_print(CEPGP_distPlayer .. " 不能再带那件独特的装备了", 1);
			CEPGP_distribute_popup:Hide();
			CEPGP_award = false;
		end
	end
end

		--[[ Restore DropDown ]]--

function CEPGP_initRestoreDropdown(frame, level, menuList)
	for k, _ in pairs(RECORDS) do
		local info = {text = k, func = CEPGP_restoreDropdownOnClick};
		local entry = UIDropDownMenu_AddButton(info);
	end
end

function CEPGP_restoreDropdownOnClick(self, arg1, arg2, checked)
	if (not checked) then
		UIDropDownMenu_SetSelectedName(CEPGP_restoreDropdown, self:GetText());
	end
end

		--[[ Sync Rank DropDown ]]--
		
function CEPGP_syncRankDropdown(frame, level, menuList)
	for i = 1, 10, 1 do
		if GuildControlGetRankName(i) ~= "" then
			local info = {text = GuildControlGetRankName(i), value = i, func = CEPGP_syncRankChange}; --Value is used as the guild rank index as ranks can have identical names
			local entry = UIDropDownMenu_AddButton(info);
		end
	end
	UIDropDownMenu_SetSelectedName(CEPGP_sync_rank, GuildControlGetRankName(CEPGP_force_sync_rank));
	UIDropDownMenu_SetSelectedValue(CEPGP_sync_rank, CEPGP_force_sync_rank);
end

function CEPGP_syncRankChange(self, arg1, arg2, checked)
	if (not checked) then
		UIDropDownMenu_SetSelectedName(CEPGP_sync_rank, self:GetText());
		UIDropDownMenu_SetSelectedValue(CEPGP_sync_rank, self.value);
		CEPGP_force_sync_rank = self.value;
		CEPGP_print("Updated forced synchronisation rank");
	end
end

		--[[ Attendance DropDown ]]--
		
function CEPGP_attendanceDropdown(frame, level, menuList)
	local info = {text = "Guild List", value = 0, func = CEPGP_attendanceChange};
	local entry = UIDropDownMenu_AddButton(info);
	for i = 1, CEPGP_ntgetn(CEPGP_raid_logs) do
		local info = {text = date("%d/%m/%Y %H:%M", CEPGP_raid_logs[i][1]), value = i, func = CEPGP_attendanceChange};
		local entry = UIDropDownMenu_AddButton(info);
	end
end

function CEPGP_attendanceChange(self, arg1, arg2, checked)
	if (not checked) then
		UIDropDownMenu_SetSelectedName(CEPGP_attendance_dropdown, self:GetText());
		UIDropDownMenu_SetSelectedValue(CEPGP_attendance_dropdown, self.value);
	end
end

		--[[ Minimum Threshold DropDown ]]--

function CEPGP_minThresholdDropdown(frame, level, menuList)
	local rarity = {
		[0] = "|cFF9D9D9D灰色|r",
		[1] = "|cFFFFFFFF白色|r",
		[2] = "|cFF1EFF00绿色|r",
		[3] = "|cFF0070DD蓝色|r",
		[4] = "|cFFA335EE紫色|r",
		[5] = "|cFFFF8000橙色|r"
	};
	for i = 0, 5 do
		local info = {
			text = rarity[i],
			value = i,
			func = CEPGP_minThresholdChange
		};
		local entry = UIDropDownMenu_AddButton(info);
	end
	UIDropDownMenu_SetSelectedName(CEPGP_min_threshold_dropdown, rarity[CEPGP_min_threshold]);
	UIDropDownMenu_SetSelectedValue(CEPGP_min_threshold_dropdown, CEPGP_min_threshold);
end

function CEPGP_minThresholdChange(self, value)
	UIDropDownMenu_SetSelectedName(CEPGP_min_threshold_dropdown, self:GetText());
	UIDropDownMenu_SetSelectedValue(CEPGP_min_threshold_dropdown, self.value);
	CEPGP_min_threshold = self.value;
	CEPGP_print("最小自动显示阈值现在设置为 " .. self:GetText());
end

		--[[ Default Channel DropDown ]]--
		
function CEPGP_defChannelDropdown(frame, level, menuList)
	local channels = {
		[1] = L["Party"],
		[2] = L["Raid"],
		[3] = L["Guild"],
		[4] = L["Officer"],
	};
	for index, value in ipairs(channels) do
		local info = {
			text = value,
			value = index,
			func = CEPGP_defChannelChange
		};
		local entry = UIDropDownMenu_AddButton(info);
	end
	for i = 1, #channels do
		if string.lower(CHANNEL) == string.lower(channels[i]) then
			UIDropDownMenu_SetSelectedName(CEPGP_def_channel_dropdown, channels[i]);
			UIDropDownMenu_SetSelectedValue(CEPGP_def_channel_dropdown, i);
		end
	end
end

function CEPGP_defChannelChange(self, value)
	UIDropDownMenu_SetSelectedName(CEPGP_def_channel_dropdown, self:GetText());
	UIDropDownMenu_SetSelectedValue(CEPGP_def_channel_dropdown, self.value);
	CHANNEL = self:GetText();
	CEPGP_print("报告频道设为 \"" .. CHANNEL .. "\".");
end

		--[[ Loot Response Channel DropDown ]]--
		
function CEPGP_lootChannelDropdown(frame, level, menuList)
	local channels = {
		[1] = L["Party"],
		[2] = L["Raid"],
		[3] = L["Guild"],
		[4] = L["Officer"],
	};
	for index, value in ipairs(channels) do
		local info = {
			text = value,
			value = index,
			func = CEPGP_lootChannelChange
		};
		local entry = UIDropDownMenu_AddButton(info);
	end
	for i = 1, #channels do
		if string.lower(CEPGP_lootChannel) == string.lower(channels[i]) then
			UIDropDownMenu_SetSelectedName(CEPGP_loot_channel_dropdown, channels[i]);
			UIDropDownMenu_SetSelectedValue(CEPGP_loot_channel_dropdown, i);
		end
	end
end

function CEPGP_lootChannelChange(self, value)
	UIDropDownMenu_SetSelectedName(CEPGP_loot_channel_dropdown, self:GetText());
	UIDropDownMenu_SetSelectedValue(CEPGP_loot_channel_dropdown, self.value);
	CEPGP_lootChannel = self:GetText();
	CEPGP_print("战利品响应通道设置为 \"" .. CEPGP_lootChannel .. "\".");
end