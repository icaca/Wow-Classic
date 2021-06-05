local L = BigWigs:NewBossLocale("Mekgineer Steamrigger", "esES") or BigWigs:NewBossLocale("Mekgineer Steamrigger", "esMX")
if not L then return end
if L then
	--L.mech_trigger = "Tune 'em up good, boys!"

	L.mechanics = "Mecánicos Vaporino"
	L.mechanics_desc = "Cuando la salud del mekigeniero Vaporino llega al 75%, 50% y 25%, invoca mecánicos Vaporino para que lo reparen."
end

L = BigWigs:NewBossLocale("Warlord Kalithresh", "esES") or BigWigs:NewBossLocale("Warlord Kalithresh", "esMX")
if L then
	L.spell_reflection = "Reflejo de hechizos"
	L.spell_reflection_desc = "El señor de la guerra Kalithresh se protege con magia, lo que refleja un 100% de los hechizos al taumaturgo durante 8 s."
end
