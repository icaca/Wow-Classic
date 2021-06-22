local L = BigWigs:NewBossLocale("Mekgineer Steamrigger", "itIT")
if not L then return end
if L then
	--L.mech_trigger = "Tune 'em up good, boys!"

	L.mechanics = "Meccanici del Vapore"
	L.mechanics_desc = "Quando il Mekgeniere Vaporlesto raggiunge il 75%, il 50% e il 25% di salute restante, evoca dei Meccanici del Vapore che lo riparino."
end

L = BigWigs:NewBossLocale("Warlord Kalithresh", "itIT")
if L then
	L.spell_reflection = "Rifletti Incantesimo"
	L.spell_reflection_desc = "Il Signore della Guerra Kalithresh si protegge con la magia, riflettendo gli incantesimi all'incantatore il 100% delle volte per 8 s."
end
