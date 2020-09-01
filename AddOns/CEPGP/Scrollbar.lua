function CEPGP_UpdateLootScrollBar(PRsort, sort)
	local tempTable = {};
	local count = 1;
	CEPGP_Info.LastRun.DistSB = GetTime();
	local call = CEPGP_Info.LastRun.DistSB;
	local quit = false;
	for name, _ in pairs(CEPGP_itemsTable) do
		local roll = math.ceil(math.random(0, 100));
		local EP, GP;
		if CEPGP_roster[name] then
			local index = CEPGP_getIndex(name);
			EP, GP = CEPGP_getEPGP(name, index);
			GP = math.max(math.floor(GP), CEPGP.GP.Min);
			tempTable[count] = {
				[1] = name,
				[2] = CEPGP_roster[name][2], --Class
				[3] = CEPGP_roster[name][3], --Rank
				[4] = CEPGP_roster[name][4], --RankIndex
				[5] = EP,
				[6] = GP,
				[7] = math.floor((tonumber(EP)*100/tonumber(GP)))/100,
				[8] = CEPGP_itemsTable[name][1] or "noitem",
				[9] = CEPGP_itemsTable[name][2] or "noitem",
				[10] = CEPGP_roster[name][7], --className in English
				[11] = CEPGP_itemsTable[name][3], -- Loot response
				[12] = CEPGP_itemsTable[name][4]
			};
		else
			local index = CEPGP_getIndex(name);
			if index then
				local _, rank, rankIndex, _, class, _, _, _, _, _, classFileName = GetGuildRosterInfo(index);
				EP, GP = CEPGP_getEPGP(name, index);
				tempTable[count] = {
					[1] = name,
					[2] = class,
					[3] = rank,
					[4] = rankIndex,
					[5] = EP,
					[6] = GP,
					[7] = math.floor((tonumber(EP)*100/tonumber(GP)))/100,
					[8] = CEPGP_itemsTable[name][1] or "noitem",
					[9] = CEPGP_itemsTable[name][2] or "noitem",
					[10] = classFileName,
					[11] = CEPGP_itemsTable[name][3], -- Loot response
					[12] = CEPGP_itemsTable[name][4]
				};
			else
				EP = 0;
				GP = BASEGP;
				for i = 1, GetNumGroupMembers() do
					if GetRaidRosterInfo(i) == name then
						local class = select(5, GetRaidRosterInfo(i))
						local rank = "不在公会";
						local rankIndex = 11;
						local classFile = select(6, GetRaidRosterInfo(i));
						tempTable[count] = {
							[1] = name,
							[2] = class,
							[3] = rank,
							[4] = rankIndex,
							[5] = EP,
							[6] = GP,
							[7] = math.floor((tonumber(EP)*100/tonumber(GP)))/100,
							[8] = CEPGP_itemsTable[name][1] or "noitem",
							[9] = CEPGP_itemsTable[name][2] or "noitem",
							[10] = classFile,
							[11] = CEPGP_itemsTable[name][3], -- Loot response
							[12] = CEPGP_itemsTable[name][4]
						};
					end
				end
			end
		end
		count = count + 1;
		
	end
	if PRsort and CEPGP_PR_sort then
		tempTable = CEPGP_sortDistList(tempTable);
	elseif sort then
		tempTable = CEPGP_tSort(tempTable, CEPGP_Info.Sorting.Loot[1], CEPGP_Info.Sorting.Loot[2]);
	end
	local kids = {_G["CEPGP_dist_scrollframe_container"]:GetChildren()};
	for _, child in ipairs(kids) do
		child:Hide();
	end
	for i = 1, #tempTable do
		if quit then return; end
		if CEPGP_Info.LastRun.DistSB ~= call then
			quit = true;
			return;
		end
		if not _G["LootDistButton" .. i] then
			local frame = CreateFrame('Button', "LootDistButton" .. i, _G["CEPGP_dist_scrollframe_container"], "LootDistButtonTemplate");
			if i > 1 then
				_G["LootDistButton" .. i]:SetPoint("TOPLEFT", _G["LootDistButton" .. i-1], "BOTTOMLEFT", 0, -2);
			else
				_G["LootDistButton" .. i]:SetPoint("TOPLEFT", _G["CEPGP_dist_scrollframe_container"], "TOPLEFT", 0, -10);
			end
		end
		--tempTable[i][11] = (CEPGP_response_buttons[tonumber(tempTable[i][11])] and CEPGP_response_buttons[tonumber(tempTable[i][11])][2]) or tempTable[i][11];
		local response = tempTable[i][11];
		local reason = CEPGP_Info.LootSchema[tempTable[i][11]];
		local EPcolour;
		if CEPGP.Loot.MinReq[1] and CEPGP.Loot.MinReq[2] > tonumber(tempTable[i][5]) then
			EPcolour = {
				r = 1,
				g = 0,
				b = 0
			};
		else
			EPcolour = CEPGP_Info.ClassColours[string.upper(tempTable[i][10])];
		end
		
		local colour = CEPGP_Info.ClassColours[string.upper(tempTable[i][10])];
		if not colour then
			colour = {
				r = 1,
				g = 1,
				b = 1
			};
		end
		
		if tempTable[i][8] ~= "noitem" or tempTable[i][9] ~= "noitem" then
			if tempTable[i][8] ~= "noitem" then
				local id = tonumber(tempTable[i][8]);
				_, link, _, _, _, _, _, _, _, tex = GetItemInfo(id);
				local iString;
				if not link and CEPGP_itemExists(id) then
					local item = Item:CreateFromItemID(id);
					item:ContinueOnItemLoad(function()
						_, link, _, _, _, _, _, _, _, tex = GetItemInfo(id)
						iString = CEPGP_getItemString(link);
						
						_G["LootDistButton" .. i]:Show();
						_G["LootDistButton" .. i]:SetAttribute("response", response);
						_G["LootDistButton" .. i]:SetAttribute("responseName", response);
						_G["LootDistButton" .. i .. "Info"]:SetText(tempTable[i][1]);
						_G["LootDistButton" .. i .. "Info"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "Class"]:SetText(tempTable[i][2]);
						_G["LootDistButton" .. i .. "Class"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "Rank"]:SetText(tempTable[i][3]);
						_G["LootDistButton" .. i .. "Rank"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "Response"]:SetText(reason);
						_G["LootDistButton" .. i .. "Response"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "EP"]:SetText(tempTable[i][5]);
						_G["LootDistButton" .. i .. "EP"]:SetTextColor(EPcolour.r, EPcolour.g, EPcolour.b);
						_G["LootDistButton" .. i .. "GP"]:SetText(tempTable[i][6]);
						_G["LootDistButton" .. i .. "GP"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "PR"]:SetText(string.format("%.2f", tempTable[i][7]));
						_G["LootDistButton" .. i .. "PR"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "Roll"]:SetText(tempTable[i][12]);
						_G["LootDistButton" .. i .. "Roll"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "Tex"]:SetScript('OnLeave', function()
																						GameTooltip:Hide()
																			end);
						_G["LootDistButton" .. i .. "Tex"]:SetScript('OnEnter', function()	
																				GameTooltip:SetOwner(_G["LootDistButton" .. i .. "Tex"], "ANCHOR_TOPLEFT");
																				GameTooltip:SetHyperlink(iString);
																				GameTooltip:Show();
																			end);
						_G["LootDistButton" .. i .. "Icon"]:SetTexture(tex);					
					end);
				else
					iString = CEPGP_getItemString(link);
				
					_G["LootDistButton" .. i]:Show();
					_G["LootDistButton" .. i]:SetAttribute("response", response);
					_G["LootDistButton" .. i]:SetAttribute("responseName", response);
					_G["LootDistButton" .. i .. "Info"]:SetText(tempTable[i][1]);
					_G["LootDistButton" .. i .. "Info"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "Class"]:SetText(tempTable[i][2]);
					_G["LootDistButton" .. i .. "Class"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "Rank"]:SetText(tempTable[i][3]);
					_G["LootDistButton" .. i .. "Rank"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "Response"]:SetText(reason);
					_G["LootDistButton" .. i .. "Response"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "EP"]:SetText(tempTable[i][5]);
					_G["LootDistButton" .. i .. "EP"]:SetTextColor(EPcolour.r, EPcolour.g, EPcolour.b);
					_G["LootDistButton" .. i .. "GP"]:SetText(tempTable[i][6]);
					_G["LootDistButton" .. i .. "GP"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "PR"]:SetText(string.format("%.2f", tempTable[i][7]));
					_G["LootDistButton" .. i .. "PR"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "Roll"]:SetText(tempTable[i][12]);
					_G["LootDistButton" .. i .. "Roll"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "Tex"]:SetScript('OnLeave', function()
																					GameTooltip:Hide()
																		end);
					_G["LootDistButton" .. i .. "Tex"]:SetScript('OnEnter', function()	
																			GameTooltip:SetOwner(_G["LootDistButton" .. i .. "Tex"], "ANCHOR_TOPLEFT");
																			GameTooltip:SetHyperlink(iString);
																			GameTooltip:Show();
																		end);
					_G["LootDistButton" .. i .. "Icon"]:SetTexture(tex);
				end
			else
				_G["LootDistButton" .. i .. "Tex"]:SetScript('OnEnter', function() end);
				_G["LootDistButton" .. i .. "Icon"]:SetTexture(nil);
			end
			
			if tempTable[i][9] ~= "noitem" then
				local id = tonumber(tempTable[i][9]);
				_, link, _, _, _, _, _, _, _, tex2 = GetItemInfo(id);
				local iString2;
				if not link and CEPGP_itemExists(id) then
					local item = Item:CreateFromItemID(id);
					item:ContinueOnItemLoad(function()
						_, link, _, _, _, _, _, _, _, tex2 = GetItemInfo(id)
						iString2 = CEPGP_getItemString(link);
						
						_G["LootDistButton" .. i]:Show();
						_G["LootDistButton" .. i]:SetAttribute("response", response);
						_G["LootDistButton" .. i]:SetAttribute("responseName", response);
						_G["LootDistButton" .. i .. "Info"]:SetText(tempTable[i][1]);
						_G["LootDistButton" .. i .. "Info"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "Class"]:SetText(tempTable[i][2]);
						_G["LootDistButton" .. i .. "Class"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "Rank"]:SetText(tempTable[i][3]);
						_G["LootDistButton" .. i .. "Rank"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "Response"]:SetText(reason);
						_G["LootDistButton" .. i .. "Response"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "EP"]:SetText(tempTable[i][5]);
						_G["LootDistButton" .. i .. "EP"]:SetTextColor(EPcolour.r, EPcolour.g, EPcolour.b);
						_G["LootDistButton" .. i .. "GP"]:SetText(tempTable[i][6]);
						_G["LootDistButton" .. i .. "GP"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "PR"]:SetText(string.format("%.2f", tempTable[i][7]));
						_G["LootDistButton" .. i .. "PR"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "Roll"]:SetText(tempTable[i][12]);
						_G["LootDistButton" .. i .. "Roll"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "Tex2"]:SetScript('OnLeave', function()
																				GameTooltip:Hide()
																			end);
						_G["LootDistButton" .. i .. "Tex2"]:SetScript('OnEnter', function()	
														GameTooltip:SetOwner(_G["LootDistButton" .. i .. "Tex2"], "ANCHOR_TOPLEFT")
														GameTooltip:SetHyperlink(iString2)
														GameTooltip:Show()
													end);				
						_G["LootDistButton" .. i .. "Icon2"]:SetTexture(tex2);
					end);
				else
					iString2 = CEPGP_getItemString(link);
					
					_G["LootDistButton" .. i]:Show();
					_G["LootDistButton" .. i]:SetAttribute("response", response);
					_G["LootDistButton" .. i]:SetAttribute("responseName", response);
					_G["LootDistButton" .. i .. "Info"]:SetText(tempTable[i][1]);
					_G["LootDistButton" .. i .. "Info"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "Class"]:SetText(tempTable[i][2]);
					_G["LootDistButton" .. i .. "Class"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "Rank"]:SetText(tempTable[i][3]);
					_G["LootDistButton" .. i .. "Rank"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "Response"]:SetText(reason);
					_G["LootDistButton" .. i .. "Response"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "EP"]:SetText(tempTable[i][5]);
					_G["LootDistButton" .. i .. "EP"]:SetTextColor(EPcolour.r, EPcolour.g, EPcolour.b);
					_G["LootDistButton" .. i .. "GP"]:SetText(tempTable[i][6]);
					_G["LootDistButton" .. i .. "GP"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "PR"]:SetText(string.format("%.2f", tempTable[i][7]));
					_G["LootDistButton" .. i .. "PR"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "Roll"]:SetText(tempTable[i][12]);
					_G["LootDistButton" .. i .. "Roll"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "Tex2"]:SetScript('OnLeave', function()
																			GameTooltip:Hide()
																		end);
					_G["LootDistButton" .. i .. "Tex2"]:SetScript('OnEnter', function()	
													GameTooltip:SetOwner(_G["LootDistButton" .. i .. "Tex2"], "ANCHOR_TOPLEFT")
													GameTooltip:SetHyperlink(iString2)
													GameTooltip:Show()
												end);				
					_G["LootDistButton" .. i .. "Icon2"]:SetTexture(tex2);
				end
			else
				_G["LootDistButton" .. i .. "Tex2"]:SetScript('OnEnter', function() end);
				_G["LootDistButton" .. i .. "Icon2"]:SetTexture(nil);
			end
		else --Recipient has no items in the corresponding slots
			
			_G["LootDistButton" .. i]:Show();
			_G["LootDistButton" .. i]:SetAttribute("response", response);
			_G["LootDistButton" .. i]:SetAttribute("responseName", response);
			_G["LootDistButton" .. i .. "Info"]:SetText(tempTable[i][1]);
			_G["LootDistButton" .. i .. "Info"]:SetTextColor(colour.r, colour.g, colour.b);
			_G["LootDistButton" .. i .. "Class"]:SetText(tempTable[i][2]);
			_G["LootDistButton" .. i .. "Class"]:SetTextColor(colour.r, colour.g, colour.b);
			_G["LootDistButton" .. i .. "Rank"]:SetText(tempTable[i][3]);
			_G["LootDistButton" .. i .. "Rank"]:SetTextColor(colour.r, colour.g, colour.b);
			_G["LootDistButton" .. i .. "Response"]:SetText(reason);
			_G["LootDistButton" .. i .. "Response"]:SetTextColor(colour.r, colour.g, colour.b);
			_G["LootDistButton" .. i .. "EP"]:SetText(tempTable[i][5]);
			_G["LootDistButton" .. i .. "EP"]:SetTextColor(EPcolour.r, EPcolour.g, EPcolour.b);
			_G["LootDistButton" .. i .. "GP"]:SetText(tempTable[i][6]);
			_G["LootDistButton" .. i .. "GP"]:SetTextColor(colour.r, colour.g, colour.b);
			_G["LootDistButton" .. i .. "PR"]:SetText(string.format("%.2f", tempTable[i][7]));
			_G["LootDistButton" .. i .. "PR"]:SetTextColor(colour.r, colour.g, colour.b);
			_G["LootDistButton" .. i .. "Roll"]:SetText(tempTable[i][12]);
			_G["LootDistButton" .. i .. "Roll"]:SetTextColor(colour.r, colour.g, colour.b);
			_G["LootDistButton" .. i .. "Tex"]:SetScript('OnLeave', function()
																			GameTooltip:Hide()
																end);
			_G["LootDistButton" .. i .. "Tex2"]:SetScript('OnLeave', function()
																	GameTooltip:Hide()
																end);
			_G["LootDistButton" .. i .. "Icon"]:SetTexture(nil);
			_G["LootDistButton" .. i .. "Icon2"]:SetTexture(nil);
			_G["LootDistButton" .. i .. "Tex2"]:SetScript('OnEnter', function() end);
			_G["LootDistButton" .. i .. "Icon2"]:SetTexture(nil);
			_G["LootDistButton" .. i .. "Tex"]:SetScript('OnEnter', function() end);
			_G["LootDistButton" .. i .. "Icon"]:SetTexture(nil);
		end
	end
end

function CEPGP_UpdateGuildScrollBar()
	CEPGP_Info.LastRun.GuildSB = GetTime();
	local call = CEPGP_Info.LastRun.GuildSB;
	local quit = false;
	local tempTable = {};
	local count = 0;
	for name, v in pairs(CEPGP_roster) do
		count = count + 1;
		local index = CEPGP_getIndex(name);
		local EP, GP = CEPGP_getEPGP(name, index)
		tempTable[count] = {
			[1] = name,
			[2] = v[2], --Class
			[3] = v[3], --Rank
			[4] = v[4], --RankIndex
			[5] = EP,
			[6] = GP,
			[7] = math.floor((EP/GP)*100)/100,
			[8] = v[7] -- className in English
		};
	end
	tempTable = CEPGP_tSort(tempTable, CEPGP_Info.Sorting.Guild[1], CEPGP_Info.Sorting.Guild[2]);
	local kids = {_G["CEPGP_guild_scrollframe_container"]:GetChildren()};
	for index, child in ipairs(kids) do
		if index > CEPGP_ntgetn(CEPGP_roster) then
			child:Hide();
			child = nil;
		end
		--child:Hide();
	end
	local i = 0;

	C_Timer.NewTicker(0.0001, function()
		if quit then return; end
		if CEPGP_Info.LastRun.GuildSB ~= call then
			quit = true;
			return;
		end
		i = i + 1;
		if #tempTable > 0 then
			if not _G["GuildButton" .. i] then
				local frame = CreateFrame('Button', "GuildButton" .. i, _G["CEPGP_guild_scrollframe_container"], "GuildButtonTemplate");
				if i > 1 then
					_G["GuildButton" .. i]:SetPoint("TOPLEFT", _G["GuildButton" .. i-1], "BOTTOMLEFT", 0, -2);
				else
					_G["GuildButton" .. i]:SetPoint("TOPLEFT", _G["CEPGP_guild_scrollframe_container"], "TOPLEFT", 0, -10);
				end
			end
			local colour = CEPGP_Info.ClassColours[string.upper(tempTable[i][8])];
			if not colour then
				colour = {
				r = 1,
				g = 1,
				b = 1
			};
			end
			_G["GuildButton" .. i]:Show();
			_G["GuildButton" .. i .. "Info"]:SetText(tempTable[i][1]);
			_G["GuildButton" .. i .. "Info"]:SetTextColor(colour.r, colour.g, colour.b);
			_G["GuildButton" .. i .. "Class"]:SetText(tempTable[i][2]);
			_G["GuildButton" .. i .. "Class"]:SetTextColor(colour.r, colour.g, colour.b);
			_G["GuildButton" .. i .. "Rank"]:SetText(tempTable[i][3]);
			_G["GuildButton" .. i .. "Rank"]:SetTextColor(colour.r, colour.g, colour.b);
			_G["GuildButton" .. i .. "EP"]:SetText(tempTable[i][5]);
			_G["GuildButton" .. i .. "EP"]:SetTextColor(colour.r, colour.g, colour.b);
			_G["GuildButton" .. i .. "GP"]:SetText(tempTable[i][6]);
			_G["GuildButton" .. i .. "GP"]:SetTextColor(colour.r, colour.g, colour.b);
			_G["GuildButton" .. i .. "PR"]:SetText(string.format("%.2f", tempTable[i][7]));
			_G["GuildButton" .. i .. "PR"]:SetTextColor(colour.r, colour.g, colour.b);
		end
	end, #tempTable);
end

function CEPGP_UpdateRaidScrollBar()
	CEPGP_Info.LastRun.RaidSB = GetTime();
	local call = CEPGP_Info.LastRun.RaidSB;
	local tempTable = {};
	for i = 1, CEPGP_ntgetn(CEPGP_raidRoster) do
		tempTable[i] = {
			[1] = CEPGP_raidRoster[i][1], --Name
			[2] = CEPGP_raidRoster[i][2], --Class
			[3] = CEPGP_raidRoster[i][3], --Rank
			[4] = CEPGP_raidRoster[i][4], --RankIndex
			[5] = CEPGP_raidRoster[i][5], --EP
			[6] = CEPGP_raidRoster[i][6], --GP
			[7] = CEPGP_raidRoster[i][7], --PR
			[8] = CEPGP_raidRoster[i][8]  --Class in English
		};
		
	end
	tempTable = CEPGP_tSort(tempTable, CEPGP_Info.Sorting.Raid[1], CEPGP_Info.Sorting.Raid[2]);
	local kids = {_G["CEPGP_raid_scrollframe_container"]:GetChildren()};
	for index, child in ipairs(kids) do
		if index > CEPGP_ntgetn(CEPGP_raidRoster) then
			child:Hide();
			--child = nil;
		end
	end
	for i = 1, CEPGP_ntgetn(tempTable) do
		if CEPGP_Info.LastRun.RaidSB ~= call or #tempTable ~= #CEPGP_raidRoster then
			return;
		end
		
		if not _G["RaidButton" .. i] then
			local frame = CreateFrame('Button', "RaidButton" .. i, _G["CEPGP_raid_scrollframe_container"], "RaidButtonTemplate");
			if i > 1 then
				_G["RaidButton" .. i]:SetPoint("TOPLEFT", _G["RaidButton" .. i-1], "BOTTOMLEFT", 0, -2);
			else
				_G["RaidButton" .. i]:SetPoint("TOPLEFT", _G["CEPGP_raid_scrollframe_container"], "TOPLEFT", 0, -10);
			end
		end
		local colour = CEPGP_Info.ClassColours[string.upper(tempTable[i][8])];
		if not colour then
			colour = {
			r = 1,
			g = 1,
			b = 1
		};
		end
		_G["RaidButton" .. i]:Show();
		_G["RaidButton" .. i .. "Info"]:SetText(tempTable[i][1]);
		_G["RaidButton" .. i .. "Info"]:SetTextColor(colour.r, colour.g, colour.b);
		_G["RaidButton" .. i .. "Class"]:SetText(tempTable[i][2]);
		_G["RaidButton" .. i .. "Class"]:SetTextColor(colour.r, colour.g, colour.b);
		_G["RaidButton" .. i .. "Rank"]:SetText(tempTable[i][3]);
		_G["RaidButton" .. i .. "Rank"]:SetTextColor(colour.r, colour.g, colour.b);
		_G["RaidButton" .. i .. "EP"]:SetText(tempTable[i][5]);
		_G["RaidButton" .. i .. "EP"]:SetTextColor(colour.r, colour.g, colour.b);
		_G["RaidButton" .. i .. "GP"]:SetText(tempTable[i][6]);
		_G["RaidButton" .. i .. "GP"]:SetTextColor(colour.r, colour.g, colour.b);
		_G["RaidButton" .. i .. "PR"]:SetText(string.format("%.2f", tempTable[i][7]));
		_G["RaidButton" .. i .. "PR"]:SetTextColor(colour.r, colour.g, colour.b);
	end
end

function CEPGP_UpdateVersionScrollBar()
	CEPGP_Info.LastRun.VersionSB = GetTime();
	local call = CEPGP_Info.LastRun.VersionSB;
	local name, classFile, class, colour, version;
	local showOffline = CEPGP_version:GetAttribute("offline");
	local tempTable = {};
	local kids = {_G["CEPGP_version_scrollframe_container"]:GetChildren()};
	for _, child in ipairs(kids) do
		child:Hide();
	end
	if showOffline == "false" then
		for i = 1, #CEPGP_groupVersion do
			if CEPGP_groupVersion[i][2] ~= "Offline" then
				tempTable[#tempTable+1] = {
					[1] = CEPGP_groupVersion[i][1],
					[2] = CEPGP_groupVersion[i][2],
					[3] = CEPGP_groupVersion[i][3],
					[4] = CEPGP_groupVersion[i][4]
				};
			end
		end
	else
		for i = 1, #CEPGP_groupVersion do
			tempTable[i] = {
				[1] = CEPGP_groupVersion[i][1],
				[2] = CEPGP_groupVersion[i][2],
				[3] = CEPGP_groupVersion[i][3],
				[4] = CEPGP_groupVersion[i][4]
			};
		end
	end
	
	tempTable = CEPGP_tSort(tempTable, CEPGP_Info.Sorting.Version[1], CEPGP_Info.Sorting.Version[2]);
	
	
	for i = 1, #tempTable do
		if call ~= CEPGP_Info.LastRun.VersionSB then return; end
		if not _G["versionButton" .. i] then
			local frame = CreateFrame('Button', "versionButton" .. i, _G["CEPGP_version_scrollframe_container"], "versionButtonTemplate"); -- Creates version frames if needed
			if i > 1 then
				_G["versionButton" .. i]:SetPoint("TOPLEFT", _G["versionButton" .. i-1], "BOTTOMLEFT", 0, -2);
			else
				_G["versionButton" .. i]:SetPoint("TOPLEFT", _G["CEPGP_version_scrollframe_container"], "TOPLEFT", 5, -6);
			end
		end
		_G["versionButton" .. i]:Show();
		if CEPGP_vSearch == "GUILD" then
			local name = tempTable[i][1];
			local classFile = tempTable[i][4];
			local colour = CEPGP_Info.ClassColours[classFile];
			if not colour then
				colour = {
				r = 1,
				g = 1,
				b = 1
			};
			end
			_G["versionButton" .. i .. "name"]:SetText(tempTable[i][1]);
			_G["versionButton" .. i .. "name"]:SetTextColor(colour.r, colour.g, colour.b);
			_G["versionButton" .. i .. "version"]:SetText(tempTable[i][2]);
			_G["versionButton" .. i .. "version"]:SetTextColor(colour.r, colour.g, colour.b);
		else
			for x = 1, GetNumGroupMembers() do
				if tempTable[i][1] == GetRaidRosterInfo(x) then
					name = tempTable[i][1];
					version = tempTable[i][2];
					class = tempTable[i][3];
					classFile = tempTable[i][4];
					local colour = CEPGP_Info.ClassColours[classFile];
					if not colour then
						colour = {
						r = 1,
						g = 1,
						b = 1
					};
					end
					_G["versionButton" .. i .. "name"]:SetText(name);
					_G["versionButton" .. i .. "name"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["versionButton" .. i .. "version"]:SetText(version);
					_G["versionButton" .. i .. "version"]:SetTextColor(colour.r, colour.g, colour.b);
				end
			end
		end
	end
end

function CEPGP_UpdateOverrideScrollBar()
	local tempTable = {};
	local items = {};
	local compTable = {};
	local kids = {_G["CEPGP_override_scrollframe_container"]:GetChildren()};
	for _, child in ipairs(kids) do
		child:Hide();
	end
	for k, v in pairs(OVERRIDE_INDEX) do
		local name = GetItemInfo(k);
		if name then
			table.insert(items, name);
			compTable[name] = k;
		else
			table.insert(items, k);
			compTable[k] = k;
		end
	end
	table.sort(items);
	for i, v in ipairs(items) do
		tempTable[#tempTable+1] = {
			[1] = compTable[v],
			[2] = OVERRIDE_INDEX[compTable[v]]
		}
	end
	for i = 1, #tempTable do
		if not _G["overrideButton" ..  i] then
			local frame = CreateFrame('Button', "overrideButton" .. i, _G["CEPGP_override_scrollframe_container"], "lootOverrideButtonTemplate"); -- Creates override frames if needed
			if i > 1 then
				_G["overrideButton" .. i]:SetPoint("TOPLEFT", _G["overrideButton" .. i-1], "BOTTOMLEFT", 0, -2);
			else
				_G["overrideButton" .. i]:SetPoint("TOPLEFT", _G["CEPGP_override_scrollframe_container"], "TOPLEFT", 5, -6);
			end
		end
		_G["overrideButton" .. i]:Show();
		_G["overrideButton" .. i .. "item"]:SetText(tempTable[i][1]);
		_G["overrideButton" .. i .. "GP"]:SetText(tempTable[i][2]);
		_G["overrideButton" .. i .. "GP"]:SetTextColor(1, 1, 1);
	end
end

function CEPGP_UpdateTrafficScrollBar()
	CEPGP_Info.LastRun.TrafficSB = GetTime();
	local lastRun = CEPGP_Info.LastRun.TrafficSB;
	local kids = {_G["CEPGP_traffic_scrollframe_container"]:GetChildren()};
	for _, child in ipairs(kids) do
		if lastRun ~= CEPGP_Info.LastRun.TrafficSB then return; end
		child:Hide();
	end
	local search = CEPGP_traffic_search:GetText();
	local results = {};
	local matches = 1;
	
	for i = 1, #TRAFFIC do
		local name, issuer, action, EPB, EPA, GPB, GPA, item, tStamp, ID, GUID = TRAFFIC[i][1] or "", TRAFFIC[i][2] or "", TRAFFIC[i][3] or "", TRAFFIC[i][4] or "", TRAFFIC[i][5] or "", TRAFFIC[i][6] or "", TRAFFIC[i][7] or "", TRAFFIC[i][8] or "", TRAFFIC[i][9], TRAFFIC[i][10], TRAFFIC[i][11];
		if not tStamp then
			tStamp = "";
		end
		if search ~= "" and (string.find(string.lower(name), string.lower(search)) or
			string.find(string.lower(issuer), string.lower(search)) or
			string.find(string.lower(action), string.lower(search)) or
			string.find(string.lower(EPB), string.lower(search)) or
			string.find(string.lower(EPA), string.lower(search)) or
			string.find(string.lower(GPB), string.lower(search)) or
			string.find(string.lower(GPA), string.lower(search)) or
			string.find(string.lower(item), string.lower(search)) or
			string.find(string.lower(tStamp), string.lower(search))) then
			results[matches] = {
				[1] = name,
				[2] = issuer,
				[3] = action,
				[4] = EPB,
				[5] = EPA,
				[6] = GPB,
				[7] = GPA,
				[8] = item,
				[9] = tStamp,
				[10] = ID,
				[11] = GUID
			};
			matches = matches + 1;
		elseif search == "" then
			results[matches] = {
				[1] = name,
				[2] = issuer,
				[3] = action,
				[4] = EPB,
				[5] = EPA,
				[6] = GPB,
				[7] = GPA,
				[8] = item,
				[9] = tStamp,
				[10] = ID,
				[11] = GUID
			};
			matches = matches + 1;
		end
	end
	local temp = {};
	for i = matches, 0, -1 do
		table.insert(temp, results[i]);
	end
	results = {};
	for i = CEPGP_Info.TrafficScope, math.min(CEPGP_Info.TrafficScope+499, #TRAFFIC) do
		table.insert(results, temp[i]);
	end
	temp = {};
	for i = #results, 0, -1 do
		table.insert(temp, results[i]);
	end
	results = temp;
	CEPGP_traffic_display:SetText("显示当前项: " .. CEPGP_Info.TrafficScope .. " - " .. math.min(CEPGP_Info.TrafficScope+499, #TRAFFIC));
	CEPGP_traffic_display:SetPoint("BOTTOMRIGHT", -25, 20);
	local i = #results;
	
	if #results > 0 then
		C_Timer.NewTicker(0.0001, function()
			if search ~= CEPGP_traffic_search:GetText() or lastRun ~= CEPGP_Info.LastRun.TrafficSB then return; end -- Terminates the previous search if the query changes
			if not _G["TrafficButton" .. i] then
				local frame = CreateFrame('Button', "TrafficButton" .. i, _G["CEPGP_traffic_scrollframe_container"], "trafficButtonTemplate");
			end
			if i ~= #results then
				_G["TrafficButton" .. i]:SetPoint("TOPLEFT", _G["TrafficButton" .. i+1], "BOTTOMLEFT", 0, -2);
			else
				_G["TrafficButton" .. i]:SetPoint("TOPLEFT", _G["CEPGP_traffic_scrollframe_container"], "TOPLEFT", 7.5, -10);
			end
			local _, class = CEPGP_getPlayerClass(results[i][1]);
			local _, issuerClass = CEPGP_getPlayerClass(results[i][2]);
			local colour, issuerColour = class, issuerClass;
			if not class then
				colour = {
					r = 1,
					g = 1,
					b = 1
				};
			end
			if not issuerClass then
				issuerColour = {
					r = 1,
					g = 1,
					b = 1
				};
			end
			_G["TrafficButton" .. i]:Show();
			_G["TrafficButton" .. i .. "Name"]:SetText(results[i][1]);
			_G["TrafficButton" .. i .. "Name"]:SetTextColor(colour.r, colour.g, colour.b);
			_G["TrafficButton" .. i .. "Issuer"]:SetText(results[i][2]);
			_G["TrafficButton" .. i .. "Issuer"]:SetTextColor(issuerColour.r, issuerColour.g, issuerColour.b);
			_G["TrafficButton" .. i .. "Action"]:SetText(results[i][3]);
			_G["TrafficButton" .. i .. "EPBefore"]:SetText(results[i][4]);
			_G["TrafficButton" .. i .. "EPAfter"]:SetText(results[i][5]);
			_G["TrafficButton" .. i .. "GPBefore"]:SetText(results[i][6]);
			_G["TrafficButton" .. i .. "GPAfter"]:SetText(results[i][7]);
			if results[i][9] ~= "" then
				local temp = i;
				_G["TrafficButton" .. temp]:SetScript('OnEnter', function()
					GameTooltip:SetOwner(_G["TrafficButton" .. temp], "ANCHOR_TOPLEFT");
					GameTooltip:SetText(date("Time: %I:%M%p\nDate: %a, %d %B %Y", results[temp][9]));
				end);
				_G["TrafficButton" .. i]:SetScript('OnLeave', function()
					GameTooltip:Hide();
				end);
			else
				local temp = i;
				_G["TrafficButton" .. temp]:SetScript('OnEnter', function()
					GameTooltip:SetOwner(_G["TrafficButton" .. temp], "ANCHOR_TOPLEFT");
					GameTooltip:SetText("没有为此记录，记录时间数据");
				end);
				_G["TrafficButton" .. i]:SetScript('OnLeave', function()
					GameTooltip:Hide();
				end);
			end
			if (results[i][8] and strfind(results[i][8], "item")) or tonumber(results[i][8]) then --Accommodates for earlier versions when malformed information may be stored in the item index of the traffic log
				_G["TrafficButton" .. i .. "ItemName"]:SetText(results[i][8]);
				local _, link = GetItemInfo(results[i][8]);
				if link then
					_G["TrafficButton" .. i .. "Item"]:SetScript('OnClick', function() SetItemRef(link) end);
				else
					local id;
					if string.find(tostring(results[i][8]), "item:") then
						id = string.sub(tostring(results[i][8]), string.find(results[i][8], ":")+1);
						id = tonumber(string.sub(id, 0, string.find(id, ":")-1));
					end
					if CEPGP_itemExists(id) then
						local queryID = id;
						local index = i;
						local newItem = Item:CreateFromItemID(id);
						newItem:ContinueOnItemLoad(function()
							
							_, link = GetItemInfo(queryID);
							_G["TrafficButton" .. index .. "Item"]:SetScript('OnClick', function() SetItemRef(link) end);
							
						end);
					else
						_G["TrafficButton" .. i .. "ItemName"]:SetText("");
						_G["TrafficButton" .. i .. "Item"]:SetScript('OnClick', function() end);
					end
				end
			else
				_G["TrafficButton" .. i .. "ItemName"]:SetText("");
				_G["TrafficButton" .. i .. "Item"]:SetScript('OnClick', function() end);
			end
			if not results[i][10] or not results[i][11] or (tonumber(results[i][9]) == tonumber(results[i][10])) then
				_G["TrafficButton" .. i .. "Share"]:Hide();
			elseif results[i][10] and results[i][11] then
				_G["TrafficButton" .. i .. "Share"]:Show();				
			end
			i = i - 1;
		end, #results);
	end
end

function CEPGP_UpdateStandbyScrollBar()
	local tempTable = {};
	local kids = {_G["CEPGP_standby_scrollframe_container"]:GetChildren()};
	for _, child in ipairs(kids) do
		child:Hide();
	end
	for i = 1, CEPGP_ntgetn(CEPGP_standbyRoster) do
		if not _G["StandbyButton" .. i] then
			local frame = CreateFrame('Button', "StandbyButton" .. i, _G["CEPGP_standby_scrollframe_container"], "StandbyButtonTemplate");
			if i > 1 then
				_G["StandbyButton" .. i]:SetPoint("TOPLEFT", _G["StandbyButton" .. i-1], "BOTTOMLEFT", 0, -2);
			else
				_G["StandbyButton" .. i]:SetPoint("TOPLEFT", _G["CEPGP_standby_scrollframe_container"], "TOPLEFT", 0, -10);
			end
		end
		local _, _, rank, rankIndex, oNote, _, classFile = CEPGP_getGuildInfo(CEPGP_standbyRoster[i][1]);
		local online = true;
		local name = CEPGP_standbyRoster[i][1];
		local index = CEPGP_getIndex(name);
		local EP, GP = CEPGP_getEPGP(name, index);
		if not EP then EP = 0; end
		if not GP then GP = BASEGP; end
		if name and index then
			_, _, _, _, _, _, _, _, online = GetGuildRosterInfo(index);
		else
			online = false;
		end
		tempTable[i] = {
			[1] = CEPGP_standbyRoster[i][1], --name
			[2] = CEPGP_standbyRoster[i][2], --class
			[3] = CEPGP_standbyRoster[i][3], --rank
			[4] = CEPGP_standbyRoster[i][4], --rankIndex
			[5] = EP, --EP
			[6] = GP, --GP
			[7] = math.floor((tonumber(EP)*100/tonumber(GP)))/100,
			[8] = CEPGP_standbyRoster[i][8], --ClassFile
			[9] = online --Online
		};
		local colour;
		if tempTable[i][9] then
			colour = CEPGP_Info.ClassColours[tempTable[i][8]];
			_G["StandbyButton" .. i]:SetScript('OnEnter', function() end);
		else
			colour = {
				r = 0.62,
				g = 0.62,
				b = 0.62
			};
			_G["StandbyButton" .. i]:SetScript('OnEnter', function()
				GameTooltip:SetOwner(_G["StandbyButton" .. i], "ANCHOR_TOPLEFT");
				GameTooltip:SetText("玩家离线");
			end);
			_G["StandbyButton" .. i]:SetScript('OnLeave', function()
				GameTooltip:Hide()
			end);
		end
		if not colour then
			colour = {
			r = 1,
			g = 1,
			b = 1
		};
		end
		_G["StandbyButton" .. i]:Show();
		_G["StandbyButton" .. i .. "Info"]:SetText(tempTable[i][1]);
		_G["StandbyButton" .. i .. "Info"]:SetTextColor(colour.r, colour.g, colour.b);
		_G["StandbyButton" .. i .. "Class"]:SetText(tempTable[i][2]);
		_G["StandbyButton" .. i .. "Class"]:SetTextColor(colour.r, colour.g, colour.b);
		_G["StandbyButton" .. i .. "Rank"]:SetText(tempTable[i][3]);
		_G["StandbyButton" .. i .. "Rank"]:SetTextColor(colour.r, colour.g, colour.b);
		_G["StandbyButton" .. i .. "EP"]:SetText(tempTable[i][5]);
		_G["StandbyButton" .. i .. "EP"]:SetTextColor(colour.r, colour.g, colour.b);
		_G["StandbyButton" .. i .. "GP"]:SetText(tempTable[i][6]);
		_G["StandbyButton" .. i .. "GP"]:SetTextColor(colour.r, colour.g, colour.b);
		_G["StandbyButton" .. i .. "PR"]:SetText(tempTable[i][7]);
		_G["StandbyButton" .. i .. "PR"]:SetTextColor(colour.r, colour.g, colour.b);
	end
end

function CEPGP_UpdateAttendanceScrollBar()
	local kids = {_G["CEPGP_attendance_scrollframe_container"]:GetChildren()};
	for _, child in ipairs(kids) do
		child:Hide();
	end
	kids = {_G["CEPGP_attendance_scrollframe_standby_container"]:GetChildren()};
	for _, child in ipairs(kids) do
		child:Hide();
	end
	local tempTable, standbyTable = {}, {};
	local name, class, classFile, rank, rankIndex, index, total, week, fn, month, twoMon, threeMon;
	local size;
	local sbCount = 1;
	local count = 1;
	if CEPGP_snapshot then 
		size = #CEPGP_raid_logs[CEPGP_snapshot]-1;
	--else
		--size = CEPGP_ntgetn(CEPGP_roster)-CEPGP_Info.NumExcluded;
	end
	if CEPGP_snapshot then
		for i = 1, size do
			local standby = false;
			if CEPGP_snapshot then
				if type(CEPGP_raid_logs[CEPGP_snapshot][i+1]) == "table" then
					name = CEPGP_raid_logs[CEPGP_snapshot][i+1][1];
					standby = CEPGP_raid_logs[CEPGP_snapshot][i+1][2];
				else
					name = CEPGP_raid_logs[CEPGP_snapshot][i+1];
				end
			else
				name = CEPGP_indexToName(i);
			end
			total, week, fn, month, twoMon, threeMon = CEPGP_calcAttendance(name);
			index, class, rank, rankIndex, _, _, classFile = CEPGP_getGuildInfo(name);
			if not index then
				rank = "Non-Guild Member";
				rankIndex = 11;
			end
			if standby then
				standbyTable[sbCount] = {
					[1] = name,
					[2] = class,
					[3] = rank,
					[4] = total,
					[5] = tostring(week),
					[6] = tostring(fn),
					[7] = tostring(month),
					[8] = tostring(twoMon),
					[9] = tostring(threeMon),
					[10] = classFile,
					[11] = standby,
					[12] = rankIndex
				}
				sbCount = sbCount + 1;
			else
				tempTable[count] = {
					[1] = name,
					[2] = class,
					[3] = rank,
					[4] = total,
					[5] = tostring(week),
					[6] = tostring(fn),
					[7] = tostring(month),
					[8] = tostring(twoMon),
					[9] = tostring(threeMon),
					[10] = classFile,
					[11] = false,
					[12] = rankIndex
				}
				count = count + 1;
			end
		end
	else
		for name, v in pairs(CEPGP_roster) do
			total, week, fn, month, twoMon, threeMon = CEPGP_calcAttendance(name);
			index, class, rank, rankIndex, _, _, classFile = CEPGP_getGuildInfo(name);
			if not index then
				rank = "Non-Guild Member";
			end
			if standby then
				standbyTable[sbCount] = {
					[1] = name,
					[2] = class,
					[3] = rank,
					[4] = total,
					[5] = tostring(week),
					[6] = tostring(fn),
					[7] = tostring(month),
					[8] = tostring(twoMon),
					[9] = tostring(threeMon),
					[10] = classFile,
					[11] = standby,
					[12] = rankIndex
				}
				sbCount = sbCount + 1;
			else
				tempTable[count] = {
					[1] = name,
					[2] = class,
					[3] = rank,
					[4] = total,
					[5] = tostring(week),
					[6] = tostring(fn),
					[7] = tostring(month),
					[8] = tostring(twoMon),
					[9] = tostring(threeMon),
					[10] = classFile,
					[11] = false,
					[12] = rankIndex
				}
				count = count + 1;
			end
		end
	end
	
	tempTable = CEPGP_tSort(tempTable, CEPGP_Info.Sorting.Attendance[1], CEPGP_Info.Sorting.Attendance[2]);
	standbyTable = CEPGP_tSort(standbyTable, CEPGP_Info.Sorting.Standby[1], CEPGP_Info.Sorting.Standby[2]);

	local adjust = false;
	if #standbyTable > 0 then
		adjust = true;
	end
	if adjust then
		_G["CEPGP_attendance_scrollframe"]:SetSize(600, 175);
		_G["CEPGP_attendance_scrollframe_container"]:SetSize(600, 175);
		_G["CEPGP_attendance_scrollframe"]:SetPoint("TOPLEFT", "CEPGP_attendance_header_name", "BOTTOMLEFT", 10, 0);
		_G["CEPGP_attendance_scrollframe_standby"]:Show();
		_G["CEPGP_attendance_scrollframe_standby_container"]:Show();
		_G["CEPGP_attendance_standby_text"]:Show();
	else
		_G["CEPGP_attendance_scrollframe"]:SetSize(600, 315);
		_G["CEPGP_attendance_scrollframe_container"]:SetSize(600, 315);
		_G["CEPGP_attendance_scrollframe"]:SetPoint("RIGHT", "CEPGP_attendance", "RIGHT", -35, -20);
		_G["CEPGP_attendance_scrollframe_standby"]:Hide();
		_G["CEPGP_attendance_scrollframe_standby_container"]:Hide();
		_G["CEPGP_attendance_standby_text"]:Hide();
	end
	local totals = {CEPGP_calcAttIntervals()};
	if #CEPGP_raid_logs then
		_G["CEPGP_attendance_header_total"]:SetText("记录的快照总数： " .. #CEPGP_raid_logs);
	else
		_G["CEPGP_attendance_header_total"]:SetText("记录的快照总数： 0");
	end
	
	size = #tempTable;
	for i = 1, size do
		local avg, colour;
		if #CEPGP_raid_logs == 0 then
			avg = 1;
		else
			avg = tempTable[i][4]/#CEPGP_raid_logs;
			avg = math.floor(avg*100)/100;
		end
		if tempTable[i][10] then
			colour = CEPGP_Info.ClassColours[tempTable[i][10]];
		end
		if not colour then
			colour = {
				r = 0.5,
				g = 0,
				b = 0
			};
		end
		if tempTable[i][5] == "nil" then tempTable[i][5] = "0"; end;
		if tempTable[i][6] == "nil" then tempTable[i][6] = "0"; end;
		if tempTable[i][7] == "nil" then tempTable[i][7] = "0"; end;
		if tempTable[i][8] == "nil" then tempTable[i][8] = "0"; end;
		if tempTable[i][9] == "nil" then tempTable[i][9] = "0"; end;
		if not _G["AttendanceButton" .. i] then
			local frame = CreateFrame('Button', "AttendanceButton" .. i, _G["CEPGP_attendance_scrollframe_container"], "AttendanceButtonTemplate");
			if i > 1 then
				_G["AttendanceButton" .. i]:SetPoint("TOPLEFT", _G["AttendanceButton" .. i-1], "BOTTOMLEFT", 0, -2);
			else
				_G["AttendanceButton" .. i]:SetPoint("TOPLEFT", _G["CEPGP_attendance_scrollframe_container"], "TOPLEFT", 0, -10);
			end
		end
		_G["AttendanceButton" .. i]:Show();
		_G["AttendanceButton" .. i .. "Info"]:SetText(tempTable[i][1]);
		_G["AttendanceButton" .. i .. "Info"]:SetTextColor(colour.r, colour.g, colour.b);
		_G["AttendanceButton" .. i .. "Rank"]:SetText(tempTable[i][3]);
		_G["AttendanceButton" .. i .. "Rank"]:SetTextColor(colour.r, colour.g, colour.b);		
		if totals[1] == 0 then
			_G["AttendanceButton" .. i .. "Total"]:SetText(tempTable[i][4] .. " (" .. avg*100 .. "%)");
			_G["AttendanceButton" .. i .. "Total"]:SetTextColor(0, 1, 0);
		else
			_G["AttendanceButton" .. i .. "Total"]:SetText(tempTable[i][4] .. " (" .. avg*100 .. "%)");
			_G["AttendanceButton" .. i .. "Total"]:SetTextColor(1-avg,avg/1,0);
		end
		_G["AttendanceButton" .. i .. "Int7"]:SetText(tempTable[i][5] .. "/" .. totals[1]);
		if totals[1] == 0 then
			_G["AttendanceButton" .. i .. "Int7"]:SetTextColor(0, 1, 0);
		else
			_G["AttendanceButton" .. i .. "Int7"]:SetTextColor(1-(tempTable[i][5]/totals[1]), (tempTable[i][5]/totals[1])/1, 0);
		end
		_G["AttendanceButton" .. i .. "Int14"]:SetText(tempTable[i][6] .. "/" .. totals[2]);
		if totals[2] == 0 then
			_G["AttendanceButton" .. i .. "Int14"]:SetTextColor(0, 1, 0);
		else
			_G["AttendanceButton" .. i .. "Int14"]:SetTextColor(1-(tempTable[i][6]/totals[2]), (tempTable[i][6]/totals[2])/1, 0);
		end
		_G["AttendanceButton" .. i .. "Int30"]:SetText(tempTable[i][7] .. "/" .. totals[3]);
		if totals[3] == 0 then
			_G["AttendanceButton" .. i .. "Int30"]:SetTextColor(0, 1, 0);
		else
			_G["AttendanceButton" .. i .. "Int30"]:SetTextColor(1-(tempTable[i][7]/totals[3]), (tempTable[i][7]/totals[3])/1, 0);
		end		
		_G["AttendanceButton" .. i .. "Int60"]:SetText(tempTable[i][8] .. "/" .. totals[4]);
		if totals[4] == 0 then
			_G["AttendanceButton" .. i .. "Int60"]:SetTextColor(0, 1, 0);
		else
			_G["AttendanceButton" .. i .. "Int60"]:SetTextColor(1-(tempTable[i][8]/totals[4]), (tempTable[i][8]/totals[4])/1, 0);
		end
		_G["AttendanceButton" .. i .. "Int90"]:SetText(tempTable[i][9] .. "/" .. totals[5]);
		if totals[5] == 0 then
			_G["AttendanceButton" .. i .. "Int90"]:SetTextColor(0, 1, 0);
		else
			_G["AttendanceButton" .. i .. "Int90"]:SetTextColor(1-(tempTable[i][9]/totals[5]), (tempTable[i][9]/totals[5])/1, 0);
		end
	end
	
			--[[ STANDBY ]]--
	size = #standbyTable;
	for i = 1, size do
		local colour;
		local avg = standbyTable[i][4]/#CEPGP_raid_logs;
		avg = math.floor(avg*100)/100;
		if standbyTable[i][10] then
			colour = CEPGP_Info.ClassColours[standbyTable[i][10]];
		end
		if not colour then
			colour = {
				r = 0.5,
				g = 0,
				b = 0
			};
		end
		if standbyTable[i][5] == "nil" then standbyTable[i][5] = "0"; end;
		if standbyTable[i][6] == "nil" then standbyTable[i][6] = "0"; end;
		if standbyTable[i][7] == "nil" then standbyTable[i][7] = "0"; end;
		if standbyTable[i][8] == "nil" then standbyTable[i][8] = "0"; end;
		if standbyTable[i][9] == "nil" then standbyTable[i][9] = "0"; end;
		if not _G["StandbyAttendanceButton" .. i] then
			local frame = CreateFrame('Button', "StandbyAttendanceButton" .. i, _G["CEPGP_attendance_scrollframe_standby_container"], "AttendanceButtonTemplate");
			if i > 1 then
				_G["StandbyAttendanceButton" .. i]:SetPoint("TOPLEFT", _G["StandbyAttendanceButton" .. i-1], "BOTTOMLEFT", 0, -2);
			else
				_G["StandbyAttendanceButton" .. i]:SetPoint("TOPLEFT", _G["CEPGP_attendance_scrollframe_standby_container"], "TOPLEFT", 0, -10);
			end
		end
		_G["StandbyAttendanceButton" .. i]:Show();
		_G["StandbyAttendanceButton" .. i .. "Info"]:SetText(standbyTable[i][1]);
		_G["StandbyAttendanceButton" .. i .. "Info"]:SetTextColor(colour.r, colour.g, colour.b);
		_G["StandbyAttendanceButton" .. i .. "Rank"]:SetText(standbyTable[i][3]);
		_G["StandbyAttendanceButton" .. i .. "Rank"]:SetTextColor(colour.r, colour.g, colour.b);		
		_G["StandbyAttendanceButton" .. i .. "Total"]:SetText(standbyTable[i][4] .. " (" .. avg*100 .. "%)");
		_G["StandbyAttendanceButton" .. i .. "Total"]:SetTextColor(1-avg,avg/1,0);
		_G["StandbyAttendanceButton" .. i .. "Int7"]:SetText(standbyTable[i][5] .. "/" .. totals[1]);
		if totals[1] == 0 then
			_G["StandbyAttendanceButton" .. i .. "Int7"]:SetTextColor(1-(standbyTable[i][5]/totals[1]), 1, 0);
		else
			_G["StandbyAttendanceButton" .. i .. "Int7"]:SetTextColor(1-(standbyTable[i][5]/totals[1]), (standbyTable[i][5]/totals[1])/1, 0);
		end
		_G["StandbyAttendanceButton" .. i .. "Int14"]:SetText(standbyTable[i][6] .. "/" .. totals[2]);
		if totals[2] == 0 then
			_G["StandbyAttendanceButton" .. i .. "Int14"]:SetTextColor(1-(standbyTable[i][6]/totals[2]), 1, 0);
		else
			_G["StandbyAttendanceButton" .. i .. "Int14"]:SetTextColor(1-(standbyTable[i][6]/totals[2]), (standbyTable[i][6]/totals[2])/1, 0);
		end
		_G["StandbyAttendanceButton" .. i .. "Int30"]:SetText(standbyTable[i][7] .. "/" .. totals[3]);
		if totals[3] == 0 then
			_G["StandbyAttendanceButton" .. i .. "Int30"]:SetTextColor(1-(standbyTable[i][7]/totals[3]), 1, 0);
		else
			_G["StandbyAttendanceButton" .. i .. "Int30"]:SetTextColor(1-(standbyTable[i][7]/totals[3]), (standbyTable[i][7]/totals[3])/1, 0);
		end		
		_G["StandbyAttendanceButton" .. i .. "Int60"]:SetText(standbyTable[i][8] .. "/" .. totals[4]);
		if totals[4] == 0 then
			_G["StandbyAttendanceButton" .. i .. "Int60"]:SetTextColor(1-(standbyTable[i][8]/totals[4]), 1, 0);
		else
			_G["StandbyAttendanceButton" .. i .. "Int60"]:SetTextColor(1-(standbyTable[i][8]/totals[4]), (standbyTable[i][8]/totals[4])/1, 0);
		end
		_G["StandbyAttendanceButton" .. i .. "Int90"]:SetText(standbyTable[i][9] .. "/" .. totals[5]);
		if totals[5] == 0 then
			_G["StandbyAttendanceButton" .. i .. "Int90"]:SetTextColor(1-(standbyTable[i][9]/totals[5]), 1, 0);
		else
			_G["StandbyAttendanceButton" .. i .. "Int90"]:SetTextColor(1-(standbyTable[i][9]/totals[5]), (standbyTable[i][9]/totals[5])/1, 0);
		end
	end
end

function CEPGP_UpdateAltScrollBar()
	local tempTable = {};
	for name, _ in pairs(CEPGP.Alt.Links) do
		table.insert(tempTable, name);
	end
	table.sort(tempTable);
	
	for _, main in ipairs(tempTable) do
		local temp = {};
		
		for index, alt in ipairs(CEPGP.Alt.Links[main]) do
			table.insert(temp, alt);
		end
		
		table.sort(temp);
		tempTable[main] = temp;
	end
	
	local kids = {_G["CEPGP_options_alt_mangement_ScrollFrame_Container"]:GetChildren()};
	for index, child in ipairs(kids) do
		child:Hide();
	end
	for i, main in ipairs(tempTable) do
		local main = tempTable[i];
		local class = select(7, CEPGP_getGuildInfo(main));
		local frame;
		if #tempTable > 0 then
			if not _G["AltFrame" .. i] then
				frame = CreateFrame('Button', "AltFrame" .. i, _G["CEPGP_options_alt_mangement_ScrollFrame_Container"], "AltFrameTemplate");
			else
				frame = _G["AltFrame" .. i];
			end
			
			local colour = CEPGP_Info.ClassColours[class];
			if not colour then
				colour = {
				r = 1,
				g = 1,
				b = 1
			};
			end
			
			local altText;
			
			for index, name in ipairs(tempTable[main]) do
				local altClass = select(7, CEPGP_getGuildInfo(name));
				if index == 1 then
					altText = CEPGP_encodeClassString(altClass, name);
				else
					_G[frame:GetName() .. "AltName"]:SetText(altText .. ", " .. CEPGP_encodeClassString(altClass, name));
					if _G[frame:GetName() .. "AltName"]:GetStringWidth() > 400 then
						altText = altText .. ",\n" .. CEPGP_encodeClassString(altClass, name);
					else
						altText = altText .. ", " .. CEPGP_encodeClassString(altClass, name);
					end
				end
			end
			
			frame:Show();
			_G[frame:GetName() .. "MainName"]:SetText(main);
			_G[frame:GetName() .. "MainName"]:SetTextColor(colour.r, colour.g, colour.b);
			_G[frame:GetName() .. "AltName"]:SetText(altText);
			frame:SetHeight(_G[frame:GetName() .. "AltName"]:GetStringHeight());
			
			if i > 1 then
				frame:SetPoint("TOPLEFT", _G["AltFrame" .. i-1], "BOTTOMLEFT", 0, -20);
			else
				frame:SetPoint("TOPLEFT", _G["CEPGP_options_alt_mangement_ScrollFrame_Container"], "TOPLEFT", 0, -10);
			end
		end
	end
end

function CEPGP_UpdateKeywordScrollBar()
	local kids = {_G["CEPGP_loot_options_keywords_scrollframe_container"]:GetChildren()};
	for _, child in ipairs(kids) do
		child:Hide();
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
		
	for i, v in ipairs(keywords) do
		local label, key, disc = v[1], v[2], v[3];
		if not _G["keywordButton" .. i] then
			local frame = CreateFrame('Button', 'keywordButton' .. i, _G["CEPGP_loot_options_keywords_scrollframe_container"], "KeywordButtonTemplate");
			if i > 1 then
				_G["keywordButton" .. i]:SetPoint("TOPLEFT", _G["keywordButton" .. i-1], "BOTTOMLEFT", 0, -2);
			else
				_G["keywordButton" .. i]:SetPoint("TOP", _G["CEPGP_loot_options_keywords_scrollframe_container"], "TOP", 0, -10);
			end
		end
		_G["keywordButton" .. i]:Show();
		_G["keywordButton" .. i .. "Label"]:SetText(label);
		_G["keywordButton" .. i .. "Keyword"]:SetText(key);
		_G["keywordButton" .. i .. "Discount"]:SetText(disc);
		_G["keywordButton" .. i .. "Label"]:SetTextColor(1, 1, 1);
		_G["keywordButton" .. i .. "Keyword"]:SetTextColor(1, 1, 1);
		_G["keywordButton" .. i .. "Discount"]:SetTextColor(1, 1, 1);
	end
end

function CEPGP_UpdateLogScrollBar()
	
	local call = CEPGP_Info.LastRun.LogSB;
	local quit = false;

	local logs = {};
	for _, data in ipairs(CEPGP.Log) do
		table.insert(logs, data);
	end
	
	local frame = CEPGP_log_container;
	local str = "";
	CEPGP_log_container:SetText("Compiling message log. Please wait...");
	for i = #logs, math.max(1, #logs-2000), -1 do
		if call ~= CEPGP_Info.LastRun.LogSB then
			timer._remainingIterations = 1;
			return;
		end
		
		local absTime =			logs[i][1];
		local msgType =			logs[i][2];
		local source =			logs[i][3];
		local destination =		logs[i][4] or "Channel-Wide";
		local content =			logs[i][5];
		local channel = 		logs[i][6];

		local state = (msgType == "attempt" and "|cFFF5B342Reattempting|r") or (msgType == "abandoned" and "|cFFFF0000Abandoned|r")	or (msgType == "received" and "|cFF03A9FCReceived|r") or (msgType == "sent" and "|cFF00FF00Sent|r");
		str = str .. date("%H:%M:%S", absTime) .. ": Source: " .. source .. ", Scope: " .. destination .. ", Channel: " .. channel .. ", State: " .. state .. "\nContent: " .. content .. "\n\n";
	end
	CEPGP_log_container:SetText(str);
end

