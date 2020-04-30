WorldBuffTrackerNPCs = {
  ["enUS"] = {
    ["Horde"] = {
      ["Thrall"] = 1, ["Overlord Runthak"] = 2, ["High Overlord Saurfang"] = 3,
    },
    ["Alliance"] = {
      ["Major Mattingly"] = 2, ["Field Marshal Afrasiabi"] = 3,
    },
  },
  ["deDE"] = {
    ["Horde"] = {
      ["Thrall"] = 1, ["Oberanführer Runthak"] = 2, ["Hochfürst Saurfang"] = 3,
    },
    ["Alliance"] = {
      ["Major Mattingly"] = 2, ["Feldmarschall Afrasiabi"] = 3,
    },
  },
  ["zhCN"] = {
    ["Horde"] = {
      ["萨尔"] = 1, ["伦萨克"] = 2, ["萨鲁法尔大王"] = 3,
    },
    ["Alliance"] = {
      ["玛丁雷少校"] = 2, ["艾法希比元帅"] = 3,
    },
  },
  ["frFR"] = {
    ["Horde"] = {
      ["Thrall"] = 1, ["Seigneur Runthak"] = 2, ["Haut seigneur Saurfang"] = 3,
    },
    ["Alliance"] = {
      ["Major Mattingly"] = 2, ["Grand maréchal Afrasiabi"] = 3,
    },
  },
  ["koKR"] = {
    ["Horde"] = {
      ["스랄"] = 1, ["대군주 룬탁"] = 2, ["대군주 사울팽"] = 3,
    },
    ["Alliance"] = {
      ["상사 매팅글리"] = 2, ["야전사령관 아프라샤비"] = 3,
    },
  },
  ["ruRU"] = {
    ["Horde"] = {
      ["Тралл"] = 1, ["Властитель Рунтак"] = 2, ["Верховный правитель Саурфанг"] = 3,
    },
    ["Alliance"] = {
      ["Майор Маттингли"] = 2, ["Фельдмаршал Афрасиаби"] = 3,
    },
  },
  ["esES"] = {
    ["Horde"] = {
      ["Thrall"] = 1, ["Señor Supremo Runthak"] = 2, ["Alto Señor Supremo Colmilloturbo"] = 3,
    },
    ["Alliance"] = {
      ["Mayor Mattingly"] = 2, ["Alguacil de campo Afrasiabi"] = 3,
    },
  },
  ["esMX"] = {
    ["Horde"] = {
      ["Thrall"] = 1, ["Señor Supremo Runthak"] = 2, ["Alto Señor Supremo Colmilloturbo"] = 3,
    },
    ["Alliance"] = {
      ["Mayor Mattingly"] = 2, ["Alguacil de campo Afrasiabi"] = 3,
    },
  },
  ["ptBR"] = {
    ["Horde"] = {
      ["Thrall"] = 1, ["Lorde Supremo Runthak"] = 2, ["Lorde Supremo Saurfang"] = 3,
    },
    ["Alliance"] = {
      ["Major Valadão"] = 2, ["Marechal de Campo Afrasiabi"] = 3,
    },
  },
}
WorldBuffTrackerSpells = {
  ["enUS"] = {
    ["Warchief's Blessing"] = 1, ["Rallying Cry of the Dragonslayer"] = 2,
  },
  ["deDE"] = {
    ["Segen des Kriegshäuptlings"] = 1, ["Schlachtruf der Drachentöter"] = 2,
  },
  ["zhCN"] = {
    ["酋长的祝福"] = 1, ["屠龙者的咆哮"] = 2,
  },
  ["frFR"] = {
    ["Bénédiction du chef de guerre"] = 1, ["Cri de ralliement du tueur de dragon"] = 2,
  },
  ["koKR"] = {
    ["대족장의 축복"] = 1, ["용사냥꾼 재집결의 외침"] = 2,
  },
  ["ruRU"] = {
    ["Благословление вождя"] = 1, ["Ободряющий клич Драконоборца"] = 2,
  },
  ["esES"] = {
    ["Bendición de Jefe de Guerra"] = 1, ["Recobrar el llanto del cazadragones"] = 2,
  },
  ["esMX"] = {
    ["Bendición de Jefe de Guerra"] = 1, ["Recobrar el llanto del cazadragones"] = 2,
  },
  ["ptBR"] = {
    ["Bênção do Chefe Guerreiro"] = 1, ["Brado Empolgante do Mata-dragões"] = 2,
  }
}
WorldBuffTrackerSpellsInverse = {}

local LOCALE = GetLocale()
local _, L = ...
setmetatable(L, { __index = function(t, k)
	local v = tostring(k)
	rawset(t, k, v)
	return v
end })

if(LOCALE == "enUS") then
  L["ThrallYell"] = "Honor your heroes!"
  L["DMFFortune"] = "Sayge's Dark Fortune of "
  L["DMF"] = "Darkmoon Faire"
  return
--Thanks to Matthinator
elseif(LOCALE == "deDE") then
  L["Possible %s buff incoming."] = "Möglicherweise %s bevorstehend."
  L["Guild announce: disabled."] = "Gildenankündigung: deaktiviert."
  L["Guild announce: enabled."] = "Gildenankündigung: aktiviert."
  L["Version announce: disabled."] = "Versionsankündigung: deaktiviert."
  L["Version announce: enabled."] = "Versionsankündigung: aktiviert."
  L["Popped: %s"] = "Benutzt: %s"
  L["Killed: %s"] = "Getötet: %s"
  L["Next: %s"] = "Nächster: %s"
  L["Onyxia"] = "Onyxia"
  L["Nefarian"] = "Nefarian"
  L["A new update is available."] = "Ein neues Update ist verfügbar."
  return
elseif(LOCALE == "zhCN") then
  return
elseif(LOCALE == "frFR") then
  return
elseif(LOCALE == "koKR") then
  return
elseif(LOCALE == "ruRU") then
  return
elseif(LOCALE == "esES" or LOCALE == "esMX") then
  return
elseif(LOCALE == "ptBR") then
  return
end
