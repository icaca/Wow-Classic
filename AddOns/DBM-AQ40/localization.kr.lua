﻿if GetLocale() ~= "koKR" then return end
local L

------------
-- Skeram --
------------
L = DBM:GetModLocalization("Skeram")

L:SetGeneralLocalization{
	name = "예언자 스케람"
}

----------------
-- Three Bugs --
----------------
L = DBM:GetModLocalization("ThreeBugs")

L:SetGeneralLocalization{
	name = "벌레 3형제"
}
L:SetMiscLocalization{
	Yauj	= "공주 야우즈",
	Vem	= "벰",
	Kri	= "군주 크리"
}

-------------
-- Sartura --
-------------
L = DBM:GetModLocalization("Sartura")

L:SetGeneralLocalization{
	name = "전투감시병 살투라"
}

--------------
-- Fankriss --
--------------
L = DBM:GetModLocalization("Fankriss")

L:SetGeneralLocalization{
	name = "불굴의 판크리스"
}
--------------
-- Viscidus --
--------------
L = DBM:GetModLocalization("Viscidus")

L:SetGeneralLocalization{
	name = "비시디우스"
}
L:SetWarningLocalization{
	WarnFreeze	= "빙결 : %d/3",
	WarnShatter	= "분해 : %d/3"
}
L:SetOptionLocalization{
	WarnFreeze	= "빙결 알림 보기",
	WarnShatter	= "분해 알림 보기"
}
L:SetMiscLocalization{
	Slow	= "느려지기 시작했습니다!",
	Freezing= "얼어붙고 있습니다!",
	Frozen	= "단단하게 얼었습니다!",
	Phase4 	= "분해되기 시작합니다!",
	Phase5 	= "부서질 것 같습니다!",
	Phase6 	= "폭발"
}
-------------
-- Huhuran --
-------------
L = DBM:GetModLocalization("Huhuran")

L:SetGeneralLocalization{
	name = "공주 후후란"
}
---------------
-- Twin Emps --
---------------
L = DBM:GetModLocalization("TwinEmpsAQ")

L:SetGeneralLocalization{
	name = "쌍둥이 제왕"
}
L:SetMiscLocalization{
	Veklor = "제왕 베클로어",
	Veknil = "제왕 베크닐라쉬"
}

------------
-- C'Thun --
------------
L = DBM:GetModLocalization("CThun")

L:SetGeneralLocalization{
	name = "쑨"
}
L:SetWarningLocalization{
	WarnEyeTentacle			= "눈 달린 촉수",
	SpecWarnWeakened		= "쑨 약화됨!"
}
L:SetTimerLocalization{
	TimerEyeTentacle		= "다음 눈 달린 촉수",
	TimerWeakened			= "쑨 약화 종료"
}
L:SetOptionLocalization{
	WarnEyeTentacle			= "눈 달린 촉수 경고 보기",
	SpecWarnWeakened		= "쑨 약화시 특수 경고 보기",
	TimerEyeTentacle		= "다음 눈 달린 촉수 타이머 바 보기",
	TimerWeakened			= "쑨 약화 지속시간 타이머 바 보기",
	RangeFrame				= "거리 창 보기(10m)"
}
L:SetMiscLocalization{
	Eye			= "쑨의 눈",
	Weakened 	= "약해집니다!",
	NotValid	= "%s 만에 안퀴40 레이드를 불완전하게 클리어했습니다. 완전하게 클리어하지 않았으므로 이번 클리어 시간은 저장되지 않습니다."
}
----------------
-- Ouro --
----------------
L = DBM:GetModLocalization("Ouro")

L:SetGeneralLocalization{
	name = "아우로"
}
L:SetWarningLocalization{
	WarnSubmerge		= "잠수",
	WarnEmerge			= "등장",
}
L:SetTimerLocalization{
	TimerSubmerge		= "잠수",
	TimerEmerge			= "등장"
}
L:SetOptionLocalization{
	WarnSubmerge		= "잠수 경고 보기",
	TimerSubmerge		= "잠수 타이머 바 보기",
	WarnEmerge			= "등장 경고 보기",
	TimerEmerge			= "등장 타이머 바 보기"
}

----------------
-- AQ40 Trash --
----------------
L = DBM:GetModLocalization("AQ40Trash")

L:SetGeneralLocalization{
	name = "안퀴40 일반몹"
}
