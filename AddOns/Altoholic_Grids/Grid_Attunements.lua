local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local raids = { C_Map.GetAreaInfo(2717), C_Map.GetAreaInfo(2159), C_Map.GetAreaInfo(2677), C_Map.GetAreaInfo(3456) }

local callbacks = {
	OnUpdate = function() end,
	GetSize = function() return #raids end,
	RowSetup = function(self, rowFrame, dataRowID)
            rowFrame.Name.Text:SetText(raids[dataRowID])
            rowFrame.Name.Text:SetJustifyH("RIGHT")
		end,
	RowOnEnter = function()	end,
	RowOnLeave = function() end,
	ColumnSetup = function(self, button, dataRowID, character)
			button.Background:SetDesaturated(false)
			button.Background:SetVertexColor(1.0, 1.0, 1.0)
			button.Background:SetTexCoord(0, 1, 0, 1)
			
			button.Name:SetFontObject("NumberFontNormalSmall")
			button.Name:SetJustifyH("RIGHT")
			button.Name:SetPoint("BOTTOMRIGHT", 0, 0)

            button.key = character
			
			if dataRowID == 1 then
                -- Molten Bore
                button.Background:SetTexture("Interface\\ICONS\\Spell_Fire_LavaSpawn")
                if DataStore:IsQuestCompletedBy(character, 7848) then -- there is also 7487, but seems to be unused?
                    button.Name:SetText(addon.Icons.ready)
                else
                    button.Name:SetText(addon.Icons.notReady)
                end
                
            elseif dataRowID == 2 then
                -- Onyxia
                button.Background:SetTexture("Interface\\ICONS\\inv_jewelry_talisman_11")
                button.Name:SetText(addon.Icons.notReady)
                local containers = DataStore:GetContainers(character)
	            if containers then
		            for containerName, container in pairs(containers) do
			            for slotID = 1, container.size do
				            itemID = DataStore:GetSlotInfo(container, slotID)
				            if itemID and (itemID == 16309) then
				                local bagNum = tonumber(string.sub(containerName, 4))
				                if (bagNum >= 0) and (bagNum <= 4) then
					               button.Name:SetText(addon.Icons.ready)
				                else
					               button.Name:SetText("B")
				                end
                                break			
			                end
				        end
			        end
		        end
                currentResultLocation = L["Equipped"]
	            local inventory = DataStore:GetInventory(character)
	            if inventory then
		            for _, v in pairs(inventory) do
                    	if type(item) == "string" then		-- convert a link to its item id, only data saved
		                    item = tonumber(item:match("item:(%d+)"))	
	                    end
			            if item == 16309 then
                            button.Name:SetText(addon.Icons.ready)
                            break
                        end
		            end
	            end
                
            elseif dataRowID == 3 then
                -- BWL
                button.Background:SetTexture("Interface\\ICONS\\INV_Misc_Head_Dragon_Black")
                if DataStore:IsQuestCompletedBy(character, 7761) then -- there is also 7487, but seems to be unused?
                    button.Name:SetText(addon.Icons.ready)
                else
                    button.Name:SetText(addon.Icons.notReady)
                end
                
            elseif dataRowID == 4 then
                -- Naxx
                button.Background:SetTexture("Interface\\ICONS\\INV_Armor_Shield_Naxxramas_D_01")
                if DataStore:IsQuestCompletedBy(character, 9121) or DataStore:IsQuestCompletedBy(character, 9122) or DataStore:IsQuestCompletedBy(character, 9123) then
                    button.Name:SetText(addon.Icons.ready)
                else
                    button.Name:SetText(addon.Icons.notReady)
                end
            
            end    
			
			button.id = dataRowID
		end,
		
	OnEnter = function(frame) 
		end,
	OnClick = function(frame, button)
		end,
	OnLeave = function(self) 
		end,
	InitViewDDM = function(frame, title) 
			frame:Hide()
			title:Hide()
		end,
}

AltoholicTabGrids:RegisterGrid(5, callbacks)
