local L = BigWigs:NewBossLocale("Shirrak the Dead Watcher", "frFR")
if not L then return end
if L then
	L.focus_fire = "Focalisation du feu"
	L.focus_fire_desc = "Shirrak le Veillemort cible l’emplacement d’un personnage-joueur et tire une salve de projectiles infligeant des dégâts de Feu à tous les personnages-joueurs qui se trouvent à moins de 12 mètres."
end

L = BigWigs:NewBossLocale("Exarch Maladaar", "frFR")
if L then
	L.avatar = "Avatar des martyrs"
	L.avatar_desc = "Quand l’exarque Maladaar n’a plus que 25% de ses points de vie, il invoque un avatar des martyrs."
end
