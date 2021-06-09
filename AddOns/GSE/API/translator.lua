local GSE = GSE
local Statics = GSE.Static

local GNOME = Statics.DebugModules["Translator"]

local L = GSE.L

--- GSE.TranslateSequence will translate from local spell name to spell id and back again.\
-- Mode of "STRING" will return local names where mode "ID" will return id's
-- dropAbsolute will remove "$$" from the start of lines.
function GSE.TranslateSequence(sequence, sequenceName, mode, dropAbsolute)

    GSE.PrintDebugMessage("GSE.TranslateSequence  Mode: " .. mode, GNOME)

    for k, v in ipairs(sequence) do
        -- Translate Sequence
        sequence[k] = GSE.TranslateString(v, mode,nil,  dropAbsolute)
    end

    if not GSE.isEmpty(sequence.KeyRelease) then
        for k, v in pairs(sequence.KeyRelease) do
            sequence.KeyRelease[k] = GSE.TranslateString(v, mode, nil, dropAbsolute)
        end
    else
        GSE.PrintDebugMessage("empty Keyrelease in translate", Statics.Translate)
    end
    if not GSE.isEmpty(sequence.KeyPress) then
        GSE.PrintDebugMessage("Keypress has stuff in translate", Statics.Translate)
        for k, v in pairs(sequence.KeyPress) do
            -- Translate KeyRelease
            sequence.KeyPress[k] = GSE.TranslateString(v, mode, nil, dropAbsolute)
        end
    else
        GSE.PrintDebugMessage("empty Keypress in translate", Statics.Translate)
    end
    if not GSE.isEmpty(sequence.PreMacro) then
        GSE.PrintDebugMessage("Keypress has stuff in translate", Statics.Translate)
        for k, v in pairs(sequence.PreMacro) do
            -- Translate KeyRelease
            sequence.PreMacro[k] = GSE.TranslateString(v, mode, nil, dropAbsolute)
        end
    else
        GSE.PrintDebugMessage("empty Keypress in translate", Statics.Translate)
    end
    if not GSE.isEmpty(sequence.PostMacro) then
        GSE.PrintDebugMessage("Keypress has stuff in translate", Statics.Translate)
        for k, v in pairs(sequence.PostMacro) do
            -- Translate KeyRelease
            sequence.PostMacro[k] = GSE.TranslateString(v, mode, nil, dropAbsolute)
        end
    else
        GSE.PrintDebugMessage("empty Keypress in translate", Statics.Translate)
    end

    -- Check for blanks
    for i, v in ipairs(sequence) do
        if v == "" then
            sequence[i] = nil
        end
    end
    return sequence
end

--- This function interates through each line in lines and does a string replace on each varible in the variableTable
function GSE.ProcessVariables(lines, variableTable)
    --print("GSE.ProcessVariables(lines, variableTable)")
    local returnLines = {}
    --print(GSE.isEmpty(variableTable))
    for _, line in ipairs(lines) do
        if not GSE.isEmpty(variableTable) then
            for key,value in pairs(variableTable) do
                if type(value) == "string" then
                    local functline = value
                    if string.sub(functline, 1, 10) == "function()" then
                        functline = string.sub(functline, 11)
                        functline = functline:sub(1, -4)
                        functline = loadstring(functline)
                        --print(type(functline))
                        if functline ~= nil then
                            value = functline
                        end
                    end
                end
                --print("updated Type: ".. type(value))
                --print(value)
                if type(value) == "function" then
                    value = value()
                end
                line = string.gsub(line, string.format("~~%s~~", key), value)
            end
        end

        for key,value in pairs(Statics.SystemVariables) do
            if type(value) == "function" then
                value = value()
            end
            local oldline = line
            line = string.gsub(line, string.format("~~%s~~", key), value)
        end
        table.insert(returnLines, line)
    end
    return returnLines
end

function GSE.TranslateString(instring, mode, cleanNewLines, dropAbsolute)
    instring = GSE.UnEscapeString(instring)
    GSE.PrintDebugMessage("Entering GSE.TranslateString with : \n" .. instring .. "\n " .. mode, GNOME)
    local output = ""
    if not GSE.isEmpty(instring) then
        local absolute = false
        if instring:find('$$', 1, true) then
            GSE.PrintDebugMessage("Setting Absolute", GNOME)
            absolute = true
        end
        if GSE.isEmpty(string.find(instring, '--', 1, true)) then
            for cmd, etc in string.gmatch(instring or '', '/(%w+)%s+([^\n]+)') do
                GSE.PrintDebugMessage("cmd : \n" .. cmd .. " etc: " .. etc, GNOME)
                output = output .. GSEOptions.WOWSHORTCUTS .. "/" .. cmd .. Statics.StringReset .. " "
                if string.lower(cmd) == "use" then
                    local conditionals, mods, trinketstuff = GSE.GetConditionalsFromString(etc)
                    if conditionals then
                        output = output .. mods .. " "
                        GSE.PrintDebugMessage("GSE.TranslateSpell conditionals found ", GNOME)
                    end
                    GSE.PrintDebugMessage("output: " .. output .. " mods: " .. mods .. " etc: " .. etc, GNOME)

                    output = output .. GSEOptions.KEYWORD .. trinketstuff .. Statics.StringReset

                elseif Statics.CastCmds[string.lower(cmd)] then
                    if not cleanNewLines then
                        etc = string.match(etc, "^%s*(.-)%s*$")
                    end
                    if string.sub(etc, 1, 1) == "!" then
                        etc = string.sub(etc, 2)
                        output = output .. "!"
                    end
                    local foundspell, returnval = GSE.TranslateSpell(etc, mode,
                                                      (cleanNewLines and cleanNewLines or false), absolute)
                    if foundspell then
                        output = output .. GSEOptions.KEYWORD .. returnval .. Statics.StringReset
                    else
                        GSE.PrintDebugMessage("Did not find : " .. etc, GNOME)
                        output = output .. etc
                    end
                    -- Check for cast Sequences
                elseif string.lower(cmd) == "castsequence" then
                    GSE.PrintDebugMessage("attempting to split : " .. etc, GNOME)
                    for x, y in ipairs(GSE.split(etc, ";")) do
                        for _, w in ipairs(GSE.SplitCastSequence(y, ",")) do
                            -- Look for conditionals at the startattack
                            local conditionals, mods, uetc = GSE.GetConditionalsFromString(w)
                            if conditionals then
                                output = output .. GSEOptions.STANDARDFUNCS .. mods .. Statics.StringReset .. " "
                            end

                            if not cleanNewLines then
                                w = string.match(uetc, "^%s*(.-)%s*$")
                            end
                            if string.sub(uetc, 1, 1) == "!" then
                                uetc = string.sub(uetc, 2)
                                output = output .. "!"
                            end
                            local foundspell, returnval = GSE.TranslateSpell(uetc, mode,
                                                              (cleanNewLines and cleanNewLines or false), asbolute)
                            output = output .. GSEOptions.KEYWORD .. returnval .. Statics.StringReset .. ", "
                        end
                        output = output .. ";"
                    end
                    output = string.sub(output, 1, string.len(output) - 1)
                    local resetleft = string.find(output, ", , ")
                    if not GSE.isEmpty(resetleft) then
                        output = string.sub(output, 1, resetleft - 1)
                    end
                    if string.sub(output, string.len(output) - 1) == ", " then
                        output = string.sub(output, 1, string.len(output) - 2)
                    end

                else
                    -- Pass it through
                    output = output .. " " .. etc

                end
            end
            -- look for single line commands and mark them up
            for k, v in ipairs(Statics.MacroCommands) do
                output = string.gsub(output, "/" .. v, GSEOptions.WOWSHORTCUTS .. "/" .. v .. Statics.StringReset)
            end
        else
            GSE.PrintDebugMessage("Detected Comment " .. string.find(instring, '--', 1, true), GNOME)
            output = output .. GSEOptions.CONCAT .. instring .. Statics.StringReset
        end
        -- If nothing was found, pass through
        if output == "" then
            output = instring
            -- look for single line commands and mark them up
            for k, v in ipairs(Statics.MacroCommands) do
                output = string.gsub(output, "/" .. v, GSEOptions.WOWSHORTCUTS .. "/" .. v .. Statics.StringReset)
            end
        end

        if GSE.isEmpty(dropAbsolute) then
            dropAbsolute = false
        end
        if  absolute and not dropAbsolute then
            output = "$$" .. output
        end
    elseif cleanNewLines then
        output = output .. instring
    end
    GSE.PrintDebugMessage("Exiting GSE.TranslateString with : \n" .. output, GNOME)
    -- Check for random "," at the end
    if string.sub(output, string.len(output) - 1) == ", " then
        output = string.sub(output, 1, string.len(output) - 2)
    end
    output = string.gsub(output, ", ;", "; ")

    output = string.gsub(output, "  ", " ")
    return output
end

function GSE.TranslateSpell(str, mode, cleanNewLines, absolute)
    local output = ""
    local found = false
    -- Check for cases like /cast [talent:7/1] Bladestorm;[talent:7/3] Dragon Roar
    if not cleanNewLines then
        str = string.match(str, "^%s*(.-)%s*$")
    end
    GSE.PrintDebugMessage("GSE.TranslateSpell Attempting to translate " .. str, GNOME)
    if string.sub(str, string.len(str)) == "," then
        str = string.sub(str, 1, string.len(str) - 1)
    end
    if string.match(str, ";") then
        GSE.PrintDebugMessage("GSE.TranslateSpell found ; in " .. str .. " about to do recursive call.", GNOME)
        for _, w in ipairs(GSE.split(str, ";")) do
            found, returnval = GSE.TranslateSpell((cleanNewLines and w or string.match(w, "^%s*(.-)%s*$")), mode,
                                   (cleanNewLines and cleanNewLines or false))
            output = output .. GSEOptions.KEYWORD .. returnval .. Statics.StringReset .. "; "
        end
        if string.sub(output, string.len(output) - 1) == "; " then
            output = string.sub(output, 1, string.len(output) - 2)
        end
    else
        local conditionals, mods, etc = GSE.GetConditionalsFromString(str)
        if conditionals then
            output = output .. mods .. " "
            GSE.PrintDebugMessage("GSE.TranslateSpell conditionals found ", GNOME)
        end
        GSE.PrintDebugMessage("output: " .. output .. " mods: " .. mods .. " etc: " .. etc, GNOME)
        if not cleanNewLines then
            etc = string.match(etc, "^%s*(.-)%s*$")
        end
        if mode == "CURRENT" then
            if GSEOptions.showCurrentSpells then
                local test = tonumber(etc)
                if test then
                    local currentSpell = FindSpellOverrideByID(etc)
                    if currentSpell then
                        etc = currentSpell
                    end
                end
            end
            mode = "STRING"
        end
        local foundspell = GSE.GetSpellId(etc, mode, absolute)

       -- print("Foudn Spell: " .. foundspell .. " etc:" .. etc .. " mode:" .. mode .. " str:" .. str)

        if foundspell then
            GSE.PrintDebugMessage("Translating Spell ID : " .. etc .. " to " .. foundspell, GNOME)
            output = output .. GSEOptions.KEYWORD .. foundspell .. Statics.StringReset
            found = true
        else
            GSE.PrintDebugMessage("Did not find : " .. etc .. ".  Spell may no longer exist", GNOME)
            output = output .. GSEOptions.UNKNOWN .. etc .. Statics.StringReset
            if GSE.isEmpty(GSEOptions.UnfoundSpells) then
                GSEOptions.UnfoundSpells = {}
            end
            GSEOptions.UnfoundSpells[etc] = true
        end
    end
    return found, output
end

function GSE.GetConditionalsFromString(str)
    GSE.PrintDebugMessage("Entering GSE.GetConditionalsFromString with : " .. str, GNOME)
    -- Check for conditionals
    local found = false
    local mods = ""
    local leftstr
    local rightstr
    local leftfound = false
    for i = 1, #str do
        local c = str:sub(i, i)
        if c == "[" and not leftfound then
            leftfound = true
            leftstr = i
        end
        if c == "]" then
            rightstr = i
        end
    end
    GSE.PrintDebugMessage("checking left : " .. (leftstr and leftstr or "nope"), GNOME)
    GSE.PrintDebugMessage("checking right : " .. (rightstr and rightstr or "nope"), GNOME)
    if rightstr and leftstr then
        found = true
        GSE.PrintDebugMessage("We have left and right stuff", GNOME)
        mods = string.sub(str, leftstr, rightstr)
        GSE.PrintDebugMessage("mods changed to: " .. mods, GNOME)
        str = string.sub(str, rightstr + 1)
        GSE.PrintDebugMessage("str changed to: " .. str, GNOME)
    end
    if not cleanNewLines then
        str = string.match(str, "^%s*(.-)%s*$")
    end
    -- Check for resets
    GSE.PrintDebugMessage("checking for reset= in " .. str, GNOME)
    local resetleft = string.find(str, "reset=")
    if not GSE.isEmpty(resetleft) then
        GSE.PrintDebugMessage("found reset= at" .. resetleft, GNOME)
    end

    local rightfound = false
    local resetright = 0
    if resetleft then
        for i = 1, #str do
            local c = str:sub(i, i)
            if c == " " then
                if not rightfound then
                    resetright = i
                    rightfound = true
                end
            end
        end
        mods = mods .. " " .. string.sub(str, resetleft, resetright)
        GSE.PrintDebugMessage("reset= mods changed to: " .. mods, GNOME)
        str = string.sub(str, resetright + 1)
        GSE.PrintDebugMessage("reset= test str changed to: " .. str, GNOME)
        found = true
    end

    mods = GSEOptions.COMMENT .. mods .. Statics.StringReset
    return found, mods, str
end

--- This option reports on language table errors and omissions.  It is accessible
-- via the command line /gs compilemissingspells and saves this informationm into
-- GSE.lua under GSEOptions.UnfoundSpellIDs, GSEOptions.UnfoundSpells and GSEOptions.ErroneousSpellID
-- This information is used by the GSEUtils that generates the enUS.lua, enUSHash.lua and enUSSHADOW.lua files.
function GSE.ReportUnfoundSpells()
    GSEOptions.UnfoundSpells = {}
    for classid, macroset in ipairs(GSE.Library) do
        for name, version in pairs(macroset) do
            for v, sequence in ipairs(version) do
                GSE.TranslateSequenceFromTo(sequence, "enUS", "enUS", name)
            end
        end
    end
    GSEOptions.UnfoundSpellIDs = {}

    for _, spell in pairs(GSEOptions.UnfoundSpells) do
        GSEOptions.UnfoundSpellIDs[spell] = GetSpellInfo(spell)
    end

end


local function ClassicGetSpellInfo(spellID)
    local name, rank, icon, castTime, minRange, maxRange, sid = GetSpellInfo(spellID);
    -- only check rank if classic.
    if GSE.GameMode < 3 then
        if GSE.isEmpty(rank) then
            if GSE.GetCurrentClassID() ~= 1 and GSE.GetCurrentClassID() ~= 4 then
                -- -- check if the rank is the same as the highest.
                -- -- print("no rank found for " .. spellID)
                -- rank = GetSpellRank(spellID)
                if pcall(function()
                    tonumber(spellID)
                end) then
                    --print("pcall passed")
                --     rank = GetSpellRank(tonumber(spellID))
                --     local testName, _, _, _, _, _, testid = GetSpellInfo(name);
                --     -- print(testName, testid, spellID, rank)
                --     local testRank = GetSpellRank(tonumber(testid))
                --     if testRank == rank then
                --         rank = nil
                --     end
                --     -- else
                --     -- print("pcall failed:", err)
                    rank = GetSpellSubtext(spellID)
                 end
            else
                -- dont set a rank for warriors and rogues
                -- print("Warrior or Rogue")
                rank = nil
            end
        end
        -- print("Did rank check found: " .. (rank or "No Rank"))
    end
    -- allows for a trinket to be part of a castsequence.
    if tostring(spellID) == "13" or tostring(spellID) == "14" then
        name = tostring(spellID)
        sid = tonumber(spellID)
    end
    return name, rank, icon, castTime, minRange, maxRange, sid;
end

--- Test override of GetSpellInfo
function GSE.ClassicGetSpellInfo(spellID)
    return ClassicGetSpellInfo(spellID)
end

--- Converts a string spell name to an id and back again.
function GSE.GetSpellId(spellstring, mode, absolute)
    if GSE.isEmpty(mode) then
        mode = ""
    end
    local returnval = ""
    local name, rank, icon, castTime, minRange, maxRange, spellId = ClassicGetSpellInfo(spellstring)
    if mode == "STRING" then
        if not GSE.isEmpty(rank) then
            returnval = name .. "(" .. rank .. ")"
        else
            returnval = name
        end
    else
        returnval = spellId
        if GSE.GameMode > 2 then
            -- If we are not in classic
            -- Check for overrides like Crusade and Avenging Wrath.
            if not absolute and not GSE.isEmpty(returnval) then
                if FindBaseSpellByID(returnval) then
                    returnval = FindBaseSpellByID(returnval)
                end
                -- Still need Heart of Azeroth overrides.
                if not GSE.isEmpty(Statics.BaseSpellTable[returnval]) then
                    returnval = Statics.BaseSpellTable[returnval]
                end
            end
        end
    end
    if not GSE.isEmpty(returnval) then
        GSE.PrintDebugMessage("Converted " .. spellstring .. " to " .. returnval .. " using mode " .. mode, "Translator")
    else
        if not GSE.isEmpty(spellstring) then
            GSE.PrintDebugMessage(spellstring .. " was not found", "Translator")
        else
            GSE.PrintDebugMessage("Nothing was there to be found", "Translator")
        end
    end
    -- print("returning " .. returnval .. " from " .. spellstring)
    return returnval
end

--- Takes a section of a sequence and returns the spells used.
function GSE.IdentifySpells(tab)
    local foundspells = {}
    local returnval = ""
    for _, p in ipairs(tab) do
        -- Run a regex to find all spell id's from the table and add them to the table foundspells
        for m in string.gmatch(p, "%w%d+") do

            foundspells[m] = 1
        end
    end

    for k, v in pairs(foundspells) do
        if not GSE.isEmpty(GSE.GetSpellId(k, "STRING", false)) then
            local wowheaddata = "spell="..k
            local domain = "www"
            if GSE.GameMode == 1 then
                wowheaddata = wowheaddata .. "?domain=classic"
                domain = "classic"
            elseif GSE.GameMode == 2 then
                wowheaddata = wowheaddata .. "?domain=classic"
                domain = "tbc"
            end
            returnval = returnval .. '<a href="http://www.wowhead.com/spell=' .. k .. '" data-wowhead="' .. wowheaddata .. '">' ..
                            GSE.GetSpellId(k, "STRING", false) .. '</a>, '
        end
    end

    return string.sub(returnval, 1, string.len(returnval) - 2), foundspells
end

GSE.TranslatorAvailable = true
