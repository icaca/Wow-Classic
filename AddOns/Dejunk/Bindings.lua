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
_G.BINDING_NAME_DEJUNK_TOGGLE_OPTIONS_FRAME = L.TOGGLE_OPTIONS_FRAME
_G.BINDING_NAME_DEJUNK_TOGGLE_SELL_FRAME = L.TOGGLE_SELL_FRAME
_G.BINDING_NAME_DEJUNK_TOGGLE_DESTROY_FRAME = L.TOGGLE_DESTROY_FRAME
_G.BINDING_NAME_DEJUNK_OPEN_LOOTABLES = L.OPEN_LOOTABLES

-- Sell next item
_G.BINDING_NAME_DEJUNK_SELL_NEXT_ITEM = L.SELL_NEXT_ITEM

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

-- Destroy next item
_G.BINDING_NAME_DEJUNK_DESTROY_NEXT_ITEM = L.DESTROY_NEXT_ITEM

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

DejunkBindings_ToggleOptionsFrame = Commands.toggle
DejunkBindings_ToggleSellFrame = Commands.sell
DejunkBindings_ToggleDestroyFrame = Commands.destroy
DejunkBindings_OpenLootables = Commands.open

function DejunkBindings_AddToList(groupName, listName)
  if not currentItemID then return end
  Lists[groupName][listName]:Add(currentItemID)
end

function DejunkBindings_RemoveFromList(groupName, listName)
  if not currentItemID then return end
  Lists[groupName][listName]:Remove(currentItemID, true)
end

function DejunkBindings_HandleNextItem(service)
  Addon[service]:HandleNextItem()
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
