local WP_TargetName
local WP_SavingNote
local WP_MouseoverName
local WP_InputName
local WP_SavingName

local WP_FunctionUsed

local WP_ShowFrameOnClick = nil
local WP_ShowPrintOnClick = true
local _G = getfenv(0)


local Login_EventFrame = CreateFrame("Frame")
Login_EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
Login_EventFrame:SetScript("OnEvent",
	function(self, event, ...)

			--parent box
			local f=WP_InputBox or CreateFrame("Frame","WP_InputBox",UIParent)
			f:SetSize(255,145)
			f:SetPoint("CENTER", 0, 100);
			f:SetBackdrop({
							bgFile = "Interface/DialogFrame/UI-DialogBox-Background-Dark",
							edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
							tile = true,
							tileSize = 32,
							edgeSize = 32,
							insets = { left = 10, right = 10, top = 10, bottom = 10 }
						});
			tinsert(UISpecialFrames,"WP_InputBox");

			--input box for the character name
f=WP_NameBox or CreateFrame("EditBox","WP_NameBox",WP_InputBox,"InputBoxTemplate")
            f:SetSize(180,24)
            f:SetPoint("CENTER", "WP_InputBox", 20, 45);
            f:SetAutoFocus(false)
            f:SetScript("OnEnterPressed",function(s)
                        WP_InputName = (s:GetText())
                        WP_NoteBox:SetFocus()
                    end)
            f:SetScript("OnShow", function(s)
                        WP_InputName = nil
                        if WP_FunctionUsed == true then
                            WP_NameBox:SetText("")
                            if WP_TargetName ~= nil then
                                WP_NameBox:SetText(WP_TargetName)
                                WP_InputName = WP_TargetName
                                WP_NoteBox:SetFocus()
                            end

                            if WP_TargetName == nil then
                                WP_NameBox:SetFocus()
                            end
                        end
                    end)

                    f:SetScript("OnEditFocusGained", function(s)

                        if WP_FunctionUsed == true and WP_TargetName ~= nil then
                            WP_NameBox:SetText("")
                            WP_NameBox:SetText(WP_TargetName)
                            WP_InputName = WP_TargetName
                            WP_NoteBox:SetFocus()
                        end
                    end)

            f:SetScript("OnEditFocusLost", function(s)

                        WP_InputName = (s:GetText())
                    end)

			f:CreateFontString("WP_NameText", OVERLAY, "GameFontNormal")
			WP_NameText:SetPoint("CENTER", "WP_NameBox", -115, 0);
			WP_NameText:SetText("Name:")

			--Input box for the note
f=WP_NoteBox or CreateFrame("EditBox","WP_NoteBox",WP_InputBox,"InputBoxTemplate")
            f:SetSize(180,24)
            f:SetPoint("CENTER", "WP_NameBox", 0, -23);
            f:SetAutoFocus(false)
            f:SetScript("OnEnterPressed",function(s)
                        WP_SavingNote = (s:GetText())
                        WP_SavingName = WP_NameBox:GetText()
                        if WP_SavingName ~= "" then
                            WP_Database[WP_SavingName] = WP_SavingNote
                            WP_InputBox:Hide()
                            UIErrorsFrame:AddMessage("Note Saved", 255, 209, 0)
                        else
							UIErrorsFrame:AddMessage("You cannot save a note without a name.", 255, 0, 0)
                            WP_NameBox:SetFocus()
                        end
                    end)
            f:SetScript("OnShow", function(s)

                        WP_NoteBox:SetText("")
                        if WP_TargetName ~= nil then
                            WP_NoteBox:SetFocus()

                        end
                        if WP_FunctionUsed == true and WP_TargetName ~= nil then
                            WP_NoteBox:SetText("")
                            WP_NoteBox:SetText(WP_Database[WP_TargetName])
                        end
                    end)

            f:SetScript("OnEditFocusGained", function(s)
                        WP_InputNote = (s:GetText())
                        if WP_InputName == nil then
                            WP_NoteBox:SetText("")
                        end
                        if WP_InputNote == "" or WP_InputNote == nil then
                            if WP_Database[WP_InputName] then
                                WP_NoteBox:SetText("")
                                WP_NoteBox:SetText(WP_Database[WP_InputName])
                            end
                        end
                            if WP_FunctionUsed == true and WP_TargetName ~= nil then
								if WP_Database[WP_TargetName] ~= nil then
									WP_NoteBox:SetText("")
									WP_NoteBox:SetText(WP_Database[WP_TargetName])
								else WP_NoteBox:SetText("")
								end
                            end
                        WP_FunctionUsed = false
                    end)

			f:CreateFontString("WP_NoteText", OVERLAY, "GameFontNormal")
			WP_NoteText:SetPoint("CENTER", "WP_NoteBox", -113, 0);
			WP_NoteText:SetText("Note:")


			--Button to save the current note
			local button = CreateFrame("Button","WP_SaveButton",WP_InputBox)
			button:SetPoint("CENTER", WP_NoteBox, "CENTER", -20, -25)
			button:SetWidth(75)
			button:SetHeight(25)

			button:SetText("Save Note")
			button:SetNormalFontObject("GameFontNormal")

			button:SetScript("OnClick", function()
						    WP_SavingNote = (WP_NoteBox:GetText())
							WP_SavingName = WP_NameBox:GetText()
								if WP_SavingName ~= "" then
									WP_Database[WP_SavingName] = WP_SavingNote
									WP_InputBox:Hide()
									UIErrorsFrame:AddMessage("Note Saved", 255, 209, 0)
								else
									UIErrorsFrame:AddMessage("You cannot save a note without a name.", 255, 0, 0)
									WP_NameBox:SetFocus()
								end
							end)

			local ntex = button:CreateTexture()
			ntex:SetTexture("Interface/Buttons/UI-Panel-Button-Up")
			ntex:SetTexCoord(0, 0.625, 0, 0.6875)
			ntex:SetAllPoints()
			button:SetNormalTexture(ntex)

			local htex = button:CreateTexture()
			htex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
			htex:SetTexCoord(0, 0.625, 0, 0.6875)
			htex:SetAllPoints()
			button:SetHighlightTexture(htex)

			local ptex = button:CreateTexture()
			ptex:SetTexture("Interface/Buttons/UI-Panel-Button-Down")
			ptex:SetTexCoord(0, 0.625, 0, 0.6875)
			ptex:SetAllPoints()
			button:SetPushedTexture(ptex)

			--Button to close the interface panel
			local button = CreateFrame("Button","WP_CancelButton",WP_InputBox)
			button:SetPoint("CENTER", WP_SaveButton, "CENTER", 75, 0)
			button:SetWidth(75)
			button:SetHeight(25)

			button:SetText("Cancel")
			button:SetNormalFontObject("GameFontNormal")

			button:SetScript("OnClick", function()
						WP_InputBox:Hide()
						end)

			local ntex = button:CreateTexture()
			ntex:SetTexture("Interface/Buttons/UI-Panel-Button-Up")
			ntex:SetTexCoord(0, 0.625, 0, 0.6875)
			ntex:SetAllPoints()
			button:SetNormalTexture(ntex)

			local htex = button:CreateTexture()
			htex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
			htex:SetTexCoord(0, 0.625, 0, 0.6875)
			htex:SetAllPoints()
			button:SetHighlightTexture(htex)

			local ptex = button:CreateTexture()
			ptex:SetTexture("Interface/Buttons/UI-Panel-Button-Down")
			ptex:SetTexCoord(0, 0.625, 0, 0.6875)
			ptex:SetAllPoints()
			button:SetPushedTexture(ptex)

			--Button to clear the input boxes
			local button = CreateFrame("Button","WP_CancelButton",WP_InputBox)
			button:SetPoint("CENTER", WP_SaveButton, "CENTER", -75, 0)
			button:SetWidth(75)
			button:SetHeight(25)

			button:SetText("Clear")
			button:SetNormalFontObject("GameFontNormal")

			button:SetScript("OnClick", function()
							WP_NameBox:SetText("")
							WP_NoteBox:SetText("")
							WP_NameBox:SetFocus()
							end)

			local ntex = button:CreateTexture()
			ntex:SetTexture("Interface/Buttons/UI-Panel-Button-Up")
			ntex:SetTexCoord(0, 0.625, 0, 0.6875)
			ntex:SetAllPoints()
			button:SetNormalTexture(ntex)

			local htex = button:CreateTexture()
			htex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
			htex:SetTexCoord(0, 0.625, 0, 0.6875)
			htex:SetAllPoints()
			button:SetHighlightTexture(htex)

			local ptex = button:CreateTexture()
			ptex:SetTexture("Interface/Buttons/UI-Panel-Button-Down")
			ptex:SetTexCoord(0, 0.625, 0, 0.6875)
			ptex:SetAllPoints()
			button:SetPushedTexture(ptex)

			--Checkbox frames/text
			f:CreateFontString("WP_CheckBoxText", OVERLAY, "GameFontNormal")
			WP_CheckBoxText:SetPoint("CENTER", "WP_SaveButton", 0, -20);
			WP_CheckBoxText:SetText("Shift-clicking a player's name in chat:")

			f:CreateFontString("WP_ShowFrameText", OVERLAY, "GameFontNormal")
			WP_ShowFrameText:SetPoint("LEFT","WP_CheckBoxText", 0, -15);
			WP_ShowFrameText:SetText("Opens this menu:")

			f:CreateFontString("WP_ShowPrintText", OVERLAY, "GameFontNormal")
			WP_ShowPrintText:SetPoint("LEFT","WP_ShowFrameText", 0, -15);
			WP_ShowPrintText:SetText("Shows the player's note in chat:")

			f=WP_ShowFrameCheckBox or CreateFrame("CheckButton", "WP_ShowFrameCheckBox", WP_InputBox, "ChatConfigCheckButtonTemplate");
			f:SetPoint("RIGHT","WP_ShowFrameText", 23, -1);
			f:SetScript("OnClick", function()
						isChecked = WP_ShowFrameCheckBox:GetChecked()
							if isChecked == true then
								WP_ShowFrameOnClick = true
							end
							if isChecked == false then
								WP_ShowFrameOnClick = false
							end
						end)


			if WP_ShowFrameOnClick == true then
				WP_ShowFrameCheckBox:SetChecked(true)
			end


			f=WP_ShowPrintCheckBox or CreateFrame("CheckButton", "WP_ShowPrintCheckBox", WP_InputBox, "ChatConfigCheckButtonTemplate");
			f:SetPoint("RIGHT","WP_ShowPrintText", 23, -1);
			f:SetScript("OnClick", function()
						isChecked = WP_ShowPrintCheckBox:GetChecked()
							if isChecked == true then
								WP_ShowPrintOnClick = true
							end
							if isChecked == false then
								WP_ShowPrintOnClick = false
							end
						end)

			if WP_ShowPrintOnClick == true then
				WP_ShowPrintCheckBox:SetChecked(true)
			end

			WP_InputBox:Hide()
end)

SLASH_WP_Commands1 = "/tn"
SlashCmdList["WP_Commands"] = function(msg)
	WP_TargetName = UnitName("target")
	WP_FunctionUsed = true
	WP_NameBox:ClearFocus()
	WP_InputBox:Show()
	if WP_FunctionUsed == true then
		WP_NameBox:SetFocus()
	end
end

local function testDropdownMenuButton(self)
	if self.value == "WP_MenuButton" then
		WP_FunctionUsed = true
		WP_NameBox:ClearFocus()
		WP_InputBox:Show()
		if WP_FunctionUsed == true then
			WP_NameBox:SetFocus()
		end
	end
end


hooksecurefunc("ChatFrame_OnHyperlinkShow", function(chatFrame, link, text, button)
if (IsModifiedClick("CHATLINK")) then
  if (link and button) then

    local args = {};
    for v in string.gmatch(link, "[^:]+") do
      table.insert(args, v);
    end
		if (args[1] and args[1] == "player") then
			args[2] = Ambiguate(args[2], "short")
			WP_TargetName = args[2]
			WP_FunctionUsed = true
			WP_NameBox:ClearFocus()
			if WP_ShowFrameOnClick == true then
				WP_NameBox:ClearFocus()
				WP_InputBox:Show()
				if WP_FunctionUsed == true then
					WP_NameBox:SetFocus()
				end
			end
			if WP_InputName == "" or WP_InputName == nil then
				WP_NameBox:ClearFocus()
				if WP_FunctionUsed == true then
					WP_NameBox:SetFocus()
				end
			else
				WP_FunctionUsed = false
			end
			if WP_ShowPrintOnClick == true then
				if WP_Database[WP_TargetName] and WP_Database[WP_TargetName] ~= "" then
					DEFAULT_CHAT_FRAME:AddMessage('WCL评分 ' .. WP_TargetName .. ': ' .. WP_Database[WP_TargetName], 255, 209, 0)
				end
			end
		end
	end
end
end)

hooksecurefunc("UnitPopup_ShowMenu", function(dropdownMenu, which, unit, name, userData)

WP_TargetName = dropdownMenu.name

	if (UIDROPDOWNMENU_MENU_LEVEL > 1) then
	return
	end
		local info = UIDropDownMenu_CreateInfo()
			info.text = 'WCL评分 ' .. WP_TargetName .. ': ' .. WP_Database[WP_TargetName]
			info.owner = which
			info.notCheckable = 1
			info.func = nil
			info.value = "WP_MenuButton"
			UIDropDownMenu_AddButton(info)
end)

GameTooltip:HookScript("OnTooltipSetUnit", function(self)
    local _, unit = self:GetUnit()
--~ 	print("set tooltip 1")

    if UnitExists(unit) then
--~    		print("set tooltip 2")
		WP_MouseoverName = UnitName(unit)
--~ 		print(WP_Database[WP_MouseoverName])

		if WP_Database[WP_MouseoverName] then
			GameTooltip:AddLine(WP_Database[WP_MouseoverName], 255, 209, 0)
--~ 			GameTooltip:Show()
		end
--~ 		GameTooltip:AddLine(WP_Database[WP_MouseoverName], 255, 209, 0)
--~ 		GameTooltip:Show()
	end
end)

local Addon_EventFrame = CreateFrame("Frame")
Addon_EventFrame:RegisterEvent("ADDON_LOADED")
Addon_EventFrame:SetScript("OnEvent",
	function(self, event, addon)
		if addon == "WclPlayerScore" then
			WP_Database = WP_Database or {}
		end
end)


local Chat_EventFrame = CreateFrame("Frame")
Chat_EventFrame:RegisterEvent("CHAT_MSG_SYSTEM")
Chat_EventFrame:SetScript("OnEvent",
	function(self, event, message)
	local name

	name = Deformat(message, _G.WHO_LIST_FORMAT)
--~ 	print("Hook 01" .. name)
	if name then
--~ 		print("Hook 02" .. name)
		if WP_Database[name] then
			print("|cFFFFFF00WCL 评分 " .. name .. ":" .. WP_Database[name] )
		end
	end
end)


-- a dictionary of format to match entity
local FORMAT_SEQUENCES = {
    ["s"] = ".+",
    ["c"] = ".",
    ["%d*d"] = "%%-?%%d+",
    ["[fg]"] = "%%-?%%d+%%.?%%d*",
    ["%%%.%d[fg]"] = "%%-?%%d+%%.?%%d*",
}

-- a set of format sequences that are string-based, i.e. not numbers.
local STRING_BASED_SEQUENCES = {
    ["s"] = true,
    ["c"] = true,
}

local cache = setmetatable({}, {__mode='k'})
-- generate the deformat function for the pattern, or fetch from the cache.
local function get_deformat_function(pattern)
    local func = cache[pattern]
    if func then
        return func
    end

    -- escape the pattern, so that string.match can use it properly
    local unpattern = '^' .. pattern:gsub("([%(%)%.%*%+%-%[%]%?%^%$%%])", "%%%1") .. '$'

    -- a dictionary of index-to-boolean representing whether the index is a number rather than a string.
    local number_indexes = {}

    -- (if the pattern is a numbered format,) a dictionary of index-to-real index.
    local index_translation = nil

    -- the highest found index, also the number of indexes found.
	local highest_index
    if not pattern:find("%%1%$") then
        -- not a numbered format

        local i = 0
        while true do
            i = i + 1
            local first_index
            local first_sequence
            for sequence in pairs(FORMAT_SEQUENCES) do
                local index = unpattern:find("%%%%" .. sequence)
                if index and (not first_index or index < first_index) then
                    first_index = index
                    first_sequence = sequence
                end
            end
            if not first_index then
                break
            end
            unpattern = unpattern:gsub("%%%%" .. first_sequence, "(" .. FORMAT_SEQUENCES[first_sequence] .. ")", 1)
            number_indexes[i] = not STRING_BASED_SEQUENCES[first_sequence]
        end

        highest_index = i - 1
    else
        -- a numbered format

        local i = 0
		while true do
		    i = i + 1
			local found_sequence
            for sequence in pairs(FORMAT_SEQUENCES) do
				if unpattern:find("%%%%" .. i .. "%%%$" .. sequence) then
					found_sequence = sequence
					break
				end
			end
			if not found_sequence then
				break
			end
			unpattern = unpattern:gsub("%%%%" .. i .. "%%%$" .. found_sequence, "(" .. FORMAT_SEQUENCES[found_sequence] .. ")", 1)
			number_indexes[i] = not STRING_BASED_SEQUENCES[found_sequence]
		end
        highest_index = i - 1

		i = 0
		index_translation = {}
		pattern:gsub("%%(%d)%$", function(w)
		    i = i + 1
		    index_translation[i] = tonumber(w)
		end)
    end

    if highest_index == 0 then
        cache[pattern] = do_nothing
    else
        --[=[
            -- resultant function looks something like this:
            local unpattern = ...
            return function(text)
                local a1, a2 = text:match(unpattern)
                if not a1 then
                    return nil, nil
                end
                return a1+0, a2
            end

            -- or if it were a numbered pattern,
            local unpattern = ...
            return function(text)
                local a2, a1 = text:match(unpattern)
                if not a1 then
                    return nil, nil
                end
                return a1+0, a2
            end
        ]=]

        local t = {}
        t[#t+1] = [=[
            return function(text)
                local ]=]

        for i = 1, highest_index do
            if i ~= 1 then
                t[#t+1] = ", "
            end
            t[#t+1] = "a"
            if not index_translation then
                t[#t+1] = i
            else
                t[#t+1] = index_translation[i]
            end
        end

        t[#t+1] = [=[ = text:match(]=]
        t[#t+1] = ("%q"):format(unpattern)
        t[#t+1] = [=[)
                if not a1 then
                    return ]=]

        for i = 1, highest_index do
            if i ~= 1 then
                t[#t+1] = ", "
            end
            t[#t+1] = "nil"
        end

        t[#t+1] = "\n"
        t[#t+1] = [=[
                end
                ]=]

        t[#t+1] = "return "
        for i = 1, highest_index do
            if i ~= 1 then
                t[#t+1] = ", "
            end
            t[#t+1] = "a"
            t[#t+1] = i
            if number_indexes[i] then
                t[#t+1] = "+0"
            end
        end
        t[#t+1] = "\n"
        t[#t+1] = [=[
            end
        ]=]

        t = table.concat(t, "")

        -- print(t)

        cache[pattern] = assert(loadstring(t))()
    end

    return cache[pattern]
end

function Deformat(text, pattern)
    if type(text) ~= "string" then
        error(("Argument #1 to `Deformat' must be a string, got %s (%s)."):format(type(text), text), 2)
    elseif type(pattern) ~= "string" then
        error(("Argument #2 to `Deformat' must be a string, got %s (%s)."):format(type(pattern), pattern), 2)
    end

    return get_deformat_function(pattern)(text)
end


