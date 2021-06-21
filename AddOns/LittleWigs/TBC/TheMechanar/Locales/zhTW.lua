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
	L.inferno_desc = "盛怒的烈焰身邊包圍著煉獄烈火，持續8秒，每秒對10碼範圍內的所有玩家造成一次火焰傷害。起火時，盛怒的烈焰無法移動或使用技能。煉獄的效果結束時，盛怒的烈焰會鎖定新的目標。"

	L.fixate_desc = "使施法者鎖定一個隨機目標。"
end
