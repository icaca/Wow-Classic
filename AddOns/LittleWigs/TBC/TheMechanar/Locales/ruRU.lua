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
	L.inferno_desc = "Вокруг яростного пламени в течение 8 с. держится адский жар, что каждую секунду наносит урон от огня всем игрокам в радиусе 10 м. Во время действия заклинания яростное пламя не может двигаться или использовать способности. Когда действие заклинания заканчивается, яростное пламя выбирает новую цель."

	L.fixate_desc = "Вынуждает заклинателя сосредоточить свое внимание на случайно выбранной цели."
end
