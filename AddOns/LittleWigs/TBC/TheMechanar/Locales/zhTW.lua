local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "zhTW")
if not L then return end
if L then
	L.despawn_message = "虚空怨灵召回，帕萨雷恩进入狂暴状态"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "zhTW")
if L then
	L.bossName = "看守者鐵手"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "zhTW")
if L then
	L.bossName = "看守者蓋洛奇歐"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "zhTW")
if L then
	L.inferno = "煉獄"
	L.inferno_desc = "凱爾薩斯‧逐日者喚來一根火柱，燃燒目標區域6碼範圍內的所有玩家，每秒造成火焰傷害，持續8秒。"
end
