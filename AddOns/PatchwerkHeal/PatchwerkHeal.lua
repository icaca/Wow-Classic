local AppName = ...
local L = LibStub("AceLocale-3.0"):GetLocale(AppName)
PatchwerkHeal=LibStub("AceAddon-3.0"):NewAddon("PatchwerkHeal", "AceConsole-3.0","AceEvent-3.0","AceTimer-3.0")
PatchwerkHeal.Active=false
PatchwerkHeal.Debug=false

local function DPrint(...)
	if PatchwerkHeal.Debug then
		print(...)
	end
end
local spellRankTableData = {
	[1] = { 774, 8936, 5185, 740, 635, 19750, 139, 2060, 596, 2061, 2054, 2050, 1064, 331, 8004, 136, 755, 689, 746 },
	[2] = { 1058, 8938, 5186, 8918, 639, 19939, 6074, 10963, 996, 9472, 2055, 2052, 10622, 332, 8008, 3111, 3698, 699, 1159 },
	[3] = { 1430, 8939, 5187, 9862, 647, 19940, 6075, 10964, 10960, 9473, 6063, 2053, 10623, 547, 8010, 3661, 3699, 709, 3267 },
	[4] = { 2090, 8940, 5188, 9863, 1026, 19941, 6076, 10965, 10961, 9474, 6064, 913, 10466, 3662, 3700, 7651, 3268 },
	[5] = { 2091, 8941, 5189, 1042, 19942, 6077, 22009, 25314, 25316, 10915, 939, 10467, 13542, 11693, 11699, 7926 },
	[6] = { 3627, 9750, 6778, 3472, 19943, 6078, 10916, 959, 10468, 13543, 11694, 11700, 7927, 23569, 24412 },
	[7] = { 8910, 9856, 8903, 10328, 10927, 10917, 8005, 13544, 11695, 10838 },
	[8] = { 9839, 9857, 9758, 10329, 10928, 10395, 10839, 23568, 24413 },
	[9] = { 9840, 9858, 9888, 25292, 10929, 10396, 18608 },
	[10] = { 9841, 9889, 25315, 25357, 18610, 23567, 24414 },
	[11] = { 25299, 25297, 30020 },
}

local function make_class_prefix(classid)
  local classid2color={"|cFFC79C6E","|cFFF58CBA","|cFFA9D271","|cFFFFF569","|cFFFFFFFF","|cFFC41F3B","|cFF0070DE","|cFF40C7EB","|cFF8787ED","|cFF00FF96","|cFFFF7D0A","|cFFA330C9"}
  return classid2color[classid]
end

local SpellIDToRank = {}
for rankIndex, spellIDTable in pairs(spellRankTableData) do
	for _, spellID in pairs(spellIDTable) do
		SpellIDToRank[spellID] = rankIndex
	end
end


function PatchwerkHeal:BuildFrame()
	--DPrint("buldFrame")
	local texture_str = "Interface\\TARGETINGFRAME\\UI-StatusBar"
	if not PatchwerkHealFrame then
		PatchwerkHealFrame=CreateFrame("Button", "myMacroButton", UIParent, "SecureActionButtonTemplate")
		PatchwerkHealFrame:SetAttribute("type1", "macro") -- left click causes macro
		
		PatchwerkHealFrame.bg = PatchwerkHealFrame:CreateTexture(nil,"BACKGROUND", nil, -5)
		PatchwerkHealFrame.bg:SetTexture(texture_str)
		PatchwerkHealFrame.bg:SetVertexColor(0,0.1,0,0.8)
		PatchwerkHealFrame.bg:SetAllPoints(PatchwerkHealFrame)
		PatchwerkHealFrame:SetAttribute("macrotext1",'/script print("'..L["HelpTips"]..'")') 
		PatchwerkHealFrame:SetMovable(true)
		PatchwerkHealFrame:SetSize(100,60)
		PatchwerkHealFrame:SetPoint("TOPLEFT",0,-10)
		PatchwerkHealFrame:EnableMouse(true)
		PatchwerkHealFrame:RegisterForDrag("RightButton")
		PatchwerkHealFrame:SetScript("OnDragStart", PatchwerkHealFrame.StartMoving)
		PatchwerkHealFrame:SetScript("OnDragStop", PatchwerkHealFrame.StopMovingOrSizing)
		PatchwerkHealFrame.HPTip = PatchwerkHealFrame:CreateFontString(nil, "ARTWORK", "GameTooltipTextSmall");
		PatchwerkHealFrame.HPTip:SetAllPoints( PatchwerkHealFrame)
		PatchwerkHealFrame.HPTip:SetTextColor(1,1,0)
		PatchwerkHealFrame.HPTip:SetText(L["Not Setting"])

		PatchwerkHealFrame:SetScript("OnReceiveDrag",function()
			if InCombatLockdown() then
				print(L["CannotModifyInCombat"])
				return
			end
			local ret={GetCursorInfo()}
			if ret[1]=="spell" then
				local dragtype,spellIndex, bookType, spellID=ret[1],ret[2],ret[3],ret[4]
				local level=SpellIDToRank[spellID]
				
				if level then
					level="("..L["level"].." "..level..")"
				else
					level=""
				end
				local spellName=GetSpellInfo(spellID)
				local guid,playername = UnitGUID("target"), UnitName("target")
				local classFilename, classId = UnitClassBase("target")
				
				--DPrint(playername,guid,classId,spellID,level)
				if guid and spellName then
					local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
					if type=="Player" then
						DPrint("/cast "..'[@"' .. playername .. '",help,nodead] '..spellName..level)
						PatchwerkHealFrame.playername=playername
						PatchwerkHealFrame.playerid=guid
						PatchwerkHealFrame:SetAttribute("macrotext1", "/cast ".."[@" .. playername .. ",help,nodead] "..spellName..level)
						
						PatchwerkHealFrame.TipText=("%s%s|r\n%s"):format(make_class_prefix(classId),PatchwerkHealFrame.playername,spellName..level)
						PatchwerkHealFrame.HPTip:SetText(PatchwerkHealFrame.TipText)
						PatchwerkHeal:UNIT_HEALTH("UNIT_HEALTH","target")
						--PatchwerkHealFrame.HPTip:SetText(PatchwerkHealFrame.playername.."\n"..spellName..level)
						ClearCursor()
					end
				else
					PatchwerkHealFrame.playername=nil
					PatchwerkHealFrame.playerid=nil
					PatchwerkHealFrame.TipText=""
					
					PatchwerkHealFrame:SetAttribute("macrotext1",'/script print("'..L["HelpTips"]..'")') 
					PatchwerkHealFrame.HPTip:SetText(L["Not Setting"])
					if PatchwerkHealMask then
						PatchwerkHealMask.bar:SetValue(0)
					end
					ClearCursor()
				end
			end
		end)	
		PatchwerkHealFrame:Hide()
	end	
--Mask Frame
	if not PatchwerkHealMask then
		PatchwerkHealMask=CreateFrame("frame",nil)
		PatchwerkHealMask:SetFrameLevel(2)
		PatchwerkHealMask:SetSize(100,60)
		PatchwerkHealMask.maskbg=PatchwerkHealMask:CreateTexture(nil,"ARTWORK", nil,1)
		PatchwerkHealMask:EnableMouse(false)
		PatchwerkHealMask.maskbg:SetTexture(texture_str)
		PatchwerkHealMask.maskbg:SetVertexColor(0.8,0.1,0.1,0.0)
		PatchwerkHealMask.maskbg:SetAllPoints(PatchwerkHealMask)

		local border_texture_str = "Interface\\Tooltips\\UI-StatusBar-Border"	
		
		local border_texture1=PatchwerkHealMask:CreateTexture(nil,"BORDER")
		
		border_texture1:SetPoint("TOPLEFT",-3,3)
		border_texture1:SetSize(96,16)
		border_texture1:SetTexture(border_texture_str)
		PatchwerkHealMask.bar=CreateFrame("StatusBar",nil,PatchwerkHealMask)
		PatchwerkHealMask.bar:SetMinMaxValues(0,100)
		PatchwerkHealMask.bar:SetValue(0)
		PatchwerkHealMask.bar:SetStatusBarTexture(texture_str,"BACKGROUND", nil,3)
		PatchwerkHealMask.bar:SetStatusBarColor(0.1,0.8,0,0.85)
		PatchwerkHealMask.bar:SetSize(90,10)
		PatchwerkHealMask.bar:SetPoint("TOPLEFT",PatchwerkHealMask,"TOPLEFT",0,0)
		PatchwerkHealMask:SetAllPoints(PatchwerkHealFrame)

		
	end
	PatchwerkHealMask:Hide()
end

function PatchwerkHeal:Toggle(force)
	if InCombatLockdown() then
		print(L["CannotModifyInCombat"])
		return
	end
	if self:IsEnabled() and force~="Enable" then
		self:Disable()
	elseif (not self:IsEnabled()) and force~="Disable" then
		self:Enable()
	end
end
function PatchwerkHeal:SetupDataBroker()
    local LDB = LibStub('LibDataBroker-1.1')
     local PatchwerkHealLauncher = LDB:NewDataObject('PatchwerkHeal', {
        type = 'launcher',
		icon = "Interface\\Icons\\INV_Mace_15",
		label = L["PatchwerkHeal_TOGGLE_TEXT"],
        OnClick = function()
            return self:Toggle()
        end,
		OnTooltipShow = function(tt)
			tt:AddLine(L["PatchwerkHeal_TOGGLE_TEXT"])
		end,
        OnLeave = GameTooltip_Hide,
    })

     LibStub('LibDBIcon-1.0'):Register('PatchwerkHeal', PatchwerkHealLauncher,{ 
		hide = false,
		radius = 110,
	})
end
--event
local function parseGUID(gid)
	if gid==nil then
		return nil,nil
	end
	local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-", gid or "")
	return npc_id,spawn_uid
end
function PatchwerkHeal:CombatLogEvent(timestamp, eventtype, hideCaster, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, ...)
	local direct_damage={["SWING_DAMAGE"]=1,["RANGE_DAMAGE"]=4,["SPELL_DAMAGE"]=4,["SPELL_PERIODIC_DAMAGE"]=4,["DAMAGE_SPLIT"]=4}
	local npc_id,spawn_uid=parseGUID(dstGUID)
	local do_damage=0
	if PatchwerkHealFrame.playerid~=nil and PatchwerkHealFrame.playerid==dstGUID then
		--DPrint(eventtype,srcName,dstName,...)
		if eventtype=="SPELL_HEAL" then
			--local data={...}
			--DPrint(("|cFFF58CBAHeal:%s:%d|r"):format(data[2],data[4]-data[5]))
		elseif eventtype=="SPELL_PERIODIC_HEAL" then
			--local data={...}
			--DPrint(("|cFFF58CBAHot:%s:%d|r"):format(data[2],data[4]-data[5]))
		elseif eventtype=="SPELL_DAMAGE" then
			local data={...}
			if (data[2]==L["Hateful Strike"]) then
				DPrint(GetTime(),(":|cFFFFF569:%s:%d|r"):format(data[2],data[4]))
				PatchwerkHealMask.maskbg:SetVertexColor(0.1,0.1,0.1,0.0)
				PlaySound(5275)
				PatchwerkHealMask:EnableMouse(false)
				C_Timer.After(1, function() 
					DPrint(GetTime(),":","Disable")
					PatchwerkHealMask.maskbg:SetVertexColor(0.8,0.1,0.1,0.6)
					PatchwerkHealMask:EnableMouse(true) 
					end)
			end
		elseif direct_damage[eventtype]~=nil then

		elseif eventtype=="UNIT_DIED" then

		end	
	end
	
end
function PatchwerkHeal:UNIT_HEALTH(event,uid)
	--DPrint(uid)
	if PatchwerkHealFrame.playerid~=nil and PatchwerkHealFrame.playerid==UnitGUID(uid) and PatchwerkHealMask.bar then

			local health_rate=UnitHealth(uid)*100/UnitHealthMax(uid)
			if health_rate<=30 then
				PatchwerkHealMask.bar:SetStatusBarColor(0.8,0.1,0,0.85)
			elseif health_rate<=70 then
				PatchwerkHealMask.bar:SetStatusBarColor(0.7,0.7,0,0.85)
			else
				PatchwerkHealMask.bar:SetStatusBarColor(0.1,0.8,0,0.85)
			end
			PatchwerkHealMask.bar:SetValue(UnitHealth(uid)*100/UnitHealthMax(uid))
	end
end
function PatchwerkHeal:COMBAT_LOG_EVENT_UNFILTERED()
	PatchwerkHeal:CombatLogEvent(CombatLogGetCurrentEventInfo())
end

function PatchwerkHeal:PLAYER_REGEN_ENABLED()
	if PatchwerkHealMask then
		PatchwerkHealMask.maskbg:SetVertexColor(0.1,0.1,0.1,0.0)
		PatchwerkHealMask:EnableMouse(false)	
	end
end
function PatchwerkHeal:PLAYER_REGEN_DISABLED()
	if PatchwerkHealMask then
		PatchwerkHealMask.maskbg:SetVertexColor(0.9,0.2,0.2,0.6)
		PatchwerkHealMask:EnableMouse(true) 	
	end	
end

function PatchwerkHeal:OnInitialize()
	self:BuildFrame()
	self:SetEnabledState(false)
	self:SetupDataBroker()
	SLASH_PWHEAL1= "/pwpw"
	SlashCmdList["PWHEAL"] = function(msg) return PatchwerkHeal:Toggle() end
	self:Print(L["LoadInfo"])
end

function PatchwerkHeal:OnEnable()
	DPrint("Enable")
	if PatchwerkHealFrame then
		PatchwerkHealFrame:Show()
		PatchwerkHealMask:Show()
		self:Print(SELECTED_CHAT_FRAME,L["ShowPatchwerkHeal"])
		self.timerCount=0 
		PatchwerkHeal.Active=true				
		PatchwerkHeal:RegisterEvent("UNIT_HEALTH")
		PatchwerkHeal:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		PatchwerkHeal:RegisterEvent("PLAYER_REGEN_ENABLED")
		PatchwerkHeal:RegisterEvent("PLAYER_REGEN_DISABLED")
	end

end

function PatchwerkHeal:OnDisable()
	DPrint("Disable")
	if PatchwerkHealFrame then
		PatchwerkHealFrame:Hide()
		PatchwerkHealMask:Hide()
		PatchwerkHealMask:EnableMouse(false)
		self:Print(SELECTED_CHAT_FRAME,L["HidePatchwerkHeal"])
		PatchwerkHeal.Active=false
		PatchwerkHeal:UnregisterEvent("UNIT_HEALTH")
		PatchwerkHeal:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		PatchwerkHeal:UnregisterEvent("PLAYER_REGEN_ENABLED")
		PatchwerkHeal:UnregisterEvent("PLAYER_REGEN_DISABLED")
	end
	

end

