
local myname, ns = ...

local NUMROWS, NUMCOLS, ICONSIZE, ICONGAP, GAP, EDGEGAP = 9, 10, 32, 3, 8, 16
local tekcheck = LibStub("tekKonfig-Checkbox")
local rows, offset, scrollbar, tradeview, grouptext = {}, 0
local _, myclass = UnitClass('player')


if AddonLoader and AddonLoader.RemoveInterfaceOptions then AddonLoader:RemoveInterfaceOptions("Steal Your Carbon") end

local frame = CreateFrame("Frame", "StealYourCarbonConfig", InterfaceOptionsFramePanelContainer)
frame.name = "Steal Your Carbon"
frame:SetScript("OnShow", function(frame)
	local StealYourCarbon = StealYourCarbon
	local title, subtitle = LibStub("tekKonfig-Heading").new(frame, "Steal Your Carbon", "若要添加物品，请将其拖放到下面的框架中或者输入 '/carbon add [物品链接] 20'.Shift-左键箭头添加/移除一组.将数量设置为0以删除物品.")


	local liquid = myclass == 'MONK' and "brew" or "water"
	local upgradewater = tekcheck.new(frame, nil, "更新 "..liquid, "TOPLEFT", subtitle, "BOTTOMLEFT", -2, -GAP)
	local checksound = upgradewater:GetScript("OnClick")
	upgradewater.tiptext = "自动升级到更好的 "..liquid.."(基于你的等级)"
	upgradewater:SetScript("OnClick", function(self) checksound(self); StealYourCarbon.db.upgradewater = not StealYourCarbon.db.upgradewater end)
	upgradewater:SetChecked(StealYourCarbon.db.upgradewater)


	local chatter = tekcheck.new(frame, nil, "聊天框反馈", "TOP", upgradewater, "TOP")
	chatter:SetPoint("LEFT", frame, "TOP", GAP, 0)
	chatter.tiptext = "购买物品时提供聊天反馈."
	chatter:SetScript("OnClick", function(self) checksound(self); StealYourCarbon.db.chatter = not StealYourCarbon.db.chatter end)
	chatter:SetChecked(StealYourCarbon.db.chatter)


	local group = ns.GenerateRestockPanel(frame)
	group:SetPoint("TOP", upgradewater, "BOTTOM", 0, -EDGEGAP-GAP)
	group:SetPoint("LEFT", EDGEGAP, 0)
	group:SetPoint("BOTTOMRIGHT", frame, "BOTTOM", -EDGEGAP/4, EDGEGAP)


	local bags = ns.GenerateBagsPanel(frame)
	bags:SetPoint("TOP", upgradewater, "BOTTOM", 0, -EDGEGAP-GAP)
	bags:SetPoint("LEFT", frame, "CENTER", EDGEGAP/4, 0)
	bags:SetPoint("BOTTOMRIGHT", -EDGEGAP, EDGEGAP)

	ns.UpdateConfigList()
	frame:SetScript("OnShow", nil)
end)


StealYourCarbon.configframe = frame
InterfaceOptions_AddCategory(frame)


LibStub("tekKonfig-AboutPanel").new("Steal Your Carbon", "StealYourCarbon")


local orig = IsOptionFrameOpen
function IsOptionFrameOpen(...)
	if not frame:IsVisible() then return orig(...) end
end
