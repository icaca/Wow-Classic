local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "ruRU")
if not L then return end
if L then
	L.despawn_message = "Скоро Призраки Хаоса исчезнут"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "ruRU")
if L then
	L.bossName = "Страж ворот Стальная Клешня"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "ruRU")
if L then
	L.bossName = "Страж ворот Точеный Нож"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "ruRU")
if L then
	L.inferno = "Преисподняя"
	L.inferno_desc = "Кель'тас Солнечный Скиталец призывает столб пламени, обжигая игроков в радиусе 6 от области действия и нанося им урон от огня раз в секунду в течение 8 с."
end
