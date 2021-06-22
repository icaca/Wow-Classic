local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "deDE")
if not L then return end
if L then
	L.despawn_message = "Nethergespenster verschwinden bald"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "deDE")
if L then
	L.bossName = "Torwächter Eisenhand"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "deDE")
if L then
	L.bossName = "Torwächter Gyrotod"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "deDE")
if L then
	L.inferno = "Inferno"
	L.inferno_desc = "Tobende Flammen umgeben sich 8 Sek. lang mit einem Inferno, das allen Spielercharakteren in einem Umkreis von 10 Metern pro Sekunde Feuerschaden zufügt. Die tobenden Flammen können sich nicht bewegen oder Fähigkeiten einsetzen, solange sie in Flammen stehen. Wenn das Inferno endet, verfolgen sie ein neues Ziel."

	L.fixate_desc = "Lässt den Zaubernden sich auf ein zufälliges Ziel fixieren."
end
