local L = BigWigs:NewBossLocale("Darkweaver Syth", "deDE")
if not L then return end
if L then
	L.elementals = "Elementare beschwören"
	L.elementals_desc = "Wenn Dunkelwirker Syth 90%, 55% und 15% seiner verbleibenden Gesundheit erreicht, beschwört er 4 Elementare zu seiner Verteidigung."
end

L = BigWigs:NewBossLocale("Anzu", "deDE")
if L then
	L.cyclone = "Federsturm"
	L.cyclone_desc = "Anzu fängt einen Spielercharakter in einem Zyklon und verhindert so alle seine Aktionen. Der Spielercharakter ist dadurch jedoch 6 Sek. lang unverwundbar."

	L.brood = "Brut des Anzu"
	L.brood_desc = "Wenn Anzu 75% und 35% seiner verbleibenden Gesundheit erreicht, verbannt er sich selbst für 1 Minute, wodurch er gegen jeglichen Schaden immun und bewegungsunfähig wird. Während der Verbannung setzt Anzu weiterhin Fähigkeiten ein und beschwört Brut des Anzu zu seiner Verteidigung. Wenn die gesamte Brut des Anzu besiegt wird, bricht Anzu den Verbannungseffekt vorzeitig ab."
end
