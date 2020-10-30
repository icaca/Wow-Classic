local AddonName, Addon = ...
local Colors = Addon.Colors
local Commands = Addon.Commands
local DCL = Addon.Libs.DCL
local L = Addon.Libs.L
local Lists = Addon.Lists
local Utils = Addon.Utils

-- Variables
local currentItemID = nil

-- ============================================================================
-- Binding Strings
-- ============================================================================

-- Category
_G.BINDING_CATEGORY_DEJUNK = DCL:ColorString(AddonName, Colors.Primary)

-- Headers
_G.BINDING_HEADER_DEJUNK_HEADER_GENERAL = L.GENERAL_TEXT
_G.BINDING_HEADER_DEJUNK_HEADER_SELL = L.SELL_TEXT
_G.BINDING_HEADER_DEJUNK_HEADER_DESTROY = L.DESTROY_TEXT

-- General
_G.BINDING_NAME_DEJUNK_TOGGLE_OPTIONS = L.BINDINGS_TOGGLE_OPTIONS_TEXT
_G.BINDING_NAME_DEJUNK_START_SELLING = L.START_SELLING_BUTTON_TEXT
_G.BINDING_NAME_DEJUNK_START_DESTROYING = L.START_DESTROYING_BUTTON_TEXT
_G.BINDING_NAME_DEJUNK_OPEN_LOOTABLES = L.OPEN_LOOTABLES

-- Sell Inclusions
_G.BINDING_NAME_DEJUNK_ADD_INCLUSIONS =
  L.BINDINGS_ADD_TO_LIST_TEXT:format(Lists.sell.inclusions.localeShort)
_G.BINDING_NAME_DEJUNK_REM_INCLUSIONS =
  L.BINDINGS_REMOVE_FROM_LIST_TEXT:format(Lists.sell.inclusions.localeShort)

-- Sell Exclusions
_G.BINDING_NAME_DEJUNK_ADD_EXCLUSIONS =
  L.BINDINGS_ADD_TO_LIST_TEXT:format(Lists.sell.exclusions.localeShort)
_G.BINDING_NAME_DEJUNK_REM_EXCLUSIONS =
  L.BINDINGS_REMOVE_FROM_LIST_TEXT:format(Lists.sell.exclusions.localeShort)

-- Destroy Inclusions
_G.BINDING_NAME_DEJUNK_ADD_DESTROYABLES =
  L.BINDINGS_ADD_TO_LIST_TEXT:format(Lists.destroy.inclusions.localeShort)
_G.BINDING_NAME_DEJUNK_REM_DESTROYABLES =
  L.BINDINGS_REMOVE_FROM_LIST_TEXT:format(Lists.destroy.inclusions.localeShort)

-- Destroy Exclusions
_G.BINDING_NAME_DEJUNK_ADD_UNDESTROYABLES =
  L.BINDINGS_ADD_TO_LIST_TEXT:format(Lists.destroy.exclusions.localeShort)
_G.BINDING_NAME_DEJUNK_REM_UNDESTROYABLES =
  L.BINDINGS_REMOVE_FROM_LIST_TEXT:format(Lists.destroy.exclusions.localeShort)

-- ============================================================================
-- Binding Functions
-- ============================================================================

DejunkBindings_ToggleOptions = Commands.toggle
DejunkBindings_StartSelling = Commands.sell
DejunkBindings_StartDestroying = Commands.destroy
DejunkBindings_OpenLootables = Commands.open

function DejunkBindings_AddToList(groupName, listName)
  if not currentItemID then return end
  Lists[groupName][listName]:Add(currentItemID)
end

function DejunkBindings_RemoveFromList(groupName, listName)
  if not currentItemID then return end
  Lists[groupName][listName]:Remove(currentItemID, true)
end

-- ============================================================================
-- Item Tooltip Hook
-- ============================================================================

local function OnTooltipSetItem(self, ...)
  currentItemID = Utils:GetItemIDFromLink(select(2, self:GetItem()))
end

local function OnTooltipCleared(self, ...)
  currentItemID = nil
end

_G.GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
_G.GameTooltip:HookScript("OnTooltipCleared", OnTooltipCleared)
