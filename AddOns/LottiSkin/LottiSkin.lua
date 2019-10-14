print("|r--|Cff81d8cfLotti Skin 已载入|r--")

-- 毛绒绒边框
CreateSD = function(ff, m, s)
	if ff.Shadow then return end
	local frame = ff
	if ff:GetObjectType() == "Texture" then frame = ff:GetParent() end
	local lvl = frame:GetFrameLevel()

	ff.Shadow = CreateFrame("Frame", nil, frame)
	ff.Shadow:SetPoint("TOPLEFT", ff, -m, m)
	ff.Shadow:SetPoint("BOTTOMRIGHT", ff, m, -m)
	ff.Shadow:SetBackdrop({
		edgeFile = [[Interface\AddOns\LottiSkin\media\glow]], edgeSize = 3 })
	ff.Shadow:SetBackdropBorderColor(0, 0, 0, 1)
	ff.Shadow:SetFrameLevel(lvl == 0 and 1 or lvl - 1)
	return ff.Shadow
end

-- Create Background
CreateBG = function(f, m)
	local frame = f
	if f:GetObjectType() == "Texture" then frame = f:GetParent() end
	local offset = m
	if not m then offset = 1.2 end
	local lvl = frame:GetFrameLevel()

	local bg = CreateFrame("Frame", nil, frame)
	bg:SetPoint("TOPLEFT", f, -offset, offset)
	bg:SetPoint("BOTTOMRIGHT", f, offset, -offset)
	bg:SetFrameLevel(lvl == 0 and 1 or lvl - 1)
	return bg
end

CreateBD = function(f, a, s)
	f:SetBackdrop({
		bgFile = [[Interface\AddOns\LottiSkin\media\statusbar]], edgeFile = [[Interface\AddOns\LottiSkin\media\glow]], edgeSize = s or 3,
		insets = {left = s or 3, right = s or 3, top = s or 3, bottom = s or 3},
	})
	f:SetBackdropColor(0, 0, 0, a or .5)
	f:SetBackdropBorderColor(0, 0, 0)
end

-- Create Skin
CreateTex = function(f)
	if f.Tex then return end
	local frame = f
	if f:GetObjectType() == "Texture" then frame = f:GetParent() end

	f.Tex = frame:CreateTexture(nil, "BACKGROUND", nil, 1)
	f.Tex:SetAllPoints()
	f.Tex:SetTexture([[Interface\AddOns\LottiSkin\media\glow]], true, true)
	f.Tex:SetHorizTile(true)
	f.Tex:SetVertTile(true)
	f.Tex:SetBlendMode("ADD")
end

CreateButton = function(parent, width, height, text, fontSize)
	local bu = CreateFrame("Button", nil, parent)
	bu:SetSize(width, height)
	CreateBD(bu, .3)
	CreateBC(bu)
	CreateFS(bu, fontSize or 14, text, true)

	return bu
end

-- Frame Text
CreateFS = function(f, size, ttext, classcolor, anchor, x, y)
	local fs = f:CreateFontString(nil, "OVERLAY")
	fs:SetFont(STANDARD_TEXT_FONT, size, "OUTLINE")
	fs:SetText(ttext)
	fs:SetWordWrap(false)
	if classcolor then
		fs:SetTextColor(cr, cg, cb)
	end
	if anchor and x and y then
		fs:SetPoint(anchor, x, y)
	else
		fs:SetPoint("CENTER", 1, 0)
	end
	return fs
end


-- Button Color
CreateBC = function(f, a)
	f:SetNormalTexture("")
	f:SetHighlightTexture("")
	f:SetPushedTexture("")
	f:SetDisabledTexture("")

	if f.Left then f.Left:SetAlpha(0) end
	if f.Middle then f.Middle:SetAlpha(0) end
	if f.Right then f.Right:SetAlpha(0) end
	if f.LeftSeparator then f.LeftSeparator:Hide() end
	if f.RightSeparator then f.RightSeparator:Hide() end

	f:SetScript("OnEnter", function()
		f:SetBackdropBorderColor(cr, cg, cb, 1)
	end)
	f:SetScript("OnLeave", function()
		f:SetBackdropBorderColor(0, 0, 0, 1)
	end)
	f:SetScript("OnMouseDown", function()
		f:SetBackdropColor(cr, cg, cb, a or .3)
	end)
	f:SetScript("OnMouseUp", function()
		f:SetBackdropColor(0, 0, 0, a or .3)
	end)
end