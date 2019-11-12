--[[
FelwoodGather 
Timer manager for felwood fruit gathering.
Author: nor3
]]--

-- constant definition

FELWOODGATHER_VERSION="0.80c";

FELWOODGATHER_TIMER = 1500;
FELWOODGATHER_TIMER_WARN1 = 300;
FELWOODGATHER_TIMER_WARN2 = 60;
FELWOODGATHER_CHECK_INTERVAL=3.0;
FELWOODGATHER_NOTIFY="TellMessage";
FWG_BROADCAST_HEADER="<FWGBRDCST>";

FELWOODGATHER_ACTIVE = false;
FelwoodGather_WorldMapDetailFrameWidth = 0;
FelwoodGather_WorldMapDetailFrameHeight = 0;
FelwoodGather_Config = {
	notify=true,
	warn1=FELWOODGATHER_TIMER_WARN1,
	warn2=FELWOODGATHER_TIMER_WARN2,
	acceptTimer= true,
	alpha=0.8,
	scale=10,
	countdown=5
};
FelwoodGather_DebugMode=false;
--[[
FelwoodGather_Details = {
	name      = FELWOODGATHER_FELWOODGATHER,
	version   = FELWOODGATHER_VERSION,
	author    = "nor3",
	email     = "norf@asuraguild.org",
	website   = "http://asuraguild.org/nor3/archives/AddOn/FelwoodGather/",
	category  = MYADDONS_CATEGORY_MAP
};
]]--

FelwoodGather_Help = {};
FelwoodGather_Help[1] = FELWOODGATHER_HELPMSG1;
FelwoodGather_Help[2] = FELWOODGATHER_HELPMSG2;
FelwoodGather_Help[3] = FELWOODGATHER_HELPMSG3;
FelwoodGather_Help[4] = FELWOODGATHER_HELPMSG4;
FelwoodGather_Help[5] = FELWOODGATHER_HELPMSG5;

-- Object Infomation
FelwoodGather_WorldObjs = {
	[1] = {x = 49, y = 12, timer = 0, status = 0,
		item     = FWG_WHIPPER_ROOT_TUBER,
	 	location = FWG_NORTH_FELWOOD, 
		texture  = FWG_WRT_TEXTURE
	}, 
	[2] = {x = 42, y = 13, timer = 0, status = 0,
		item     = FWG_NIGHT_DRAGON_BREATH,
	 	location = FWG_JADEFIRE_RUN,
		texture  = FWG_NDB_TEXTURE 
	},
	[3] = {x = 40, y = 19, timer = 0, status = 0,
		item     = FWG_WHIPPER_ROOT_TUBER, 
		location = FWG_JADEFIRE_RUN, 
		texture  = FWG_WRT_TEXTURE 
	},
	[4] = {x = 50, y = 18, timer = 0, status = 0, 
		item     = FWG_WHIPPER_ROOT_TUBER,
 		location = FWG_IRONTREE_WOODS,
		texture  = FWG_WRT_TEXTURE 
	},
	[5] = {x = 50, y = 30, timer = 0, status = 0, 
		item     = FWG_NIGHT_DRAGON_BREATH,
	 	location = FWG_GRAVEYARD,
		texture  = FWG_NDB_TEXTURE 
	},
	[6] = {x = 43, y = 46, timer = 0, status = 0, 
		item     = FWG_WHIPPER_ROOT_TUBER,
 		location = FWG_FALLS, 
		texture  = FWG_WRT_TEXTURE 
	},
	[7] = {x = 34, y = 60, timer = 0, status = 0, 
		item     = FWG_WHIPPER_ROOT_TUBER, 
		location = FWG_JADENAR, 
		texture  = FWG_WRT_TEXTURE 
	}, 
	[8] = {x = 35, y = 58, timer = 0, status = 0, 
		item     = FWG_NIGHT_DRAGON_BREATH,
		location = FWG_JADENAR, 
		texture  = FWG_NDB_TEXTURE 
	}, 
	[9] = {x = 40, y = 78, timer = 0, status = 0, 
		item     = FWG_NIGHT_DRAGON_BREATH, 
		location = FWG_JADEFIRE_GLEN, 
		texture  = FWG_NDB_TEXTURE 
	}, 
	[10] = { x = 40, y = 85, timer = 0, status = 0, 
		item     = FWG_WHIPPER_ROOT_TUBER,
		location = FWG_JADEFIRE_GLEN, 
		texture  = FWG_WRT_TEXTURE 
	},
	[11] = { x = 55, y =  6, timer = 0, status = 0, 
		item     = FWG_WINDBLOSSOM_BERRIES,
		location = FWG_NORTH_FELWOOD, 
		texture  = FWG_WBB_TEXTURE 
	},
	[12] = { x = 45, y = 18, timer = 0, status = 0, 
		item     = FWG_WINDBLOSSOM_BERRIES,
		location = FWG_JADEFIRE_RUN, 
		texture  = FWG_WBB_TEXTURE 
	},
	[13] = { x = 38, y = 21, timer = 0, status = 0, 
		item     = FWG_WINDBLOSSOM_BERRIES,
		location = FWG_JADEFIRE_RUN, 
		texture  = FWG_WBB_TEXTURE 
	},
	[14] = { x = 44, y = 41, timer = 0, status = 0, 
		item     = FWG_WINDBLOSSOM_BERRIES,
		location = FWG_SHATTER_SCAR_VALE, 
		texture  = FWG_WBB_TEXTURE 
	},
	[15] = { x = 34, y = 48, timer = 0, status = 0, 
		item     = FWG_WINDBLOSSOM_BERRIES,
		location = FWG_RIVER, 
		texture  = FWG_WBB_TEXTURE 
	},
	[16] = { x = 38, y = 59, timer = 0, status = 0, 
		item     = FWG_WINDBLOSSOM_BERRIES,
		location = FWG_JADENAR, 
		texture  = FWG_WBB_TEXTURE 
	},
	[17] = { x = 36, y = 61, timer = 0, status = 0, 
		item     = FWG_WINDBLOSSOM_BERRIES,
		location = FWG_JADENAR, 
		texture  = FWG_WBB_TEXTURE 
	},
	[18] = { x = 49, y = 79, timer = 0, status = 0, 
		item     = FWG_WINDBLOSSOM_BERRIES,
		location = FWG_EMERALD_SANCTUARY, 
		texture  = FWG_WBB_TEXTURE 
	},
	[19] = { x = 55, y = 23, timer = 0, status = 0, 
		item     = FWG_WINDBLOSSOM_BERRIES,
		location = FWG_IRONTREE_WOODS, 
		texture  = FWG_WBB_TEXTURE 
	}
};

FelwoodGather_Latest={};
FelwoodGather_Latest.index = 0;
FelwoodGather_Latest.timer = 0;
FelwoodGather_PickupCount = {};
FelwoodGather_PickupCount.inProgress=false;
FelwoodGather_PickupCount.count = 0;

FelwoodGather_LabelColorPast      ={ r=0.7, g=0.7, b=0.7 };
FelwoodGather_LabelColorWarn2     ={ r=1.0, g=0.0, b=0.0 };
FelwoodGather_LabelColorWarn1     ={ r=1.0, g=1.0, b=0.0 };
FelwoodGather_LabelColorNormal    ={ r=0.0, g=1.0, b=0.0 };
FelwoodGather_LabelColorHighlight ={ r=1.0, g=1.0, b=1.0 };

FelwoodGather_Continents = {};
FelwoodGather_MapZones = {};

function FelwoodGather_LoadContinents(...)
   for i=1, arg.n do
      FelwoodGather_Continents[i] = arg[i];
   end
end
function FelwoodGather_LoadMapZones(...)
   for i=1, arg.n do
      FelwoodGather_MapZones[i] = arg[i];
   end
end


-- ***************** Handlers **********************

function FelwoodGather_OnLoad()
	-- Event Registration
	this:RegisterEvent("WORLD_MAP_UPDATE");
	this:RegisterEvent("CLOSE_WORLD_MAP");
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("CHAT_MSG_LOOT");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("CHAT_MSG_RAID");
	this:RegisterEvent("CHAT_MSG_PARTY");

	-- command registration
	SLASH_FELWOODGATHER1="/felwoodgather";
	SLASH_FELWOODGATHER2="/fwg";

	SlashCmdList["FELWOODGATHER"] = function (msg)
		FelwoodGahter_SlashCmd(msg);
	end
end

-- Slash Command Handler
function FelwoodGahter_SlashCmd(msg)
	msg = string.lower (msg);
	if (msg == FWG_SUBCOMMAND_SHARE) then
		FelwoodGather_ShareTimer();
	elseif (msg == FWG_SUBCOMMAND_CONFIG) then
		FelwoodGather_ToggleConfigWindow();
	elseif (msg == FWG_SUBCOMMAND_COUNT ) then
		FelwoodGather_PickupCountDown(true);
	elseif (msg == FWG_SUBCOMMAND_MAP) then
		FelwoodGatherMap_ToggleMapWindow();
	elseif (msg == FWG_SUBCOMMAND_RESET) then
		FelwoodGatherMap_ResetMapPosition();
	else
		DEFAULT_CHAT_FRAME:AddMessage(FWG_SLASHHELPMSG1);
		DEFAULT_CHAT_FRAME:AddMessage(FWG_SLASHHELPMSG2);
		DEFAULT_CHAT_FRAME:AddMessage(FWG_SLASHHELPMSG3);
		DEFAULT_CHAT_FRAME:AddMessage(FWG_SLASHHELPMSG4);
		DEFAULT_CHAT_FRAME:AddMessage(FWG_SLASHHELPMSG5);
		DEFAULT_CHAT_FRAME:AddMessage(FWG_SLASHHELPMSG6);
	end
end


function FelwoodGather_IsActivate() 
	if(table.getn(FelwoodGather_Continents) == 0) then
		FelwoodGather_Continents = {};
		FelwoodGather_MapZones = {};
		FelwoodGather_LoadContinents(GetMapContinents());
		for n, cont in FelwoodGather_Continents do
			if ( cont == FWG_KALIMDOR_MAPNAME ) then
				FelwoodGather_LoadMapZones(GetMapZones(n));
			end
		end
	end
	if((FelwoodGather_Continents[GetCurrentMapContinent()] == FWG_KALIMDOR_MAPNAME) and (FelwoodGather_MapZones[GetCurrentMapZone()]==FWG_FELWOOD_MAPNAME)) then
		return true;
	end
	return false;
end

-- OnEvent handler for main window
function FelwoodGather_OnEvent(event)
	if (strfind(event, "CHAT_MSG_LOOT")) then
		FelwoodGather_CheckAndStart(arg1);
	elseif (event == "WORLD_MAP_UPDATE") then
		FELWOODGATHER_ACTIVE = FelwoodGather_IsActivate();
		if ( FELWOODGATHER_ACTIVE ) then
			FelwoodGather_WorldMapDetailFrameWidth = WorldMapDetailFrame:GetWidth();
			FelwoodGather_WorldMapDetailFrameHeight = WorldMapDetailFrame:GetHeight();
			FelwoodMapOverlayFrame:Show();
			FelwoodGather_MainDraw();
		else
			FelwoodGather_HideAll();
		end
	elseif ( event == "CLOSE_WORLD_MAP") then
		FelwoodMapOverlayFrame:Hide();
		FelwoodGather_MainDraw();
	elseif( event == "ADDON_LOADED") then
		if( arg1 == FELWOODGATHER_FELWOODGATHER ) then
			-- myAddOns support
--			if ( myAddOnsFrame_Register ) then
--				myAddOnsFrame_Register(FelwoodGather_Details, FelwoodGather_Help);
--			end
			-- store MapWindow size
			FelwoodGather_WorldMapDetailFrameWidth = WorldMapDetailFrame:GetWidth();
			FelwoodGather_WorldMapDetailFrameHeight = WorldMapDetailFrame:GetHeight();
			--FelwoodGather_Print("FelwoodGather by nor3 ver."..FELWOODGATHER_VERSION.." loaded.");
		end
	elseif (event == "VARIABLES_LOADED") then

		local playerName = UnitName("player");
		UIDropDownMenu_Initialize(FelwoodMainMenu, FelwoodMainMenu_Initialize, "MENU");
		-- TODO make charscter depends settings.
		if ((playerName) and (playerName ~= UNKNOWNOBJECT)) then
-- TODO
			if( FelwoodGather_Config.notify == nil ) then
				FelwoodGather_Config.notify = true;
			end
			if( FelwoodGather_Config.warn1 == nil ) then
				FelwoodGather_Config.warn1 = FELWOODGATHER_TIMER_WARN1;
			end
			if( FelwoodGather_Config.warn2 == nil ) then
				FelwoodGather_Config.warn2 = FELWOODGATHER_TIMER_WARN2;
			end
			if( FelwoodGather_Config.acceptTimer == nil ) then
				FelwoodGather_Config.acceptTimer = true;
			end
			if( FelwoodGather_Config.alpha == nil ) then
				FelwoodGather_Config.alpha = 0.7;
			end
			if( FelwoodGather_Config.scale == nil ) then
				FelwoodGather_Config.scale = 12;
			end
			if( FelwoodGather_Config.countdown == nil ) then
				FelwoodGather_Config.countdown = 5;
			end
			-- FelGlimReg();
		end
		FelwoodGather_Options_Init();
	elseif ( event == "ZONE_CHANGED_NEW_AREA" ) then
--[[
		local curZone = GetRealZoneText();
		if( (curZone ~= nil) and curZone == FWG_FELWOOD_MAPNAME) then
			FELWOODGATHER_ACTIVE=true;
			FelwoodMapOverlayFrame:Show();
			FelwoodGather_MainDraw();
		else
			FELWOODGATHER_ACTIVE=false;
			FelwoodMapOverlayFrame:Hide();
			FelwoodGather_HideAll();
		end
]]--
	elseif( event == "CHAT_MSG_RAID") then
		if (not FELWOODGATHER_ACTIVE) then
			return;
		end
		if (strsub(arg1, 1, string.len(FWG_BROADCAST_HEADER)) == FWG_BROADCAST_HEADER) then
			FelwoodGather_ParseMessage(arg1);
		end
	elseif( event == "CHAT_MSG_PARTY") then
		if (not FELWOODGATHER_ACTIVE) then
			return;
		end
		if (strsub(arg1, 1, string.len(FWG_BROADCAST_HEADER)) == FWG_BROADCAST_HEADER) then
			FelwoodGather_ParseMessage(arg1);
		end
	else
		FelwoodGather_Print("Unknown event: "..event);
	end
end
function FelGlimReg()
	gLim_RegisterButton (
		"FelwoodGather",
		FELWOODGATHER_OPTIONS,
		"Interface\\AddOns\\FelwoodGather\\Icon",
		function()
			gLimModSecBookShowConfig("gLimFelwoodGather");
		end,
		4,
		10
	);
	gLim_RegisterConfigClass(
		"gLimFelwoodGather",
		"FelwoodGather",
		"黑眼圈"
	);
	gLim_RegisterConfigSection(
		"gLim_FelwoodGather_Section",
		FELWOODGATHER_OPTIONS,
	  FELWOODGATHER_HELPMSG2,
		nil,
		"gLimFelwoodGather"
	);
	
	gLim_RegisterConfigButton(
		"gLim_QuickEquip_ToggleConfigWindow",
		"详细设置",
		"设置费伍德水果助手",
		"设置",
		function ()
			FelwoodGather_ToggleConfigWindow();
			gLimConfigSubFrame:Hide();
		end,
		"gLimFelwoodGather"
	);		
	
	gLim_RegisterConfigButton(
		"gLim_QuickEquip_ToggleMapWindow",
		"打开小地图",
		"打开费伍德水果分布小地图",
		"打开小地图",
		FelwoodGatherMap_ToggleMapWindow,
		"gLimFelwoodGather"

	);
end
-- map update handler (seems main window not updated while map window open.)
function FelwoodGather_MapUpdate(elapsed)
	if (not FelwoodGather_UpdateMapTimer ) then
		FelwoodGather_UpdateMapTimer = 0;
	else
		FelwoodGather_UpdateMapTimer = FelwoodGather_UpdateMapTimer + elapsed;
		if (FelwoodGather_UpdateMapTimer > FELWOODGATHER_CHECK_INTERVAL) then
			FelwoodGather_UpdateMapTimer = 0;
			FelwoodGather_MainDraw();
		end
	end
end

-- timer update handler 
function FelwoodGather_TimeCheck(elapsed)
--	if ((not FELWOODGATHER_ACTIVE) or (not FelwoodGather_Config.notify)) then
--		return;
--	end
	if (not FelwoodGather_UpdateTimer) then
		FelwoodGather_UpdateTimer = 0;
	else
		FelwoodGather_UpdateTimer = FelwoodGather_UpdateTimer + elapsed;
		if (FelwoodGather_UpdateTimer > FELWOODGATHER_CHECK_INTERVAL) then
			FelwoodGather_UpdateTimer = 0;
			FelwoodGather_OnUpdate();
		end
	end
	-- countdown check
	if(FelwoodGather_PickupCount.inProgress) then
		FelwoodGather_PickupCount.elapse = FelwoodGather_PickupCount.elapse + elapsed;
		if(FelwoodGather_PickupCount.elapse > 1 ) then
			FelwoodGather_PickupCount.elapse = FelwoodGather_PickupCount.elapse -1;
			FelwoodGather_PickupCountDown(false);
		end
	end
end

-- parser for share timer message
function FelwoodGather_ParseMessage(msg)
	if( not FelwoodGather_Config.acceptTimer ) then
		return;
	end
	local useless1, useless2, var0, var1, var2, var3 = string.find(msg, FELWOODGATHER_PARSE_FORMAT);
--	FelwoodGather_Print(useless1 .. ", "..  useless2 .. ", "..  var1 .. ", "..  var2);
	curTime = GetTime();
	if ( tonumber(var1) and tonumber(var2) and tonumber(var3)) then
		FelwoodGather_SetTimer(tonumber(var1), curTime + tonumber(var2)*60 + tonumber(var3) - FELWOODGATHER_TIMER);
	end

end

-- Main drawer function
function FelwoodGather_MainDraw()
	FelwoodGather_DebugPrint("FelwoodGather_MainDraw called.");
	if(not FELWOODGATHER_ACTIVE) then
		return;
	end
	local curTime = GetTime();
	local eta;
	local etatext;
	for n, Objs in FelwoodGather_WorldObjs do 
		-- set texture
		local mainNoteTexture = getglobal("FelwoodMain"..n.."Texture");
		if (mainNoteTexture == nil) then 
			FelwoodGather_Print("get texture failed" .. n);
		else 
			mainNoteTexture:SetTexture(Objs.texture);
		end

		-- draw icon
		local mainNote = getglobal("FelwoodMain"..n);

		mnX = Objs.x/100 * FelwoodGather_WorldMapDetailFrameWidth;
		mnY = -Objs.y/100 * FelwoodGather_WorldMapDetailFrameHeight;
--		FelwoodGather_Print("position["..n.."]=("..mnX..","..mnY..")");
		mainNote:SetPoint("CENTER", "FelwoodMapOverlayFrame", "TOPLEFT", mnX, mnY);
		mainNote:SetAlpha(FelwoodGather_Config.alpha);
		mainNote:SetWidth(FelwoodGather_Config.scale);
		mainNote:SetHeight(FelwoodGather_Config.scale);
		mainNote:Show();

		-- calculate estimation time
		if (Objs.timer == 0) then
			eta = nil;
			etatext = FWG_NO_TIMER;
		else
			eta = (Objs.timer + FELWOODGATHER_TIMER) - curTime;
			if(eta < 0 ) then
				est = "-";
			else 
				est = "";
			end
			d, h, m, s = ChatFrame_TimeBreakDown(math.abs(eta));
			etatext = format("%s%02d:%02d", est, m, s);
		end

		-- set tooltip text
		mainNote.toolTip = format(FWG_TOOLTIP_TEXT, Objs.item, Objs.location, etatext);
--		mainNote:SetText(Objs.toolTip);

		-- set label text
		local mainNoteLabel = getglobal("FelwoodMain"..n.."Label");
		if (mainNoteLabel == nil) then 
--			FelwoodGather_Print("get label failed" .. n);
		else 
			mainNoteLabel:SetText(etatext);
			if (FelwoodGather_Latest.index == n ) then
--				mainNoteLabel:SetTextColor(0,1,1);
				mainNoteLabel:SetTextColor(FelwoodGather_LabelColorHighlight.r, 
							FelwoodGather_LabelColorHighlight.g, 
							FelwoodGather_LabelColorHighlight.b);
			else
--				mainNoteLabel:SetTextColor(1,1,1);
--[[
				local r = 1; g = 1; b = 1;
				local r = 1; g = 1; b = 1;
				if( eta < 0) then
					r=1; g=0; b=0;
				elseif (eta == 0) then
					r=0.7; g=0.7; b=0.7;
				else 
					r=1; g=1;
					b = eta / FELWOODGATHER_TIMER;
					if( b > 1) then
						b = 1;
					end
				end
]]--
				if ( Objs.timer == 0 ) then
					mainNoteLabel:SetTextColor(
						FelwoodGather_LabelColorPast.r, 
						FelwoodGather_LabelColorPast.g, 
						FelwoodGather_LabelColorPast.b);
				else
					if( eta < 0) then
						mainNoteLabel:SetTextColor(
							FelwoodGather_LabelColorWarn2.r, 
							FelwoodGather_LabelColorWarn2.g, 
							FelwoodGather_LabelColorWarn2.b);
					elseif (Objs.status == 2) then
						mainNoteLabel:SetTextColor(
							FelwoodGather_LabelColorWarn2.r, 
							FelwoodGather_LabelColorWarn2.g, 
							FelwoodGather_LabelColorWarn2.b);
					elseif (Objs.status == 1) then
						mainNoteLabel:SetTextColor(
							FelwoodGather_LabelColorWarn1.r, 
							FelwoodGather_LabelColorWarn1.g, 
							FelwoodGather_LabelColorWarn1.b);
					else
						mainNoteLabel:SetTextColor(
							FelwoodGather_LabelColorNormal.r, 
							FelwoodGather_LabelColorNormal.g, 
							FelwoodGather_LabelColorNormal.b);
					end
				end
--				mainNoteLabel:SetTextColor(r, g, b);
			end
			mainNoteLabel:Show();
		end
	end
end

-- trigger timer function
function FelwoodGather_CheckAndStart(arg1) 
	if(not FELWOODGATHER_ACTIVE) then
		return;
	end
--	local iStart, iEnd, sItem = string.find(arg1, FWG_LOOTMSG_MATCH_PATTERN);
--	if(( sItem ~= nil ) and ((sItem == "[夜龙之息]") or (sItem =="[鞭根块茎]"))) then
	if(( string.find(arg1, FWG_NIGHT_DRAGON_BREATH)) 
		or (string.find(arg1, FWG_WINDBLOSSOM_BERRIES))
		or (string.find(arg1, FWG_WHIPPER_ROOT_TUBER))) then

		x, y = GetPlayerMapPosition("player");
		x= x*100;
		y= y*100;
		curTime = GetTime();
		for n, Objs in FelwoodGather_WorldObjs do 
			if( (Objs.x - x)*(Objs.x - x)+(Objs.y - y)*(Objs.y - y) < 2) then
				Objs.timer = curTime;
				Objs.status = 0;
			else 
				if ((Objs.timer + FELWOODGATHER_TIMER > curTime ) and
				((FelwoodGather_Latest.timer == 0) or (FelwoodGather_Latest.timer > Objs.timer))) then
					FelwoodGather_Latest.index = n;
					FelwoodGather_Latest.timer = Objs.timer;
				end
			end
		end
	else 
		FelwoodGather_DebugPrint("FelwoodGather_CheckAndStart checked but ignored this loot.");
	end
end

-- hide window
function FelwoodGather_HideAll()
	for n, Objs in FelwoodGather_WorldObjs do 
		local mainNote = getglobal("FelwoodMain"..n);
		mainNote:Hide();
	end
end

-- timer update function with notification check.
function FelwoodGather_OnUpdate()
	FelwoodGather_DebugPrint("FelwoodGather_OnUpdate called");
	local curTime = GetTime();

	if (curTime > FelwoodGather_Latest.timer + FELWOODGATHER_TIMER ) then
		FelwoodGather_Latest.index = 0;
		FelwoodGather_Latest.timer = 0;
	end
	for n, Objs in FelwoodGather_WorldObjs do 
		if (Objs.timer == 0) then
		else
			eta = (Objs.timer + FELWOODGATHER_TIMER) - curTime;
			if ((eta < FelwoodGather_Config.warn1) and (Objs.status < 1)) then
				Objs.status = 1;
				FelwoodGather_NotifyEstimate(Objs, eta, false);
			elseif ( (eta < FelwoodGather_Config.warn2) and (Objs.status <2) ) then
				Objs.status = 2;
				FelwoodGather_NotifyEstimate(Objs, eta, false);
			end
			if ((Objs.timer + FELWOODGATHER_TIMER > curTime ) and
			(((FelwoodGather_Latest.timer == 0) and (eta > 0)) or (FelwoodGather_Latest.timer > Objs.timer))) then
				FelwoodGather_Latest.index = n;
				FelwoodGather_Latest.timer = Objs.timer;
			end
		end
		
	end
end

-- notifier
function FelwoodGather_NotifyEstimate(Objs, eta, useChannel) 
	if (not FelwoodGather_Config.notify ) then
		return;
	end
	local d, h, m, s = ChatFrame_TimeBreakDown(math.abs(eta));
	local message = format(FWG_NOTIFY_MESSAGE, Objs.item, Objs.location, m, s);
	if (useChannel) then
		local channel;
		if (GetNumRaidMembers() > 0) then
			channel = "RAID";
		elseif (GetNumPartyMembers() > 0) then
			channel = "PARTY";
		else
			return;
		end
		SendChatMessage(message, channel);
	else 
		FelwoodGather_Print(message);
	end
	PlaySound(FELWOODGATHER_NOTIFY);
end

-- broadcast timers 
-- test needed. I dont know whether the GetTime() values are same for everyone.
-- if not, this should send delta value.
function FelwoodGather_ShareTimer() 
	local channel;
	if (GetNumRaidMembers() > 0) then
		channel = "RAID";
	elseif (GetNumPartyMembers() > 0) then
		channel = "PARTY";
	else
		return;
	end
	local curTime = GetTime();
	local message;
	local count = 0;
	for n, Objs in FelwoodGather_WorldObjs do 
		if ((Objs.timer ~= 0) and (Objs.timer + FELWOODGATHER_TIMER > curTime)) then
			eta = Objs.timer + FELWOODGATHER_TIMER - curTime;
			d, h, m, s = ChatFrame_TimeBreakDown(eta);
			
			message = string.format(FELWOODGATHER_SHARE_TIMER_FORMAT, FWG_BROADCAST_HEADER, n, m, s, Objs.item, Objs.location, Objs.x, Objs.y);
			SendChatMessage(message, channel);
			count = count + 1;
		end
	end
	FelwoodGather_Print(count .. FWG_BROADCAST_COUNTS);
end

--for test
function FelwoodGather_SetTimer(n, time)
	FelwoodGather_WorldObjs[n].timer=time;
	FelwoodGather_WorldObjs[n].status=0;

	FelwoodGather_Latest.index = 0;
	FelwoodGather_Latest.timer = 0;
	curTime = GetTime();
	for n, Objs in FelwoodGather_WorldObjs do 
		if ((Objs.timer + FELWOODGATHER_TIMER > curTime ) and
		((FelwoodGather_Latest.timer == 0) or (FelwoodGather_Latest.timer > Objs.timer))) then
			FelwoodGather_Latest.index = n;
			FelwoodGather_Latest.timer = Objs.timer;
		end
	end
end

function FelwoodGather_Print(message)
	if ( DEFAULT_CHAT_FRAME ) then 
		DEFAULT_CHAT_FRAME:AddMessage(message, 1.0, 0.5, 0.25);
	end
end

function FelwoodGather_DebugPrint(message)
	if (FelwoodGather_DebugMode) then
		FelwoodGather_Print(message);
	end
end	
-- ************** menu handler **********************
-- click handler
function FelwoodGather_OnClick(button, id, parent) 
	ToggleDropDownMenu(1, id, FelwoodMainMenu, parent, 0, 0);
end

-- Menu initializer
function FelwoodMainMenu_Initialize() 
	local info = {};

	if (UIDROPDOWNMENU_MENU_LEVEL == 2) then
	else
		info.isTitle = true;
		info.text = FELWOODGATHER_FELWOODGATHER.." "..FELWOODGATHER_VERSION;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.func = FelwoodGather_Menu_Announce;

		info.text = FELWOODGATHER_ANNOUNCE;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.func = FelwoodGather_Menu_ClearTimer;
		info.text = FELWOODGATHER_CLEARTIMER;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.func = FelwoodGather_ShareTimer;
		info.text = FELWOODGATHER_SHARETIMER;
		UIDropDownMenu_AddButton(info);
	end
end

function FelwoodGather_Menu_ClearTimer() 
--	FelwoodGather_Print(UIDROPDOWNMENU_MENU_VALUE);
	FelwoodGather_SetTimer(UIDROPDOWNMENU_MENU_VALUE, 0);
end

function FelwoodGather_Menu_Announce()
	Objs = FelwoodGather_WorldObjs[UIDROPDOWNMENU_MENU_VALUE];
	if ( (Objs ~= nil) and (Objs.timer ~= 0) ) then
		local eta = (Objs.timer + FELWOODGATHER_TIMER) - GetTime();
		FelwoodGather_NotifyEstimate(Objs, eta, true);
	else 
		FelwoodGather_Print(FWG_NOT_HAVE_TIMER);
	end
end

function FelwoodGather_ToggleConfigWindow()
	if(FelwoodGather_OptionsFrame:IsVisible()) then
		FelwoodGather_OptionsFrame:Hide();
	else
		FelwoodGather_OptionsFrame:Show();
	end
end

function FelwoodGather_Options_OnLoad()
	UIPanelWindows['FelwoodGather_OptionsFrame'] = {area = 'center', pushable = 0};
end

function FelwoodGather_Options_Init()
	FelwoodGather_SliderWarn1:SetValue(FelwoodGather_Config.warn1);
	FelwoodGather_SliderWarn2:SetValue(FelwoodGather_Config.warn2);
	FelwoodGather_SliderAlpha:SetValue(FelwoodGather_Config.alpha);
	FelwoodGather_SliderScale:SetValue(FelwoodGather_Config.scale);
	FelwoodGather_Notify:SetChecked(FelwoodGather_Config.notify);
	FelwoodGather_AcceptTimer:SetChecked(FelwoodGather_Config.acceptTimer);
	FelwoodGather_DebugPrint("Option_Init()");
end

function FelwoodGather_Options_OnHide()
--	if(MYADDONS_ACTIVE_OPTIONSFRAME == this) then
--		ShowUIPanel(myAddOnsFrame);
--	end
end

function FelwoodGather_GetLatestObject()
	if (FelwoodGather_Latest.index ~= 0) then
		return FelwoodGather_WorldObjs[FelwoodGather_Latest.index];
	else
		return nil;
	end
end

function FelwoodGather_PickupCountDown(byUI)
	if(FelwoodGather_PickupCount.inProgress and byUI) then
		-- count down in progress. ignored
		return;
	end

	if(not FelwoodGather_PickupCount.inProgress ) then
		-- start count down
		FelwoodGather_PickupCount.count = FelwoodGather_Config.countdown;
		FelwoodGather_PickupCount.elapse = 0;
		FelwoodGather_PickupCount.inProgress = true;
	end
	-- counter in progress.
	if(FelwoodGather_PickupCount.count == FelwoodGather_Config.countdown) then
		SendChatMessage(FELWOODGATHER_OPENNOW, "SAY");
	elseif (FelwoodGather_PickupCount.count <= 0) then 
		SendChatMessage(FELWOODGATHER_PICKUP, "SAY");
		FelwoodGather_PickupCount.inProgress = false;
	else
		SendChatMessage(""..FelwoodGather_PickupCount.count, "SAY");
	end
	FelwoodGather_PickupCount.count = FelwoodGather_PickupCount.count - 1;
end
