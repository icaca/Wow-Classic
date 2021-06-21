local L = BigWigs:NewBossLocale("Hungarfen", "koKR")
if not L then return end
if L then
	L.foul_spores = "더러운 곰팡이"
	L.foul_spores_desc = "헝가르펜은 생명력이 20% 이하로 떨어지면 더러운 곰팡이를 분출하여 15미터 반경 내에 있는 모든 플레이어에게서 11초 동안 400의 생명력을 착취합니다."

	L.mushroom = "지하수렁 버섯"
end

L = BigWigs:NewBossLocale("Swamplord Musel'ek", "koKR")
if L then
	--L.warmup_trigger = "Don't look so smug!"

	L.claw = "수렁발톱"
end
