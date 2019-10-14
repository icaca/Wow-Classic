-- 修改自 nibRealUI_BossSkins , AltzUI 感谢原作者
local NAME, addon = ...

local F = CreateFrame("Frame")
local function registerBWStyle()
--    if not BigWigs or not aCoreCDB["SkinOptions"]["setBW"] then return end
    local bars = BigWigs:GetPlugin("Bars", true)
    if not bars then return end
--    local fontName, fontSize, fontArgs = LottiSkinFont:GetFont()

    -- based on MonoUI style
    local backdropBorder = {
        bgFile = [[Interface\AddOns\LottiSkin\media\statusbar]], --进度条材质
        edgeFile = [[Interface\AddOns\LottiSkin\media\glow]],  --毛绒绒边框材质
        tile = false, tileSize = 0, edgeSize = 3,
        insets = {left = 3, right = 3, top = 3, bottom = 3}
    }

    local function styleBar(bar)
        --print("styleBar", bar)
        bar:SetHeight(10)
        bar.candyBarBackground:Hide()

        local bd = bar.candyBarBackdrop
        bd:SetBackdrop(backdropBorder)
        bd:SetBackdropColor(0, 0, 0, 0.5)
        bd:SetBackdropBorderColor(0, 0, 0, 1)

        bd:ClearAllPoints()
        bd:SetPoint("TOPLEFT", bar, "TOPLEFT", -3, 3)
        bd:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", 3, -3)
        bd:Show()

        if bars.db.profile.icon then
            local icon = bar.candyBarIconFrame
            local tex = icon.icon
            bar:SetIcon(nil)
            icon:SetTexture(tex)
            icon:ClearAllPoints()
            icon:SetPoint("BOTTOMRIGHT", bar, "BOTTOMLEFT", -4, 0)
            icon:SetSize(24, 24)
            icon:Show() -- XXX temp
            bar:Set("bigwigs:restoreIcon", tex)

            local iconBd = bar.candyBarIconFrameBackdrop
            iconBd:SetBackdrop(backdropBorder)
            iconBd:SetBackdropColor(0, 0, 0, 0.5)
            iconBd:SetBackdropBorderColor(0, 0, 0, 1)

            iconBd:ClearAllPoints()
            iconBd:SetPoint("TOPLEFT", icon, "TOPLEFT", -3, 3)
            iconBd:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 3, -3)
            iconBd:Show()
        end

        local label = bar.candyBarLabel
        local font = label:GetFontObject() or {label:GetFont()}
        bar:Set("bigwigs:restoreFont", font)
        local shadow = {label:GetShadowOffset()}
        bar:Set("bigwigs:restoreShadow", shadow)

--       label:SetFont(fontName, fontSize, fontArgs)
        label:SetShadowOffset(0, 0)
        label:SetJustifyH("LEFT")
        label:SetJustifyV("BOTTOM")
        label:ClearAllPoints()
        label:SetPoint("BOTTOMLEFT", bar, "TOPLEFT", 4, -5)
        label:SetPoint("TOPRIGHT", bar, "TOPRIGHT", -25, 20)

        local timer = bar.candyBarDuration
--        timer:SetFont(fontName, fontSize, fontArgs)
        timer:SetShadowOffset(0, 0)
        timer:SetJustifyH("RIGHT")
        timer:ClearAllPoints()
        timer:SetPoint("BOTTOMRIGHT", bar, "TOPRIGHT", -4, -5)

        bar:SetTexture([[Interface\AddOns\LottiSkin\media\statusbar]])
    end

    local function removeStyle(bar)
        bar:SetHeight(14)
        bar.candyBarBackdrop:Hide()
        bar.candyBarBackground:Show()

        local tex = bar:Get("bigwigs:restoreIcon")
        if tex then
            local icon = bar.candyBarIconFrame
            icon:ClearAllPoints()
            icon:SetPoint("TOPLEFT")
            icon:SetPoint("BOTTOMLEFT")
            bar:SetIcon(tex)

            bar.candyBarIconFrameBackdrop:Hide()
        end

        local shadow = bar:Get("bigwigs:restoreShadow")
        local label = bar.candyBarLabel
        label:SetShadowOffset(shadow[1], shadow[2])
        label:ClearAllPoints()
        label:SetPoint("TOPLEFT", bar.candyBarBar, "TOPLEFT", 2, 0)
        label:SetPoint("BOTTOMRIGHT", bar.candyBarBar, "BOTTOMRIGHT", -2, 0)

        local timer = bar.candyBarDuration
        timer:SetShadowOffset(shadow[1], shadow[2])
        timer:ClearAllPoints()
        timer:SetPoint("RIGHT", bar.candyBarBar, "RIGHT", -2, 0)

        local font = bar:Get("bigwigs:restoreFont")
        if type(font) == "table" and font[1] then
            label:SetFont(font[1], floor(font[2] + 0.5), font[3])
            timer:SetFont(font[1], floor(font[2] + 0.5), font[3])
        else
            label:SetFontObject(font)
            timer:SetFontObject(font)
        end
    end

    bars:RegisterBarStyle("LottiSkin", {
        apiVersion = 1,
        version = 1,
        GetSpacing = function(bar) return 23 end,
        ApplyStyle = styleBar,
        BarStopped = removeStyle,
        GetStyleName = function() return "LottiSkin" end,
    })
end

local function registerDBMStyle()
--    if not DBM or not aCoreCDB["SkinOptions"]["setDBM"] then return end
    local skin = DBT:RegisterSkin("LottiSkin")

    skin.defaults = {
        Skin = "LottiSkin",
        Template = "LottiSkinTimerTemplate",
        Texture = [[Interface\AddOns\LottiSkin\media\statusbar]],
        FillUpBars = false,
        IconLocked = false,

        Font = "", --If this has any set font it will override the XML font template, so it needs to be blank.
        FontSize = 13,

        StartColorR = 1,
        StartColorG = 0.8,
        StartColorB = 0,
        EndColorR = 1,
        EndColorG = 0.1,
        EndColorB = 0,

        Width = 170,
        Height = 10,
        Scale = 1,
        TimerPoint = "TOP",
        TimerX = 280,
        TimerY = -135,
        BarYOffset = 10,

        HugeWidth = 185,
        HugeScale = 1,
        HugeTimerPoint = "TOP",
        HugeTimerX = -249,
        HugeTimerY = -135,
        HugeBarYOffset = 10,
    }
	
    if DBM.Bars.options.Texture:find("DBM") then
        DBM.Bars.options.Texture = skin.defaults.Texture
    end

    if DBM.Bars.options.Template ~= skin.defaults.Template then
        --only set the skin if it isn't already set.
       DBM.Bars:SetSkin("LottiSkin")
	end
end

F:RegisterEvent("PLAYER_ENTERING_WORLD")
F:RegisterEvent("ADDON_LOADED")
local reason

F:SetScript("OnEvent", function(self, event, addon)
if event == "PLAYER_ENTERING_WORLD" or event == "ADDON_LOADED" then
	if not reason then reason = (select(6, GetAddOnInfo("BigWigs_Plugins"))) end
	if (reason == "MISSING" and addon == "BigWigs") or addon == "BigWigs_Plugins" then
	registerBWStyle()
	end
	end
end)


local function registerDBMStyle()
--    if not DBM or not aCoreCDB["SkinOptions"]["setDBM"] then return end
    local skin = DBT:RegisterSkin("LottiSkin")

    skin.defaults = {
        Skin = "LottiSkin",
        Template = "LottiSkinTimerTemplate",
        Texture = [[Interface\AddOns\LottiSkin\media\statusbar]],
        FillUpBars = false,
        IconLocked = false,

        Font = "", --If this has any set font it will override the XML font template, so it needs to be blank.
        FontSize = 13,

        StartColorR = 1,
        StartColorG = 0.8,
        StartColorB = 0,
        EndColorR = 1,
        EndColorG = 0.1,
        EndColorB = 0,

        Width = 170,
        Height = 10,
        Scale = 1,
        TimerPoint = "TOP",
        TimerX = 280,
        TimerY = -135,
        BarYOffset = 10,

        HugeWidth = 185,
        HugeScale = 1,
        HugeTimerPoint = "TOP",
        HugeTimerX = -249,
        HugeTimerY = -135,
        HugeBarYOffset = 10,
    }
	
    if DBM.Bars.options.Texture:find("DBM") then
        DBM.Bars.options.Texture = skin.defaults.Texture
    end

    if DBM.Bars.options.Template ~= skin.defaults.Template then
        --only set the skin if it isn't already set.
       DBM.Bars:SetSkin("LottiSkin")
	end
end

-- 载入

F:RegisterEvent("PLAYER_ENTERING_WORLD")
F:RegisterEvent("ADDON_LOADED")
local reason

F:SetScript("OnEvent", function(self, event, addon)
	if event == "PLAYER_ENTERING_WORLD" then
		if IsAddOnLoaded("DBM-Core") then
			registerDBMStyle()
		end
	elseif event == "ADDON_LOADED" then
		if not reason then reason = (select(6, GetAddOnInfo("BigWigs_Plugins"))) end
		if (reason == "MISSING" and addon == "BigWigs") or addon == "BigWigs_Plugins" then
			registerBWStyle()
		end
	end
end)
