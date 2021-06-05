local L = BigWigs:NewBossLocale("Mekgineer Steamrigger", "zhCN")
if not L then return end
if L then
	L.mech_trigger = "好好修理他们，伙计们！"

	L.mechanics = "斯蒂里格技师"
	L.mechanics_desc = "当机械师斯蒂里格的生命值降低至75%，50%和25%时，他会召唤斯蒂里格技师来修理他。"
end

L = BigWigs:NewBossLocale("Warlord Kalithresh", "zhCN")
if L then
	L.spell_reflection = "法术反射"
	L.spell_reflection_desc = "督军卡利瑟里斯将他自己包裹在魔法之中，有100%的几率将法术反射回施法者身上，持续8秒。"
end
