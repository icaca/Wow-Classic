local AppName = ...
local AL = LibStub("AceLocale-3.0")
local L = AL:NewLocale(AppName, "enUS", true)
L.ADDON_NAME="PatchwerkHeal"
L.LoadInfo = "PatchwerkHeal Loaded"
L.UnLoadInfo = "PatchwerkHeal UnLoaded"
L["PatchwerkHeal_TOGGLE_TEXT"] = "click to open/close the PW Heal Frame"
L["ShowPatchwerkHeal"]="open the PW Heal Frame,use mouse right key to drag the frame"
L["HidePatchwerkHeal"]="close the PW Heal Frame"
L["Not Setting"]="No Target set"
L["CannotModifyInCombat"]="Cannot toggle in combat"
L["level"]="Rank"
L["HelpTips"]="Select target,then drag skill to PW frame,if no target ,the drag can clear the setting."
L["Hateful Strike"]="Hateful Strike"

L = AL:NewLocale(AppName, "zhCN")
if L then
	L.ADDON_NAME="帕奇维克又来陪我们玩"
	L.LoadInfo= "|cff1eff00帕奇维克又来陪我们玩|r 已装载\nBy 一只傻安安@班尔法克斯 命令 /pwpw 开关界面"
	L["PatchwerkHeal_TOGGLE_TEXT"] = "点击以开启/关闭PW治疗框体"
	L["ShowPatchwerkHeal"]="开启帕奇维克治疗助手，右键移动框体"
	L["HidePatchwerkHeal"]="关闭帕奇维克治疗助手"
	L["Not Setting"]="未设置有效目标"
	L["CannotModifyInCombat"]="战斗中无法修改"
	L["level"]="等级"
	L["HelpTips"]="PW框体:选中目标，拖动设置的技能到PW治疗框体，不选中目标的拖曳可以清除当前选择。"
	L["Hateful Strike"]="仇恨打击"
end

L = AL:NewLocale(AppName, "zhTW")
if L then
	L.ADDON_NAME="帕奇維克又來陪我們玩"
	L.LoadInfo= "|cff1eff00帕奇維克又來陪我們玩|r 已裝載\nBy 一隻傻安安@班爾法克斯 命令 /pwpw 開關介面"
	L["PatchwerkHeal_TOGGLE_TEXT"] = "點擊以開啟/關閉PW治療框體"
	L["ShowPatchwerkHeal"]="開啟帕奇維克治療助手，右鍵移動框體"
	L["HidePatchwerkHeal"]="關閉帕奇維克治療助手"
	L["Not Setting"]="未設置有效目標"
	L["CannotModifyInCombat"]="戰鬥中無法修改"
	L["level"]="等級"
	L["HelpTips"]="PW框體:選中目標，拖動設置的技能到PW治療框體，不選中目標的拖曳可以清除當前選擇。"
	L["Hateful Strike"]="憎恨打擊"
end