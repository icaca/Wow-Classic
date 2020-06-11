--[[
-TODO
wenn schon was im lootfenster ist, nicht auffüllen.

1.10
- Option: Trade locked items in untrade slot for rogues
- show picklock-button for rogues

1.01
- don't clear on trade-startup
- automatic put locked items in special-slot, when in trade with a rogue

1.00
- preload items
- Disabled during combat-lockdown

0.17
- Fix Healthstone-trade :)

0.16
- Warlock Healthstone support
- Option "Use not complete full stack"

0.15
- Fix Lua-Error on combat start.

0.14
- conjured food support
- combine settings for conjured food / water
- small icons
- You can set now for solo/stranger, group-member and raid-member
- predefinied settings for any conjured food / water
- Sorry - i must reset all settings

0.13
- Add additional button to the trade window
- checks minimum level for an conjured item
- support cast button, when conjured water is missing 
--]]

local DEBUGMODE=false


local TOCNAME,ADDON=...
local L = setmetatable({}, {__index = function (t, k)  
	if ADDON.L and ADDON.L[k] then 
		return ADDON.L[k]
	else
		return "["..k.."]"
	end	
end})
WATERDISPENSER_ADDON=ADDON
ADDON.Version=GetAddOnMetadata(TOCNAME, "Version") 
ADDON.SettingsVersion=3
ADDON.Title=GetAddOnMetadata(TOCNAME, "Title") 
ADDON.PREFIX="[WD]: "

local T=":0:0:0:0:64:64:4:60:4:60"

ADDON.CombineItemId={}
local function AddCombineItemId(id,list)
	for i,add in ipairs(list) do
		ADDON.CombineItemId[add]=id
	end
end

AddCombineItemId(5512,{19005,19004})
AddCombineItemId(5511,{19007,19006})
AddCombineItemId(5509,{19009,19008})
AddCombineItemId(5510,{19011,19010})
AddCombineItemId(9421,{19013,19012})

ADDON.SpellList={ -- spell,item
	MageWater={
		[5504]=5350,
		[5505]=2288,
		[5506]=2136,
		[6127]=3772,
		[10138]=8077,
		[10139]=8078,
		[10140]=8079,
	},
	MageFood={
		[587]=5349,
		[597]=1113,
		[990]=1114,
		[6129]=1487,
		[10144]=8075,
		[10145]=8076,
		[28612]=22895,
	},
	WarlockHealthstone={
		[6201]=5512,
		[6202]=5511,
		[5699]=5509,
		[11729]=5510,
		[11730]=9421,
	}
}

ADDON.SpellPickLock=1804

function ADDON.ClearInventroy()
	ADDON.Inventory=nil
end
function ADDON.GetInventory()
	OldInventory=ADDON.Inventory 
	
	ADDON.Inventory={}
	ADDON.InventoryLockbox=nil
	
	for itemCollection,spells in pairs(ADDON.SpellList) do
		for spell,itemID in pairs(spells) do
			if IsSpellKnown(spell) or DEBUGMODE then
				local itemName, itemLink, _, _, itemMinLevel, _, _, itemStackCount, _, itemIcon, _, itemClassID, _, bindType= GetItemInfo(itemID) 
				ADDON.Inventory[itemID]={
							link=itemLink,
							name=itemName,
							icon=itemIcon,
							id=itemID,
							stack=itemStackCount,
							bag={},
							level=itemMinLevel or 0,
							collection=itemCollection,
							spellId=spell,
						}
			end
		end
	end
	for bag=BACKPACK_CONTAINER , NUM_BAG_SLOTS do
		for slot=1,GetContainerNumSlots(bag) do
			local _, itemCount, _, _, _, lootable, itemLink, _, _, itemID = GetContainerItemInfo(bag, slot)
			
			if itemID then 
				if lootable then
					for i,text in ipairs(ADDON.Tool.ScanToolTip("SetBagItem",bag,slot)) do
						if text==LOCKED then
							ADDON.InventoryLockbox={Bag=bag,Slot=slot}
						end
					end				
				end
			
			
				local itemName, _, _, _, itemMinLevel, _, _, itemStackCount, _, itemIcon, _, itemClassID, _, bindType= GetItemInfo(itemID) 
				if itemClassID==LE_ITEM_CLASS_CONSUMABLE and bindType==0 then
				
					local classId= ADDON.CombineItemId[itemID] or itemID

					if not ADDON.Inventory[classId] then
						ADDON.Inventory[classId]={
							link=itemLink,
							name=itemName,
							icon=itemIcon,
							id=itemID,
							stack=itemStackCount,
							level=itemMinLevel or 0,
							bag={},
						}
					end
					--print(itemLink,itemStackCount,itemCount)
					tinsert(ADDON.Inventory[classId].bag,{
						["bag"]=bag,
						["slot"]=slot,	
						["full"]=itemStackCount==itemCount,
					})				
				end
			end
		end
	end
	
	if OldInventory then
		for id,item in pairs(ADDON.Inventory) do
			if #item.bag ~= (OldInventory[id] and #OldInventory[id].bag or 0) then
				return true
			end
		end
		return false	
	end
	return true
end

function ADDON.ClearTrade()
	if not ADDON.TradeClass then 
		print(ADDON.PREFIX,L.errNoTrade)
		return
	end
	
	for i=1,MAX_TRADABLE_ITEMS do
		ClearCursor()
		ClickTradeButton(i)		
	end
	ClearCursor()
end

function ADDON.FillTrade(forced)
	if not ADDON.TradeClass then 
		print(ADDON.PREFIX,L.errNoTrade)
		return
	end
	
	if not ADDON.GetInventory() and not forced then
		return true
	end
	
	local colMax={}
	local colItemId={}

	for id,x in pairs(ADDON.SpellList) do 
		colItemId[id]=0
		colMax[id]=0
	end
	
	for id,item in pairs(ADDON.Inventory) do
		if item.collection then
			if (colMax[item.collection] or 0)< item.level and ADDON.TradeLevel >= item.level then
				colMax[item.collection]=item.level
				colItemId[item.collection]=id
			end
		end
	end
	
	ADDON.MissingStack=false
	if not ADDON.DontClear then
		ADDON.ClearTrade()
	else
		ADDON.DontClear=false
	end
	
	if ADDON.DB.Locked and ADDON.InventoryLockbox and ADDON.TradeClass=="ROGUE" then 
		ClearCursor()
		PickupContainerItem(ADDON.InventoryLockbox.Bag, ADDON.InventoryLockbox.Slot)
		ClickTradeButton(TRADE_ENCHANT_SLOT)
	end
	

	local inventory=ADDON.Inventory
	
	local tradePos
	for id,SaveItem in pairs(ADDON.DB.Item) do
		local count

		if ADDON.TradeParty then
			if IsInRaid() then 
				count=SaveItem.Raid[ADDON.TradeClass] or 0
			else
				count=SaveItem.Group[ADDON.TradeClass] or 0
			end
		else
			count=SaveItem.Solo[ADDON.TradeClass] or 0		
		end
		
		if count>0 then 
			local inv
			if colItemId[id] then
				inv=inventory[colItemId[id]]
				if colItemId[id]==0 then
					count=0
				end
			else
				inv=inventory[id]
			end
			
			if inv then
				
				for ibag,item in ipairs(inv.bag) do
					if item.full then 
						ClearCursor()
						PickupContainerItem(item.bag, item.slot)
						tradePos=TradeFrame_GetAvailableSlot()
						if tradePos==nil then
							return
						end
						ClickTradeButton(tradePos)						
						count=count-1
						if count<=0 then
							break
						end						
					end
				end
				-- not full stack
				if count>0 and SaveItem.UseNotFullStack then
					for ibag,item in ipairs(inv.bag) do
						if not item.full then 
							ClearCursor()
							PickupContainerItem(item.bag, item.slot)
							tradePos=TradeFrame_GetAvailableSlot()
							if tradePos==nil then
								return
							end
							ClickTradeButton(tradePos)
							count=count-1
							if count<=0 then
								break
							end						
						end
					end								
				end
											
			end
			if count>0 then
				ADDON.MissingStack=true
				if inv then
					print(ADDON.PREFIX,L.MissingStack,(inv.icon and ("|T"..inv.icon..T.."|t") or "")..inv.name,"x"..count)
					
					if inv.spellId and inv.collection and ADDON.Frame.Btn[inv.collection] then		
						ADDON.Frame.Btn[inv.collection]:SetSpell(inv.spellId)
					end
				else
					print(ADDON.PREFIX,L.MissingStack,(SaveItem and ("|T"..SaveItem.icon..T.."|t") or "")..SaveItem.name,"x"..count)
				end
					
			end
		end
	end
	
	
	if IsSpellKnown(ADDON.SpellPickLock) then
		ADDON.Frame.Btn.PickLock:SetSpell(ADDON.SpellPickLock)
	end
	
	
	
end

local function OptionSelectedID(id)

	ADDON.OptionItemId=id
	
	local x
	if ADDON.DB.Item[id] then
		x=ADDON.DB.Item[id]
	else
		x=ADDON.Inventory[id]
	end
	
	
	ADDON.Options.EditCategory(ADDON.OptionItemName,(x.icon and ("|T"..x.icon..T.."|t") or "")..x.name .." ".. L.inStacks)
	
	if x.Solo then
		for i,class in ipairs(ADDON.Tool.Classes) do
			ADDON.ClassListSolo[class] =ADDON.DB.Item[id].Solo[class] or 0
			ADDON.ClassListGroup[class]=ADDON.DB.Item[id].Group[class] or 0
			ADDON.ClassListRaid[class] =ADDON.DB.Item[id].Raid[class] or 0
		end
		ADDON.ClassListSolo.UseNotFullStack=ADDON.DB.Item[id].UseNotFullStack or false
		
		ADDON.OptionButSave:Enable()
		if x.noRemove then
			ADDON.OptionButRemove:Disable()
			ADDON.OptionsCboxUseNotFullStack:Hide()
		else		
			ADDON.OptionButRemove:Enable()
			ADDON.OptionsCboxUseNotFullStack:Show()
		end
		
	else
		for i,class in ipairs(ADDON.Tool.Classes) do
			ADDON.ClassListSolo[class]=0
			ADDON.ClassListGroup[class]=0
			ADDON.ClassListRaid[class]=0
		end
		ADDON.ClassListSolo.UseNotFullStack=false
		ADDON.OptionButSave:Enable()
		ADDON.OptionButRemove:Disable()
		ADDON.OptionsCboxUseNotFullStack:Show()
	end	
	
	ADDON.Options.DoCancel(ADDON.ClassListSolo) 
	ADDON.Options.DoCancel(ADDON.ClassListGroup)
	ADDON.Options.DoCancel(ADDON.ClassListRaid) 
end
local function OptionSave()
	if ADDON.OptionItemId then
		ADDON.Options.DoOk(ADDON.ClassListSolo) 
		ADDON.Options.DoOk(ADDON.ClassListGroup) 
		ADDON.Options.DoOk(ADDON.ClassListRaid) 
		local id=ADDON.OptionItemId
		if ADDON.DB.Item[id]==nil then
			ADDON.DB.Item[id]={
				name=ADDON.Inventory[id].name,
				icon=ADDON.Inventory[id].icon,
				Solo={},
				Group={},
				Raid={},				
			}
		end
		for i,class in ipairs(ADDON.Tool.Classes) do			
			ADDON.DB.Item[id].Solo[class]=ADDON.ClassListSolo[class]
			ADDON.DB.Item[id].Group[class]=ADDON.ClassListGroup[class]
			ADDON.DB.Item[id].Raid[class]=ADDON.ClassListRaid[class]
		end
		ADDON.DB.Item[id].UseNotFullStack=ADDON.ClassListSolo.UseNotFullStack
		
		print(ADDON.PREFIX,L.Saved, ADDON.DB.Item[id].name)
	end

end

local function OptionOpenMenu(self)
	if not ADDON.PopupDynamic:Wipe("Options") then
		return
	end
	ADDON.GetInventory()
	ADDON.PopupDynamic:AddItem(L.Stored,true)
	local list={}
	for id,item in pairs(ADDON.DB.Item) do
		tinsert(list,{ (item.icon and ("|T"..item.icon..T.."|t") or "").. item.name,id})		
	end
	table.sort(list,function(a,b) return a[1]<b[1] end)
	for i,x in ipairs(list) do
		ADDON.PopupDynamic:AddItem(x[1],false,OptionSelectedID,x[2])
	end
	
	ADDON.PopupDynamic:AddItem(L.Available,true)
	wipe (list)
	for id,item in pairs(ADDON.Inventory) do
		if not ADDON.DB.Item[id] and not item.collection then
			tinsert(list,{ (item.icon and ("|T"..item.icon..T.."|t") or "")..   item.name,id})		
		end
	end
	for itemCollection,spells in pairs(ADDON.SpellList) do
		if not ADDON.DB.Item[itemCollection] then
			tinsert(list,{L[itemCollection],itemCollection})			
		end
	end
	table.sort(list,function(a,b) return a[1]<b[1] end)
	for i,x in ipairs(list) do
		ADDON.PopupDynamic:AddItem(x[1],false,OptionSelectedID,x[2])
	end
	ADDON.PopupDynamic:Show(self or "cursor",0,0)
end

local function OptionClear()
	for i,class in ipairs(ADDON.Tool.Classes) do
		ADDON.ClassListSolo[class]=0
		ADDON.ClassListGroup[class]=0
		ADDON.ClassListRaid[class]=0
	end
	ADDON.Options.EditCategory(ADDON.OptionItemName,L.PlaceHolderSelect)
	
	ADDON.ClassListSolo.UseNotFullStack=false
		
	ADDON.OptionItemId=nil
	ADDON.OptionButSave:Disable()
	ADDON.OptionButRemove:Disable()
	ADDON.OptionsCboxUseNotFullStack:Show()
	
	ADDON.Options.DoCancel(ADDON.ClassListSolo) 
	ADDON.Options.DoCancel(ADDON.ClassListGroup)
	ADDON.Options.DoCancel(ADDON.ClassListRaid) 
	
end

local function OptionRemove()
	if ADDON.OptionItemId then
		print(ADDON.PREFIX,L.Removed, ADDON.DB.Item[ADDON.OptionItemId ].name)
		ADDON.DB.Item[ADDON.OptionItemId]=nil		
	end
	OptionClear()
end

function ADDON.OptionsInit()
	ADDON.Options.Init(
		function()--doOk
			ADDON.Options.DoOk() 
			OptionClear()
		end,
		function()--doCancel
			ADDON.Options.DoCancel() 
			OptionClear()
		end,
		function()--doDefault
			ADDON.Options.DoDefault() 
			OptionClear()
		end
	)
		
	ADDON.Options.AddPanel(ADDON.Title)
	ADDON.Options.AddVersion('|cff00c0ff' .. ADDON.Version .. "|r")
	
	ADDON.Options.AddCheckBox(ADDON.DB,"AutoFillSolo",true,L.cboxAutoFillSolo)
	ADDON.Options.AddCheckBox(ADDON.DB,"AutoFillGroup",true,L.cboxAutoFillGroup)
	ADDON.Options.AddCheckBox(ADDON.DB,"AutoFillRaid",true,L.cboxAutoFillRaid)
	ADDON.Options.AddSpace()
	ADDON.Options.AddCheckBox(ADDON.DB,"Locked",true,L.cboxLocked)
	ADDON.Options.AddSpace()
	ADDON.Options.AddButton(L.SelectItem,OptionOpenMenu)
	ADDON.Options.AddSpace()
	ADDON.OptionItemName=ADDON.Options.AddCategory(L.PlaceHolderSelect)
	
	ADDON.Options.Indent(10)
	ADDON.ClassListSolo={}
	ADDON.ClassListGroup={}
	ADDON.ClassListRaid={}
	
	ADDON.Options.AnchorRightSide()
	ADDON.Options.AddText(" ")		
	for i,class in ipairs(ADDON.Tool.Classes) do
		ADDON.Options.AddEditBox(ADDON.ClassListSolo,class,0,
			ADDON.Tool.IconClass[class] .. "|c" .. ADDON.Tool.ClassColor[class].colorStr .. ADDON.Tool.ClassName[class],
			20,150,true)			
	end
	
	ADDON.Options.SetRightSide(155)
	ADDON.Options.AddText(L.Solo)	
	
	ADDON.Options.SetRightSide(220)
	ADDON.Options.AddText(L.Group)	
	ADDON.Options.Indent(5)
	for i,class in ipairs(ADDON.Tool.Classes) do
		ADDON.Options.AddEditBox(ADDON.ClassListGroup,class,0,
			"",
			20,0,true)			
	end
	
	ADDON.Options.SetRightSide(285)
	ADDON.Options.AddText(L.Raid)	
	ADDON.Options.Indent(5)
	for i,class in ipairs(ADDON.Tool.Classes) do
		ADDON.Options.AddEditBox(ADDON.ClassListRaid,class,0,
			"",
			20,0,true)			
	end
		
	ADDON.Options.EndRightSide()
	ADDON.OptionsCboxUseNotFullStack=ADDON.Options.AddCheckBox(ADDON.ClassListSolo,"UseNotFullStack",false,L.cboxUseNotFullStack)
	
	ADDON.Options.AddSpace()
	ADDON.Options.InLine()
	ADDON.OptionButSave=ADDON.Options.AddButton(L.Save,OptionSave)
	ADDON.OptionButRemove=ADDON.Options.AddButton(L.Remove,OptionRemove)
	ADDON.Options.EndInLine()
	ADDON.Options.Indent(-10)
	
	local function SlashText(txt)
		ADDON.Options.AddText(txt)
	end
	ADDON.Options.AddPanel(L["PanelAbout"])

	ADDON.Options.AddCategory("|cFFFF1C1C"..GetAddOnMetadata(TOCNAME, "Title") .." ".. GetAddOnMetadata(TOCNAME, "Version") .." by "..GetAddOnMetadata(TOCNAME, "Author"))
	ADDON.Options.Indent(10)
	ADDON.Options.AddText(GetAddOnMetadata(TOCNAME, "Notes"))		
	ADDON.Options.Indent(-10)
	
	ADDON.Options.AddCategory(L["HeaderInfo"])
	ADDON.Options.Indent(10)
	ADDON.Options.AddText(L["AboutInfo"],-20)
	ADDON.Options.Indent(-10)
	
	ADDON.Options.AddCategory(L["HeaderUsage"])
	ADDON.Options.Indent(10)
	ADDON.Options.AddText(L["AboutUsage"],-20)
	ADDON.Options.Indent(-10)
	
	ADDON.Options.AddCategory(L["HeaderSlashCommand"])
	ADDON.Options.Indent(10)
	ADDON.Options.AddText(L["AboutSlashCommand"],-20)
	ADDON.Tool.PrintSlashCommand(nil,nil,SlashText)
	ADDON.Options.Indent(-10)
	
	if L["AboutCredits"]~="" then 
		ADDON.Options.AddCategory(L["HeaderCredits"])
		ADDON.Options.Indent(10)
		ADDON.Options.AddText(L["AboutCredits"],-20)
		ADDON.Options.Indent(-10)
	end
	
	
	
end


local function Event_BAG_UPDATE()
	if ADDON.TradeClass and ADDON.MissingStack then
		ADDON.FillTrade()
	end
end
local function Event_TRADE_SHOW()
	if InCombatLockdown() then
		return
	end

	ADDON.TradeName=GetUnitName("NPC")
	_,ADDON.TradeClass,_=UnitClass("NPC")
	ADDON.TradeLevel=UnitLevel("NPC")
	if ADDON.TradeLevel==nil or ADDON.TradeLevel==-1 then
		ADDON.TradeLevel=UnitLevel("player")+10
	end
	ADDON.TradeParty=UnitInParty("NPC") or UnitInRaid("NPC")
	
	ADDON.Frame:ShowParent(ADDON.TradeFrame)
	
	ADDON.ClearInventroy()
	
	if DEBUGMODE then
		print(ADDON.TradeName,ADDON.TradeClass, ADDON.TradeLevel,ADDON.TradeParty)
	end
	
	local x
	if ADDON.TradeParty then
		if IsInRaid() then
			x=ADDON.DB.AutoFillRaid
		else
			x=ADDON.DB.AutoFillGroup
		end
	else
		x=ADDON.DB.AutoFillSolo
	end
	
	ADDON.DontClear=true

	if x then 
		ADDON.FillTrade(false)	
	end
	
end
local function Event_TRADE_CLOSED()
	ADDON.TradeName=nil
	ADDON.TradeClass=nil
	ADDON.TradeLevel=nil
	ADDON.TradeParty=nil
	ADDON.ClearInventroy()
	ADDON.Frame:HideParent()
end

local function Event_ADDON_LOADED(arg1)--init!
	if arg1 == TOCNAME then
		if not WaterDispenserDB then WaterDispenserDB = {} end

		ADDON.DB=WaterDispenserDB
		
		--convert options
		if not WaterDispenserDB.Version or WaterDispenserDB.Version < 2 then
			--reset settings
			WaterDispenserDB.Version=2
			WaterDispenserDB.Item = {}	
			ADDON.DB.Item.MageWater={
				noRemove=true,
				Solo= {["HUNTER"] = 2,["WARRIOR"] = 0,["SHAMAN"] = 2,["MAGE"] = 0,["PRIEST"] = 2,["WARLOCK"] = 2,["DRUID"] = 2,["ROGUE"] = 0,["PALADIN"] = 2,},
				Group={["HUNTER"] = 3,["WARRIOR"] = 0,["SHAMAN"] = 3,["MAGE"] = 0,["PRIEST"] = 3,["WARLOCK"] = 3,["DRUID"] = 3,["ROGUE"] = 0,["PALADIN"] = 3,},
				Raid= {["HUNTER"] = 5,["WARRIOR"] = 0,["SHAMAN"] = 5,["MAGE"] = 0,["PRIEST"] = 5,["WARLOCK"] = 5,["DRUID"] = 5,["ROGUE"] = 0,["PALADIN"] = 5,},
				icon="Interface\\ICONS\\INV_Drink_18",
			}
			ADDON.DB.Item.MageFood={
				noRemove=true,
				Solo= {["HUNTER"] = 0,["WARRIOR"] = 1,["SHAMAN"] = 0,["MAGE"] = 0,["PRIEST"] = 0,["WARLOCK"] = 1,["DRUID"] = 0,["ROGUE"] = 1,["PALADIN"] = 0,},
				Group={["HUNTER"] = 0,["WARRIOR"] = 2,["SHAMAN"] = 0,["MAGE"] = 0,["PRIEST"] = 0,["WARLOCK"] = 2,["DRUID"] = 0,["ROGUE"] = 2,["PALADIN"] = 0,},
				Raid= {["HUNTER"] = 0,["WARRIOR"] = 2,["SHAMAN"] = 0,["MAGE"] = 0,["PRIEST"] = 0,["WARLOCK"] = 2,["DRUID"] = 0,["ROGUE"] = 2,["PALADIN"] = 0,},
				icon="Interface\\ICONS\\INV_Misc_Food_09",
			}			
		end
		if WaterDispenserDB.Version < 3 then
			WaterDispenserDB.Version=3
			ADDON.DB.Item.WarlockHealthstone={
				noRemove=true,
				Solo= {["HUNTER"] = 1,["WARRIOR"] = 1,["SHAMAN"] = 1,["MAGE"] = 1,["PRIEST"] = 1,["WARLOCK"] = 0,["DRUID"] = 1,["ROGUE"] = 1,["PALADIN"] = 1,},
				Group={["HUNTER"] = 1,["WARRIOR"] = 1,["SHAMAN"] = 1,["MAGE"] = 1,["PRIEST"] = 1,["WARLOCK"] = 0,["DRUID"] = 1,["ROGUE"] = 1,["PALADIN"] = 1,},
				Raid= {["HUNTER"] = 1,["WARRIOR"] = 1,["SHAMAN"] = 1,["MAGE"] = 1,["PRIEST"] = 1,["WARLOCK"] = 0,["DRUID"] = 1,["ROGUE"] = 1,["PALADIN"] = 1,},
				icon="Interface\\ICONS\\INV_Stone_04",
			}
			ADDON.DB.AutoFill=nil
		end
		
		--always update name!
		ADDON.DB.Item.MageWater.name=L.MageWater
		ADDON.DB.Item.MageFood.name=L.MageFood
		ADDON.DB.Item.WarlockHealthstone.name=L.WarlockHealthstone
		
		
		ADDON.PopupDynamic=ADDON.Tool.CreatePopup()
		
		local function doDBSet(DB,var,value)
			if value==nil then
				DB[var]= not DB[var]
			elseif tContains({"true","1","enable"},value) then
				DB[var]=true
			elseif tContains({"false","0","disable"},value) then
				DB[var]=false
			end
			print(ADDON.PREFIX,"Set "..var.." to "..tostring(DB[var]))
		end		
		
		ADDON.Tool.SlashCommand({"/wd","/waterdispenser"},{
			{"auto","",{
					{"solo",  "", {{"%",L.slashAutoFillSolo,doDBSet,ADDON.DB,"AutoFillSolo"}}},
					{"group", "", {{"%",L.slashAutoFillGroup,doDBSet,ADDON.DB,"AutoFillGroup"}}},
					{"raid",  "", {{"%",L.slashAutoFillRaid,doDBSet,ADDON.DB,"AutoFillRaid"}}},
				},
			},
			{"fill",L.slashFill,ADDON.FillTrade,true},
			{"about",L.slashAbout,ADDON.Options.Open,2},
			{{"config","setup","options"},L.slashConfig,ADDON.Options.Open,1},
		})
		
		ADDON.OptionsInit()		
				
		print("|cFFFF1C1C Loaded: "..GetAddOnMetadata(TOCNAME, "Title") .." ".. GetAddOnMetadata(TOCNAME, "Version") .." by "..GetAddOnMetadata(TOCNAME, "Author"))
	end
end
local function Event_PLAYER_REGEN_DISABLED()
	ADDON.Frame:HideParent()
end

local function Event_SPELLS_CHANGED()
	--make sure, that every item is known!
	if DEBUGMODE then print("GET ITEM IDS")	end	
	
	for id,repId in pairs(ADDON.CombineItemId) do
		GetItemInfo(id)
		GetItemInfo(repId)		
		if DEBUGMODE then print("combine:",id,repId)	end	
	end
	
	for typ,list in pairs(ADDON.SpellList) do
		for spellId,itemId in pairs(list) do
			GetItemInfo(itemId)
			if DEBUGMODE then print("spelllist:",itemId)	end	
		end
	end
	
	if ADDON and ADDON.DB and ADDON.DB.Item then 
		for id,list in pairs(ADDON.DB.Item) do
			local i=tonumber(id) or 0
			if i>0 then
				GetItemInfo(i)
				if DEBUGMODE then print("saved:",i)	end	
			end
		end
	end
	
	for bag=BACKPACK_CONTAINER , NUM_BAG_SLOTS do
		for slot=1,GetContainerNumSlots(bag) do
			local itemID = GetContainerItemID(bag,slot)
			if itemID then 
				GetItemInfo(itemID)
				if DEBUGMODE then print("bag:",itemID)	end	
			end
		end
	end
	
	
end

ADDON.Tool.RegisterEvent("ADDON_LOADED",Event_ADDON_LOADED)
ADDON.Tool.RegisterEvent("TRADE_SHOW",Event_TRADE_SHOW)
ADDON.Tool.RegisterEvent("TRADE_CLOSED",Event_TRADE_CLOSED)
ADDON.Tool.RegisterEvent("BAG_UPDATE",Event_BAG_UPDATE)
ADDON.Tool.RegisterEvent("PLAYER_REGEN_DISABLED",Event_PLAYER_REGEN_DISABLED)
ADDON.Tool.RegisterEvent("SPELLS_CHANGED",Event_SPELLS_CHANGED)
ADDON.Tool.RegisterEvent("LEARNED_SPELL_IN_TAB",Event_SPELLS_CHANGED)



local function _setSpell(self,id)
	local name, _, _, _, _, _, _ = GetSpellInfo(id)
	local rank=GetSpellSubtext(id)
	if rank~=nil and rank~="" then
		rank="("..rank..")"
	else
		rank=""
	end
	self:SetAttribute("type","macro")
	self:SetAttribute("macrotext","/cast "..name..rank)
	self:SetText(name..rank)
	self:SetWidth( self:GetTextWidth()+20 )
	self:Show()
end
local function BtnCreate(frame,text,func,anchorFrame,anchorPos,x,y,secure)
	button=CreateFrame("Button", nil, frame, secure and "UIPanelButtonTemplate,SecureActionButtonTemplate" or "UIPanelButtonTemplate"  )
	button:SetText(text)
	button:SetWidth( button:GetTextWidth()+20 )
	
	button:SetPoint("TOPLEFT",anchorFrame,anchorPos,x or 0,y or 0)
	
	if secure then 
		button:SetAttribute("type","macro")
		button:SetAttribute("macrotext","/script print(1)")
		button.SetSpell=_setSpell
	else
		button:SetScript("OnClick", func)
	end
	
	return button
end

function ADDON.CreateTradeButtonsFrame()
	local frame = CreateFrame("Frame", nil, UIParent)
	--[[frame:SetBackdrop({
        bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
        tile = true,        
    })
	--]]
	
	frame:EnableMouse(false)
	frame:SetPoint("CENTER")
	frame:SetSize(400, 200)
	
	frame.BtnClear=BtnCreate(frame,L.ClearTrade,ADDON.ClearTrade,frame,"TOPLEFT")
	frame.BtnFill=BtnCreate(frame,L.FillTrade,function() ADDON.FillTrade(true) end, frame.BtnClear,"BOTTOMLEFT")
	frame.BtnConfig=BtnCreate(frame,L.Config,function() ADDON.Options.Open(1) end, frame.BtnFill,"BOTTOMLEFT")
	frame.BtnAccept=BtnCreate(frame,L.AcceptTrade, AcceptTrade, frame.BtnConfig,"BOTTOMLEFT",0,-5)
	frame.BtnSpell1=BtnCreate(frame," ", nil, frame.BtnAccept,"BOTTOMLEFT",0,-5, true)
	frame.BtnSpell2=BtnCreate(frame," ", nil, frame.BtnSpell1,"BOTTOMLEFT",0,0, true)
	frame.BtnSpell3=BtnCreate(frame," ", nil, frame.BtnSpell2,"BOTTOMLEFT",0,0, true)
	
	frame.Btn={}
	frame.Btn.MageWater=frame.BtnSpell1
	frame.Btn.MageFood=frame.BtnSpell2	
	frame.Btn.WarlockHealthstone=frame.BtnSpell3
	frame.Btn.PickLock=frame.BtnSpell3
	frame:Hide()
	
	function frame:ShowParent(parent)
		self:SetParent(parent)
		self:ClearAllPoints()
		self:SetPoint("TOPLEFT",parent,"TOPRIGHT")
		self:Show()
		self.BtnSpell1:Hide()
		self.BtnSpell2:Hide()
		self.BtnSpell3:Hide()
	end
	function frame:HideParent()
		self:SetParent(UIParent)
		self:Hide()
	end
	return frame
end

ADDON.Frame=ADDON.CreateTradeButtonsFrame()
ADDON.TradeFrame=TradeFrame


if DEBUGMODE then
	--demo-code
	ADDON.Tool.RegisterEvent("MERCHANT_SHOW",Event_TRADE_SHOW)
	ADDON.Tool.RegisterEvent("MERCHANT_CLOSED",Event_TRADE_CLOSED)
	ADDON.TradeFrame=MerchantFrame
end