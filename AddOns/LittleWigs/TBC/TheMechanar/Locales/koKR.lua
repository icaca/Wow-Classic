local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "koKR")
if not L then return end
if L then
	L.despawn_message = "잠시 후 황천의 망령 사라짐"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "koKR")
if L then
	L.bossName = "문지기 무쇠주먹"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "koKR")
if L then
	L.bossName = "문지기 회전톱날"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "koKR")
if L then
	L.inferno = "불지옥"
	L.inferno_desc = "사나운 불길이 8초 동안 불지옥으로 자신을 둘러싸 10미터 반경 내에 있는 모든 플레이어에게 1초마다 화염 피해를 입힙니다. 불지옥이 활성화된 동안 사나운 불길은 움직이거나 능력을 사용할 수 없고, 불지옥이 꺼지면 새로운 대상을 선택하여 추격합니다."

	L.fixate_desc = "무작위 대상에게 시선을 고정합니다."
end
