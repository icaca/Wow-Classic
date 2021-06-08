local L = BigWigs:NewBossLocale("Commander Sarannis", "itIT")
if not L then return end
if L then
	L.mender = "Guaritore Guardiasangue"

	L.reinforcements = "Evocazione: Rinforzi"
	L.reinforcements_desc = "Il Comandante Sarannis evoca 3 Riservisti Guardiasangue e un Guaritore Guardiasangue al minuto."
end

L = BigWigs:NewBossLocale("High Botanist Freywinn", "itIT")
if L then
	L.white_seedling = "Piantina Bianca"
end

L = BigWigs:NewBossLocale("Warp Splinter", "itIT")
if L then
	L.mender = "Guaritore Guardiasangue"

	L.saplings = "Evocazione: Arboscello"
	L.saplings_desc = "Scheggia Arcana evoca 6 Arboscelli ad aiutarlo in battaglia. Dopo 25 s, gli Arboscelli si sacrificano, curando Scheggia Arcana di un ammontare uguale alla loro salute restante."
end
