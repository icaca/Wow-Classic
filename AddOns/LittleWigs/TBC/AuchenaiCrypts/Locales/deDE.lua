local L = BigWigs:NewBossLocale("Shirrak the Dead Watcher", "deDE")
if not L then return end
if L then
	L.focus_fire = "Fokussiertes Feuer"
	L.focus_fire_desc = "Shirrak der Totenwächter visiert den Standort eines Spielercharakters an und feuert eine Salve von Geschossen ab, die allen Spielercharakteren im Umkreis von 12 Metern Feuerschaden zufügen."
end

L = BigWigs:NewBossLocale("Exarch Maladaar", "deDE")
if L then
	L.avatar = "Avatar des Gemarterten"
	L.avatar_desc = "Wenn Exarch Maladaar noch 25% seiner Gesundheit verbleiben, beschwört er einen Avatar des Gemarterten."
end
