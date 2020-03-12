function CEPGP_UpdateLootScrollBar(sort)
	local tempTable = {};
	local count = 1;
	for name, id in pairs(CEPGP_itemsTable) do
		local EP, GP;
		if CEPGP_roster[name] then
			EP, GP = CEPGP_getEPGP(CEPGP_roster[name][5], CEPGP_roster[name][1], name)
			tempTable[count] = {
				[1] = name,
				[2] = CEPGP_roster[name][2], --Class
				[3] = CEPGP_roster[name][3], --Rank
				[4] = CEPGP_roster[name][4], --RankIndex
				[5] = EP,
				[6] = GP,
				[7] = math.floor((tonumber(EP)/tonumber(GP))*100)/100,
				[8] = CEPGP_itemsTable[name][1] or "noitem",
				[9] = CEPGP_itemsTable[name][2] or "noitem",
				[10] = CEPGP_roster[name][7], --className in English
				[11] = CEPGP_itemsTable[name][3] -- Loot response
			};
		else
			EP = 0;
			GP = BASEGP;
			for i = 1, GetNumGroupMembers() do
				if GetRaidRosterInfo(i) == name then
					local class = select(5, GetRaidRosterInfo(i))
					local rank = "Not in Guild";
					local rankIndex = 11;
					local classFile = select(6, GetRaidRosterInfo(i));
					tempTable[count] = {
					[1] = name,
					[2] = class,
					[3] = rank,
					[4] = rankIndex,
					[5] = EP,
					[6] = GP,
					[7] = math.floor((tonumber(EP)/tonumber(GP))*100)/100,
					[8] = CEPGP_itemsTable[name][1] or "noitem",
					[9] = CEPGP_itemsTable[name][2] or "noitem",
					[10] = classFile,
					[11] = CEPGP_itemsTable[name][3] -- Loot response
				};
				end
			end
		end		
		count = count + 1;
	end
	if sort and CEPGP_PR_sort then
		tempTable = CEPGP_sortDistList(tempTable);
	end
	--tempTable = CEPGP_tSort(tempTable, CEPGP_criteria);
	local kids = {_G["CEPGP_dist_scrollframe_container"]:GetChildren()};
	for _, child in ipairs(kids) do
		child:Hide();
	end
	for i = 1, #tempTable do
		if not _G["LootDistButton" .. i] then
			local frame = CreateFrame('Button', "LootDistButton" .. i, _G["CEPGP_dist_scrollframe_container"], "LootDistButtonTemplate");
			if i > 1 then
				_G["LootDistButton" .. i]:SetPoint("TOPLEFT", _G["LootDistButton" .. i-1], "BOTTOMLEFT", 0, -2);
			else
				_G["LootDistButton" .. i]:SetPoint("TOPLEFT", _G["CEPGP_dist_scrollframe_container"], "TOPLEFT", 0, -10);
			end
		end
		local response = tempTable[i][11];
		tempTable[i][11] = CEPGP_response_buttons[tonumber(response)][2];
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
						local colour = RAID_CLASS_COLORS[string.upper(tempTable[i][10])];
						if not colour then
							colour = {
							r = 1,
							g = 1,
							b = 1
						};
						end
						_G["LootDistButton" .. i]:Show();
						_G["LootDistButton" .. i]:SetAttribute("response", response);
						_G["LootDistButton" .. i]:SetAttribute("responseName", tempTable[i][11]);
						_G["LootDistButton" .. i .. "Info"]:SetText(tempTable[i][1]);
						_G["LootDistButton" .. i .. "Info"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "Class"]:SetText(tempTable[i][2]);
						_G["LootDistButton" .. i .. "Class"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "Rank"]:SetText(tempTable[i][3]);
						_G["LootDistButton" .. i .. "Rank"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "Response"]:SetText(tempTable[i][11]);
						_G["LootDistButton" .. i .. "Response"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "EP"]:SetText(tempTable[i][5]);
						_G["LootDistButton" .. i .. "EP"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "GP"]:SetText(tempTable[i][6]);
						_G["LootDistButton" .. i .. "GP"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "PR"]:SetText(string.format("%.2f", tempTable[i][7]));
						_G["LootDistButton" .. i .. "PR"]:SetTextColor(colour.r, colour.g, colour.b);
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
					local colour = RAID_CLASS_COLORS[string.upper(tempTable[i][10])];
					if not colour then
						colour = {
						r = 1,
						g = 1,
						b = 1
					};
					end
					_G["LootDistButton" .. i]:Show();
					_G["LootDistButton" .. i]:SetAttribute("response", response);
					_G["LootDistButton" .. i]:SetAttribute("responseName", tempTable[i][11]);
					_G["LootDistButton" .. i .. "Info"]:SetText(tempTable[i][1]);
					_G["LootDistButton" .. i .. "Info"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "Class"]:SetText(tempTable[i][2]);
					_G["LootDistButton" .. i .. "Class"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "Rank"]:SetText(tempTable[i][3]);
					_G["LootDistButton" .. i .. "Rank"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "Response"]:SetText(tempTable[i][11]);
					_G["LootDistButton" .. i .. "Response"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "EP"]:SetText(tempTable[i][5]);
					_G["LootDistButton" .. i .. "EP"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "GP"]:SetText(tempTable[i][6]);
					_G["LootDistButton" .. i .. "GP"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "PR"]:SetText(string.format("%.2f", tempTable[i][7]));
					_G["LootDistButton" .. i .. "PR"]:SetTextColor(colour.r, colour.g, colour.b);
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
						local colour = RAID_CLASS_COLORS[string.upper(tempTable[i][10])];
						if not colour then
							colour = {
							r = 1,
							g = 1,
							b = 1
						};
						end
						_G["LootDistButton" .. i]:Show();
						_G["LootDistButton" .. i]:SetAttribute("response", response);
						_G["LootDistButton" .. i]:SetAttribute("responseName", tempTable[i][11]);
						_G["LootDistButton" .. i .. "Info"]:SetText(tempTable[i][1]);
						_G["LootDistButton" .. i .. "Info"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "Class"]:SetText(tempTable[i][2]);
						_G["LootDistButton" .. i .. "Class"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "Rank"]:SetText(tempTable[i][3]);
						_G["LootDistButton" .. i .. "Rank"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "Response"]:SetText(tempTable[i][11]);
						_G["LootDistButton" .. i .. "Response"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "EP"]:SetText(tempTable[i][5]);
						_G["LootDistButton" .. i .. "EP"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "GP"]:SetText(tempTable[i][6]);
						_G["LootDistButton" .. i .. "GP"]:SetTextColor(colour.r, colour.g, colour.b);
						_G["LootDistButton" .. i .. "PR"]:SetText(string.format("%.2f", tempTable[i][7]));
						_G["LootDistButton" .. i .. "PR"]:SetTextColor(colour.r, colour.g, colour.b);
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
					local colour = RAID_CLASS_COLORS[string.upper(tempTable[i][10])];
					if not colour then
						colour = {
						r = 1,
						g = 1,
						b = 1
					};
					end
					_G["LootDistButton" .. i]:Show();
					_G["LootDistButton" .. i]:SetAttribute("response", response);
					_G["LootDistButton" .. i]:SetAttribute("responseName", tempTable[i][11]);
					_G["LootDistButton" .. i .. "Info"]:SetText(tempTable[i][1]);
					_G["LootDistButton" .. i .. "Info"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "Class"]:SetText(tempTable[i][2]);
					_G["LootDistButton" .. i .. "Class"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "Rank"]:SetText(tempTable[i][3]);
					_G["LootDistButton" .. i .. "Rank"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "Response"]:SetText(tempTable[i][11]);
					_G["LootDistButton" .. i .. "Response"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "EP"]:SetText(tempTable[i][5]);
					_G["LootDistButton" .. i .. "EP"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "GP"]:SetText(tempTable[i][6]);
					_G["LootDistButton" .. i .. "GP"]:SetTextColor(colour.r, colour.g, colour.b);
					_G["LootDistButton" .. i .. "PR"]:SetText(string.format("%.2f", tempTable[i][7]));
					_G["LootDistButton" .. i .. "PR"]:SetTextColor(colour.r, colour.g, colour.b);
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
			local colour = RAID_CLASS_COLORS[string.upper(tempTable[i][10])];
			if not colour then
				colour = {
				r = 1,
				g = 1,
				b = 1
			};
			end
			_G["LootDistButton" .. i]:Show();
			_G["LootDistButton" .. i]:SetAttribute("response", response);
			_G["LootDistButton" .. i]:SetAttribute("responseName", tempTable[i][11]);
			_G["LootDistButton" .. i .. "Info"]:SetText(tempTable[i][1]);
			_G["LootDistButton" .. i .. "Info"]:SetTextColor(colour.r, colour.g, colour.b);
			_G["LootDistButton" .. i .. "Class"]:SetText(tempTable[i][2]);
			_G["LootDistButton" .. i .. "Class"]:SetTextColor(colour.r, colour.g, colour.b);
			_G["LootDistButton" .. i .. "Rank"]:SetText(tempTable[i][3]);
			_G["LootDistButton" .. i .. "Rank"]:SetTextColor(colour.r, colour.g, colour.b);
			_G["LootDistButton" .. i .. "Response"]:SetText(tempTable[i][11]);
			_G["LootDistButton" .. i .. "Response"]:SetTextColor(colour.r, colour.g, colour.b);
			_G["LootDistButton" .. i .. "EP"]:SetText(tempTable[i][5]);
			_G["LootDistButton" .. i .. "EP"]:SetTextColor(colour.r, colour.g, colour.b);
			_G["LootDistButton" .. i .. "GP"]:SetText(tempTable[i][6]);
			_G["LootDistButton" .. i .. "GP"]:SetTextColor(colour.r, colour.g, colour.b);
			_G["LootDistButton" .. i .. "PR"]:SetText(string.format("%.2f", tempTable[i][7]));
			_G["LootDistButton" .. i .. "PR"]:SetTextColor(colour.r, colour.g, colour.b);
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
	local tempTable = {};
	for name, v in pairs(CEPGP_roster) do
		local EP, GP = CEPGP_getEPGP(v[5], v[1], name)
		if not EP then EP = 0; end
		if not GP then GP = BASEGP; end
		tempTable[v[1]] = {
			[1] = name,
			[2] = v[2], --Class
			[3] = v[3], --Rank
			[4] = v[4], --RankIndex
			[5] = EP,
			[6] = GP,
			[7] = math.floor((tonumber(EP)/tonumber(GP))*100)/100,
			[8] = v[7] -- className in English
		};
	end
	tempTable = CEPGP_tSort(tempTable, CEPGP_criteria);
	local kids = {_G["CEPGP_guild_scrollframe_container"]:GetChildren()};
	for _, child in ipairs(kids) do
		child:Hide();
	end
	for i = 1, CEPGP_ntgetn(tempTable) do
		if not _G["GuildButton" .. i] then
			local frame = CreateFrame('Button', "GuildButton" .. i, _G["CEPGP_guild_scrollframe_container"], "GuildButtonTemplate");
			if i > 1 then
				_G["GuildButton" .. i]:SetPoint("TOPLEFT", _G["GuildButton" .. i-1], "BOTTOMLEFT", 0, -2);
			else
				_G["GuildButton" .. i]:SetPoint("TOPLEFT", _G["CEPGP_guild_scrollframe_container"], "TOPLEFT", 0, -10);
			end
		end
		local colour = RAID_CLASS_COLORS[string.upper(tempTable[i][8])];
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
end

function CEPGP_UpdateRaidScrollBar()
	local tempTable = {};
	for i = 1, CEPGP_ntgetn(CEPGP_raidRoster) do
		local name = CEPGP_raidRoster[i][1];
		local EP, GP;
		if CEPGP_roster[name] then
			EP, GP = CEPGP_getEPGP(CEPGP_roster[name][5], CEPGP_roster[name][1], name);
			if not EP then EP = 0; end
			if not GP then GP = BASEGP; end
			tempTable[i] = {
				[1] = name,
				[2] = CEPGP_roster[name][2], --Class
				[3] = CEPGP_roster[name][3], --Rank
				[4] = CEPGP_roster[name][4], --RankIndex
				[5] = EP,
				[6] = GP,
				[7] = math.floor((tonumber(EP)/tonumber(GP))*100)/100,
				[8] = CEPGP_roster[name][7] --Class in English
			};
		else
			tempTable[i] = {
				[1] = name,
				[2] = CEPGP_raidRoster[i][2], --Class
				[3] = CEPGP_raidRoster[i][3], --Rank
				[4] = CEPGP_raidRoster[i][4], --RankIndex
				[5] = CEPGP_raidRoster[i][5], --EP
				[6] = CEPGP_raidRoster[i][6], --GP
				[7] = CEPGP_raidRoster[i][7], --PR
				[8] = CEPGP_raidRoster[i][8]  --Class in English
			};
		end
		
	end
	tempTable = CEPGP_tSort(tempTable, CEPGP_criteria);
	local kids = {_G["CEPGP_raid_scrollframe_container"]:GetChildren()};
	for _, child in ipairs(kids) do
		child:Hide();
	end
	for i = 1, CEPGP_ntgetn(CEPGP_raidRoster) do
		if not _G["RaidButton" .. i] then
			local frame = CreateFrame('Button', "RaidButton" .. i, _G["CEPGP_raid_scrollframe_container"], "RaidButtonTemplate");
			if i > 1 then
				_G["RaidButton" .. i]:SetPoint("TOPLEFT", _G["RaidButton" .. i-1], "BOTTOMLEFT", 0, -2);
			else
				_G["RaidButton" .. i]:SetPoint("TOPLEFT", _G["CEPGP_raid_scrollframe_container"], "TOPLEFT", 0, -10);
			end
		end
		local colour = RAID_CLASS_COLORS[string.upper(tempTable[i][8])];
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
	if CEPGP_vSearch == "GUILD" then
		for i = 1, #tempTable do
			if not _G["versionButton" .. i] then
				local frame = CreateFrame('Button', "versionButton" .. i, _G["CEPGP_version_scrollframe_container"], "versionButtonTemplate"); -- Creates version frames if needed
				if i > 1 then
					_G["versionButton" .. i]:SetPoint("TOPLEFT", _G["versionButton" .. i-1], "BOTTOMLEFT", 0, -2);
				else
					_G["versionButton" .. i]:SetPoint("TOPLEFT", _G["CEPGP_version_scrollframe_container"], "TOPLEFT", 5, -6);
				end
			end
			_G["versionButton" .. i]:Show();
			local name = tempTable[i][1];
			local classFile = tempTable[i][4];
			local colour = RAID_CLASS_COLORS[classFile];
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
		end
	else
		for i = 1, CEPGP_ntgetn(tempTable) do
			_G["versionButton" .. i]:Show();
			for x = 1, GetNumGroupMembers() do
				if tempTable[x][1] == GetRaidRosterInfo(i) then
					name = tempTable[x][1];
					version = tempTable[x][2];
					class = tempTable[x][3];
					classFile = tempTable[x][4];
				--	print(name);
				--	print(class);
					local colour = RAID_CLASS_COLORS[classFile];
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
					break;
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
	local kids = {_G["CEPGP_traffic_scrollframe_container"]:GetChildren()};
	for _, child in ipairs(kids) do
		child:Hide();
	end
	local search = CEPGP_traffic_search:GetText();
	local results = {};
	local matches = 1;
	for i = 1, #TRAFFIC do
		local name, issuer, action, EPB, EPA, GPB, GPA, item, tStamp = TRAFFIC[i][1] or "", TRAFFIC[i][2] or "", TRAFFIC[i][3] or "", TRAFFIC[i][4] or "", TRAFFIC[i][5] or "", TRAFFIC[i][6] or "", TRAFFIC[i][7] or "", TRAFFIC[i][8] or "", TRAFFIC[i][9];
		if tStamp then
			tStamp = date("Time: %I:%M%p\nDate: %a, %d %B %Y", tStamp);
		else
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
				[9] = tStamp
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
				[9] = tStamp
			};
			matches = matches + 1;
		end
	end
	for i = #results, 1, -1 do
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
		if results[i][9] then
			_G["TrafficButton" .. i]:SetScript('OnEnter', function()
				GameTooltip:SetOwner(_G["TrafficButton" .. i], "ANCHOR_TOPLEFT");
				GameTooltip:SetText(results[i][9]);
			end);
			_G["TrafficButton" .. i]:SetScript('OnLeave', function()
				GameTooltip:Hide();
			end);
		else
			_G["TrafficButton" .. i]:SetScript('OnEnter', function() end);
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
					local newItem = Item:CreateFromItemID(id);
					newItem:ContinueOnItemLoad(function()
						_, link = GetItemInfo(results[i][8]);
						_G["TrafficButton" .. i .. "Item"]:SetScript('OnClick', function() SetItemRef(link) end);
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
		if CEPGP_standbyRoster[i][1] then
			_, _, _, _, _, _, _, _, online = GetGuildRosterInfo(CEPGP_getIndex(CEPGP_standbyRoster[i][1]));
		end
		tempTable[i] = {
			[1] = CEPGP_standbyRoster[i][1], --name
			[2] = CEPGP_standbyRoster[i][2], --class
			[3] = CEPGP_standbyRoster[i][3], --rank
			[4] = CEPGP_standbyRoster[i][4], --rankIndex
			[5] = CEPGP_standbyRoster[i][5], --EP
			[6] = CEPGP_standbyRoster[i][6], --GP
			[7] = CEPGP_standbyRoster[i][7],
			[8] = CEPGP_standbyRoster[i][8], --ClassFile
			[9] = online --Online
		};
		local colour;
		if tempTable[i][9] then
			colour = RAID_CLASS_COLORS[tempTable[i][8]];
			_G["StandbyButton" .. i]:SetScript('OnEnter', function() end);
		else
			colour = {
				r = 0.62,
				g = 0.62,
				b = 0.62
			};
			_G["StandbyButton" .. i]:SetScript('OnEnter', function()
				GameTooltip:SetOwner(_G["StandbyButton" .. i], "ANCHOR_TOPLEFT");
				GameTooltip:SetText("Player Offline");
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
	local name, class, classFile, rank, index, total, week, fn, month, twoMon, threeMon;
	local size;
	local sbCount = 1;
	local count = 1;
	if CEPGP_snapshot then 
		size = #CEPGP_raid_logs[CEPGP_snapshot]-1;
	else
		size = CEPGP_ntgetn(CEPGP_roster);
	end
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
		index, class, rank, _, _, _, classFile = CEPGP_getGuildInfo(name);
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
				[11] = standby
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
				[11] = false
			}
			count = count + 1;
		end
	end
	tempTable = CEPGP_tSort(tempTable, CEPGP_criteria);
	standbyTable = CEPGP_tSort(standbyTable, CEPGP_criteria);
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
		_G["CEPGP_attendance_header_total"]:SetText("Total Snapshots Recorded: " .. #CEPGP_raid_logs);
	else
		_G["CEPGP_attendance_header_total"]:SetText("Total Snapshots Recorded: 0");
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
			colour = RAID_CLASS_COLORS[tempTable[i][10]];
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
			colour = RAID_CLASS_COLORS[standbyTable[i][10]];
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