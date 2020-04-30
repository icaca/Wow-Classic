local oldTime = 0;
local WBT_Timer;
WBT_DMFData = {
  ["Remaining"] = 0;
}

local BuffIDs = {
  [23735] = true,
  [23736] = true,
  [23737] = true,
  [23738] = true,
  [23766] = true,
  [23767] = true,
  [23768] = true,
  [23769] = true,
}

function WorldBuffTracker_HasFortuneCooldown()
  return WBT_DMFData["Remaining"] > 0;
end

function WorldBuffTracker_CreateDMFTimer()
  if(WBT_DMFData["Remaining"] > 0) then
    WBT_DMFData["Remaining"] = WBT_DMFData["Remaining"] - 2;
  else
    WBT_DMFData["Remaining"] = WorldBuffTrackerBuffCDs["DMF"] - 1;
  end
  WorldBuffTracker_SetRemainingCD();
  oldTime = GetTime();
  WBT_Timer = C_Timer.NewTicker(1, function()
    local T = GetTime();
    local dT = T - oldTime;
    oldTime = T;
    WBT_DMFData["Remaining"] = WBT_DMFData["Remaining"] - dT;
    if(WBT_DMFData["Remaining"] <= 0) then
      WBT_Timer:Cancel();
      --alert
    end
  end);
end

function WorldBuffTracker_SetRemainingCD()
  for i=1,32 do
    local b,_,_,_,e,f,_,_,_,id,_ = UnitBuff("player", i);
    if(b == nil) then
      return 0;
    end
    if(BuffIDs[id]) then
      WBT_DMFData["Remaining"] = WorldBuffTrackerBuffCDs["DMF"] + (f-GetTime()-7200);
    end
  end
  return false;
end
