local L = BigWigs:NewBossLocale("Mekgineer Steamrigger", "frFR")
if not L then return end
if L then
	--L.mech_trigger = "Tune 'em up good, boys!"

	L.mechanics = "Mécaniciens montevapeurs"
	L.mechanics_desc = "Quand il ne lui reste plus que 75%, 50% et 25% de ses points de vie, le mekgénieur montevapeur invoque des mécaniciens montevapeurs pour le réparer."
end

L = BigWigs:NewBossLocale("Warlord Kalithresh", "frFR")
if L then
	L.spell_reflection = "Renvoi de sort"
	L.spell_reflection_desc = "Le seigneur de guerre Kalithresh s’entoure de magie, ce qui lui permet de renvoyer les sorts à leur lanceur dans 100% des cas pendant 8 s."
end
