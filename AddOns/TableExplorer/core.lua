-- $Id: TableExplorer.lua 16 2014-02-24 05:55:58Z diesal2010 $
local AddOnName, Env = ...
local ADDON = {}
Env[1], _G[AddOnName] = ADDON, ADDON
-- ~~| Libraries |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
local DiesalTools 	= LibStub("DiesalTools-1.0")
local DiesalStyle 	= LibStub("DiesalStyle-1.0")
local DiesalGUI 		= LibStub("DiesalGUI-1.0")
-- ~~| Lua Upvalues |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
local print, type, select, tostring, tonumber	= print, type, select, tostring, tonumber
local sub, format, match, lower								= string.sub, string.format, string.match, string.lower
local table_sort															= table.sort
local abs																			= math.abs
-- ~~| WoW Upvalues |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- ~~| Slash Command |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SLASH_TEXPLORE1= '/texplore'
function SlashCmdList.TEXPLORE(msg)
 local table, depth = msg:match("^([^%s]*)%s*(%d*).*$")
	if not _G[table] then print('table dosnt exist') return end
	texplore(table,_G[table],tonumber(depth))
end
-- | Global Explorer Call |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function texplore(tname,t,depth)
	local explorer = DiesalGUI:Create('TableExplorer')
	t = type(tname) == 'table' and tname or t
	tname = type(tname) == 'table' and tostring(tname) or tname
	depth = type(t) == 'number' and t or depth

	explorer:SetTable(tname,t,depth)
end

-- | Constants |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
local TIMEOUT = 5
