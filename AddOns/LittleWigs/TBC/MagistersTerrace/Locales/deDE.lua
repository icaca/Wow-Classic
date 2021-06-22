local L = BigWigs:NewBossLocale("Vexallus", "deDE")
if not L then return end
if L then
	L.energy_discharged = "%s beschworen" -- %s = Pure Energy (npc ID = 24745)

	L.pure_energy = "Pure Energie"
	L.pure_energy_desc = "Vexallus beschwört pure Energie, wenn seine verbleibende Gesundheit um 15% verringert wird.$[!2,4[Heroisch] Vexallus beschwört zwei pure Energien gleichzeitig.$]"
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider MT", "deDE")
if L then
	L.warmup_trigger = "Bildet Euch nichts ein!"

	L.flame_strike = "Flammenstoß"
	L.flame_strike_desc = "Kael'thas Sonnenwanderer löst eine Flammensäule aus, die allen Spielercharakteren innerhalb von 6 Metern vom Einschlagspunkt 8 Sek. lang pro Sekunde Feuerschaden zufügt."

	L.shock_barrier = "Schockbarriere"
	L.shock_barrier_desc = "Kael'thas Sonnenwanderer umgibt sich mit einer Barriere, die 10000 Schaden absorbiert und ihn immun gegen Unterbrechungseffekte macht."
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "deDE")
if L then
	L.mage_guard = "Magierwache der Sonnenklingen"
	L.magister = "Magister der Sonnenklingen"
	L.keeper = "Bewahrer der Sonnenklingen"
end

L = BigWigs:NewBossLocale("Priestess Delrissa", "deDE")
if L then
	L.apoko = "Apoko"
	L.yazzai = "Yazzai"
	L.ellrys = "Ellrys Dämmerweih"
end
