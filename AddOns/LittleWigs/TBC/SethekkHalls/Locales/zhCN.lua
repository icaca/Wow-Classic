local L = BigWigs:NewBossLocale("Darkweaver Syth", "zhCN")
if not L then return end
if L then
	L.elementals = "召唤元素"
	L.elementals_desc = "当黑暗编织者塞斯的生命值降低至90%、55%和15%时，他会召唤4个元素为他作战。"
end

L = BigWigs:NewBossLocale("Anzu", "zhCN")
if L then
	L.cyclone = "羽毛飓风"
	L.cyclone_desc = "安苏用飓风包裹一名玩家，使其无法做出任何动作，但免疫所有伤害，持续6秒。"

	L.brood = "安苏的子嗣"
	L.brood_desc = "当安苏的生命值降低至75%和35%时，他将放逐自己，持续1分钟。并使自己免疫所有的伤害，且无法移动。处于放逐状态时，安苏将继续使用技能并召唤安苏的子嗣为其作战。击败所有安苏的子嗣，将使安苏提前解除放逐效果。"
end
