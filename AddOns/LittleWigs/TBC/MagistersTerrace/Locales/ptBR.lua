local L = BigWigs:NewBossLocale("Vexallus", "ptBR")
if not L then return end
if L then
	L.energy_discharged = "%s descarregado" -- %s = Pure Energy (npc ID = 24745)

	L.pure_energy = "Energia Pura"
	L.pure_energy_desc = "Vexallus evoca uma Energia Pura sempre que sua vida for reduzida em 15%.$[!2,4Na dificuldade Heroica, Vexallus evoca duas Energias Puras de uma vez.$]"
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider MT", "ptBR")
if L then
	L.warmup_trigger = "Não fiquem aí, com essa cara de arrogância!"

	L.flame_strike = "Golpe Flamejante"
	L.flame_strike_desc = "Kael'thas Andassol evoca um pilar de fogo, queimando todos os jogadores em um raio de 6 metros da área alvejada e causando dano de fogo a cada segundo por 8 s."

	L.shock_barrier = "Barreira de Choque"
	L.shock_barrier_desc = "Kael'thas Andassol se protege com uma barreira que absorve 10000 de dano e o torna imune a efeitos de interrupção."
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "ptBR")
if L then
	L.mage_guard = "Guarda Mago Gumélion"
	L.magister = "Magíster Gumélion"
	L.keeper = "Guardião Gumélion"
end

L = BigWigs:NewBossLocale("Priestess Delrissa", "ptBR")
if L then
	L.apoko = "Apoke"
	L.yazzai = "Yazzai"
	L.ellrys = "Ellrys Sacrepúsculo"
end
