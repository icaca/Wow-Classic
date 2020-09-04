local addonName = "Altoholic"
local addon = _G[addonName]

-- File backported from Altoholic v3.2.002 by Teelo-Arugal-US

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"

local INITIAL_OFFSET_X = 25				-- constants used for positioning talents
local INITIAL_OFFSET_Y = 15
local TALENT_OFFSET_X = 40
local TALENT_OFFSET_Y = 40

local function BranchSetTexture(self, branchType, x, y)
	local branch = _G["AltoholicTabCharacters_TalentFrame" .. self.index .. "_Branch" .. self.BranchCount]
	local tc = TALENT_BRANCH_TEXTURECOORDS[branchType][1]
	
	branch:SetTexCoord(tc[1], tc[2], tc[3], tc[4]);
	branch:SetPoint("TOPLEFT",	_G["AltoholicTabCharacters_TalentFrame" .. self.index], "TOPLEFT", x, y)
	branch:Show()
	
	self.BranchCount = self.BranchCount + 1
end

addon:Controller("AltoholicUI.TalentPanel", {
	OnBind = function(frame)	
	end,
	Update = function(frame)
    	
    	AltoholicTabCharacters.Talents:Hide()
    	
    	local character = Altoholic.Tabs.Characters:GetAltKey()
    	if not character then return end
    	
    	local DS = DataStore
    	local _, class = DS:GetCharacterClass(character)
    	if not DS:IsClassKnown(class) then return end

    	local index = 1
    	for tree in DS:GetClassTrees(class) do
            frame.index = index
            treeName = DS:GetTreeNameByID(class, index)
        
            -- textures are 90.625% of the original size
        	local _, bg = DS:GetTreeInfo(class, treeName)
        	_G["AltoholicTabCharacters_bgTopLeft"..index]:SetTexture(bg.."-TopLeft")
        	_G["AltoholicTabCharacters_bgTopRight"..index]:SetTexture(bg.."-TopRight")
        	_G["AltoholicTabCharacters_bgBottomLeft"..index]:SetTexture(bg.."-BottomLeft")
        	_G["AltoholicTabCharacters_bgBottomRight"..index]:SetTexture(bg.."-BottomRight")
        
        	local buttonCount = 1
        	local arrowCount = 1
        	frame.BranchCount = 1
            local branchArray = {}
        	
        	for i = 1, MAX_NUM_TALENT_TIERS do
        		branchArray[i] = {};
        		for j = 1, NUM_TALENT_COLUMNS do
        			branchArray[i][j] = {};
        		end
        	end
        	
        	-- draw all icons in their respective slot
        	for i = 1, DS:GetNumTalents(class, treeName) do
        		local _, _, texture, tier, column = DS:GetTalentInfo(class, treeName, i)
        		local rank = DS:GetTalentRank(character, treeName, i)
    
            	local itemName = "AltoholicTabCharacters_TalentFrame" .. index .. "_TalentButton" .. buttonCount
            	local itemButton = _G[itemName]
            
            	itemButton:SetPoint("TOPLEFT", itemButton:GetParent(), "TOPLEFT", 
            		INITIAL_OFFSET_X + ((column-1) * TALENT_OFFSET_X), 
            		-(INITIAL_OFFSET_Y + ((tier-1) * TALENT_OFFSET_Y)))
            	itemButton:SetID(i)
            
            	if texture then
            		Altoholic:SetItemButtonTexture(itemName, texture, 37, 37)
            	end
            	
            	local itemCount = _G[itemName .. "Count"]
            	local itemTexture = _G[itemName .. "IconTexture"]
    
            	if rank and rank > 0 then
            		itemCount:SetText(GREEN .. rank)
            		itemCount:Show()
            		itemTexture:SetDesaturated(false)
            	else
            		itemTexture:SetDesaturated(true)
            		itemCount:Hide()
            	end
            	itemButton:Show()
            
            	buttonCount = buttonCount + 1
    
                branchArray[tier][column].node = true;
        				
        		-- Draw arrows & branches where applicable
        		local prereqTier, prereqColumn = DS:GetTalentPrereqs(class, treeName, i)
        		if prereqTier and prereqColumn then
        			local left = min(column, prereqColumn);
        			local right = max(column, prereqColumn);
        
        			if ( left == prereqColumn ) then		-- Don't check the location of the current button
        				left = left + 1;
        			else
        				right = right - 1;
        			end
        			
        			local blocked								-- Check for blocking talents
        			for j = 1, DS:GetNumTalents(class, treeName) do
        				local _, _, _, searchedTier, searchedColumn = DS:GetTalentInfo(class, treeName, j)
        			
        				if searchedTier == prereqTier then				-- do nothing if lower tier, process if same tier, exit if higher tier
        					if (searchedColumn >= left) and (searchedColumn <= right) then
        						blocked = true
        						break
        					end
        				elseif searchedTier > prereqTier then
        					break
        				end
        			end
    
                	local arrowType					-- algorithm taken from TalentFrameBase.lua, adjusted for my needs
                	if (column == prereqColumn) then			-- Same column ? ==> TOP
                		arrowType = "top"
                	elseif (tier == prereqTier) then			-- Same tier ? ==> LEFT or RIGHT
                		if (column < prereqColumn) then
                			arrowType = "right"
                		else
                			arrowType = "left"
                		end
                	else												-- None of these ? ==> diagonal
                		if not blocked then
                			arrowType = "top"
                		else
                			if (column < prereqColumn) then
                				arrowType = "right"
                			else
                				arrowType = "left"
                			end
                		end
                	end
                	
                	if not arrowType then
                		return
                	end
                	
                	local x, y
                	if arrowType == "top" then
                		x = 2
                		y = 18
                	elseif arrowType == "left" then
                		x = -17
                		y = -2
                	elseif arrowType == "right" then
                		x = 22
                		y = -2
                	end
                	
                	x = x + INITIAL_OFFSET_X + ((column-1) * TALENT_OFFSET_X)
                	y = y - (INITIAL_OFFSET_Y + ((tier-1) * TALENT_OFFSET_Y))
                	
                	local arrow = _G["AltoholicTabCharacters_TalentFrame" .. index .. "_ArrowFrame_Arrow" .. arrowCount]
                	local tc = TALENT_ARROW_TEXTURECOORDS[arrowType][1]
                	
                	arrow:SetTexCoord(tc[1], tc[2], tc[3], tc[4]);
                	arrow:SetPoint("TOPLEFT",	_G["AltoholicTabCharacters_TalentFrame" .. index], "TOPLEFT", x, y)
                	arrow:Show()
                	
                	arrowCount = arrowCount + 1
    
                	-- algorithm taken from TalentFrameBase.lua, adjusted for my needs
                	local left = min(column, prereqColumn);
                	local right = max(column, prereqColumn);
                	
                	if (column == prereqColumn) then			-- Same column ? ==> TOP
                		for i = prereqTier, tier - 1 do
                			branchArray[i][column].down = true;
                			if ( (i + 1) <= (tier - 1) ) then
                				branchArray[i+1][column].up = true;
                			end
                		end
                	end
                		
                	if (tier == prereqTier) then			-- Same tier ? ==> LEFT or RIGHT
                		for i = left, right-1 do
                			branchArray[prereqTier][i].right = true;
                			branchArray[prereqTier][i+1].left = true;
                		end
                	end
                
                	-- None of these ? ==> diagonal
                	if not blocked then
                		branchArray[prereqTier][column].down = true;
                		branchArray[tier][column].up = true;
                		
                		for i = prereqTier, tier - 1 do
                			branchArray[i][column].down = true;
                			branchArray[i + 1][column].up = true;
                		end
                
                		for i = left, right - 1 do
                			branchArray[prereqTier][i].right = true;
                			branchArray[prereqTier][i+1].left = true;
                		end
                	else
                		for i=prereqTier, tier-1 do
                			branchArray[i][column].up = true;
                			branchArray[i + 1][column].down = true;
                		end
                	end
        		end
        	end
    
        	local x, y
        	local ignoreUp
        	
        	for i = 1, MAX_NUM_TALENT_TIERS do
        		for j = 1, NUM_TALENT_COLUMNS do
        			local p = branchArray[i][j]
        			
        			x = INITIAL_OFFSET_X + ((j-1) * TALENT_OFFSET_X) + 2
        			y = -(INITIAL_OFFSET_Y + ((i-1) * TALENT_OFFSET_Y)) - 2
                    
        			if p.node then			-- there's a talent there
        				if p.up then
        					if not ignoreUp then
        						BranchSetTexture(frame,"up", x, y + 25)
        					else
        						ignoreUp = nil
        					end
        				end
        				if p.down then
        					BranchSetTexture(frame,"down", x, y - 25 + 1)
        				end
        				if p.left then
        					BranchSetTexture(frame,"left", x - 25, y)
        				end
        				if p.right then
        					BranchSetTexture(frame,"right", x + 25, y)
        				end			
        			else
        				if p.up and p.left and p.right then
        					BranchSetTexture(frame,"tup", x, y)
        				elseif p.down and p.left and p.right then
        					BranchSetTexture(frame,"tdown", x, y)
        				elseif p.left and p.down then
        					BranchSetTexture(frame,"topright", x, y)
        					BranchSetTexture(frame,"down", x, y-25)
        				elseif p.left and p.up then
        					BranchSetTexture(frame,"bottomright", x, y)
        				elseif p.left and p.right then
        					BranchSetTexture(frame,"right", x + 25, y)
        					BranchSetTexture(frame,"left", x+1, y)
        				elseif p.right and p.down then
        					BranchSetTexture(frame,"topleft", x, y)
        					BranchSetTexture(frame,"down", x, y-25)
        				elseif p.right and p.up then
        					BranchSetTexture(frame,"bottomleft", x, y)
        				elseif p.up and p.down then
        					BranchSetTexture(frame,"up", x, y)
        					BranchSetTexture(frame,"down", x, y-25)
        					ignoreUp = true
        				end
        			end
        
        			p.up = nil			-- clear after use
        			p.left = nil
        			p.right = nil
        			p.down = nil
        			p.node = nil
        		end
        	end
        	
        	while buttonCount <= 40 do
        		_G["AltoholicTabCharacters_TalentFrame" .. index .. "_TalentButton" .. buttonCount]:Hide()
        		_G["AltoholicTabCharacters_TalentFrame" .. index .. "_TalentButton" .. buttonCount]:SetID(0)	
        		buttonCount = buttonCount + 1
        	end
    
        	while arrowCount <= 30 do
        		_G["AltoholicTabCharacters_TalentFrame" .. index .. "_ArrowFrame_Arrow" .. arrowCount]:Hide()
        		arrowCount = arrowCount + 1
        	end
    
        	while frame.BranchCount <= 30 do
        		_G["AltoholicTabCharacters_TalentFrame" .. index .. "_Branch" .. frame.BranchCount]:Hide()
        		frame.BranchCount = frame.BranchCount + 1
        	end
            
            if AltoholicTabCharacters:IsVisible() then
    		  AltoholicTabCharacters.Talents:Show()
              _G["AltoholicTabCharacters_TalentFrame" .. index]:Show()
    	    end
        
            index = index + 1
    	end
        
        AltoholicTabCharacters:Show()
	end,
})
