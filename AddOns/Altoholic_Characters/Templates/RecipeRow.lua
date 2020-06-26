local addonName = "Altoholic"
local addon = _G[addonName]
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

addon:Controller("AltoholicUI.RecipeRow", {
	Update = function(frame, profession, recipeID, color, isLearned, recipeRank, totalRanks)               
		-- ** set the crafted item **
		local craftedItemID, maxMade = DataStore:GetCraftResultItem(recipeID)
		local itemName, itemLink, itemRarity

		if craftedItemID then
			frame.CraftedItem:SetIcon(GetItemIcon(craftedItemID))
			frame.CraftedItem.itemID = craftedItemID
			
			itemName, itemLink, itemRarity = GetItemInfo(craftedItemID)
			local vc = (isLearned) and 1 or 0.3
			frame.CraftedItem.Icon:SetVertexColor(vc, vc, vc)
			if itemRarity then
				frame.CraftedItem:SetRarity(itemRarity)
			end
			
			if maxMade > 1 then
				frame.CraftedItem.Count:SetText(maxMade)
				frame.CraftedItem.Count:Show()
			else
				frame.CraftedItem.Count:Hide()
			end
			frame.CraftedItem:Show()
            if itemName then
			    local _, _, _, hexColor = GetItemQualityColor(itemRarity)
			    recipeText = format("|c%s%s", hexColor, itemName)
		    end
		elseif profession == DataStore:GetLocaleEnchantingName() then
            itemName = DataStore:GetResultItemName(recipeID); itemRarity = 4; maxMade = 1;
            frame.CraftedItem:SetIcon("Interface\\Icons\\Trade_Engraving.blp")
            frame.CraftedItem.itemID = nil
            frame.CraftedItem.Icon:SetVertexColor(1,1,1)
            frame.CraftedItem:SetRarity(itemRarity)
            frame.CraftedItem.Count:Hide()
            frame.CraftedItem:Show()
            recipeText = format("%s%s", color, itemName)
        else
			frame.CraftedItem:Hide()
		end
			
        frame.RecipeLink.Text:SetText(recipeText)
		
		-- ** set the reagents **
		local reagents = DataStore:GetCraftReagents(recipeID)		-- reagents = "2996,2|2318,1|2320,1"
		local index = 1
		
		if reagents then
			for reagent in reagents:gmatch("([^|]+)") do
				local reagentIcon = frame["Reagent" .. index]
				local reagentID, reagentCount = strsplit(",", reagent)
				reagentID = tonumber(reagentID)
				
				if reagentID then
					reagentCount = tonumber(reagentCount)
					
					reagentIcon.itemID = reagentID
					reagentIcon:SetIcon(GetItemIcon(reagentID))
					reagentIcon.Count:SetText(reagentCount)
					reagentIcon.Count:Show()
				
					reagentIcon:Show()
					index = index + 1
				else
					reagentIcon:Hide()
				end				
			end
		end
		
		-- hide unused reagent icons
		while index <= 8 do
			frame["Reagent" .. index]:Hide()
			index = index + 1
		end

		frame:Show()
	end,
})
