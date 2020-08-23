local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local keys = {6893, 7146, 11000, 11140, 12382, 13704, 18249}

local callbacks = {
	OnUpdate = function() end,
	GetSize = function() return #keys end,
	RowSetup = function(self, rowFrame, dataRowID)
            local item = Item:CreateFromItemID(keys[dataRowID])
            item:ContinueOnItemLoad(function()
                rowFrame.Name.Text:SetText("|c".. select(4, GetItemQualityColor(item:GetItemQuality())) .. item:GetItemName())
		      	rowFrame.Name.Text:SetJustifyH("RIGHT")
            end)
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
			
			local item = keys[dataRowID] DataStore:GetInventoryItem(character, keys[dataRowID])
			if item then
				button.key = character
				
				button.Background:SetTexture(GetItemIcon(item))
				
                local bagCount, bankCount = DataStore:GetContainerItemCount(character, item)
                if bagCount > 0 or bankCount > 0 then
				    button.Name:SetText(addon.Icons.ready)
                else
                    button.Name:SetText(addon.Icons.notReady)
                end
			else
				button.key = nil
				button.Background:SetTexture(addon:GetEquipmentSlotIcon(dataRowID))
				button.Name:SetText("")
			end
			
			button.id = dataRowID
		end,
		
	OnEnter = function(frame) 
			local character = frame.key
			if not character then return end

			local item = keys[frame.id]
			if not item then return end

			GameTooltip:SetOwner(frame, "ANCHOR_LEFT")
			local link
			if type(item) == "number" then
				link = select(2, GetItemInfo(item))
			else
				link = item
			end
			
			if not link then
				GameTooltip:AddLine(L["Unknown link, please relog this character"],1,1,1)
				GameTooltip:Show()
				return
			end
			
			GameTooltip:SetHyperlink(link)
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(colors.green .. L["Right-Click to find an upgrade"])
			GameTooltip:Show()
		end,
	OnClick = function(frame, button)
		end,
	OnLeave = function(self)
			GameTooltip:Hide() 
		end,
	InitViewDDM = function(frame, title) 
			frame:Hide()
			title:Hide()
		end,
}

AltoholicTabGrids:RegisterGrid(4, callbacks)
