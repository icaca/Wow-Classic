local L = BigWigs:NewBossLocale("Commander Sarannis", "deDE")
if not L then return end
if L then
	L.mender = "Heilkundiger der Blutwärter"

	L.reinforcements = "Verstärkung beschwören"
	L.reinforcements_desc = "Kommandantin Sarannis beschwört jede Minute 3 Reservisten und einen Heilkundigen der Blutwärter."
end

L = BigWigs:NewBossLocale("High Botanist Freywinn", "deDE")
if L then
	L.white_seedling = "Weißer Setzling"
end

L = BigWigs:NewBossLocale("Warp Splinter", "deDE")
if L then
	L.mender = "Heilkundiger der Blutwärter"

	L.saplings = "Schösslinge beschwören"
	L.saplings_desc = "Warpzweig zieht 6 Schösslinge auf, die ihm im Kampf helfen sollen. Nach 25 Sek. opfern sich die Schösslinge und heilen Warpzweig um die Menge ihrer verbleibenden Gesundheit."
end
