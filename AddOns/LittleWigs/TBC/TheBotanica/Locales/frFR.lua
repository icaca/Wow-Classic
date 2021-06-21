local L = BigWigs:NewBossLocale("Commander Sarannis", "frFR")
if not L then return end
if L then
	L.mender = "Réparateur garde-sang"

	L.reinforcements = "Invocation de renforts"
	L.reinforcements_desc = "Le commandant Sarannis invoque 3 réservistes garde-sang ainsi qu’un réparateur garde-sang toutes les minutes."
end

L = BigWigs:NewBossLocale("High Botanist Freywinn", "frFR")
if L then
	L.white_seedling = "Bouture blanche"
end

L = BigWigs:NewBossLocale("Warp Splinter", "frFR")
if L then
	L.mender = "Réparateur garde-sang"

	L.saplings = "Invocation d'arbrisseaux"
	L.saplings_desc = "Brise-Dimension anime 6 arbrisseaux pour l’aider dans son combat. Au bout de 25 s, les arbrisseaux se sacrifient et soignent Brise-Dimension pour un montant égal à leurs points de vie restants."
end
