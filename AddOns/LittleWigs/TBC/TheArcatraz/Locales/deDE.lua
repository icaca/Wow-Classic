local L = BigWigs:NewBossLocale("Harbinger Skyriss", "deDE")
if not L then return end
if L then
	L.first_cell_trigger = "ich war nicht ich selbst"
	L.second_and_third_cells_trigger = "von unfassbarer Macht"
	L.fourth_cell_trigger = "Anarchie! Chaos!"
	L.warmup_trigger = "die mächtige Legion"

	L.prison_cell = "Gefängniszelle"

	L.illusion = "Die Illusion des Herolds"
	L.illusion_desc = "Wenn Herold Horizontiss 66% und 33% seiner verbleibenden Gesundheit erreicht, erzeugt er eine Illusion seiner selbst. Die Illusion des Herolds Horizontiss setzt Gedankenwunde ein, um Spielercharaktere anzugreifen."
end

L = BigWigs:NewBossLocale("The Arcatraz Trash", "deDE")
if L then
	L.entropic_eye = "Entropisches Auge"
	L.sightless_eye = "Blindes Auge"
	L.soul_eater = "Seelenfresser der Eredar"
	L.temptress = "Boshafte Verführerin"
	L.abyssal = "Riesengroßer Abyss"
end

L = BigWigs:NewBossLocale("Wrath-Scryer Soccothrates", "deDE")
if L then
	L.felfire = "Teufelsfeuer"
	L.felfire_desc = "Zornseher Soccothrates schleudert alle Spielercharaktere im Umkreis von 10 Metern weg. Nachdem er alle Spielercharaktere weggestoßen hat, stürmt Zornseher Soccothrates auf einen Spielercharakter zu und hinterlässt eine Spur von Teufelsfeuer auf seinem Weg. Teufelsfeuer fügt darin befindlichen Spielercharakteren pro Sekunde Feuerschaden zu."
end
