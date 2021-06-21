local L = BigWigs:NewBossLocale("Mekgineer Steamrigger", "koKR")
if not L then return end
if L then
	--L.mech_trigger = "Tune 'em up good, boys!"

	L.mechanics = "스팀리거 정비사"
	L.mechanics_desc = "기계박사 스팀리거는 생명력이 각각 75%, 50%, 25%로 떨어지면 자신을 수리할 스팀리거 정비사를 소환합니다."
end

L = BigWigs:NewBossLocale("Warlord Kalithresh", "koKR")
if L then
	L.spell_reflection = "주문 반사"
	L.spell_reflection_desc = "장군 칼리스레쉬가 마법으로 자신을 감싸 8초 동안 100%의 확률로 주문을 시전자에게 반사합니다."
end
