local AddonName, Addon = ...
local Colors = Addon.Colors
local Commands = Addon.Commands
local DB = Addon.DB
local DCL = Addon.Libs.DCL
local E = Addon.Events
local EventManager = Addon.EventManager
local IsShiftKeyDown = _G.IsShiftKeyDown
local L = Addon.Libs.L
local LDB = Addon.Libs.LDB
local LDBIcon = Addon.Libs.LDBIcon
local MinimapIcon = Addon.MinimapIcon
local unpack = _G.unpack

local _colors = { 1.0, 0.82, 0, 1, 1, 1 }

-- Initialize once the DB becomes available.
EventManager:Once(E.DatabaseReady, function()
  local object = LDB:NewDataObject(AddonName, {
    type = "data source",
    text = AddonName,
  	icon = "Interface\\AddOns\\Dejunk\\Dejunk_Icon",

    OnClick = function(_, button)
      if IsShiftKeyDown() then
        if (button == "LeftButton") then
          Commands.sell()
        end

        if (button == "RightButton") then
          Commands.destroy()
        end
      elseif (button == "LeftButton") then
        Commands.toggle()
      end
    end,

    OnTooltipShow = function(tooltip)
      tooltip:AddDoubleLine(
        DCL:ColorString(AddonName, Colors.Primary),
        Addon.VERSION
      )
      tooltip:AddLine(" ")
      tooltip:AddDoubleLine(L.LEFT_CLICK, L.TOGGLE_OPTIONS_FRAME, unpack(_colors))
      tooltip:AddDoubleLine(L.SHIFT_LEFT_CLICK, L.TOGGLE_SELL_FRAME, unpack(_colors))
      tooltip:AddDoubleLine(L.SHIFT_RIGHT_CLICK, L.TOGGLE_DESTROY_FRAME, unpack(_colors))
		end,
  })

  LDBIcon:Register(AddonName, object, DB.Global.minimapIcon)
end)

-- ============================================================================
-- General Functions
-- ============================================================================

-- Displays the minimap icon.
function MinimapIcon:Show()
  DB.Global.minimapIcon.hide = false
  LDBIcon:Show(AddonName)
end

-- Hides the minimap icon.
function MinimapIcon:Hide()
  DB.Global.minimapIcon.hide = true
  LDBIcon:Hide(AddonName)
end

-- Toggles the minimap icon.
function MinimapIcon:Toggle()
  if DB.Global.minimapIcon.hide then
    self:Show()
  else
    self:Hide()
  end
end
