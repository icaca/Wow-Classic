local L = BigWigs:NewBossLocale("Shirrak the Dead Watcher", "zhCN")
if not L then return end
if L then
	L.focus_fire = "集中火力"
	L.focus_fire_desc = "死亡观察者希尔拉克向一名玩家所在位置射出一片弹幕，对12码范围内的所有玩家造成火焰伤害。"
end

L = BigWigs:NewBossLocale("Exarch Maladaar", "zhCN")
if L then
	L.avatar = "殉难者的化身"
	L.avatar_desc = "当大主教玛拉达尔的生命值降至25%时，他将召唤一个殉难者的化身。"
end
