local L = BigWigs:NewBossLocale("Darkweaver Syth", "itIT")
if not L then return end
if L then
	L.elementals = "Evocazione: Elementali"
	L.elementals_desc = "Quando raggiunge il 90%, il 55% e il 15% di salute restante, Syth il Mistico Oscuro evoca 4 elementali per assisterlo in battaglia."
end

L = BigWigs:NewBossLocale("Anzu", "itIT")
if L then
	L.cyclone = "Ciclone di Piume"
	L.cyclone_desc = "Anzu imprigiona in un ciclone un personaggio, impedendogli qualsiasi azione, ma rendendolo invulnerabile per 6 s."

	L.brood = "Stirpe di Anzu"
	L.brood_desc = "Quando raggiunge il 75% e al 35% di salute restante, Anzu si esilia per 1 min, diventando immune a tutti i tipi di danni, ma restando immobilizzato. Mentre è esiliato, Anzu continua a utilizzare le sue abilità ed evoca la Stirpe di Anzu per difendersi.Sconfiggere tutti i membri della Stirpe di Anzu annulla l'effetto di esilio."
end
