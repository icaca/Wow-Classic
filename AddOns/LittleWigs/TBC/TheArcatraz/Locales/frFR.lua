local L = BigWigs:NewBossLocale("Harbinger Skyriss", "frFR")
if not L then return end
if L then
	--L.first_cell_trigger = "I have not been myself"
	--L.second_and_third_cells_trigger = "of incomprehensible power"
	--L.fourth_cell_trigger = "Anarchy! Bedlam!"
	--L.warmup_trigger = "the mighty Legion"

	--L.prison_cell = "Prison Cell"

	L.illusion = "Illusion du messager"
	L.illusion_desc = "Quand il ne lui reste plus que 66% et 33% de ses points de vie, le messager Cieuriss invoque un double illusoire. L’illusion du messager Cieuriss attaque les personnages-joueurs à l’aide de Pourfendre l’esprit."
end

L = BigWigs:NewBossLocale("The Arcatraz Trash", "frFR")
if L then
	L.entropic_eye = "Oeil d'entropie"
	L.sightless_eye = "Oeil sans-vue"
	L.soul_eater = "Mangeur d'âme érédar"
	L.temptress = "Tentatrice malveillante"
	L.abyssal = "Abyssal gargantuesque"
end

L = BigWigs:NewBossLocale("Wrath-Scryer Soccothrates", "frFR")
if L then
	L.felfire = "Gangrefeu"
	L.felfire_desc = "Le scrute-courroux Soccothrates repousse au loin tous les personnages-joueurs se trouvant à moins de 10 mètres. Il charge ensuite un personnage-joueur en laissant un mur de Gangrefeu sur son passage. Gangrefeu inflige des dégâts de Feu toutes les secondes à tous les personnages-joueurs pris dedans."
end
