local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "esES") or BigWigs:NewBossLocale("Pathaleon the Calculator", "esMX")
if not L then return end
if L then
	--L.despawn_message = "Nether Wraiths Despawning Soon"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "esES") or BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "esMX")
if L then
	L.bossName = "Vigía de las puertas Manoyerro"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "esES") or BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "esMX")
if L then
	L.bossName = "Vigía de las puertas Giromata"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "esES") or BigWigs:NewBossLocale("Nethermancer Sepethrea", "esMX")
if L then
	L.inferno = "Infierno"
	L.inferno_desc = "Las llamas enfurecidas se rodean a sí mismas con llamas infernales durante 8 s, lo que inflige daño de Fuego a todos los jugadores en un radio de 10 m cada segundo. Mientras el infierno está activo, las llamas enfurecidas no pueden moverse ni utilizar facultades. Cuando termina, las llamas enfurecidas eligen un nuevo objetivo al que perseguir."

	L.fixate_desc = "Provoca que el taumaturgo se fije en un objetivo aleatorio."
end
