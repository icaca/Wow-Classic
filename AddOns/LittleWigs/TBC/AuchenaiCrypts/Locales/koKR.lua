local L = BigWigs:NewBossLocale("Shirrak the Dead Watcher", "koKR")
if not L then return end
if L then
	L.focus_fire = "화염 집중"
	L.focus_fire_desc = "죽음의 감시인 쉴라크가 특정 플레이어의 위치에 집중 공격을 퍼부어, 해당 위치로부터 12미터 반경 내에 있는 모든 플레이어에게 화염 피해를 입힙니다."
end

L = BigWigs:NewBossLocale("Exarch Maladaar", "koKR")
if L then
	L.avatar = "순교자의 화신"
	L.avatar_desc = "총독 말라다르는 생명력이 25% 이하로 떨어지면 순교자의 화신을 소환합니다."
end
