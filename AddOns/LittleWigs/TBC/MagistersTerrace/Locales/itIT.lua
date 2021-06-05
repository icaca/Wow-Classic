local L = BigWigs:NewBossLocale("Vexallus", "itIT")
if not L then return end
if L then
	--L.energy_discharged = "%s discharged" -- %s = Pure Energy (npc ID = 24745)

	L.pure_energy = "Energia Pura"
	L.pure_energy_desc = "Quando raggiunge il 15% di salute restante, Vexallus evoca un'Energia Pura.$[!2,4In modalità Eroica, Vexallus evoca due Energie Pure alla volta.$]"
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider MT", "itIT")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	-- L.warmup_trigger = "Don't look so smug!"

	L.flame_strike = "Assalto delle Fiamme"
	L.flame_strike_desc = "Kael'thas Solealto evoca una colonna di fuoco, bruciando tutti i personaggi entro 6 m dal centro dell'area bersaglio e infliggendo danni da fuoco aggiuntivi ogni secondo per 8 s."

	L.shock_barrier = "Barriera Folgorante"
	L.shock_barrier_desc = "Kael'thas Solealto si circonda con una barriera che assorbe 10000 danni, rendendolo immune agli effetti di interruzione."
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "itIT")
if L then
	L.mage_guard = "Guardia Magica Lamasole"
	L.magister = "Magistro Lamasole"
	L.keeper = "Guardiano Lamasole"
end

L = BigWigs:NewBossLocale("Priestess Delrissa", "itIT")
if L then
	L.apoko = "Apoko"
	L.yazzai = "Yazzai"
	L.ellrys = "Ellrys Sacrovespro"
end
