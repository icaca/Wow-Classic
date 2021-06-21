local L = BigWigs:NewBossLocale("Harbinger Skyriss", "esES") or BigWigs:NewBossLocale("Harbinger Skyriss", "esMX")
if not L then return end
if L then
	--L.first_cell_trigger = "I have not been myself"
	--L.second_and_third_cells_trigger = "of incomprehensible power"
	--L.fourth_cell_trigger = "Anarchy! Bedlam!"
	--L.warmup_trigger = "the mighty Legion"

	--L.prison_cell = "Prison Cell"

	L.illusion = "Ilusión del presagista"
	L.illusion_desc = "Cuando la salud del presagista Cieloriss llega al 66% y al 33%, crea una ilusión de sí mismo. La ilusión del presagista Cieloriss usa Desgarro mental para atacar a los jugadores."
end

L = BigWigs:NewBossLocale("The Arcatraz Trash", "esES") or BigWigs:NewBossLocale("The Arcatraz Trash", "esMX")
if L then
	L.entropic_eye = "Ojo entrópico"
	L.sightless_eye = "Ojo invidente"
	L.soul_eater = "Devoraalmas eredar"
	L.temptress = "Tentadora maliciosa"
	L.abyssal = "Abisal inmenso"
end

L = BigWigs:NewBossLocale("Wrath-Scryer Soccothrates", "esES") or BigWigs:NewBossLocale("Wrath-Scryer Soccothrates", "esMX")
if L then
	L.felfire = "Fuego vil"
	L.felfire_desc = "El arúspice de cólera Soccothrates repele a todos los jugadores en un radio de 10 m. Tras repeler a todos los jugadores, el arúspice de cólera Soccothrates carga contra un jugador, lo que crea un muro de Fuego vil a su paso. Fuego vil inflige daño de Fuego cada segundo a todos los jugadores que estén en él."
end
