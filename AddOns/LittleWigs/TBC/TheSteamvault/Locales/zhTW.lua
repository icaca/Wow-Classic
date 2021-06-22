local L = BigWigs:NewBossLocale("Mekgineer Steamrigger", "zhTW")
if not L then return end
if L then
	--L.mech_trigger = "Tune 'em up good, boys!"

	L.mechanics = "蒸汽操控者技師"
	L.mechanics_desc = "當機電師蒸汽操控者的生命力上限剩下75%、50%和25%時，他召喚蒸汽操控者技師來修理自己。"
end

L = BigWigs:NewBossLocale("Warlord Kalithresh", "zhTW")
if L then
	L.spell_reflection = "法術反射"
	L.spell_reflection_desc = "督軍卡利斯瑞將自己包覆在魔法中，有100%的機率將法術反射回到施法者身上，持續8秒。"
end
