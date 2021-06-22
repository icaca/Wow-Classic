local L = BigWigs:NewBossLocale("Shirrak the Dead Watcher", "ruRU")
if not L then return end
if L then
	L.focus_fire = "Сконцентрированный огонь"
	L.focus_fire_desc = "Ширрак Страж Мертвых целится туда, где находится игрок, и выпускает залп ракет, которые наносят урон от огня всем игрокам в радиусе 12 м."
end

L = BigWigs:NewBossLocale("Exarch Maladaar", "ruRU")
if L then
	L.avatar = "Аватара Мученика"
	L.avatar_desc = "Когда у Экзарха Маладаара остается 25% здоровья, он призывает Аватару Мученика."
end
