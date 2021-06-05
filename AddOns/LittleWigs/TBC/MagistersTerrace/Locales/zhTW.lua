local L = BigWigs:NewBossLocale("Vexallus", "zhTW")
if not L then return end
if L then
	--L.energy_discharged = "%s discharged" -- %s = Pure Energy (npc ID = 24745)

	L.pure_energy = "純淨能量"
	L.pure_energy_desc = "每當維克索魯斯的生命力降低15%時，他會召喚一個純淨能量。$[!2,4在英雄難度，維克索魯斯會一次召喚兩個純淨能量。$]"
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider MT", "zhTW")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	-- L.warmup_trigger = "Don't look so smug!"

	L.flame_strike = "烈焰尖刺"
	L.flame_strike_desc = "凱爾薩斯‧逐日者喚來一根火柱，燃燒目標區域6碼範圍內的所有玩家，每秒造成火焰傷害，持續8秒。"

	L.shock_barrier = "震擊屏障"
	L.shock_barrier_desc = "凱爾薩斯‧逐日者用護盾包裹自己，吸收10000點傷害，並使自己對所有中斷效果免疫。"
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "zhTW")
if L then
	--L.mage_guard = "Sunblade Mage Guard"
	--L.magister = "Sunblade Magister"
	--L.keeper = "Sunblade Keeper"
end

L = BigWigs:NewBossLocale("Priestess Delrissa", "zhTW")
if L then
	L.apoko = "阿波考"
	L.yazzai = "耶賽"
	L.ellrys = "艾爾里斯‧聖暮"
end
