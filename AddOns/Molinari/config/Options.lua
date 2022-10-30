local addonName, ns = ...
local L = ns.L

local WOW_10 = select(4, GetBuildInfo()) >= 100000

local function UpdateOptions()
	if((InterfaceOptionsFrameAddOns or SettingsPanel):IsShown()) then
		LibStub('AceConfigRegistry-3.0'):NotifyChange(addonName)
	end
end

local function CreateOptions()
	CreateOptions = nop -- we only want to load this once

	LibStub('AceConfig-3.0'):RegisterOptionsTable(addonName, {
		type = 'group',
		get = function(info)
			return ns.db.profile.general[info[#info]]
		end,
		set = function(info, value)
			ns.db.profile.general[info[#info]] = value
		end,
		args = {
			modifierKey = {
				order = 1,
				name = string.format(L['Modifier to activate %s'], addonName),
				type = 'select',
				values = {
					ALT = L['ALT key'],
					CTRL = L['ALT + CTRL key'],
					SHIFT = L['ALT + SHIFT key']
				},
				set = function(info, value)
					ns.db.profile.general[info[#info]] = value
					Molinari:UpdateStateDriver()
				end,
				disabled = InCombatLockdown,
			},
			combatWarning = {
				order = 2,
				name = string.format('|cff990000%s|r', L['You can\'t do that while in combat']),
				type = 'description',
				hidden = function() return not InCombatLockdown() end,
			},
		},
	})

	LibStub('AceConfigDialog-3.0'):AddToBlizOptions(addonName)

	-- handle combat updates
	local EventHandler = CreateFrame('Frame', nil, InterfaceOptionsFrameAddOns or SettingsPanel)
	EventHandler:RegisterEvent('PLAYER_REGEN_ENABLED')
	EventHandler:RegisterEvent('PLAYER_REGEN_DISABLED')
	EventHandler:SetScript('OnEvent', UpdateOptions)
end

if WOW_10 then
	SettingsPanel:HookScript('OnShow', function()
		CreateOptions() -- LoD
		ns.CreateBlocklistOptions() -- LoD
	end)
else
	InterfaceOptionsFrameAddOns:HookScript('OnShow', function()
		CreateOptions() -- LoD
		ns.CreateBlocklistOptions() -- LoD

		-- we load too late, so we have to manually refresh the list
		InterfaceAddOnsList_Update()
	end)
end

_G['SLASH_' .. addonName .. '1'] = '/molinari'
SlashCmdList[addonName] = function()
	CreateOptions() -- LoD
	ns.CreateBlocklistOptions() -- LoD

	if WOW_10 then
		Settings.OpenToCategory(addonName)
	else
		InterfaceOptionsFrame_OpenToCategory(addonName)
		InterfaceOptionsFrame_OpenToCategory(addonName) -- load twice due to an old bug
	end
end
