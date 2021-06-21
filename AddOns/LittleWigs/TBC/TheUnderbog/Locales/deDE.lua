local L = BigWigs:NewBossLocale("Hungarfen", "deDE")
if not L then return end
if L then
	L.foul_spores = "Faulige Sporen"
	L.foul_spores_desc = "Wenn Hungarfenn 20% seiner verbleibenden Gesundheit erreicht, setzt er faulige Sporen frei, die 11 Sek. lang pro Sekunde allen Spielercharakteren in einem Umkreis von 15 Metern 400 Gesundheit entziehen."

	L.mushroom = "Tiefensumpfpilz"
end

L = BigWigs:NewBossLocale("Swamplord Musel'ek", "deDE")
if L then
	--L.warmup_trigger = "Don't look so smug!"

	L.claw = "Klaue"
end
