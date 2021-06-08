local L = BigWigs:NewBossLocale("Shirrak the Dead Watcher", "esES") or BigWigs:NewBossLocale("Shirrak the Dead Watcher", "esMX")
if not L then return end
if L then
	L.focus_fire = "Enfocar Fuego"
	L.focus_fire_desc = "Shirrak el Vigía de los Muertos selecciona la ubicación de un jugador, donde lanza una descarga de misiles que infligen daño de Fuego a todos los jugadores en un radio de 12 m."
end

L = BigWigs:NewBossLocale("Exarch Maladaar", "esES") or BigWigs:NewBossLocale("Exarch Maladaar", "esMX")
if L then
	L.avatar = "Avatar de los Martirizados"
	L.avatar_desc = "Cuando su salud llega al 25%, el exarca Maladaar invoca a un Avatar de los Martirizados."
end
