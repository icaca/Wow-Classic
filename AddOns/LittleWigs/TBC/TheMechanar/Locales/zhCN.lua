local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "zhCN")
if not L then return end
if L then
	L.despawn_message = "虚空怨灵即将召回"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "zhCN")
if L then
	L.bossName = "看守者埃隆汉"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "zhCN")
if L then
	L.bossName = "看守者盖罗基尔"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "zhCN")
if L then
	L.inferno = "地狱火"
	L.inferno_desc = "凯尔萨斯·逐日者召唤一根火柱，灼烧指定区域6码范围内的所有玩家，每秒造成一次火焰伤害，持续8秒。"
end
