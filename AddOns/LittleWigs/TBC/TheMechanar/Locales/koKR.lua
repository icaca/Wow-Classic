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
	L.inferno_desc = "캘타스 선스트라이더가 불기둥을 불러일으켜, 대상 지역으로부터 6미터 반경 내에 있는 모든 플레이어에게 8초 동안 1초마다 화염 피해를 입힙니다."
end
