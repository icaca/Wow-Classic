local L = CEPGP_Locale:GetLocale("CEPGP");

function CEPGP_ListButton_OnClick(obj, button)
	if button == "LeftButton" then
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
		
		if strfind(obj, "overrideButton") and strfind(obj, "Delete") then
			
			local name = _G[_G[obj]:GetParent():GetName() .. "item"]:GetText();
			OVERRIDE_INDEX[name] = nil;
			CEPGP_print(name .. " |c006969FFremoved from the GP override list");
			CEPGP_UpdateOverrideScrollBar();
			return;
		end
		
		if strfind(obj, "keywordButton") and strfind(obj, "Delete") then
			local parent = _G[obj]:GetParent();
			CEPGP.Loot.ExtraKeywords.Keywords[_G[parent:GetName() .. "Label"]:GetText()] = nil;
			CEPGP_UpdateKeywordScrollBar();
			return;
		end
		
		if strfind(obj, "TrafficButton") and strfind(obj, "Remove") then
			local id = string.sub(obj, 14, string.find(obj, "Remove")-1);
			local frame = _G["TrafficButton" .. id];
			local page = CEPGP_traffic:GetAttribute("page");
			local entry = #TRAFFIC - (500-id) - (page*500);
			if frame:GetAttribute("delete_confirm") == "true" then
				table.remove(TRAFFIC, tonumber(entry));
				CEPGP_print("EPGP详情目录 " .. entry .. " 清除.");
				CEPGP_UpdateTrafficScrollBar();
			else
				local function verify(tLog)
					for i = 1, 8 do
						if not tLog[i] then return false; end
					end
					return true;
				end
				if verify(TRAFFIC[entry]) then
					CEPGP_print("您正试图清除以下条目：");
					if TRAFFIC[entry][8] and string.find(TRAFFIC[entry][8], "item:") then -- If an item is associated with the log
						CEPGP_print("管理者: " .. TRAFFIC[entry][2] .. ", 动作: " .. TRAFFIC[entry][3] .. ", 装备: " .. TRAFFIC[entry][8] .. " |c006969FF, 玩家: " .. TRAFFIC[entry][1] .. "|r");
					else
						CEPGP_print("管理者: " .. TRAFFIC[entry][2] .. ", 动作: " .. TRAFFIC[entry][3] .. ", 玩家: " .. TRAFFIC[entry][1]);
					end
				else
					CEPGP_print("您试图清除EPGP详情目录.");
				end
				CEPGP_print("此操作无法撤消。若要继续，请再次按“删除”按钮。");
				frame:SetAttribute("delete_confirm", "true");
			end
			return;
		end
		
		if strfind(obj, "TrafficButton") and strfind(obj, "Share") then
			local entry = tonumber(string.sub(obj, 14, string.find(obj, "Share")-1));
			local ID, GUID = TRAFFIC[entry][10], TRAFFIC[entry][11];
			if ID and GUID then
				CEPGP_ShareTraffic(ID, GUID);
			end
			return;
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
			CEPGP_context_popup_header:SetText("替补EP调节");
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
																		CEPGP_addStandbyEP(tonumber(CEPGP_context_amount:GetText()), nil, CEPGP_context_reason:GetText());
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
		
		if obj == "CEPGP_exclude_rank_confirm" then
			local changes = false;
			for i = 1, 10 do
				if CEPGP.Exclusions[i] ~= _G["CEPGP_exclude_rank_" .. i .. "_check"]:GetChecked() then
					CEPGP.Exclusions[i] = not CEPGP.Exclusions[i];
					changes = true;
				end
			end
			if changes then
				CEPGP_print("更新的EPGP会阶排除");
				CEPGP_roster = {};
				CEPGP_Info.NumExcluded = 0;
				CEPGP_rosterUpdate("GUILD_ROSTER_UPDATE");
				
				for i = 1, GetNumGuildMembers() do
					local _, _, rankIndex = GetGuildRosterInfo(i);
					if CEPGP.Exclusions[rankIndex+1] then
						CEPGP_Info.NumExcluded = CEPGP_Info.NumExcluded + 1;
					end
				end
			end
			CEPGP_rank_exclude:Hide();
			return;
		end
		
		if obj == "CEPGP_standby_ep_list_add" and (CanEditOfficerNote() or CEPGP_Info.Debug) then
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
			local function addRankToStandby()
				local group = {};
				local ranks = {};
				
				for i = 1, GetNumGroupMembers() do
					local name = GetRaidRosterInfo(i);
					table.insert(group, name);
				end
				for i = 1, 10 do
					if _G["CEPGP_standby_addRank_" .. i .. "_check"]:GetChecked() then
						ranks[i] = true;
					else
						ranks[i] = false;
					end
				end
				for i = 1, GetNumGuildMembers() do
					local name, _, rIndex = GetGuildRosterInfo(i);
					name = Ambiguate(name, "all");
					if ranks[rIndex+1] and not CEPGP_tContains(CEPGP_standbyRoster, name) and not CEPGP_tContains(group, name) and name ~= UnitName("player") then
						local _, class, rank, _, oNote, _, classFile = CEPGP_getGuildInfo(name);
						local EP,GP = CEPGP_getEPGP(name, i);
						CEPGP_standbyRoster[#CEPGP_standbyRoster+1] = {
							[1] = name,
							[2] = class,
							[3] = rank,
							[4] = rIndex,
							[5] = EP,
							[6] = GP,
							[7] = math.floor((tonumber(EP)*100/tonumber(GP)))/100,
							[8] = classFile
						};
						if CEPGP_standby_share then
							CEPGP_SendAddonMsg("StandbyListAdd;"..name..";"..class..";"..rank..";"..rIndex..";"..EP..";"..GP..";"..classFile, "RAID");
						end
					end
				end
				CEPGP_UpdateStandbyScrollBar();
			end
			
			if CEPGP_ntgetn(CEPGP_roster) < (GetNumGuildMembers() - CEPGP_Info.NumExcluded) and CEPGP_Info.Polling then
				CEPGP_print("正在扫描公会名册。将很快将该会阶添加到替补列表");
				local callback = function() addRankToStandby() end;
				table.insert(CEPGP_Info.RosterStack, callback);
			else
				addRankToStandby();
			end
			CEPGP_standby_addRank:Hide();
			return;
		end
		if obj == "CEPGP_standby_ep_list_purge" then
			CEPGP_standbyRoster = {};
			CEPGP_UpdateStandbyScrollBar();
		end
		
		if not CanEditOfficerNote() and not CEPGP_Info.Debug then
			CEPGP_print("你没有权限修改EPGP", 1);
			return;
		end
		
		--[[ Distribution Menu ]]--
		if strfind(obj, "LootDistButton") then --A player in the distribution menu is clicked
			local discount, response, reason;
			if _G[obj]:GetAttribute("response") then
				local attr = _G[obj]:GetAttribute("response");
				response = _G[obj]:GetAttribute("responseName");
				response = CEPGP_indexToLabel(response);
				reason = CEPGP_response_buttons[attr] and CEPGP_response_buttons[attr][2] or response;
				discount = (CEPGP.Loot.ExtraKeywords.Keywords[attr] and CEPGP_getDiscount(attr)) or (CEPGP_response_buttons[attr] and CEPGP_response_buttons[attr][3]) or CEPGP_getDiscount(CEPGP_indexToLabel(attr));
				CEPGP_distribute_popup:SetAttribute("responseName", reason);
				CEPGP_distribute_popup:SetAttribute("response", attr);
			else
				discount = 0;
				CEPGP_distribute_popup:SetAttribute("responseName", nil);
				CEPGP_distribute_popup:SetAttribute("response", nil);
			end
			local gp = math.floor(CEPGP_distribute_GP_value:GetText());
			local discGP = math.floor(gp*((discount)/100));
			local player = _G[_G[obj]:GetName() .. "Info"]:GetText();
			local index = CEPGP_getIndex(player);
			if index then
				local rankIndex = select(3, GetGuildRosterInfo(index));
				if CEPGP.Exclusions[rankIndex+1] then
					discGP = 0;
					discount = 100;
					reason = "Exclusion List";
					CEPGP_distribute_popup:SetAttribute("responseName", "Exclusion List");
				end
			end
			ShowUIPanel(CEPGP_distribute_popup);
			if reason then
				if reason == "Exclusion List" then
					CEPGP_distribute_popup_title:SetText(player .. " (排除列表)");
					CEPGP_distribute_popup_gp_full:Hide();
					CEPGP_distribute_popup_gp:Show();
					CEPGP_distribute_popup_gp:SetText("给予 " .. discGP .. "\n(" .. reason .. ")");
				else
					CEPGP_distribute_popup_title:SetText(player .. " (" .. reason .. ")");
					CEPGP_distribute_popup_gp_full:Show();
					CEPGP_distribute_popup_gp_full:SetText("给予 " .. gp .. "\n(全价)");
					if discount ~= 0 then
						CEPGP_distribute_popup_gp:SetText("给予 " .. discGP .. "\n(" .. reason .. ")");
						CEPGP_distribute_popup_gp:Show();
					else
						CEPGP_distribute_popup_gp:Hide();
					end
				end
			else
				CEPGP_distribute_popup_title:SetText(player);
				CEPGP_distribute_popup_gp_full:SetText("给予 " .. gp .. "\n(全价)");
				CEPGP_distribute_popup_gp:Hide();
			end
			
			CEPGP_distribute_popup_gp:SetScript('OnClick', function()
				CEPGP_distPlayer = _G[_G[obj]:GetName() .. "Info"]:GetText();
				CEPGP_distribute_popup:SetID(CEPGP_distribute:GetID()); --CEPGP_distribute:GetID gets the ID of the LOOT SLOT. Not the player.
				CEPGP_rate = (discount)/100;
				if reason == "Exclusion List" then
					CEPGP_distGP = false;
				else
					CEPGP_distGP = true;
				end
				CEPGP_award = true;
				PlaySound(799);
				CEPGP_distribute_popup_give();
			end);
			CEPGP_distribute_popup_gp_full:SetScript('OnClick', function()
				reason = "Full Price";
				CEPGP_distribute_popup:SetAttribute("responseName", reason);
				CEPGP_distribute_popup:SetAttribute("response", tonumber(_G[obj]:GetAttribute("response")));
				CEPGP_distPlayer = _G[_G[obj]:GetName() .. "Info"]:GetText();
				CEPGP_distribute_popup:SetID(CEPGP_distribute:GetID());
				CEPGP_rate = 1;
				CEPGP_distGP = true;
				CEPGP_award = true;
				PlaySound(799);
				CEPGP_distribute_popup_give();
			end);
			CEPGP_distribute_popup_free:SetScript('OnClick', function()
				CEPGP_distPlayer = _G[_G[obj]:GetName() .. "Info"]:GetText();
				CEPGP_distribute_popup:SetID(CEPGP_distribute:GetID());
				CEPGP_rate = 1;
				CEPGP_award = true;
				CEPGP_distGP = false;
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
			CEPGP_context_popup_header:SetText("公会成员EP调节");
			CEPGP_context_popup_title:SetText("修改EP： " .. name);
			CEPGP_context_popup_desc:SetText("加/减EP");
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
			CEPGP_context_popup_header:SetText("公会调节");
			CEPGP_context_popup_title:SetText("修改公会EP");
			CEPGP_context_popup_desc:SetText("为加减EP所有公会成员");
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
			CEPGP_decay_popup:Show();
			CEPGP_decay_popup_reason:SetText("");
			CEPGP_decay_popup_amount:SetText("0");
			local EP, GP; -- Whether or not this is an EP or GP specific decay
			if obj == "CEPGP_guild_decay_EP" then
				CEPGP_decay_popup_header:SetText("衰变公会EP");
				EP = true;
			elseif obj == "CEPGP_guild_decay_GP" then
				CEPGP_decay_popup_header:SetText("衰变公会GP");
				GP = true;
			else
				CEPGP_decay_popup_header:SetText("衰变公会EPGP");
			end
			CEPGP_decay_popup_desc:SetText("正数衰减|负数膨胀");
			CEPGP_decay_popup_confirm:SetScript('OnClick', function()
				local amount = CEPGP_decay_popup_amount:GetText();
				local fixed = CEPGP_decay_popup_fixed_check:GetChecked();
				local reason = CEPGP_decay_popup_reason:GetText();
				if (string.find(amount, '^[0-9]+$') or string.find(amount, '^[0-9]+.[0-9]+$') or
					string.find(amount, '^-[0-9]+$') or string.find(amount, '^-[0-9]+.[0-9]+$')) and
					amount ~= "0" then
					PlaySound(799);
					CEPGP_decay_popup:Hide();
					CEPGP_decay(tonumber(amount), reason, EP, GP, fixed);
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
			CEPGP_context_popup_header:SetText("公会EPGP重置");
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
				CEPGP_print(name .. " 不是公会成员-不能授予EP或GP", true);
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
			CEPGP_context_popup_header:SetText("团队调整");
			CEPGP_context_popup_title:SetText("修改EP/GP" .. name);
			CEPGP_context_popup_desc:SetText("为整个团队添加/减去EP");
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
		
		elseif strfind(obj, "CEPGP_raid_add_EP") then --Click the Add Raid EP button in the Raid menu
			CEPGP_award_raid_popup:Show();
			CEPGP_award_raid_popup_amount:SetText("0");
			CEPGP_award_raid_popup_confirm:SetScript('OnClick', function()
				local standby = CEPGP_award_raid_popup_standby_check:GetChecked();
				local amount = tonumber(CEPGP_award_raid_popup_amount:GetText());
				local reason = CEPGP_award_raid_popup_reason:GetText();
				if string.find(CEPGP_award_raid_popup_amount:GetText(), '[^0-9%-]') then
					CEPGP_print("输入有效数字", true);
				else
					PlaySound(799);
					CEPGP_award_raid_popup:Hide();
					CEPGP_AddRaidEP(amount, reason);
					if standby then
						CEPGP_addStandbyEP(amount, nil, reason);
					end
				end
			end);
			return;
		end
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
	CEPGP_print(CEPGP_distPlayer .. "不在战利品候选名单上", true);
	CEPGP_distPlayer = "";
end

function CEPGP_distribute_popup_OnEvent(eCode)
	
	--[[	Error Codes:
		2		Player's inventory is full
		22		Player already has one of the unique item
	]]
	
	if CEPGP_distributing then
		if eCode == 2 then
			CEPGP_print(CEPGP_distPlayer .. "的物品栏已满。", 1);
			CEPGP_distribute_popup:Hide();
			CEPGP_distPlayer = "";
			CEPGP_award = false;
			
		elseif eCode == 22 then
			CEPGP_print(CEPGP_distPlayer .. " 不能再带这件唯一属性的装备了", 1);
			CEPGP_distribute_popup:Hide();
			CEPGP_distPlayer = "";
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
	local init = false;
	for i = 1, 10, 1 do
		if GuildControlGetRankName(i) ~= "" then
			local info = {
				text = GuildControlGetRankName(i),
				value = i,
				func = CEPGP_syncRankChange
			}; --Value is used as the guild rank index as ranks can have identical names
			UIDropDownMenu_AddButton(info);	--TAINTED
			init = true;
		end
	end
	if init then
		UIDropDownMenu_SetSelectedName(CEPGP_interface_options_forced_sync_rank, GuildControlGetRankName(CEPGP_force_sync_rank));
		--UIDropDownMenu_SetSelectedValue(CEPGP_interface_options_forced_sync_rank, CEPGP_force_sync_rank);
	end
end

function CEPGP_syncRankChange(self, arg1, arg2, checked)
	if (not checked) then
		UIDropDownMenu_SetSelectedName(CEPGP_interface_options_forced_sync_rank, self:GetText());
		--UIDropDownMenu_SetSelectedValue(CEPGP_interface_options_forced_sync_rank, self.value);
		CEPGP_force_sync_rank = self.value;
		CEPGP.Sync[2] = self.value;
		CEPGP_print("更新的配置管理状态");
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
	UIDropDownMenu_SetSelectedName(CEPGP_min_threshold_dropdown, rarity[CEPGP.Loot.MinThreshold]);
	--UIDropDownMenu_SetSelectedValue(CEPGP.Loot.MinThreshold_dropdown, CEPGP.Loot.MinThreshold);
end

function CEPGP_minThresholdChange(self, value)
	UIDropDownMenu_SetSelectedName(CEPGP_min_threshold_dropdown, self:GetText());
	--UIDropDownMenu_SetSelectedValue(CEPGP.Loot.MinThreshold_dropdown, self.value);
	CEPGP.Loot.MinThreshold = self.value;
	CEPGP_print("最小自动显示阈值现在设置为" .. self:GetText());
end

		--[[ Default Channel DropDown ]]--
		
function CEPGP_defChannelDropdown(frame, level, menuList)
	local channels = {
		[1] = "Party",
		[2] = "Raid",
		[3] = "Guild",
		[4] = "Officer"
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
			UIDropDownMenu_SetSelectedName(CEPGP_interface_options_def_channel_dropdown, channels[i]);
		end
	end
end

function CEPGP_defChannelChange(self, value)
	UIDropDownMenu_SetSelectedName(CEPGP_interface_options_def_channel_dropdown, self:GetText());
	--UIDropDownMenu_SetSelectedValue(CEPGP_interface_options_def_channel_dropdown, self.value);
	CHANNEL = self:GetText();
	CEPGP.Channel = self:GetText();
	CEPGP_print("报告频道设为 \"" .. CHANNEL .. "\".");
end

		--[[ Loot Response Channel DropDown ]]--
		
function CEPGP_lootChannelDropdown(frame, level, menuList)
	local channels = {
		[1] = "Party",
		[2] = "Raid",
		[3] = "Guild",
		[4] = "Officer"
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
		if string.lower(CEPGP.LootChannel) == string.lower(channels[i]) then
			UIDropDownMenu_SetSelectedName(CEPGP_loot_channel_dropdown, channels[i]);
			--UIDropDownMenu_SetSelectedValue(CEPGP_loot_channel_dropdown, i);
		end
	end
end

function CEPGP_lootChannelChange(self, value)
	UIDropDownMenu_SetSelectedName(CEPGP_loot_channel_dropdown, self:GetText());
	--UIDropDownMenu_SetSelectedValue(CEPGP_loot_channel_dropdown, self.value);
	CEPGP.LootChannel = self:GetText();
	CEPGP_print("战利品响应通道设置为 \"" .. CEPGP.LootChannel .. "\".");
end