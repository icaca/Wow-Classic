local L = BigWigs:NewBossLocale("Mekgineer Steamrigger", "ruRU")
if not L then return end
if L then
	--L.mech_trigger = "Tune 'em up good, boys!"

	L.mechanics = "Механики паровой оснастки"
	L.mechanics_desc = "Когда у анжинера Паропуска остается 75%, 50% и 25% здоровья, он призывает механиков паровой оснастки, которые восстанавливают ему здоровье."
end

L = BigWigs:NewBossLocale("Warlord Kalithresh", "ruRU")
if L then
	L.spell_reflection = "Отражение заклинания"
	L.spell_reflection_desc = "Полководец Калитреш окружает себя магическим барьером, с вероятностью 100% отражающим заклинания в того, кто их применил. Время действия – 8 с."
end
