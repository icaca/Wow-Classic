﻿local _, ns = ...
local B, C, L, DB = unpack(ns)

local module = B:RegisterModule("Bags")
local cargBags = ns.cargBags

local ipairs, strmatch, unpack, ceil = ipairs, string.match, unpack, math.ceil
local LE_ITEM_QUALITY_POOR, LE_ITEM_QUALITY_RARE = LE_ITEM_QUALITY_POOR, LE_ITEM_QUALITY_RARE
local LE_ITEM_CLASS_WEAPON, LE_ITEM_CLASS_ARMOR, LE_ITEM_CLASS_QUIVER = LE_ITEM_CLASS_WEAPON, LE_ITEM_CLASS_ARMOR, LE_ITEM_CLASS_QUIVER
local GetContainerNumSlots, GetContainerItemInfo, PickupContainerItem = GetContainerNumSlots, GetContainerItemInfo, PickupContainerItem
local C_NewItems_IsNewItem, C_NewItems_RemoveNewItem = C_NewItems.IsNewItem, C_NewItems.RemoveNewItem
local IsControlKeyDown, IsAltKeyDown, DeleteCursorItem = IsControlKeyDown, IsAltKeyDown, DeleteCursorItem
local SortBankBags, SortBags, InCombatLockdown, ClearCursor = SortBankBags, SortBags, InCombatLockdown, ClearCursor
local GetContainerItemID, SplitContainerItem = GetContainerItemID, SplitContainerItem
local NUM_BAG_SLOTS = NUM_BAG_SLOTS or 4
local NUM_BANKBAGSLOTS = NUM_BANKBAGSLOTS or 6

function module:UpdateAnchors(parent, bags)
	local anchor = parent
	for _, bag in ipairs(bags) do
		if bag:GetHeight() > 45 then
			bag:Show()
		else
			bag:Hide()
		end
		if bag:IsShown() then
			bag:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, 5)
			anchor = bag
		end
	end
end

local function highlightFunction(button, match)
	button:SetAlpha(match and 1 or .3)
end

function module:CreateInfoFrame()
	local infoFrame = CreateFrame("Button", nil, self)
	infoFrame:SetPoint("TOPLEFT", 10, 0)
	infoFrame:SetSize(160, 32)
	local icon = infoFrame:CreateTexture()
	icon:SetSize(24, 24)
	icon:SetPoint("LEFT")
	icon:SetTexture("Interface\\Minimap\\Tracking\\None")
	icon:SetTexCoord(1, 0, 0, 1)

	local search = self:SpawnPlugin("SearchBar", infoFrame)
	search.highlightFunction = highlightFunction
	search.isGlobal = true
	search:SetPoint("LEFT", 0, 5)
	search:DisableDrawLayer("BACKGROUND")
	local bg = B.CreateBDFrame(search, 0)
	bg:SetPoint("TOPLEFT", -5, -5)
	bg:SetPoint("BOTTOMRIGHT", 5, 5)
	B.CreateGradient(bg)

	local tag = self:SpawnPlugin("TagDisplay", "[money]", infoFrame)
	tag:SetFont(unpack(DB.Font))
	tag:SetPoint("LEFT", icon, "RIGHT", 5, 0)
end

function module:CreateBagBar(settings, columns)
	local bagBar = self:SpawnPlugin("BagBar", settings.Bags)
	local width, height = bagBar:LayoutButtons("grid", columns, 5, 5, -5)
	bagBar:SetSize(width + 10, height + 10)
	bagBar:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", 0, -5)
	B.SetBD(bagBar)
	bagBar.highlightFunction = highlightFunction
	bagBar.isGlobal = true
	bagBar:Hide()

	self.BagBar = bagBar
end

function module:CreateCloseButton()
	local bu = B.CreateButton(self, 24, 24, true, "Interface\\RAIDFRAME\\ReadyCheck-NotReady")
	bu:SetScript("OnClick", CloseAllBags)
	bu.title = CLOSE
	B.AddTooltip(bu, "ANCHOR_TOP")

	return bu
end

function module:CreateRestoreButton(f)
	local bu = B.CreateButton(self, 24, 24, true, "Atlas:transmog-icon-revert")
	bu:SetScript("OnClick", function()
		C.db["TempAnchor"][f.main:GetName()] = nil
		C.db["TempAnchor"][f.bank:GetName()] = nil
		f.main:ClearAllPoints()
		f.main:SetPoint("BOTTOMRIGHT", -50, 320)
		f.bank:ClearAllPoints()
		f.bank:SetPoint("BOTTOMRIGHT", f.main, "BOTTOMLEFT", -10, 0)
		PlaySound(SOUNDKIT.IG_MINIMAP_OPEN)
	end)
	bu.title = RESET
	B.AddTooltip(bu, "ANCHOR_TOP")

	return bu
end

function module:CreateBagToggle()
	local bu = B.CreateButton(self, 24, 24, true, "Interface\\Buttons\\Button-Backpack-Up")
	bu:SetScript("OnClick", function()
		ToggleFrame(self.BagBar)
		if self.BagBar:IsShown() then
			bu:SetBackdropBorderColor(1, .8, 0)
			PlaySound(SOUNDKIT.IG_BACKPACK_OPEN)
			if self.keyring and self.keyring:IsShown() then self.keyToggle:Click() end
		else
			bu:SetBackdropBorderColor(0, 0, 0)
			PlaySound(SOUNDKIT.IG_BACKPACK_CLOSE)
		end
	end)
	bu.title = BACKPACK_TOOLTIP
	B.AddTooltip(bu, "ANCHOR_TOP")
	self.bagToggle = bu

	return bu
end

function module:CreateKeyToggle()
	local bu = B.CreateButton(self, 24, 24, true, "Interface\\ICONS\\INV_Misc_Key_12")
	bu:SetScript("OnClick", function()
		ToggleFrame(self.keyring)
		if self.keyring:IsShown() then
			bu:SetBackdropBorderColor(1, .8, 0)
			PlaySound(SOUNDKIT.KEY_RING_OPEN)
			if self.BagBar and self.BagBar:IsShown() then self.bagToggle:Click() end
		else
			bu:SetBackdropBorderColor(0, 0, 0)
			PlaySound(SOUNDKIT.KEY_RING_CLOSE)
		end
	end)
	bu.title = KEYRING
	B.AddTooltip(bu, "ANCHOR_TOP")
	self.keyToggle = bu

	return bu
end

function module:CreateSortButton(name)
	local bu = B.CreateButton(self, 24, 24, true, DB.sortTex)
	bu:SetScript("OnClick", function()
		if InCombatLockdown() then
			UIErrorsFrame:AddMessage(DB.InfoColor..ERR_NOT_IN_COMBAT)
			return
		end

		if name == "Bank" then
			SortBankBags()
		else
			SortBags()
		end
	end)
	bu.title = L["Sort"]
	B.AddTooltip(bu, "ANCHOR_TOP")

	return bu
end

function module:GetContainerEmptySlot(bagID)
	local bagType = module.BagsType[bagID]
	for slotID = 1, GetContainerNumSlots(bagID) do
		if not GetContainerItemID(bagID, slotID) and bagType == 0 then
			return slotID
		end
	end
end

function module:GetEmptySlot(name)
	if name == "Main" then
		for bagID = 0, NUM_BAG_SLOTS do
			local slotID = module:GetContainerEmptySlot(bagID)
			if slotID then
				return bagID, slotID
			end
		end
	elseif name == "Bank" then
		local slotID = module:GetContainerEmptySlot(-1)
		if slotID then
			return -1, slotID
		end
		for bagID = NUM_BAG_SLOTS+1, NUM_BAG_SLOTS+NUM_BANKBAGSLOTS do
			local slotID = module:GetContainerEmptySlot(bagID)
			if slotID then
				return bagID, slotID
			end
		end
	end
end

function module:FreeSlotOnDrop()
	local bagID, slotID = module:GetEmptySlot(self.__name)
	if slotID then
		PickupContainerItem(bagID, slotID)
	end
end

local freeSlotContainer = {
	["Main"] = true,
	["Bank"] = true,
}

function module:CreateFreeSlots()
	local name = self.name
	if not freeSlotContainer[name] then return end

	local slot = CreateFrame("Button", name.."FreeSlot", self)
	slot:SetSize(self.iconSize, self.iconSize)
	slot:SetHighlightTexture(DB.bdTex)
	slot:GetHighlightTexture():SetVertexColor(1, 1, 1, .25)
	slot:GetHighlightTexture():SetInside()
	B.CreateBD(slot, .3)
	slot:SetBackdropColor(.3, .3, .3, .3)
	slot:SetScript("OnMouseUp", module.FreeSlotOnDrop)
	slot:SetScript("OnReceiveDrag", module.FreeSlotOnDrop)
	B.AddTooltip(slot, "ANCHOR_RIGHT", L["FreeSlots"])
	slot.__name = name

	local tag = self:SpawnPlugin("TagDisplay", "[space]", slot)
	tag:SetFont(DB.Font[1], DB.Font[2]+2, DB.Font[3])
	tag:SetTextColor(.6, .8, 1)
	tag:SetPoint("CENTER", 1, 0)
	tag.__name = name

	self.freeSlot = slot
end

local toggleButtons = {}
function module:SelectToggleButton(id)
	for index, button in pairs(toggleButtons) do
		if index ~= id then
			button.__turnOff()
		end
	end
end

local splitEnable
local function saveSplitCount(self)
	local count = self:GetText() or ""
	C.db["Bags"]["SplitCount"] = tonumber(count) or 1
end

function module:CreateSplitButton()
	local enabledText = DB.InfoColor..L["SplitMode Enabled"]

	local splitFrame = CreateFrame("Frame", nil, self)
	splitFrame:SetSize(100, 50)
	splitFrame:SetPoint("TOPRIGHT", self, "TOPLEFT", -5, 0)
	B.CreateFS(splitFrame, 14, L["SplitCount"], "system", "TOP", 1, -5)
	B.SetBD(splitFrame)
	splitFrame:Hide()
	local editbox = B.CreateEditBox(splitFrame, 90, 20)
	editbox:SetPoint("BOTTOMLEFT", 5, 5)
	editbox:SetJustifyH("CENTER")
	editbox:SetScript("OnTextChanged", saveSplitCount)

	local bu = B.CreateButton(self, 24, 24, true, "Interface\\HELPFRAME\\ReportLagIcon-AuctionHouse")
	bu.Icon:SetPoint("TOPLEFT", -1, 3)
	bu.Icon:SetPoint("BOTTOMRIGHT", 1, -3)
	bu.__turnOff = function()
		bu:SetBackdropBorderColor(0, 0, 0)
		bu.text = nil
		splitFrame:Hide()
		splitEnable = nil
	end
	bu:SetScript("OnClick", function(self)
		module:SelectToggleButton(1)
		splitEnable = not splitEnable
		if splitEnable then
			self:SetBackdropBorderColor(1, .8, 0)
			self.text = enabledText
			splitFrame:Show()
			editbox:SetText(C.db["Bags"]["SplitCount"])
		else
			self.__turnOff()
		end
		self:GetScript("OnEnter")(self)
	end)
	bu:SetScript("OnHide", bu.__turnOff)
	bu.title = L["QuickSplit"]
	B.AddTooltip(bu, "ANCHOR_TOP")

	toggleButtons[1] = bu

	return bu
end

local function splitOnClick(self)
	if not splitEnable then return end

	PickupContainerItem(self.bagID, self.slotID)

	local texture, itemCount, locked = GetContainerItemInfo(self.bagID, self.slotID)
	if texture and not locked and itemCount and itemCount > C.db["Bags"]["SplitCount"] then
		SplitContainerItem(self.bagID, self.slotID, C.db["Bags"]["SplitCount"])

		local bagID, slotID = module:GetEmptySlot("Main")
		if slotID then
			PickupContainerItem(bagID, slotID)
		end
	end
end

local favouriteEnable
function module:CreateFavouriteButton()
	local enabledText = DB.InfoColor..L["FavouriteMode Enabled"]

	local bu = B.CreateButton(self, 24, 24, true, "Interface\\Common\\friendship-heart")
	bu.Icon:SetPoint("TOPLEFT", -5, 0)
	bu.Icon:SetPoint("BOTTOMRIGHT", 5, -5)
	bu.__turnOff = function()
		bu:SetBackdropBorderColor(0, 0, 0)
		bu.text = nil
		favouriteEnable = nil
	end
	bu:SetScript("OnClick", function(self)
		module:SelectToggleButton(2)
		favouriteEnable = not favouriteEnable
		if favouriteEnable then
			self:SetBackdropBorderColor(1, .8, 0)
			self.text = enabledText
		else
			self.__turnOff()
		end
		self:GetScript("OnEnter")(self)
	end)
	bu:SetScript("OnHide", bu.__turnOff)
	bu.title = L["FavouriteMode"]
	B.AddTooltip(bu, "ANCHOR_TOP")

	toggleButtons[2] = bu

	return bu
end

local function favouriteOnClick(self)
	if not favouriteEnable then return end

	local texture, _, _, quality, _, _, _, _, _, itemID = GetContainerItemInfo(self.bagID, self.slotID)
	if texture and quality > LE_ITEM_QUALITY_POOR then
		if C.db["Bags"]["FavouriteItems"][itemID] then
			C.db["Bags"]["FavouriteItems"][itemID] = nil
		else
			C.db["Bags"]["FavouriteItems"][itemID] = true
		end
		ClearCursor()
		module:UpdateAllBags()
	end
end

StaticPopupDialogs["NDUI_WIPE_JUNK_LIST"] = {
	text = L["Reset junklist warning"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		wipe(NDuiADB["CustomJunkList"])
	end,
	whileDead = 1,
}
local customJunkEnable
function module:CreateJunkButton()
	local enabledText = DB.InfoColor..L["JunkMode Enabled"]

	local bu = B.CreateButton(self, 24, 24, true, "Interface\\BUTTONS\\UI-GroupLoot-Coin-Up")
	bu.Icon:SetPoint("TOPLEFT", C.mult, -3)
	bu.Icon:SetPoint("BOTTOMRIGHT", -C.mult, -3)
	bu.__turnOff = function()
		bu:SetBackdropBorderColor(0, 0, 0)
		bu.text = nil
		customJunkEnable = nil
	end
	bu:SetScript("OnClick", function(self)
		if IsAltKeyDown() and IsControlKeyDown() then
			StaticPopup_Show("NDUI_WIPE_JUNK_LIST")
			return
		end

		module:SelectToggleButton(3)
		customJunkEnable = not customJunkEnable
		if customJunkEnable then
			self:SetBackdropBorderColor(1, .8, 0)
			self.text = enabledText
		else
			bu.__turnOff()
		end
		module:UpdateAllBags()
		self:GetScript("OnEnter")(self)
	end)
	bu:SetScript("OnHide", bu.__turnOff)
	bu.title = L["CustomJunkMode"]
	B.AddTooltip(bu, "ANCHOR_TOP")

	toggleButtons[3] = bu

	return bu
end

local function customJunkOnClick(self)
	if not customJunkEnable then return end

	local texture, _, _, _, _, _, _, _, _, itemID = GetContainerItemInfo(self.bagID, self.slotID)
	local price = select(11, GetItemInfo(itemID))
	if texture and price > 0 then
		if NDuiADB["CustomJunkList"][itemID] then
			NDuiADB["CustomJunkList"][itemID] = nil
		else
			NDuiADB["CustomJunkList"][itemID] = true
		end
		ClearCursor()
		module:UpdateAllBags()
	end
end

local deleteEnable
function module:CreateDeleteButton()
	local enabledText = DB.InfoColor..L["DeleteMode Enabled"]

	local bu = B.CreateButton(self, 24, 24, true, "Interface\\Buttons\\UI-GroupLoot-Pass-Up")
	bu.Icon:SetPoint("TOPLEFT", 3, -2)
	bu.Icon:SetPoint("BOTTOMRIGHT", -1, 2)
	bu.__turnOff = function()
		bu:SetBackdropBorderColor(0, 0, 0)
		bu.text = nil
		deleteEnable = nil
	end
	bu:SetScript("OnClick", function(self)
		module:SelectToggleButton(4)
		deleteEnable = not deleteEnable
		if deleteEnable then
			self:SetBackdropBorderColor(1, .8, 0)
			self.text = enabledText
		else
			bu.__turnOff()
		end
		self:GetScript("OnEnter")(self)
	end)
	bu:SetScript("OnHide", bu.__turnOff)
	bu.title = L["ItemDeleteMode"]
	B.AddTooltip(bu, "ANCHOR_TOP")

	toggleButtons[4] = bu

	return bu
end

local function deleteButtonOnClick(self)
	if not deleteEnable then return end

	local texture, _, _, quality = GetContainerItemInfo(self.bagID, self.slotID)
	if IsControlKeyDown() and IsAltKeyDown() and texture and (quality < LE_ITEM_QUALITY_RARE) then
		PickupContainerItem(self.bagID, self.slotID)
		DeleteCursorItem()
	end
end

function module:ButtonOnClick(btn)
	if btn ~= "LeftButton" then return end
	splitOnClick(self)
	favouriteOnClick(self)
	customJunkOnClick(self)
	deleteButtonOnClick(self)
end

function module:UpdateAllBags()
	if self.Bags and self.Bags:IsShown() then
		self.Bags:BAG_UPDATE()
	end
end

function module:OpenBags()
	OpenAllBags(true)
end

function module:CloseBags()
	CloseAllBags()
end

function module:OnLogin()
	if not C.db["Bags"]["Enable"] then return end

	-- Settings
	local bagsScale = C.db["Bags"]["BagsScale"]
	local bagsWidth = C.db["Bags"]["BagsWidth"]
	local bankWidth = C.db["Bags"]["BankWidth"]
	local iconSize = C.db["Bags"]["IconSize"]
	local deleteButton = C.db["Bags"]["DeleteButton"]
	local showNewItem = C.db["Bags"]["ShowNewItem"]
	local hasPawn = IsAddOnLoaded("Pawn")

	-- Init
	local Backpack = cargBags:NewImplementation("NDui_Backpack")
	Backpack:RegisterBlizzard()
	Backpack:SetScale(bagsScale)
	Backpack:HookScript("OnShow", function() PlaySound(SOUNDKIT.IG_BACKPACK_OPEN) end)
	Backpack:HookScript("OnHide", function() PlaySound(SOUNDKIT.IG_BACKPACK_CLOSE) end)

	module.Bags = Backpack
	module.BagsType = {}
	module.BagsType[0] = 0	-- backpack
	module.BagsType[-1] = 0	-- bank

	local f = {}
	local filters = self:GetFilters()

	function Backpack:OnInit()
		local MyContainer = self:GetContainerClass()

		f.main = MyContainer:New("Main", {Columns = bagsWidth, Bags = "bags"})
		f.main:SetFilter(filters.onlyBags, true)
		f.main:SetPoint("BOTTOMRIGHT", -50, 320)

		f.junk = MyContainer:New("Junk", {Columns = bagsWidth, Parent = f.main})
		f.junk:SetFilter(filters.bagsJunk, true)

		f.bagFavourite = MyContainer:New("BagFavourite", {Columns = bagsWidth, Parent = f.main})
		f.bagFavourite:SetFilter(filters.bagFavourite, true)

		f.ammoItem = MyContainer:New("AmmoItem", {Columns = bagsWidth, Parent = f.main})
		f.ammoItem:SetFilter(filters.bagAmmo, true)

		f.equipment = MyContainer:New("Equipment", {Columns = bagsWidth, Parent = f.main})
		f.equipment:SetFilter(filters.bagEquipment, true)

		f.consumable = MyContainer:New("Consumable", {Columns = bagsWidth, Parent = f.main})
		f.consumable:SetFilter(filters.bagConsumable, true)

		f.bagGoods = MyContainer:New("BagGoods", {Columns = bagsWidth, Parent = f.main})
		f.bagGoods:SetFilter(filters.bagGoods, true)

		f.bagQuest = MyContainer:New("BagQuest", {Columns = bagsWidth, Parent = f.main})
		f.bagQuest:SetFilter(filters.bagQuest, true)

		local keyring = MyContainer:New("Keyring", {Columns = bagsWidth, Parent = f.main})
		keyring:SetFilter(filters.onlyKeyring, true)
		keyring:SetPoint("TOPRIGHT", f.main, "BOTTOMRIGHT", 0, -5)
		keyring:Hide()
		f.main.keyring = keyring

		f.bank = MyContainer:New("Bank", {Columns = bankWidth, Bags = "bank"})
		f.bank:SetFilter(filters.onlyBank, true)
		f.bank:SetPoint("BOTTOMRIGHT", f.main, "BOTTOMLEFT", -10, 0)
		f.bank:Hide()

		f.bankFavourite = MyContainer:New("BankFavourite", {Columns = bankWidth, Parent = f.bank})
		f.bankFavourite:SetFilter(filters.bankFavourite, true)

		f.bankAmmoItem = MyContainer:New("BankAmmoItem", {Columns = bankWidth, Parent = f.bank})
		f.bankAmmoItem:SetFilter(filters.bankAmmo, true)

		f.bankLegendary = MyContainer:New("BankLegendary", {Columns = bankWidth, Parent = f.bank})
		f.bankLegendary:SetFilter(filters.bankLegendary, true)

		f.bankEquipment = MyContainer:New("BankEquipment", {Columns = bankWidth, Parent = f.bank})
		f.bankEquipment:SetFilter(filters.bankEquipment, true)

		f.bankConsumable = MyContainer:New("BankConsumable", {Columns = bankWidth, Parent = f.bank})
		f.bankConsumable:SetFilter(filters.bankConsumable, true)

		f.bankGoods = MyContainer:New("BankGoods", {Columns = bankWidth, Parent = f.bank})
		f.bankGoods:SetFilter(filters.bankGoods, true)

		f.bankQuest = MyContainer:New("BankQuest", {Columns = bankWidth, Parent = f.bank})
		f.bankQuest:SetFilter(filters.bankQuest, true)

		module.BagGroup = {f.ammoItem, f.equipment, f.bagFavourite, f.bagGoods, f.consumable, f.bagQuest, f.junk}
		module.BankGroup = {f.bankAmmoItem, f.bankEquipment, f.bankLegendary, f.bankFavourite, f.bankGoods, f.bankConsumable, f.bankQuest}
	end

	local initBagType
	function Backpack:OnBankOpened()
		self:GetContainer("Bank"):Show()

		if not initBagType then
			module:UpdateAllBags() -- Initialize bagType
			initBagType = true
		end
	end

	function Backpack:OnBankClosed()
		self:GetContainer("Bank"):Hide()
	end

	local MyButton = Backpack:GetItemButtonClass()
	MyButton:Scaffold("Default")

	function MyButton:OnCreate()
		self:SetNormalTexture(nil)
		self:SetPushedTexture(nil)
		self:SetHighlightTexture(DB.bdTex)
		self:GetHighlightTexture():SetVertexColor(1, 1, 1, .25)
		self:GetHighlightTexture():SetInside()
		self:SetSize(iconSize, iconSize)

		self.Icon:SetInside()
		self.Icon:SetTexCoord(unpack(DB.TexCoord))
		self.Count:SetPoint("BOTTOMRIGHT", -1, 2)
		self.Count:SetFont(unpack(DB.Font))
		self.Cooldown:SetInside()

		B.CreateBD(self, .3)
		self:SetBackdropColor(.3, .3, .3, .3)

		local parentFrame = CreateFrame("Frame", nil, self)
		parentFrame:SetAllPoints()
		parentFrame:SetFrameLevel(5)

		self.Favourite = parentFrame:CreateTexture(nil, "ARTWORK")
		self.Favourite:SetAtlas("collections-icon-favorites")
		self.Favourite:SetSize(30, 30)
		self.Favourite:SetPoint("TOPLEFT", -12, 9)

		self.Quest = B.CreateFS(self, 30, "!", "system", "LEFT", 3, 0)
		self.iLvl = B.CreateFS(self, 12, "", false, "BOTTOMLEFT", 1, 2)

		if showNewItem then
			self.glowFrame = B.CreateGlowFrame(self, iconSize)
		end

		self:HookScript("OnClick", module.ButtonOnClick)
	end

	function MyButton:ItemOnEnter()
		if self.glowFrame then
			B.HideOverlayGlow(self.glowFrame)
			C_NewItems_RemoveNewItem(self.bagID, self.slotID)
		end
	end

	local bagTypeColor = {
		[-1] = {.67, .83, .45, .25},
		[0] = {.3, .3, .3, .3},
		[1] = {.53, .53, .93, .25},
		[2] = {0, .5, 0, .25},
		[3] = {0, .5, .8, .25},
	}

	local function isItemNeedsLevel(item)
		return item.link and item.level and item.rarity > 1 and (item.classID == LE_ITEM_CLASS_WEAPON or item.classID == LE_ITEM_CLASS_ARMOR)
	end

	local function UpdatePawnArrow(self, item)
		if not hasPawn then return end
		if not PawnIsContainerItemAnUpgrade then return end
		if self.UpgradeIcon then
			self.UpgradeIcon:SetShown(PawnIsContainerItemAnUpgrade(item.bagID, item.slotID))
		end
	end

	function MyButton:OnUpdate(item)
		if MerchantFrame:IsShown() then
			if item.isInSet then
				self:SetAlpha(.5)
			else
				self:SetAlpha(1)
			end
		end

		if self.JunkIcon then
			if (MerchantFrame:IsShown() or customJunkEnable) and (item.rarity == LE_ITEM_QUALITY_POOR or NDuiADB["CustomJunkList"][item.id]) and item.sellPrice > 0 then
				self.JunkIcon:Show()
			else
				self.JunkIcon:Hide()
			end
		end

		if C.db["Bags"]["FavouriteItems"][item.id] then
			self.Favourite:Show()
		else
			self.Favourite:Hide()
		end

		if C.db["Bags"]["BagsiLvl"] and isItemNeedsLevel(item) then
			--local level = B.GetItemLevel(item.link, item.bagID, item.slotID) or item.level
			local level = item.level
			if level < C.db["Bags"]["iLvlToShow"] then level = "" end
			local color = DB.QualityColors[item.rarity]
			self.iLvl:SetText(level)
			self.iLvl:SetTextColor(color.r, color.g, color.b)
		else
			self.iLvl:SetText("")
		end

		if self.glowFrame then
			if C_NewItems_IsNewItem(item.bagID, item.slotID) then
				B.ShowOverlayGlow(self.glowFrame)
			else
				B.HideOverlayGlow(self.glowFrame)
			end
		end

		if C.db["Bags"]["SpecialBagsColor"] then
			local bagType = module.BagsType[item.bagID]
			local color = bagTypeColor[bagType] or bagTypeColor[0]
			self:SetBackdropColor(unpack(color))
		else
			self:SetBackdropColor(.3, .3, .3, .3)
		end

		-- Hide empty tooltip
		if not GetContainerItemInfo(item.bagID, item.slotID) then
			GameTooltip:Hide()
		end

		-- Support Pawn
		UpdatePawnArrow(self, item)
	end

	function MyButton:OnUpdateQuest(item)
		self.Quest:Hide()

		if item.isQuestItem then
			self:SetBackdropBorderColor(.8, .8, 0)
			self.Quest:Show()
		elseif item.rarity and item.rarity > -1 then
			local color = DB.QualityColors[item.rarity]
			self:SetBackdropBorderColor(color.r, color.g, color.b)
		else
			self:SetBackdropBorderColor(0, 0, 0)
		end
	end

	local MyContainer = Backpack:GetContainerClass()
	function MyContainer:OnContentsChanged()
		self:SortButtons("bagSlot")

		local columns = self.Settings.Columns
		local offset = 38
		local spacing = 3
		local xOffset = 5
		local yOffset = -offset + xOffset
		local _, height = self:LayoutButtons("grid", columns, spacing, xOffset, yOffset)
		local width = columns * (iconSize+spacing)-spacing
		if self.freeSlot then
			if C.db["Bags"]["GatherEmpty"] then
				local numSlots = #self.buttons + 1
				local row = ceil(numSlots / columns)
				local col = numSlots % columns
				if col == 0 then col = columns end
				local xPos = (col-1) * (iconSize + spacing)
				local yPos = -1 * (row-1) * (iconSize + spacing)

				self.freeSlot:ClearAllPoints()
				self.freeSlot:SetPoint("TOPLEFT", self, "TOPLEFT", xPos+xOffset, yPos+yOffset)
				self.freeSlot:Show()

				if height < 0 then
					height = iconSize
				elseif col == 1 then
					height = height + iconSize + spacing
				end
			else
				self.freeSlot:Hide()
			end
		end
		self:SetSize(width + xOffset*2, height + offset)

		module:UpdateAnchors(f.main, module.BagGroup)
		module:UpdateAnchors(f.bank, module.BankGroup)
	end

	function MyContainer:OnCreate(name, settings)
		self.Settings = settings
		self:SetParent(settings.Parent or Backpack)
		self:SetFrameStrata("HIGH")
		self:SetClampedToScreen(true)
		B.SetBD(self)
		B.CreateMF(self, settings.Parent, true)

		local label
		if strmatch(name, "AmmoItem$") then
			label = DB.MyClass == "HUNTER" and INVTYPE_AMMO or SOUL_SHARDS
		elseif strmatch(name, "Equipment$") then
			label = BAG_FILTER_EQUIPMENT
		elseif name == "BankLegendary" then
			label = LOOT_JOURNAL_LEGENDARIES
		elseif strmatch(name, "Consumable$") then
			label = BAG_FILTER_CONSUMABLES
		elseif name == "Junk" then
			label = BAG_FILTER_JUNK
		elseif strmatch(name, "Favourite") then
			label = PREFERENCES
		elseif name == "Keyring" then
			label = KEYRING
		elseif strmatch(name, "Goods") then
			label = AUCTION_CATEGORY_TRADE_GOODS
		elseif strmatch(name, "Quest") then
			label = QUESTS_LABEL
		end
		if label then B.CreateFS(self, 14, label, true, "TOPLEFT", 5, -8) return end

		module.CreateInfoFrame(self)

		local buttons = {}
		buttons[1] = module.CreateCloseButton(self)
		if name == "Main" then
			module.CreateBagBar(self, settings, NUM_BAG_SLOTS)
			buttons[2] = module.CreateRestoreButton(self, f)
			buttons[3] = module.CreateBagToggle(self)
			buttons[4] = module.CreateKeyToggle(self)
			buttons[5] = module.CreateSortButton(self, name)
			buttons[6] = module.CreateSplitButton(self)
			buttons[7] = module.CreateFavouriteButton(self)
			buttons[8] = module.CreateJunkButton(self)
			if deleteButton then buttons[9] = module.CreateDeleteButton(self) end
		elseif name == "Bank" then
			module.CreateBagBar(self, settings, NUM_BANKBAGSLOTS)
			buttons[2] = module.CreateBagToggle(self)
			buttons[3] = module.CreateSortButton(self, name)
		end

		for i = 1, #buttons do
			local bu = buttons[i]
			if not bu then break end
			if i == 1 then
				bu:SetPoint("TOPRIGHT", -5, -3)
			else
				bu:SetPoint("RIGHT", buttons[i-1], "LEFT", -3, 0)
			end
		end

		self:HookScript("OnShow", B.RestoreMF)

		self.iconSize = iconSize
		module.CreateFreeSlots(self)
	end

	local BagButton = Backpack:GetClass("BagButton", true, "BagButton")
	function BagButton:OnCreate()
		self:SetNormalTexture(nil)
		self:SetPushedTexture(nil)
		self:SetHighlightTexture(DB.bdTex)
		self:GetHighlightTexture():SetVertexColor(1, 1, 1, .25)
		self:GetHighlightTexture():SetInside()

		self:SetSize(iconSize, iconSize)
		B.CreateBD(self, .25)
		self.Icon:SetAllPoints()
		self.Icon:SetTexCoord(unpack(DB.TexCoord))
	end

	function BagButton:OnUpdate()
		local id = GetInventoryItemID("player", (self.GetInventorySlot and self:GetInventorySlot()) or self.invID)
		if not id then return end
		local _, _, quality, _, _, _, _, _, _, _, _, classID, subClassID = GetItemInfo(id)
		if not quality or quality == 1 then quality = 0 end
		local color = DB.QualityColors[quality]
		if not self.hidden and not self.notBought then
			self:SetBackdropBorderColor(color.r, color.g, color.b)
		else
			self:SetBackdropBorderColor(0, 0, 0)
		end

		if classID == LE_ITEM_CLASS_CONTAINER then
			module.BagsType[self.bagID] = subClassID or 0
		elseif classID == LE_ITEM_CLASS_QUIVER then
			module.BagsType[self.bagID] = -1
		else
			module.BagsType[self.bagID] = 0
		end
	end

	-- Sort order
	SetSortBagsRightToLeft(not C.db["Bags"]["ReverseSort"])
	SetInsertItemsLeftToRight(false)

	-- Init
	ToggleAllBags()
	ToggleAllBags()
	module.initComplete = true

	B:RegisterEvent("TRADE_SHOW", module.OpenBags)
	--B:RegisterEvent("TRADE_CLOSED", module.CloseBags)
	B:RegisterEvent("AUCTION_HOUSE_SHOW", module.OpenBags)
	B:RegisterEvent("AUCTION_HOUSE_CLOSED", module.CloseBags)

	-- Fixes
	BankFrame.GetRight = function() return f.bank:GetRight() end
	BankFrameItemButton_Update = B.Dummy

	-- Shift key alert
	local function onUpdate(self, elapsed)
		if IsShiftKeyDown() then
			self.elapsed = (self.elapsed or 0) + elapsed
			if self.elapsed > 5 then
				UIErrorsFrame:AddMessage(DB.InfoColor..L["StupidShiftKey"])
				self.elapsed = 0
			end
		end
	end
	local shiftUpdater = CreateFrame("Frame", nil, f.main)
	shiftUpdater:SetScript("OnUpdate", onUpdate)
end