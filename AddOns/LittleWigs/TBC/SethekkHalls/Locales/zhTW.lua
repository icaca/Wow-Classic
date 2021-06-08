local L = BigWigs:NewBossLocale("Darkweaver Syth", "zhTW")
if not L then return end
if L then
	L.elementals = "召喚元素生物"
	L.elementals_desc = "當暗織者希斯剩下90%、55%與15%生命力時，他會召喚4個元素生物來防衛他。"
end

L = BigWigs:NewBossLocale("Anzu", "zhTW")
if L then
	L.cyclone = "羽毛颶風"
	L.cyclone_desc = "安祖對一名玩家發出颶風，阻礙所有行動但使其不會受到傷害，持續6秒。"

	L.brood = "安祖之子"
	L.brood_desc = "當安祖剩下75%與35%生命力時，他會放逐他自己1分鐘，使他對所有傷害免疫且無法移動。當被放逐時，安祖會繼續使用技能並召喚安祖之子來防衛他。擊敗所有安祖之子會使安祖提早取消放逐效果。"
end
