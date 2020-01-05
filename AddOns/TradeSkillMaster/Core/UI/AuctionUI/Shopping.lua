-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                http://www.curse.com/addons/wow/tradeskill-master               --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

local _, TSM = ...
local Shopping = TSM.UI.AuctionUI:NewPackage("Shopping")
local ItemClass = TSM.Include("Data.ItemClass")
local L = TSM.Include("Locale").GetTable()
local FSM = TSM.Include("Util.FSM")
local Event = TSM.Include("Util.Event")
local TempTable = TSM.Include("Util.TempTable")
local Table = TSM.Include("Util.Table")
local Money = TSM.Include("Util.Money")
local Log = TSM.Include("Util.Log")
local Math = TSM.Include("Util.Math")
local ItemString = TSM.Include("Util.ItemString")
local Threading = TSM.Include("Service.Threading")
local ItemInfo = TSM.Include("Service.ItemInfo")
local CustomPrice = TSM.Include("Service.CustomPrice")
local BagTracking = TSM.Include("Service.BagTracking")
local private = {
	singleItemSearchType = "normal",
	fsm = nil,
	rarityList = nil,
	frame = nil,
	hasLastScan = false,
	contentPath = "selection",
	selectedGroups = {},
	groupSearch = "",
	itemInfo = {
		itemString = nil,
		seller = nil,
		stackSize = nil,
		displayedBid = nil,
		buyout = nil,
	},
	itemString = nil,
	postQuantity = nil,
	postStack = nil,
	postTimeStr = nil,
	perItem = true,
	updateCallbacks = {},
	itemLocation = ItemLocation.CreateEmpty(),
}
local SINGLE_ITEM_SEARCH_TYPES = {
	normal = "|cffffd839" .. L["Normal"] .. "|r",
	crafting = "|cffffd839" .. L["Crafting"] .. "|r"
}
local SINGLE_ITEM_SEARCH_TYPES_ORDER = { "normal", "crafting" }
local MAX_ITEM_LEVEL = 1000
local DEFAULT_DIVIDED_CONTAINER_CONTEXT = {
	leftWidth = 272,
}
local DEFAULT_TAB_GROUP_CONTEXT = {
	pathIndex = 1
}
local PLAYER_NAME = UnitName("player")
local POST_TIME_STRS = {
	TSM.IsWowClassic() and L["2 hr"] or L["12 hr"],
	TSM.IsWowClassic() and L["8 hr"] or L["24 hr"],
	TSM.IsWowClassic() and L["24 hr"] or L["48 hr"],
}
local function NoOp()
	-- do nothing - what did you expect?
end
-- TODO: this should eventually go in the saved variables
private.dividedContainerContext = {}



-- ============================================================================
-- Module Functions
-- ============================================================================

function Shopping.OnInitialize()
	private.postTimeStr = POST_TIME_STRS[2]
	TSM.UI.AuctionUI.RegisterTopLevelPage(L["Shopping"], "iconPack.24x24/Shopping", private.GetShoppingFrame, private.OnItemLinked)
	private.FSMCreate()
end

function Shopping.StartGatheringSearch(items, stateCallback, buyCallback, mode)
	assert(Shopping.IsVisible())
	private.frame:SetPath("selection")
	private.StartGatheringSearchHelper(private.frame, items, stateCallback, buyCallback, mode)
end

function Shopping.StartItemSearch(item)
	private.OnItemLinked(ItemInfo.GetName(item), item)
end

function Shopping.IsVisible()
	return TSM.UI.AuctionUI.IsPageOpen(L["Shopping"])
end

function Shopping.RegisterUpdateCallback(callback)
	tinsert(private.updateCallbacks, callback)
end



-- ============================================================================
-- Shopping UI
-- ============================================================================

function private.GetShoppingFrame()
	TSM.UI.AnalyticsRecordPathChange("auction", "shopping")
	if not private.hasLastScan then
		private.contentPath = "selection"
	end
	local frame = TSMAPI_FOUR.UI.NewElement("ViewContainer", "shopping")
		:SetNavCallback(private.GetShoppingContentFrame)
		:AddPath("selection")
		:AddPath("scan")
		:SetPath(private.contentPath)
		:SetScript("OnHide", private.FrameOnHide)
	private.frame = frame
	for _, callback in ipairs(private.updateCallbacks) do
		callback()
	end
	return frame
end

function private.GetShoppingContentFrame(viewContainer, path)
	private.contentPath = path
	if path == "selection" then
		return private.GetSelectionFrame()
	elseif path == "scan" then
		return private.GetScanFrame()
	else
		error("Unexpected path: "..tostring(path))
	end
end

function private.GetSelectionFrame()
	TSM.UI.AnalyticsRecordPathChange("auction", "shopping", "selection")
	local frame = TSMAPI_FOUR.UI.NewElement("DividedContainer", "selection")
		:SetStyle("background", "#272727")
		:SetContextTable(private.dividedContainerContext, DEFAULT_DIVIDED_CONTAINER_CONTEXT)
		:SetMinWidth(250, 250)
		:SetLeftChild(TSMAPI_FOUR.UI.NewElement("Frame", "groupSelection")
			:SetLayout("VERTICAL")
			:SetStyle("padding", { top = 21 })
			:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "title")
				:SetLayout("HORIZONTAL")
				:SetStyle("height", 44)
				:SetStyle("padding", { top = 12, bottom = 12, left = 8, right = 8 })
				:AddChild(TSMAPI_FOUR.UI.NewElement("SearchInput", "search")
					:SetText(private.groupSearch)
					:SetHintText(L["Search Groups"])
					:SetScript("OnTextChanged", private.GroupSearchOnTextChanged)
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Button", "moreBtn")
					:SetStyle("width", 18)
					:SetStyle("height", 18)
					:SetStyle("margin.left", 8)
					:SetStyle("backgroundTexturePack", "iconPack.18x18/More")
					:SetScript("OnClick", private.MoreBtnOnClick)
				)
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Texture", "line")
				:SetStyle("height", 2)
				:SetStyle("color", "#9d9d9d")
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("ApplicationGroupTree", "groupTree")
				:SetGroupListFunc(private.GroupTreeGetList)
				:SetContextTable(TSM.db.profile.internalData.shoppingGroupTreeContext)
				:SetSearchString(private.groupSearch)
				:SetScript("OnGroupSelectionChanged", private.GroupTreeOnGroupSelectionChanged)
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Texture", "line")
				:SetStyle("height", 2)
				:SetStyle("color", "#9d9d9d")
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("ActionButton", "scanBtn")
				:SetStyle("height", 26)
				:SetStyle("margin", 12)
				:SetText(L["RUN SHOPPING SCAN"])
				:SetDisabled(true)
				:SetScript("OnClick", private.ScanButtonOnClick)
			)
		)
		:SetRightChild(TSMAPI_FOUR.UI.NewElement("ViewContainer", "content")
			:SetNavCallback(private.GetSelectionContent)
			:AddPath("search", true)
			:AddPath("advanced")
		)
		:SetScript("OnUpdate", private.SelectionFrameOnUpdate)

	return frame
end

function private.SelectionFrameOnUpdate(frame)
	frame:SetScript("OnUpdate", nil)
	frame:GetBaseElement():SetBottomPadding(nil)
	frame:GetElement("groupSelection.scanBtn"):SetDisabled(frame:GetElement("groupSelection.groupTree"):IsSelectionCleared(true)):Draw()
end

function private.GetSelectionContent(viewContainer, path)
	if path == "search" then
		return private.GetSelectionSearchFrame()
	elseif path == "advanced" then
		return private.GetAdvancedFrame()
	else
		error("Unexpected path: "..tostring(path))
	end
end

function private.GetSelectionSearchFrame()
	return TSMAPI_FOUR.UI.NewElement("ScrollFrame", "search")
		:SetStyle("padding", { top = 43, left = 8, right = 8, bottom = 8 })
		:AddChild(TSMAPI_FOUR.UI.NewElement("TabGroup", "buttons")
			:SetStyle("height", 152)
			:SetStyle("margin", { left = -8, right = -8 })
			:SetNavCallback(private.GetSearchesElement)
			:SetContextTable(TSM.db.profile.internalData.shoppingTabGroupContext, DEFAULT_TAB_GROUP_CONTEXT)
			:AddPath(L["Recent Searches"])
			:AddPath(L["Favorite Searches"])
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("Texture", "line")
			:SetStyle("height", 2)
			:SetStyle("margin", { left = -8, right = -8 })
			:SetStyle("color", "#9d9d9d")
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "itemHeader")
			:SetLayout("HORIZONTAL")
			:SetStyle("height", 22)
			:SetStyle("margin", { top = 16, bottom = 4 })
			:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "text")
				:SetStyle("font", TSM.UI.Fonts.MontserratBold)
				:SetStyle("fontHeight", 16)
				:SetStyle("autoWidth", true)
				:SetText(L["Filter Shopping"])
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Dropdown", "dropdown")
				:SetStyle("width", 80)
				:SetStyle("height", 14)
				:SetStyle("margin.left", 8)
				:SetStyle("background", "#00000000")
				:SetStyle("border", "#00000000")
				:SetStyle("font", TSM.UI.Fonts.MontserratBold)
				:SetStyle("fontHeight", 11)
				:SetStyle("openFont", TSM.UI.Fonts.MontserratBold)
				:SetStyle("openFontHeight", 11)
				:SetDictionaryItems(SINGLE_ITEM_SEARCH_TYPES, SINGLE_ITEM_SEARCH_TYPES[private.singleItemSearchType], SINGLE_ITEM_SEARCH_TYPES_ORDER)
				:SetSettingInfo(private, "singleItemSearchType")
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Spacer", "spacer"))
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "text")
			:SetStyle("height", 14)
			:SetStyle("fontHeight", 11)
			:SetText(L["Use the field below to search the auction house by filter"])
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("Input", "filterInput")
			:SetStyle("height", 26)
			:SetStyle("margin", { top = 16, bottom = 16 })
			:SetStyle("background", "#525252")
			:SetStyle("border", "#9d9d9d")
			:SetStyle("borderSize", 2)
			:SetStyle("fontHeight", 11)
			:SetStyle("textColor", "#e2e2e2")
			:SetStyle("hintJustifyH", "LEFT")
			:SetStyle("hintTextColor", "#e2e2e2")
			:SetHintText(L["Enter Filter"])
			:SetScript("OnEnterPressed", private.FilterSearchInputOnEnterPressed)
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "advanced")
			:SetLayout("HORIZONTAL")
			:SetStyle("height", 18)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Button", "textBtn")
				:SetStyle("font", TSM.UI.Fonts.MontserratBold)
				:SetStyle("fontHeight", 11)
				:SetStyle("autoWidth", true)
				:SetText(L["Advanced Item Search"])
				:SetScript("OnClick", private.AdvancedButtonOnClick)
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Button", "iconBtn")
				:SetStyle("width", 18)
				:SetStyle("height", 18)
				:SetStyle("backgroundTexturePack", "iconPack.18x18/Chevron/Collapsed")
				:SetScript("OnClick", private.AdvancedButtonOnClick)
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Spacer", "spacer"))
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "text")
			:SetStyle("height", 22)
			:SetStyle("margin.top", 27)
			:SetStyle("font", TSM.UI.Fonts.MontserratBold)
			:SetStyle("fontHeight", 16)
			:SetText(L["Other Shopping Searches"])
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "buttonsLine1")
			:SetLayout("HORIZONTAL")
			:SetStyle("height", 26)
			:SetStyle("margin", { top = 16, bottom = 16 })
			:AddChild(TSMAPI_FOUR.UI.NewElement("ActionButton", "dealsBtn")
				:SetStyle("margin.right", 16)
				:SetText(L["GREAT DEALS SEARCH"])
				:SetDisabled(not TSM.Shopping.GreatDealsSearch.GetFilter())
				:SetScript("OnClick", private.DealsButtonOnClick)
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("ActionButton", "vendorBtn")
				:SetText(L["VENDOR SEARCH"])
				:SetScript("OnClick", private.VendorButtonOnClick)
			)
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "buttonsLine1")
			:SetLayout("HORIZONTAL")
			:SetStyle("height", 26)
			:AddChild(TSMAPI_FOUR.UI.NewElement("ActionButton", "disenchantBtn")
				:SetStyle("margin.right", 16)
				:SetText(L["DISENCHANT SEARCH"])
				:SetScript("OnClick", private.DisenchantButtonOnClick)
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Spacer", "spacer"))
		)
end

function private.GetAdvancedFrame()
	if not private.rarityList then
		private.rarityList = {}
		for i = 1, 7 do
			tinsert(private.rarityList, _G["ITEM_QUALITY"..i.."_DESC"])
		end
	end
	return TSMAPI_FOUR.UI.NewElement("Frame", "search")
		:SetLayout("VERTICAL")
		:AddChild(TSMAPI_FOUR.UI.NewElement("ScrollFrame", "search")
			:SetStyle("padding", { top = 18 })
			:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "header")
				:SetLayout("HORIZONTAL")
				:SetStyle("height", 45)
				:SetStyle("margin", { left = 7, top = 3 })
				:SetStyle("background", "#272727")
				:AddChild(TSMAPI_FOUR.UI.NewElement("Button", "backIcon")
					:SetStyle("width", 18)
					:SetStyle("backgroundTexturePack", "iconPack.14x14/SideArrow")
					:SetStyle("backgroundTextureRotation", 180)
					:SetScript("OnClick", private.AdvancedBackButtonOnClick)
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Button", "backBtn")
					:SetStyle("width", 40)
					:SetText(strupper(BACK))
					:SetStyle("fontHeight", 13)
					:SetScript("OnClick", private.AdvancedBackButtonOnClick)
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "title")
					:SetStyle("margin.right", 100)
					:SetStyle("fontHeight", 16)
					:SetStyle("justifyH", "CENTER")
					:SetText(L["Advanced Item Search"])
				)
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Texture", "line")
				:SetStyle("height", 2)
				:SetStyle("color", "#9d9d9d")
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "body")
				:SetLayout("VERTICAL")
				:SetStyle("padding", { left = 10, right = 10 })
				:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "label")
					:SetText(L["FILTER BY KEYWORD"])
					:SetStyle("height", 18)
					:SetStyle("font", TSM.UI.Fonts.bold)
					:SetStyle("fontHeight", 11)
					:SetStyle("margin.top", 15)
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Input", "filterInput")
					:SetStyle("height", 26)
					:SetStyle("margin.bottom", 10)
					:SetStyle("background", "#404040")
					:SetStyle("border", "#585858")
					:SetStyle("borderSize", 2)
					:SetStyle("fontHeight", 11)
					:SetStyle("textColor", "#e2e2e2")
					:SetStyle("hintJustifyH", "LEFT")
					:SetStyle("hintTextColor", "#e2e2e2")
					:SetHintText(L["Enter Keyword"])
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "classAndSubClassLabels")
					:SetLayout("HORIZONTAL")
					:SetStyle("height", 18)
					:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "classLabel")
						:SetText(L["ITEM CLASS"])
						:SetStyle("font", TSM.UI.Fonts.bold)
						:SetStyle("fontHeight", 11)
					)
					:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "subClassLabel")
						:SetStyle("margin.left", 20)
						:SetText(L["ITEM SUBCLASS"])
						:SetStyle("font", TSM.UI.Fonts.bold)
						:SetStyle("fontHeight", 11)
					)
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "classAndSubClass")
					:SetLayout("HORIZONTAL")
					:SetStyle("height", 18)
					:SetStyle("margin.bottom", 10)
					:AddChild(TSMAPI_FOUR.UI.NewElement("Dropdown", "classDropdown")
						:SetStyle("height", 20)
						:SetStyle("margin.right", 20)
						:SetItems(ItemClass.GetClasses())
						:SetScript("OnSelectionChanged", private.ClassDropdownOnSelectionChanged)
						:SetHintText(L["All Item Classes"])
					)
					:AddChild(TSMAPI_FOUR.UI.NewElement("Dropdown", "subClassDropdown")
						:SetStyle("height", 20)
						:SetDisabled(true)
						:SetItems(ItemClass.GetClasses())
						:SetHintText(L["All Subclasses"])
					)
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "frame")
					:SetLayout("HORIZONTAL")
					:SetStyle("height", 30)
					:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "label")
						:SetText(L["REQUIRED LEVEL RANGE"])
						:SetStyle("font", TSM.UI.Fonts.bold)
						:SetStyle("fontHeight", 11)
					)
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "level")
					:SetLayout("HORIZONTAL")
					:SetStyle("height", 18)
					:SetStyle("margin.bottom", 10)
					:AddChild(TSMAPI_FOUR.UI.NewElement("Slider", "slider")
						:SetRange(0, MAX_PLAYER_LEVEL)
					)
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "frame")
					:SetLayout("HORIZONTAL")
					:SetStyle("height", 30)
					:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "label")
						:SetText(L["ITEM LEVEL RANGE"])
						:SetStyle("font", TSM.UI.Fonts.bold)
						:SetStyle("fontHeight", 11)
					)
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "itemLevel")
					:SetLayout("HORIZONTAL")
					:SetStyle("height", 18)
					:SetStyle("margin.bottom", 10)
					:AddChild(TSMAPI_FOUR.UI.NewElement("Slider", "slider")
						:SetRange(0, MAX_ITEM_LEVEL)
					)
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "quantityLabel")
					:SetLayout("HORIZONTAL")
					:SetStyle("height", 26)
					:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "label")
						:SetText(L["MAXIMUM QUANTITY TO BUY:"])
						:SetStyle("font", TSM.UI.Fonts.bold)
						:SetStyle("fontHeight", 11)
					)
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "quantity")
					:SetLayout("HORIZONTAL")
					:SetStyle("height", 18)
					:SetStyle("margin.bottom", 10)
					:AddChild(TSMAPI_FOUR.UI.NewElement("InputNumeric", "input")
						:SetStyle("backgroundTexturePacks", "uiFrames.ActiveInputField")
						:SetStyle("width", 64)
						:SetStyle("height", 24)
						:SetMaxNumber(2000)
						:SetStyle("justifyH", "CENTER")
					)
					:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "label")
						:SetText(L["(minimum 0 - maximum 2000)"])
						:SetStyle("margin.left", 10)
						:SetStyle("fontHeight", 14)
					)
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "rarityLabel")
					:SetLayout("HORIZONTAL")
					:SetStyle("height", 26)
					:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "label")
						:SetText(L["MINIMUM RARITY"])
						:SetStyle("font", TSM.UI.Fonts.bold)
						:SetStyle("fontHeight", 11)
					)
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "rarity")
					:SetLayout("HORIZONTAL")
					:SetStyle("height", 18)
					:SetStyle("margin.bottom", 10)
					:AddChild(TSMAPI_FOUR.UI.NewElement("Dropdown", "dropdown")
						:SetStyle("height", 20)
						:SetItems(private.rarityList)
					)
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "usableFrame")
					:SetLayout("HORIZONTAL")
					:SetStyle("height", 18)
					:SetStyle("margin.bottom", 10)
					:AddChild(TSMAPI_FOUR.UI.NewElement("Checkbox", "usableCheckbox")
						:SetStyle("height", 24)
						:SetCheckboxPosition("LEFT")
						:SetText(L["Search Usable Items Only?"])
						:SetStyle("fontHeight", 12)
						:SetStyle("checkboxSpacing", 1)
					)
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "exactFrame")
					:SetLayout("HORIZONTAL")
					:SetStyle("height", 25)
					:SetStyle("margin.bottom", 12)
					:AddChild(TSMAPI_FOUR.UI.NewElement("Checkbox", "exactCheckbox")
						:SetStyle("height", 24)
						:SetCheckboxPosition("LEFT")
						:SetText(L["Exact Match Only?"])
						:SetStyle("fontHeight", 12)
						:SetStyle("checkboxSpacing", 1)
					)
				)
			)
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("Texture", "line")
			:SetStyle("height", 2)
			:SetStyle("color", "#9d9d9d")
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "buttons")
			:SetLayout("HORIZONTAL")
			:SetStyle("height", 50)
			:SetStyle("background", "#272727")
			:SetStyle("padding", { left = 10, right = 10})
			:AddChild(TSMAPI_FOUR.UI.NewElement("ActionButton", "startBtn")
				:SetStyle("height", 26)
				:SetText(L["RUN ADVANCED ITEM SEARCH"])
				:SetScript("OnClick", private.AdvancedStartOnClick)
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Button", "resetBtn")
				:SetStyle("height", 24)
				:SetStyle("width", 100)
				:SetStyle("fontHeight", 11)
				:SetText(L["Reset Filters"])
				:SetScript("OnClick", private.ResetButtonOnClick)
			)
		)
end

function private.GetSearchesElement(self, button)
	if button == L["Recent Searches"] then
		return TSMAPI_FOUR.UI.NewElement("SearchList", "list")
			:SetQuery(TSM.Shopping.SavedSearches.CreateRecentSearchesQuery())
			:SetEditButtonHidden(true)
			:SetScript("OnFavoriteChanged", private.SearchListOnFavoriteChanged)
			:SetScript("OnDelete", private.SearchListOnDelete)
			:SetScript("OnRowClick", private.SearchListOnRowClick)
	elseif button == L["Favorite Searches"] then
		return TSMAPI_FOUR.UI.NewElement("SearchList", "list")
			:SetQuery(TSM.Shopping.SavedSearches.CreateFavoriteSearchesQuery())
			:SetScript("OnFavoriteChanged", private.SearchListOnFavoriteChanged)
			:SetScript("OnNameChanged", private.SearchListOnNameChanged)
			:SetScript("OnDelete", private.SearchListOnDelete)
			:SetScript("OnRowClick", private.SearchListOnRowClick)
	else
		error("Unexpected button: "..tostring(button))
	end
end

function private.GetScanFrame()
	TSM.UI.AnalyticsRecordPathChange("auction", "shopping", "scan")
	return TSMAPI_FOUR.UI.NewElement("Frame", "scan")
		:SetLayout("VERTICAL")
		:SetStyle("background", "#272727")
		:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "backFrame")
			:SetLayout("HORIZONTAL")
			:SetStyle("margin", { left = 8, top = 6, bottom = 4 })
			:SetStyle("height", 18)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Button", "backIcon")
				:SetStyle("width", 18)
				:SetStyle("backgroundTexturePack", "iconPack.18x18/SideArrow")
				:SetStyle("backgroundTextureRotation", 180)
				:SetScript("OnClick", private.ScanBackButtonOnClick)
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Spacer"))
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "searchText")
			:SetStyle("margin.left", 8)
			:SetStyle("margin.bottom", 2)
			:SetStyle("margin.top", 4)
			:SetStyle("height", 13)
			:SetStyle("font", TSM.UI.Fonts.MontserratBold)
			:SetStyle("fontHeight", 10)
			:SetText(L["CURRENT SEARCH"])
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "searchFrame")
			:SetLayout("HORIZONTAL")
			:SetStyle("height", 26)
			:SetStyle("margin.left", 8)
			:SetStyle("margin.right", 8)
			:SetStyle("margin.bottom", 8)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Input", "filterInput")
				:SetStyle("height", 26)
				:SetStyle("background", "#404040")
				:SetStyle("border", "#585858")
				:SetStyle("borderSize", 1)
				:SetStyle("fontHeight", 11)
				:SetStyle("textColor", "#e2e2e2")
				:SetStyle("hintJustifyH", "LEFT")
				:SetStyle("hintTextColor", "#e2e2e2")
				:SetHintText(L["Enter Filter"])
				:SetScript("OnEnterPressed", private.ScanFilterInputOnEnterPressed)
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("ActionButton", "rescanBtn")
				:SetStyle("width", 150)
				:SetStyle("margin.left", 8)
				:SetText(L["RESCAN"])
				:SetScript("OnClick", private.RescanBtnOnClick)
			)
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("Texture", "line")
			:SetStyle("height", 2)
			:SetStyle("color", "#9d9d9d")
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("ShoppingScrollingTable", "auctions")
			:SetScript("OnSelectionChanged", private.AuctionsOnSelectionChanged)
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "bottom")
			:SetLayout("HORIZONTAL")
			:SetStyle("height", 38)
			:SetStyle("padding.bottom", -2)
			:SetStyle("padding.top", 6)
			:SetStyle("background", "#363636")
			:AddChild(TSMAPI_FOUR.UI.NewElement("ProgressBar", "progressBar")
				:SetStyle("margin.right", 8)
				:SetStyle("height", 28)
				:SetProgress(0)
				:SetProgressIconHidden(false)
				:SetText(L["Starting Scan..."])
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("ActionButton", "postBtn")
				:SetStyle("width", 107)
				:SetStyle("height", 26)
				:SetStyle("margin.right", 8)
				:SetStyle("iconTexturePack", "iconPack.14x14/Post")
				:SetText(L["POST"])
				:SetDisabled(true)
				:SetScript("OnClick", private.AuctionsOnPostButtonClick)
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Texture", "line")
				:SetStyle("width", 3)
				:SetStyle("height", 23)
				:SetStyle("margin.right", 8)
				:SetStyle("color", "#9d9d9d")
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("ActionButton", "bidBtn")
				:SetStyle("width", 107)
				:SetStyle("height", 26)
				:SetStyle("margin.right", 8)
				:SetStyle("iconTexturePack", "iconPack.14x14/Bid")
				:SetText(strupper(BID))
				:SetDisabled(true)
				:SetScript("OnClick", private.BidBtnOnClick)
			)
			:AddChild(TSMAPI_FOUR.UI.NewNamedElement("ActionButton", "buyoutBtn", "TSMShoppingBuyoutBtn")
				:SetStyle("width", 107)
				:SetStyle("height", 26)
				:SetStyle("margin.right", 8)
				:SetStyle("iconTexturePack", "iconPack.14x14/Post")
				:SetText(strupper(BUYOUT))
				:SetDisabled(true)
				:DisableClickCooldown(true)
				:SetScript("OnClick", private.BuyoutBtnOnClick)
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("ActionButton", "stopBtn")
				:SetStyle("width", 107)
				:SetStyle("height", 26)
				:SetStyle("iconTexturePack", "iconPack.14x14/Stop")
				:SetText(L["STOP"])
				:SetDisabled(true)
				:SetScript("OnClick", private.StopButtonOnClick)
			)
		)
		:SetScript("OnUpdate", private.ScanFrameOnUpdate)
		:SetScript("OnHide", private.ScanFrameOnHide)
end

function private.BidBtnOnClick(button)
	private.fsm:ProcessEvent("EV_BID_CLICKED")
end

function private.BuyoutBtnOnClick(button)
	private.fsm:ProcessEvent("EV_BUYOUT_CLICKED")
end

function private.PostDialogShow(baseFrame, record)
	baseFrame:ShowDialogFrame(TSMAPI_FOUR.UI.NewElement("Frame", "frame")
		:SetLayout("VERTICAL")
		:SetStyle("width", 264)
		:SetStyle("height", 252)
		:SetStyle("anchors", { { "CENTER" } })
		:SetStyle("background", "#2e2e2e")
		:SetStyle("border", "#e2e2e2")
		:SetStyle("borderSize", 1)
		:SetStyle("padding", 8)
		:SetMouseEnabled(true)
		:AddChild(TSMAPI_FOUR.UI.NewElement("ViewContainer", "view")
			:SetNavCallback(private.GetViewContentFrame)
			:AddPath("posting")
			:AddPath("selection")
			:SetPath("posting")
			:SetContext(record)
		)
		:SetScript("OnHide", private.PostDialogOnHide)
	)
end

function private.PostDialogOnHide(frame)
	private.itemString = nil
end

function private.GetViewContentFrame(viewContainer, path)
	if path == "posting" then
		return private.GetPostingFrame()
	elseif path == "selection" then
		return private.GetPostSelectionFrame()
	else
		error("Unexpected path: "..tostring(path))
	end
end

function private.GetPostingFrame()
	local frame = TSMAPI_FOUR.UI.NewElement("Frame", "posting")
		:SetLayout("VERTICAL")
		:SetMouseEnabled(true)
		:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "header")
			:SetLayout("HORIZONTAL")
			:SetStyle("margin.bottom", 8)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "title")
				:SetStyle("width", 124)
				:SetStyle("height", 13)
				:SetStyle("font", TSM.UI.Fonts.MontserratMedium)
				:SetStyle("fontHeight", 10)
				:SetStyle("justifyH", "LEFT")
				:SetStyle("textColor", "#e2e2e2")
				:SetText(L["CUSTOM POST"])
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Button", "closeBtn")
				:SetStyle("width", 18)
				:SetStyle("height", 18)
				:SetStyle("margin", { top = -4, left = 110, right = -4 })
				:SetStyle("backgroundTexturePack", "iconPack.18x18/Close/Default")
				:SetScript("OnClick", private.PostDialogCloseBtnOnClick)
			)
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "item")
			:SetLayout("HORIZONTAL")
			:SetStyle("margin.top", -6)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Button", "icon")
				:SetStyle("width", 28)
				:SetStyle("height", 28)
				:SetStyle("margin", { top = 2, right = 8, bottom = 7 })
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "name")
				:SetStyle("height", 40)
				:SetStyle("margin.top", -5)
				:SetStyle("font", TSM.UI.Fonts.FRIZQT)
				:SetStyle("fontHeight", 16)
				:SetStyle("justifyH", "LEFT")
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Button", "editBtn")
				:SetStyle("width", 14)
				:SetStyle("height", 14)
				:SetStyle("margin", { top = -5, left = 4 })
				:SetStyle("backgroundTexturePack", "iconPack.14x14/Edit")
				:SetScript("OnClick", private.ItemBtnOnClick)
			)
		)
	if TSM.IsWow83() then
		frame:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "quantity")
				:SetLayout("HORIZONTAL")
				:SetStyle("height", 20)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "desc")
					:SetStyle("font", TSM.UI.Fonts.MontserratRegular)
					:SetStyle("fontHeight", 12)
					:SetStyle("textColor", "#e2e2e2")
					:SetText(L["Quantity"] .. ":")
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("InputNumeric", "stackSize")
					:SetStyle("width", 100)
					:SetStyle("font", TSM.UI.Fonts.RobotoMedium)
					:SetStyle("fontHeight", 12)
					:SetStyle("height", 18)
					:SetStyle("justifyH", "RIGHT")
					:SetMinNumber(1)
					:SetMaxNumber(9999)
					:SetMaxLetters(4)
					:SetScript("OnTextChanged", private.QuantityStackInputOnTextChanged)
					:SetScript("OnTabPressed", private.QuantityStackInputOnTabPressed)
				)
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "maxBtns")
				:SetLayout("HORIZONTAL")
				:SetStyle("height", 20)
				:SetStyle("margin.bottom", 8)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Spacer", "spacer1"))
				:AddChild(TSMAPI_FOUR.UI.NewElement("ActionButton", "stackSizeBtn")
					:SetStyle("width", 100)
					:SetStyle("height", 15)
					:SetStyle("margin.left", 4)
					:SetStyle("font", TSM.UI.Fonts.MontserratMedium)
					:SetStyle("fontHeight", 12)
					:SetText(L["MAX"])
					:SetScript("OnClick", private.MaxStackSizeBtnOnClick)
				)
			)
	else
		frame:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "quantity")
				:SetLayout("HORIZONTAL")
				:SetStyle("height", 20)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "desc")
					:SetStyle("width", 110)
					:SetStyle("font", TSM.UI.Fonts.MontserratRegular)
					:SetStyle("fontHeight", 12)
					:SetStyle("textColor", "#e2e2e2")
					:SetText(L["Stack / Quantity"] .. ":")
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("InputNumeric", "num")
					:SetStyle("height", 18)
					:SetStyle("margin.left", 8)
					:SetStyle("font", TSM.UI.Fonts.RobotoMedium)
					:SetStyle("fontHeight", 12)
					:SetStyle("justifyH", "RIGHT")
					:SetMinNumber(1)
					:SetMaxNumber(9999)
					:SetMaxLetters(4)
					:SetText("1")
					:SetScript("OnTextChanged", private.QuantityNumInputOnTextChanged)
					:SetScript("OnTabPressed", private.QuantityNumInputOnTabPressed)
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "ofText")
					:SetStyle("width", 20)
					:SetStyle("margin", 4)
					:SetStyle("font", TSM.UI.Fonts.RobotoMedium)
					:SetStyle("fontHeight", 12)
					:SetStyle("justifyH", "CENTER")
					:SetText(L["of"])
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("InputNumeric", "stackSize")
					:SetStyle("font", TSM.UI.Fonts.RobotoMedium)
					:SetStyle("fontHeight", 12)
					:SetStyle("height", 18)
					:SetStyle("justifyH", "RIGHT")
					:SetMinNumber(1)
					:SetMaxNumber(9999)
					:SetMaxLetters(4)
					:SetScript("OnTextChanged", private.QuantityStackInputOnTextChanged)
					:SetScript("OnTabPressed", private.QuantityStackInputOnTabPressed)
				)
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "maxBtns")
				:SetLayout("HORIZONTAL")
				:SetStyle("height", 20)
				:SetStyle("margin.bottom", 8)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Spacer", "spacer1")
					:SetStyle("width", 118)
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("ActionButton", "numBtn")
					:SetStyle("height", 15)
					:SetStyle("margin.left", 4)
					:SetStyle("margin.right", 4)
					:SetStyle("font", TSM.UI.Fonts.MontserratMedium)
					:SetStyle("fontHeight", 12)
					:SetText(L["MAX"])
					:SetScript("OnClick", private.MaxNumBtnOnClick)
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("Spacer", "spacer2")
					:SetStyle("width", 20)
					:SetStyle("margin", 4)
				)
				:AddChild(TSMAPI_FOUR.UI.NewElement("ActionButton", "stackSizeBtn")
					:SetStyle("height", 15)
					:SetStyle("margin.left", 4)
					:SetStyle("margin.right", 4)
					:SetStyle("font", TSM.UI.Fonts.MontserratMedium)
					:SetStyle("fontHeight", 12)
					:SetText(L["MAX"])
					:SetScript("OnClick", private.MaxStackSizeBtnOnClick)
				)
			)
	end
	frame:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "duration")
			:SetLayout("HORIZONTAL")
			:SetStyle("height", 20)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "desc")
				:SetStyle("width", 110)
				:SetStyle("font", TSM.UI.Fonts.MontserratRegular)
				:SetStyle("fontHeight", 12)
				:SetStyle("textColor", "#e2e2e2")
				:SetText(L["Auction Duration"] .. ":")
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Toggle", "toggle")
				:SetStyle("height", 16)
				:SetStyle("margin.left", 8)
				:SetStyle("font", TSM.UI.Fonts.RobotoMedium)
				:SetStyle("border", "#e2e2e2")
				:SetStyle("textColor", "#e2e2e2")
				:SetStyle("selectedBackground", "#e2e2e2")
				:SetStyle("fontHeight", 12)
				:AddOption(POST_TIME_STRS[1])
				:AddOption(POST_TIME_STRS[2])
				:AddOption(POST_TIME_STRS[3])
				:SetOption(private.postTimeStr, true)
				:SetScript("OnValueChanged", private.DurationOnValueChanged)
			)
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("Spacer", "spacer"))
	if TSM.IsWow83() then
		frame:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "stack")
				:SetStyle("width", 49)
				:SetStyle("height", 14)
				:SetStyle("font", TSM.UI.Fonts.MontserratMedium)
				:SetStyle("margin", { left = 199, bottom = 4 })
				:SetStyle("fontHeight", 10)
				:SetStyle("justifyH", "RIGHT")
				:SetStyle("textColor", "#ffd839")
				:SetText(L["Per Unit"])
			)
	else
		frame:AddChild(TSMAPI_FOUR.UI.NewElement("Button", "stack")
				:SetStyle("width", 49)
				:SetStyle("height", 14)
				:SetStyle("font", TSM.UI.Fonts.MontserratMedium)
				:SetStyle("margin", { left = 199, bottom = 4 })
				:SetStyle("fontHeight", 10)
				:SetStyle("justifyH", "RIGHT")
				:SetStyle("textColor", "#ffd839")
				:SetText(L["Per Unit"])
				:SetScript("OnClick", private.StackBtnOnClick)
			)
	end
		frame:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "bid")
			:SetLayout("HORIZONTAL")
			:SetStyle("height", 20)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "desc")
				:SetStyle("font", TSM.UI.Fonts.MontserratRegular)
				:SetStyle("fontHeight", 12)
				:SetStyle("textColor", "#e2e2e2")
				:SetStyle("autoWidth", true)
				:SetText(L["Bid Price"] .. ":")
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("EditableText", "text")
				:SetStyle("font", TSM.UI.Fonts.RobotoMedium)
				:SetStyle("fontHeight", 12)
				:SetStyle("justifyH", "RIGHT")
				:SetContext("bid")
				:SetScript("OnValueChanged", private.BidTextOnValueChanged)
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Button", "editBtn")
				:SetStyle("width", 12)
				:SetStyle("height", 12)
				:SetStyle("margin.left", 4)
				:SetStyle("backgroundTexturePack", "iconPack.12x12/Edit")
				:SetScript("OnClick", private.BidEditBtnOnClick)
			)
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "buyout")
			:SetLayout("HORIZONTAL")
			:SetStyle("height", 20)
			:SetStyle("margin.bottom", 6)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "desc")
				:SetStyle("font", TSM.UI.Fonts.MontserratRegular)
				:SetStyle("fontHeight", 12)
				:SetStyle("textColor", "#e2e2e2")
				:SetStyle("autoWidth", true)
				:SetText(L["Buyout Price"] .. ":")
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("EditableText", "text")
				:SetStyle("font", TSM.UI.Fonts.RobotoMedium)
				:SetStyle("fontHeight", 12)
				:SetStyle("justifyH", "RIGHT")
				:SetContext("buyout")
				:SetScript("OnValueChanged", private.BuyoutTextOnValueChanged)
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Button", "editBtn")
				:SetStyle("width", 12)
				:SetStyle("height", 12)
				:SetStyle("margin.left", 4)
				:SetStyle("backgroundTexturePack", "iconPack.12x12/Edit")
				:SetScript("OnClick", private.BuyoutEditBtnOnClick)
			)
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "deposit")
			:SetLayout("HORIZONTAL")
			:SetStyle("height", 20)
			:SetStyle("margin.bottom", 4)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "desc")
				:SetStyle("font", TSM.UI.Fonts.MontserratRegular)
				:SetStyle("fontHeight", 12)
				:SetStyle("textColor", "#e2e2e2")
				:SetStyle("autoWidth", true)
				:SetText(L["Deposit Price"] .. ":")
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "text")
				:SetStyle("font", TSM.UI.Fonts.RobotoMedium)
				:SetStyle("fontHeight", 12)
				:SetStyle("justifyH", "RIGHT")
			)
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("ActionButton", "confirmBtn")
			:SetStyle("margin.top", 0)
			:SetStyle("height", 248)
			:SetStyle("height", 26)
			:SetText(L["POST"])
			:SetScript("OnClick", private.PostButtonOnClick)
		)
		:SetScript("OnUpdate", private.PostingFrameOnUpdate)

	return frame
end

function private.GetPostSelectionFrame()
	local query = BagTracking.CreateQueryBagsItemAuctionable(ItemString.GetBase(private.itemString))
	local frame = TSMAPI_FOUR.UI.NewElement("Frame", "selection")
		:SetLayout("VERTICAL")
		:SetMouseEnabled(true)
		:AddChild(TSMAPI_FOUR.UI.NewElement("Frame", "header")
			:SetLayout("HORIZONTAL")
			:SetStyle("margin.bottom", 6)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Text", "title")
				:SetStyle("width", 124)
				:SetStyle("height", 13)
				:SetStyle("font", TSM.UI.Fonts.MontserratMedium)
				:SetStyle("fontHeight", 10)
				:SetStyle("justifyH", "LEFT")
				:SetStyle("textColor", "#e2e2e2")
				:SetText(L["ITEM SELECTION"])
			)
			:AddChild(TSMAPI_FOUR.UI.NewElement("Button", "closeBtn")
				:SetStyle("width", 18)
				:SetStyle("height", 18)
				:SetStyle("margin", { top = -4, left = 110, right = -4, bottom = 1 })
				:SetStyle("backgroundTexturePack", "iconPack.18x18/Close/Default")
				:SetScript("OnClick", private.PostDialogCloseBtnOnClick)
			)
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("QueryScrollingTable", "items")
			:SetStyle("lineColor", "#000000")
			:SetStyle("hideHeader", true)
			:SetStyle("headerBackground", "#00000000")
			:SetStyle("background", "#000000")
			:SetStyle("altBackground", "#1b1b1b")
			:SetStyle("headerFont", TSM.UI.Fonts.MontserratRegular)
			:SetStyle("headerFontHeight", 12)
			:GetScrollingTableInfo()
				:NewColumn("item")
					:SetTitles(L["Item"])
					:SetFont(TSM.UI.Fonts.FRIZQT)
					:SetFontHeight(12)
					:SetJustifyH("LEFT")
					:SetIconSize(14)
					:SetTextInfo("itemString", TSM.UI.GetColoredItemName)
					:SetIconInfo("itemString", ItemInfo.GetTexture)
					:SetTooltipInfo("itemString")
					:Commit()
				:Commit()
			:SetQuery(query)
			:SetAutoReleaseQuery(true)
			:SetScript("OnRowClick", private.ItemQueryOnRowClick)
		)
		:AddChild(TSMAPI_FOUR.UI.NewElement("ActionButton", "backBtn")
			:SetStyle("margin.top", 9)
			:SetStyle("height", 248)
			:SetStyle("height", 26)
			:SetText(L["BACK"])
			:SetScript("OnClick", private.ViewBackButtonOnClick)
		)

	return frame
end

function private.PostingFrameOnUpdate(frame)
	frame:SetScript("OnUpdate", nil)

	local record = frame:GetParentElement():GetContext()
	if not private.itemString then
		assert(record.itemString)
		local foundItem = false
		local backupItemString = nil
		local query = BagTracking.CreateQueryBagsAuctionable()
			:OrderBy("slotId", true)
			:Select("itemString")
		for _, itemString in query:Iterator() do
			if itemString == record.itemString then
				foundItem = true
			elseif not backupItemString and ItemString.GetBase(itemString) == ItemString.GetBase(record.itemString) then
				backupItemString = itemString
			end
		end
		query:Release()
		private.itemString = foundItem and record.itemString or backupItemString

		if not private.itemString then
			frame:GetBaseElement():HideDialog()
			Log.PrintfUser(L["Failed to post %sx%d as the item no longer exists in your bags."], ItemInfo.GetLink(record.itemString), record.stackSize)
			private.frame:GetElement("scan.bottom.postBtn")
				:SetDisabled(true)
				:Draw()
			return
		end
	end
	local undercut = TSMAPI_FOUR.PlayerInfo.IsPlayer(record.seller, true, true, true) and 0 or 1
	local bid = floor(record.displayedBid / record.stackSize) - undercut
	if TSM.IsWow83() then
		bid = Math.Round(bid, COPPER_PER_SILVER)
	end
	if bid <= 0 then
		bid = 1
	elseif bid > MAXIMUM_BID_PRICE then
		bid = MAXIMUM_BID_PRICE
	end
	local buyout = floor(record.buyout / record.stackSize) - undercut
	if TSM.IsWow83() then
		buyout = Math.Round(buyout, COPPER_PER_SILVER)
	end
	if buyout < 0 then
		buyout = 0
	elseif buyout > MAXIMUM_BID_PRICE then
		buyout = MAXIMUM_BID_PRICE
	end
	local cagedPet = strfind(private.itemString, "^p")
	private.perItem = true

	frame:GetElement("item.icon")
		:SetStyle("backgroundTexture", ItemInfo.GetTexture(private.itemString))
		:SetTooltip(private.itemString)
	frame:GetElement("item.name")
		:SetText(TSM.UI.GetColoredItemName(private.itemString))
	if TSM.IsWow83() then
		if ItemInfo.IsCommodity(private.itemString) then
			frame:GetElement("bid"):Hide()
		else
			frame:GetElement("bid"):Show()
		end
	else
		frame:GetElement("quantity.num")
			:SetDisabled(cagedPet)
		frame:GetElement("maxBtns.numBtn")
			:SetDisabled(cagedPet)
	end
	local maxPostStack = private.GetMaxPostStack(private.itemString)
	frame:GetElement("quantity.stackSize")
		:SetDisabled(cagedPet)
		:SetText(min(record.stackSize, maxPostStack))
		:SetMaxNumber(maxPostStack)
	frame:GetElement("maxBtns.stackSizeBtn")
		:SetDisabled(cagedPet)
	frame:GetElement("bid.text")
		:SetText(Money.ToString(bid, nil, "OPT_83_NO_COPPER"))
	frame:GetElement("buyout.text")
		:SetText(Money.ToString(buyout, nil, "OPT_83_NO_COPPER"))
	frame:GetElement("confirmBtn")
		:SetContext(private.itemString)

	frame:Draw()

	private.UpdateDepositCost(frame)
end

function private.ItemQueryOnRowClick(scrollingtable, row)
	private.itemString = row:GetField("itemString")
	scrollingtable:GetElement("__parent.__parent"):SetPath("posting", true)
end

function private.ViewBackButtonOnClick(button)
	button:GetElement("__parent.__parent"):SetPath("posting", true)
end



-- ============================================================================
-- Local Script Handlers
-- ============================================================================

function private.OnItemLinked(name, itemLink)
	local itemString = ItemString.Get(itemLink)
	local baseItemString = ItemString.GetBase(itemString)
	local baseName = ItemInfo.GetName(baseItemString)
	private.frame:SetPath("selection")
	if itemString == baseItemString and private.singleItemSearchType ~= "crafting" then
		baseName = baseName.."/exact"
	end
	private.itemInfo.itemString = itemString
	private.itemInfo.seller = PLAYER_NAME
	private.itemInfo.stackSize = 1
	private.itemInfo.displayedBid = CustomPrice.GetValue("first(dbmarket, 100g)", itemString)
	private.itemInfo.buyout = CustomPrice.GetValue("first(dbmarket, 100g)", itemString)
	private.frame:GetBaseElement():HideDialog()
	private.StartFilterSearchHelper(private.frame, baseName, nil, private.itemInfo)
	return true
end

function private.GroupSearchOnTextChanged(input)
	private.groupSearch = strlower(strtrim(input:GetText()))
	input:GetElement("__parent.__parent.groupTree")
		:SetSearchString(private.groupSearch)
		:Draw()
end

local function MoreDialogRowIterator(_, prevIndex)
	if prevIndex == nil then
		return 1, L["Select All Groups"], private.SelectAllBtnOnClick
	elseif prevIndex == 1 then
		return 2, L["Deselect All Groups"], private.DeselectAllBtnOnClick
	elseif prevIndex == 2 then
		return 3, L["Expand All Groups"], private.ExpandAllBtnOnClick
	elseif prevIndex == 3 then
		return 4, L["Collapse All Groups"], private.CollapseAllBtnOnClick
	end
end
function private.MoreBtnOnClick(button)
	button:GetBaseElement():ShowMoreButtonDialog(button, MoreDialogRowIterator)
end

function private.SelectAllBtnOnClick(button)
	local baseFrame = button:GetBaseElement()
	baseFrame:GetElement("content.shopping.selection.groupSelection.groupTree"):SelectAll()
	baseFrame:HideDialog()
end

function private.DeselectAllBtnOnClick(button)
	local baseFrame = button:GetBaseElement()
	baseFrame:GetElement("content.shopping.selection.groupSelection.groupTree"):DeselectAll()
	baseFrame:HideDialog()
end

function private.ExpandAllBtnOnClick(button)
	local baseFrame = button:GetBaseElement()
	baseFrame:GetElement("content.shopping.selection.groupSelection.groupTree"):ExpandAll()
	baseFrame:HideDialog()
end

function private.CollapseAllBtnOnClick(button)
	local baseFrame = button:GetBaseElement()
	baseFrame:GetElement("content.shopping.selection.groupSelection.groupTree"):CollapseAll()
	baseFrame:HideDialog()
end

function private.GroupTreeOnGroupSelectionChanged(groupTree, selectedGroups)
	local scanBtn = groupTree:GetElement("__parent.scanBtn")
	scanBtn:SetDisabled(not next(selectedGroups))
	scanBtn:Draw()
end

function private.FrameOnHide(frame)
	assert(frame == private.frame)
	private.frame = nil
	for _, callback in ipairs(private.updateCallbacks) do
		callback()
	end
end

function private.GroupTreeGetList(groups, headerNameLookup)
	TSM.UI.ApplicationGroupTreeGetGroupList(groups, headerNameLookup, "Shopping")
end

function private.ScanButtonOnClick(button)
	if not TSM.UI.AuctionUI.StartingScan(L["Shopping"]) then
		return
	end
	wipe(private.selectedGroups)
	for _, groupPath in button:GetElement("__parent.groupTree"):SelectedGroupsIterator() do
		if groupPath ~= "" and not strmatch(groupPath, "^`") then
			tinsert(private.selectedGroups, groupPath)
		end
	end

	button:GetParentElement():GetParentElement():GetParentElement():SetPath("scan", true)
	local threadId, marketValueFunc = TSM.Shopping.GroupSearch.GetScanContext()
	private.fsm:ProcessEvent("EV_START_SCAN", threadId, marketValueFunc, NoOp, NoOp, "", private.selectedGroups)
end

function private.SearchListOnFavoriteChanged(_, dbRow, isFavorite)
	TSM.Shopping.SavedSearches.SetSearchIsFavorite(dbRow, isFavorite)
end

function private.SearchListOnNameChanged(_, dbRow, newName)
	TSM.Shopping.SavedSearches.RenameSearch(dbRow, newName)
end

function private.SearchListOnDelete(_, dbRow)
	TSM.Shopping.SavedSearches.DeleteSearch(dbRow)
end

function private.SearchListOnRowClick(searchList, dbRow)
	local viewContainer = searchList:GetParentElement():GetParentElement():GetParentElement():GetParentElement():GetParentElement()
	private.StartFilterSearchHelper(viewContainer, dbRow:GetField("filter"))
end

function private.AdvancedButtonOnClick(button)
	button:GetParentElement():GetParentElement():GetParentElement():SetPath("advanced", true)
end

function private.AdvancedBackButtonOnClick(button)
	button:GetParentElement():GetParentElement():GetParentElement():GetParentElement():SetPath("search", true)
end

function private.ClassDropdownOnSelectionChanged(dropdown, selection)
	local subClassDropdown = dropdown:GetElement("__parent.subClassDropdown")
	if selection then
		subClassDropdown:SetItems(ItemClass.GetSubClasses(selection))
		subClassDropdown:SetDisabled(false)
		subClassDropdown:SetSelection(nil)
			:Draw()
	else
		subClassDropdown:SetDisabled(true)
		subClassDropdown:SetSelection(nil)
			:Draw()
	end
end

function private.ResetButtonOnClick(button)
	local searchFrame = button:GetElement("__parent.__parent.search.body")
	searchFrame:GetElement("filterInput"):SetText("")
	searchFrame:GetElement("level.slider"):SetValue(0, MAX_PLAYER_LEVEL)
	searchFrame:GetElement("itemLevel.slider"):SetValue(0, MAX_ITEM_LEVEL)
	searchFrame:GetElement("classAndSubClass.classDropdown"):SetSelection(nil)
	searchFrame:GetElement("classAndSubClass.subClassDropdown"):SetSelection(nil)
	searchFrame:GetElement("rarity.dropdown"):SetSelection(nil)
	searchFrame:GetElement("quantity.input"):SetText("")
	searchFrame:GetElement("usableFrame.usableCheckbox"):SetChecked(false)
	searchFrame:GetElement("exactFrame.exactCheckbox"):SetChecked(false)
	searchFrame:Draw()
end

function private.AdvancedStartOnClick(button)
	local searchFrame = button:GetElement("__parent.__parent.search.body")
	local filterParts = TempTable.Acquire()

	tinsert(filterParts, strtrim(searchFrame:GetElement("filterInput"):GetText()))

	local levelMin, levelMax = searchFrame:GetElement("level.slider"):GetValue()
	if levelMin ~= 0 or levelMax ~= MAX_PLAYER_LEVEL then
		tinsert(filterParts, levelMin)
		tinsert(filterParts, levelMax)
	end

	local itemLevelMin, itemLevelMax = searchFrame:GetElement("itemLevel.slider"):GetValue()
	if itemLevelMin ~= 0 or itemLevelMax ~= MAX_ITEM_LEVEL then
		tinsert(filterParts, "i"..itemLevelMin)
		tinsert(filterParts, "i"..itemLevelMax)
	end

	local class = searchFrame:GetElement("classAndSubClass.classDropdown"):GetSelection()
	if class then
		tinsert(filterParts, class)
	end

	local subClass = searchFrame:GetElement("classAndSubClass.subClassDropdown"):GetSelection()
	if subClass then
		tinsert(filterParts, subClass)
	end

	local rarity = searchFrame:GetElement("rarity.dropdown"):GetSelection()
	if rarity then
		tinsert(filterParts, rarity)
	end

	local quantity = tonumber(searchFrame:GetElement("quantity.input"):GetText())
	if quantity then
		tinsert(filterParts, "x"..quantity)
	end

	if searchFrame:GetElement("usableFrame.usableCheckbox"):IsChecked() then
		tinsert(filterParts, "usable")
	end

	if searchFrame:GetElement("exactFrame.exactCheckbox"):IsChecked() then
		tinsert(filterParts, "exact")
	end

	local filter = table.concat(filterParts, "/")
	TempTable.Release(filterParts)
	local viewContainer = searchFrame:GetParentElement():GetParentElement():GetParentElement():GetParentElement():GetParentElement()
	private.StartFilterSearchHelper(viewContainer, filter)
end

function private.FilterSearchInputOnEnterPressed(input)
	local filter = strtrim(input:GetText())
	if filter == "" then
		return
	end
	local viewContainer = input:GetParentElement():GetParentElement():GetParentElement():GetParentElement()
	private.StartFilterSearchHelper(viewContainer, filter)
end

function private.FilterSearchButtonOnClick(button)
	private.FilterSearchInputOnEnterPressed(button:GetElement("__parent.filterInput"))
end

function private.StartFilterSearchHelper(viewContainer, filter, isGreatDeals, itemInfo)
	if not TSM.UI.AuctionUI.StartingScan(L["Shopping"]) then
		return
	end
	local originalFilter = filter
	local mode = (private.singleItemSearchType == "crafting" and not isGreatDeals) and "CRAFTING" or "NORMAL"
	filter = TSM.Shopping.FilterSearch.PrepareFilter(strtrim(filter), mode, TSM.db.global.shoppingOptions.pctSource)
	if not filter or filter == "" then
		viewContainer:SetPath("scan", true)
		Log.PrintUser(L["Invalid search filter"]..": "..originalFilter)
		return
	end
	viewContainer:SetPath("scan", true)
	local threadId, marketValueFunc = TSM.Shopping.FilterSearch.GetScanContext(isGreatDeals)
	private.fsm:ProcessEvent("EV_START_SCAN", threadId, marketValueFunc, NoOp, NoOp, isGreatDeals and L["Great Deals Search"] or filter, filter, itemInfo)
end

function private.StartGatheringSearchHelper(viewContainer, items, stateCallback, buyCallback, mode)
	if not TSM.UI.AuctionUI.StartingScan(L["Shopping"]) then
		return
	end
	local filterList = TempTable.Acquire()
	for itemString, quantity in pairs(items) do
		tinsert(filterList, itemString.."/x"..quantity)
	end
	local filter = table.concat(filterList, ";")
	TempTable.Release(filterList)
	filter = TSM.Shopping.FilterSearch.PrepareFilter(filter, mode, "matprice")
	assert(filter and filter ~= "")
	viewContainer:SetPath("scan", true)
	local threadId, marketValueFunc = TSM.Shopping.FilterSearch.GetScanContext(true)
	private.fsm:ProcessEvent("EV_START_SCAN", threadId, marketValueFunc, buyCallback, stateCallback, L["Gathering Search"], filter)
end

function private.DealsButtonOnClick(button)
	local viewContainer = button:GetParentElement():GetParentElement():GetParentElement():GetParentElement():GetParentElement()
	private.StartFilterSearchHelper(viewContainer, TSM.Shopping.GreatDealsSearch.GetFilter(), true)
end

function private.VendorButtonOnClick(button)
	if not TSM.UI.AuctionUI.StartingScan(L["Shopping"]) then
		return
	end
	button:GetParentElement():GetParentElement():GetParentElement():GetParentElement():GetParentElement():SetPath("scan", true)
	local threadId, marketValueFunc = TSM.Shopping.VendorSearch.GetScanContext()
	private.fsm:ProcessEvent("EV_START_SCAN", threadId, marketValueFunc, NoOp, NoOp, L["Vendor Search"])
end

function private.DisenchantButtonOnClick(button)
	if not TSM.UI.AuctionUI.StartingScan(L["Shopping"]) then
		return
	end
	button:GetParentElement():GetParentElement():GetParentElement():GetParentElement():GetParentElement():SetPath("scan", true)
	local threadId, marketValueFunc = TSM.Shopping.DisenchantSearch.GetScanContext()
	private.fsm:ProcessEvent("EV_START_SCAN", threadId, marketValueFunc, NoOp, NoOp, L["Disenchant Search"])
end

function private.ScanBackButtonOnClick(button)
	button:GetParentElement():GetParentElement():GetParentElement():SetPath("selection", true)
	private.fsm:ProcessEvent("EV_SCAN_BACK_BUTTON_CLICKED")
end

function private.AuctionsOnSelectionChanged()
	private.fsm:ProcessEvent("EV_AUCTION_SELECTION_CHANGED")
end

function private.AuctionsOnPostButtonClick()
	private.fsm:ProcessEvent("EV_POST_BUTTON_CLICK")
end

function private.StopButtonOnClick(button)
	private.fsm:ProcessEvent("EV_STOP_SCAN")
end

function private.ScanFrameOnUpdate(frame)
	frame:SetScript("OnUpdate", nil)
	frame:GetBaseElement():SetBottomPadding(38)
	private.fsm:ProcessEvent("EV_SCAN_FRAME_SHOWN", frame)
end

function private.ScanFrameOnHide(frame)
	private.fsm:ProcessEvent("EV_SCAN_FRAME_HIDDEN")
end

function private.BidEditBtnOnClick(button)
	local frame = button:GetParentElement():GetParentElement()
	local buyoutText = frame:GetElement("buyout.text")
	buyoutText:SetEditing(false)
	button:GetElement("__parent.text"):SetEditing(true)
end

function private.BuyoutEditBtnOnClick(button)
	local frame = button:GetParentElement():GetParentElement()
	local bidText = frame:GetElement("bid.text")
	bidText:SetEditing(false)
	button:GetElement("__parent.text"):SetEditing(true)
end

function private.StackBtnOnClick(button)
	local frame = button:GetParentElement()
	local record = frame:GetParentElement():GetContext()
	local undercut = record.seller == PLAYER_NAME and 0 or 1
	local stackSize = record.stackSize
	local bidText = frame:GetElement("bid.text")
	local buyoutText = frame:GetElement("buyout.text")
	-- always update buyout first
	if private.perItem then
		private.perItem = nil
		local bid = Money.FromString(bidText:GetText())
		bid = bid and (bid * stackSize + undercut) or record.displayedBid
		local buyout = Money.FromString(buyoutText:GetText())
		buyout = buyout and (buyout * stackSize + undercut) or record.buyout
		local stackSizeEdit = frame:GetElement("quantity.stackSize"):GetText()
		stackSizeEdit = tonumber(stackSizeEdit)
		if stackSize == stackSizeEdit then
			private.BuyoutTextOnValueChanged(buyoutText, Money.ToString(buyout - undercut, nil, "OPT_83_NO_COPPER"), true)
			private.BidTextOnValueChanged(bidText, Money.ToString(bid - undercut, nil, "OPT_83_NO_COPPER"), true)
		else
			private.BuyoutTextOnValueChanged(buyoutText, Money.FromString(buyoutText:GetText()) > 0 and Money.ToString(floor(record.buyout / stackSize) * stackSizeEdit, nil, "OPT_83_NO_COPPER") or 0, true)
			private.BidTextOnValueChanged(bidText, Money.ToString(floor(record.displayedBid / stackSize) * stackSizeEdit, nil, "OPT_83_NO_COPPER"), true)
		end
		button:SetText(L["Per Stack"])
	else
		private.perItem = true
		local bid = Money.FromString(bidText:GetText())
		bid = bid and (bid + undercut * stackSize) or record.displayedBid
		local buyout = Money.FromString(buyoutText:GetText())
		buyout = buyout and (buyout + undercut * stackSize) or record.buyout
		local stackSizeEdit = frame:GetElement("quantity.stackSize"):GetText()
		stackSizeEdit = tonumber(stackSizeEdit)
		if stackSize == stackSizeEdit then
			private.BuyoutTextOnValueChanged(buyoutText, Money.FromString(buyoutText:GetText()) > 0 and Money.ToString(floor(buyout / stackSizeEdit) - undercut, nil, "OPT_83_NO_COPPER") or 0, true)
			private.BidTextOnValueChanged(bidText, Money.ToString(floor(bid / stackSizeEdit) - undercut, nil, "OPT_83_NO_COPPER"), true)
		else
			private.BuyoutTextOnValueChanged(buyoutText, Money.FromString(buyoutText:GetText()) > 0 and Money.ToString(floor(record.buyout / stackSize), nil, "OPT_83_NO_COPPER") or 0, true)
			private.BidTextOnValueChanged(bidText, Money.ToString(floor(record.displayedBid / stackSize), nil, "OPT_83_NO_COPPER"), true)
		end
		button:SetText(L["Per Unit"])
	end
	button:Draw()
end

function private.BidTextOnValueChanged(text, value, skipUpdate)
	value = Money.FromString(value)
	if value then
		value = min(value, MAXIMUM_BID_PRICE)
		local frame = text:GetParentElement():GetParentElement()
		local buyout = Money.FromString(frame:GetElement("buyout.text"):GetText())
		if private.perItem and buyout > 0 and value > buyout then
			text:SetText(Money.ToString(buyout, nil, "OPT_83_NO_COPPER"))
		elseif not private.perItem and buyout > 0 and value > buyout then
			text:SetText(Money.ToString(buyout, nil, "OPT_83_NO_COPPER"))
		else
			text:SetText(Money.ToString(value, nil, "OPT_83_NO_COPPER"))
		end
	end
	text:Draw()

	if not skipUpdate then
		private.UpdateDepositCost(text:GetParentElement():GetParentElement())
	end
end

function private.BuyoutTextOnValueChanged(text, value, skipUpdate)
	value = Money.FromString(value)
	if value then
		if TSM.IsWow83() then
			value = Math.Round(value, COPPER_PER_SILVER)
		end
		value = min(value, MAXIMUM_BID_PRICE)
		local frame = text:GetParentElement():GetParentElement()
		local bidText = frame:GetElement("bid.text")
		local bid = Money.FromString(bidText:GetText())
		if value > 0 and bid > value then
			private.BidTextOnValueChanged(bidText, Money.ToString(value, nil, "OPT_83_NO_COPPER"), skipUpdate)
		end
		text:SetText(Money.ToString(value, nil, "OPT_83_NO_COPPER"))
	end
	text:Draw()

	if not skipUpdate then
		private.UpdateDepositCost(text:GetParentElement():GetParentElement())
	end
end

function private.ItemBtnOnClick(button)
	button:GetElement("__parent.__parent.__parent"):SetPath("selection", true)
end

function private.QuantityNumInputOnTextChanged(input)
	local text = input:GetText()
	local textNum = tonumber(text)
	if not textNum then
		return
	end
	if textNum < 1 then
		return
	end
	if textNum == private.postQuantity then
		return
	end
	private.postQuantity = textNum

	input:SetText(text)

	private.UpdateDepositCost(input:GetParentElement():GetParentElement())
end

function private.QuantityNumInputOnTabPressed(input)
	local frame = input:GetParentElement()
	local stackInput = frame:GetElement("stackSize")
	stackInput:SetFocused(true)
	stackInput:HighlightText()
end

function private.QuantityStackInputOnTextChanged(input)
	local text = input:GetText()
	local textNum = tonumber(text)
	if not textNum then
		return
	end
	if textNum < 1 then
		return
	end
	if textNum == private.postStack then
		return
	end
	private.postStack = textNum

	input:SetText(text)

	private.UpdateDepositCost(input:GetParentElement():GetParentElement())

	if private.perItem then
		return
	end

	local frame = input:GetParentElement():GetParentElement()
	local record = frame:GetParentElement():GetContext()
	local undercut = record.seller == PLAYER_NAME and 0 or 1
	local stackSize = record.stackSize
	local bidText = frame:GetElement("bid.text")
	local buyoutText = frame:GetElement("buyout.text")
	local bid = record.displayedBid
	local buyout = record.buyout
	local stackSizeEdit = frame:GetElement("quantity.stackSize"):GetText()
	stackSizeEdit = tonumber(stackSizeEdit)
	-- always update buyout first
	if stackSize == stackSizeEdit then
		private.BuyoutTextOnValueChanged(buyoutText, Money.ToString(buyout - undercut, nil, "OPT_83_NO_COPPER"))
		private.BidTextOnValueChanged(bidText, Money.ToString(bid - undercut, nil, "OPT_83_NO_COPPER"))
	else
		private.BuyoutTextOnValueChanged(buyoutText, Money.ToString(floor(buyout / stackSize) * stackSizeEdit, nil, "OPT_83_NO_COPPER"))
		private.BidTextOnValueChanged(bidText, Money.ToString(floor(bid / stackSize) * stackSizeEdit, nil, "OPT_83_NO_COPPER"))
	end
end

function private.QuantityStackInputOnTabPressed(input)
	local frame = input:GetParentElement()
	local numInput = frame:GetElement("num")
	numInput:SetFocused(true)
	numInput:HighlightText()
end

function private.UpdateDepositCost(frame)
	local itemString = frame:GetElement("confirmBtn"):GetContext()
	if not itemString then
		return
	end

	local postBag, postSlot = BagTracking.CreateQueryBagsAuctionable()
		:OrderBy("slotId", true)
		:Select("bag", "slot")
		:Equal("itemString", itemString)
		:GetFirstResultAndRelease()
	if not postBag or not postSlot then
		frame:GetElement("deposit.text")
			:SetText(Money.ToString(0, nil, "OPT_83_NO_COPPER"))
			:Draw()
		frame:GetElement("confirmBtn")
			:SetDisabled(true)
			:Draw()
		return
	end

	private.postTimeStr = frame:GetElement("duration.toggle"):GetValue()
	local postTime = Table.GetDistinctKey(POST_TIME_STRS, private.postTimeStr)
	local stackSize = tonumber(frame:GetElement("quantity.stackSize"):GetText())
	local depositCost = nil
	if TSM.IsWow83() then
		private.itemLocation:Clear()
		private.itemLocation:SetBagAndSlot(postBag, postSlot)
		local commodityStatus = C_AuctionHouse.GetItemCommodityStatus(private.itemLocation)
		if commodityStatus == Enum.ItemCommodityStatus.Item then
			depositCost = C_AuctionHouse.CalculateItemDeposit(private.itemLocation, postTime, stackSize)
		elseif commodityStatus == Enum.ItemCommodityStatus.Commodity then
			depositCost = C_AuctionHouse.CalculateCommodityDeposit(ItemString.ToId(itemString), postTime, stackSize)
		else
			error("Unknown commodity status: "..tostring(itemString))
		end
	else
		local bid = Money.FromString(frame:GetElement("bid.text"):GetText())
		local buyout = Money.FromString(frame:GetElement("buyout.text"):GetText())
		if private.perItem then
			bid = bid * stackSize
			buyout = buyout * stackSize
		end
		local num = tonumber(frame:GetElement("quantity.num"):GetText())
		ClearCursor()
		PickupContainerItem(postBag, postSlot)
		ClickAuctionSellItemButton(AuctionsItemButton, "LeftButton")
		ClearCursor()
		depositCost = GetAuctionDeposit(postTime, bid, buyout, stackSize, num)
		ClearCursor()
		ClickAuctionSellItemButton(AuctionsItemButton, "LeftButton")
		ClearCursor()
	end

	frame:GetElement("deposit.text")
		:SetText(Money.ToString(depositCost))
		:Draw()
	frame:GetElement("confirmBtn")
		:SetDisabled(false)
		:Draw()
end

function private.PostButtonOnClick(button)
	local frame = button:GetParentElement()
	local stackSize = frame:GetElement("quantity.stackSize"):GetText()
	stackSize = tonumber(stackSize)
	local bid = Money.FromString(frame:GetElement("bid.text"):GetText())
	local buyout = Money.FromString(frame:GetElement("buyout.text"):GetText())
	local itemString = button:GetContext()
	local postBag, postSlot = BagTracking.CreateQueryBagsAuctionable()
		:OrderBy("slotId", true)
		:Select("bag", "slot")
		:Equal("itemString", itemString)
		:GetFirstResultAndRelease()
	if postBag and postSlot then

		local postTime = Table.GetDistinctKey(POST_TIME_STRS, frame:GetElement("duration.toggle"):GetValue())
		if TSM.IsWow83() then
			bid = Math.Round(bid, COPPER_PER_SILVER)
			buyout = Math.Round(buyout, COPPER_PER_SILVER)
			private.itemLocation:Clear()
			private.itemLocation:SetBagAndSlot(postBag, postSlot)
			local commodityStatus = C_AuctionHouse.GetItemCommodityStatus(private.itemLocation)
			if commodityStatus == Enum.ItemCommodityStatus.Item then
				C_AuctionHouse.PostItem(private.itemLocation, postTime, stackSize, bid < buyout and bid or nil, buyout)
			elseif commodityStatus == Enum.ItemCommodityStatus.Commodity then
				C_AuctionHouse.PostCommodity(private.itemLocation, postTime, stackSize, buyout)
			else
				error("Unknown commodity status: "..tostring(itemString))
			end
		else
			local num = frame:GetElement("quantity.num"):GetText()
			num = tonumber(num)
			if strfind(button:GetContext(), "^p") then
				stackSize = 1
				num = 1
			end
			if private.perItem then
				bid = bid * stackSize
				buyout = buyout * stackSize
			end
			-- need to set the duration in the default UI to avoid Blizzard errors
			AuctionFrameAuctions.duration = postTime
			ClearCursor()
			PickupContainerItem(postBag, postSlot)
			ClickAuctionSellItemButton(AuctionsItemButton, "LeftButton")
			PostAuction(bid, buyout, postTime, stackSize, num)
			ClearCursor()
		end
	end
	frame:GetBaseElement():HideDialog()
end

function private.PostDialogCloseBtnOnClick(button)
	button:GetBaseElement():HideDialog()
end

function private.ScanFilterInputOnEnterPressed(input)
	local filter = strtrim(input:GetText())
	if filter == "" then
		return
	end
	local viewContainer = input:GetParentElement():GetParentElement():GetParentElement()
	viewContainer:SetPath("selection")
	private.StartFilterSearchHelper(viewContainer, filter)
end

function private.RescanBtnOnClick(button)
	if not TSM.UI.AuctionUI.StartingScan(L["Shopping"]) then
		return
	end
	private.fsm:ProcessEvent("EV_RESCAN_CLICKED")
end

function private.GetBagQuantity(itemString)
	return BagTracking.CreateQueryBagsItemAuctionable(ItemString.GetBase(itemString))
		:SumAndRelease("quantity") or 0
end

function private.GetMaxPostStack(itemString)
	local numHave = private.GetBagQuantity(itemString)
	if TSM.IsWow83() then
		return ItemInfo.IsCommodity(itemString) and numHave or 1
	else
		return min(ItemInfo.GetMaxStack(itemString), numHave)
	end
end

function private.MaxNumBtnOnClick(button)
	button:GetElement("__parent.__parent.quantity.stackSize"):SetFocused(false)
	local itemString = button:GetElement("__parent.__parent.confirmBtn"):GetContext()
	local stackSize = tonumber(button:GetElement("__parent.__parent.quantity.stackSize"):GetText())
	local num = floor(private.GetBagQuantity(itemString) / stackSize)
	if num == 0 then
		return
	end
	button:GetElement("__parent.__parent.quantity.num")
		:SetText(num)
		:Draw()
end

function private.MaxStackSizeBtnOnClick(button)
	if not TSM.IsWow83() then
		button:GetElement("__parent.__parent.quantity.num"):SetFocused(false)
	end
	local itemString = button:GetElement("__parent.__parent.confirmBtn"):GetContext()
	local numHave = private.GetBagQuantity(itemString)
	local stackSize = private.GetMaxPostStack(itemString)
	assert(stackSize > 0)
	button:GetElement("__parent.__parent.quantity.stackSize")
		:SetText(stackSize)
		:Draw()
	if not TSM.IsWow83() then
		local numStacks = tonumber(button:GetElement("__parent.__parent.quantity.num"):GetText())
		local newStackSize = floor(numHave / stackSize)
		if numStacks > newStackSize then
			button:GetElement("__parent.__parent.quantity.num")
				:SetText(newStackSize)
				:Draw()
		end
	end
end

function private.DurationOnValueChanged(toggle)
	private.UpdateDepositCost(toggle:GetParentElement():GetParentElement())
end



-- ============================================================================
-- FSM
-- ============================================================================

function private.FSMCreate()
	local fsmContext = {
		db = TSMAPI_FOUR.Auction.NewDatabase("SHOPPING_AUCTIONS"),
		scanFrame = nil,
		scanName = "",
		itemInfo = nil,
		scanThreadId = nil,
		marketValueFunc = nil,
		auctionScan = nil,
		query = nil,
		progress = 0,
		progressText = L["Starting Scan..."],
		postDisabled = true,
		bidDisabled = true,
		buyoutDisabled = true,
		stopDisabled = true,
		findHash = nil,
		findAuction = nil,
		findResult = nil,
		numFound = 0,
		numBought = 0,
		lastBuyQuantity = 0,
		numBid = 0,
		numConfirmed = 0,
		scanContext = nil,
		buyCallback = nil,
		stateCallback = nil,
	}

	Event.Register("CHAT_MSG_SYSTEM", private.FSMMessageEventHandler)
	Event.Register("UI_ERROR_MESSAGE", private.FSMMessageEventHandler)
	Event.Register("AUCTION_HOUSE_CLOSED", function()
		private.fsm:ProcessEvent("EV_AUCTION_HOUSE_CLOSED")
	end)
	local function UpdateScanFrame(context)
		if not context.scanFrame then
			return
		end
		context.scanFrame:GetElement("searchFrame.filterInput")
			:SetText(context.scanName)
		context.scanFrame:GetElement("searchFrame.rescanBtn")
			:SetDisabled(context.scanName == L["Gathering Search"])
		local bottom = context.scanFrame:GetElement("bottom")
		bottom:GetElement("postBtn"):SetDisabled(context.postDisabled)
		bottom:GetElement("bidBtn"):SetDisabled(context.bidDisabled)
		bottom:GetElement("buyoutBtn"):SetDisabled(context.buyoutDisabled)
		bottom:GetElement("stopBtn"):SetDisabled(context.stopDisabled)
		bottom:GetElement("progressBar"):SetProgress(context.progress)
			:SetText(context.progressText or "")
			:SetProgressIconHidden(context.progress == 1 or (context.findResult and context.numBought + context.numBid == context.numConfirmed))
		local auctionList = context.scanFrame:GetElement("auctions")
			:SetContext(context.auctionScan)
			:SetQuery(context.query)
			:SetMarketValueFunction(context.marketValueFunc)
			:SetSelectionDisabled(context.numBought + context.numBid ~= context.numConfirmed)
		if context.findAuction and not auctionList:GetSelectedRecord() then
			auctionList:SetSelectedRecord(context.findAuction)
		end
		context.scanFrame:Draw()
	end
	private.fsm = FSM.New("SHOPPING")
		:AddState(FSM.NewState("ST_INIT")
			:SetOnEnter(function(context, ...)
				private.hasLastScan = false
				context.db:Truncate()
				context.scanName = ""
				context.itemInfo = nil
				if context.scanThreadId then
					Threading.Kill(context.scanThreadId)
					context.scanThreadId = nil
				end
				if context.query then
					context.query:Release()
				end
				if context.scanContext then
					TempTable.Release(context.scanContext)
					context.scanContext = nil
				end
				if context.stateCallback then
					context.stateCallback("DONE")
				end
				context.query = nil
				context.marketValueFunc = nil
				context.progress = 0
				context.progressText = L["Starting Scan..."]
				context.postDisabled = true
				context.bidDisabled = true
				context.buyoutDisabled = true
				context.stopDisabled = true
				context.findHash = nil
				context.findAuction = nil
				context.findResult = nil
				context.numFound = 0
				context.numBought = 0
				context.lastBuyQuantity = 0
				context.numBid = 0
				context.numConfirmed = 0
				context.buyCallback = nil
				context.stateCallback = nil
				if context.auctionScan then
					context.auctionScan:Release()
					context.auctionScan = nil
				end
				if ... then
					return "ST_STARTING_SCAN", ...
				elseif context.scanFrame then
					context.scanFrame:GetParentElement():SetPath("selection", true)
					context.scanFrame = nil
				end
				TSM.UI.AuctionUI.EndedScan(L["Shopping"])
			end)
			:AddTransition("ST_INIT")
			:AddTransition("ST_STARTING_SCAN")
		)
		:AddState(FSM.NewState("ST_STARTING_SCAN")
			:SetOnEnter(function(context, scanThreadId, marketValueFunc, buyCallback, stateCallback, scanName, filterStr, itemInfo, ...)
				context.scanContext = TempTable.Acquire(scanThreadId, marketValueFunc, buyCallback, stateCallback, scanName, filterStr, itemInfo, ...)
				private.hasLastScan = true
				context.scanThreadId = scanThreadId
				context.marketValueFunc = marketValueFunc
				context.scanName = scanName
				context.itemInfo = itemInfo
				context.buyCallback = buyCallback
				context.stateCallback = stateCallback
				context.auctionScan = TSMAPI_FOUR.Auction.NewAuctionScan(context.db)
					:SetResolveSellers(true)
					:SetScript("OnProgressUpdate", private.FSMAuctionScanOnProgressUpdate)
				context.query = context.db:NewQuery()
				context.stopDisabled = false
				UpdateScanFrame(context)
				Threading.SetCallback(context.scanThreadId, private.FSMScanCallback)
				Threading.Start(context.scanThreadId, context.auctionScan, filterStr, itemInfo, ...)
				context.stateCallback("SCANNING")
				return "ST_SCANNING"
			end)
			:AddTransition("ST_SCANNING")
		)
		:AddState(FSM.NewState("ST_SCANNING")
			:AddTransition("ST_UPDATING_SCAN_PROGRESS")
			:AddTransition("ST_RESULTS")
			:AddTransition("ST_INIT")
			:AddEventTransition("EV_SCAN_PROGRESS_UPDATE", "ST_UPDATING_SCAN_PROGRESS")
			:AddEvent("EV_SCAN_COMPLETE", function(context)
				TSM.UI.AuctionUI.EndedScan(L["Shopping"])
				if context.scanFrame then
					context.scanFrame:GetElement("auctions"):ExpandSingleResult()
				end
				context.stateCallback("RESULTS")
				return "ST_RESULTS"
			end)
			:AddEvent("EV_SCAN_FAILED", function(context)
				context.stateCallback("RESULTS")
				return "ST_RESULTS"
			end)
			:AddEvent("EV_STOP_SCAN", function(context)
				context.stateCallback("RESULTS")
				return "ST_RESULTS"
			end)
			:AddEvent("EV_RESCAN_CLICKED", function(context)
				if context.scanFrame then
					local viewContainer = context.scanFrame:GetParentElement()
					viewContainer:SetPath("selection", true)
					viewContainer:SetPath("scan", true)
					context.scanFrame = viewContainer:GetElement("scan")
				end
				local scanContext = context.scanContext
				context.scanContext = nil
				return "ST_INIT", TempTable.UnpackAndRelease(scanContext)
			end)
		)
		:AddState(FSM.NewState("ST_UPDATING_SCAN_PROGRESS")
			:SetOnEnter(function(context)
				local filtersScanned, numFilters, pagesScanned, numPages = context.auctionScan:GetProgress()
				local progress, text = nil, nil
				if filtersScanned == numFilters then
					progress = 1
					text = L["Done Scanning"]
				else
					if numPages == 0 then
						progress = filtersScanned / numFilters
						numPages = 1
					else
						progress = (filtersScanned + pagesScanned / numPages) / numFilters
					end
					text = format(L["Scanning %d / %d (Page %d / %d)"], filtersScanned + 1, numFilters, pagesScanned + 1, numPages)
				end
				context.progress = progress
				context.progressText = text
				UpdateScanFrame(context)
				return "ST_SCANNING"
			end)
			:AddTransition("ST_SCANNING")
		)
		:AddState(FSM.NewState("ST_RESULTS")
			:SetOnEnter(function(context)
				TSM.UI.AuctionUI.EndedScan(L["Shopping"])
				Threading.Kill(context.scanThreadId)
				context.findAuction = nil
				context.findResult = nil
				context.numFound = 0
				context.numBought = 0
				context.lastBuyQuantity = 0
				context.numBid = 0
				context.numConfirmed = 0
				context.progress = 1
				context.progressText = L["Done Scanning"]
				if context.itemInfo then
					local cheapest = context.db:NewQuery()
						:Equal("itemString", context.itemInfo.itemString)
						:OrderBy("itemBuyout", true)
						:GreaterThan("itemBuyout", 0)
						:GetFirstResultAndRelease()
					if cheapest then
						context.itemInfo.seller = cheapest:GetField("seller")
						context.itemInfo.displayedBid = cheapest:GetField("itemDisplayedBid")
						context.itemInfo.buyout = cheapest:GetField("itemBuyout")
						cheapest:Release()
					end
				end
				context.postDisabled = not context.itemInfo and true or private.GetBagQuantity(context.itemInfo.itemString) == 0
				context.bidDisabled = true
				context.buyoutDisabled = true
				context.stopDisabled = true
				UpdateScanFrame(context)
				if context.scanFrame and context.scanFrame:GetElement("auctions"):GetSelectedRecord() and TSM.UI.AuctionUI.StartingScan(L["Shopping"]) then
					return "ST_FINDING_AUCTION"
				end
			end)
			:AddTransition("ST_FINDING_AUCTION")
			:AddTransition("ST_INIT")
			:AddEvent("EV_AUCTION_SELECTION_CHANGED", function(context)
				assert(context.scanFrame)
				if context.scanFrame:GetElement("auctions"):GetSelectedRecord() and TSM.UI.AuctionUI.StartingScan(L["Shopping"]) then
					return "ST_FINDING_AUCTION"
				end
			end)
			:AddEvent("EV_POST_BUTTON_CLICK", function(context)
				private.PostDialogShow(context.scanFrame:GetBaseElement(), context.scanFrame:GetElement("auctions"):GetSelectedRecord() or private.itemInfo)
			end)
			:AddEvent("EV_RESCAN_CLICKED", function(context)
				if context.scanFrame then
					local viewContainer = context.scanFrame:GetParentElement()
					viewContainer:SetPath("selection", true)
					viewContainer:SetPath("scan", true)
					context.scanFrame = viewContainer:GetElement("scan")
				end
				local scanContext = context.scanContext
				context.scanContext = nil
				return "ST_INIT", TempTable.UnpackAndRelease(scanContext)
			end)
		)
		:AddState(FSM.NewState("ST_FINDING_AUCTION")
			:SetOnEnter(function(context)
				assert(context.scanFrame)
				context.findAuction = context.scanFrame:GetElement("auctions"):GetSelectedRecord()
				context.findHash = context.findAuction:GetField("hash")
				context.progress = 0
				context.progressText = L["Finding Selected Auction"]
				context.postDisabled = private.GetBagQuantity(context.scanFrame:GetElement("auctions"):GetSelectedRecord():GetField("itemString")) == 0
				context.bidDisabled = true
				context.buyoutDisabled = true
				UpdateScanFrame(context)
				TSM.Shopping.SearchCommon.StartFindAuction(context.auctionScan, context.findAuction, private.FSMFindAuctionCallback, false)
			end)
			:SetOnExit(function(context)
				TSM.Shopping.SearchCommon.StopFindAuction()
			end)
			:AddTransition("ST_FINDING_AUCTION")
			:AddTransition("ST_RESULTS")
			:AddTransition("ST_AUCTION_FOUND")
			:AddTransition("ST_AUCTION_NOT_FOUND")
			:AddTransition("ST_INIT")
			:AddEventTransition("EV_AUCTION_FOUND", "ST_AUCTION_FOUND")
			:AddEventTransition("EV_AUCTION_NOT_FOUND", "ST_AUCTION_NOT_FOUND")
			:AddEvent("EV_AUCTION_SELECTION_CHANGED", function(context)
				assert(context.scanFrame)
				if context.scanFrame:GetElement("auctions"):GetSelectedRecord() and TSM.UI.AuctionUI.StartingScan(L["Shopping"]) then
					return "ST_FINDING_AUCTION"
				else
					return "ST_RESULTS"
				end
			end)
			:AddEvent("EV_POST_BUTTON_CLICK", function(context)
				private.PostDialogShow(context.scanFrame:GetBaseElement(), context.scanFrame:GetElement("auctions"):GetSelectedRecord())
			end)
			:AddEvent("EV_RESCAN_CLICKED", function(context)
				if context.scanFrame then
					local viewContainer = context.scanFrame:GetParentElement()
					viewContainer:SetPath("selection", true)
					viewContainer:SetPath("scan", true)
					context.scanFrame = viewContainer:GetElement("scan")
				end
				local scanContext = context.scanContext
				context.scanContext = nil
				return "ST_INIT", TempTable.UnpackAndRelease(scanContext)
			end)
			:AddEvent("EV_SCAN_FRAME_HIDDEN", function(context)
				context.scanFrame = nil
				context.findAuction = nil
				return "ST_RESULTS"
			end)
		)
		:AddState(FSM.NewState("ST_AUCTION_FOUND")
			:SetOnEnter(function(context, result)
				TSM.UI.AuctionUI.EndedScan(L["Shopping"])
				if TSM.IsWow83() then
					local numCanBuy = min(result, context.auctionScan:GetNumCanBuy(context.findAuction) or math.huge)
					context.findResult = numCanBuy > 0
					context.numFound = numCanBuy
				else
					context.findResult = result
					context.numFound = min(#result, context.auctionScan:GetNumCanBuy(context.findAuction) or math.huge)
				end
				assert(context.numBought == 0 and context.numBid == 0 and context.numConfirmed == 0)
				return "ST_BUYING"
			end)
			:AddTransition("ST_BUYING")
		)
		:AddState(FSM.NewState("ST_AUCTION_NOT_FOUND")
			:SetOnEnter(function(context)
				TSM.UI.AuctionUI.EndedScan(L["Shopping"])
				local link = context.findAuction:GetField("rawLink")
				context.auctionScan:DeleteRowFromDB(context.findAuction, 0)
				Log.PrintfUser(L["Failed to find auction for %s, so removing it from the results."], link)
				return "ST_RESULTS"
			end)
			:AddTransition("ST_RESULTS")
		)
		:AddState(FSM.NewState("ST_BUYING")
			:SetOnEnter(function(context, numToRemove)
				if numToRemove then
					-- remove the one we just bought
					context.db:SetQueryUpdatesPaused(true)
					local deletedRow = context.auctionScan:DeleteRowFromDB(context.findAuction, numToRemove)
					if deletedRow and context.scanFrame then
						-- move to the next auction
						context.scanFrame:GetElement("auctions"):SelectNextRecord()
					end
					context.db:SetQueryUpdatesPaused(false)
					context.findAuction = context.scanFrame and context.scanFrame:GetElement("auctions"):GetSelectedRecord()
				end
				local selection = context.scanFrame and context.scanFrame:GetElement("auctions"):GetSelectedRecord()
				local auctionSelected = selection and context.findHash == selection:GetField("hash")
				local numCanBuy = not auctionSelected and 0 or (context.numFound - context.numBought - context.numBid)
				local numConfirming = context.numBought + context.numBid - context.numConfirmed
				local progressText = nil
				if numConfirming == 0 and numCanBuy == 0 then
					-- we're done buying and confirming this batch - try to select the next auction
					return "ST_RESULTS"
				elseif numConfirming == 0 then
					-- we can still buy more
					progressText = format(L["Buy %d / %d"], context.numBought + context.numBid + 1, context.numFound)
				elseif numCanBuy == 0 then
					-- we're just confirming
					progressText = format(L["Confirming %d / %d"], context.numConfirmed + 1, context.numFound)
				else
					-- we can buy more while confirming
					progressText = format(L["Buy %d / %d (Confirming %d / %d)"], context.numBought + context.numBid + 1, context.numFound, context.numConfirmed + 1, context.numFound)
				end
				context.progress = context.numConfirmed / context.numFound
				context.progressText = progressText
				context.postDisabled = private.GetBagQuantity(selection:GetField("itemString")) == 0
				local isPlayer = TSMAPI_FOUR.PlayerInfo.IsPlayer(selection.seller, true, true, true)
				if numCanBuy == 0 or isPlayer or (TSM.IsWow83() and numConfirming > 0) then
					context.bidDisabled = true
					context.buyoutDisabled = true
				else
					context.bidDisabled = not TSM.Auction.CanBid(selection)
					context.buyoutDisabled = not TSM.Auction.CanBuyout(selection, context.db)
				end
				UpdateScanFrame(context)
			end)
			:AddTransition("ST_BUYING")
			:AddTransition("ST_BUY_CONFIRMATION")
			:AddTransition("ST_BID_CONFIRMATION")
			:AddTransition("ST_PLACING_BUY")
			:AddTransition("ST_PLACING_BID")
			:AddTransition("ST_CONFIRMING_BUY")
			:AddTransition("ST_RESULTS")
			:AddTransition("ST_INIT")
			:AddEventTransition("EV_AUCTION_SELECTION_CHANGED", "ST_BUYING")
			:AddEventTransition("EV_BUYOUT_CLICKED", "ST_BUY_CONFIRMATION")
			:AddEventTransition("EV_BID_CLICKED", "ST_BID_CONFIRMATION")
			:AddEvent("EV_CONFIRMED", function(context, isBuy, quantity)
				return isBuy and "ST_PLACING_BUY" or "ST_PLACING_BID", quantity
			end)
			:AddEvent("EV_MSG", function(context, msg)
				if not context.findAuction then
					return
				end
				if msg == LE_GAME_ERR_AUCTION_HIGHER_BID or msg == LE_GAME_ERR_ITEM_NOT_FOUND or msg == LE_GAME_ERR_AUCTION_BID_OWN or msg == LE_GAME_ERR_NOT_ENOUGH_MONEY then
					-- failed to buy an auction
					return "ST_CONFIRMING_BUY", false
				elseif msg == format(ERR_AUCTION_WON_S, context.findAuction:GetField("rawName")) or (context.numBid > 0 and msg == ERR_AUCTION_BID_PLACED) then
					-- bought an auction
					return "ST_CONFIRMING_BUY", true
				end
			end)
			:AddEvent("EV_POST_BUTTON_CLICK", function(context)
				private.PostDialogShow(context.scanFrame:GetBaseElement(), context.scanFrame:GetElement("auctions"):GetSelectedRecord())
			end)
			:AddEvent("EV_RESCAN_CLICKED", function(context)
				if context.scanFrame then
					local viewContainer = context.scanFrame:GetParentElement()
					viewContainer:SetPath("selection", true)
					viewContainer:SetPath("scan", true)
					context.scanFrame = viewContainer:GetElement("scan")
				end
				local scanContext = context.scanContext
				context.scanContext = nil
				return "ST_INIT", TempTable.UnpackAndRelease(scanContext)
			end)
			:AddEvent("EV_SCAN_FRAME_HIDDEN", function(context)
				context.scanFrame = nil
				context.findAuction = nil
				return "ST_RESULTS"
			end)
		)
		:AddState(FSM.NewState("ST_BUY_CONFIRMATION")
			:SetOnEnter(function(context)
				local selection = context.scanFrame:GetElement("auctions"):GetSelectedRecord()
				if TSM.UI.AuctionUI.BuyUtil.ShowConfirmation(context.scanFrame, selection, true, context.numConfirmed + 1, context.numFound, private.FSMConfirmationCallback) then
					return "ST_BUYING"
				else
					return "ST_PLACING_BUY", selection:GetField("stackSize")
				end
			end)
			:AddTransition("ST_PLACING_BUY")
			:AddTransition("ST_BUYING")
		)
		:AddState(FSM.NewState("ST_BID_CONFIRMATION")
			:SetOnEnter(function(context)
				local selection = context.scanFrame:GetElement("auctions"):GetSelectedRecord()
				if TSM.UI.AuctionUI.BuyUtil.ShowConfirmation(context.scanFrame, selection, false, context.numConfirmed + 1, context.numFound, private.FSMConfirmationCallback) then
					return "ST_BUYING"
				else
					return "ST_PLACING_BID", selection:GetField("stackSize")
				end
			end)
			:AddTransition("ST_PLACING_BID")
			:AddTransition("ST_BUYING")
		)
		:AddState(FSM.NewState("ST_PLACING_BUY")
			:SetOnEnter(function(context, quantity)
				local index = not TSM.IsWow83() and tremove(context.findResult, #context.findResult) or nil
				assert(TSM.IsWow83() or index)
				-- buy the auction
				if context.auctionScan:PlaceBidOrBuyout(index, context.findAuction:GetField("buyout"), context.findAuction, false, quantity) then
					context.numBought = context.numBought + (TSM.IsWow83() and quantity or 1)
					context.lastBuyQuantity = quantity
				else
					Log.PrintfUser(L["Failed to buy auction of %s."], context.findAuction:GetField("rawLink"))
				end
				return "ST_BUYING"
			end)
			:AddTransition("ST_BUYING")
		)
		:AddState(FSM.NewState("ST_CONFIRMING_BUY")
			:SetOnEnter(function(context, success)
				if success then
					context.buyCallback(context.findAuction:GetField("targetItem"), context.lastBuyQuantity * context.findAuction:GetField("targetItemRate"))
				else
					Log.PrintfUser(L["Failed to buy auction of %s."], context.findAuction:GetField("rawLink"))
				end
				context.numConfirmed = context.numConfirmed + (TSM.IsWow83() and context.lastBuyQuantity or 1)
				return "ST_BUYING", context.lastBuyQuantity
			end)
			:AddTransition("ST_BUYING")
		)
		:AddState(FSM.NewState("ST_PLACING_BID")
			:SetOnEnter(function(context, quantity)
				local index = not TSM.IsWow83() and tremove(context.findResult, #context.findResult) or nil
				assert(not TSM.IsWow83() or index)
				-- bid on the auction
				if context.auctionScan:PlaceBidOrBuyout(index, TSM.Auction.GetRequiredBidByScanResultRow(context.findAuction), context.findAuction, false, quantity) then
					context.numBid = context.numBid + (TSM.IsWow83() and quantity or 1)
					context.lastBuyQuantity = quantity
				else
					Log.PrintfUser(L["Failed to bid on auction of %s."], context.findAuction:GetField("rawLink"))
				end
				return "ST_BUYING"
			end)
			:AddTransition("ST_BUYING")
		)
		:AddDefaultEvent("EV_START_SCAN", function(context, ...)
			return "ST_INIT", ...
		end)
		:AddDefaultEvent("EV_SCAN_FRAME_SHOWN", function(context, scanFrame)
			context.scanFrame = scanFrame
			UpdateScanFrame(context)
			context.scanFrame:GetElement("auctions")
				:UpdateData(true)
				:ExpandSingleResult()
		end)
		:AddDefaultEvent("EV_SCAN_FRAME_HIDDEN", function(context)
			context.scanFrame = nil
			context.findAuction = nil
		end)
		:AddDefaultEventTransition("EV_AUCTION_HOUSE_CLOSED", "ST_INIT")
		:AddDefaultEventTransition("EV_SCAN_BACK_BUTTON_CLICKED", "ST_INIT")
		:Init("ST_INIT", fsmContext)
end

function private.FSMMessageEventHandler(_, msg)
	private.fsm:SetLoggingEnabled(false)
	private.fsm:ProcessEvent("EV_MSG", msg)
	private.fsm:SetLoggingEnabled(true)
end

function private.FSMAuctionScanOnProgressUpdate(auctionScan)
	private.fsm:ProcessEvent("EV_SCAN_PROGRESS_UPDATE")
end

function private.FSMScanCallback(success)
	if success then
		private.fsm:ProcessEvent("EV_SCAN_COMPLETE")
	else
		private.fsm:ProcessEvent("EV_SCAN_FAILED")
	end
end

function private.FSMFindAuctionCallback(result)
	if result then
		private.fsm:ProcessEvent("EV_AUCTION_FOUND", result)
	else
		private.fsm:ProcessEvent("EV_AUCTION_NOT_FOUND")
	end
end

function private.FSMConfirmationCallback(isBuy, quantity)
	private.fsm:ProcessEvent("EV_CONFIRMED", isBuy, quantity)
end
