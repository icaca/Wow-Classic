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
	L.inferno_desc = "Les flammes violentes s’entourent d’un Inferno pendant 8 s et infligent des dégâts de Feu à tous les personnages-joueurs se trouvant à moins de 10 mètres toutes les secondes. Tant qu’elles sont englouties par les flammes, les flammes violentes ne peuvent pas se déplacer ni utiliser leurs techniques. Une fois l’Inferno éteint, les flammes violentes choisissent une nouvelle cible à poursuivre."

	L.fixate_desc = "Le lanceur de sorts se concentre sur une cible aléatoire."
end
