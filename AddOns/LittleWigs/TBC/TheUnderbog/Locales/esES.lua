local L = BigWigs:NewBossLocale("Hungarfen", "esES") or BigWigs:NewBossLocale("Hungarfen", "esMX")
if not L then return end
if L then
	L.foul_spores = "Esporas hediondas"
	L.foul_spores_desc = "Cuando a Panthambre le queda un 20% de salud, lanza Esporas hediondas que roban 400 p. de salud a todos los jugadores en un radio de 15 m cada segundo durante 11 s."

	L.mushroom = "Champiñón de la Sotiénaga"
end

L = BigWigs:NewBossLocale("Swamplord Musel'ek", "esES") or BigWigs:NewBossLocale("Swamplord Musel'ek", "esMX")
if L then
	--L.warmup_trigger = "Don't look so smug!"

	L.claw = "Zarpa"
end
