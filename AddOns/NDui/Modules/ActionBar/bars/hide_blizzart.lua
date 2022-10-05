local _, ns = ...
local B, C, L, DB = unpack(ns)
local Bar = B:GetModule("Actionbar")

local _G = _G
local next, tonumber = next, tonumber
local ACTION_BUTTON_SHOW_GRID_REASON_CVAR = ACTION_BUTTON_SHOW_GRID_REASON_CVAR

local scripts = {
	"OnShow", "OnHide", "OnEvent", "OnEnter", "OnLeave", "OnUpdate", "OnValueChanged", "OnClick", "OnMouseDown", "OnMouseUp",
}

local framesToHide = {
	MainMenuBar, OverrideActionBar,
}

local framesToDisable = {
	MainMenuBar,
	MicroButtonAndBagsBar, MainMenuBarArtFrame, StatusTrackingBarManager,
	ActionBarDownButton, ActionBarUpButton,
	OverrideActionBar,
	OverrideActionBarExpBar, OverrideActionBarHealthBar, OverrideActionBarPowerBar, OverrideActionBarPitchFrame,
}

local function DisableAllScripts(frame)
	for _, script in next, scripts do
		if frame:HasScript(script) then
			frame:SetScript(script, nil)
		end
	end
end

local function buttonShowGrid(name, showgrid)
	for i = 1, 12 do
		local button = _G[name..i]
		if button then
			button:SetAttribute("showgrid", showgrid)
			ActionButton_ShowGrid(button, ACTION_BUTTON_SHOW_GRID_REASON_CVAR)
		end
	end
end

local updateAfterCombat
local function toggleButtonGrid()
	if InCombatLockdown() then
		updateAfterCombat = true
		B:RegisterEvent("PLAYER_REGEN_ENABLED", toggleButtonGrid)
	else
		local showgrid = tonumber(GetCVar("alwaysShowActionBars"))
		buttonShowGrid("ActionButton", showgrid)
		buttonShowGrid("MultiBarBottomLeftButton", showgrid)
		buttonShowGrid("MultiBarBottomRightButton", showgrid)
		buttonShowGrid("MultiBarRightButton", showgrid)
		buttonShowGrid("MultiBarLeftButton", showgrid)
		buttonShowGrid("NDui_ActionBarXButton", showgrid)
		if updateAfterCombat then
			B:UnregisterEvent("PLAYER_REGEN_ENABLED", toggleButtonGrid)
			updateAfterCombat = false
		end
	end
end

local function updateTokenVisibility()
	TokenFrame_LoadUI()
	TokenFrame_Update()
	BackpackTokenFrame_Update()
end

function Bar:HideBlizz()
	MainMenuBar:SetMovable(true)
	MainMenuBar:SetUserPlaced(true)
	MainMenuBar.ignoreFramePositionManager = true
	MainMenuBar:SetAttribute("ignoreFramePositionManager", true)

	for _, frame in next, framesToHide do
		frame:SetParent(B.HiddenFrame)
	end

	for _, frame in next, framesToDisable do
		frame:UnregisterAllEvents()
		DisableAllScripts(frame)
	end

	-- Hide blizz options
	SetCVar("multiBarRightVerticalLayout", 0)
	InterfaceOptionsActionBarsPanelStackRightBars:EnableMouse(false)
	InterfaceOptionsActionBarsPanelStackRightBars:SetAlpha(0)
	-- Update button grid
	hooksecurefunc("MultiActionBar_UpdateGridVisibility", toggleButtonGrid)
	hooksecurefunc("MultiActionBar_HideAllGrids", toggleButtonGrid)
	B:RegisterEvent("ACTIONBAR_HIDEGRID", toggleButtonGrid)
	toggleButtonGrid()
	-- Update token panel
	B:RegisterEvent("CURRENCY_DISPLAY_UPDATE", updateTokenVisibility)
end