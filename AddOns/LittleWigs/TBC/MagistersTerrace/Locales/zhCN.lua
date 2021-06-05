local L = BigWigs:NewBossLocale("Vexallus", "zhCN")
if not L then return end
if L then
	L.energy_discharged = "放射出%s" -- %s = Pure Energy (npc ID = 24745)

	L.pure_energy = "纯净能量"
	L.pure_energy_desc = "维萨鲁斯的生命值每降低15%，就会召唤一个纯净能量。$[!2,4在英雄模式下，维萨鲁斯一次会召唤两个纯净能量。$]"
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider MT", "zhCN")
if L then
	L.warmup_trigger = "别拿那种眼神看着我！"

	L.flame_strike = "烈焰风暴"
	L.flame_strike_desc = "凯尔萨斯·逐日者召唤一根火柱，灼烧指定区域6码范围内的所有玩家，每秒造成一次火焰伤害，持续8秒。"

	L.shock_barrier = "冲击屏障"
	L.shock_barrier_desc = "凯尔萨斯·逐日者用一道屏障包围住自己，吸收10000点伤害，并免疫打断效果。"
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "zhCN")
if L then
	L.mage_guard = "炎刃魔法卫兵"
	L.magister = "炎刃魔导师"
	L.keeper = "炎刃守护者"
end

L = BigWigs:NewBossLocale("Priestess Delrissa", "zhCN")
if L then
	L.apoko = "埃波克"
	L.yazzai = "亚赛"
	L.ellrys = "艾尔蕾丝"
end
