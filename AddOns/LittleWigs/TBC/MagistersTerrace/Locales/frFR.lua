local L = BigWigs:NewBossLocale("Vexallus", "frFR")
if not L then return end
if L then
	--L.energy_discharged = "%s discharged" -- %s = Pure Energy (npc ID = 24745)

	L.pure_energy = "Énergie pure"
	L.pure_energy_desc = "Vexallus invoque une énergie pure chaque fois qu’il perd 15% de ses points de vie restants.$[!2,4En mode héroïque, Vexallus invoque deux énergies pures à la fois.$]"
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider MT", "frFR")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	-- L.warmup_trigger = "Don't look so smug!"

	L.flame_strike = "Frappe de flammes"
	L.flame_strike_desc = "Kael’thas Haut-Soleil invoque un pilier de flammes brûlant tous les personnages-joueurs se trouvant à moins de 6 mètres de la zone ciblée et infligeant des dégâts de Feu toutes les secondes pendant 8 s."

	L.shock_barrier = "Barrière de choc"
	L.shock_barrier_desc = "Kael’thas Haut-Soleil s’entoure d’une barrière absorbant 10000 points de dégâts et prévenant tout effet d’interruption."
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "frFR")
if L then
	L.mage_guard = "Garde mage lamesoleil"
	L.magister = "Magistère lamesoleil"
	L.keeper = "Gardien lamesoleil"
end

L = BigWigs:NewBossLocale("Priestess Delrissa", "frFR")
if L then
	L.apoko = "Apoko"
	L.yazzai = "Yazzai"
	L.ellrys = "Ellrys Sanctebrune"
end
