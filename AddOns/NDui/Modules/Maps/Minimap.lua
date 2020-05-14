﻿local _, ns = ...
local B, C, L, DB = unpack(ns)
local module = B:GetModule("Maps")

local strmatch, strfind, strupper = string.match, string.find, string.upper
local select, pairs, ipairs, unpack = select, pairs, ipairs, unpack
local IsPlayerSpell, GetSpellInfo, GetSpellTexture = IsPlayerSpell, GetSpellInfo, GetSpellTexture
local CastSpellByID, GetTrackingTexture = CastSpellByID, GetTrackingTexture
local cr, cg, cb = DB.r, DB.g, DB.b

function module:CreatePulse()
	if not NDuiDB["Map"]["CombatPulse"] then return end

	local MBG = B.CreateBG(Minimap, 1)
	B.CreateSD(MBG)
	local anim = MBG:CreateAnimationGroup()
	anim:SetLooping("BOUNCE")
	anim.fader = anim:CreateAnimation("Alpha")
	anim.fader:SetFromAlpha(.8)
	anim.fader:SetToAlpha(.2)
	anim.fader:SetDuration(1)
	anim.fader:SetSmoothing("OUT")

	local function updateMinimapAnim(event)
		if event == "PLAYER_REGEN_DISABLED" then
			MBG.Shadow:SetBackdropBorderColor(1, 0, 0)
			anim:Play()
		elseif not InCombatLockdown() then
			if MiniMapMailFrame:IsShown() then
				MBG.Shadow:SetBackdropBorderColor(1, 1, 0)
				anim:Play()
			else
				anim:Stop()
				MBG.Shadow:SetBackdropBorderColor(0, 0, 0)
			end
		end
	end
	B:RegisterEvent("PLAYER_REGEN_ENABLED", updateMinimapAnim)
	B:RegisterEvent("PLAYER_REGEN_DISABLED", updateMinimapAnim)
	B:RegisterEvent("UPDATE_PENDING_MAIL", updateMinimapAnim)

	MiniMapMailFrame:HookScript("OnHide", function()
		if InCombatLockdown() then return end
		anim:Stop()
		MBG.Shadow:SetBackdropBorderColor(0, 0, 0)
	end)
end

function module:ReskinRegions()
	-- Tracking icon
	MiniMapTrackingFrame:SetScale(.7)
	MiniMapTrackingFrame:ClearAllPoints()
	MiniMapTrackingFrame:SetPoint("BOTTOMRIGHT", Minimap, -5, 5)
	MiniMapTrackingBorder:Hide()
	MiniMapTrackingIcon:SetTexCoord(unpack(DB.TexCoord))
	local bg = B.CreateBG(MiniMapTrackingIcon)
	B.CreateBD(bg)
	bg:SetBackdropBorderColor(cr, cg, cb)

	-- Mail icon
	MiniMapMailFrame:ClearAllPoints()
	MiniMapMailFrame:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -3, 3)
	MiniMapMailIcon:SetTexture(DB.mailTex)
	MiniMapMailIcon:SetSize(21, 21)
	MiniMapMailIcon:SetVertexColor(1, 1, 0)

	-- Battlefield
	MiniMapBattlefieldFrame:ClearAllPoints()
	MiniMapBattlefieldFrame:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", -5, -5)
	MiniMapBattlefieldBorder:Hide()
	MiniMapBattlefieldIcon:SetAlpha(0)
	BattlegroundShine:SetTexture(nil)

	local queueIcon = Minimap:CreateTexture(nil, "ARTWORK")
	queueIcon:SetPoint("CENTER", MiniMapBattlefieldFrame)
	queueIcon:SetSize(50, 50)
	queueIcon:SetTexture(DB.eyeTex)
	queueIcon:Hide()
	local anim = queueIcon:CreateAnimationGroup()
	anim:SetLooping("REPEAT")
	anim.rota = anim:CreateAnimation("Rotation")
	anim.rota:SetDuration(2)
	anim.rota:SetDegrees(360)

	hooksecurefunc("BattlefieldFrame_UpdateStatus", function()
		queueIcon:SetShown(MiniMapBattlefieldFrame:IsShown())

		anim:Play()
		for i = 1, MAX_BATTLEFIELD_QUEUES do
			local status = GetBattlefieldStatus(i)
			if status == "confirm" then
				anim:Stop()
				break
			end
		end
	end)
end

function module:RecycleBin()
	if not NDuiDB["Map"]["ShowRecycleBin"] then return end

	local buttons = {}
	local blackList = {
		["GameTimeFrame"] = true,
		["MiniMapLFGFrame"] = true,
		["BattlefieldMinimap"] = true,
		["MinimapBackdrop"] = true,
		["TimeManagerClockButton"] = true,
		["FeedbackUIButton"] = true,
		["HelpOpenTicketButton"] = true,
		["MiniMapBattlefieldFrame"] = true,
		["QueueStatusMinimapButton"] = true,
		["GarrisonLandingPageMinimapButton"] = true,
		["MinimapZoneTextButton"] = true,
		["RecycleBinFrame"] = true,
		["RecycleBinToggleButton"] = true,
	}

	local bu = CreateFrame("Button", "RecycleBinToggleButton", Minimap)
	bu:SetSize(24, 24)
	bu:SetPoint("BOTTOMLEFT", -15, -15)
	bu.Icon = bu:CreateTexture(nil, "ARTWORK")
	bu.Icon:SetAllPoints()
	bu.Icon:SetTexture(DB.binTex)
	bu:SetHighlightTexture(DB.binTex)
	B.AddTooltip(bu, "ANCHOR_LEFT", L["Minimap RecycleBin"], "white")

	local bin = CreateFrame("Frame", "RecycleBinFrame", UIParent)
	bin:SetPoint("RIGHT", bu, "LEFT", -3, -6)
	bin:Hide()
	B.CreateGF(bin, 220, 40, "Horizontal", 0, 0, 0, 0, .7)
	local topLine = CreateFrame("Frame", nil, bin)
	topLine:SetPoint("BOTTOMRIGHT", bin, "TOPRIGHT", 1, 0)
	B.CreateGF(topLine, 220, 1, "Horizontal", cr, cg, cb, 0, .7)
	local bottomLine = CreateFrame("Frame", nil, bin)
	bottomLine:SetPoint("TOPRIGHT", bin, "BOTTOMRIGHT", 1, 0)
	B.CreateGF(bottomLine, 220, 1, "Horizontal", cr, cg, cb, 0, .7)
	local rightLine = CreateFrame("Frame", nil, bin)
	rightLine:SetPoint("LEFT", bin, "RIGHT", 0, 0)
	B.CreateGF(rightLine, 1, 40, "Vertical", cr, cg, cb, .7, .7)
	bin:SetFrameStrata("LOW")

	local function hideBinButton()
		bin:Hide()
	end
	local function clickFunc()
		UIFrameFadeOut(bin, .5, 1, 0)
		C_Timer.After(.5, hideBinButton)
	end

	local secureAddons = {
		["HANDYNOTESPIN"] = true,
		["GATHERMATEPIN"] = true,
		["GUIDELIME"] = true,
		["TRACKINGEYE"] = true,
	}

	local function isButtonSecure(name)
		name = strupper(name)
		for addonName in pairs(secureAddons) do
			if strmatch(name, addonName) then
				return true
			end
		end
	end

	local isCollecting

	local function CollectRubbish()
		if isCollecting then return end
		isCollecting = true

		for _, child in ipairs({Minimap:GetChildren()}) do
			local name = child:GetName()
			if name and not blackList[name] and not isButtonSecure(name) then
				if child:GetObjectType() == "Button" or strmatch(strupper(name), "BUTTON") then
					child:SetParent(bin)
					child:SetSize(34, 34)
					for j = 1, child:GetNumRegions() do
						local region = select(j, child:GetRegions())
						if region:GetObjectType() == "Texture" then
							local texture = region:GetTexture() or ""
							if strfind(texture, "Interface\\CharacterFrame") or strfind(texture, "Interface\\Minimap") then
								region:SetTexture(nil)
							elseif texture == 136430 or texture == 136467 then
								region:SetTexture(nil)
							end
							region:ClearAllPoints()
							region:SetAllPoints()
							region:SetTexCoord(unpack(DB.TexCoord))
						end
					end

					if child:HasScript("OnDragStart") then child:SetScript("OnDragStart", nil) end
					if child:HasScript("OnDragStop") then child:SetScript("OnDragStop", nil) end
					--if child:HasScript("OnClick") then child:HookScript("OnClick", clickFunc) end

					if child:GetObjectType() == "Button" then
						child:SetHighlightTexture(DB.bdTex) -- prevent nil function
						child:GetHighlightTexture():SetColorTexture(1, 1, 1, .25)
					elseif child:GetObjectType() == "Frame" then
						child.highlight = child:CreateTexture(nil, "HIGHLIGHT")
						child.highlight:SetAllPoints()
						child.highlight:SetColorTexture(1, 1, 1, .25)
					end
					B.CreateSD(child, 3, 3)

					-- Naughty Addons
					if name == "DBMMinimapButton" then
						child:SetScript("OnMouseDown", nil)
						child:SetScript("OnMouseUp", nil)
					--elseif name == "BagSync_MinimapButton" then
					--	child:HookScript("OnMouseUp", clickFunc)
					end

					tinsert(buttons, child)
				end
			end
		end

		isCollecting = nil
	end

	local function SortRubbish()
		if #buttons == 0 then return end
		local lastbutton
		for _, button in pairs(buttons) do
			if next(button) and button:IsShown() then -- fix for fuxking AHDB
				button:ClearAllPoints()
				if not lastbutton then
					button:SetPoint("RIGHT", bin, -3, 0)
				else
					button:SetPoint("RIGHT", lastbutton, "LEFT", -3, 0)
				end
				lastbutton = button
			end
		end
	end

	bu:SetScript("OnClick", function()
		SortRubbish()
		if bin:IsShown() then
			clickFunc()
		else
			UIFrameFadeIn(bin, .5, 0, 1)
		end
	end)

	C_Timer.After(.3, function()
		CollectRubbish()
		SortRubbish()
	end)
end

function module:WhoPingsMyMap()
	if not NDuiDB["Map"]["WhoPings"] then return end

	local f = CreateFrame("Frame", nil, Minimap)
	f:SetAllPoints()
	f.text = B.CreateFS(f, 12, "", false, "TOP", 0, -3)

	local anim = f:CreateAnimationGroup()
	anim:SetScript("OnPlay", function() f:SetAlpha(1) end)
	anim:SetScript("OnFinished", function() f:SetAlpha(0) end)
	anim.fader = anim:CreateAnimation("Alpha")
	anim.fader:SetFromAlpha(1)
	anim.fader:SetToAlpha(0)
	anim.fader:SetDuration(3)
	anim.fader:SetSmoothing("OUT")
	anim.fader:SetStartDelay(3)

	B:RegisterEvent("MINIMAP_PING", function(_, unit)
		local class = select(2, UnitClass(unit))
		local r, g, b = B.ClassColor(class)
		local name = GetUnitName(unit)

		anim:Stop()
		f.text:SetText(name)
		f.text:SetTextColor(r, g, b)
		anim:Play()
	end)
end

function module:UpdateMinimapScale()
	local scale = NDuiDB["Map"]["MinmapScale"]
	Minimap:SetScale(scale)
	Minimap.mover:SetSize(Minimap:GetWidth()*scale, Minimap:GetHeight()*scale)
end

function module:ShowMinimapClock()
	if NDuiDB["Map"]["Clock"] then
		if not TimeManagerClockButton then LoadAddOn("Blizzard_TimeManager") end
		if not TimeManagerClockButton.styled then
			TimeManagerClockButton:DisableDrawLayer("BORDER")
			TimeManagerClockButton:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, -8)
			TimeManagerClockTicker:SetFont(unpack(DB.Font))
			TimeManagerClockTicker:SetTextColor(1, 1, 1)

			TimeManagerClockButton.styled = true
		end
		TimeManagerClockButton:Show()
	else
		if TimeManagerClockButton then TimeManagerClockButton:Hide() end
	end
end

function module:TrackMenu_SetText(spellID)
	local name = GetSpellInfo(spellID)
	local texture = GetSpellTexture(spellID) or 136243
	name = " |T"..texture..":12:12:0:0:50:50:4:46:4:46|t "..name
	return name
end

function module:TrackMenu_OnClick(spellID)
	CastSpellByID(spellID)
end

function module:TrackMenu_CheckStatus()
	local texture = GetSpellTexture(self.arg1)
	if texture == GetTrackingTexture() then
		return true
	end
end

function module:EasyTrackMenu()
	local trackSpells = {
		2383,	--Find Herbs
		2580,	--Find Minerals
		2481,	--Find Treasure
		1494,	--Track Beasts
		19883,	--Track Humanoids
		19884,	--Track Undead
		19885,	--Track Hidden
		19880,	--Track Elementals
		19878,	--Track Demons
		19882,	--Track Giants
		19879,	--Track Dragonkin
		5225,	--Track Humanoids: Druid
		5500,	--Sense Demons
		5502,	--Sense Undead
	}

	local menuFrame = CreateFrame("Frame", "NDui_EasyTrackMenu", UIParent, "UIDropDownMenuTemplate")
	menuFrame:SetFrameStrata("TOOLTIP")
	menuFrame:Hide()
	local menuList = {
		[1] = {text = L["TrackMenu"], isTitle = true, notCheckable = true},
	}

	local function updateMenuList()
		for i = 2, #menuList do
			if menuList[i] then wipe(menuList[i]) end
		end

		local index = 2
		for _, spellID in pairs(trackSpells) do
			if IsPlayerSpell(spellID) then
				if not menuList[index] then menuList[index] = {} end
				menuList[index].arg1 = spellID
				menuList[index].text = module:TrackMenu_SetText(spellID)
				menuList[index].func = module.TrackMenu_OnClick
				menuList[index].checked = module.TrackMenu_CheckStatus

				index = index + 1
			end
		end

		return index
	end

	local function toggleTrackMenu(self)
		if DropDownList1:IsShown() then
			DropDownList1:Hide()
		else
			local index = updateMenuList()
			if index > 2 then
				local offset = self:GetWidth()*self:GetScale()*.5
				EasyMenu(menuList, menuFrame, self, -offset, offset, "MENU")
			end
		end
	end

	-- Click Func
	Minimap:SetScript("OnMouseUp", function(self, btn)
		if btn == "RightButton" then
			toggleTrackMenu(self)
		else
			Minimap_OnClick(self)
		end
	end)
end

function module:SetupMinimap()
	-- Shape and Position
	local scale = NDuiDB["Map"]["MinmapScale"]
	Minimap:SetFrameLevel(10)
	Minimap:SetMaskTexture("Interface\\Buttons\\WHITE8X8")
	DropDownList1:SetClampedToScreen(true)

	local mover = B.Mover(Minimap, L["Minimap"], "Minimap", C.Minimap.Pos)
	Minimap:ClearAllPoints()
	Minimap:SetPoint("TOPRIGHT", mover)
	Minimap.mover = mover

	self:UpdateMinimapScale()
	self:ShowMinimapClock()

	-- Mousewheel Zoom
	Minimap:EnableMouseWheel(true)
	Minimap:SetScript("OnMouseWheel", function(_, zoom)
		if zoom > 0 then
			Minimap_ZoomIn()
		else
			Minimap_ZoomOut()
		end
	end)

	-- Hide Blizz
	local frames = {
		"MinimapBorderTop",
		"MinimapNorthTag",
		"MinimapBorder",
		"MinimapZoneTextButton",
		"MinimapZoomOut",
		"MinimapZoomIn",
		"MiniMapWorldMapButton",
		"MiniMapMailBorder",
		"MinimapToggleButton",
		"GameTimeFrame",
	}

	for _, v in pairs(frames) do
		B.HideObject(_G[v])
	end
	MinimapCluster:EnableMouse(false)

	-- Add Elements
	self:CreatePulse()
	self:ReskinRegions()
	self:RecycleBin()
	self:WhoPingsMyMap()
	self:EasyTrackMenu()

	if LibDBIcon10_TownsfolkTracker then
		LibDBIcon10_TownsfolkTracker:DisableDrawLayer("OVERLAY")
		LibDBIcon10_TownsfolkTracker:DisableDrawLayer("BACKGROUND")
	end
end