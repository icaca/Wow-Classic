local L = BigWigs:NewBossLocale("Mekgineer Steamrigger", "deDE")
if not L then return end
if L then
	L.mech_trigger = "Legt Sie tiefer, Jungs!"

	L.mechanics = "Dampfhammers Mechaniker"
	L.mechanics_desc = "Wenn Robogenieur Dampfhammer 75%, 50% und 25% seiner verbleibenden Gesundheit erreicht, beschwört er Dampfhammers Mechaniker, die ihn reparieren."
end

L = BigWigs:NewBossLocale("Warlord Kalithresh", "deDE")
if L then
	L.spell_reflection = "Zauberreflexion"
	L.spell_reflection_desc = "Kriegsherr Kalithresh umgibt sich mit Magie, die Zauber 8 Sek. lang in 100% der Fälle auf den Zaubernden zurückwirft."
end
