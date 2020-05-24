local _, ns = ...
local B, C, L, DB = unpack(ns)

tinsert(C.defaultThemes, function()
	TradePlayerEnchantInset:Hide()
	TradePlayerItemsInset:Hide()
	TradeRecipientEnchantInset:Hide()
	TradeRecipientItemsInset:Hide()
	TradePlayerInputMoneyInset:Hide()
	TradeRecipientMoneyInset:Hide()
	TradeRecipientBG:Hide()
	TradeRecipientMoneyBg:Hide()
	TradeRecipientBotLeftCorner:Hide()
	TradeRecipientLeftBorder:Hide()
	select(4, TradePlayerItem7:GetRegions()):Hide()
	select(4, TradeRecipientItem7:GetRegions()):Hide()

	B.ReskinPortraitFrame(TradeFrame)
	B.Reskin(TradeFrameTradeButton)
	B.Reskin(TradeFrameCancelButton)

	B.ReskinInput(TradePlayerInputMoneyFrameGold)
	B.ReskinInput(TradePlayerInputMoneyFrameSilver)
	TradePlayerInputMoneyFrameSilver.bg:SetPoint("BOTTOMRIGHT", -10, 0)
	B.ReskinInput(TradePlayerInputMoneyFrameCopper)
	TradePlayerInputMoneyFrameCopper.bg:SetPoint("BOTTOMRIGHT", -10, 0)
	TradePlayerInputMoneyFrameSilver:SetPoint("LEFT", TradePlayerInputMoneyFrameGold, "RIGHT", 18, 0)
	TradePlayerInputMoneyFrameCopper:SetPoint("LEFT", TradePlayerInputMoneyFrameSilver, "RIGHT", 8, 0)

	local function reskinButton(bu)
		bu:SetNormalTexture("")
		bu:SetPushedTexture("")
		bu.icon:SetTexCoord(.08, .92, .08, .92)
		bu.IconBorder:SetAlpha(0)
		bu:GetHighlightTexture():SetColorTexture(1, 1, 1, .25)
		B.CreateBDFrame(bu, .25)
	end

	for i = 1, MAX_TRADE_ITEMS do
		_G["TradePlayerItem"..i.."SlotTexture"]:Hide()
		_G["TradePlayerItem"..i.."NameFrame"]:Hide()
		_G["TradeRecipientItem"..i.."SlotTexture"]:Hide()
		_G["TradeRecipientItem"..i.."NameFrame"]:Hide()

		reskinButton(_G["TradePlayerItem"..i.."ItemButton"])
		reskinButton(_G["TradeRecipientItem"..i.."ItemButton"])
	end
end)