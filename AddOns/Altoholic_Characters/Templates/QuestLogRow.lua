local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

addon:Controller("AltoholicUI.QuestLogRow", { "AltoholicUI.Formatter", function(formatter)
	return {
		SetName = function(frame, name, level)
            if (not name) then name = "" end
			frame.Name.Text:SetText(format("%s[%s%d%s] |r%s", colors.white, colors.cyan, level, colors.white, name))
		end,
		SetInfo = function(frame, isComplete, isDaily, groupSize, money)
			local infos = {}
		
			local moneyText = ""
			if money and money > 0 then
				moneyText = formatter.MoneyString(money or 0, colors.white)
			end
			
			if moneyText ~= "" then table.insert(infos, moneyText) end
			if isComplete then table.insert(infos, format("%s%s", colors.green, COMPLETE)) end
			if isDaily then table.insert(infos, format("%s%s", colors.cyan, DAILY)) end
			if (groupSize) then table.insert(infos, groupSize) end
		
			frame.Info:SetText(table.concat(infos,	" / "))
		end,
		SetType = function(frame, tagID)
			local icon = frame.QuestType.Icon
			
			-- Use the known in-game icons, if proper coords exists
			local tagCoords = QUEST_TAG_TCOORDS[tagID]
			if tagCoords then
				icon:SetTexture("Interface\\QuestFrame\\QuestTypeIcons")
				icon:SetTexCoord(unpack(tagCoords))
            else
				icon:SetTexture("Interface\\LFGFrame\\LFGIcon-Quest")
				icon:SetTexCoord(0, 1, 0, 1)
			end
			icon:Show()
		end,
		SetRewards = function(frame)
		end,

		Name_OnEnter = function(frame)
			local id = frame:GetID()
			if id == 0 then return end

			local character = addon.Tabs.Characters:GetAltKey()
			local questName, questID, _, groupName, level, groupSize, tag, isComplete, isDaily, isTask, isBounty, isStory, isHidden, isSolo, questDescription, objectives = DataStore:GetQuestLogInfo(character, id)

            -- On retail, we use GameTooltip:SetHyperlink and pass in the quest link
            -- Now to recreate what it does...
			GameTooltip:ClearLines()
			GameTooltip:SetOwner(frame.Name, "ANCHOR_LEFT")
			GameTooltip:AddLine(questName)
			GameTooltip:AddLine(" ",1,1,1)
            GameTooltip:AddLine(questDescription,1,1,1,true)
            GameTooltip:AddLine(" ",1,1,1)
            
            if objectives then
                if (#objectives > 0) then
                    GameTooltip:AddLine(QUEST_TOOLTIP_REQUIREMENTS)
                end
                for _, objective in pairs(objectives) do
                    GameTooltip:AddLine(objective.text,1,1,1)
                end
                GameTooltip:AddLine(" ",1,1,1)
            end
			
            GameTooltip:AddDoubleLine(format("%s: %s%d", LEVEL, colors.teal, level), format("%s: %s%d", L["QuestID"], colors.teal, questID))
			
			local player = addon.Tabs.Characters:GetAlt()
			addon:ListCharsOnQuest(questName, player, GameTooltip)
			GameTooltip:Show()
		end,
		Name_OnClick = function(frame, button)
			if button ~= "LeftButton" or not IsShiftKeyDown() then return end

			local chat = ChatEdit_GetLastActiveWindow()
			if not chat:IsShown() then return end
			
			local id = frame:GetID()
			if id == 0 then return end
			
			local character = addon.Tabs.Characters:GetAltKey()
			local _, _, link = DataStore:GetQuestLogInfo(character, id)
			if link then
				chat:Insert(link)
			end
		end,
	}
end})
