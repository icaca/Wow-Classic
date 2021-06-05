local L = BigWigs:NewBossLocale("Commander Sarannis", "ruRU")
if not L then return end
if L then
	L.mender = "Кровостраж-лекарь"

	L.reinforcements = "Вызов подкрепления"
	L.reinforcements_desc = "Командир Сараннис призывает 3-х кровостражей-резервистов и кровостража-лекаря каждую минуту."
end

L = BigWigs:NewBossLocale("High Botanist Freywinn", "ruRU")
if L then
	L.white_seedling = "Белый саженец"
end

L = BigWigs:NewBossLocale("Warp Splinter", "ruRU")
if L then
	L.mender = "Кровостраж-лекарь"

	L.saplings = "Вызов саженцев"
	L.saplings_desc = "Узлодревень выращивает 6 саженцев, которые будут помогать ему в бою. По прошествии 25 с. саженцы будут принесены в жертву, восстанавливая столько единиц здоровья Узлодревня, сколько у них осталось."
end
