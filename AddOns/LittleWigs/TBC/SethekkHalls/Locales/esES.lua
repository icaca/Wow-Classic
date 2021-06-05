local L = BigWigs:NewBossLocale("Darkweaver Syth", "esES") or BigWigs:NewBossLocale("Darkweaver Syth", "esMX")
if not L then return end
if L then
	L.elementals = "Invocar elementales"
	L.elementals_desc = "Cuando la salud del tejeoscuro Syth llega al 90%, al 55% y al 15%, invoca 4 elementales para que lo defiendan."
end

L = BigWigs:NewBossLocale("Anzu", "esES") or BigWigs:NewBossLocale("Anzu", "esMX")
if L then
	L.cyclone = "Ciclón de plumas"
	L.cyclone_desc = "Anzu atrapa a un jugador en un ciclón, lo que le impide realizar acción alguna, pero lo vuelve invulnerable durante 6 s."

	L.brood = "Linaje de Anzu"
	L.brood_desc = "Cuando la salud de Anzu alcanza el 75% y el 35%, este se destierra a sí mismo durante 1 min, lo que lo vuelve inmune a todo el daño y no le permite moverse. Mientras está desterrado, Anzu puede seguir utilizando facultades e invoca al linaje de Anzu para que lo defienda.Derrotar a la totalidad del linaje de Anzu provoca que Anzu cancele el efecto de destierro antes de tiempo."
end
