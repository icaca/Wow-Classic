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
	L.inferno_desc = "Kael'thas Sonnenwanderer löst eine Flammensäule aus, die allen Spielercharakteren innerhalb von 6 Metern vom Einschlagspunkt 8 Sek. lang pro Sekunde Feuerschaden zufügt."
end
