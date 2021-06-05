local L = BigWigs:NewBossLocale("Harbinger Skyriss", "zhCN")
if not L then return end
if L then
	L.first_cell_trigger = "我不知道自己怎么回事"
	L.second_and_third_cells_trigger = "深不可测的力量的恐怖生物"
	L.fourth_cell_trigger = "混乱！疯狂！"
	L.warmup_trigger = "燃烧军团也不行"

	L.prison_cell = "监狱牢笼"

	L.illusion = "预言者的幻象"
	L.illusion_desc = "当预言者斯克瑞斯的生命值降低至66%和33%时，他会制造一个自己的幻象。预言者斯克瑞斯的幻象用心灵撕裂攻击玩家。"
end

L = BigWigs:NewBossLocale("The Arcatraz Trash", "zhCN")
if L then
	L.entropic_eye = "熵能之眼"
	L.sightless_eye = "盲目之眼"
	L.soul_eater = "艾瑞达食魂者"
	L.temptress = "恶毒的女妖"
	L.abyssal = "巨型深渊火魔"
end

L = BigWigs:NewBossLocale("Wrath-Scryer Soccothrates", "zhCN")
if L then
	L.felfire = "邪火"
	L.felfire_desc = "天怒预言者苏克拉底将10码范围内的所有玩家击退。击退所有玩家后，天怒预言者苏克拉底向一名玩家冲锋，在路径上留下一堵邪火之墙。邪火每秒对身在其中的所有玩家造成火焰伤害。"
end
