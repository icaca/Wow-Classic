local L = BigWigs:NewBossLocale("Commander Sarannis", "zhCN")
if not L then return end
if L then
	L.mender = "血警卫修理工"

	L.reinforcements = "召唤援军"
	L.reinforcements_desc = "指挥官萨拉妮丝每分钟召唤3个血警卫预备兵和1个血警卫修理工。"
end

L = BigWigs:NewBossLocale("High Botanist Freywinn", "zhCN")
if L then
	L.white_seedling = "白色树苗"
end

L = BigWigs:NewBossLocale("Warp Splinter", "zhCN")
if L then
	L.mender = "血警卫修理工"

	L.saplings = "召唤树苗"
	L.saplings_desc = "迁跃扭木召唤6棵树苗为他作战。25秒之后，树苗会牺牲自己来治疗迁跃扭木，治疗量相当于其剩余生命值。"
end
