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
	L.inferno_desc = "狂怒烈焰用地狱火环绕自己，持续8秒，每秒对10码范围内的所有玩家造成火焰伤害。燃烧时，狂怒烈焰不能移动或使用任何技能。地狱火效果消失时，狂怒烈焰会选择一个新目标去追逐。"

	L.fixate_desc = "使施法者锁定一个随机目标。"
end
