local L = BigWigs:NewBossLocale("Vexallus", "koKR")
if not L then return end
if L then
	L.energy_discharged = "%s 소환됨" -- %s = Pure Energy (npc ID = 24745)

	L.pure_energy = "순수한 에너지"
	L.pure_energy_desc = "벡살루스는 생명력이 15%만큼 떨어질 때마다 순수한 에너지를 소환합니다.$[!2,4영웅 난이도에서는 한 번에 순수한 에너지를 두 개 소환합니다.$]"
end

L = BigWigs:NewBossLocale("Kael'thas Sunstrider MT", "koKR")
if L then
	-- Don't look so smug! I know what you're thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind, half-night elf mongrel?
	-- L.warmup_trigger = "Don't look so smug!"

	L.flame_strike = "불기둥"
	L.flame_strike_desc = "캘타스 선스트라이더가 불기둥을 불러일으켜, 대상 지역으로부터 6미터 반경 내에 있는 모든 플레이어에게 8초 동안 1초마다 화염 피해를 입힙니다."

	L.shock_barrier = "충격 방벽"
	L.shock_barrier_desc = "캘타스 선스트라이더가 자신의 주위에 방벽을 형성하여 10000의 피해를 흡수하고, 주문 방해 효과에 면역이 됩니다."
end

L = BigWigs:NewBossLocale("Magisters' Terrace Trash", "koKR")
if L then
	L.mage_guard = "태양칼날단 마법수호병"
	L.magister = "태양칼날단 마법학자"
	L.keeper = "태양칼날단 수호자"
end

L = BigWigs:NewBossLocale("Priestess Delrissa", "koKR")
if L then
	L.apoko = "아포코"
	L.yazzai = "야자이"
	L.ellrys = "엘리스 더스크할로우"
end
