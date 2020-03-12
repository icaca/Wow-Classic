
local myname, ns = ...
local NUMROWS, NUMCOLS, ICONSIZE, ICONGAP, GAP, EDGEGAP = 9, 10, 32, 3, 8, 16
local dirty, rows, offset, scrollbar = true, {}, 0

if select(4, GetBuildInfo()) < 40200 then NUMROWS = 5 end


local stacks = setmetatable({}, {
	__index = function(t, i)
		local _, _, _, _, _, _, _, maxStack = GetItemInfo(i)
		t[i] = maxStack
		return maxStack
	end
})


local links = setmetatable({}, {
	__index = function(t, i)
		local _, link = GetItemInfo(i)
		t[i] = link
		return link
	end
})


local icons = setmetatable({}, {
	__index = function(t, i)
		local texture = GetItemIcon(i)
		t[i] = texture
		return texture
	end
})


function ns.GenerateBagsPanel(frame)
	local group = LibStub("tekKonfig-Group").new(frame, "背包")


	local grouptext = group:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	grouptext:SetHeight(48)
	grouptext:SetPoint("TOPLEFT", group, "TOPLEFT", EDGEGAP, -EDGEGAP)
	grouptext:SetPoint("RIGHT", group, -EDGEGAP-16, 0)
	grouptext:SetNonSpaceWrap(true)
	grouptext:SetJustifyH("LEFT")
	grouptext:SetJustifyV("TOP")
	grouptext:SetText("这些都是你包里的可成组的物品.")


	local function OnClick(self)
		if not self.row.id then return end
		PickupItem(self.row.id)
	end
	local function ShowTooltip(self)
		if not self.row.id then return end
		local _, link = GetItemInfo(self.row.id)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetHyperlink(link)
	end
	local function HideTooltip() GameTooltip:Hide() end
	for i=1,NUMROWS do
		local row = CreateFrame("Frame", nil, group)
		if i == 1 then row:SetPoint("TOP", grouptext, "BOTTOM", 0, -GAP/2)
		else row:SetPoint("TOP", rows[i-1], "BOTTOM", 0, -6) end
		row:SetPoint("LEFT", group, EDGEGAP, 0)
		row:SetPoint("RIGHT", group, -EDGEGAP-16, 0)
		row:SetHeight(ICONSIZE)

		local iconbutton = CreateFrame("Button", nil, row)
		iconbutton:SetPoint("TOPLEFT")
		iconbutton:SetWidth(ICONSIZE)
		iconbutton:SetHeight(ICONSIZE)
		iconbutton.row = row
		iconbutton:SetScript("OnEnter", ShowTooltip)
		iconbutton:SetScript("OnLeave", HideTooltip)
		iconbutton:SetScript("OnClick", OnClick)
		iconbutton:SetScript("OnDragStart", OnClick)
		iconbutton:RegisterForDrag("LeftButton")

		local buttonback = iconbutton:CreateTexture(nil, "ARTWORK")
		buttonback:SetTexture("Interface\\Buttons\\UI-Quickslot2")
		buttonback:SetPoint("CENTER")
		buttonback:SetWidth(ICONSIZE*64/37) buttonback:SetHeight(ICONSIZE*64/37)

		local icon = iconbutton:CreateTexture(nil, "ARTWORK")
		icon:SetAllPoints()

		local name = row:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		name:SetPoint("TOPLEFT", iconbutton, "TOPRIGHT", GAP-6, 0)
		name:SetPoint("RIGHT", row)
		name:SetJustifyH("LEFT")
		name:SetText("[Bacon Ipsum]")

		local stack = row:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		stack:SetPoint("TOPLEFT", name, "BOTTOMLEFT", 0, -2)
		stack:SetPoint("RIGHT", row)
		stack:SetJustifyH("LEFT")
		stack:SetText("堆叠数: 20")

		rows[i], row.icon, row.name, row.stack = row, icon, name, stack
	end


	scrollbar = LibStub("tekKonfig-Scroll").new(group, 6, 1)
	scrollbar:SetValue(0)

	local f = scrollbar:GetScript("OnValueChanged")
	scrollbar:SetScript("OnValueChanged", function(self, value, ...)
		offset = math.floor(value)
		ns.UpdateBagList()
		return f(self, value, ...)
	end)


	group:EnableMouseWheel()
	group:SetScript("OnShow", ns.UpdateBagList)
	group:SetScript("OnMouseWheel", function(self, val) scrollbar:SetValue(scrollbar:GetValue() - val*3) end)
	group:SetScript("OnEvent", function() dirty = true end)
	group:RegisterEvent("BAG_UPDATE")


	ns.UpdateBagList()
	return group
end


local ids, sortedlist = {}, {}
function ns.UpdateBagList()
	if dirty then
		wipe(ids)
		wipe(sortedlist)

		for bag=0,4 do
			for slot=1,GetContainerNumSlots(bag) do
				local id = GetContainerItemID(bag, slot)
				if id and stacks[id] > 1 then
					ids[id] = true
				end
			end
		end

		for id in pairs(ids) do table.insert(sortedlist, id) end
		table.sort(sortedlist)

		scrollbar:SetMinMaxValues(0, math.max(#sortedlist - NUMROWS, 0))

		dirty = false
	end

	for i,row in pairs(rows) do
		local id = sortedlist[i + offset]
		if id then
			row.id = id
			row.icon:SetTexture(icons[id])
			row.name:SetText(links[id])
			row.stack:SetText("堆叠数: "..(stacks[id] or "???"))
			row:Show()
		else
			row:Hide()
		end
	end
end