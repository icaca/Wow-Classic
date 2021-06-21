local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "itIT")
if not L then return end
if L then
	--L.despawn_message = "Nether Wraiths Despawning Soon"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "itIT")
if L then
	L.bossName = "Guardiano del Portale Mandiferro"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "itIT")
if L then
	L.bossName = "Guardiano del Portale Giro-Morte"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "itIT")
if L then
	L.inferno = "Inferno"
	L.inferno_desc = "Le Fiamme Furenti vengono circondate da un inferno ardente per 8 s, infliggendo danni da fuoco a tutti i personaggi entro 10 m ogni secondo. In questo stato, le Fiamme Furenti non possono muoversi o usare abilità. Quando Inferno finisce, le Fiamme Furenti scelgono un nuovo bersaglio da inseguire."

	L.fixate_desc = "Induce l'incantatore a prendere di mira un bersaglio casuale."
end
