local L = BigWigs:NewBossLocale("Harbinger Skyriss", "ruRU")
if not L then return end
if L then
	--L.first_cell_trigger = "I have not been myself"
	--L.second_and_third_cells_trigger = "of incomprehensible power"
	--L.fourth_cell_trigger = "Anarchy! Bedlam!"
	--L.warmup_trigger = "the mighty Legion"

	--L.prison_cell = "Prison Cell"

	L.illusion = "Двойник Предвестника"
	L.illusion_desc = "Когда здоровье Предвестника Скайрисса падает до уровня 66% или 33%, он создает своего двойника, который атакует игроков при помощи заклинания \"Разрыв разума\"."
end

L = BigWigs:NewBossLocale("The Arcatraz Trash", "ruRU")
if L then
	L.entropic_eye = "Энтропический глаз"
	L.sightless_eye = "Незрячий глаз"
	L.soul_eater = "Эредераский пожиратель душ"
	L.temptress = "Сердитая искусительница"
	L.abyssal = "Чудовищный магматический инфернал"
end

L = BigWigs:NewBossLocale("Wrath-Scryer Soccothrates", "ruRU")
if L then
	L.felfire = "Огонь Скверны"
	L.felfire_desc = "Провидец Гнева Соккорат отбрасывает всех игроков в радиусе 10 м. Затем Провидец Гнева Соккорат атакует игрока, создавая стену огня Скверны на своем пути. Огонь Скверны каждую секунду наносит урон от огня всем игрокам, находящимся в нем."
end
