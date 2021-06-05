local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "frFR")
if not L then return end
if L then
	L.despawn_message = "Disparition des âmes en peine du Néant imminente"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "frFR")
if L then
	L.bossName = "Gardien de porte Main-en-Fer"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "frFR")
if L then
	L.bossName = "Gardien de porte Gyro-Meurtre"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "frFR")
if L then
	L.inferno = "Inferno"
	L.inferno_desc = "Kael’thas Haut-Soleil invoque un pilier de flammes brûlant tous les personnages-joueurs se trouvant à moins de 6 mètres de la zone ciblée et infligeant des dégâts de Feu toutes les secondes pendant 8 s."
end
