--- 扒自 NDui 感谢原作者---


local F = CreateFrame("Frame")
--local B, C, L, DB = unpack(select(2, ...))
--local module = NDui:GetModule("Skins")


-------
local function SkinWA()
	local function Skin_WeakAuras(f, fType)
		if fType == "icon" then
			if not f.styled then
				f.icon:SetTexCoord(.08, .92, .08, .92) --图标缩放裁切
				f.icon.SetTexCoord = function() end
				CreateSD(f, 3, 3) --在LottiSkin.lua里
				f.styled = true
			end
		elseif fType == "aurabar" then
			if not f.styled then
				CreateSD(f.bar, 3, 3)   --进度条的毛绒绒边框
				f.icon:SetTexCoord(.08, .92, .08, .92)
				f.icon.SetTexCoord = function() end
				f.iconFrame:SetAllPoints(f.icon)
				CreateSD(f.iconFrame, 3, 3)
				f.styled = true
			end
		end
	end

	local regionTypes = WeakAuras.regionTypes
	local Create_Icon, Modify_Icon = regionTypes.icon.create, regionTypes.icon.modify
	local Create_AuraBar, Modify_AuraBar = regionTypes.aurabar.create, regionTypes.aurabar.modify

	regionTypes.icon.create = function(parent, data)
		local region = Create_Icon(parent, data)
		Skin_WeakAuras(region, "icon")
		return region
	end

	regionTypes.aurabar.create = function(parent)
		local region = Create_AuraBar(parent)
		Skin_WeakAuras(region, "aurabar")
		return region
	end

	regionTypes.icon.modify = function(parent, region, data)
		Modify_Icon(parent, region, data)
		Skin_WeakAuras(region, "icon")
	end

	regionTypes.aurabar.modify = function(parent, region, data)
		Modify_AuraBar(parent, region, data)
		Skin_WeakAuras(region, "aurabar")
	end

	for weakAura, _ in pairs(WeakAuras.regions) do
		local regions = WeakAuras.regions[weakAura]
		if regions.regionType == "icon" or regions.regionType == "aurabar" then
			Skin_WeakAuras(regions.region, regions.regionType)
		end
	end
end

-- 载入 --

F:RegisterEvent("PLAYER_ENTERING_WORLD")
F:RegisterEvent("ADDON_LOADED")
local reason

F:SetScript("OnEvent", function(sf, event, addon)
	if event == "PLAYER_ENTERING_WORLD" or event == "ADDON_LOADED" then 
		if IsAddOnLoaded("WeakAuras")  then
			SkinWA()
		end
		
end
end)

--module:LoadWithAddOn("WeakAuras", "WeakAuras", ReskinWA)