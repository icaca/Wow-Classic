local L = BigWigs:NewBossLocale("Vexallus", "ruRU")
if not L then return end
if L then
	--L.energy_discharged = "%s discharged" -- %s = Pure Energy (npc ID = 24745)

	L.pure_energy = "Чистая энергия"
	L.pure_energy_desc = "Вексалиус призывает чистую энергию каждый раз, когда уровень его здоровья падает на 15%.$[!2,4В героическом режиме Вексалиус одновременно призывает два сгустка чистой энергии.$]"
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider MT", "ruRU")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	-- L.warmup_trigger = "Don't look so smug!"

	L.flame_strike = "Поражение пламенем"
	L.flame_strike_desc = "Кель'тас Солнечный Скиталец призывает столб пламени, обжигая игроков в радиусе 6 от области действия и нанося им урон от огня раз в секунду в течение 8 с."

	L.shock_barrier = "Шоковая преграда"
	L.shock_barrier_desc = "Кель'тас Солнечный Скиталец окружает себя преградой, поглощающей 10000 ед. урона и защищающей его от прерывания заклинаний."
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "ruRU")
if L then
	L.mage_guard = "Маг-стражник Солнечного Клинка"
	L.magister = "Магистр Солнечного Клинка"
	L.keeper = "Хранитель Солнечного Клинка"
end

L = BigWigs:NewBossLocale("Priestess Delrissa", "ruRU")
if L then
	L.apoko = "Апоко"
	L.yazzai = "Яззай"
	L.ellrys = "Эллриса Почитательница Тени"
end
