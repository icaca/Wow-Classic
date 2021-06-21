local L = BigWigs:NewBossLocale("Commander Sarannis", "koKR")
if not L then return end
if L then
	L.mender = "붉은경비대 치유사"

	L.reinforcements = "지원군 소환"
	L.reinforcements_desc = "지휘관 새래니스는 1분마다 붉은경비대 보충병 3명과 붉은경비대 치유사 1명을 소환합니다."
end

L = BigWigs:NewBossLocale("High Botanist Freywinn", "koKR")
if L then
	L.white_seedling = "백색 덩굴손"
end

L = BigWigs:NewBossLocale("Warp Splinter", "koKR")
if L then
	L.mender = "붉은경비대 치유사"

	L.saplings = "나무정령 소환"
	L.saplings_desc = "차원의 분리자가 나무정령 6마리를 소환하여 전투에서 자신을 돕게 합니다. 나무정령은 25초 후에 자신을 희생하여 남은 생명력만큼 차원의 분리자의 생명력을 회복시킵니다."
end
