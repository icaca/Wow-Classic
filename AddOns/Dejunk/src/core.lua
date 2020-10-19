local AddonName, Addon = ...
local Colors = Addon.Colors
local Confirmer = Addon.Confirmer
local Core = Addon.Core
local DB = Addon.DB
local DCL = Addon.Libs.DCL
local Dejunker = Addon.Dejunker
local Destroyer = Addon.Destroyer
local GetNetStats = _G.GetNetStats
local L = Addon.Libs.L
local ListHelper = Addon.ListHelper
local Lists = Addon.Lists
local max = math.max
local print = print
local Repairer = Addon.Repairer
local select = select
local UI = Addon.UI

-- ============================================================================
-- Functions
-- ============================================================================

-- Prints a formatted message ("[Dejunk] msg").
-- @param ... - the messages to print
function Core:Print(...)
  if DB.Profile.general.silentMode then return end
  print(DCL:ColorString(("[%s]"):format(AddonName), Colors.Primary), ...)
end

-- Attempts to print a message if verbose mode is enabled.
-- @param ... - the messages to print
function Core:PrintVerbose(...)
  if DB.Profile.general.verboseMode then self:Print(...) end
end

--[[
-- Prints a debug message ("[Dejunk Debug] title: ...").
-- @param title - the title of the debug message
-- @param ... - the messages to print
function Core:Debug(title, ...)
  print(
    DCL:ColorString(("[%s Debug]"):format(AddonName), Colors.Red),
    (select("#", ...) > 0) and
    DCL:ColorString(title, Colors.Green)..":" or
    title,
    ...
  )
end
--]] Core.Debug = _G.nop

-- Returns true if the dejunking process can be safely started,
-- and false plus a reason message otherwise.
-- @return bool, string or nil
function Core:CanDejunk()
  if Dejunker:IsDejunking() or Confirmer:IsConfirming("Dejunker") then
    return false, L.SELLING_IN_PROGRESS
  end

  if Destroyer:IsDestroying() or Confirmer:IsConfirming("Destroyer") then
    return false, L.CANNOT_SELL_WHILE_DESTROYING
  end

  if
    ListHelper:IsParsing(Lists.sell.inclusions) or
    ListHelper:IsParsing(Lists.sell.exclusions)
  then
    return
      false,
      L.CANNOT_SELL_WHILE_LISTS_UPDATING:format(
        Lists.sell.inclusions.locale,
        Lists.sell.exclusions.locale
      )
  end

  return true
end

-- Returns true if the destroying process can be safely started,
-- and false plus a reason message otherwise.
-- @return bool, string or nil
function Core:CanDestroy()
  if Destroyer:IsDestroying() or Confirmer:IsConfirming("Destroyer") then
    return false, L.DESTROYING_IN_PROGRESS
  end

  if Dejunker:IsDejunking() or Confirmer:IsConfirming("Dejunker") then
    return false, L.CANNOT_DESTROY_WHILE_SELLING
  end

  if
    ListHelper:IsParsing(Lists.destroy.inclusions) or
    ListHelper:IsParsing(Lists.destroy.exclusions)
  then
    return
      false,
      L.CANNOT_DESTROY_WHILE_LISTS_UPDATING:format(
        Lists.destroy.inclusions.locale,
        Lists.destroy.exclusions.locale
      )
  end

  return true
end

-- Returns true if Dejunk is busy performing a critical action.
-- @return - boolean
function Core:IsBusy()
  return
    Dejunker:IsDejunking() or
    Destroyer:IsDestroying() or
    ListHelper:IsParsing() or
    Confirmer:IsConfirming()
end

-- ============================================================================
-- Game Update
-- ============================================================================

-- Frame
_G.CreateFrame("Frame"):SetScript("OnUpdate", function(_, elapsed)
  Core:OnUpdate(elapsed)
end)

local DELAY = 10 -- seconds
local interval = DELAY
local home, world, latency

function Core:OnUpdate(elapsed)
  interval = interval + elapsed
  if (interval >= DELAY) then -- Update latency
    interval = 0
    home, world = select(3, GetNetStats())
    latency = max(home, world) * 0.001 -- convert to seconds
    self.MinDelay = max(latency, 0.1) -- 0.1 seconds min
  end

  ListHelper:OnUpdate(elapsed)

  Dejunker:OnUpdate(elapsed)
  Destroyer:OnUpdate(elapsed)
  if Repairer.OnUpdate then Repairer:OnUpdate(elapsed) end
  Confirmer:OnUpdate(elapsed)

  UI:OnUpdate(elapsed)
end
