local faction = UnitFactionGroup("player");
local playerName = UnitName("player");
local realmName = GetRealmName();

local HasVersionControlled = false;
WorldBuffTrackerConfigurableVars = {};
local WorldBuffTrackerVars = {
  ["PlaySound"] = true,
  ["SelfWhisper"] = true,
  ["GuildAnnounce"] = false,
}
local _, L = ...;

function WorldBuffTracker_VerifyTable()
  for k, v in pairs(WorldBuffTrackerVars) do
    if(WorldBuffTracker[k] == nil and type(v) == "boolean") then
      WorldBuffTracker[k] = v;
      WorldBuffTrackerConfigurableVars[k] = v;
    end
  end
  if(type(WorldBuffTracker[realmName]) ~= "table") then
    WorldBuffTracker[realmName] = {};
    WorldBuffTracker[realmName]["Characters"] = {};
    if(type(WorldBuffTracker[realmName][faction]) ~= "table") then
      WorldBuffTracker[realmName][faction] = {};
      WorldBuffTracker[realmName][faction]["LastSync"] = 0;
    end
  end
  WorldBuffTracker_TestBuffSubtable("1");
  WorldBuffTracker_TestBuffSubtable("2");
  WorldBuffTracker_TestBuffSubtable("3");
end

function WorldBuffTracker_TestBuffSubtable(buff)
  local buffEntryType = type(WorldBuffTracker[realmName][faction][buff]);
  if(buffEntryType ~= "table") then
    WorldBuffTracker[realmName][faction][buff] = {
      ["Timestamp"] = 0,
      ["Yell"] = 0,
      ["Version"] = WorldBuffTracker_GetVersion(),
      ["Sender"] = UnitName("player"),
      ["Origin"] = UnitName("player"),
      ["Killed"] = false,
      ["Y0"] = 0,
      ["Y1"] = 0,
      ["Y2"] = 0,
      ["Weight"] = 0,
    }
  end
end

function WorldBuffTracker_DistinctTimestamp(list, timestamp)
  if(type(WorldBuffTracker[realmName][faction][list]) == "table" and tonumber(list) ~= nil) then
    if(abs(timestamp-WorldBuffTracker[realmName][faction][list]["Timestamp"]) < 30) then
      return false;
    end
    return true;
  end
  return false;
end

function WorldBuffTracker_TimeTableTest()
  local t = GetServerTime();
  WorldBuffTracker_TimeTableResetByBuff("1", t, WorldBuffTrackerBuffCDs["1"]);
  WorldBuffTracker_TimeTableResetByBuff("2", t, WorldBuffTrackerBuffCDs["2"]);
  WorldBuffTracker_TimeTableResetByBuff("3", t, WorldBuffTrackerBuffCDs["3"]);
end

function WorldBuffTracker_TimeTableResetByBuff(buff, t, cd)
  local dt = WorldBuffTracker[realmName][faction][buff]["Timestamp"];
  if(dt ~= 0) then
    WorldBuffTracker[realmName][faction][buff]["Yell"] = 0;
  end
  if(t-dt > cd) then
    WorldBuffTracker[realmName][faction][buff]["Timestamp"] = 0;
  end
end

function WorldBuffTracker_HandleSync(message, sender)
  local buffType, time, origin, version, _ = strsplit("_", message);
  version = WorldBuffTracker_GetVersionFromString(version);
  if(version < 11326) then
    return
  end
  time = tonumber(time);
  if(WorldBuffTracker[realmName][faction][buffType] == nil) then
    return
  elseif(time == nil or time > GetServerTime()
    or (WorldBuffTracker[realmName][faction][buffType]["Timestamp"] > 0 and WorldBuffTracker[realmName][faction][buffType]["Sender"] == UnitName("player"))
    or (WorldBuffTracker[realmName][faction][buffType]["Timestamp"] > 0 and
    version < WorldBuffTracker[realmName][faction][buffType]["Version"])) then
    return
  end
  if(WorldBuffTracker_DistinctTimestamp(buffType, time)) then
    if(WorldBuffTracker[realmName][faction][buffType]["Version"] < version or WorldBuffTracker[realmName][faction][buffType]["Timestamp"] == 0) then
      WorldBuffTracker[realmName][faction][buffType]["Timestamp"] = time;
      WorldBuffTracker[realmName][faction][buffType]["Sender"] = sender;
      WorldBuffTracker[realmName][faction][buffType]["Origin"] = origin;
      WorldBuffTracker[realmName][faction][buffType]["Version"] = version;
    end
  end
end

function WorldBuffTracker_HandleSyncNew(message, sender, guild)
  local version, b1, b2, b3 = strsplit("_", message);
  version = WorldBuffTracker_GetVersionFromString(version);
  WorldBuffTracker_HandleSyncSubType("1", b1, sender, guild);
  WorldBuffTracker_HandleSyncSubType("2", b2, sender, guild);
  WorldBuffTracker_HandleSyncSubType("3", b3, sender, guild);
end

function WorldBuffTracker_HandleSyncSubType(buffType, string, sender, guild)
  local timestamp, origin, killed, weight, version = strsplit(":", string);
  weight = guild and tonumber(weight) or 1;
  --need to make use of this in some creative way, perhaps need a blacklist/trust system.
  timestamp = WorldBuffTracker_HexToDec(timestamp);
  killed = tonumber(killed) == 1 and 1 or 0;
  version = WorldBuffTracker_GetVersionFromString(WorldBuffTracker_HexToDec(timestamp));
  if(timestamp == nil or timestamp > GetServerTime()
    or (WorldBuffTracker[realmName][faction][buffType]["Timestamp"] > 0 and WorldBuffTracker[realmName][faction][buffType]["Sender"] == UnitName("player"))
    or (WorldBuffTracker[realmName][faction][buffType]["Timestamp"] > 0 and
    version < WorldBuffTracker[realmName][faction][buffType]["Version"])) then
    return
  end
  if(WorldBuffTracker_DistinctTimestamp(buffType, time)) then
    if(WorldBuffTracker[realmName][faction][buffType]["Version"] < version or WorldBuffTracker[realmName][faction][buffType]["Timestamp"] == 0) then
      WorldBuffTracker[realmName][faction][buffType]["Timestamp"] = time;
      WorldBuffTracker[realmName][faction][buffType]["Sender"] = sender;
      WorldBuffTracker[realmName][faction][buffType]["Origin"] = origin;
      WorldBuffTracker[realmName][faction][buffType]["Killed"] = killed;
      WorldBuffTracker[realmName][faction][buffType]["Weight"] = weight;
      WorldBuffTracker[realmName][faction][buffType]["Version"] = version;
    end
  end
end

function WorldBuffTracker_SendSyncData(target)
  WorldBuffTracker_TimeTableTest();
  C_ChatInfo.SendAddonMessage("WBT-S", WorldBuffTracker_BuildSyncMessage(), "WHISPER", target);
end

function WorldBuffTracker_BuildSyncMessage()
  return WorldBuffTracker_Serialize(WorldBuffTracker_GetVersion(),
    WorldBuffTracker_BuildSyncMessageSubType("1"),
    WorldBuffTracker_BuildSyncMessageSubType("2"),
    WorldBuffTracker_BuildSyncMessageSubType("3"));
end

function WorldBuffTracker_BuildSyncMessageSubType(id)
  return WorldBuffTracker_DecToHex(WorldBuffTracker[realmName][faction][id]["Timestamp"]) .. ":" ..
    WorldBuffTracker_GetTrueOrigin(id) .. ":" ..
    WorldBuffTracker[realmName][faction][id]["Killed"] .. ":" ..
    WorldBuffTracker[realmName][faction][id]["Weight"] .. ":" ..
    WorldBuffTracker_DecToHex(WorldBuffTracker[realmName][faction][id]["Version"]);
end

function WorldBuffTracker_GetTrueOrigin(id)
  local origin = WorldBuffTracker[realmName][faction][id]["Origin"];
  if(WorldBuffTracker[realmName]["Characters"][origin] == nil) then
    return origin;
  else
    return playerName;
  end
end

function WorldBuffTracker_GetOriginString(v)
  local sources = " ";
  if(WorldBuffTracker[realmName][faction][v]["Origin"] ~= WorldBuffTracker[realmName][faction][v]["Sender"]) then
    sources = sources .. "(" .. WorldBuffTracker[realmName][faction][v]["Origin"] .. "→" .. WorldBuffTracker[realmName][faction][v]["Sender"] .. ")";
  else
    sources = sources .. "(" .. WorldBuffTracker[realmName][faction][v]["Sender"] .. ")";
  end
  return sources;
end

function WorldBuffTracker_HandleWarchief(sender, version, time)
  WorldBuffTracker_HandleBuffByType("1", 10800, sender, version, time);
end

function WorldBuffTracker_HandleOnyxia(sender, version, time)
  WorldBuffTracker_HandleBuffByType("2", 21600, sender, version, time);
end

function WorldBuffTracker_HandleNefarian(sender, version, time)
  WorldBuffTracker_HandleBuffByType("3", 21600, sender, version, time);
end

function WorldBuffTracker_HandleBuffById(id)
  if(id == "1") then
    WorldBuffTracker_HandleWarchief(UnitName("player"), WorldBuffTracker_GetVersion(), GetServerTime());
  elseif(id == "2") then
    WorldBuffTracker_HandleOnyxia(UnitName("player"), WorldBuffTracker_GetVersion(), GetServerTime());
  elseif(id == "3") then
    WorldBuffTracker_HandleNefarian(UnitName("player"), WorldBuffTracker_GetVersion(), GetServerTime());
  end
end

function WorldBuffTracker_HandleBuffByType(type, cooldown, sender, version, time)
  if(version < 11326) then
    return
  end
  if(WorldBuffTracker[realmName][faction][type]["Timestamp"] + cooldown < time) then
    WorldBuffTracker[realmName][faction][type]["Timestamp"] = time;
    WorldBuffTracker[realmName][faction][type]["Version"] = version;
    WorldBuffTracker[realmName][faction][type]["Sender"] = sender;
    WorldBuffTracker[realmName][faction][type]["Origin"] = sender;
  elseif(WorldBuffTracker[realmName][faction][type]["Version"] < version) then
    WorldBuffTracker[realmName][faction][type]["Timestamp"] = time;
    WorldBuffTracker[realmName][faction][type]["Version"] = version;
    WorldBuffTracker[realmName][faction][type]["Sender"] = sender;
    WorldBuffTracker[realmName][faction][type]["Origin"] = sender;
  end
end

function WorldBuffTracker_GetVersionFromString(str)
  local v = tonumber(str) ~= nil and tonumber(str) or 11321;
  if(not HasVersionControlled and v > WorldBuffTracker_GetVersion()) then
    HasVersionControlled = true;
    print("|cFFB90AFF[WorldBuffTracker]|r |cFF30D4FF" .. L["A new update is available."] .. "|r");
  end
  return v;
end

function WorldBuffTracker_BuffIsValid(spell, type)
  for i=1,32 do
    local b,_,_,_,e,f,_ = UnitBuff("player", i);
    if(b == nil) then
      return false;
    end
    if(spell == b and type == 1 and f-GetTime() > 3598) then
      return true;
    elseif(spell == b and f-GetTime() > 7198) then
      return true;
    end
  end
  return false;
end

function WorldBuffTracker_DecToHex(number)
  return string.format("%x", number);
end

function WorldBuffTracker_HexToDec(hex)
  return tonumber(hex, 16);
end

function WorldBuffTracker_Serialize(...)
  local str = "";
  for k, v in ipairs({...}) do
    if(str ~= "") then
      str = str .. "_" .. v;
    else
      str = v;
    end
  end
  return str;
end
