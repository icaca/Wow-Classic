local L = BigWigs:NewBossLocale("Vexallus", "esES") or BigWigs:NewBossLocale("Vexallus", "esMX")
if not L then return end
if L then
	--L.energy_discharged = "%s discharged" -- %s = Pure Energy (npc ID = 24745)

	L.pure_energy = "Energía pura"
	L.pure_energy_desc = "Vexallus invoca una energía pura cada vez que su salud restante se reduce un 15%.$[!2,4En dificultad heroica, Vexallus invoca 2 energías puras a la vez.$]"
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider MT", "esES") or BigWigs:NewBossLocale("Kael'thas Sunstrider MT", "esMX")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	-- L.warmup_trigger = "Don't look so smug!"

	L.flame_strike = "Golpe de llamas"
	L.flame_strike_desc = "Kael'thas Caminante del Sol invoca un pilar de llamas que quema a todos los jugadores en un radio de 6 m del área objetivo y les inflige daño de Fuego cada segundo durante 8 s."

	L.shock_barrier = "Barrera de choque"
	L.shock_barrier_desc = "Kael'thas Caminante del Sol se rodea con una barrera que absorbe 10000 p. de daño y lo vuelve inmune a los efectos de interrupción."
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "esES") or BigWigs:NewBossLocale("Magisters' Terrace Trash", "esMX")
if L then
	L.mage_guard = "Guardia mago Filosol"
	L.magister = "Magister Filosol"
	L.keeper = "Vigilante Filosol"
end

L = BigWigs:NewBossLocale("Priestess Delrissa", "esES") or BigWigs:NewBossLocale("Priestess Delrissa", "esMX")
if L then
	L.apoko = "Apoko"
	L.yazzai = "Yazzai"
	L.ellrys = "Ellrys Sacronoche"
end
