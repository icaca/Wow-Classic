local _, L = ...;
local VERSION = 11326;
local realmName = GetRealmName();
local playerName = UnitName("player");
function WorldBuffTracker_GetVersion()
  return VERSION;
end
local faction = "Alliance";
local wbtString = "[WorldBuffTracker] ";
local color = {
  ["BLUE"] = "|cFF30D4FF",
  ["ORANGE"] = "|cFFFFAA0A",
  ["PURPLE"] = "|cFFB90AFF",
}
local WorldBuffTrackerFrame = CreateFrame("Frame");
local addonInitialized = 99999999999999;
local WorldBuffTrackerEvents = {}
WorldBuffTracker = {}

WorldBuffTrackerZones = {
  ["Horde"] = {
    [1411] = true, [1454] = true, [1413] = true;
  },
  ["Alliance"] = {
      [1453] = true, [1429] = true;
    },
  ["DMF"] = {
    [1412] = true, [1429] = true;
  }
}

WorldBuffTrackerTTB = {
  ["1"] = 13, ["2"] = 17, ["3"] = 17,
}

WorldBuffTrackerBuffCDs = {
  ["1"] = 10800, ["2"] = 21600, ["3"] = 28800,
  ["DMF"] = 14400, ["SF"] = 1500;
}

function WorldBuffTracker_Initialize()
  if(GetSpellBookItemName(1, "spell") ~= nil) then
    if(WorldBuffTrackerSpells[GetLocale()] ~= nil) then
      WorldBuffTrackerSpells = WorldBuffTrackerSpells[GetLocale()];
      WorldBuffTrackerNPCs = WorldBuffTrackerNPCs[GetLocale()];
    else
      WorldBuffTrackerSpells = WorldBuffTrackerSpells["enUS"];
      WorldBuffTrackerNPCs = WorldBuffTrackerNPCs["enUS"];
    end
    for k,v in pairs(WorldBuffTrackerSpells) do
      if(v == 2) then
        WorldBuffTrackerSpellsInverse["2"] = k .. ": (" .. L["Onyxia"] .. ")";
        WorldBuffTrackerSpellsInverse["3"] = k .. ": (" .. L["Nefarian"] .. ")";
      else
        WorldBuffTrackerSpellsInverse[tostring(v)] = k;
      end
    end
    faction, _ = UnitFactionGroup("player");
    WorldBuffTracker_VerifyTable();
    if(WorldBuffTracker[realmName][faction]["LastSync"] - GetServerTime() < -300) then
      C_ChatInfo.SendAddonMessage("WBT-0", VERSION, "GUILD");
      C_ChatInfo.SendAddonMessage("WBT-S", VERSION, "GUILD");
      WorldBuffTracker[realmName][faction]["LastSync"] = GetServerTime();
    end
    WorldBuffTracker[realmName]["Characters"][playerName] = 0;
    addonInitialized = GetTime() + 0.5;
    WorldBuffTrackerFrame:SetScript("OnUpdate", WorldBuffTracker_DelayTracking);
    WorldBuffTracker_TimeTableTest();
    WorldBuffTracker_SetRemainingCD();
    if(WorldBuffTracker_HasFortuneCooldown()) then
      WorldBuffTracker_CreateDMFTimer();
    end
  end
end

function WorldBuffTracker_DelayTracking()
  if(addonInitialized - GetTime() < 0) then
    addonInitialized = 99999999999999;
    WorldBuffTrackerFrame:SetScript("OnUpdate", nil);
    for k, v in pairs(WorldBuffTrackerEvents) do
      WorldBuffTrackerFrame:RegisterEvent(k);
    end
    WorldBuffTrackerFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
    WorldBuffTrackerFrame:UnregisterEvent("CHAT_MSG_MONSTER_YELL");
    WorldBuffTrackerEvents:ZONE_CHANGED_NEW_AREA();
  end
end

function WorldBuffTrackerEvents:COMBAT_LOG_EVENT_UNFILTERED(...)
  local _, eventType, _,
      _, sourceName, _, _,
      destGUID, destName, _, _,
      spellId, spellName, _, auraType, _ = CombatLogGetCurrentEventInfo();
    if((eventType == "SPELL_AURA_APPLIED" or eventType == "SPELL_AURA_REFRESH")
      and destName == playerName and auraType == "BUFF" and (WorldBuffTrackerSpells[spellName] ~= nil or strfind(spellName, L["DMFFortune"]))) then
        if(strfind(spellName, L["DMFFortune"])) then
          if(WorldBuffTracker_BuffIsValid(spellName, 2)) then
            WBT_DMFData["Remaining"] = 0;
            WorldBuffTracker_CreateDMFTimer();
          end
          return
        end
        local buffID = WorldBuffTrackerSpells[spellName];
        if(buffID == 2) then
          if(WorldBuffTracker[realmName][faction]["2"]["Yell"] == WorldBuffTracker[realmName][faction]["3"]["Yell"]) then
            return
          else
            buffID = (WorldBuffTracker[realmName][faction]["2"]["Yell"] > WorldBuffTracker[realmName][faction]["3"]["Yell"]) and "2" or "3";
          end
        end
        if(WorldBuffTracker_BuffIsValid(spellName, buffID)) then
          if(IsInGuild()) then
            C_ChatInfo.SendAddonMessage("WBT-" .. buffID, VERSION, "GUILD");
          else
            WorldBuffTracker_HandleBuffById(buffID);
          end
        end
    elseif(eventType == "UNIT_DIED") then
      local npc = WorldBuffTrackerNPCs[faction][destName];
      if(npc) then
        local t = GetServerTime() + 500;
        C_ChatInfo.SendAddonMessage("WBT-D", WorldBuffTracker_Serialize(npc, t, VERSION), "GUILD");
        --WorldBuffTracker_BuffAnnounce(npc, t);
      end
    end
end

function WorldBuffTrackerEvents:ZONE_CHANGED_NEW_AREA(...)
  if(WorldBuffTrackerZones[faction][C_Map.GetBestMapForUnit("player")] ~= nil or
    WorldBuffTrackerZones["DMF"][C_Map.GetBestMapForUnit("player")] ~= nil) then
    WorldBuffTrackerFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
    WorldBuffTrackerFrame:RegisterEvent("CHAT_MSG_MONSTER_YELL");
  else
    WorldBuffTrackerFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
    WorldBuffTrackerFrame:UnregisterEvent("CHAT_MSG_MONSTER_YELL");
  end
end

function WorldBuffTrackerEvents:CHAT_MSG_MONSTER_YELL(msg, npc, ...)
  if(WorldBuffTrackerNPCs[faction][npc] == nil) then
    return;
  end
  npc = tostring(WorldBuffTrackerNPCs[faction][npc]);
  WorldBuffTracker_TimeTableTest();
  if(WorldBuffTracker[realmName][faction][npc]["Timestamp"] == 0) then
    local t = GetServerTime();
    if(WorldBuffTracker[realmName][faction][npc]["Yell"] < t) then
      if(npc ~= "1" or (strfind(msg, L["ThrallYell"]) ~= nil)) then
        C_ChatInfo.SendAddonMessage("WBT-A", npc .. "_" .. VERSION, "GUILD");
        WorldBuffTracker_BuffAnnounce(npc, t);
      end
    end
  end
end

function WorldBuffTrackerEvents:CHAT_MSG_ADDON(prefix, message, channel, sender, ...)
  local sender, _ = strsplit("-", sender);
  local t = GetServerTime();
  if(prefix == "WBT-A" and channel == "GUILD") then
    local buff, version = strsplit("_", message);
    version = WorldBuffTracker_GetVersionFromString(version);
    if(WorldBuffTracker[realmName][faction][buff] ~= nil and version >= 11326) then
      WorldBuffTracker_BuffAnnounce(buff, t);
    end
  elseif(prefix == "WBT-B") then

  elseif(prefix == "WBT-1") then
    WorldBuffTracker_HandleWarchief(sender, WorldBuffTracker_GetVersionFromString(message), t);
  elseif(prefix == "WBT-2") then
    WorldBuffTracker_HandleOnyxia(sender, WorldBuffTracker_GetVersionFromString(message), t);
  elseif(prefix == "WBT-3") then
    WorldBuffTracker_HandleNefarian(sender, WorldBuffTracker_GetVersionFromString(message), t);
  elseif(prefix == "WBT-0") then
    if(channel == "WHISPER") then
      WorldBuffTracker_HandleSync(message, sender);
    end
  elseif(prefix == "WBT-S") then
    if(channel == "GUILD" and sender ~= playerName) then
      WorldBuffTracker_SendSyncData(sender);
    elseif(channel == "WHISPER") then
      WorldBuffTracker_HandleSyncNew(message, sender);
    end
  end
end

function WorldBuffTrackerEvents:GOSSIP_SHOW(...)
  local npc, _ = UnitName("npc");
  if(WorldBuffTrackerNPCs[faction][npc]) then
    --check coords
    --check buffs

  end
end

function WorldBuffTrackerEvents:UNIT_TARGET(...)
  if(not UnitPlayerControlled("target")) then

  end
end

function WorldBuffTracker_BuffAnnounce(buffID, t)
    if(WorldBuffTracker[realmName][faction][buffID]["Yell"] < t) then
      WorldBuffTracker[realmName][faction][buffID]["Yell"] = t + 3600;
      local buffString = WorldBuffTrackerSpellsInverse[buffID];
      print(wbtString .. buffString
      .. " incoming!");
      WorldBuffTracker_AlertPlayer(buffString, true, true);
    end
end

local function WorldBuffTrackerFrame_Command(msg, editbox)
  if(strlower(msg) == "version") then
    if(WorldBuffTracker["VersionControl"]) then
      print(wbtString .. L["Version announce: disabled."])
    else
      print(wbtString .. L["Version announce: enabled."])
    end
    --WorldBuffTracker["VersionControl"] = not WorldBuffTracker["VersionControl"];
    return;
  end
  WorldBuffTracker_TimeTableTest();
  local t = GetServerTime();
  print(color["PURPLE"] .. "------ WorldBuffTracker ------|r");
  if(WorldBuffTracker_HasFortuneCooldown()) then
    print(color["BLUE"] .. L["DMF"] .. "|r");
    print("    " .. color["ORANGE"] .. WorldBuffTracker_TimeUntilDate(math.floor(WBT_DMFData["Remaining"])) .. "|r");
  end
  for buff=1,3 do
    WorldBuffTracker_OutputByType(tostring(buff), t);
  end
  print(color["PURPLE"] .. "-----------------------------------|r")
end

function WorldBuffTracker_OutputByType(buff, t)
  local bT = WorldBuffTracker[realmName][faction][buff]["Timestamp"];
    if(bT > 0) then
    print(color["BLUE"] .. WorldBuffTrackerSpellsInverse[buff]
     .. "|r");
      local cd = WorldBuffTrackerBuffCDs[buff];
      print("    " .. string.format(L["Popped: %s"], color["ORANGE"] .. date('%H:%M:%S', bT) .. "|r"));
      print("    " .. string.format(L["Next: %s"], color["ORANGE"] .. date('%H:%M:%S', bT + cd) .. "|r"));
      print("    " .. color["ORANGE"] .. WorldBuffTracker_TimeUntilDate(bT - t + cd) .. "|r");
    end
end

function WorldBuffTracker_TimeUntilDate(seconds)
  local str = "";
  if(seconds > 3600) then
    local hours = math.floor(seconds / 3600);
    str = hours .. "h ";
    seconds = seconds - 3600 * hours;
  end
  if(seconds > 60) then
    local minutes = math.floor(seconds / 60);
    str = str .. minutes .. "m ";
    seconds = seconds - 60 * minutes;
  end
  return str .. math.floor(seconds) .. "s";
end

function WorldBuffTracker_AlertPlayer(buff, playSound, whisper)
  if(WorldBuffTracker["SelfWhisper"]) then
    PlaySoundFile("Interface/AddOns/WorldBuffTracker/resources/sound/beware.ogg", "Master");
  end
  if(WorldBuffTracker["PlaySound"]) then
    SendChatMessage(wbtString .. buff .. " incoming!", "WHISPER", nil, UnitName("player"));
  end
end

SLASH_WORLDBUFFS1, SLASH_WORLDBUFFS2, SLASH_WORLDBUFFS3 = '/worldbuffs', '/worldbufftracker', '/wbt'

SlashCmdList["WORLDBUFFS"] = WorldBuffTrackerFrame_Command;

WorldBuffTrackerFrame:SetScript("OnUpdate", WorldBuffTracker_Initialize);
WorldBuffTrackerFrame:SetScript("OnEvent", function(self, event, ...)
  WorldBuffTrackerEvents[event](self, ...);
end);
C_ChatInfo.RegisterAddonMessagePrefix("WBT-0");
C_ChatInfo.RegisterAddonMessagePrefix("WBT-1");
C_ChatInfo.RegisterAddonMessagePrefix("WBT-2");
C_ChatInfo.RegisterAddonMessagePrefix("WBT-3");
C_ChatInfo.RegisterAddonMessagePrefix("WBT-A");
C_ChatInfo.RegisterAddonMessagePrefix("WBT-S");
C_ChatInfo.RegisterAddonMessagePrefix("WBT-B");
C_ChatInfo.RegisterAddonMessagePrefix("WBT-D");
