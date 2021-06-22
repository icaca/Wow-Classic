local L = BigWigs:NewBossLocale("Darkweaver Syth", "koKR")
if not L then return end
if L then
	L.elementals = "정령 소환"
	L.elementals_desc = "흑마술사 시스는 생명력이 90%, 55%, 15% 이하로 떨어지면 자신을 보호해줄 정령 4마리를 소환합니다."
end

L = BigWigs:NewBossLocale("Anzu", "koKR")
if L then
	L.cyclone = "깃털 회오리"
	L.cyclone_desc = "안주가 회오리를 일으켜 플레이어를 감쌉니다. 플레이어는 6초 동안 어떤 행동도 하지 못하지만 무적 상태가 됩니다."

	L.brood = "안주의 혈족"
	L.brood_desc = "안주는 생명력이 75%, 35% 이하로 떨어지면 1분 동안 다른 공간으로 사라져 모든 피해에 면역이 되고 이동할 수 없는 상태가 됩니다. 이 동안에도 안주는 계속 능력을 사용하며, 안주의 혈족을 소환하여 자신을 방어합니다. 안주의 혈족을 모두 처치하면 안주는 효과의 지속시간을 채우지 않고 다시 나타납니다."
end
