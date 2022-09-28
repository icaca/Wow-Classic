RXPGuides.RegisterGuide([[
#version 5
#wotlk
#group RestedXP 法师 AoE 68-80
<< Mage
#name 68-80 法师 AoE

step
#completewith WHFP << Horde
#completewith VKHS << Alliance
+欢迎使用RXPGuides AoE Mage 68-80指南！
.link https://discord.com/invite/ApNgbdQNQy >> 由于这是Beta版，指南可能有一些错误。如果在玩游戏时遇到任何问题，请在此处报告！
step << Horde
#completewith BTZep1
.zone Orgrimmar >> 电传至Orgrimmar
step << Horde
#level 68
.goto Orgrimmar,38.4,86.1
>>下楼去
.trainer >> 训练你的职业咒语
step << Horde
#label BTZep1
.goto Durotar,41.6,18.2,30,0
.goto Durotar,41.4,17.6
.zone BoreanTundra >>把齐柏林飞艇从杜隆塔尔带到伯兰苔原
step << Horde
#completewith end
#label WHHS
.goto BoreanTundra,41.92,54.49
.home >> 将您的炉石设置为战歌控制
step << Horde
#completewith end
#requires WHHS
#label WHFP
.goto BoreanTundra,40.72,52.54,20,0
.goto BoreanTundra,40.36,51.39
>> 走楼梯，然后乘电梯到楼顶
.fp Warsong Hold >> 获取战歌等待飞行路径
step << Alliance
#completewith Boat1
.zone Stormwind City >> 传送到暴风城
step << Alliance
#level 68
.goto Stormwind City,49.2,87.7
.trainer >> 训练你的职业咒语
step << Alliance
#label Boat1
.goto Stormwind City,43.5,52.7,70,0
.goto Stormwind City,17.7,25.5
.zone BoreanTundra >>前往暴风港。船到了就上船。带它去Borean Tundra
step << Alliance
#completewith end
#label VKFP
.goto BoreanTundra,58.9,68.3
.fp Valiance Keep >> 获取Valiance保持飞行路线
step << Alliance
#completewith end
#requires VKFP
#label VKHS
.goto BoreanTundra,58.5,68.3,15,0
.goto BoreanTundra,58.3,68.1
>>进入客栈
.home >> 将您的炉石设置为Valiance Keep
step << skip
.loop 75,BoreanTundra,54.0,48.8,55.1,42.4,53.6,39.2,54.8,38.4,61.8,40.0,62.2,31.7,55.6,27.1,57.3,34.2
.xp 72 >> AoE将猛犸、狼、机器、鹰和驯鹿研磨至72
step
#requires WHFP << Horde
#requires VKHS << Alliance
.loop 75,BoreanTundra,48.77,48.69,42.48,47.53,43.11,42.42,47.18,40.43,48.77,48.69
.xp 69 >> AoE将犀牛磨碎至69
step
#level 69
#completewith next
.zone Undercity >> 传送到地下城 << Horde
.zone Stormwind City >> 传送到暴风城 << Alliance
step
#level 69
.goto Undercity,85.1,10.0 << Horde
.goto Stormwind City,49.2,87.7 << Alliance
.trainer >> 训练你的职业咒语
step
#completewith next
.hs >> 心与心保持一致 << Alliance
.hs >> 心脏到征服保持 << Horde
step
.loop 75,BoreanTundra,48.77,48.69,42.48,47.53,43.11,42.42,47.18,40.43,48.77,48.69
.xp 70 >> AoE将犀牛磨碎至70
step
#level 70
#completewith next
.zone Undercity >> 传送到地下城 << Horde
.zone Stormwind City >> 传送到暴风城 << Alliance
step
#level 70
.goto Undercity,85.1,10.0 << Horde
.goto Stormwind City,49.2,87.7 << Alliance
.trainer >> 训练你的职业咒语
step
#completewith next
.hs >> 心脏到征服保持 << Horde
.hs >> 心与心保持一致 << Alliance
step << skip
.loop 75,BoreanTundra,48.77,48.69,42.48,47.53,43.11,42.42,47.18,40.43
.line BoreanTundra,48.77,48.69,42.48,47.53,43.11,42.42,47.18,40.43
.xp 71 >> AoE将犀牛碾碎至71
step << skip
#level 71
#completewith next
.zone Undercity >> 传送到地下城 << Horde
.zone Stormwind City >> 传送到暴风城 << Alliance
step << skip
#level 71
.goto Undercity,85.1,10.0 << Horde
.goto Stormwind City,49.2,87.7 << Alliance
.trainer >> 训练你的职业咒语
step << skip
#completewith next
.hs >> 心脏到征服保持 << Horde
.hs >> 心与心保持一致 << Alliance
step
.loop 75,BoreanTundra,48.77,48.69,42.48,47.53,43.11,42.42,47.18,40.43,48.77,48.69
.xp 72 >> AoE将犀牛研磨至72
step << skip
#level 72
#completewith next
.zone Undercity >> 传送到地下城 << Horde
.zone Stormwind City >> 传送到暴风城 << Alliance
step << skip
#level 72
.goto Undercity,85.1,10.0 << Horde
.goto Stormwind City,49.2,87.7 << Alliance
.trainer >> 训练你的职业咒语
step << skip
#completewith next
.hs >> 心脏到征服保持 << Horde
.hs >> 心与心保持一致 << Alliance
step << skip
#completewith end
#label ALFP
.goto BoreanTundra,45.33,34.62
>>前往琥珀色壁架
.fp Amber Ledge >> 获取琥珀色Ledge飞行路径
step << Horde
#completewith end
#label TaunFP
.goto BoreanTundra,77.76,37.77
>>前往陶恩卡省
.fp Taunka'le Village >> 获得Taunka'le村的飞行路线
step << Alliance
#completewith end
#label UnuFP
.goto BoreanTundra,78.54,51.53
>>前往Unu'pe
.fp Unu'pe >> 获取Unu'pe飞行路线
step << Alliance
.goto BoreanTundra,82.17,46.41
>>与二等兵凯西交谈
.accept 12157 >>接受丢失的信使
step
#completewith next
.goto Dragonblight,12.39,55.22
.zone Dragonblight >> 前往Dragonblight
step << Horde
#completewith end
#label AgmarFP
.goto Dragonblight,37.51,45.77
>>前往阿格玛锤子
.fp Agmar's Hammer >> 获取Agmar的Hammer飞行路线
step << Horde
#completewith end
#requires WyrmFP
#label WyrmFP
.goto Dragonblight,60.32,51.55
>>前往Wyrmrest Temple
.fp Wyrmrest Temple >> 获得Wyrmrest Temple飞行路线
step << Horde
#completewith end
#requires WyrmFP
#label VenomFP
.goto Dragonblight,76.48,62.20
.fp Venomspite >> 获取Venomwhile飞行路径
step << Horde
#completewith end
#requires VenomFP
#label VenomHS
.goto Dragonblight,76.87,63.13
.home >>将你的心设为毒液怨恨
step << Alliance
#completewith end
#label StarsFP
.goto Dragonblight,29.15,55.32
>>星空之旅
.fp Stars' Rest >> 获取星星的休息飞行路径
step << Alliance
.goto Dragonblight,28.84,56.16
>>与兰森交谈
.turnin 12157 >>交出丢失的信使
.accept 12171 >>接受叛徒和叛国罪
step << Alliance
.goto Dragonblight,29.16,55.37
>>与Palena交谈
>>接受这个任务会让你飞到温特加德要塞
.turnin 12171 >>叛徒和叛国者的上缴
.accept 12174 >>接受高级指挥官Halford Wyrmbane
step << Alliance
#completewith end
#label WinterFP
.goto Dragonblight,77.08,49.86
.fp Wintergarde Keep>>获取Wintergarde Keep飞行路线
step << Alliance
#requires WinterFP
.goto Dragonblight,78.59,48.18
>>与Halford Wyrmbane交谈
.turnin 12174 >>交给高级指挥官哈尔福德·怀尔姆班
.accept 12235 >>接受纳克萨玛斯和温特加尔德的沦陷
step << Alliance
#completewith end
#label WinterHS
.goto Dragonblight,77.46,51.43
.home >>将您的炉石设置为Wintergarde Keep
step << Alliance
#requires WinterHS
.goto Dragonblight,77.18,50.09
>>返回到Flight Master。与Urik交谈
.turnin 12235 >>纳克萨玛斯与温特加尔德的沦陷
.accept 12237 >>接受Wintergarde Defender的飞行
step << skip
#completewith next
.cast 48388 >> 使用鹰头狮哨声来骑上一只温特加德鹰头狮。你可以用它在温特加德和腐肉场飞行
.use 37287
step << skip
#requires VenomHS
.loop 75,BoreanTundra,48.77,48.69,42.48,47.53,43.11,42.42,47.18,40.43
.xp 73 >> AoE将猩红打磨到73
step << skip
#level 73
#completewith next
.zone Undercity >> 传送到地下城 << Horde
.zone Stormwind City >> 传送到暴风城 << Alliance
step << skip
#level 73
.goto Undercity,85.1,10.0 << Horde
.goto Stormwind City,49.2,87.7 << Alliance
.trainer >> 训练你的职业咒语
step << skip
#level 73
#label WinterHS1
#completewith next
.hs >> 从心脏到毒液 << Horde
.hs >> 温特加尔德要塞的壁炉 << Alliance
step << Alliance
#requires WinterHS1
#completewith next
.cast 48388 >> 使用鹰头狮哨声来骑上一只温特加德鹰头狮。你可以用它在温特加德和腐肉场飞行
.use 37287
step
.loop 75,BoreanTundra,48.77,48.69,42.48,47.53,43.11,42.42,47.18,40.43
.xp 74 >> AoE将猩红碾碎至74
step
#label WinterHS2
#completewith next
.hs >> 从心脏到毒液 << Horde
.hs >> 温特加尔德要塞的壁炉 << Alliance
step
#completewith next
.goto Dragonblight,77.08,49.86 << Alliance
.fly Stars' Rest>>飞到星星的休息处 << Alliance
.goto Dragonblight,76.48,62.20 << Horde
.fly Agmar >>飞向阿格玛之锤 << Horde
.zoneskip Dalaran
.zoneskip SholazarBasin
step << Horde
.goto Dragonblight,38.05,46.22
>>与Aethas交谈
.accept 12791 >>接受达拉然魔法王国
.zoneskip SholazarBasin
.zoneskip Dalaran
step << Horde
.goto Dragonblight,38.05,46.22
.zone Dalaran >>向Aethas请求传送到达拉然
.zoneskip SholazarBasin
.skipgossip
step << Alliance
.goto Dragonblight,29.0,55.5
>>与Modera交谈
.accept 12794 >>接受达拉然魔法王国
.zoneskip SholazarBasin
.zoneskip Dalaran
step << Alliance
.goto Dragonblight,29.0,55.5
.zone Dalaran >>向Modera请求传送至达拉然
.zoneskip SholazarBasin
.skipgossip
step
.abandon 12791 >> 放弃达拉然魔法王国。不要把这个交进去 << Horde
.abandon 12794 >> 放弃达拉然魔法王国。不要把这个交进去 << Alliance
step
.goto Dalaran,56.3,46.7
.trainer >>进入大楼。训练您的达拉然门户
step
.goto Dalaran,54.94,46.19
.trainer >> 训练你的职业咒语
step
#completewith end
#label DalaranFP
.goto Dalaran,72.18,45.77
.fp Dalaran >> 获取达拉然飞行路线
step
#requires DalaranFP
#completewith next
.goto Dalaran,68.54,42.07
>>前往克拉苏斯登陆。与Pentarus交谈
.accept 12521 >>接受Hemet Nesingwarve到底在哪里？
step
#requires DalaranFP
.goto Dalaran,68.54,42.07
.zone SholazarBasin >>叫彭塔鲁斯带你去肖拉扎尔盆地。这需要50秒
.skipgossip
step
.goto SholazarBasin,39.70,58.65
>>与挂在树上的蒙特交谈
.turnin 12521 >>上车Hemet Nesingwarve到底在哪里？
.accept 12489 >>欢迎来到Sholazar盆地
step
#completewith end
#label Nesingwary
.goto SholazarBasin,26.8,59.3,0,0
.home >> 将您的炉石设置为Nesingwarve大本营
>>如果需要，购买食物
step
>>前往Nesingwarve大本营。与Hemet、Debaar和Chad交谈
.turnin 12489 >>欢迎来到Sholazar Basin
.goto SholazarBasin,27.09,58.64
.accept 12524 >>接受风险投资公司冒险
.goto SholazarBasin,27.25,59.90
.accept 12624 >>接受它可以在任何地方！
.goto SholazarBasin,26.86,58.94
step
#requires Nesingwary
.goto SholazarBasin,25.35,58.48
>>与卫斯理通话
.accept 12522 >>接受需要引擎，接受引擎
step
#completewith VentureCo2
>>杀死Sholazar的所有暴徒以获得黄金订婚戒指。根本不要关注这个任务
.complete 12624,1 
step
.goto SholazarBasin,38.69,56.72
>>在飞行机器旁边的水面上抢劫“引擎”
.complete 12522,1 
step
#completewith Helice
.goto SholazarBasin,36.8,47.3,0
>>AoE Swindlegrin’s Dig的创业公司
.complete 12524,1 
step
.goto SholazarBasin,35.55,47.42
>>与工程师Helice交谈，开始护送
.accept 12688 >>接受工程灾难
step
#label Helice
.goto SholazarBasin,37.27,50.59
>>护送Helice
.complete 12688,1 
step
#completewith next
>>AoE Swindlegrin’s Dig的创业公司
.complete 12524,1 
step
.loop 75,SholazarBasin,36.21,51.02,37.13,45.50,32.88,45.11,31.67,48.72
.xp 75 >> AoE创业公司至75
step
.goto SholazarBasin,37.35,45.78,50,0
.goto SholazarBasin,33.31,45.31,50,0
.goto SholazarBasin,33.13,47.90
>>AoE Swindlegrin’s Dig的创业公司
.complete 12524,1 
step
#level 75
#completewith next
.zone Dalaran >> 传送至达拉然
step
#level 75
.goto Dalaran,54.94,46.19
.trainer >> 训练你的职业咒语
step
#completewith Debaar1
.hs >> Nesingwarve大本营之炉
step
>>返回Nesingwarve的大本营。与Hemet和Debaar交谈
.turnin 12688 >>提交工程灾难
.goto SholazarBasin,27.09,58.64
.turnin 12524 >>投靠风险投资公司冒险
.accept 12525 >>接受擦掉他脸上的表情
.goto SholazarBasin,27.25,59.90
.isQuestComplete 12688
step
#requires EscortEnd
#label Debaar1
.goto SholazarBasin,27.25,59.90
>>与Debaar交谈
.turnin 12524 >>投靠风险投资公司冒险
.accept 12525 >>接受擦掉他脸上的表情
step
.goto SholazarBasin,26.86,58.94
>>与乍得对话
.turnin 12624 >>交上来它可能在任何地方！
.isQuestComplete 12624
step
.goto SholazarBasin,25.35,58.48
>>与卫斯理通话
.turnin 12522 >>转弯需要引擎，带上引擎
.accept 12523 >>接受拥有一部分，给予一部分
step
#completewith VentureCo2
.goto SholazarBasin,33.2,45.7,0
>>抢劫在斯温德莱格林的地窖附近发现的各种备件
.complete 12523,1 
step
.goto SholazarBasin,35.49,50.00
>>杀死木平台上的Foreman Swindlegrin和Meatpie
.complete 12525,1 
.complete 12525,2 
step
#label VentureCo2
.loop 75,SholazarBasin,36.21,51.02,37.13,45.50,32.88,45.11,31.67,48.72
.xp 76 >> AoE创业公司至76
step
.goto SholazarBasin,33.2,45.7,50,0
.goto SholazarBasin,37.03,46.72
>>抢劫在斯温德莱格林的地窖附近发现的各种备件
.complete 12523,1 
step
>>杀死Sholazar的所有暴徒以获得黄金订婚戒指。根本不要关注这个任务
.complete 12624,1 
step
#level 76
#completewith next
.zone Dalaran >> 传送至达拉然
step
#level 76
.goto Dalaran,54.94,46.19
.trainer >> 训练你的职业咒语
step
#completewith Debaar1
.hs >> Nesingwarve大本营之炉
step
#completewith end
#label NesFP
.goto SholazarBasin,25.35,58.48
>>与卫斯理通话，然后与飞行机器和卡尔弗特通话
.turnin 12523 >>上交一部分，给一部分
.fp Nesingwary Base Camp >> 获得Nesingwarve大本营飞行路线
.goto SholazarBasin,25.27,58.45


step
#requires NesFP
>>先和Debaar谈谈，然后是Drostan
.turnin 12525 >>转身擦掉他脸上的笑容
.goto SholazarBasin,27.25,59.90
.accept 12589 >>接受踢，什么踢？
.goto SholazarBasin,27.08,59.91
step
.goto SholazarBasin,27.08,59.91
.use 38573 >> 用你包里的RJR步枪射击Lucky Wilhelm。这样做直到目标完成，然后重新装备你的魔杖
.complete 12589,1 
.turnin 12589 >>转身踢腿，什么踢腿？

step
.goto SholazarBasin,26.86,58.94
>>与乍得对话
.turnin 12624 >>交上来它可能在任何地方！
step
.loop 75,SholazarBasin,36.21,51.02,37.13,45.50,32.88,45.11,31.67,48.72
.xp 77 >> AoE创业公司至77
step
#completewith next
.zone Dalaran >> 传送至达拉然
step
#level 77
.goto Dalaran,54.94,46.19
.trainer >> 训练你的职业咒语
step
.goto Dalaran,69.81,45.45
.train 54197 >> 从Hira训练寒冷天气飞行
step
#completewith next
>>如果你有295或更多的法术命中（和精准天赋），跳过这一步
.hs >> Nesingwarve大本营之炉
step
.loop 75,SholazarBasin,36.21,51.02,37.13,45.50,32.88,45.11,31.67,48.72
>>如果你有295或更多的法术命中（和精准天赋），跳过这一步
.xp 78 >> AoE创业公司至78
step
#completewith next
.zone Dalaran >> 传送至达拉然
step
#level 78
.goto Dalaran,54.94,46.19
.trainer >> 训练你的职业咒语
step
#completewith next
.goto IcecrownGlacier,59.0,73.8
.zone Icecrown >> 飞向冰冠
step
.goto IcecrownGlacier,59.0,73.8
.xp 79 >> AoE亡灵到79
step
#level 79
#completewith next
.zone Dalaran >> 传送至达拉然
step
#level 79
.goto Dalaran,54.94,46.19
.trainer >> 训练你的职业咒语
step
#completewith next
.goto IcecrownGlacier,59.0,73.8
.zone Icecrown >> 飞向冰冠
step
.goto IcecrownGlacier,59.0,73.8
.xp 80 >> AoE亡灵到80
step
+恭喜您完成了RestedXP 68-80 AoE调平指南！感谢您使用RestedXP。
.link https://discord.com/invite/ApNgbdQNQy >> 由于这是Beta版，指南可能有一些错误。如果您在玩游戏时遇到任何问题，请在此处报告！
]])
RXPGuides.RegisterGuide([[
#version 7
#wotlk
#group 死亡骑士开始
<< DK
#name 55-58 东瘟疫之地:血色领地
step
.goto ScarletEnclave,51.3,35.1
.accept 12593 >>接受巫妖王的服务

step
.goto ScarletEnclave,48.3,28.2
>>与Razuvious教练交谈以提交您的任务
.turnin 12593 >>为巫妖王服务
.accept 12619 >>接受印有徽标的Runeblade
step
.goto ScarletEnclave,46.8,29.1,40,0
.goto ScarletEnclave,48.1,27.9,40,0
.goto ScarletEnclave,49.2,26.5,40,0
.goto ScarletEnclave,46.8,29.1,40,0
.goto ScarletEnclave,48.1,27.9,40,0
.goto ScarletEnclave,49.2,26.5
>>掠夺战场上的佩剑。它可以在墙周围有多个繁殖位置
.collect 38607,1,12619,1 
step
.goto ScarletEnclave,47.9,27.6
.use 38607 >> 前往Runeforge。点击你包里的战斗佩剑，使其成为一把Runeblade剑
.complete 12619,1 
step
.goto ScarletEnclave,48.3,28.2
>>返回Razuvious
.turnin 12619 >>交上印有花纹的Runeblade
.accept 12842 >>接受逃跑：准备战斗
step
.goto ScarletEnclave,47.9,27.5
>>前往Runeforge。在你的魔法书中点击Runeforging并将其拖到你的栏上。对你的新武器应用一个附魔
.complete 12842,1 
step
.goto ScarletEnclave,48.3,28.2
>>返回Razuvious
.turnin 12842 >>上缴Runeforging：准备战斗
.accept 12848 >>接受无尽的饥饿
step
.goto ScarletEnclave,48.4,29.0
.use 40732 >>到房间中间去。点击其中一个Acherus灵魂监狱，将无名小卒链接到墙上与他们战斗。在等待RP时跑回Razuvious，死亡将他们紧紧地抓住了他。杀了它
.complete 12848,1 
step
.goto ScarletEnclave,48.3,28.2
>>返回Razuvious
.turnin 12848 >>交出无尽的饥饿
.accept 12636 >>接受阿舍罗斯之眼
step
.goto ScarletEnclave,51.3,35.1
>>返回巫妖王
.turnin 12636 >>交给阿舍罗斯的眼睛
.accept 12641 >>接受死亡来自高空
step
#label dkeyes
#completewith next
.goto ScarletEnclave,51.1,36.2
.goto ScarletEnclave,61.5,60.6,0
>>点击巫妖王左边或右边的眼睛
>>使用“Acherus虹吸”（1）分析锻造。使用“裹尸布”（3）以避免受到血腥暴徒的伤害。
.complete 12641,1 
step
.goto ScarletEnclave,61.7,68.2,0
>>使用“Acherus虹吸”（1）来分析Hold。使用“裹尸布”（3）以避免受到血腥暴徒的伤害。
.complete 12641,3 
step
.goto ScarletEnclave,53.4,70.7,0
>>使用“Acherus虹吸”（1）分析市政厅。使用“裹尸布”（3）以避免受到血腥暴徒的伤害。
.complete 12641,2 
step
.goto ScarletEnclave,52.2,80.7,0
>>使用“阿切鲁斯虹吸管”（1）来分析教堂。使用“裹尸布”（3）以避免受到血腥暴徒的伤害。
.complete 12641,4 

step
#completewith next
+完成后，按取消或（4）返回Ebon Hold
step
#requires dkeyes
.goto ScarletEnclave,51.3,35.3
>>返回巫妖王
.turnin 12641 >>死亡来自高空
.accept 12657 >>接受天灾的力量
step
#completewith next
.goto ScarletEnclave,50.5,33.4,10 >>跑进紫色大门
step
.goto ScarletEnclave,48.9,29.8
>>与底层房间中间的Darion交谈
.turnin 12657 >>交出天灾的力量
.accept 12850 >>接受向天灾指挥官塔拉诺的报告
step
.goto ScarletEnclave,51.0,34.6
>>与你目前所在楼层的天灾指挥官塔拉诺交谈
.turnin 12850 >>向天灾指挥官塔拉诺提交报告
.accept 12670 >>接受鲜红的收获
step
#completewith next
.goto ScarletEnclave,52.0,35.0
.fly >>点击天灾鹰头狮进入死亡决裂
step
.goto ScarletEnclave,52.3,33.9
>>与瓦拉纳王子交谈
.turnin 12670 >>《血色丰收》上映
.accept 12678 >>接受混乱的驱使，让痛苦控制缰绳
step
#completewith next
.goto ScarletEnclave,53.2,33.5,0
.goto ScarletEnclave,51.4,36.1,0
>>与在路上巡逻的Salanar交谈
.accept 12680 >>接受Grand Theft Palomino
step
.goto ScarletEnclave,54.5,34.2
>>在尸体坑与奥尔伦交谈
.accept 12733 >>接受死亡的挑战
step
.goto ScarletEnclave,53.2,33.5,30,0
.goto ScarletEnclave,51.4,36.1
>>与在路上巡逻的Salanar交谈
.accept 12680 >>接受Grand Theft Palomino
step
.goto ScarletEnclave,53.7,36.3,50,0
.goto ScarletEnclave,52.1,38.2
>>与Orithos（巡逻骷髅弓箭手）交谈
.accept 12679 >>接受今晚我们在Havenshire吃饭
step
#completewith next
.goto ScarletEnclave,55.6,51.4
>>杀死该地区的血腥暴徒和黑文郡公民。掠夺该地区地面上的萨龙石箭
.complete 12678,1 
.complete 12678,2 
.complete 12679,1 
step
#completewith next
.goto ScarletEnclave,57.4,42.3
.vehicle >>偷任何Havenshire马。小心马厩主人基特里克在马区巡逻，因为他是精英
step
.goto ScarletEnclave,52.4,34.3
>>把偷来的马还给死神之怒。在冷却时使用“Gallop”（2）加速跑步。使用“交付被盗马匹”（1）返还
.complete 12680,1 
step
.goto ScarletEnclave,53.2,33.5,30,0
.goto ScarletEnclave,51.4,36.1
>>与在路上巡逻的Salanar交谈
.turnin 12680 >>移交Grand Theft Palomino
.accept 12687 >>接受进入阴影王国
step
#completewith next
.goto ScarletEnclave,54.6,46.4
.vehicle >>杀死一个黑暗骑士阿舍罗斯。杀了他后，骑上他的死亡充电器
step
.goto ScarletEnclave,52.4,34.7
>>将Acherus死亡充电器返回死亡违约。使用“骑士召唤”（1）返回。
.complete 12687,1 
step
.goto ScarletEnclave,53.2,33.5,30,0
.goto ScarletEnclave,51.4,36.1
>>与在路上巡逻的Salanar交谈
.turnin 12687 >>转入阴影王国
step
#completewith next
.cast 48778 >> 进入你的角色面板（C），然后进入集合选项卡。召唤你的弓箭手死亡充电器，然后将其绑定到你的栏中
step
#completewith Mailbox
.goto ScarletEnclave,55.6,51.4,0
>>杀死该地区的哈文郡市民。掠夺该地区地面上的萨龙石箭
.complete 12678,2 
.complete 12679,1 
step
.goto ScarletEnclave,55.9,38.8,50,0
.goto ScarletEnclave,53.9,45.6
>>杀死该地区的血腥暴徒
.complete 12678,1 
step
#label Mailbox
.goto ScarletEnclave,55.3,46.2
>>单击邮箱上的信件
.turnin 12711 >>交出放弃的邮件
step
#sticky
#label Citizens
.goto ScarletEnclave,56.0,58.8,0,0
>>杀死在该地区逃跑的Havenshire市民
.complete 12678,2 
step
.goto ScarletEnclave,56.1,51.9
>>在整个场地内抢夺地面上的箭
.complete 12679,1 
step
#requires Citizens
.goto ScarletEnclave,51.9,35.4,30,0
.goto ScarletEnclave,51.0,33.6,30,0
.goto ScarletEnclave,53.8,30.9,30,0
.goto ScarletEnclave,51.9,35.4
>>围绕死亡破解，与5名死亡骑士入门对话并决斗。不要跑出30码的决斗范围
.complete 12733,1 
.skipgossip
step
.goto ScarletEnclave,54.5,34.5
.turnin 12733 >>提交死亡挑战
.isQuestComplete 12733
step
#requires Citizens
>>骑马回到死亡的缺口
.turnin 12679 >>我们今晚在Havenshire吃饭
.goto ScarletEnclave,53.3,36.8
.turnin 12733 >>提交死亡挑战
.goto ScarletEnclave,54.5,34.5
.turnin 12678 >>如果混乱不断，就上缴，让苦难控制缰绳
.accept 12697 >>接受收割机Gothik
.goto ScarletEnclave,52.3,34.0
step
.goto ScarletEnclave,54.0,35.0
>>与收割机Gothik交谈
.turnin 12697 >>收割机Gothik
.accept 12698 >>接受不断给予的礼物
step
#completewith next
.use 39253
+跑进Havenshire Mines。把你们包里的收割机礼物用在并没有战斗的采血者身上，直到你们有5个食尸鬼跟着你们，然后回到死亡之裂。
.goto ScarletEnclave,58.4,30.9,30,0
.goto ScarletEnclave,60.0,31.6,30,0
.goto ScarletEnclave,61.6,27.5,0
step
.goto ScarletEnclave,54.1,34.9
>>死亡决裂时将所有5个食尸鬼送回戈提克
.complete 12698,1 
.turnin 12698 >>交上不断给予的礼物
.accept 12700 >>接受机会的攻击
step
.goto ScarletEnclave,52.3,34.0
>>返回瓦拉纳
.turnin 12700 >>交出机会攻击
.accept 12701 >>在光明点接受屠杀
step
.goto ScarletEnclave,60.2,32.7,40,0
.goto ScarletEnclave,63.5,32.3,20,0
.goto ScarletEnclave,67.7,39.1
>>跑过矿井，从山上下来，走到Light’s Point Tower后面。在那里下山，然后跑到船上。避开你看到的所有非矿工暴徒。如果你死了，等待瓦尔基尔施压（不要释放灵魂）
>>一旦你到了船上，进入一门血色大炮。垃圾邮件“血色大炮”（1）杀死血色卫士。如果血色卫士开始近战攻击加农炮，使用“电磁脉冲”（2）
.complete 12701,1 
step
#completewith next
.vehicle >> 当你杀死了所有100名防御者后，使用“骷髅鹰头逃脱”（3）返回死神之手
step
.goto ScarletEnclave,52.3,34.1
>>返回瓦拉纳
.turnin 12701 >>在光点上发动屠杀
.accept 12706 >>接受死亡的胜利！
step << skip
.hs >> Hearth back to Acherus（您的Hearth在此处自动设置）

step << skip
#completewith next
.goto ScarletEnclave,50.5,33.4,10 >>把传送机带到楼下。
step
#completewith next
.goto ScarletEnclave,53.1,32.5
.fly >> 把一只天灾鹰头狮带回阿彻鲁斯
step
.goto ScarletEnclave,48.9,29.9
>>返回Darion Mograine
.turnin 12706 >>死而复生！
.accept 12714 >>接受巫妖王的意志
step
.goto ScarletEnclave,47.5,26.5
.turnin 12849 >>交出血、霜和邪恶的力量
.trainer >> 训练你的职业咒语
step
.goto ScarletEnclave,47.5,26.5
.turnin 12849 >>交出血、霜和邪恶的力量
step
#completewith next
.goto ScarletEnclave,52.1,35.0
.fly >>点击鹰头狮返回死亡决裂
step
.goto ScarletEnclave,53.4,36.5
>>与瓦拉纳交谈。他已经搬到山边了
.turnin 12714 >>交出巫妖王的意志
.accept 12715 >>接受记忆之墓
step
.goto ScarletEnclave,55.8,52.4
>>在大锅前的田野里与诺思交谈
.accept 12716 >>接受瘟疫使者的请求
step
.goto ScarletEnclave,53.9,58.1,15,0
>>直奔记忆之墓的底部
.turnin 12715 >>交出记忆的墓穴
.accept 12719 >>无处可跑，无处可藏
.goto ScarletEnclave,54.3,57.4
.accept 12722 >>接受羔羊屠宰
.goto ScarletEnclave,54.6,57.4
step
#completewith next
>>杀死新阿瓦隆市民和血腥十字军暴徒。掠夺他们的头骨。稍后您将完成此操作
.complete 12716,3 
.complete 12722,2 
.complete 12722,1 
step
.goto ScarletEnclave,53.1,71.1,20,0
>>进入市政厅，杀死昆比市长。抢劫他旁边桌子上的书
.complete 12719,1 
.goto ScarletEnclave,52.2,71.2
.complete 12719,2 
.goto ScarletEnclave,52.5,71.0
step
.goto ScarletEnclave,53.9,58.1,15,0
>>骑马回到地穴
.turnin 12719 >>无处可跑，无处可藏
.accept 12720 >>接受如何赢得朋友和影响敌人
.goto ScarletEnclave,54.3,57.4
step
#completewith Dawn
>>杀死新阿瓦隆市民和血腥十字军暴徒。抢劫他们的头骨
.complete 12716,3 
.complete 12722,2 
.complete 12722,1 
step
.goto ScarletEnclave,62.0,60.3
>>抢劫铁匠内部墙上的链条
.complete 12716,2 
step
.goto ScarletEnclave,57.8,61.8
>>抢劫客栈地下室的大锅
.complete 12716,1 
step
#completewith next
.use 39418
+打开包里的珠宝盒。在里面装备Keleseth的两个说服者

step
#label Dawn
.goto ScarletEnclave,62.4,68.2
>>装备Keleseth的劝导器，攻击血腥暴徒-继续杀戮他们，直到有人告诉你什么（当目标完成时，他们会变得中立）
.complete 12720,1 
step
#completewith Soldiers
>>掠夺新阿瓦隆的类人头骨
.complete 12716,3 
step
#completewith next
.goto ScarletEnclave,62.7,68.4
>>杀死该地区的血腥十字军士兵
.complete 12722,1 
step
.goto ScarletEnclave,57.8,67.8,30,0
.goto ScarletEnclave,56.9,68.5,30,0
.goto ScarletEnclave,55.5,68.3,30,0
.goto ScarletEnclave,53.9,71.9,30,0
.goto ScarletEnclave,53.0,69.7
>>杀死该地区的新阿瓦隆市民
.complete 12722,2 
step
#label Soldiers
.goto ScarletEnclave,62.7,68.4
>>杀死该地区的血腥十字军士兵
.complete 12722,1 
step
.goto ScarletEnclave,53.0,69.7
>>掠夺新阿瓦隆的类人头骨
.complete 12716,3 
step
>>先和瘟疫使者诺思谈谈，然后再和大酒馆谈谈
.turnin 12716 >>提交瘟疫制造者的请求
.accept 12717 >>接受诺思特酿
.goto ScarletEnclave,55.9,52.4
.turnin 12717 >>加入诺思特酿
.goto ScarletEnclave,56.2,52.0
step
#completewith next
.goto ScarletEnclave,56.2,52.0,0
>>如果你有20多个头骨，再次点击坩埚，了解更多诺思特酿。把它们绑在你的酒吧里
.turnin 12718 >>多交头骨酿酒
step
.goto ScarletEnclave,53.9,58.1,15,0
>>骑回地穴。重新装备你的普通武器
.turnin 12722 >> 把羊羔交给屠夫
.goto ScarletEnclave,54.6,57.5
.turnin 12720 >>交出如何赢得朋友和影响敌人
.accept 12723 >>在红线后面接受
.goto ScarletEnclave,54.2,57.4
step
#completewith next
.destroy 39328 >> 删除包里剩下的十字军头骨
step
>>骑马到房子，然后上楼到二楼
.turnin 12723 >>在红线后面转弯
.accept 12724 >>接受正义十字军的道路
.goto ScarletEnclave,56.3,79.8
.accept 12725 >>接受死亡兄弟
.goto ScarletEnclave,56.3,80.0
step
.goto ScarletEnclave,62.8,68.6,15,0
.goto ScarletEnclave,63.0,68.0
>>跑到思嘉堡的地窖，和科尔蒂拉·戴斯韦弗谈谈。避免在途中与暴徒战斗-如果你死了，让瓦尔基尔复活你（不要释放）
>>开始任务后不要保护科尔蒂拉，它不是护送者
.turnin 12725 >>死里逃生的兄弟
.accept 12727 >>接受血腥突破
step
#completewith next
.goto ScarletEnclave,63.1,68.2,15,0
.goto ScarletEnclave,62.7,68.6,15,0
.goto ScarletEnclave,62.9,68.3
>>不要防守科尔蒂拉，而是去顶楼。抢劫桌上的巡逻时间表
.complete 12724,1 
step
.goto ScarletEnclave,63.0,68.0
>>返回Koltira Deathweaver。杀死瓦尔罗斯。把他的头从地上抢走
>>你可能需要在等待瓦尔罗斯产卵时杀死攻击科尔蒂拉的附加兵力
.complete 12727,1 
step
.goto ScarletEnclave,63.1,68.2,15,0
.goto ScarletEnclave,62.7,68.6,15,0
.goto ScarletEnclave,62.9,68.3
>>去顶层，抢夺桌子上的巡逻时间表
.complete 12724,1 
step
>>返回房屋二楼
.turnin 12724 >>转向正义十字军的道路
.goto ScarletEnclave,56.3,79.8
.turnin 12727 >>交出血腥突围
.accept 12738 >>接受复仇的哭泣！
.goto ScarletEnclave,56.3,80.0
step
.goto ScarletEnclave,52.6,80.7,40,0
.goto ScarletEnclave,53.1,82.1
>>骑马走出房子去教堂。与Plaguefist交谈
.turnin 12738 >>为复仇而哭泣！
.accept 12748 >>接受一个特别的惊喜 << Orc
.accept 12739 >>接受一个特别的惊喜 << Tauren
.accept 12742 >>接受一个特别的惊喜 << Human
.accept 12743 >>接受一个特别的惊喜 << NightElf
.accept 12744 >>接受一个特别的惊喜 << Dwarf
.accept 12745 >>接受一个特别的惊喜 << Gnome
.accept 12746 >>接受一个特别的惊喜 << Draenei
.accept 12747 >>接受一个特别的惊喜 << BloodElf
.accept 12749 >>接受一个特别的惊喜 << Troll
.accept 12750 >>接受一个特别的惊喜 << Undead
step << Orc
.goto ScarletEnclave,53.8,83.4
>>站在库格面前，等待RP结束。之后杀了他
.complete 12748,1 
step << Tauren
.goto ScarletEnclave,54.4,83.4
>>站在马拉面前，等待RP结束。之后杀了他
.complete 12739,1 
step << Human
.goto ScarletEnclave,53.6,83.6
>>站在艾伦面前，等待RP结束。之后杀了他
.complete 12742,1 
step << NightElf
.goto ScarletEnclave,54.2,83.8
>>站在Yazmina面前，等待RP结束。之后杀了她
.complete 12743,1 
step << Dwarf
.goto ScarletEnclave,54.0,83.4
>>站在多诺万面前，等待RP结束。之后杀了他
.complete 12744,1 
step << Gnome
.goto ScarletEnclave,54.0,83.4
>>站在戈比面前，等待RP结束。之后杀了他
.complete 12745,1 
step << Draenei
.goto ScarletEnclave,54.4,83.4
>>站在瓦洛克面前，等待RP结束。之后杀了他
.complete 12746,1 
step << BloodElf
.goto ScarletEnclave,54.2,83.4
>>站在Eonys女士面前，等待RP结束。之后杀了她
.complete 12747,1 
step << Troll
.goto ScarletEnclave,53.8,83.4
>>站在Iggy面前，等待RP结束。之后杀了他
.complete 12749,1 
step << Undead
.goto ScarletEnclave,53.6,83.4
>>站在安托万面前，等待RP结束。之后杀了他
.complete 12750,1 
step
.goto ScarletEnclave,53.1,82.1
>>返回Plaguefist
.turnin 12748 >>交一份特别惊喜 << Orc
.turnin 12739 >>交一份特别惊喜 << Tauren
.turnin 12742 >>交一份特别惊喜 << Human
.turnin 12743 >>交一份特别惊喜 << Nightelf
.turnin 12744 >>交一份特别惊喜 << Dwarf
.turnin 12745 >>交一份特别惊喜 << Gnome
.turnin 12746 >>交一份特别惊喜 << Draenei
.turnin 12747 >>交一份特别惊喜 << Bloodelf
.turnin 12749 >>交一份特别惊喜 << Troll
.turnin 12750 >>交一份特别惊喜 << Undead
.accept 12751 >>接受一种回家的感觉
step
.goto ScarletEnclave,56.3,80.0
>>回到房子的二楼
.turnin 12751 >>交一份返校节
.goto ScarletEnclave,56.3,80.0
.accept 12754 >>俯瞰时接受伏击
.goto ScarletEnclave,56.3,79.8
step
.use 39645 >>使用包中的临时盖。杀死血色信使。
.goto ScarletEnclave,60.0,77.0
.complete 12754,1 
.complete 12754,2 
step
.goto ScarletEnclave,56.3,79.8
>>回到房子的二楼
.turnin 12754 >>俯瞰时埋伏
.accept 12755 >>接受与命运的会面
step
.goto ScarletEnclave,65.6,83.9
>>一路骑行到海滩上的阿本迪斯将军
.turnin 12755 >>与命运会面
.accept 12756 >>接受血腥的出现
step
.goto ScarletEnclave,56.3,79.8
>>回到房子的二楼
.turnin 12756 >>《血腥暴发》上映
.accept 12757 >>接受红军的接近。。。
step
#completewith next
.goto ScarletEnclave,50.0,32.3,20 >> 等待奥巴兹召唤传送门。点击通往阿切鲁斯的门户，返回指挥大厅
step
.goto ScarletEnclave,48.9,29.9
>>返回Darion Mograine
.turnin 12757 >>红军接近。。。
.accept 12778 >>接受《血腥启示录》
step
.goto ScarletEnclave,47.4,26.8
.trainer >> 训练你的职业咒语

step
.goto ScarletEnclave,52.0,35.0
.fly >>点击鹰头狮返回死亡决裂
step
.goto ScarletEnclave,53.5,36.8
>>与俯瞰死亡决裂的巫妖王交谈
.turnin 12778 >>交给《血腥启示录》
.accept 12779 >>接受一切结束。。。
step
#completewith next
.use 39700
.vehicle >> 用霜卵之角爬上冻僵龙
step
>>施放“冰冻死亡箭”（1）造成伤害（不要施放）。使用“吞噬类人”（2）在近战范围内拾取一个血色士兵，恢复生命值和法力值。杀死被血色士兵包围的巴利斯塔
.goto ScarletEnclave,56.0,62.2,100,0
.goto ScarletEnclave,55.4,64.8,100,0
.goto ScarletEnclave,54.8,66.8,100,0
.goto ScarletEnclave,54.6,69.9,100,0
.goto ScarletEnclave,54.4,75.6,100,0
.goto ScarletEnclave,57.0,74.8,100,0
.goto ScarletEnclave,57.3,71.8,100,0
.goto ScarletEnclave,60.0,72.2,100,0
.goto ScarletEnclave,62.6,75.1,100,0
.goto ScarletEnclave,59.5,66.1,100,0
.goto ScarletEnclave,59.5,60.2,100,0
.goto ScarletEnclave,56.0,62.2,100,0
.goto ScarletEnclave,55.4,64.8,100,0
.goto ScarletEnclave,54.8,66.8
.complete 12779,2 
.complete 12779,1 
step
>>飞回巫妖王
.goto ScarletEnclave,53.5,36.8
.turnin 12779 >>结束一切。。。
.accept 12800 >>接受巫妖王的命令
step
.goto ScarletEnclave,49.3,28.7,45,0
.goto ScarletEnclave,47.1,24.1,45,0
.goto ScarletEnclave,34.1,30.4
>> 向北穿过有毒山口。骑马前往布劳曼磨坊，与塔拉诺交谈
.turnin 12800 >>交出巫妖王的命令
.accept 12801 >>接受黎明之光
step
#completewith next
+与大领主达里安·莫格拉涅交谈，开始活动
.skipgossip 29173,2
step
.goto ScarletEnclave,39.0,38.5
>> 等待事件开始（此时您可以休息一下）。完成非常长的战斗和RP
.complete 12801,1 
step
.goto Eastern Plaguelands,39,39
.turnin 12801 >>《黎明之光》
.accept 13165 >>接受取回Acherus
step
#completewith next
.cast 50977 >>使用你的死亡之门法术返回Ebon Hold
step
.goto Eastern Plaguelands,83.4,49.4
>>与Ebon Hold内的Darion Mograine交谈
.turnin 13165 >>交回阿切罗斯
.accept 13166 >>接受Ebon Hold之战
step
#completewith next
.goto ScarletEnclave,50.3,33.1,8 >> 通过门户网站
step
#sticky
#label ScourgeH
>>杀死Ebon Hold主楼内的天灾
.goto ScarletEnclave,48.1,28.4,-1
.complete 13166,2 

step
.goto ScarletEnclave,48.9,29.8
>>在乌木小屋的主楼层中间杀死帕奇沃克
.complete 13166,1 
step
#completewith next
.goto ScarletEnclave,50.5,33.4,10 >>跑进紫色大门
step
#requires ScourgeH
.goto ScarletEnclave,50.7,33.7
>>返回Darion Mograine
.turnin 13166 >>为Ebon Hold交战
.accept 13189 >>接受酋长的祝福
step << Horde
.goto ScarletEnclave,52.1,35.0
.zone Durotar >>把入口带到奥格瑞玛
step << Horde
.goto Orgrimmar,31.9,37.8
.turnin 13189 >>交出酋长的祝福

step << Alliance
.goto ScarletEnclave,50.9,36.3
.zone Elwynn Forest >>将入口带到暴风城
step << Alliance
.goto Stormwind City,80.0,38.5
.turnin 13188 >>在国王步行的地方转弯
]])
RXPGuides.RegisterGuide([[
#version 6
#wotlk
#tbc
#group RestedXP WLK的准备
#name !如何使用本指南
#hidewindow
step
#sticky
+欢迎使用RXP 70-71准备指南！
+从“收藏物品”和“启动准备指南”章节开始，因为它们将为您在启动时提交的所有任务做好准备。完整地完成它们，把它说要交的所有任务交上来。这些是您在开放世界中留下的任务线，而不是您保存在任务日志中的任务！
+接下来，做25个任务日志指南，这些是你在任务日志中留下的任务。建议您完成大约24个任务，而不是全部25个任务，以确保在发布日有足够的空间来完成准备好的任务。在上一步之前不要执行此指南，否则您需要回溯！
+然后查看“当日转弯速度助手”以加快路线转弯速度
+最后，您可以在发布日使用《入住指南》！
+目前，《入住指南》尚未发布，以防止意外使用，请密切关注我们社区的不和谐，以跟上时代的步伐
step << skip
+完成指南后，强烈建议您将角色复制到PTR，并在PTR上对《转入指南》进行测试，以便更好地了解路线！
]])
RXPGuides.RegisterGuide([[
#version 7
#wotlk
#tbc
#group RestedXP WLK的准备
#name 可收藏物品
step
#completewith questdrops
#sticky
+指南的这一章是从开始任务的怪物身上掉落的所有物品。强烈建议您遵循它完成任务，即使这意味着要为精英任务找到一个团队。
step
#sticky
.reputation 1015,friendly >> 与荷兰之翼友好相处。
step
.isQuestAvailable 10804
.goto Shadowmoon Valley,59.4,58.6
>> 这个任务线会让你和荷兰之翼很友好，这会给你很多潜在的经验。
* 任务给予者可能正在与岩石钉子战斗，甚至会被他们杀死，你可能需要等待他重生。
.accept 10804 >> 接受仁慈
step
.isOnQuest 10804
.goto Shadowmoon Valley,62.4,58.6
.use 31372 >> 杀死并掠夺该地区的Rocknail Flayers以获取他们的尸体。然后把它们的尸体放在地上喂给荷兰龙。
*Make sure to travel a bit when laying the meat, as the same drakes won't eat twice in a row
.complete 10804,1 
step
.isOnQuest 10804
.goto Shadowmoon Valley,59.4,58.6
>> 任务给予者可能正在与岩石钉子战斗，甚至会被他们杀死，你可能需要等待他重生。
.turnin 10804 >> 交出善良
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,59.4,58.6
.accept 10811 >> 接受寻找Neltharaku。
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,61.8,60.0,80,0
.goto Shadowmoon Valley,66.2,60.4,80,0
.goto Shadowmoon Valley,61.8,60.0
>> 她是一条幽灵般的巨龙，在荷兰飞翔，可能需要四处寻找她。
.unitscan Neltharaku
.turnin 10811 >> 转入寻找Neltharaku
.accept 10814 >> 接受内特哈拉库的故事
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,61.8,60.0
.skipgossip
>> 与Neltharaku交谈
.turnin 10814 >> 交出奈特哈拉库的故事
.accept 10836 >> 接受渗透的龙嘴要塞
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,66.0,60.0
>> 杀死该地区所有的龙嘴兽，除了人以外，其他人都会加入任务
.complete 10836,1 
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,61.8,60.0
>> 再次在天空中找到奈特哈拉库，希望离你上次看到她的地方很近
.unitscan Neltharaku
.turnin 10836 >> 转入渗透龙嘴要塞
.accept 10837 >> 接受荷兰之翼！
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,66.0,80.0,60,0
.goto Shadowmoon Valley,66.3,82.3,30,0
.goto Shadowmoon Valley,67.3,81.7,30,0
.goto Shadowmoon Valley,68.3,79.8,30,0
.goto Shadowmoon Valley,71.7,83.1,30,0
.goto Shadowmoon Valley,76.7,83.3,60,0
.goto Shadowmoon Valley,66.0,80.0
>> 抢劫该地区的荷兰水晶。“寻找矿物”可以追踪它们，尽管它们看起来像植物。
.complete 10837,1 
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,61.8,60.0
.unitscan Neltharaku
>> 找到尼特哈拉库在尼日翼原野上空飞行
.turnin 10837 >> 交给荷兰队！
.accept 10854 >> 接受内尔塔拉库的力量
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,71.0,64.0 
.use 31652 >> 在被奴役的龙兽身上使用水晶。不要站得太近，否则他们会攻击你而不是兽人。
*The drakes are very weak and will charge nearby orcs after freeing them, be quick to help them in combat or they will die.
.complete 10854,1 
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,61.8,60.0
.unitscan Neltharaku
>> 找到尼特哈拉库在尼日翼原野上空飞行
.turnin 10854 >> 内尔塔拉库的力量
.accept 10858 >> 接受Karynaku
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,69.8,61.4
>> 在要塞的二楼找到Karynaku
.unitscan Karynaku
.turnin 10858 >> 转入Karynaku
.accept 10872 >> 接受Zuluhed the Whacked
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,71.0,62.2
>> 这是一个精英任务，你可能需要帮助。杀死祖鲁希德，抢夺他的钥匙。
.complete 10872,2
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,69.8,61.4
.use 31664 >> 用Karynaku锁链上的钥匙来释放她。
.complete 10872,1
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,69.8,61.4
.turnin 10872 >> 交给被打的祖鲁希德
.accept 10871 >> 接受荷兰联军
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,59.4,58.6
>> 任务给予者可能正在与岩石钉子战斗，甚至会被他们杀死，你可能需要等待他重生。
.turnin 10871 >> 交出荷兰联军
.accept 11012 >> 接受下翼的血腥誓言
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,59.4,58.6
.turnin 11012 >> 交出下翼的血腥誓言
.accept 11013 >> 接受伊利达里人的服务
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,66.2,85.6
.turnin 11013 >> 为伊利达里人服务
.accept 11014 >> 接受进入Taskmaster
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,66.0,86.4
.turnin 11014 >> 上车进入Taskmaster
step
.isQuestAvailable 11041
.goto Shadowmoon Valley,73.4,86.0
>> 杀死贪婪的阿沃尔并抢劫他。他是精英，你可能需要一个团队。
* Note, sometimes only one person per kill can loot the item, you may need to kill him multiple times.
.unitscan Arvoar the Rapacious
.collect 32621,1,11041,1
step
.isQuestAvailable 11041
.goto Shadowmoon Valley,73.4,86.0
.use 32621 >> 使用包中的部分消化手接受任务
.accept 11041 >> 接受未完成的工作
step
.isOnQuest 11041
.goto Shadowmoon Valley,70.4,84.6
>> 杀死该地区的Overmine Flayers和Den Mother Barash
.unitscan Barash the Den Mother
.complete 11041,1
.complete 11041,2
step
.isOnQuest 11041
.goto Shadowmoon Valley,66.2,85.6
.turnin 11041 >> 提交未完成的工作
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,66.0,86.4
.accept 11019 >> 从内部接受你的朋友
.turnin 11019 >> 从内部交出你的朋友
step
.goto Shadowmoon Valley,66.0,86.4
.reputation 1015,friendly >> 通过做日报与荷兰派保持友好关系。不要提交任何一次任务，如羽翼蛋或上升，监督！
.accept 11020 >> 接受缓慢死亡
.accept 11015 >> 接受荷兰水晶
.accept 11035 >> 接受不那么友好的天空。。。
>> 这三个任务需要采集职业，每天只能完成一个。
.accept 11018 >> 接受菱铁矿
.accept 11017 >> 接受荷兰花粉
.accept 11016 >> 接受Nethermin Flayer Hide
step
.goto Shadowmoon Valley,63.0,87.8
>> 从矿井中德雷纳的黑血中收集25个污泥覆盖物
*Note: You can copy your character onto the PTR, turn in "Rise, Overseer!" and "The Netherwing Mines" on the PTR then start opening them until you find one that has Murkblood Escape Plans. You can delete the rest, as that same one will have it on live servers.
.collect 32724,25,11081,1
step
.goto Shadowmoon Valley,53.0,62.4,60,0
.goto Shadowmoon Valley,52.7,68.6,60,0
.goto Shadowmoon Valley,51.6,63.8,60,0
.goto Shadowmoon Valley,52.3,59.1,60,0
.goto Shadowmoon Valley,53.0,62.4
.unitscan Val'zareq the Conqueror
>> 去杀了征服者瓦尔扎雷。这是一个精英任务，你可能需要分组。
.collect 31345,1,10793,1 >> 获取Vel'zareq杂志
step << Horde
.goto Shadowmoon Valley,67.6,36.6
>> 杀死Smith Gorlunk并抢劫他
.unitscan Smith Gorlunk
.collect 31241,1,10755,1
step << Alliance
>> 杀死Smith Gorlunk并抢劫他
.unitscan Smith Gorlunk
.goto Shadowmoon Valley,67.6,36.6
.collect 31239,1,10754,1
step
.requires quest,11370
.goto Shattrath City,75.0,36.4
.daily 11369,11384,11382,11363,11362,11375,11354,11386,11373,11378,11374,11372,11368,11388,11370 >> 每天接受英雄副本
step
.requires quest,11387
.goto Shattrath City,75.4,37.6
.daily 11389,11371,11376,11383,11364,11385,11387 >> 每天接受副本
step
.goto Terokkar Forest,69.6,78.6
>> 杀死并抢劫塔龙牧师伊沙尔。如果你还没有完成暗影世界的任务，你需要找到一个已经完成任务的人，和他们一起组队，如果没有任务中的长生不老药，他是看不见的。
>> 他们可以为你杀死塔龙牧师，你可以为《华尔街日报》抢劫他。不要完成阴影世界来完成这个任务，阴影世界在发布日更有经验。
>> 如果找不到人，请跳过此步骤。
.unitscan Talonpriest Ishaal
.collect 32523,1,11021,1
step
.goto Terokkar Forest,41.2,56.8
>> 杀死并掠夺该地区的阴谋集团敌人，直到你获得任务物品
.collect 31707,1,10880,1
step
.goto Hellfire Peninsula,25.6,76.6
.unitscan Avruu
>> 杀死并掠夺Avruu
.collect 23580,1,9418,1
step << Horde
.goto Hellfire Peninsula,65.6,30.0
>> 杀死并抢劫剃须刀
.collect 29590,1,10393,1
step << Alliance
.goto Hellfire Peninsula,53.1,26.7
>> 杀戮和掠夺战争使者阿里克斯·阿马尔
.collect 29588,1,10395,1
step
.goto Hellfire Peninsula,48.6,39.6
>> 杀死并掠夺掠夺地壳爆破器，直到你获得任务物品
* You will need to run over the "Earthquakes" on the ground to spawn the enemies
.collect 23338,1,9373,1
step
.goto Hellfire Peninsula,17.8,40.6
>> 杀死并抢劫愤怒的巨像
.collect 29476,1,10134,1
step << Alliance
.goto Zangarmarsh,80.2,41.0
>> 杀死并掠夺枯萎巨人，直到你获得任务物品。
* Save the Bog Lord Tendrils if you need Sporeggar rep
.collect 24483,1,9827,1
step << Horde
.goto Zangarmarsh,80.2,41.0
>> 杀死并掠夺枯萎巨人，直到你获得任务物品。
* Save the Bog Lord Tendrils if you need Sporeggar rep
.collect 24484,1,9828,1
step << skip
.goto Zangarmarsh,62.2,40.6
>> 杀死并抢劫该地区的蒸汽泵监督人员和其他管理人员，直到你得到排水示意图
.collect 24330,1,9731,1
step
.goto Nagrand,73.6,59.2,40,0
.goto Nagrand,69.8,52.8,40,0
.goto Nagrand,72.8,44.6,40,0
.goto Nagrand,65.8,38.2,0
>> 杀死并掠夺该地区的闪电元素，尘啸者拥有最好的下降率。
.collect 24504,1,9861,1
step << Alliance
.goto Nagrand,48.6,34.4,40,0
.goto Nagrand,43.0,31.6,40,0
.goto Nagrand,41.0,27.0,40,0
.goto Nagrand,35.8,26.0,40,0
.goto Nagrand,34.0,20.4,0
>> 杀死并掠夺黑血侵略者，他们四处巡逻，所以你可能需要多圈。
.collect 24559,1,9871,1
.unitscan Murkblood Invader
step << Horde
.goto Nagrand,48.6,34.4,40,0
.goto Nagrand,43.0,31.6,40,0
.goto Nagrand,41.0,27.0,40,0
.goto Nagrand,35.8,26.0,40,0
.goto Nagrand,34.0,20.4,0
>> 杀死并掠夺黑血侵略者，他们四处巡逻，所以你可能需要多圈。
.collect 24558,1,9872,1
.unitscan Murkblood Invader
step
.goto Zangarmarsh,32.9,59.6
>> 杀死并抢劫“安古拉伯爵”
.collect 25459,1,9911,1
.unitscan "Count" Ungula
step
.goto Blade's Edge Mountains,75.8,23.6,40,0
.goto Blade's Edge Mountains,71.6,33.6,40,0
.goto Blade's Edge Mountains,70.6,44.8,0
>> 杀死并抢劫一名邪恶的腐败者
.collect 31384,1,10810,1
.unitscan Fel Corrupter
step
.goto Blade's Edge Mountains,41.6,21.4
>> 杀死并抢劫该地区的Grishna暴徒
.collect 31489,1,10825,1
step
.goto Netherstorm,59.8,86.8
>> 杀死并抢劫科利安·弗罗斯特韦弗
.collect 29236,1,10307,1
.unitscan Cohlien Frostweaver
step
.goto Netherstorm,60.0,85.2
>> 杀死并掠夺魔法师Luminrath
.collect 29235,1,10306,1
.unitscan Conjurer Luminrath
step
.goto Netherstorm,60.6,87.6
>> 杀戮和掠夺战斗法师Dathric
.collect 29233,1,10182,1
.unitscan Battle-Mage Dathric
step
.goto Netherstorm,59.0,88.2
>> 杀死并抢劫Abjurit Belmara
.collect 29234,1,10305,1
.unitscan Abjurist Belmara
step
.goto Netherstorm,55.0,43.4
>> 杀死凝固的虚空恐怖并掠夺他。这是精英，你可能需要分组。这个暴徒有30分钟的重生时间。
.collect 29738,1,10413,1
.unitscan Congealed Void Horror
step << Horde
>> 杀死地狱火堡垒的最后一个老板。
.collect 23892,1,9588,1
step << Alliance
>> 杀死地狱火堡垒的最后一个老板。
.collect 23890,1,9587,1
step
>> 杀死蒸汽堡的暴徒，直到瓦什女士的命令下达为止
.collect 24367,1,9764,1 >> 从Vashj女士那里获得订单
step
#sticky
#label questdrops
#completewith BOEitems
+这些任务是从奇袭中获得的，如果可以的话，请将其获取，否则请跳过本章
step << Alliance
>> 从马瑟里登的巢穴里找到马瑟里顿头
.collect 32385,1,11002,1
step << Horde
>> 从马瑟里登的巢穴里找到马瑟里顿头
.collect 32386,1,11003,1
step
>> 从风暴要塞获得凯尔萨斯和苍翠球体。
.collect 32405,1,11007,1
step
>> 从祖勒曼那里获得军阀之血。这个任务需要一个召唤到幽灵之地的召唤是一个有效的回合，如果你在发射日无法进入，请跳过。
.collect 33102,1,11178,1
step
#sticky
#completewith BOPitemslist
#label BOEitems
+本章是所有可以在拍卖行购买的物品，将是免费送货任务。购买时请核对。
step << Horde
.collect 31670,3,10860,1
.collect 31671,3,10860,1
step
.collect 24368,1,9765,1 
step

.collect 23445,4,10763,1
.collect 22445,2,10763,1
.collect 22574,4,10763,1
step
.collect 24449,6,9806,1 
step
.collect 24246,5,9715,1 
step
.reputation 970,friendly,0,1
.collect 24245,10,9808,1 
step
#aldor
.collect 25744,8,10024,1 
step
#aldor
.collect 29740,1,10420,1 
step
#aldor
.collect 30809,10,10653,1 
step << Alliance
.goto Blasted Lands,63.5,17.0
>>前往尼德加德禁猎区（Blasted lands）。到马厩里去买一杯Nethergard Bitter
.collect 23848,1,9563,1 
step
#aldor
.collect 29425,10,10325,1 
step
#scryer
.collect 30810,10,10656,1 
step
#scryer
.collect 29426,10,10412,1 
step
#scryer
.collect 29739,1,10416,1 
step
.collect 25719,30,10917,1 
step
.collect 32388,6,11004,1 
step
>> 这项任务要求您与联盟保持中立，我们将在稍后的指南中将我们的代表减少为中立。如果您不想这样做，请跳过此步骤。
.collect 25463,27,9914,1 
step
>> 这项任务要求您与联盟保持中立，我们将在稍后的指南中将我们的代表减少为中立。如果您不想这样做，请跳过此步骤。
.collect 25416,10,9882,1 
step
.collect 32601,1,11061,1 
step
.collect 32598,1,11030,1 
step
.collect 32464,40
.skill mining,<350,1 >> 如果你有两种采集职业，那么你每天只能提交一次荷兰之翼采集，请跳过下一步购买
step
.collect 32468,40
.skill herbalism,<350,1 >> 如果你有两种采集职业，那么你每天只能提交一次荷兰之翼采集，请跳过下一步购买
step
.collect 32470,35
.skill skinning,<350,1
step
#completewith BOEitems
.collect 24401,10,9802,1 
step
#sticky
#label BOPitemslist
#completewith BOPitems
+这些道具是BOP道具，需要在你的角色身上种植，以获得自由周转。
step

>>为战珠杀死纳格兰的食人魔
.collect 25433,20,9893,1 
step << Alliance
.goto Nagrand,75.0,65.0
>> 在纳格兰碾碎任何暴徒，获得奥舒贡水晶粉。请注意，它是唯一的，最多100个，包括您银行中的任何一个
.collect 26043,20,10076,1
step << Horde
#label BOPitems
.goto Nagrand,75.0,65.0
>> 在你选择的纳格兰地区研磨任何暴徒，获得奥舒贡水晶粉。请注意，它是唯一的，最多100个，包括您银行中的任何一个。
.collect 26042,20,10074,1
step
.goto Blade's Edge Mountains,30.2,75.2

>>杀死奥格里拉周围的暴徒
.collect 32569,5 
step
.goto Netherstorm,30.6,75.2
>> 在暴风雨中杀死并掠夺扎克西斯袭击者和跟踪者
.collect 29209,10,10262,1 
step
.goto Shadowmoon Valley,69.0,85.0
>> 杀死该地区的暴徒，并将其掠夺为荷兰之翼水晶
.collect 32427,30,11015,1 
step
.goto Shadowmoon Valley,69.0,85.0
.reputation 1015,friendly,<0,1
>> 可以通过在该地区放牧、采矿、杀死怪物或在世界上找到怪物来找到。它们看起来像巨大的发光柱，类似于荷兰风暴中的天岭上的蛋。
.collect 32506,1,11049,1 
step << Alliance
.goto Blade's Edge Mountains,46.8,78.6,30,0
.goto Blade's Edge Mountains,43.2,80.4
>> 从地上的酿酒师或桶中收集11瓶布鲁特班血腥酒。
.collect 29443,11,10511,1
]])
RXPGuides.RegisterGuide([[
#version 7
#wotlk
#tbc
#group RestedXP WLK的准备
#name 25 任务日志指南
step
#sticky
+本指南将在您的任务日志中为您提供25个任务以供启动。在准备好所有其他向导后，准备最后10个任务。
+ 有些任务可能看起来不正常，如果每个人都有不同的任务，那么不可能100%高效地完成任务。很抱歉，如果你必须加倍努力！
step
.requires quest,10667
>> 去拍卖行买这些东西
.collect 23784,1,10664,1
.collect 23793,4,10664,1
step
.requires quest,9837
.goto Shattrath City,54.6,44.2
.accept 9836 >> 接受主人的抚摸

step
.requires quest,10297
.goto Tanaris,66.0,49.6
>> 当你接受任务时，确保你站着不动，下车，以便飞下时间之穴。如果你没有成功，放弃并重新接受任务。
.skipgossip
.accept 10279 >> 接受主人的巢穴
step
.requires quest,10297
.goto Tanaris,58.4,54.2
.turnin 10279 >> 投奔主人的巢穴
.accept 10277 >> 接受时间的洞穴
step
.requires quest,10297
.goto Tanaris,58.4,54.2
.timer 540,Wait for the Custodian to show you around the Caverns of Time
>> 只需在任务给予者处等待，您仍将获得积分。这个角色扮演需要9分钟，休息一下。
.complete 10277,1
step
.requires quest,10297
.goto Tanaris,58.4,54.2
.turnin 10277 >> 时间的洞穴
step
.requires quest,10445
.goto Tanaris,59.6,54.2
.accept 10445 >> 接受永恒的瓶子
step
.requires quest,10297
.goto Tanaris,58.4,54.2
.accept 10282 >> 接受旧Hillsbrad
step
.requires quest,10297
>> 去旧希尔斯布拉德地牢。
.turnin 10282 >> 转入Old Hillsbrad
.accept 10283 >> 接受塔雷莎的转移
step
.requires quest,10297
+纵火焚烧建筑物。
complete 10283,1
step
.requires quest,10297
>> 在地下室找到萨尔。
.turnin 10283 >> 塔雷莎的改道
.accept 10284 >> 接受逃离Durnholde
step
.requires quest,10297
>> 当地牢完成后，在任务中回合。
.turnin 10284 >> 转入逃离Durnholde。
.accept 10285 >> 接受返回Andormu
step
.requires quest,10297
.goto Tanaris,58.4,54.2
.turnin 10285 >> 返回安多尔姆
.accept 10296 >> 接受黑色沼泽
step
.requires quest,10297
>> 进入黑沼泽并完成任务。
.turnin 10296 >> 《黑色沼泽》
.accept 10297 >> 接受黑暗之门的开启
step
.requires quest,10297
>> 完成黑暗之门的开启，但不要完成任务。
.complete 10297,1
step
.requires quest,9837
>> 前往黑沼泽并完成地牢，然后返回任务
.turnin 9836 >> 交给大师
.accept 9837 >> 接受返回卡德加。这个任务不要交。
step
.requires quest,10445
>> 去杀死SSC的瓦什女士。
.complete 10445,1
step
.requires quest,10445
>> 去暴风雨要塞杀了凯尔萨斯阳光行者。
.complete 10445,2

step
.requires quest,9831
.zone Deadwind Pass >> 前往卡拉赞
step
.requires quest,9831
.goto Deadwind Pass,47.0,75.7
>>与大法师阿尔图鲁斯交谈，他将开启调谐链。
.accept 9824 >>接受奥术干扰
.accept 9825 >>接受不安分活动
step
#completewith wellr
.requires quest,9831
.goto Deadwind Pass,48.6,78.7
+沿着地下室的入口往下走，朝鬼魂走去
step
#sticky
#completewith PondR
.requires quest,9831
>>杀死幽灵。掠夺他们的鬼魂精华
.complete 9825,1 
step
#label wellr
.requires quest,9831
.goto Deadwind Pass,54.7,81.8,30,0
.goto Deadwind Pass,53.3,90.2
.use 24474 >>在地窖尽头的井里使用库存中的紫罗兰水晶
* This quest is underground in the cellar, make sure you're below ground when following the arrow.
.complete 9824,1 
step
#completewith next
.requires quest,9831
.goto Deadwind Pass,48.6,78.1
+沿着另一个地窖的入口走
step
#label PondR
.requires quest,9831
.goto Deadwind Pass,47.0,74.2,30,0
.goto Deadwind Pass,44.5,74.0,20,0
.goto Deadwind Pass,42.8,78.1
.use 24474 >>在水中使用库存中的紫罗兰水晶
.complete 9824,2 
step
.requires quest,9831
.goto Deadwind Pass,43.4,71.2,20,0
.goto Deadwind Pass,45.6,71.6,40,0
.goto Deadwind Pass,41.3,70.0,40,0
.goto Deadwind Pass,41.5,63.0,40,0
.goto Deadwind Pass,41.7,76.8,40,0
.goto Deadwind Pass,46.8,75.1,40,0
.goto Deadwind Pass,43.4,71.2,20,0
.goto Deadwind Pass,45.6,71.6,40,0
.goto Deadwind Pass,41.3,70.0,40,0
.goto Deadwind Pass,41.5,63.0,40,0
.goto Deadwind Pass,41.7,76.8,40,0
.goto Deadwind Pass,46.8,75.1,40,0
.goto Deadwind Pass,43.4,71.2,20,0
.goto Deadwind Pass,45.6,71.6,40,0
.goto Deadwind Pass,41.3,70.0,40,0
.goto Deadwind Pass,41.5,63.0,40,0
.goto Deadwind Pass,41.7,76.8,40,0
.goto Deadwind Pass,46.8,75.1,40,0
>>完成对鬼魂的掠夺，获取精华。如果你愿意的话，把你的队伍分成几个小组，回到另一个地窖去产卵
.complete 9825,1 
step
.requires quest,9831
.goto Deadwind Pass,47.0,75.6
>> 离开地窖
.turnin 9825 >>转入不安分活动
.turnin 9824 >>转入奥术干扰
.accept 9826 >>接受Dalaran的联系
step << Alliance
#completewith next
.requires quest,9831
>>骑马返回Darkhire << !Mage
>> 创建通往铁炉堡的门户 << Mage
.goto Duskwood,77.5,44.3
.fly Southshore >>飞往南岸
step << Horde
#completewith next
.requires quest,9831
>> 骑马返回斯托纳德 << !Mage
>> 创建通往幽暗城的门户 << Mage
.goto Swamp of Sorrows,46.0,54.7
.fly Tarren Mill >>飞往塔伦磨坊
step
.requires quest,9831
>>骑马前往达拉然郊外，与大法师塞德里克交谈。
.goto Alterac Mountains,15.6,54.6
.turnin 9826 >>交给达拉然联系人
.accept 9829 >>接受卡德加
step
.zone Shattrath City >> 前往沙塔斯城
.goto Shattrath City,54.7,44.4
step
.requires quest,9831
.goto Shattrath City,54.7,44.4
>> 乘车前往市中心。
.turnin 9829 >>转入卡德加
.accept 9831 >>接受进入Karazhan
step
#aldor
.requires quest,11492
.goto Shattrath City,30.6,34.4
.accept 11481 >> 在太阳井接受危机
step
#scryer
.requires quest,11492
.goto Shattrath City,54.4,80.8
.accept 11482 >> 接受值班电话
step << skip
.requires quest,11000
.goto Shattrath City,56.4,49.0
.accept 10984 >> 接受与食人魔对话
step << skip
.requires quest,11000
.goto Shattrath City,65.2,68.0
.turnin 10984 >> 转身与食人魔交谈
.accept 10983 >> 接受Mog'dorg the Wizened
step
.requires quest,11000
.goto Shattrath City,65.2,68.0
.accept 10983 >> 接受Mog'dorg the Wizened
step
.requires quest,10095
.goto Shattrath City,50.4,45.4
.accept 10177 >> 接受Auchindoun的麻烦
step
.requires quest,11514
.goto Shattrath City,49.2,42.6
.accept 11514 >> 接受维护Sunwell门户
step
.requires quest,11877
.goto Shattrath City,62.7,36.2
.accept 11877 >> 接受太阳怒攻击计划
step << Alliance
.goto Shattrath City,67.2,34.0
.daily 11337,11336,11335,11338 >> 接受PvP Daily
step << Horde
.goto Shattrath City,67.0,56.6
.daily 11341,11340,11339,11342 >> 接受PvP Daily
step
.requires quest,10667
>> 去沙塔斯买一个恶魔守卫图腾。
.goto Shattrath City,64.6,70.6
.collect 30823,1,10664,1

step << Alliance
.requires quest,10667
.goto Shadowmoon Valley,23.6,34.4
.collect 30756,1,10621,1 >> 杀死监督者Ripsaw
step << Horde
.requires quest,10667
.goto Shadowmoon Valley,23.6,34.4
.collect 30579,1,10623,1 >> 杀死监督者Ripsaw
step << Alliance
.requires quest,10667
.goto Shadowmoon Valley,36.8,54.8
.use 30576
.turnin 10621 >> 交出伊利达里诅咒碎片
.accept 10626 >> 接受捕获武器
step << Horde
.requires quest,10667
.use 30579
.goto Shadowmoon Valley,29.8,31.2
.turnin 10623 >> 交出伊利达里诅咒碎片
.accept 10627 >> 接受捕获武器
step << Alliance
.requires quest,10667
.goto Shadowmoon Valley,24.0,33.8
>> 杀死Makazradon
.unitscan Makazradon
.complete 10626,1
step << Alliance
.requires quest,10667
.goto Shadowmoon Valley,23.6,38.2
>> 杀死Morgroron
.unitscan Morgroron
.complete 10626,2
step << Horde
.requires quest,10667
.goto Shadowmoon Valley,24.0,33.8
>> 杀死Makazradon
.unitscan Makazradon
.complete 10627,1
step << Horde
.requires quest,10667
.goto Shadowmoon Valley,23.6,38.2
>> 杀死Morgroron
.unitscan Morgroron
.complete 10627,2
step << Alliance
.requires quest,10667
.goto Shadowmoon Valley,36.8,54.8
.turnin 10626 >> 上缴缴获武器
.accept 10662 >> 接受Hermit Smith
step << Horde
.requires quest,10667
.goto Shadowmoon Valley,29.8,31.2
.turnin 10627 >> 上缴缴获武器
.accept 10663 >> 接受Hermit Smith
step
#aldor
.requires quest,10649
.goto Shadowmoon Valley,61.2,29.2
.accept 10587 >> 接受Karabor训练场
step
#aldor
.requires quest,10649
.goto Shadowmoon Valley,70.4,49.0
>> 杀死该地区的血精灵恶魔猎人，直到任务完成。
.complete 10587,1
step
#aldor
.requires quest,10649
.goto Shadowmoon Valley,61.2,29.2
.turnin 10587 >> 移交卡拉博训练场
.accept 10637 >> 接受必要的分心
step
#aldor
.requires quest,10649
.goto Shadowmoon Valley,69.0,51.0
.use 30811 >> 将阿扎洛斯从驱逐他的术士手中解救出来。
.complete 10637,1
step
#aldor
.requires quest,10649
.goto Shadowmoon Valley,61.2,29.2
.turnin 10637 >> 都灵处于必要的分心状态
.accept 10640 >> 接受利他
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,62.6,28.4
.accept 10568 >> 接受Baa'ri平板电脑
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,59.8,35.6
.complete 10568,1
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,62.6,28.4
.turnin 10568 >> 上交Baa'ri药片
.accept 10571 >> 接受奥罗努长老
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,57.2,32.6
.complete 10571,1
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,62.6,28.4
.turnin 10571 >> 交给奥罗努长老
.accept 10574 >> 接受Ashlange腐败者
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,49.8,23.0
.complete 10574,3
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,48.2,39.4
.complete 10574,4
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,51.0,52.4
.complete 10574,1
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,57.0,73.4
.complete 10574,2
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,62.6,28.4
.turnin 10574 >> 交出Ashlange腐败者
.accept 10575 >> 收下监狱长的笼子
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,56.2,59.6
.accept 10683 >> 接受Baa'ri平板电脑
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,59.8,35.6
.complete 10683,1
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,56.2,59.6
.turnin 10683 >> 上交Baa'ri药片
.accept 10684 >> 接受奥罗努长老
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,57.2,32.6
.complete 10684,1
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,56.2,59.6
.turnin 10684 >> 交给奥罗努长老
.accept 10685 >> 接受Ashlange腐败者
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,57.0,73.4
.complete 10685,2
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,51.0,52.4
.complete 10685,1
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,48.2,39.4
.complete 10685,4
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,49.8,23.0
.complete 10685,3
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,56.2,59.6
.turnin 10685 >> 交出Ashlange腐败者
.accept 10686 >> 收下监狱长的笼子
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,57.2,49.6
.turnin 10575 >> 交出监狱长的笼子
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,57.2,49.6
.turnin 10686 >> 交出监狱长的笼子
step
.requires quest,10707
.goto Shadowmoon Valley,57.2,49.6
.accept 10622 >> 接受效忠证明
step
.requires quest,10707
>> 杀死赞德拉，他在守卫墙的顶端。
.goto Shadowmoon Valley,58.0,48.8
.complete 10622,1
step
.requires quest,10707
.goto Shadowmoon Valley,57.2,49.6
.turnin 10622 >> 提交效忠证明
.accept 10628 >> 接受Akama
step
.requires quest,10707
.goto Shadowmoon Valley,58.0,48.2
>> 去和阿卡玛谈谈。他在楼下，潜到水下，在另一个隧道里上来。
.skipgossip
.turnin 10628 >> 交给Akaama
.accept 10705 >> 接受Seer Udalo
step
.requires quest,10707
>> 进入Arcatraz并完成任务。
.turnin 10705 >> 交给Seer Udalo
.accept 10706 >> 接受神秘的部分
step
.requires quest,10707
.goto Shadowmoon Valley,58.0,48.2
.turnin 10706 >> 交出神秘的部分
.accept 10707 >> 接受Ata'mal Terrace
step
.requires quest,10707
.goto Shadowmoon Valley,71.4,35.4
>> 找一个小组，得到愤怒之心。这个任务不要交。
.complete 10707,1
step
#scryer
.requires quest,10649
.goto Shadowmoon Valley,55.8,58.2
.accept 10687 >> 接受Karabor训练场
step
#scryer
.requires quest,10649
.goto Shadowmoon Valley,70.4,49.0
>> 杀死血精灵直到任务完成。
.complete 10687,1
step
#scryer
.requires quest,10649
.goto Shadowmoon Valley,55.8,58.2
.turnin 10687 >> 移交卡拉博训练场
.accept 10688 >> 接受必要的分心
step
#scryer
.requires quest,10649
.goto Shadowmoon Valley,69.0,51.0
.use 30811 >> 将阿扎洛斯从驱逐他的术士手中解救出来。
.complete 10688,1
step
#scryer
.requires quest,10649
.goto Shadowmoon Valley,55.8,58.2
.turnin 10688 >> 都灵处于必要的分心状态
.accept 10689 >> 接受利他
step
#aldor
.requires quest,10649
.goto Nagrand,27.4,43.0
.turnin 10640 >> 交出利他鲁
step
#scryer
.requires quest,10649
.goto Nagrand,27.4,43.0
.turnin 10689 >> 交出利他鲁
step
.requires quest,10649
.goto Nagrand,27.4,43.0
.accept 10641 >> 接受反对军团
.accept	10668 >> 接受对伊利达里的挑战
.accept 10669 >> 万无一失地接受
step
.requires quest,10649
.goto Zangarmarsh,16.4,40.4
.use 30853 >> 使用Imbued银矛召唤并杀死Xeleth
.complete 10669,1
step
.requires quest,10649
.goto Shadowmoon Valley,28.6,50.6
>> 杀死Lothros
.complete 10668,1
step
#sticky
.requires quest,10649
#completewith next
.collect 30850,1,10641,1 >> 杀死愤怒的女祭司
step
.goto Netherstorm,41.8,22.2
.requires quest,10649
.use 30850 >> 使用鲜血召唤萨塔尔阿凡达并杀死她。
.complete 10641,1 step
step
.requires quest,10649
.goto Nagrand,27.4,43.0
.turnin 10641 >> 向军团投降
.turnin	10668 >> 向伊利达里人投降
.turnin 10669 >> 逆境自首
step
.requires quest,10649
.goto Nagrand,27.4,43.0
.skipgossip
.accept 10646 >> 接受伊利丹的学生
step
.requires quest,10649
.goto Nagrand,27.4,43.0
.skipgossip
>> 听利特鲁斯的故事
.turnin 10646 >> 交出伊利丹的学生
step
.requires quest,10649
.goto Nagrand,27.4,43.0
.accept 10649 >> 接受恶魔之书

step
.requires quest,10091
.goto Terokkar Forest,39.8,72.2
.accept 10178 >> 接受查找间谍To'gun
step << Horde
.requires quest,11506
.goto Terokkar Forest,49.8,46.6
.accept 11506 >> 接受Auchindoun的精神
step << Horde
.requires quest,11506
.goto Terokkar Forest,32.4,57.8,40,0
.goto Terokkar Forest,42.5,53.9,40,0
.goto Terokkar Forest,48.9,60.5,40,0
.goto Terokkar Forest,47.3,72.3,40,0
.goto Terokkar Forest,40.5,78.1,40,0
.complete 11506,1
step << Alliance
.requires quest,11505
.goto Terokkar Forest,55.8,53.8
.accept 11505 >> 接受Auchindoun的精神
step << Alliance
.requires quest,11505
.goto Terokkar Forest,32.4,57.8,40,0
.goto Terokkar Forest,42.5,53.9,40,0
.goto Terokkar Forest,48.9,60.5,40,0
.goto Terokkar Forest,47.3,72.3,40,0
.goto Terokkar Forest,40.5,78.1,40,0
.complete 11505,1
step
.requires quest,10164
.goto Terokkar Forest,35.0,65.2
.accept 10164 >> 接受一切都会好起来的
step
.requires quest,10667
.goto Terokkar Forest,77.6,38.6
.turnin 10663 >> 交给Hermit Smith << Horde
.turnin 10662 >> 交给Hermit Smith << Alliance
step
.requires quest,10667
.goto Terokkar Forest,77.6,38.6
.accept 10664 >> 接受其他材料
step
.requires quest,10667
.goto Terokkar Forest,77.6,38.6
.turnin 10664 >> 提交附加材料
.accept 10665 >> 接受来自Mechanar的新鲜食物
.accept 10666 >> 接受词典恶魔
step
.requires quest,10091
.goto Terokkar Forest,39.8,72.2
>> 进入阴影迷宫，找到间谍托根。他在走廊尽头的第二个房间里。
.turnin 10178 >> 上交找到间谍To'gun
.accept 10091 >> 接受灵魂设备
step
>> 去暗影迷宫干掉第三个老板，大师沃皮尔。然后抢劫他以完成任务。
.complete 10666,1
step
>> 去做Mechanar并抢劫守门人铁手附近的粉色盒子来完成任务。
.complete 10665,1
step
.requires quest,10667
.goto Terokkar Forest,77.6,38.6
.turnin 10665 >> 从Mechanar新鲜上车
.turnin 10666 >> 交上《恶魔词典》
.accept 10670 >> 接受地球母亲的眼泪
.accept 10667 >> 接受地下壤土
step
.requires quest,10095
.goto Terokkar Forest,40.0,72.2
>> 前往环南侧的奥欣登门户室，它在锁着的门后面。
* You get the key from the last boss in Sethekk Halls if nobody else can open it for you.
.turnin 10177 >> 在Auchindoun遇到麻烦
.accept 10094 >> 接受血法典
step
.requires quest,10095
.goto Terokkar Forest,39.4,72.7
>> 去做影子迷宫并完成任务。
.turnin 10094 >> 交上血法典
.accept 10095 >> 接受进入迷宫的中心
step
.requires quest,9831
.goto Terokkar Forest,39.4,72.7
>> 去暗影迷宫获得第一个关键片段。不要交任务。
.complete 9831,1
step
.requires quest,10091
.goto Terokkar Forest,39.4,72.7
>> 完成暗影迷宫内的任务。不要交任务。
.complete 10091,1
step
.requires quest,10649
.goto Terokkar Forest,39.4,72.7
>> 完成暗影迷宫并掠夺恶魔之书。不要交付任务。
.complete 10649,1
step
.requires quest,10667
>> 去做阴影迷宫，从漩涡大师那里抢夺恶魔词典
.complete 10665,1
step
.requires quest,10095
>> 杀死暗影迷宫内的穆尔。不要交任务。
.complete 10095,1
step
.requires quest,10098
.goto Terokkar Forest,44.0,65.0
.accept 10098 >> 接受特洛克的遗产
.accept 10097 >> 兄弟对抗兄弟
step
.requires quest,10098
>> 完成Sethekk Halls。不要发送任务。
.complete 10098,1
.complete 10098,2
.complete 10098,3
.complete 10097,1
.complete 10097,2
step
.requires quest,10165
.goto Terokkar Forest,39.4,58.6
.accept 10165 >> 接受削弱竞争
step
.requires quest,10218
.goto Terokkar Forest,39.4,58.6
>> 去地牢外接受任务。
.accept 10216 >> 接受安全是第一要务
step
.requires quest,10218
>> 进入法力墓穴完成任务
.complete 10216,1
.complete 10216,2
.complete 10216,3
.complete 10216,4
step
.requires quest,10218
>> 在地牢内传送任务。
.turnin 10216 >> 交班安全是首要任务
step
.requires quest,10218
>> 接受冷冻工程师Sha'heen的任务
.accept 10218 >> 其他人的努力会有回报
step
.requires quest,10218
>> 完成地牢内的护送。不要交付任务。
.complete 10218,1
step
.requires quest,10165
>> 在法力墓穴完成任务。不要交付任务。
.complete 10165,1
step
.requires quest,10164
>> 去奥切奈地穴。不要交付任务。
.complete 10164,1

step << Alliance
.requires quest,9492
.goto Hellfire Peninsula,56.6,66.6
.accept 9492 >> 接受扭转局面
step << Horde
.requires quest,9495
.goto Hellfire Peninsula,55.0,36.0
.accept 9495 >> 接受巫师的意志
step << Alliance
.requires quest,9494
.goto Hellfire Peninsula,53.8,65.6
.accept 9494,1 >> 接受Fel Embers
step << Alliance
.requires quest,9493
.goto Hellfire Peninsula,56.8,62.6
.accept 9493 >> 接受恶魔部落的骄傲
step << Horde
.requires quest,9496
.goto Hellfire Peninsula,55.0,36.2
.accept 9496 >> 接受恶魔部落的骄傲
step
.requires quest,9494
.use 23735 >> 去破碎的大厅杀死大术士尼瑟库斯。然后使用大术士在王座附近掉落的护身符。不要交付任务。
.complete 9494,1
step
.requires quest,10667
>> 去《破碎的大厅》，杀死战使奥姆洛格。不要交任务。
.complete 10670,1
step << Alliance
.requires quest,9492
>> 在破碎的大厅中杀死Warcheif Kargath的拳头。不要交任务。
.complete 9492,1
step << Horde
.requires quest,9495
>> 在破碎的大厅中杀死Warcheif Kargath的拳头。不要交任务。
.complete 9495,1
step << Alliance
.requires quest,9493
>> 进入破碎大厅并完成任务。不要交付任务。
.complete 9493,1
.complete 9493,2
.complete 9493,3
step << Horde
.requires quest,9496
>> 进入破碎大厅并完成任务。不要交付任务。
.complete 9496,1
.complete 9496,2
.complete 9496,3

step
.requires quest,10257
.goto Netherstorm,31.4,66.2
.accept 10173 >> 接受大法师的杖。
step
.requires quest,10257
.goto Netherstorm,40.8,72.6
.use 29207
>> 站在火盆旁边，用魔法粉召唤Ekkorash并杀死她。
.complete 10173,1
step
.requires quest,10257
.goto Netherstorm,31.4,66.2
.turnin 10173 >> 交出大法师的杖。
.accept 10300 >> 接受重建员工。
step
.requires quest,10257
.goto Netherstorm,33.6,54.6
>> 杀死并掠夺水晶的无身保护者和维护者。
.complete 10300,1
step
.requires quest,10257
.goto Netherstorm,31.4,66.2
.turnin 10300 >> 上缴重建员工。
.accept 10174 >> 接受紫罗兰塔的诅咒。
.use 28455 >> 使用职员召唤任务上缴
.turnin 10174 >> 使用完棍子后，将紫罗兰塔诅咒交给大法师瓦尔戈特。
step
.requires quest,10257
.goto Netherstorm,51.8,80.4
.use 28455 >> 使用大法师瓦尔哥特的杖接受任务
.accept 10188 >> 接受克拉苏斯的符号
step
.requires quest,10257
.goto Netherstorm,51.8,80.4
>> 找到并杀死法术绑定者玛丽亚娜，然后抢劫她以换取克拉苏斯魔咒
.unitscan Spellbinder Maryana
.complete 10188,1
step
.requires quest,10257
.goto Netherstorm,51.8,80.4
.use 28455 >> 使用大法师瓦戈特的杖
.turnin 10188 >> 交出克拉苏斯的符号
.accept 10192 >> 接受Krasus的纲要
step
.requires quest,10257
.goto Netherstorm,58.6,89.2,-1
.goto Netherstorm,57.6,89.6,-1
.goto Netherstorm,58.8,88.0,-1
>> 从一个房间的房子里收集简编章节。
.collect 28472,1,10192,1
.collect 28473,1,10192,1
.collect 28474,1,10192,1
step
.requires quest,10257
.goto Netherstorm,57.4,86.2
.use 28455 >> 使用大法师瓦戈特的杖
.turnin 10192 >> 交上克拉索斯的纲要
.accept 10301 >> 接受解锁概要
step
.requires quest,10257
.goto Netherstorm,56.4,79.0
>> 找到并杀死魔法师玛拉泰尔，然后为奥库卢斯掠夺她
.unitscan Spellreaver Marathelle
.complete 10301,1
step
.requires quest,10257
.goto Netherstorm,57.0,63.4
.use 28455 >> 使用大法师瓦戈特的杖
.turnin 10301 >> 打开大纲
.accept 10209 >> 接受召唤师坎丁奖
step
.requires quest,10257
.goto Netherstorm,57.0,63.4
>> 找到并杀死召唤师坎丁，然后抢劫他以换取格拉希克斯之石
.unitscan Summoner Kanthin
.complete 10209,1
step
.requires quest,10257
.goto Netherstorm,58.2,86.4
.use 28455 >> 使用大法师瓦戈特的杖
.turnin 10209 >> 交出传唤官Kanthin的奖品
.accept 10176 >> 接受守护者阿奎罗斯
step
.requires quest,10257
.goto Netherstorm,58.0,86.0
>> 进入Kirin'Var村中心的紫罗兰塔，击败Ar'kelos
.complete 10176,1
step
.requires quest,10257
.goto Netherstorm,58.2,86.4
.turnin 10176 >> 交给守护者阿奎洛斯
.accept 10256 >> 接受查找密钥管理器
step
.requires quest,10257
.goto Netherstorm,53.0,67.0
.unitscan Apex
>> 找到并杀死Apex，然后抢劫他以获得焦点
.collect 28786,1,10256,1
step
.requires quest,10257
.goto Netherstorm,58.2,86.4
.use 28786 >> 使用水晶焦点找到钥匙主人的身份
.complete 10256,1
step
.requires quest,10257
.goto Netherstorm,58.2,86.4
.turnin 10256 >> 轮流去找钥匙管理员
.accept 10257 >> 接受夺取基石
step
.requires quest,10257
+进入Botanica，从指挥官Sarannis手中抢走Keystone。不要一次性完成任务。
.complete 10257,1
step
.requires quest,11877
.goto Netherstorm,23.4,72.4
>> 为计划杀死任何太阳怒派别的敌人
.complete 11877,1
step
.requires quest,10257
.goto Netherstorm,58.3,86.4
.turnin 10256 >> 轮流去找钥匙管理员
.accept 10257 >> 接受夺取基石
step
.requires quest,10257
>> 去做植物学并完成任务。这个任务不要交。
.complete 10257,1
step
.requires quest,10667
>> 去做麦加那，在麦加诺领主卡佩蒂斯面前抢劫紫色盒子
.complete 10665,1
step
.requires quest,10439
.goto Netherstorm,60.0,31.8
.accept 10437 >> 接受销毁配方
step
.requires quest,10439
.goto Netherstorm,61.2,43.6
>> 杀死并掠夺该地区的虚空军团和虚空战士
.complete 10437,1
step
.requires quest,10439
.goto Netherstorm,60.0,31.8
.turnin 10437 >> 提交销毁配方
.accept 10438 >> 接受阴蒂之翼
step
.requires quest,10439
.goto Netherstorm,62.6,41.0
>> 在任务列表处跳上坐骑。
.use 29778
.complete 10438,1
step
.requires quest,10439
.goto Netherstorm,60.0,31.8
.turnin 10438 >> 打开阴蒂之翼
.accept 10439 >> 接受一切吞噬的维度
step
.requires quest,10439
.goto Netherstorm,62.4,40.8
>> 找到一个小组并完成任务。不要交出这个任务
.complete 10439,1
.complete 10439,2
step
.requires quest,10408
.goto Netherstorm,59.4,32.4
.accept 10339 >> 接受以太坊
step
.requires quest,10408
.goto Netherstorm,57.0,37.4
.complete 10339,1
.complete 10339,2
.complete 10339,3
.complete 10339,4
step
.requires quest,10408
.goto Netherstorm,56.8,38.6
.turnin 10339 >> 打开以太坊
.accept 10384 >> 接受以太坊数据
step
.requires quest,10408
.goto Netherstorm,55.8,39.9
.complete 10384,1
step
.requires quest,10408
.goto Netherstorm,56.8,38.6
.turnin 10384 >> 提交以太坊数据
.accept 10385 >> 接受脑损伤可能性=高
step
.requires quest,10408
.goto Netherstorm,56.2,41.4
.complete 10385,1
step
.requires quest,10408
.goto Netherstorm,56.8,38.6
.turnin 10385 >> 转入脑损伤的可能性=高
.accept 10405 >> 接受S-A-B-O-T-A-G-E
step
.requires quest,10408
.goto Netherstorm,56.2,41.4
>> 杀死以太坊执政官和霸王。
.complete 10405,1
step
.requires quest,10408
.goto Netherstorm,56.8,38.6
.turnin 10405 >> 转入S-A-B-O-T-A-G-E
.accept 10406 >> 传递消息
step
.requires quest,10408
.goto Netherstorm,56.8,38.6
>>确保你站在召唤任务给予者的平台上，否则任务可能会出错。
.complete 10406,1
step
.requires quest,10408
.goto Netherstorm,56.8,38.6
.turnin 10406 >> 交上来传递信息
.accept 10408 >> 接受Nexus King Salhadaar
step
.requires quest,10408
.goto Netherstorm,53.4,42.0
.use 29618 >> 分组完成任务。使用Protectorate Disruptor释放他。这个任务不要交。
.complete 10408,1

step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,52.6,59.0
.accept 10718 >> 接受灵魂的声音
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.4
.turnin 10718 >> 灵魂发声
.accept 10614 >> 接受风中的低语
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,75.2,60.8
.turnin 10614 >> 风中低语
.accept 10709 >> 接受团聚
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.4
.turnin 10709 >> 加入留尼汪
.accept 10714 >> 接受灵魂的翅膀
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,58.0,30.0
.use 31128 >> 使用哨子同时监视血腥监工和占卜师
.complete 10714,1
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.4
.turnin 10714 >> 打开精灵的翅膀
.accept 10783 >> 接受萨布勒曼男爵
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,53.2,42.1
.turnin 10783 >> 交给萨布勒曼男爵
.accept 10715 >> 接受进入漩涡峡谷
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,47.0,44.8
>> 杀戮并掠夺外壳斗牛士的腺体
.complete 10715,1
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,53.2,41.2
.turnin 10715 >> 转入漩涡峡谷
.accept 10749 >> 接受萨布勒曼男爵的毒药
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.4
.turnin 10749 >> 交出萨布勒曼男爵的毒药
.accept 10720 >> 接受最小的生物
step << Horde
#sticky
#completewith poisonkeybe
.requires quest,10742
.goto Blade's Edge Mountains,56.5,29.3
+使用Kodohide滚筒控制土拨鼠。使用隐形能力，跑到酒桶里毒死他们。
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,55.4,28.1
.complete 10720,2 
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,55.3,26.0
.complete 10720,1 
step << Horde
#label poisonkeybe
.requires quest,10742
.goto Blade's Edge Mountains,56.0,23.2
.complete 10720,3 
step
.requires quest,11514
.goto Blade's Edge Mountains,53.0,18.8
>>从巴什尔登陆收集法力细胞
.complete 11514,1
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.4
.turnin 10720 >>交出最小的生物
.accept 10721 >>接受Grulloc的求婚时间
step << Horde
#completewith next
.requires quest,10742
.goto Blade's Edge Mountains,60.1,47.7
+使用Huffer的哨声，等待Huffer攻击Grulloc。当他逃跑时，抢走了格鲁洛克的口袋。
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,60.9,47.8
.complete 10721,1 
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,53.2,41.2
.turnin 10721 >>为Grulloc报仇
.accept 10785 >>接受这是个陷阱！
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.3
.turnin 10785 >>上车，这是个陷阱！
.accept 10723 >>接受食龙者戈格罗姆
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,30.6,22.2
>>点击Gorgrom祭坛召唤Misha。等待短RP，当Gorgrom死亡时，放置你的3个恐怖图腾。
.complete 10723,1 
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.3
.turnin 10723 >>交出食龙者戈格罗姆
.accept 10724 >> 接受剑锋之囚徒
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,64.2,23.4
>> 找到一个小组并完成任务
.use 31144
.complete 10724,1
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.3
.turnin 10724 >> 交给刀锋尖塔的囚徒
.accept 10742 >> 接受决战
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,64.0,18.4
>> 找一个小组来帮助你。不要交付任务。
.use 31146
.complete 10742,1
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,55.1,24.0
>>上楼，杀死并抢劫多尔戈克，然后点击你包里的物品
.complete 10795,1 
.collect 31363,1,10797,1 
.accept 10797 >> 接受格隆的青睐
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,62.0,38.0
>>点击包中的物品
.turnin 10797 >> 支持Gronn
.accept 10798 >> 接受拜见男爵
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,53.3,41.2
.turnin 10798 >> 上书拜见男爵
.accept 10799 >> 接受进入漩涡峡谷
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,48.4,43.7
.complete 10799,1 
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,53.2,41.2
.turnin 10799 >> 转入漩涡峡谷
.accept 10800 >> 接受晚安，格隆
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,60.9,47.7
>>在格鲁洛克身上使用萨布曼男爵的安眠粉。小心，因为它可以抵抗（只需再次使用）
.complete 10800,1 
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,53.2,41.2
.turnin 10800 >> 晚安，格伦
.accept 10801 >> 接受这是个陷阱！
step << Alliance
.goto Blade's Edge Mountains,44.0,51.8
.accept 10516 >> 接受维护者的陷阱
step << Alliance
.goto Blade's Edge Mountains,42.6,59.4,40,0
.goto Blade's Edge Mountains,39.0,52.6
>> 杀死德罗加姆和莫格道格，并掠夺他们的任务物品
.complete 10516,2 
.complete 10516,1 
step << Alliance
.goto Blade's Edge Mountains,44.0,51.8
.turnin 10516 >> 交出辩护人的陷阱
.accept 10517 >> 接受戈尔丁，你的时间到了。。。
step << Alliance
.goto Blade's Edge Mountains,39.4,49.2
>> 杀死Gorr'dim
.complete 10517,1 
step << Alliance
.goto Blade's Edge Mountains,44.0,51.8
.turnin 10517 >> 交上Gorr'Dim，你的时间到了。。。
.accept 10518 >> 接受种植旗帜
step << Alliance
.goto Blade's Edge Mountains,39.2,58.6,40,0
.goto Blade's Edge Mountains,46.4,74.6
>> 杀死一个剑锋战士并将其掠夺为旗帜
.unitscan Bladespire Champion
.collect 30416,1,10518,1
.use 30416 >> 使用塔顶的横幅引诱格伦·格鲁布诺什。为了他的头盔杀了他。
.collect 30417,1,10518,1
step << Alliance
.goto Blade's Edge Mountains,36.2,66.2
.turnin 10518 >> 上缴种植旗帜
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,62.0,38.1
.turnin 10801 >> 上车，这是个陷阱！
.accept 10802 >> 接受食龙者戈格罗姆
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,30.5,22.2
>>点击中间的祭坛，将图腾放在巨人的尸体上
.complete 10802,1 
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,62.0,38.0
.turnin 10802 >> 交出食龙者戈格罗姆
.accept 10818 >> 接受萨布曼男爵要求您出席
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,53.2,41.2
.turnin 10818 >> 交出男爵Sableman要求你在场
.accept 10805 >> 接受格鲁尔巢穴的屠杀
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,63.0,20.2
.complete 10805,1
.complete 10805,2
.complete 10805,3
.complete 10805,4
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,51.8,58.3
.turnin 10805 >> 在格鲁尔的巢穴投案大屠杀
.accept 10806 >> 接受决战
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,64.0,18.4
>> 找一个小组来帮助你。不要交付任务。
.use 31808
.complete 10806,1
step
.requires quest,11000
.goto Blade's Edge Mountains,55.4,44.8
.accept 10995 >> 接受Grulloc有两个头骨
.accept 10996 >> 接受Maggoc的宝箱
.accept 10997 >> 接受Even Gronn的标准
step
.requires quest,11000
.goto Blade's Edge Mountains,60.6,47.6
>> 杀死格鲁洛克
.complete 10995,1
step
.requires quest,11000
.goto Blade's Edge Mountains,66.0,55.5
>> 找到麦戈克，杀死他，洗劫他的箱子。
.complete 10996,1
step
.requires quest,11000
.goto Terokkar Forest,20.5,17.7
>> 杀戮杀手
.complete 10997,1
step
.requires quest,11000
.goto Blade's Edge Mountains,55.4,44.8
.turnin 10995 >> Turn in Grulloc有两个头骨
.turnin 10996 >> 交出Maggoc的宝箱
.turnin 10997 >> 交给Even Gronn有标准
.accept 10998 >> 接受严酷的业务
step
.requires quest,11000
.goto Blade's Edge Mountains,77.4,31.2
>> 找到一个小组，完成5人小组任务。
.complete 10998,1
step
.requires quest,11000
.goto Blade's Edge Mountains,55.4,44.8
>> 在探索中把它转过来，接下来是笨重的一个。
.turnin 10998 >> 营业额惨淡
step
.requires quest,11000
.goto Blade's Edge Mountains,55.4,44.8
.accept 11000 >> 接受进入灵魂世界。
step
.requires quest,11000
.goto Blade's Edge Mountains,60.6,25.6
>> 再次找到一个团队，完成5人团队任务。这个任务不要交。
.complete 11000,1

step
.requires quest,9738
.goto Zangarmarsh,52.2,36.0
>> 进入湖中央的水下水库
.accept 9738 >> 接受迷失在行动中
step
.requires quest,9763
.goto Zangarmarsh,52.2,36.0
>> 进入湖中央的水下水库
.accept 9763 >> 接受军阀的庇护
step
.requires quest,9738
>> 在“从笔”中完成这两个步骤
.complete 9738,3
.complete 9738,2
step
.requires quest,9738
>> 在Underbog完成这两个步骤。不要交付任务。
.complete 9738,1
.complete 9738,4
step
.requires quest,9763
>> 杀死Steamvaults的最后一个老板。不要交付任务。
.complete 9763,3
step
.requires quest,10667
>> 去执行Steamfaults，杀死Hydromacer Thespia。不要交任务。
.complete 10667,1

step
.requires quest,11108
.goto Shadowmoon Valley,66.0,85.4
.reputation 1015,exalted,<0,1
>> 这个问题需要提升。
.accept 11107 >> 接受对大领主的鞠躬
step
.requires quest,11108
.goto Shadowmoon Valley,66.0,85.4
.turnin 11107 >> 向大领主鞠躬
.accept 11108 >> 接受伊利丹·怒风勋爵
step
.requires quest,11108
>> 等待超长RP。不要在这个任务中交出。 
.complete 11108,1
step << Horde
.requires quest,9937
.goto Nagrand,55.7,37.9
.accept 9935 >> 接受通缉：基塞尔达
.accept 9939 >> 接受通缉：顾问Zorbo
step << Alliance
.requires quest,9938
.goto Nagrand,54.7,70.8
.accept 9936 >> 接受通缉：基塞尔达
.accept 9940 >> 接受通缉：顾问Zorbo
step << Horde
.requires quest,9937
.goto Nagrand,71.2,82.2
>> 杀死该地区的克伦族吉塞尔达和15名基尔索洛特工
.complete 9935,1
.complete 9935,2
step << Alliance
.requires quest,9938
.goto Nagrand,71.2,82.2
>> 杀死该地区的克伦族吉塞尔达和15名基尔索洛特工
.complete 9936,1
.complete 9936,2
step << Horde
.requires quest,9937
.goto Nagrand,46.0,19.0
>> 杀死该地区的顾问佐尔布和战争食人魔
.complete 9939,1
.complete 9939,2
.complete 9939,3
step << Alliance
.requires quest,9938
.goto Nagrand,46.0,19.0
>> 杀死该地区的顾问佐尔布和战争食人魔
.complete 9940,1
.complete 9940,2
.complete 9940,3
step << Alliance
.requires quest,9938
.goto Nagrand,54.7,70.8
.turnin 9936 >> 通缉犯：基塞尔达
.turnin 9940 >> 通缉犯：顾问佐尔布
step << Horde
.requires quest,9937
.goto Nagrand,55.8,37.8
.turnin 9935 >> 通缉犯：基塞尔达
.turnin 9939 >> 通缉犯：顾问佐尔布
step << Horde
.requires quest,9937
.goto Nagrand,55.8,37.8
.accept 9937 >> 通缉犯：饥饿者杜伦
step << Alliance
.requires quest,9938
.goto Nagrand,55.8,37.8
.accept 9938 >> 通缉犯：饥饿者杜伦
step << Horde
.requires quest,9937
.goto Nagrand,38.2,77.2,60,0
.goto Nagrand,47.0,70.0,60,0
.goto Nagrand,37.0,58.2,60,0
.goto Nagrand,31.0,69.2,60,0
>> 找到并杀死饥饿者杜伦，他在巨大的水晶周围巡逻。完成此任务后不要交上来。
.unitscan Durn the Hungerer
.complete 9937,1
step << Alliance
.requires quest,9938
.goto Nagrand,38.2,77.2,60,0
.goto Nagrand,47.0,70.0,60,0
.goto Nagrand,37.0,58.2,60,0
.goto Nagrand,31.0,69.2,60,0
>> 找到并杀死饥饿者杜伦，他在巨大的水晶周围巡逻。完成此任务后不要交上来。
.unitscan Durn the Hungerer
.complete 9938,1
step
.requires quest,9853
.goto Nagrand,61.2,22.2
>> 这个任务链的末端是精英，你可能需要帮助。
.accept 9818 >> 接受底层
step
.requires quest,9853
.goto Nagrand,61.0,22.0
>> 与地球元素对话
.skipgossip
.complete 9818,1
step
.requires quest,9853
.goto Nagrand,61.2,22.2
.turnin 9819 >> 在下面转弯
.accept 9819 >> 接受被扭曲的地球
step
.requires quest,9853
.goto Nagrand,67.0,32.0
>> 杀死该地区被扭曲的大地精灵
.complete 9819,1 
step
.requires quest,9853
.goto Nagrand,61.2,22.2
.turnin 9819 >> 扭转扭曲的地球
.accept 9821 >> 接受吃的诅咒
step
.requires quest,9853
.goto Nagrand,56.0,52.0
>> 杀死并抢劫愤怒的破碎者
.collect 24473,15,9821,1
step
.requires quest,9853
.goto Nagrand,61.2,22.2
.turnin 9821 >> 轮到吃东西了
.accept 9849 >> 接受粉碎面纱
step
.requires quest,9853
.goto Nagrand,29.0,67.4,40,0
.goto Nagrand,32.0,80.6,40,0
.goto Nagrand,41.0,82.6,40,0
.use 24501 >> 在破碎的隆隆声上使用戈尔多格的巨石，然后杀死产卵的小黄人
.complete 9849,1
step
.requires quest,9853
.goto Nagrand,61.2,22.2
.turnin 9849 >> 转身撕碎面纱
.accept 9853 >> 接受暴徒古洛克
step
.requires quest,9853
.goto Nagrand,29.0,24.8
>> 杀死并抢劫侵略者古洛克。完成此任务后不要交上来。
.collect 24503,1,9853,1
step
.requires quest,9977
.goto Nagrand,42.8,20.8
>> 这个任务链是精英，你可能需要帮助。
.accept 9962 >> 接受血环：断脚趾
step
.requires quest,9977
.goto Nagrand,42.8,20.8
>> 进入竞技场击败老板
.complete 9962,1
step
.requires quest,9977
.goto Nagrand,42.8,20.8
.turnin 9962 >> 转动血环：脚趾骨折
.accept 9967 >> 接受血环：蓝色兄弟
step
.requires quest,9977
.goto Nagrand,42.8,20.8
>> 进入竞技场击败老板
.complete 9967,1
step
.requires quest,9977
.goto Nagrand,42.8,20.8
.turnin 9967 >> 移交血环：蓝色兄弟
.accept 9970 >> 接受血环：破碎的魔王Rokdar
step
.requires quest,9977
.goto Nagrand,42.8,20.8
>> 进入竞技场击败老板
.complete 9970,1
step
.requires quest,9977
.goto Nagrand,42.8,20.8
.turnin 9970 >> 交回血环：破碎的洛达尔
.accept 9972 >> 接受血环：斯科拉加特
step
.requires quest,9977
.goto Nagrand,42.8,20.8
>> 进入竞技场击败老板
.complete 9972,1
step
.requires quest,9977
.goto Nagrand,42.8,20.8
.turnin 9972 >> 血之环：斯卡拉加特
.accept 9973 >> 接受血环：战争冠军
step
.requires quest,9977
.goto Nagrand,42.8,20.8
>> 进入竞技场击败老板
.complete 9973,1
step
.requires quest,9977
.goto Nagrand,42.8,20.8
.turnin 9973 >> 血腥之戒：战锤冠军
.accept 9977 >> 接受血环：最后的挑战
step
.requires quest,9977
.goto Nagrand,42.8,20.8
>> 进入竞技场，击败老板。完成任务后不要交任务！
.complete 9977,1
step
#sticky
+以下任务是每日任务。因为你在角色身上完成了很多普通任务。

step
.requires quest,11369
.isOnQuest 11369
>> 进入《植物学》的英雄难度，击败《黑追踪者》。完成任务后不要提交。
.complete 11369,1
step
.requires quest,11384
.isOnQuest 11384
>> 进入Underbog的英雄难度并击败曲分裂。完成任务后不要提交。
.complete 11384,1
step
.requires quest,11382
.isOnQuest 11382
>> 进入英雄难度的黑色沼泽，击败埃昂纳斯。完成任务后不要提交。
.complete 11382,1
step
.requires quest,11363
.isOnQuest 11363
>> 进入英雄难度的破碎大厅，击败酋长卡加特·刀锋拳。完成任务后不要提交。
.complete 11363,1
step
.requires quest,11362
.isOnQuest 11362
>> 以英雄难度进入血炉，击败破坏者科利丹。完成任务后不要提交。
.complete 11362,1
step
.requires quest,11375
.isOnQuest 11375
>> 在英雄难度上进入暗影迷宫并击败穆尔。完成任务后不要提交。
.complete 11375,1
step
.requires quest,11354
.isOnQuest 11354
>> 进入地狱火堡垒，挑战英雄难度，击败纳桑。完成任务后不要提交。
.complete 11354,1
step
.requires quest,11386
.isOnQuest 11386
>> 进入英雄难度的Mechanar，击败计算器上的Pathaleon。完成任务后不要提交。
.complete 11386,1
step
.requires quest,11373
.isOnQuest 11373
>> 以英雄难度进入玛纳墓穴，击败纳克西斯王子沙法尔。完成任务后不要提交。
.complete 11373,1
step
.requires quest,11378
.isOnQuest 11378
>> 以英雄难度进入旧希尔斯布拉德山麓地牢，击败时代猎人。完成任务后不要提交。
.complete 11378,1
step
.requires quest,11374
.isOnQuest 11374
>> 进入奥切奈地穴，挑战英勇难度，击败马拉达尔酋长。完成任务后不要提交。
.complete 11374,1
step
.requires quest,11372
.isOnQuest 11372
>> 进入塞塞克大厅（Sethekk Halls），挑战英雄难度，击败塔龙国王艾吉斯（Talon King Ikiss）。完成任务后不要提交。
.complete 11372,1
step
.requires quest,11368
.isOnQuest 11368
>> 进入《奴隶笔》的英雄难度，击败夸美兰。完成任务后不要提交。
.complete 11368,1
step
.requires quest,11388
.isOnQuest 11388
>> 进入《魔兽世界》中的英雄难度，击败先驱者Skyriss。完成任务后不要提交。
.complete 11388,1
step
.requires quest,11370
.isOnQuest 11370
>> 进入《蒸汽断层》，挑战英雄难度，击败军阀卡利思雷什。完成任务后不要提交。
.complete 11370,1

step
.requires quest,11377
.goto Shattrath City,61.6,15.8
.daily 11380,11377,11381,11379 >> 每天接受烹饪
step
.requires quest,11377
.isOnQuest 11380
.goto Netherstorm,46.0,11.0
>> 在荷兰风暴的生态穹顶收集法力浆果。完成任务后不要提交。
.complete 11380,1
step
.requires quest,11377
.isOnQuest 11377
>> 从围绕斯凯蒂斯飞行的怪物卡里里那里收集一只巨大的卡里里翅膀
.goto Terokkar Forest,61.2,74.2,20,0
.goto Terokkar Forest,69.8,75.0,20,0
.goto Terokkar Forest,74.6,88.4,20,0
.collect 33838,1,11377,1
step << Alliance
.requires quest,11377
.isOnQuest 11377
.goto Stormwind City,53.6,59.6
>> 烹饪3个曲汉堡，或从拍卖行购买。
.collect 27659,3,11377,1
step << Horde
.requires quest,11377
.isOnQuest 11377
.goto Orgrimmar,55.6,62.8
>> 烹饪3个曲汉堡，或从拍卖行购买。
.collect 27659,3,11377,1
step
.requires quest,11377
.isOnQuest 11377
.use 33837 >> 使用您的烹饪锅，并在您的库存中添加配料。完成任务后不要提交。
.complete 11377,1
step << Alliance
.requires quest,11377
.isOnQuest 11381
.goto Stormwind City,53.6,59.6
>> 烹饪4个烤羊蹄，或从拍卖行购买。
.collect 27658,4,11381,1
step << Horde
.requires quest,11377
.isOnQuest 11381
.goto Orgrimmar,55.6,62.8
>> 烹饪4个烤羊蹄，或从拍卖行购买。
.collect 27658,4,11381,1
step
.requires quest,11377
.isOnQuest 11381
.goto Nagrand,26.0,59.5
.use 33851 >> 站在祖先的场地内，用你的烹饪锅和你库存中的配料。完成任务后不要提交。
.complete 11381,1
step << Alliance
.requires quest,11377
.isOnQuest 11377
.goto Stormwind City,53.6,59.6
>> 煮2条莫克纳撒尔排骨和一条松脆的蛇，或者从拍卖行买下来。
.collect 31672,2,11377,1
.collect 31673,1,11377,1
step << Horde
.requires quest,11377
.isOnQuest 11377
.goto Orgrimmar,55.6,62.8
>> 煮2条莫克纳撒尔排骨和一条松脆的蛇，或者从拍卖行买下来。
.collect 31672,2,11377,1
.collect 31673,1,11377,1
step
.requires quest,11377
.isOnQuest 11377
.goto Blade's Edge Mountains,29.6,83.4
.use 33837 >> 站在一个死了的深渊火焰弹上，用你的烹饪锅和你的库存中的配料。完成任务后不要提交。
.complete 11377,1

step
.requires quest,11387
.isOnQuest 11389
>> 进入奥克拉兹，击败5名奥克拉兹哨兵。完成任务后不要提交。
.complete 11389,1
step
.requires quest,11387
.isOnQuest 11371
>> 进入Steamvault，击败14名Coilfang Myrmidons。完成任务后不要提交。
.complete 11371,1
step
.requires quest,11387
.isOnQuest 11376
>> 进入暗影迷宫，击败3名恶意教练。完成任务后不要提交。
.complete 11376,1
step
.requires quest,11387
.isOnQuest 11383
>> 进入黑沼泽，击败4个裂谷领主。完成任务后不要提交。
.complete 11383,1
step
.requires quest,11387
.isOnQuest 11364
>> 进入破碎大厅，击败4名破碎手百夫长。完成任务后不要提交。
.complete 11364,1
step
.requires quest,11387
.isOnQuest 11385
>> 进入《植物学》，击败6名阳光卫士频道。完成任务后不要提交。
.complete 11385,1
step
.requires quest,11387
.isOnQuest 11387
>> 进入Mechanar并击败5个风暴锻造毁灭者。完成任务后不要提交。
.complete 11387,1

step
.requires quest,11523
.goto Isle of Quel'Danas,47.4,30.6
.accept 11523 >> 接受武装病房！
step
.requires quest,11525
.goto Isle of Quel'Danas,47.2,30.6
.accept 11525 >> 接受进一步的转换
step
.requires quest,11521
.goto Isle of Quel'Danas,51.5,32.5
.accept 11521 >> 接受重新发现你的根
step
.requires quest,11546
.goto Isle of Quel'Danas,51.5,32.5
.accept 11546 >> 接受开业
step
.requires quest,11541
.goto Isle of Quel'Danas,53.8,34.2
.accept 11541 >> 接受瓦林德里亚船长对格林吉尔海岸的破坏。
step
.requires quest,11533
.goto Isle of Quel'Danas,47.6,35.2
.accept 11533 >> 接受空袭必须继续
step
.requires quest,11547
.goto Isle of Quel'Danas,47.6,35.4
.accept 11547 >> 接受星际巫师达纳里安的《了解你的莱伊线》。
step
.requires quest,11536
.goto Isle of Quel'Danas,50.4,40.6
.accept 11536 >> 接受现在不要停止。。。。
step
.requires quest,11544
.goto Isle of Quel'Danas,50.6,40.8
.accept 11544 >> 接受Ata'mal武器
step
.requires quest,11542
.goto Isle of Quel'Danas,50.6,39.0
.accept 11542 >> 接受拦截维护者Kaalan的增援。
step
.requires quest,11539
.goto Isle of Quel'Danas,49.4,40.2
.accept 11539 >> 接受从魔法师伊拉斯塔手中夺取港口
step
.requires quest,11536
.goto Isle of Quel'Danas,65.0,48.0
>> 深松矿石的敞口箱子
.collect 34479,3
step
.requires quest,11541
.goto Isle of Quel'Danas,60.9,51.6
.use 34483 >> 为穆洛克控制之球杀死黑松树警报器，并将其用于格林吉尔奴隶。完成任务后不要提交。
.complete 11541,1
step
.requires quest,11547
.goto Isle of Quel'Danas,61.2,62.5
.use 34533 >> 使用神龛附近的星际漫游者水晶。完成任务后不要提交。
.complete 11547,2
step
.requires quest,11547
.goto Isle of Quel'Danas,48.4,45.5
.use 34533 >> 使用入口附近的星际漫游者水晶。
.complete 11547,1
step
.requires quest,11523
.goto Isle of Quel'Danas,47.4,30.6
.use 34338 >> 使用法力残留物为基地周围的任何守卫提供能量
.complete 11523,1
step
.requires quest,11539
.goto Isle of Quel'Danas,45.6,41.4
>>杀死该区域周围的Dawnblade敌人。完成任务后不要提交。
.complete 11539,1
.complete 11539,2
.complete 11539,3
step
.requires quest,11547
.goto Isle of Quel'Danas,42.0,35.2
.use 34533 >> 使用血晶附近的星际魔术师水晶。
.complete 11547,3
step
.requires quest,11533
.goto Isle of Quel'Danas,48.4,25.2
.use 34475 >>与Ayren Cloudbreaker交谈，飞越亲爱的疤痕，使用奥术冲锋杀死敌人
.complete 11533,1
.complete 11533,2
.complete 11533,3
step
.requires quest,11542
.skipgossip
>> 与Ayren Cloudbreaker交谈，进行飞越船只的飞行。
.goto Isle of Quel'Danas,48.4,25.2
step
.requires quest,11542
.goto Isle of Quel'Danas,48.4,25.2
.use 34489 >> 在每艘船的船帆上洒上燃烧的油
.complete 11542,1
.complete 11542,2
.complete 11542,3
step
.requires quest,11542
.goto Isle of Quel'Danas,48.4,25.2
>> 着陆时杀死道恩布拉德预备队。完成任务后不要提交。
.complete 11542,4
step
.requires quest,11546
.goto Isle of Quel'Danas,38.0,29.7
>> 抢劫该地区的血莓。
.complete 11546,1
step
.requires quest,11523
.goto Isle of Quel'Danas,44.8,26.4,40,0
.goto Isle of Quel'Danas,40.6,30.4,40,0
.goto Isle of Quel'Danas,35.6,35.0
>>为法力残留物杀死穷凶极恶的敌人
.collect 34338,4,11523,1
step
.requires quest,11525
.goto Isle of Quel'Danas,43.8,26.6,40,0
.goto Isle of Quel'Danas,37.4,32.4,40,0
.goto Isle of Quel'Danas,34.6,38.8
.use 34368 >> 击败反复无常的哨兵并替换其核心
.complete 11525,1
step
#aldor
.requires quest,11492
.goto Isle of Quel'Danas,47.4,30.6
.turnin 11481 >> Sunwell面临的危机
.accept 11488 >> 接受魔法师露台
step
#scryer
.requires quest,11492
.goto Isle of Quel'Danas,47.4,30.6
.turnin 11482 >> 交班电话
.accept 11488 >> 接受魔法师露台
step
.requires quest,11492
>> 进入魔术师露台
.turnin 11488 >> 转入魔术师露台
.accept 11490 >> 接受Scryer的Scryer
step
.requires quest,11492
>> 在圣珠上的魔法师露台完成任务。
.complete 11490,1
step
.requires quest,11492
>> 将任务交给实例内部。
.turnin 11490 >> 交给Scryer的Scryer
.accept 11492 >> 接受难以杀死
step
.requires quest,11492
>> 在实例内杀死Kael'thas。不要交任务。
.complete 11492,1
step
.requires quest,11544
.goto Shadowmoon Valley,69.5,39.6
>> 在阿塔玛露台周围杀死兽人，获得5件阿塔玛武器。
.collect 34500,5,11544,1
step
.requires quest,11544
.goto Isle of Quel'Danas,50.1,40.5
.use 34500 >> 站在Hauthaa铁砧旁边时，使用Ata'mal武器。完成任务后不要提交。
.complete 11544,1
step
.requires quest,11521
.goto Terokkar Forest,58.1,13.2
>> 杀死Razorthorn Flayers获取腺体
.collect 34255,1,11521,1
step
.requires quest,11521
.use 34255 >> 使用剃须刀掠夺者的腺体来控制它，并露出根部供你挖掘。完成任务后不要提交。
.complete 11521,1

step
.requires quest,11020
.goto Shadowmoon Valley,66.0,86.4
.accept 11020 >> 接受亚齐尔水星公司的缓慢死亡
step
.requires quest,11020
.goto Shadowmoon Valley,45.8,61.5,20
>> 杀死附近的Felfire Diemetradon获取Fel腺体。
.collect 32502,12,11020,1
step
.requires quest,11020
.goto Shadowmoon Valley,66.0,82.1,30,0
.goto Shadowmoon Valley,76.3,85.4,30,0
.use 32503>> 用龙嘴狮附近的亚齐尔羊肉毒死它们。完成任务后不要提交。
.complete 11020,1

step
.requires quest,11035
.goto Shadowmoon Valley,66.0,86.4
.accept 11035 >> 接受亚齐尔商品交易所的“不那么友好的天空”。
step
.requires quest,11035
.goto Shadowmoon Valley,72.3,64.3
>> 为了荷兰之翼遗迹杀死龙嘴运输车。完成任务后不要提交。
.complete 11035,1

step
.requires quest,11515
.goto Hellfire Peninsula,58.2,17.6
.accept 11515 >> 接受Magistrix Seyla的血换血服务。
step
.requires quest,11516
.goto Hellfire Peninsula,58.2,17.6
.accept 11516 >> 接受爆破网关
step
.requires quest,11516
.goto Hellfire Peninsula,58.2,17.6
.use 34253 >> 召唤带着嘶嘶灰烬的活火炬，将其靠近火元素，为其供电。当它完成时，把它带到恶魔之门。
.complete 11516,1
step
.requires quest,11515
.use 34257 >> 为恶魔之血杀死愤怒先驱，然后对恶魔之血提升者使用恶魔虹吸。完成任务后不要提交。
.complete 11515,1
step << Alliance
.requires quest,11502
.goto Nagrand,55.8,73.6
.accept 11502 >> 从特拉尔的拉科尔接受哈拉的辩护。
step << Alliance
.requires quest,11502
.goto Nagrand,55.8,73.6,20,0
>> 杀死哈拉周围的敌人派系守卫或玩家。完成任务后不要提交。
.complete 11502,1

step << Horde
.requires quest,11503
.goto Nagrand,52.8,36.0
.accept 11503 >> 接受来自Garadar Karrtog的新老敌人。
step << Horde
.requires quest,11503
.goto Nagrand,55.8,73.6,20,0
>> 杀死哈拉周围的敌人派系守卫或玩家。完成任务后不要提交。
.complete 11503,1
step
.requires quest,11008
.goto Terokkar Forest,64.6,66.6
.accept 11008 >> 接受草图上的火焰
step
.requires quest,11008
.goto Terokkar Forest,70.4,80.1,10,0
.goto Terokkar Forest,74.7,88.3,10,0
.goto Terokkar Forest,67.6,86.0,10,0
.goto Terokkar Forest,62.6,80.8,10,0
.use 32406 >> 在您上山时，在您的库存中使用爆破费用来摧毁该区域结构顶部的鸡蛋。完成任务后不要提交。
.complete 11008,1
]])
RXPGuides.RegisterGuide([[
#version 7
#wotlk
#tbc
#group RestedXP WLK的准备
#name RestedXP 准备的 经验 总数
#hidewindow
step
>> 到目前为止，您准备的经验是：
.showtotalxp
>> 在角色可能的总数中：
.showtotalxp 1
>> 对于任务日志任务，请将物品放入包中，以便所有任务都标记为“（完成）”。
>>-
.show25quests >> 单击此处查看角色的25个最佳任务列表
]])
RXPGuides.RegisterGuide([[
#version 7
#wotlk
#tbc
#group RestedXP WLK的准备
#name 启动准备指南
step
#sticky
+这本指南是关于做任务链，可以很容易地拿起，并在启动时交给，而不需要将它们保存在您的任务日志中。如果指南的这一章说要交东西，那就交吧！没关系，你不会在实验中失败。只是不要交任何它没有告诉你的任务，这些是我们正在保存的任务。他们将按照“交车指南”交车。
step
.reputation 989,revered >> 与时间守护者一起获得尊敬。
>> 垃圾洞时间地牢直到被尊敬。这是一个必须做的步骤，除非你有一个术士可以在发射时召唤你去洞穴。
step << Horde
.reputation 729,exalted >> 与霜狼氏族一起升华
.goto Alterac Mountains,62.2,58.9
>> 这一步需要在发射日召唤奥特兰克山脉。如果没有，请跳过。我们正在提交AV小饰物升级任务。如果你已经提交了令人尊敬的升级任务，那么至少要达到令人尊敬或赞叹的程度。尊敬和崇高给予同样的经验。这一经验是由奥特兰克山谷的普华永道获得的。
* Be sure to do Proving Grounds and unlock the base level of your trinket. This quest is picked up in Alterac Mountains
.accept 7161 >> 接受证明理由
.turnin 7161 >> 移交试验场地
step << Alliance
.reputation 730,exalted >> 与风暴守卫一起升华
.goto Alterac Mountains,39.6,81.2
>> 这一步需要在发射日召唤奥特兰克山脉。如果没有，请跳过。我们正在提交AV小饰物升级任务。如果你已经提交了令人尊敬的升级任务，那么至少要达到令人尊敬或赞叹的程度。尊敬和崇高给予同样的经验。这一经验是由奥特兰克山谷的普华永道获得的。
* Be sure to do Proving Grounds and unlock the base level of your trinket. This quest is picked up in Alterac Mountains
.accept 7162 >> 接受证明理由
.turnin 7162 >> 移交试验场地
step
.reputation 967,exalted >> 《紫罗兰之眼》让你神采飞扬。
>> 我们正在进行卡拉环升级任务。至少获得荣誉，所有过去获得荣誉的营业额都是相同的经验。如果你已经提交了戒指升级任务，那么就提升一个代表级别。你可以累积多次重复奖励以获得更多经验！通过运行Karazhan获得此重复次数。
step
.reputation 990,exalted >> 用沙子的尺度来提升自己。
>> 我们正在进行Hyjal环升级任务。至少获得荣誉，所有过去获得荣誉的营业额都是相同的经验。如果你已经提交了戒指升级任务，那么就提升一个代表级别。通过运行Mount Hyjal获得此重复次数。
step << Horde
.goto Hellfire Peninsula,87.4,48.2
.accept 10289 >> 接受萨尔玛之旅
step << Horde
#completewith next
.goto Hellfire Peninsula,55.8,36.8
.fly Thrallmar >> 再次与NPC对话，飞往萨尔玛
step << Horde
.goto Hellfire Peninsula,55.8,36.8
.turnin 10289 >> 《萨尔纳之旅》（Journey to Thrallnar）
.accept 10291 >> 接受向Nazgrel的报告
step << Horde
.goto Hellfire Peninsula,55.0,36.0
.turnin 10291 >> 向Nazgrel提交报告
.accept 10121 >> 接受消灭燃烧军团
step << Horde
>> 跑出城镇
.goto Hellfire Peninsula,58.0,41.2
.turnin 10121 >> 上缴消灭燃烧军团
.accept 10123 >> 接受Felsark Ravine
step << Horde
.goto Hellfire Peninsula,63.0,38.0
>> 杀死该地区的火焰行者小鬼、地狱战警和恐怖召唤者
.complete 10123,1
.complete 10123,2
.complete 10123,3
step << Horde
.goto Hellfire Peninsula,58.0,41.2
.turnin 10123 >> 转入Felsark Ravine
.accept 10124 >> 接受前方基地：雷沃的坠落
step << Horde
.goto Hellfire Peninsula,65.8,43.6
.turnin 10124 >> 前垒转身：雷弗倒下
.accept 10208 >> 接受干扰他们的强化
step << Horde
#sticky
#label disrupttransp
.goto Hellfire Peninsula,70.8,45.1
>>一旦你得到4块符石，使用托阿奇的初级技能来禁用军团运输者。
.complete 10208,1 
step << Horde
#label disrupttransp
.goto Hellfire Peninsula,74.1,38.9
>>一旦你再收集4块符石，使用To'arch's Primers来禁用军团运输者。
.complete 10208,2 
step << Horde
#requires disrupttransp
.goto Hellfire Peninsula,65.9,43.6
.turnin 10208 >> 转入破坏他们的强化
.accept 10129 >> 接受任务：Murketh和Shaadraz网关
step << Horde
.goto Hellfire Peninsula,78.0,51.2
.complete 10129,2 
step << Horde
.goto Hellfire Peninsula,78.2,47.7
.complete 10129,1 
step << Horde
.goto Hellfire Peninsula,65.9,43.6
.turnin 10129 >> 移交任务：Murketh和Shaadraz网关
.accept 10162 >> 接受任务：深海大陆架
.accept 10388 >> 接受返回萨尔玛
step << Horde
>>当你飞越深渊大陆架时，使用52区特殊炸弹来完成这个任务。
.complete 10162,3 
.complete 10162,1 
.complete 10162,2 
step << Horde
.goto Hellfire Peninsula,65.9,43.6
.turnin 10162 >> 移交任务：深海大陆架
step << Horde
.goto Hellfire Peninsula,55.0,36.0
.turnin 10388 >> 返回萨尔玛
.accept 9400 >> 接受刺客。
step << Horde
.goto Hellfire Peninsula,33.6,43.6
>> 飞向兽人尸体
.complete 9400,1
step << Horde
.goto Hellfire Peninsula,33.6,43.6
.turnin 9400 >> 交出刺客
step << Alliance
.goto Hellfire Peninsula,87.4,50.7
.accept 10288 >> 接受到达外域
step << Alliance
.goto Hellfire Peninsula,87.4,52.4
.turnin 10288 >> 到达外域时的交车
.accept 10140 >> 接受荣誉之旅
step << Alliance
.goto Hellfire Peninsula,54.7,62.8
>> 要么再和飞行管理员谈谈，要么自己飞到荣誉舱
.skipgossip
.turnin 10140 >> 在荣誉之旅中缴械
.accept 10254 >> 接受部队指挥官Danath
step << Alliance
.goto Hellfire Peninsula,56.6,66.6
.turnin 10254 >> 接受部队指挥官Danath
.accept 10141 >> 接受军团重生
step << Alliance
.goto Hellfire Peninsula,61.7,60.7
.turnin 10141 >> 交出军团重生
.accept 10142 >> 接受痛苦之路
step << Alliance
.goto Hellfire Peninsula,67.0,58.6
>> 消灭该地区的恶魔
.complete 10142,1 
.complete 10142,2 
.complete 10142,3 
step << Alliance
.goto Hellfire Peninsula,61.7,60.7
.turnin 10142 >> 转向痛苦之路
.accept 10143 >> 接受催交点
step << Alliance
.goto Hellfire Peninsula,56.6,66.5
.accept 10047 >> 在禁区内接受来自Warp Scryer Kryv的荣耀之路。
step << Alliance
.goto Hellfire Peninsula,64.5,49.6,10,0
.goto Hellfire Peninsula,54.6,50.4,10,0
.use 25889
>> 在荣耀之路发现的被践踏的骷髅上使用德莱尼圣水。
.complete 10047,1
step << Alliance
.goto Hellfire Peninsula,56.6,66.6
.turnin 10047 >> 转向荣耀之路
step << Alliance
.goto Hellfire Peninsula,23.0,40.4
>> 前往Hellfire半岛西部
.accept 9390 >> 接受搜索Sedai。
step << Alliance
.goto Hellfire Peninsula,26.8,37.6
.turnin 9390 >> 交出寻找塞岱。
step << Alliance
.reputation 946,friendly >> 与荣誉保持友好，这样您就可以在发布时提交获得米伦的信任。通过垃圾地牢做到这一点，以减少任务损失。
step << Horde
.goto Zangarmarsh,85.2,54.6
.accept 9774 >> 接受厚水螅鳞片
step << Horde
.goto Zangarmarsh,84.1,39.0,80,0
.goto Zangarmarsh,85.2,54.6,80,0
.goto Zangarmarsh,80.1,34.3,80,0
.goto Zangarmarsh,81.0,41.3
>> 杀死该地区的九头蛇并掠夺其鳞片。
*They do NOT share spawns with the Giants.
.complete 9774,1
step << Horde
.goto Zangarmarsh,85.2,54.6
.turnin 9774 >> 交上厚水螅鳞片
step
.goto Zangarmarsh,78.4,62.0
.accept 9716 >> 接受乌姆布拉芬湖的干扰
step
.goto Zangarmarsh,70.8,81.3
.complete 9716,1
step
.goto Zangarmarsh,78.4,62.0
.turnin 9716 >> Umbrafen湖的转弯干扰
.accept 9718 >> 当乌鸦飞翔时接受
step
.goto Zangarmarsh,78.4,62.0
.use 25465 >> 使用风暴护身符，等待任务完成。需要2分30秒，稍作伸展休息：）
.complete 9718,1
step
.goto Zangarmarsh,78.4,62.0
.turnin 9718 >> 乌鸦飞翔时转身
.accept 9720 >> 必须保留接受余额
step << skip
#label schemmy
.itemcount 24330,1
.use 24330 >> 使用包中的排水示意图接受任务
.accept 9731 >> 接受排放示意图
step
.goto Zangarmarsh,70.6,80.3
.use 24355 >> 使用铁藤种子禁用Umbrafen Lake的控制台。
.complete 9720,1
step
.goto Zangarmarsh,25.2,43.6
.use 24355 >> 使用铁藤种子禁用马歇尔莱克的控制台。
.complete 9720,2
step << skip
#requires schemmy
.itemcount 24330,1
.goto Zangarmarsh,50.4,40.9
>> 探索足够深的排水沟以完成任务。
.complete 9731,1
step
.goto Zangarmarsh,62.0,40.8
.use 24355 >> 使用铁藤种子在蛇湖禁用。
.complete 9720,3
step
.goto Zangarmarsh,63.1,64.1
.use 24355 >> 使用铁藤种子在泻湖禁用。
.complete 9720,4
step
.goto Zangarmarsh,78.4,62.0
.turnin 9720 >> 必须保持上缴余额
step << skip
#requires schemmy
.itemcount 24330,1
.goto Zangarmarsh,78.4,62.0
.turnin 9731 >> 转向排水示意图
step
#label thickysticky
.goto Terokkar Forest,44.4,26.2 
.accept 9968 >> 接受奇异能量。
.accept 9971 >> 接受灌木丛中的线索。
step
#sticky
#requires thickysticky
.goto Terokkar Forest,45.1,21.8,40,0
.goto Terokkar Forest,44.4,30.8,40,0
.goto Terokkar Forest,45.1,21.8
>> 杀死Terromoth和Vicious Terromotth以获取样本。
*Terromoths spawn on the south side, Vicious Terrormoths spawn north in the village.
.complete 9968,2
.complete 9968,1
step
.goto Terokkar Forest,45.1,21.8
>> 与客栈地板上的奇怪物体互动。
.complete 9971,1
step
#requires thickysticky
.goto Terokkar Forest,44.4,26.2 
.turnin 9968 >> 交出奇异能量。
.turnin 9971 >> 在灌木丛中交出线索。

step
.goto Terokkar Forest,44.4,26.2 
.accept 9978 >> 以任何必要的方式接受。
step
.goto Terokkar Forest,38.3,26.6,80,0
.goto Terokkar Forest,50.3,29.0,80,0
.goto Terokkar Forest,38.3,26.6
.line Terokkar Forest,38.3,26.6,40.6,25.5,47.2,27.0,50.3,29.0
.skipgossip
>>在路上找到Empoor，和他战斗，说服他告诉你他知道什么。
.unitscan Empoor
.turnin 9978 >> 以任何必要的方式提交并接受。
.accept 9979 >> 接受Wind Trader Lathrai。
step << Horde
.goto Terokkar Forest,48.8,45.6
.accept 10000 >> 接受不受欢迎的状态
step << Horde
.goto Terokkar Forest,67.4,51.8
>> 杀死该地区的翘皮狮子
.complete 10000,1 
step << Horde
.goto Terokkar Forest,63.4,42.6
.turnin 10000 >> 提交不受欢迎的状态
step << Alliance
.goto Terokkar Forest,58.2,54.8
.accept 9998 >> 接受不规则的邻居
step << Alliance
.goto Terokkar Forest,67.4,51.8
>> 杀死该地区的翘皮狮子
.complete 9998,1 
step << Alliance
.goto Terokkar Forest,69.6,44.2
.turnin 9998 >> 交出不守规矩的邻居
step
.goto Shattrath City,72.4,31.6
.turnin 9979 >> 交给Wind Trader Lathrai。
.accept 10112 >> 接受个人恩惠。
step
.goto Terokkar Forest,31.6,42.6
>> 杀死并抢劫斯基提亚暴徒的赃物。
.complete 10112,1
step
.goto Shattrath City,72.2,30.9
.turnin 10112 >> 交出个人喜好。
step
.goto Shattrath City,72.2,30.9
.accept 9990 >> 接受调查问卷。
step
>> 在废墟中收集密封的盒子。
.goto Terokkar Forest,54.0,30.0
.complete 9990,1
step << Horde
.goto Terokkar Forest,44.4,26.2 
.turnin 9990 >> 上交Investigate Tuurem。
.accept 9995 >> 接受这些是什么？
step << Alliance
.goto Terokkar Forest,44.4,26.2 
.turnin 9990 >> 上交Investigate Tuurem。
.accept 9994 >> 接受这些是什么？
step << Horde
.goto Terokkar Forest,50.0,45.8
.turnin 9995 >> 交上来这些是什么？
.accept 10448 >> 接受向碎石者营地的报告。
step << Horde
.goto Terokkar Forest,50.0,44.8
.accept 9993 >> 接受Olemba籽油。
step << Horde
#sticky
#completewith endofseedoil
#label seedoil
>> 在特罗卡森林的树木周围收集木兰籽。
* They look like little blue crystals.
.complete 9993,1
step << Horde
.goto Terokkar Forest,63.2,42.4
.turnin 10448 >> 向碎石营地提交报告。
.accept 9997 >> 接受对发射点的攻击。
step << Alliance
.goto Terokkar Forest,57.0,53.6
.turnin 9994 >> 交上来这些是什么？
.accept 10444 >> 接受Allerian Post的报告。
step << Alliance
.goto Terokkar Forest,69.6,44.0
.turnin 10444 >> 向Allerian Post提交报告。
.accept 9996 >> 接受对发射点的攻击。
step << Alliance
.goto Terokkar Forest,71.6,37.8
>> 杀死火翼防御者、血矮人和术士。
.complete 9996,1
.complete 9996,2
.complete 9996,3
step << Horde
.goto Terokkar Forest,71.6,37.8
>> 杀死火翼防御者、血矮人和术士。
.complete 9997,1
.complete 9997,2
.complete 9997,3
step << Alliance
.goto Terokkar Forest,69.6,44.0
.turnin 9996 >> 攻击射击点。
.accept 10446 >> 接受最终代码。
step << Horde
.goto Terokkar Forest,63.2,42.4
.turnin 9997 >> 攻击射击点。
.accept 10447 >> 接受最终代码。
step
#sticky
#completewith endofseedoil
.goto Terokkar Forest,73.6,36.0
>> 飞到塔顶
step << Alliance
.goto Terokkar Forest,73.8,35.8
>> 杀掉莎斯·沃尔登以获得最终密码。
.collect 29912,1,10446,1
step << Horde
.goto Terokkar Forest,73.8,35.8
>> 杀掉莎斯·沃尔登以获得最终密码。
.collect 29912,1,10447,1
step << Horde
.goto Terokkar Forest,71.3,37.4
.use 29912 >> 点击Firewing Point中心的柱子
.complete 10447,1
step << Alliance
.goto Terokkar Forest,71.3,37.4
.use 29912 >> 点击Firewing Point中心的柱子
.complete 10446,1
step << Horde
.goto Terokkar Forest,50.0,45.8
.turnin 10447 >> 提交最终代码。
step << Alliance
.goto Terokkar Forest,57.0,53.5
.turnin 10446 >> 提交最终代码。
step << Horde
#requires seedoil
.goto Terokkar Forest,50.1,44.9
.turnin 9993 >> 加入Olemba籽油。
step
#label endofseedoil
.goto Terokkar Forest,49.8,76.2
.accept 10920 >> 接受堕落者。
step
.goto Terokkar Forest,51.8,78.8,30,0
.goto Terokkar Forest,55.6,61.2
>> 沿着骨废料的边缘杀死恐惧方寡妇。
.complete 10920,1
step
.goto Terokkar Forest,49.8,76.2
.turnin 10920 >> 为堕落者而自首。
.accept 10921 >> 接受Terokkarantula。
step
.goto Terokkar Forest,54.0,81.6
>> 杀死特洛克卡兰图拉。这是一个精英任务，你可能需要帮助。
.complete 10921,1
step
.goto Terokkar Forest,49.8,76.2
.turnin 10921 >> 转入Terokkarantula。
step
.goto Terokkar Forest,35.0,65.2
>> 在奥切奈地穴入口附近找到哈雷。
.accept 10227 >> 接受我看到了死亡的德雷尼。
step
.goto Terokkar Forest,35.1,66.0
.turnin 10227 >> 交给我，我看见了死亡的德雷尼。
.accept 10228 >> 接受以西结。
step << Horde
.goto Nagrand,55.6,37.6
>> 前往纳格朗
.accept 9888 >> 接受无能的领导者。
step << Horde
.goto Terokkar Forest,19.8,60.8
.turnin 9888 >> 交出无能的领导人。
.accept 9889 >> 接受不要杀死胖人。
step << Horde
.goto Terokkar Forest,19.8,62.6
>> 杀死10名巨石拳入侵者。不要和无情的乌克尔战斗。
.complete 9889,1
step << Horde
.goto Terokkar Forest,20.0,63.4
>> 殴打Unkor直到他提交。
.complete 9889,2
.turnin 9889 >> 上车不要杀胖人。
.accept 9890 >> 接受成功！
step << Horde
.goto Terokkar Forest,19.6,60.8
.turnin 9890 >> 成功交出！
.accept 9891 >> 接受，因为基拉斯是胆小鬼。
step << Horde
.goto Nagrand,55.6,37.6
.turnin 9891 >> 因为基拉思是个胆小鬼，所以要上车。
.accept 9906 >> 在战斗中接受信息。
step << Horde
.goto Nagrand,76.4,61.6,20,0
.goto Nagrand,74.6,69.6
>> 杀死巨石拳食人魔。
.complete 9906,1
.complete 9906,2
step << Horde
.goto Nagrand,55.6,37.6
.turnin 9906 >> 在战斗中交出信息。
.accept 9907 >> 接受大胆的前进。
step << Horde
.goto Nagrand,49.6,56.4
.goto Nagrand,40.8,31.6
>> 杀死巨石拳食人魔。
.complete 9907,1
.complete 9907,2
step << Horde
.goto Nagrand,55.6,37.6
.turnin 9907 >> 大胆前进。
.accept 10107 >> 接受外交措施。
step << Horde
.goto Nagrand,73.8,62.6
>> 与Lantressor对话
.skipgossip
.turnin 10107 >> 提交外交措施。
.accept 9928 >> 接受武器欺骗。
.accept 9927 >> 接受无情的狡猾。
step << Horde
.goto Nagrand,69.4,81.4
>> 从堡垒周围的箱子里捡起基尔索洛武器。
.complete 9928,1
>> 杀死基尔的敌人，在他们的尸体上贴上横幅。你不必瞄准尸体。
.use 25552
.complete 9927,1
step << Horde
.goto Nagrand,73.8,62.6
.turnin 9928 >> 缴械以防欺骗。
.turnin 9927 >> 交给无情的狡猾。
.accept 9931 >> 接受退货优惠。
.accept 9932 >> 接受证据主体。
step << Horde
.goto Nagrand,54.8,39.8
.accept 9864 >> 接受失踪的战争党。
step << Horde
#sticky
.goto Nagrand,46.7,24.3
>> 站在柴堆旁边时，使用湿羊毛毯。
* Boulderfist Saboteurs will spawn, protect them if any ogres aggro to them.
.use 25658
.complete 9932,1
step << Horde
.goto Nagrand,46.0,20.2
>> 杀死Warmaul食人魔，在他们的尸体上贴上横幅。你不必瞄准尸体。
.use 25555
.complete 9931,1
step << Horde
.goto Nagrand,32.4,36.0
.turnin 9864 >> 交出失踪的战争党。
.accept 9865 >> 接受曾经的勇士。
step << Horde
.goto Nagrand,73.8,62.6
.turnin 9931 >> 交《还情》。
.turnin 9932 >>	提交证据。
step << Horde
.goto Nagrand,32.6,42.6
>> 杀死黑血清道夫和掠夺者。
.complete 9865,1
.complete 9865,2
step << Horde
.goto Nagrand,32.4,36.0
.turnin 9865 >> 交出曾经的勇士。
step << Alliance
.goto Nagrand,55.0,70.6
.accept 9917 >> 接受我的眼睛欺骗我。
step << Alliance
.goto Nagrand,62.8,72.4
>> 为计划杀死巨石拳猎人。
.complete 9917,1
step << Alliance
.goto Nagrand,55.0,70.6
.turnin 9917 >> 我的眼睛欺骗了我。
.accept 9918 >> 不接受我的监视！
step << Alliance
.goto Nagrand,62.6,71.6
>> 殴打Lump直到他投降，然后和他说话。
.skipgossip
.complete 9918,1
step << Alliance
.goto Nagrand,55.0,70.6
.turnin 9918 >> 不要在我的手表上睡觉！
.accept 9920 >> 接受Mo'mor the Breaker。
step << Alliance
.goto Nagrand,54.6,72.2
.turnin 9920 >> 将Mo'mor交给断路器。
.accept 9921 >> 接受燃烧之刃的废墟。
step << Alliance
.goto Nagrand,74.6,68.6,40,0
>> 杀死营地周围的巨石拳食人魔
.complete 9921,1
.complete 9921,2
step << Alliance
.goto Nagrand,54.6,72.2
.turnin 9921 >> 交出燃烧之刃的废墟。
.accept 9922 >> 接受Nagrand的双胞胎裂缝。
step << Alliance
.goto Nagrand,50.2,56.8,40,0
.goto Nagrand,40.8,31.6,40,0
>> 杀死营地周围的巨石拳食人魔
.complete 9922,1
.complete 9922,2
step << Alliance
.goto Nagrand,54.6,72.2
.turnin 9922 >> 交上《纳格朗的双夹板》。
.accept 10108 >> 接受外交措施。
step << Alliance
.goto Nagrand,55.4,68.8
.accept 11044 >> 接受毁灭的愿景
step << Alliance
.goto Nagrand,73.8,62.6
>> 与Lantresor交谈。
.skipgossip
.complete 10108,1
.turnin 10108 >> 提交外交措施。
.accept 9928 >> 接受武器欺骗。
.accept 9927 >> 接受无情的狡猾。
step << Alliance
.goto Nagrand,69.4,81.4
>> 从堡垒周围的箱子里捡起基尔索洛武器。
.complete 9928,1
>> 杀死基尔索洛的敌人并种植横幅。
.use 25552
.complete 9927,1
step << Alliance
.goto Nagrand,73.8,62.6
.turnin 9928 >> 缴械以防欺骗。
.turnin 9927 >> 交给无情的狡猾。
.accept 9931 >> 接受退货优惠。
.accept 9932 >> 接受证据主体。
step << Alliance
#sticky
.goto Nagrand,46.7,24.3
>> 站在柴堆旁边时，使用湿羊毛毯。一旦破坏者产卵，保护他们。
.use 25658
.complete 9932,1
step << Alliance
.goto Nagrand,46.0,20.2
>> 杀死Warmaul食人魔并种植横幅。
.use 25555
.complete 9931,1
step << Alliance
.goto Nagrand,73.8,62.6
.turnin 9931 >> 交《还情》。
.turnin 9932 >>	提交证据。
step
.goto Nagrand,27.4,43.0
>> 确保您已下马。
.accept 9991 >> 接受土地勘测。
step
>> 飞行时侦察锻造营地。这大约需要2分钟，可以自由起身伸展：D
.complete 9991,1
.turnin 9991 >> 交验土地。
.accept 9999 >> 接受购买时间。
step
.goto Nagrand,24.4,37.4,30,0
.goto Nagrand,19.6,51.4
>> 杀死锻造营地周围的恶魔。这是一个精英任务，你可能需要帮助。
.complete 9999,1
.complete 9999,2
.complete 9999,3
step
.goto Nagrand,27.4,43.0
.turnin 9999 >> 提交购买时间。
.accept 10001 >> 接受主计划员。
step
.goto Nagrand,23.6,34.8
>> 杀死莫阿尔格总规划师以获得蓝图。
.complete 10001,1
step
.goto Nagrand,27.4,43.0
.turnin 10001 >> 交上总策划师。
.accept 10004 >> 接受耐心和理解。
step
.goto Shattrath City,77.2,34.8
.skipgossip
>> 前往沙塔斯。与萨尔萨拉宾谈谈，与他战斗。 << !Mage
>> 传送到沙塔斯。与萨尔萨拉宾谈谈，与他战斗。 << Mage
.turnin 10004 >> 耐心和理解。
.accept 10009 >> 接受敲碎一些头骨。
step
.goto Shattrath City,75.0,31.8
.skipgossip
>> 向醉汉雷利克讨债。
.complete 10009,1
step
.goto Shattrath City,61.2,49.6
>> 找到以西结，逆时针绕着建筑走。
.unitscan Ezekiel
.turnin 10228 >> 交给以西结。
.accept 10231 >> 接受什么书？我没有看到任何书。
step
.goto Shattrath City,43.6,29.4
.skipgossip
>> 去打败肮脏的拉里。如果他死了，你可能需要等待他重生。
* He is an elite, you may need help.
.complete 10231,1
step
.goto Shattrath City,43.6,29.4
.turnin 10231 >> 交什么书？我没有看到任何书。
step
.goto Zangarmarsh,81.0,91.6
.skipgossip
>> 从库什库什那里得到债务。
.complete 10009,2
step << Alliance
.goto Shadowmoon Valley,39.4,53.6
.turnin 11044 >> 交出毁灭的愿景
.accept 10562 >> 接受围困！
step << Alliance
.goto Shadowmoon Valley,36.4,56.8
.accept 10680 >> 接受古尔丹的手
step << Alliance
.goto Shadowmoon Valley,38.8,54.2
.accept 10569 >> 接受Skethlon残骸
step << Alliance
.goto Shadowmoon Valley,39.0,50.0
>> 向北去杀了地狱，守卫周围的人并不总是值得称赞
.complete 10562,1 
step << Alliance
.goto Shadowmoon Valley,39.4,53.6
.turnin 10562 >> 被围起来！
.accept 10563 >> 接受军团控制
step << Alliance
.goto Shadowmoon Valley,23.4,36.8
.use 30638 >> 使用“诡计盒”在通信设备旁伪装自己。这个角色扮演大约需要一分钟。
.complete 10563,1 
step << Alliance
.goto Shadowmoon Valley,39.4,53.6
.turnin 10563 >> 转入军团据点
.accept 10572 >> 接受设置炸弹
step << Alliance
.goto Shadowmoon Valley,26.2,41.1,40,-1
.goto Shadowmoon Valley,22.2,35.4,40,-1
>> 从地面上掠夺恶魔收割者能量核心和装甲板。电源核心在水下。
.complete 10572,1 
.complete 10572,2 
step << Alliance
.goto Shadowmoon Valley,39.4,53.6
.turnin 10572 >> 投掷炸弹
.accept 10564 >> 接受爆炸地狱！
step << Alliance
.goto Shadowmoon Valley,22.6,39.9
.use 30614 >> 使用绿色圆圈中的炸弹。如果你没有马上看到它，它每5秒就会脉冲一次。
.complete 10564,1 
step << Alliance
.goto Shadowmoon Valley,39.4,53.6
.turnin 10564 >> 转身冲向地狱
.accept 10573 >> 接受死亡锻造
step << Alliance
.goto Shadowmoon Valley,40.4,41.4
.turnin 10573 >> 交给死亡熔炉
.accept 10582 >> 接受影子议会的小黄人
step << Alliance
.goto Shadowmoon Valley,40.0,39.0
>> 冲进洞穴，杀死该地区的死亡堡敌人
.complete 10582,1 
.complete 10582,2 
step << Alliance
.goto Shadowmoon Valley,40.4,41.4
>> 返回塔楼
.turnin 10582 >> 交出影子议会的小黄人
.accept 10583 >> 接受Flanis的命运
.accept 10585 >> 接受召唤室
step << Alliance
#sticky
#label elementald2
.goto Shadowmoon Valley,40.0,39.0
>> 杀死死亡堡史密斯和修补匠。掠夺他们作为元素置换器
.collect 30672,1,10585,1
step << Alliance
.goto Shadowmoon Valley,40.0,38.0,60,0
.goto Shadowmoon Valley,34.0,39.0
>> 返回下面的洞穴。继续穿过大桥，然后向右穿过地狱。与Flanis的尸体交谈
.unitscan Flanis
.skipgossip
.collect 30658,1,10583,1
step << Alliance
#requires elementald2
.goto Shadowmoon Valley,37.0,38.0
.use 30672 >> 前往低层，然后使用元素置换器扰乱召唤师斯卡塔克斯所在的仪式
.unitscan Summnoner Skartax
.complete 10585,1 
step << Alliance
.goto Shadowmoon Valley,40.4,41.4
>> 返回塔楼
.turnin 10583 >> 交出弗拉尼斯的命运
.turnin 10585 >> 进入召唤室
.accept 10586 >> 接受击倒战使！
step << Alliance
.goto Shadowmoon Valley,39.0,46.0,20,0
.goto Shadowmoon Valley,37.4,42.6
.use 30688 >> 返回上层洞穴，穿过大桥，然后用钥匙打开左侧的门廊。杀死房间后面的战使拉祖恩，并为他的命令洗劫他。
.unitscan Warbringer Razuun
.complete 10586,1 
.collect 30689,1,10586,1
step << Alliance
.goto Shadowmoon Valley,39.4,53.6
.turnin 10586 >> 来吧，把战使打倒！
.accept 10589 >> 接受获取访问权限
step << Alliance
.goto Shadowmoon Valley,42.2,45.0
.turnin 10680 >> 交给古尔丹
.accept 10458 >> 接受火与土的激怒灵魂
step << Alliance
.goto Shadowmoon Valley,46.7,46.1
.use 30094 >>使用精灵图腾，杀死图腾旁边的火/土元素。
*The range is around 25 yards for the totem to work.
.complete 10458,1 
.complete 10458,2 
step << Alliance
.goto Shadowmoon Valley,42.1,45.1
.turnin 10458 >> 交出火与土的激怒灵魂
.accept 10480 >> 接受激怒的水灵
step << Alliance
.goto Shadowmoon Valley,51.4,27.5
.use 30094 >>使用你袋子里的精灵图腾，杀死图腾旁边的水元素
*The range is around 25 yards for the totem to work.
.complete 10480,1 
step << Alliance
.goto Shadowmoon Valley,42.2,45.1
.turnin 10480 >> 交出激怒的水灵
.accept 10481 >> 接受空气中的愤怒灵魂
step << Alliance
.goto Shadowmoon Valley,60.8,66.6
.use 30094 >>使用你袋子里的精灵图腾，杀死图腾旁边的空气元素。一些元素也可以在北方的尼日翼原野产卵。
*The range is around 25 yards for the totem to work.
.complete 10481,1 
step << Alliance
.goto Shadowmoon Valley,42.3,45.0
.turnin 10481 >> 交出愤怒的空气精灵
.accept 10513 >> 接受Oronok破碎的心
step << Alliance
.goto Shadowmoon Valley,22.4,33.4
>> 杀死莫阿尔格兵器匠，并将其掠夺以控制军团的电信员
.collect 30695,1,10589,1
step << Alliance
.goto Shadowmoon Valley,37.4,30.4
>> 杀死该地区的黑暗秘会暴徒并掠夺他们的日记页
.complete 10569,1 
.complete 10569,2 
.complete 10569,3 
step << Alliance
.goto Shadowmoon Valley,39.4,53.6
.turnin 10589 >> 转入获取访问权限
.accept 10766 >> 接受入侵点：灾难
step << Alliance
.goto Shadowmoon Valley,38.8,54.2
.turnin 10569 >> 交上Skethlon残骸
.accept 10759 >> 接受寻找沙漠者
step << Alliance
.goto Shadowmoon Valley,35.4,41.8
.turnin 10759 >> 转入寻找沙漠者
.accept 10777 >> 接受阿斯加尔的图腾
step << Alliance
.goto Shadowmoon Valley,40.0,30.8
>> 找到Asghar，杀掉并抢劫他的图腾
.unitscan Asghar
.complete 10777,1 
step << Alliance
.goto Shadowmoon Valley,40.8,22.2
.turnin 10766 >> 转入入侵点：灾难
.accept 10606 >> 接受Fell Reaver维护的艺术
step << Alliance
.goto Shadowmoon Valley,39.6,19.6
>> 杀死古特里克医生，抢走他的钥匙。
.unitscan Doctor Gutrick
.collect 30712,1,10606,1
step << Alliance
.goto Shadowmoon Valley,39.6,19.6
.use 30712 >>使用钥匙打开医生保险箱，检索《收割者维护艺术》
.collect 30713,1,10606,1
step << Alliance
.goto Shadowmoon Valley,40.8,22.2
.turnin 10606 >> 交付Fell Reaver维护的艺术
.accept 10612 >> 接受恶魔和狂暴
step << Alliance
.goto Shadowmoon Valley,40.8,22.2
>> 使用地狱收割者控制台摧毁60个死亡锻造地狱
.complete 10612,1 
step << Alliance
.goto Shadowmoon Valley,40.8,22.2
.turnin 10612 >> 交出《恶魔与狂暴》
step << Horde
.goto Shadowmoon Valley,30.4,32.4
.accept 10595 >> 接受围困！
step << Horde
.goto Shadowmoon Valley,29.8,27.8
.accept 10624 >> 接受一段闹鬼的历史
step << Horde
.goto Shadowmoon Valley,31,29.8
.accept 10760 >> 接受Sketh'lon残骸
step << Horde
#sticky
#completewith next
>> 在杀死无间道袭击者的同时掠夺燃烧着的灰烬堆
.complete 10624,1 
step << Horde
.goto Shadowmoon Valley,32.0,32.0,80,0
.goto Shadowmoon Valley,30.7,36.2,60,0
.goto Shadowmoon Valley,32.0,32.0
>> 杀死无间道攻击者
.complete 10595,1 
step << Horde
.goto Shadowmoon Valley,32.2,38.1,60,0
>> 完成对不断燃烧的灰堆的掠夺
.complete 10624,1 
step << Horde
.goto Shadowmoon Valley,37.4,30.4
>> 杀死该地区的黑暗秘会暴徒并掠夺他们的日记页
.complete 10760,1 
.complete 10760,2 
.complete 10760,3 
step << Horde
.goto Shadowmoon Valley,29.8,27.8
.turnin 10624 >> 交出闹鬼的历史
.accept 10625 >> 接受斑点
step << Horde
.goto Shadowmoon Valley,29.8,27.8
.use 30719 >> 戴上护目镜，杀死镇上的幽灵
.complete 10625,1 
step << Horde
.goto Shadowmoon Valley,29.8,27.8
>> 确保重新装备您的普通头盔
.turnin 10625 >> 交给Spectercles
step << Horde
.goto Shadowmoon Valley,31.0,29.8
.turnin 10760 >> 交出Sketh'lon残骸
.accept 10761 >> 接受寻找沙漠者
step << Horde
.goto Shadowmoon Valley,30.4,32.4
.turnin 10595 >> 被围起来！
.accept 10596 >> 接受军团控制
step << Horde
.goto Shadowmoon Valley,23.4,36.8
.use 30638 >> 使用“诡计盒”在通信设备旁伪装自己。这个角色扮演大约需要一分钟。
.complete 10596,1 
step << Horde
.goto Shadowmoon Valley,30.4,32.4
.turnin 10596 >> 转入军团据点
.accept 10597 >> 设置炸弹
step << Horde
.goto Shadowmoon Valley,26.2,41.1,20,-1
.goto Shadowmoon Valley,22.2,35.4,20,-1
>> 掠夺恶魔收割者能量核心和装甲板。电源核心在水下。
.complete 10597,1 
.complete 10597,2 
step << Horde
.goto Shadowmoon Valley,30.4,32.4
.turnin 10597 >> 投掷炸弹
.accept 10598 >> 接受爆炸地狱！
step << Horde
.goto Shadowmoon Valley,22.6,39.9
.use 30614 >> 使用绿色圆圈中的fel炸弹。如果你没有马上看到它，它每5秒就会脉冲一次。
.complete 10598,1 
step << Horde
.goto Shadowmoon Valley,30.4,32.4
.turnin 10598 >> 转身向地狱狂轰乱炸！
.accept 10599 >> 接受死亡锻造
step << Horde
.goto Shadowmoon Valley,38.6,38.2
>> 向屋顶走去
.turnin 10599 >> 交给死亡熔炉
.accept 10600 >> 接受影子议会的小黄人
step << Horde
.goto Shadowmoon Valley,40.0,39.0
>> 冲进洞穴，杀死该地区的死亡堡敌人
.complete 10600,1 
.complete 10600,2 
step << Horde
.goto Shadowmoon Valley,38.6,38.2
.turnin 10600 >> 交出影子议会的小黄人
.accept 10601 >> 接受卡格罗斯的命运
.accept 10602 >> 接受召唤圈
step << Horde
#sticky
#label elementald
.goto Shadowmoon Valley,40.0,39.0
>> 杀死死亡堡史密斯和修补匠。掠夺他们作为元素置换器
.collect 30672,1,10602,1
step << Horde
.goto Shadowmoon Valley,40.0,39.0,40,0
.goto Shadowmoon Valley,35.2,40.1
.unitscan Kagrosh
.skipgossip
>> 返回下面的洞穴。继续穿过大桥，然后向右穿过地狱。与兽人的尸体对话并带走他的背包
.collect 30659,1,10601,1
step << Horde
#requires elementald
.goto Shadowmoon Valley,37.0,38.0
.use 30672 >> 前往低层，然后使用元素置换器扰乱召唤师斯卡塔克斯所在的仪式
.unitscan Summnoner Skartax
.complete 10602,1 
step << Horde
.goto Shadowmoon Valley,38.6,38.2
>> 返回塔顶外侧
.turnin 10601 >> 交出卡格罗斯的命运
.turnin 10602 >> 进入召唤圈
.accept 10603 >> 接受击倒战使！
step << Horde
.goto Shadowmoon Valley,40.0,39.0,40,0
.goto Shadowmoon Valley,38.9,46.7
.use 30688 >> 回到你杀死史密斯和修补匠的洞穴。用钥匙打开房间左侧的门廊，然后杀死战使拉祖并为他的命令洗劫他。
.unitscan Warbringer Razuun
.complete 10603,1 
.collect 30689,1,10603,1
step << Horde
>> 返回塔楼
.goto Shadowmoon Valley,30.4,32.4
.turnin 10603 >> 交出击倒战争使者
.accept 10604 >> 接受获取访问权限
step << Horde
.goto Shadowmoon Valley,35.4,41.8
.turnin 10761 >> 转入寻找沙漠者
.unitscan Parshah
.accept 10777 >> 接受阿斯加尔的图腾
step << Horde
.goto Shadowmoon Valley,40.0,30.8
>> 找到Asghar，杀掉并抢劫他的图腾
.unitscan Asghar
.complete 10777,1 
step << Horde
.goto Shadowmoon Valley,28.4,26.6
.accept 10681 >> 接受古尔丹的手
step << Horde
.goto Shadowmoon Valley,42.2,45.0
.turnin 10681 >> 交给古尔丹
.accept 10458 >> 接受火与土的激怒灵魂
step << Horde
.goto Shadowmoon Valley,46.7,46.1
.use 30094 >>使用精灵图腾，杀死图腾旁边的火/土元素。
*The range is around 25 yards for the totem to work.
.complete 10458,1 
.complete 10458,2 
step << Horde
.goto Shadowmoon Valley,42.1,45.1
.turnin 10458 >> 交出火与土的激怒灵魂
.accept 10480 >> 接受激怒的水灵
step << Horde
.goto Shadowmoon Valley,51.4,27.5
.use 30094 >>使用你袋子里的精灵图腾，杀死图腾旁边的水元素
*The range is around 25 yards for the totem to work.
.complete 10480,1 
step << Horde
.goto Shadowmoon Valley,42.2,45.1
.turnin 10480 >> 交出激怒的水灵
.accept 10481 >> 接受空气中的愤怒灵魂
step << Horde
.goto Shadowmoon Valley,60.8,66.6
.use 30094 >>使用你袋子里的精灵图腾，杀死图腾旁边的空气元素。一些元素也可以在北方的尼日翼原野产卵。
*The range is around 25 yards for the totem to work.
.complete 10481,1 
step << Horde
.goto Shadowmoon Valley,42.3,45.0
.turnin 10481 >> 交出愤怒的空气精灵
.accept 10513 >> 接受Oronok破碎的心
step << Horde
.goto Shadowmoon Valley,22.4,33.4
>> 杀死莫阿尔格兵器匠，并将其掠夺以控制军团的电信员
.collect 30695,1,10604,1
step << Horde
.goto Shadowmoon Valley,30.4,32.4
.turnin 10604 >> 转入获取访问权限
.accept 10767 >> 接受入侵点：灾难
step << Horde
.goto Shadowmoon Valley,27.4,21.2
.turnin 10767 >> 转入入侵点：灾难
.accept 10611 >> 接受Fell Reaver维护的艺术
step << Horde
.goto Shadowmoon Valley,28.9,20.6
>> 杀死Maleficus医生，并抢劫他以获取医生的钥匙。
.unitscan Doctor Maleficus
.collect 30712,1,10611,1
step << Horde
.goto Shadowmoon Valley,38.9,20.5
.use 30712 >>使用钥匙打开医生保险箱，检索《收割者维护艺术》
.collect 30713,1,10611,1
step << Horde
.goto Shadowmoon Valley,27.4,21.2
.turnin 10611 >> 交付Fell Reaver维护的艺术
.accept 10613 >> 接受恶魔和狂暴
step << Horde
.goto Shadowmoon Valley,27.8,19.8
>> 使用地狱收割者控制台摧毁60个死亡锻造地狱
* Using the first Fel Reaver ability destroys the Infernals, the rest of the buttons are rather irrelevant.
.complete 10613,1 
step << Horde
.goto Shadowmoon Valley,27.4,21.2
.turnin 10613 >> 交出《恶魔与狂暴》
step
.goto Shadowmoon Valley,54.0,23.6
.turnin 10513 >> 交给Oronok破碎的心
.accept 10514 >> 接受我是很多事情。。。
step
.goto Shadowmoon Valley,54.0,16.0
.use 30462 >>站在地上的小植物上，用公猪的口哨让附近的公猪挖出块茎。然后单击它。
* You may need to kill Flayers in the area, so they stop killing the boars near tubers.
.complete 10514,1 
step
.goto Shadowmoon Valley,53.9,23.5
.turnin 10514 >> 交了很多东西。。。
.accept 10515 >> 接受经验教训
step
.goto Shadowmoon Valley,56.6,17.0
>>摧毁该区域周围的蛋，小心巡逻该区域的大型精英暴徒
.complete 10515,1 
step
.goto Shadowmoon Valley,53.9,23.4
.turnin 10515 >> 交上所学的课程
.accept 10519 >> 接受诅咒的密码-真相与历史
>> 与Oronok交谈
.skipgossip
.complete 10519,1 
step
.goto Shadowmoon Valley,53.9,23.4
.turnin 10519 >> 交出诅咒的密码-真相与历史
.accept 10521 >> 接受格罗姆托尔，奥罗诺克之子
.accept 10527 >> 接受阿托尔，奥罗诺克之子
.accept 10546 >> 接受奥罗诺克之子博拉克
step
.goto Shadowmoon Valley,44.6,23.7
.turnin 10521 >> 交给格罗姆托尔，奥罗诺克之子
.accept 10522 >> 接受诅咒密码-格罗姆托尔的指控
step
.goto Shadowmoon Valley,46.0,28.2
>>杀死Nagas以获得箱子钥匙，打开箱子直到你洗劫碎片
.complete 10522,1 
step
.goto Shadowmoon Valley,44.6,23.7
.turnin 10522 >> 交出诅咒密码-格罗姆托尔的指控
step
.goto Shadowmoon Valley,35.4,41.8
.turnin 10777 >> 交出Asghar的图腾
.accept 10778 >> 接受Lianth之杖
step
.goto Shadowmoon Valley,47.5,57.3
.turnin 10546 >> 交给奥罗诺克之子博拉克
.accept 10547 >> 接受蓟头和鸡蛋。。。
step
.goto Shadowmoon Valley,45.1,57.4
>>在地上寻找腐烂的鸡蛋，要小心，因为它们会在抢劫时对你造成伤害
.complete 10547,1 
step
.goto Shattrath City,64.1,69.8
>> 前往沙塔斯。如果一切就绪，请起火，并设置为沙塔斯。
.turnin 10547 >> 蓟头和鸡蛋的交还。。。
.accept 10550 >> 接受血丝束
step
.isOnQuest 10009
.goto Terokkar Forest,27.2,57.8
.skipgossip
>> 从Floon那里获得债务。
.complete 10009,3
step
>> 返回影月谷
.goto Shadowmoon Valley,29.6,50.3
.turnin 10527 >> 交给阿托尔，奥罗诺克之子
.accept 10528 >> 接受恶魔水晶监狱
step
.goto Shadowmoon Valley,28.0,47.7
>>杀害痛苦女主人加布里萨
.complete 10528,1 
step
.goto Shadowmoon Valley,29.6,50.5
.turnin 10528 >> 移交恶魔水晶监狱
>> 等阿托死了再和他的灵魂谈谈
.accept 10537 >> 接受Lohn'goron，破碎的心之弓
step
.goto Shadowmoon Valley,30.5,50.0
>>杀死并抢劫任务给予者周围的伊利达里暴徒。
* The drop rate is very low, just keep killing
.complete 10537,1 
step
.goto Shadowmoon Valley,29.5,50.5
.turnin 10537 >> 交给洛恩戈隆，破碎的心之弓
.accept 10540 >> 接受诅咒密码-阿托尔的指控
step
.goto Shadowmoon Valley,29.5,57.5
>>当阿托尔的灵魂跟随你时，向东南方向走，在这一带走动，直到阿托尔召唤维尼拉图斯
.complete 10540,1 
>>准备好长期战斗，维尼拉斯的生命值是普通暴徒的3倍
step
.goto Shadowmoon Valley,29.5,50.6
.turnin 10540 >> 交出诅咒密码-阿托尔的指控
step
.goto Shadowmoon Valley,47.5,57.2
.turnin 10550 >> 交出一捆血丝
.accept 10570 >> 接受以抓住一个蓟头
step
.goto Shadowmoon Valley,48.9,57.4
>>在桥的尽头种上一束血丝。回到另一边，等博拉克对你低语后再去攻击。
.complete 10570,1 
step
.goto Shadowmoon Valley,47.6,57.2
.turnin 10570 >> 转身抓蓟头
.accept 10576 >> 接受影月洗牌
step
#sticky
#label liantherod
.goto Shadowmoon Valley,47.2,67.0
>> 杀死该地区的食蚀暴徒，直到他们丢下Lianthe的钥匙
.complete 10778,1 
step
.goto Shadowmoon Valley,49.6,62.2
>> 杀死并抢劫该地区的日食暴徒
.complete 10576,1 
step
#requires liantherod
.goto Shadowmoon Valley,47.5,71.7
>> 使用利安特堡垒上的钥匙，抢劫利安特的棍子
.complete 10778,2 
step
.goto Shadowmoon Valley,35.4,41.8
>> 转弯处可以从这里沿着公路巡逻
.turnin 10778 >> 交回Lianth的棍子
.accept 10780 >> 接受Sketh'lon Feathers
step
.goto Shadowmoon Valley,43.7,57.5
>> 在地上掠夺羽毛
.complete 10780,1 
step
.goto Shadowmoon Valley,47.6,57.2
.turnin 10576 >> 转入影月洗牌
.accept 10577 >> 接受伊利丹想要的，伊利丹得到。。。
step
.goto Shadowmoon Valley,46.5,71.9
.skipgossip
>>使用提供的伪装，与2个兽人守护的血精灵交谈
.complete 10577,1 
step
.goto Shadowmoon Valley,47.5,57.2
.turnin 10577 >> 交出伊利丹想要的，伊利丹得到。。。
.accept 10578 >> 接受诅咒密码-博拉克的指控
step
.goto Shadowmoon Valley,62.6,57.2
>> 杀死并抢劫黑暗者鲁尔
* You will need to group for this quest, he is very difficult.
.unitscan Ruul the Darkener
.complete 10578,1 
step
.goto Shadowmoon Valley,47.5,57.2
.turnin 10578 >> 交出诅咒密码-博拉克的指控
step
.goto Shadowmoon Valley,35.4,41.8
.turnin 10780 >> 交上斯凯思的羽毛
step
>> 返回沙塔斯。 << !Mage
>> 传送回沙塔斯 << Mage
.goto Shattrath City,77.2,34.8
.turnin 10009 >> 打开一些头骨。

step
.goto Shattrath City,59.7,41.5
.accept 10210 >> 接受A'dal
step
.goto Shattrath City,54.5,44.9
.turnin 10210 >> 交给A'dal
step
.goto Shattrath City,54.5,44.9
>> 与卡德加交谈
.accept 10211 >> 接受光明之城
step
.goto Shattrath City,48.1,42.0
>> 前往G'eras附近的二楼隧道等待。如果其他仆人在此期间到达，你可以瞄准它，它将为你完成任务。否则，您的仆人需要8分30秒才能到达。放松一下！
.complete 10211,1 
step
.goto Shattrath City,54.5,44.9
.turnin 10211 >> 在光明之城转弯
step
#label choice
#completewith aldorOrScryer
.goto Shattrath City,54.5,44.1
+ 选择效忠Aldor或Scryer。他们都给了愤怒同样数量的准备经验，所以选择你喜欢的。选择后，请手动跳过此步骤。
* If you do not see aldor or scryer specific quest steps after this, type "/reload" into your ingame chat box
step
#scryer
#label aldorOrScryer
.goto Shattrath City,54.5,44.1
.turnin 10552 >> 向清洁工递交效忠书
step
#aldor
#label aldorOrScryer
.goto Shattrath City,54.5,44.1
.turnin 10551 >> 向阿尔多献殷勤
step
#sticky
#requires choice
#completewith notofftoarea52
>> 前往荷兰风暴
* 5 other quests count as the same pre-requisite as Off to Area 52, if it's not here for you, it means you did a different pre-requisite, you can skip this step.
.goto Netherstorm,20.6,55.7
.accept 10183 >> 接受前往52区
step
#label notofftoarea52
.goto Netherstorm,32.7,64.9
.turnin 10183 >> 转入52区
step
.goto Netherstorm,32.7,64.9
.accept 10186 >> 接受你被录用了！
step
.goto Netherstorm,32.4,64.2
.accept 10265 >> 接受Consortium Crystal Collection。
step
.goto Netherstorm,31.4,66.2
.accept 10173 >> 接受大法师的杖。
step
#aldor
.goto Netherstorm,32.1,64.3
.accept 10241 >> 在马纳福堡接受分心
step
#scryer
.goto Netherstorm,32.0,64.0
.accept 10189 >> 接受Manaforge B'naar。
step
#aldor
.goto Netherstorm,26.6,68.4
>> 杀死该地区的Sunfrew敌人
.complete 10241,1 
.complete 10241,2 
step
#scryer
.goto Netherstorm,28.0,65.6
>> 杀死阿拉森上尉并为任务物品抢劫他。
.complete 10189,1
step
#scryer
.goto Netherstorm,32.0,64.0
.turnin 10189 >> 交给马纳福格·比纳尔。
.accept 10193 >> 接受高价值目标。
step
#scryer
.goto Netherstorm,25.4,71.8,100,0
.goto Netherstorm,22.0,72.7,40,0
.goto Netherstorm,25.4,71.8
>> 杀死该区域的Sunfrew敌人。
.complete 10193,1
.complete 10193,2
.complete 10193,3
step
#scryer
.goto Netherstorm,32.0,64.0
.turnin 10193 >> 提交高价值目标。
.accept 10329 >> 接受关闭Manaforge B'naar。
step
#aldor
.goto Netherstorm,32.1,64.3
.turnin 10241 >> 在Manaforge B'naar分心
.accept 10313 >> 接受测量翘曲能量
.accept 10243 >> 接受Naaru技术
step
#scryer
.goto Netherstorm,23.8,70.6
>> 杀死并掠夺法力锻炉内的监督特蕾迪斯以获得B'naar Access水晶
.collect 29366,1,10329,1
step
#scryer
.goto Netherstorm,23.2,68.1
>> 单击控制台并保护它免受技术人员的攻击。这需要2分钟。
.skipgossip
.complete 10329,1
step
#scryer
.goto Netherstorm,32.0,64.0
.turnin 10329 >> 转入“关闭马纳福格·比纳尔”（Shutting Down Manaforge B'naar）。
.accept 10194 >> 接受隐形飞行。
step
#scryer
.goto Netherstorm,33.8,64.2
.turnin 10194 >> 转入隐形飞行。
.accept 10652 >> 在敌后接受
step
#aldor
.goto Netherstorm,25.4,60.3
>>当靠近管道时，使用包中的“扭曲调整球”
.complete 10313,1 
step
#aldor
.goto Netherstorm,20.7,67.5
>>站在脚手架顶部并使用球
.complete 10313,4 
step
#aldor
.goto Netherstorm,20.3,70.9
>> 站在这根管子旁边时使用这个球体
.complete 10313,3 
step
#aldor
.goto Netherstorm,23.2,68.1
>> 进入大楼，然后点击柱子
.turnin 10243 >> 交出Naaru技术
.accept 10245 >> 接受B'naar控制台转录
step
#aldor
.goto Netherstorm,29.1,72.8
>>当靠近管道时，使用包中的“扭曲调整球”
.complete 10313,2 
step
#aldor
.goto Netherstorm,32.1,64.2
.turnin 10245 >> 提交B'naar控制台转录
.accept 10299 >> 接受关闭Manaforge B'naar
.turnin 10313 >> 转向测量翘曲能量
step
#aldor
.goto Netherstorm,23.7,70.1
>> 回到大楼里。杀死并抢劫监工
.complete 10299,2 
step
#aldor
.goto Netherstorm,23.2,68.1
.skipgossip
>>点击挂架启动关机定时器，杀死所有试图阻止它的暴徒。这需要2分钟。
.complete 10299,1 
step
#aldor
.goto Netherstorm,32.1,64.2
.turnin 10299 >> 关闭Manaforge B'naar
.accept 10321 >> 接受关闭Manaforge Coruu
.accept 10246 >> 接受对Manaforge Coruu的攻击
step
.goto Netherstorm,42.6,72.6
>> 为了水晶杀死并掠夺五角龙。
.complete 10265,1
step
.goto Netherstorm,40.8,72.6
.use 29207
>> 站在火盆旁边，用魔法粉召唤Ekkorash并杀死她。
.complete 10173,1
step
.goto Netherstorm,32.4,64.2
.turnin 10265 >> 交上Consortium Crystal Collection。
.accept 10262 >> 接受一堆Ethereals。
step
.goto Netherstorm,29.3,78.1
>> 杀死该地区的扎克西斯暴徒并掠夺他们的徽章
.collect 29209,10,10262,1
step
.goto Netherstorm,32.4,64.2
.turnin 10262 >> 交上一堆以太币
.accept 10205 >> 接受变形突袭者Nesaad
step
.goto Netherstorm,31.4,66.2
.turnin 10173 >> 交出大法师的杖。
.accept 10300 >> 接受重建员工。
step
.goto Netherstorm,28.3,79.9
>> 杀死扭曲袭击者尼萨德
.unitscan Warp-Raider Nesaad
.complete 10205,1
step
.goto Netherstorm,32.4,64.2
.turnin 10205 >> 交出曲速突袭者Nesaad
.accept 10266 >> 接受援助请求
step
#sticky
#label crystalmatrixs
.goto Netherstorm,33.1,54.4
>> 抢劫该地区地面上的红色水晶
* You can use your racial Find Treasure to track them on the minimap << Dwarf
.complete 10186,1 
step
.goto Netherstorm,33.6,54.6
>> 杀死并掠夺水晶的无身保护者和维护者。
.complete 10300,1
step
#requires crystalmatrixs
.goto Netherstorm,32.7,64.9
.turnin 10186 >> 交上来你被录用了！
step
.goto Netherstorm,31.4,66.2
.turnin 10300 >> 上缴重建员工。
step
#scryer
.goto Netherstorm,48.2,86.6
.turnin 10652 >> 在敌人后方转弯。
.accept 10197 >> 接受令人信服的伪装。
step
#scryer
.goto Netherstorm,49.0,81.6
>> 杀害和抢劫该地区的暴徒。收集部件以进行伪装。
* Researchers are inside, Guardsmen are found on the eastern side. Arcanists are on the west side.
.complete 10197,1
.complete 10197,2
.complete 10197,3
step
#scryer
.goto Netherstorm,48.2,86.6
.turnin 10197 >> 交上一个令人信服的伪装。
.accept 10198 >> 接受信息收集。
step
#scryer
>> 乔装打扮，前往马纳福格·科鲁，找到指挥官道恩福格，站在他旁边，为这次任务获得荣誉。
* You may need to wait for the Arcane Annihilator to patrol away from the door
.use 28607
.goto Netherstorm,48.2,84.0
.complete 10198,1
step
#scryer
.goto Netherstorm,48.2,86.6
.turnin 10198 >> 打开信息收集。
.accept 10330 >> 接受关闭Manaforge Coruu。
step
#scryer
.goto Netherstorm,49.0,81.6
>> 点击你的伪装，然后为她的Access Crystal杀死Overseer Seylanna，并在控制台上使用它。
.complete 10330,1
step
#scryer
.goto Netherstorm,48.2,86.6
.turnin 10330 >> 转入关闭Manaforge Coruu。
step
#aldor
#sticky
#label researcherkills
.goto Netherstorm,48.7,82.2
>> 杀死房间周围的研究人员
.complete 10246,1 
step
#aldor
.goto Netherstorm,49.0,81.5
>>杀死控制台旁边的监督员
.complete 10321,2 
step
#aldor
.goto Netherstorm,49.0,81.5
.skipgossip
>>点击挂架启动关机定时器，杀死所有试图阻止它的暴徒。在暴徒之间研磨百夫长。
* Kill Researchers in the area while waiting.
.complete 10321,1 
step
#aldor
#requires researcherkills
.goto Netherstorm,49.6,80.6
>> 走出去，杀死奥术家
.complete 10246,2 
step
.goto Netherstorm,57.4,86.2
.accept 10184 >> 接受邪恶残余。
step
.goto Netherstorm,59.4,87.4
>> 杀死麒麟湾周围的幽灵。
.complete 10184,1
step
.goto Netherstorm,57.4,86.2
.turnin 10184 >> 交出恶意残留物。
.accept 10312 >> 接受《基林瓦尔纪事》。
step
.goto Netherstorm,60.6,87.6
>> 杀死战斗法师达思里克并收集这本书。不要转动他的刀片。我们将在70-71转弯路线中使用它。
.complete 10312,1
step
.goto Netherstorm,57.4,86.2
.turnin 10312 >> 上交《基林瓦尔年鉴》。
step
#aldor
.goto Netherstorm,32.1,64.3
.turnin 10321 >> 关闭Manaforge Coruu
.turnin 10246 >> 攻击马纳福格·科鲁
.accept 10322 >> 接受关闭Manaforge Duro
.accept 10328 >> 接受Sunfrew简报
step
#scryer
.goto Netherstorm,32.0,64.0
.accept 10341 >> 接受在他们倒下时踢他们。
step
#scryer
.goto Netherstorm,59.0,66.8
>> 杀死太阳怒的敌人。百夫长通常出现在法力锻造厂的入口处。
.complete 10341,1
.complete 10341,2
.complete 10341,3
step
#scryer
.goto Netherstorm,32.0,64.0
.turnin 10341 >> 当他们倒下时，转身踢他们。
.accept 10202 >> 接受叛徒。
step
#scryer
.goto Netherstorm,26.2,41.6
.turnin 10202 >> 交一名叛徒。
.accept 10432 >> 接受筑坝证据。
step
#scryer
.goto Netherstorm,26.4,44.0
>> 前往法力锻炉下方的洞穴。为命令杀戮和掠夺恶魔。
.collect 29797,8,10432,1
step
#aldor
#sticky
#label militarymanaforge
.goto Netherstorm,58.5,63.6
>>杀死并抢劫Manaforge Duro内的Sunfrage百夫长
.complete 10328,1 
step
#aldor
.goto Netherstorm,60.0,68.5
>>杀死并抢劫法力锻造厂南翼内的监督员阿萨内尔
.complete 10322,2 
step
#aldor
.goto Netherstorm,59.1,66.6
.skipgossip
>> 与铁塔对话，开始关闭。杀死任何试图阻止你的暴徒。
.complete 10322,1 
step
#aldor
#requires militarymanaforge
.goto Netherstorm,57.2,64.2
>> 杀死并掠夺法力锻炉周围的太阳怒魔法师
.complete 10328,2 
step
#aldor
.goto Netherstorm,32.0,64.2
.turnin 10328 >> 提交Sunfrew简报
.accept 10431 >> 接受外部援助
.turnin 10322 >> 关闭Manaforge Duro
.accept 10323 >> 接受关闭Manaforge Ara
step
#aldor
.goto Netherstorm,34.8,38.2
.turnin 10431 >> 交出外部援助
.accept 10380 >> 接受黑暗协议
step
#aldor
.goto Netherstorm,26.4,43.5
>> 杀死洞穴中的甘阿尔格和莫阿尔格恶魔
.complete 10380,1 
.complete 10380,3 
step
#aldor
.goto Netherstorm,26.4,43.5,40,0
.goto Netherstorm,28.5,39.9
>> 离开洞穴，绕着马纳福格·阿拉飞翔，寻找命运之女
* The demons don't social aggro with the blood elves if you ranged pull them.
.unitscan Daughter of Destiny
.complete 10380,2 
step
#aldor
.goto Netherstorm,34.8,38.3
.turnin 10380 >> 提交一份黑暗协议
.accept 10381 >> 不再接受阿尔多
step
#aldor
.goto Netherstorm,26.0,38.7
>> 杀死监督员Azarad。抢他去拿通道水晶。然后与塔架对话，像以前那样保护它。
*This quest can be very overwhelming compared to the previous ones, be ready and you may need help. Clear a safe space in the room beforehand.
.skipgossip
.complete 10323,2 
.complete 10323,1 
step
#aldor
.goto Netherstorm,32.0,64.2
.turnin 10381 >> 不要再把阿尔多交上来了
.accept 10407 >> 接受索克塔尔的阴影
.turnin 10323 >> 关闭Manaforge Ara
step
#aldor
.goto Netherstorm,36.2,26.4
>> 杀死并抢劫锻造大师摩格。他是精英，你可能需要帮助。
.unitscan Forgemaster Morug
.complete 10407,1 
step
#aldor
.goto Netherstorm,40.8,19.5
>> 杀死并抢劫西罗，他是精英，你可能需要帮助。
.unitscan Silroth
.complete 10407,2 
step
#scryer
.goto Netherstorm,32.0,64.0
.turnin 10432 >> 提交该死的证据。
.accept 10508 >> 接受Voren'thal的礼物。
step
#scryer
>> 从莫鲁和西罗那里获得索克塔尔石的一半。
.goto Netherstorm,36.8,27.6,10,0
.goto Netherstorm,40.8,19.4
.complete 10508,1
.complete 10508,2
step
#aldor
.goto Netherstorm,32.1,64.3
.turnin 10407 >> 交出索克塔尔的影子
step
#scryer
.goto Netherstorm,32.0,64.0
.turnin 10508 >> 为Voren'thal交一份礼物。
step << skip
#aldor
.goto Netherstorm,32.0,64.2
.accept 10263 >> 接受协助联合体。
step << skip
#scryer
.goto Netherstorm,32.0,64.2
.accept 10264 >> 接受协助联合体。
step << skip
#aldor
.goto Netherstorm,32.4,64.2
.turnin 10263 >> 协助联合体。
step << skip
#scryer
.goto Netherstorm,32.4,64.2
.turnin 10264 >> 协助联合体。
step
.goto Netherstorm,33.0,64.6
.accept 10206 >> 接受选择您的部件
step
.goto Netherstorm,28.9,77.6
>> 该地区的掠夺以太技术，它在小盒子里
.complete 10206,1 
step
.goto Netherstorm,33.0,64.6
.turnin 10206 >> 上车取你的零件
.accept 10333 >> 接受帮助Mama Wheeler。
step
.goto Netherstorm,46.4,56.4
.accept 10417 >> 接受运行诊断！
.accept 10433 >> 接受保持外观。
step
.goto Netherstorm,48.2,55.0
>> 单击支柱收集诊断结果
.complete 10417,1
step
.goto Netherstorm,46.4,56.4
.turnin 10417 >> 打开运行诊断！
.accept 10418 >> 接受与破坏者的交易。
step
.goto Netherstorm,46.6,57.0
.turnin 10266 >> 移交援助请求
.accept 10267 >> 接受正确的重新占有
step
.goto Netherstorm,56.9,63.8
>> 收集马纳福吉周围的研究设备。它们看起来像灰色的小板条箱。
.complete 10267,1
step
.goto Netherstorm,46.6,57.0
.turnin 10267 >> 正确收回
.accept 10268 >> 与王子一起接受观众
step
#sticky
#label croctimes
.goto Netherstorm,47.0,52.6
>> 杀死附近的鳄鱼。
.complete 10418,1
step
.goto Netherstorm,44.0,49.4,20,0
.goto Netherstorm,44.8,57.2,20,0
.goto Netherstorm,44.0,49.4
>> 在生态穹顶下杀死里普芳山猫，获取它们的毛皮。
.complete 10433,1
step
#requires croctimes
.goto Netherstorm,46.4,56.4
.turnin 10418 >> 与破坏者交锋。
.turnin 10433 >> 交上来保持形象。
step
.goto Netherstorm,46.6,56.6
.turnin 10333 >> 交给Help Mama Wheeler。
.accept 10234 >> 接受一个恶魔的垃圾。。。
step
.goto Netherstorm,50.4,58.9
>> 收集该区域周围的Fel reaver部件。
.complete 10234,1
step
.goto Netherstorm,46.6,56.6
.turnin 10234 >> 交出一个恶魔的垃圾。。。
.accept 10235 >> 接受破除末日法则。
step
.goto Netherstorm,50.8,57.6
>> 杀死毁灭法则并收集任务物品。
.complete 10235,1
step
.goto Netherstorm,46.6,56.6
.turnin 10235 >> 打开破解末日定律。
.accept 10237 >> 接受52区警告！
step
.goto Netherstorm,45.9,36.0
.turnin 10268 >> 将观众交给王子
.accept 10269 >> 接受三角点一
step
.goto Netherstorm,66.7,33.8
.use 28962 >> 在该区域使用三角测量设备
.complete 10269,1
step
.goto Netherstorm,58.4,31.3
.turnin 10269 >> 转入三角点一
.accept 10275 >> 接受三角点二
step
.goto Netherstorm,28.9,41.3
.use 29018 >> 在该区域使用三角测量设备
.complete 10275,1
step
.goto Netherstorm,34.6,37.9
.turnin 10275 >> 转入三角点二
.accept 10276 >> 接受全三角形
step
.goto Netherstorm,53.5,21.4
>> 杀死并掠夺Culuthas以获取水晶。如果你有困难，你可能需要帮助。
.complete 10276,1
step
.goto Netherstorm,45.8,36.0
.turnin 10276 >> 以全三角形转弯
step
.goto Netherstorm,32.6,64.8
.turnin 10237 >> 进入52号警戒区！
.accept 10247 >> 接受沃米萨博士。
step
.goto Netherstorm,37.2,63.8
.turnin 10247 >> 交给沃米萨博士。
.accept 10248 >> 接受你，机器人。
step
.goto Netherstorm,37.2,63.8
>> 使用您在废料回收器上的控制器并击败Negatron。确保在冷却时使用机器人的能力。
* Save the stun for when Negatron uses earthquake. Only use Smash if you start getting threat, otherwise heal Scrap Reaver and stun Negatron during earthquake.
* Scrap Reaver is buffable as well << Paladin/Priest/Druid
.use 28634
.complete 10248,1
step
.goto Netherstorm,37.2,63.8
.turnin 10248 >> 交给你，机器人。
step
.goto Blade's Edge Mountains,55.4,44.9
.accept 10995 >> 接受Grulloc有两个头骨
.accept 10996 >> 接受Maggoc的宝箱
.accept 10997 >> 接受Even Gronn的标准
step
#sticky
#completewith gronnsdone
.goto Blade's Edge Mountains,60.3,47.5
>> 杀死格鲁洛克，在他死后在地上掠夺物品。
.complete 10995,1
step
#sticky
#completewith gronssdone
.goto Blade's Edge Mountains,58.5,60.8,40,0
.goto Blade's Edge Mountains,64.5,54.8,40,0
.goto Blade's Edge Mountains,68.3,74.8
>> 找到麦戈克，他在缩放架周围巡逻。杀了他，抢走他扔在地上的东西
.unitscan Maggoc
.complete 10996,1
step
#sticky
#completewith gronssdone
.goto Terokkar Forest,20.3,15.9
>> 杀死斯拉格，并将他扔在地上的物品洗劫一空
.complete 10997,1
step
#completewith next
#label gronnprep
+接下来的3个任务都是精英任务，需要一个团队，然而，它们的独特之处在于，老板会丢弃一个可以右击地面的项目，以获得任务奖励，即使你不在被杀的团队中。你可以按任何顺序来做，两个在刀刃边缘，一个在沙塔斯上面。
step
#label gronnsdone
#requires gronnprep
.goto Blade's Edge Mountains,55.4,44.9
.turnin 10995 >> Turn in Grulloc有两个头骨
.turnin 10997 >> 交给Even Gronn有标准
.turnin 10996 >> 交出Maggoc的宝箱
.accept 10998 >> 接受严酷的业务
step
.goto Blade's Edge Mountains,77.4,31.2
>> 为他的书杀死Vim'gol the Vile，再次在地上抢劫物品。你不需要加入杀害他的组织就可以抢劫。
.complete 10998,1
step
.goto Blade's Edge Mountains,55.4,44.9
.turnin 10998 >> 交清严酷的生意
.accept 11000 >> 接受进入灵魂世界
step
.goto Blade's Edge Mountains,60.0,24.1
.use 32467 >> 踏上祭坛，用香灰开始战斗。在海浪中幸存下来，然后杀死老板，并洗劫他掉在地上的灵魂。
.complete 11000,1


step
.goto Deadwind Pass,47.0,75.6
.reputation 967,honored 
>> 迎风传球
.accept 9630 >> 接受麦迪文杂志。
step

>> 进入Karazhan，在馆长老板之后，在房间里与Wravien交谈。
.turnin 9630 >> 交给麦迪文杂志。
.accept 9638 >> 以良好的方式接受。
step
>> Gradav距离Wravien稍远一点。
.turnin 9638 >> 交给好帮手。
.accept 9639 >> 接受Kamsis。
step
>> 像以前一样，卡姆西斯比格拉达夫领先一点。
.turnin 9639 >> 交给Kamsis。
.accept 9640 >> 接受阿兰的阴影。
step
>> 击败《阿兰阴影》获得《华尔街日报》。
.complete 9640,1
step
.turnin 9640 >> 与卡米西斯一起上交《阿兰的阴影》。
.accept 9645 >> 接受主人的露台。
step
>> 去卡拉詹的主人露台读日记。
.use 23934
.complete 9645,1
step
.goto Deadwind Pass,47.0,75.6
.turnin 9645 >> 在主人的露台上转弯。
.accept 9680 >> 接受挖掘过去。
step
.goto Deadwind Pass,45.0,78.8
>> 从地上收集烧焦的骨头碎片。
.complete 9680,1
step
.goto Deadwind Pass,47.0,75.6
.turnin 9680 >> 打开挖掘过去。
step
#sticky
.goto Netherstorm,43.5,35.0
+由于复杂性，本指南中不包括职业任务，但由于经验缩放，它们在70时可能会有大量经验。如果你有任何低级任务可用，比如治疗德鲁伊毒药、圣骑士复活等，请准备好在启动时提交。有些10级任务由于缩放而放弃30公里经验。
step
.goto Netherstorm,43.5,35.0
+前往风暴精灵，攻击敌方玩家，攻击守卫。杀死守卫，直到你在联盟中处于0/3000中立。你每杀一次就损失125次。有一个敌对派别的朋友会加快这一进程。
>>在以下任务中需要中立的声誉：从小偷那里偷窃和满头象牙
*Skip this step if those 2 quests are already complete
step
.goto Shadowmoon Valley,66.0,84.6
.reputation 1015,exalted
+通过制作以下日报，达到与荷兰之翼的共鸣。不要提交任何一次任务！
.accept 11020 >> 接受缓慢死亡
.accept 11015 >> 接受荷兰水晶
.accept 11035 >> 接受不那么友好的天空。。。
step
.goto Shadowmoon Valley,66.0,84.6
.accept 11018 >> 接受菱铁矿
.skill mining,<350,1
step
.goto Shadowmoon Valley,66.0,84.6
.skill herbalism,<350,1
.accept 11017 >> 接受荷兰花粉
step
.goto Shadowmoon Valley,66.0,84.6
.skill skinning,<350,1
.accept 11016 >> 接受Nethermin Flayer Hide
]])
RXPGuides.RegisterGuide([[
#version 7
#wotlk
#tbc
#group RestedXP WLK的准备
#name 交接日速度助理
step << !Mage
#sticky
#completewith next
+如果你的任务日志中没有“了解你的莱伊线”作为你的任务之一，那么在发射前几个小时去做“知道你的莱尔线”，它会给你一个卷轴来传送到沙塔斯。当日报再次可用时，此项目将被删除。如果你是一个愿意转移/召唤你的术士或法师的朋友，也可以跳过这一步。
step << !Mage
.goto Isle of Quel'Danas,47.6,35.4
.accept 11547 >> 接受Know Your Ley Lines
step << !Mage
.isOnQuest 11547
.goto Isle of Quel'Danas,42.0,34.9,-1
.goto Isle of Quel'Danas,48.4,44.4,-1
.goto Isle of Quel'Danas,61.0,62.1,-1
.use 34533 >> 使用星际巫师的水晶读取传送门、神殿和血水晶。
.complete 11547,1
.complete 11547,2
.complete 11547,3
step << !Mage
.isOnQuest 11547
.goto Isle of Quel'Danas,47.6,35.4
.turnin 11547 >> 上车了解你的路线
step
>> 可以提高你的转身速度的物品。
.collect 6372,1
.collect 7052,1
.collect 2459,5
.collect 25653,1
step
>> 您还可以选择获得赞萨的迅捷。也可能会节省你一点时间（需要赞达拉部落的尊敬）
.reputation 270,revered
.collect 20081,1
step
>> 火箭靴结合noggenfogger也可以为你节省很多时间。
*There is a cloth and leather version of the boots, pick whichever is best for your spec. << Druid/Shaman/Paladin
.skill engineering,<330,1
.collect 8529,40
.collect 35581,1 << Warlock/Mage/Priest/Shaman/Druid/Paladin
.collect 23824,1 << Warrior/Paladin/Rogue/Hunter/Shaman/Druid
.collect 30542,1
]])
RXPGuides.RegisterGuide([[
#version 7
#wotlk
#tbc
#group RestedXP WLK的准备
#name 启动上交指南
step
#sticky
#completewith start1
+ 这是您在WOTLK退出时使用的指南，您正在提交探索任务。该指南尚未发布，以防止人们意外提交任务，请在发布前不久通过我们的网站更新您的指南以访问此指南！
step
#sticky
#completewith start1
+ 将任务接受物品从您的库存添加到您的工具栏上，并按键绑定它们以更快地接受它们。这将节省以后查找它们的大量时间。
step
.isQuestTurnedIn 9680
>> 前往逆风山口
.goto Deadwind Pass,47.0,75.6
.accept 9631 >> 接受同事的帮助。
step
.goto Deadwind Pass,47.1,75.2
.reputation 967,friendly,<0,1
>> 选择一条环形路径，选择一条后跳过此步骤。
.dailyturnin 10730,10732,10729,10731 >> 在紫色空白的道路上转弯
step
.goto Deadwind Pass,47.1,75.2
.reputation 967,honored,<0,1
.daily 10735,10736,10733,10734 >> 接受荣誉戒指任务。如果您超越荣誉，请跳过此步骤
.dailyturnin 10735,10736,10733,10734 >> 提交荣誉戒指任务。如果您超越荣誉，请跳过此步骤
step
.goto Deadwind Pass,47.1,75.2
.reputation 967,revered,<0,1
.daily 10739,10740,10741,10738 >> 接受尊敬的戒指任务。如果你不受尊敬，跳过这一步
.dailyturnin 10739,10740,10741,10738 >> 交出尊敬的戒指任务。如果你不受尊敬，跳过这一步
step
.goto Deadwind Pass,47.1,75.2
.reputation 967,exalted,<0,1
.daily 10725,10728,10727,10726 >> 接受至尊戒指任务
.dailyturnin 10725,10728,10727,10726 >> 提交至尊戒指任务
step
.zone Shattrath City >> 前往沙塔斯城
step
#scryer
.itemcount 30810,10
.goto Shattrath City,45.5,81.4
.accept 10656 >> 接受Sunfrew标牌
.turnin 10656 >> 交上Sunfrew标牌
step
#scryer
.itemcount 29426,10
.goto Shattrath City,45.4,81.4
.accept 10412 >> 接受消防标识
.turnin 10412 >> 交出消防标识
step
#scryer
.itemcount 29739,1
.goto Shattrath City,42.6,91.4
.accept 10416 >> 接受功率合成
.turnin 10416 >> 交合功率合成
step
#aldor
.itemcount 30809,10
.goto Shattrath City,30.8,34.6
.accept 10653 >> 接受萨格拉斯的标记
.turnin 10653 >> 交出萨格拉斯的标记
step
#aldor
.itemcount 29425,10
.goto Shattrath City,30.8,34.6
.accept 10325 >> 接受基尔加丹的标记
.turnin 10325 >> 基尔加丹的上缴标记
step
#aldor
.itemcount 29740,1
.goto Shattrath City,24.2,29.8
.accept 10420 >> 接受清洁灯
.turnin 10420 >> 打开清洁灯
step
.itemcount 32405,1
.goto Shattrath City,54.0,44.6
.accept 11007 >> 点击苍翠球体并接受任务
.turnin 11007 >> 将凯尔萨斯和苍翠的球体交给我们
step
.isOnQuest 9837
.goto Shattrath City,54.6,44.2
.turnin 9837 >> 转入卡德加
step
.isOnQuest 9831
.goto Shattrath City,54.6,44.2
.turnin 9831 >> 转入卡拉赞入口
step
.isQuestAvailable 11550
.goto Shattrath City,53.4,43.6
.accept 11550 >> 接受进入骗子。。。
step
.itemcount 27480,5
.goto Shattrath City,50.4,45.4
.turnin 10091 >> 交回灵魂设备
step
.isOnQuest 10095
.goto Shattrath City,50.4,45.4
.turnin 10095 >> 进入迷宫的中心
step
.itemcount 34246,10
.goto Shattrath City,49.2,42.4
.turnin 11514 >> 移交维护Sunwell门户
step
.isOnQuest 11108
.goto Shattrath City,66.6,16.8
.turnin 11108 >> 交出伊利丹·怒风勋爵
step
.itemcount 35231,1
.goto Shattrath City,62.6,36.0
.turnin 11877 >> 提交Sunfrew攻击计划
step << Alliance
.goto Shattrath City,67.2,34.0
.dailyturnin 11337,11336,11335,11338 >> 交PvP Daily
step << Horde
.goto Shattrath City,67.0,56.6
.dailyturnin 11341,11340,11339,11342 >> 交PvP Daily
step
.itemcount 25719,30
.goto Shattrath City,49.0,18.4
>> Vekax在该地区四处走动
.unitscan Vekax
.accept 10917 >> 接受弃儿的困境
.turnin 10917 >> 反击被放逐者的困境
step
#aldor
.itemcount 25744,8
.goto Shattrath City,54.8,22.6
.accept 10024 >> 接受沃伦萨尔的观点
.turnin 10024 >> 交给沃伦萨尔的愿景
step
.itemcount 33849,15
.goto Shattrath City,61.6,15.8
.turnin 11380 >> 交给Manalicious
step
.itemcount 33839,1
.goto Shattrath City,61.6,15.8
.turnin 11377 >> 报仇很美味
step
.itemcount 33850,1
.goto Shattrath City,61.6,15.8
.turnin 11381 >> 为灵魂上汤
step
.itemcount 33848,1
.goto Shattrath City,61.6,15.8
.turnin 11379 >> 加入超级热炖肉
step
#scryer
.itemcount 25802,8
.goto Shattrath City,64.4,15.6
.accept 10017 >> 接受应变物资
.turnin 10017 >> 上缴应变物资
step
.itemcount 33826,1
.goto Shattrath City,75.0,36.4
.turnin 11369 >> 通缉犯：一个黑跟踪鸡蛋
step
.itemcount 33859,1
.goto Shattrath City,75.0,36.4
.turnin 11384 >> 通缉犯：一个曲翼分割器剪辑
step
.itemcount 33858,1
.goto Shattrath City,75.0,36.4
.turnin 11382 >> 通缉犯：Aeonus的沙漏
step
.itemcount 11363,1
.goto Shattrath City,75.0,36.4
.turnin 11363 >> 通缉犯：刀锋圣印
step
.itemcount 33840,1
.goto Shattrath City,75.0,36.4
.turnin 11375 >> 通缉犯：窃窃私语
step
.itemcount 33833,1
.goto Shattrath City,75.0,36.4
.turnin 11354 >> 通缉犯：Nazan的骑马作物
step
.itemcount 33860,1
.goto Shattrath City,75.0,36.4
.turnin 11386 >> 通缉犯：Pathaleon的投影仪
step
.itemcount 33835,1
.goto Shattrath City,75.0,36.4
.turnin 11373 >> 通缉犯：Shaffar的Wondrous Pendan
step
.itemcount 33847,1
.goto Shattrath City,75.0,36.4
.turnin 11378 >> 通缉犯：时代猎人的头颅
step
.itemcount 33836,1
.goto Shattrath City,75.0,36.4
.turnin 11374 >> 通缉犯：统治者的灵魂宝石
step
.itemcount 33834,1
.goto Shattrath City,75.0,36.4
.turnin 11372 >> 通缉犯：艾吉斯的头饰
step
.itemcount 33821,1
.goto Shattrath City,75.0,36.4
.turnin 11368 >> 通缉犯：Quagmirran的心脏
step
.itemcount 33861,1
.goto Shattrath City,75.0,36.4
.turnin 11388 >> 通缉犯：Skyris卷轴
step
.itemcount 33827,1
.goto Shattrath City,75.0,36.4
.turnin 11370 >> 通缉犯：军阀论
step << Horde
.isQuestTurnedIn 9993
.goto Terokkar Forest,50.0,44.8
.accept 10201 >> 接受现在，真相时刻
step << Horde
.isOnQuest 10201
.goto Terokkar Forest,49.8,45.2
>> 与Grek交谈
.skipgossip
.complete 10201,1
step << Horde
.isOnQuest 10201
.goto Terokkar Forest,50.0,44.8
.turnin 10201 >> 现在，真相时刻
step << Horde
.isQuestTurnedIn 10447
.goto Terokkar Forest,50.0,45.8
.accept 10006 >> 接受让土工Tavgren知道
step << Horde
.isOnQuest 10006
.goto Terokkar Forest,44.4,26.2 
.turnin 10006 >> 交给土匪塔夫格伦
step << Horde
.isOnQuest 11506
.goto Terokkar Forest,49.8,45.6
.turnin 11506 >> 交出奥金登的精神

step << Horde
.isQuestAvailable 10013
.goto Terokkar Forest,67.9,53.5
>> 点击建筑物内的卷轴
.accept 10013 >> 接受一只看不见的手。
step << Alliance
.isQuestTurnedIn 10446
.goto Terokkar Forest,57.0,53.6
.accept 10005 >> 接受Earthbinder Tavgren Know。
step << Alliance
.isOnQuest 11505
.goto Terokkar Forest,55.8,53.8
.turnin 11505 >> 交出奥金登的精神
step << Alliance
.isQuestAvailable 10038
.goto Terokkar Forest,57.6,55.6
.accept 10038 >> 接受与私人周交谈
step << Alliance
.isQuestAvailable 10012
.goto Terokkar Forest,67.9,53.5
>> 点击建筑物内的卷轴
.accept 10012 >> 接受恶魔计划。
step
#label start1
.itemcount 30829,1
.goto Terokkar Forest,77.4,38.6
.turnin 10670 >> 大地母亲的眼泪
step
.itemcount 30828,1
.goto Terokkar Forest,77.4,38.6
.turnin 10667 >> 交出地下壤土
step
.goto Terokkar Forest,77.4,38.6
>> 接受并交出任务，然后等待他制作剑。如果需要，请跳过此步骤。
.accept 10676 >> 接受伊利达里的诅咒
step
>> 需要30秒才能分娩。它有一个相当免费的后续任务。
.isOnQuest 10676
.goto Terokkar Forest,77.4,38.6
.turnin 10676 >> 交出伊利达利之王
step
.isQuestTurnedIn 10676
.goto Terokkar Forest,77.4,38.6
>> 在他锻造完刀刃后，接受新的任务
.accept 10679 >> 接受叶片淬火
step << Alliance
.isOnQuest 10005
.goto Terokkar Forest,44.4,26.2 
.turnin 10005 >> 交给土匪塔夫格伦
step << Horde
.isOnQuest 10013
.goto Terokkar Forest,49.0,44.7
.turnin 10013 >> 交一只看不见的手。
step << Horde
.isQuestAvailable 10847
.goto Terokkar Forest,49.0,44.7
.accept 10862 >> 接受投降部落。
step << Horde
.isQuestAvailable 10039
>> 与血精灵对话
.goto Terokkar Forest,48.8,44.6
.accept 10039 >> 接受与Neftis探子交谈
step << Horde
.isOnQuest 10039
.goto Terokkar Forest,39.0,43.8
.turnin 10039 >> 转而与侦察员Neftis交谈
step << Alliance
.isOnQuest 10038
.goto Terokkar Forest,40.4,36.0
.turnin 10038 >> 与私人周交谈
step
.itemcount 31707,1
.goto Terokkar Forest,37.4,51.2
.use 31707,1 >> 使用包中的阴谋命令接受任务
.accept 10880 >> 接受阴谋集团订单
.turnin 10880 >> 交出阴谋命令
step
.isOnQuest 10218
.goto Terokkar Forest,39.4,58.4
.turnin 10218 >> 把别人的努力交给你会有回报
step
.isOnQuest 10165
.goto Terokkar Forest,39.4,58.4
.turnin 10165 >> 交出削弱竞争
step
.isOnQuest 10097
.goto Terokkar Forest,44.0,65.0
.turnin 10097 >> 交兄弟反对兄弟
step
.isOnQuest 10098
.goto Terokkar Forest,44.0,65.0
.turnin 10098 >> 交出特洛克的遗产
step
.isQuestTurnedIn 10921
.goto Terokkar Forest,49.8,76.2
.accept 10926 >> 接受返回沙塔里大本营。
step
.isOnQuest 10926
.goto Terokkar Forest,31.4,75.6
.turnin 10926 >> 返回沙塔里大本营。
step
.isOnQuest 10164
.goto Terokkar Forest,35.0,65.2
.turnin 10164 >> 交上来一切都会好的
step << Alliance
.isOnQuest 10012
.goto Terokkar Forest,58.2,54.8
.turnin 10012 >> 提交兽人计划。
step << Alliance
.isQuestAvailable 10847
.goto Terokkar Forest,57.6,56.0
.accept 10863 >> 接受阿拉科亚的秘密。
step
.itemcount 32523,1
.goto Terokkar Forest,64.0,66.8
.use 32523 >> 使用包中的Ishaal年鉴接受任务
.accept 11021 >> 接受Ishaal的年鉴
.turnin 11021 >> 提交Ishaal的年鉴
step
.isQuestTurnedIn 11021
.goto Terokkar Forest,64.0,66.8
.accept 11024 >> 接受下城盟友
step
.itemcount 32388,6
.goto Terokkar Forest,64.0,66.8
.accept 11004 >> 接受阴影世界
.turnin 11004 >> 在阴影世界中旋转
step
.isOnQuest 11008
.goto Terokkar Forest,64.6,66.6
.turnin 11008 >> 在Skettis上交火
step << Alliance
.isQuestTurnedIn 10612
.goto Shadowmoon Valley,40.8,22.2
.accept 10744 >> 接受胜利消息
step << Alliance
.isQuestTurnedIn 10522
.goto Shadowmoon Valley,44.6,23.7
.accept 10523 >> 接受诅咒密码-恢复的第一个碎片
step << Horde
.isQuestTurnedIn 10613
.goto Shadowmoon Valley,27.4,21.2
.accept 10745 >> 接受胜利消息
step << Horde
.isOnQuest 10745
.goto Shadowmoon Valley,28.4,26.4
.turnin 10745 >> 递交胜利消息
step << Horde
.isQuestAvailable 10750
.goto Shadowmoon Valley,28.4,26.4
.accept 10750 >> 接受征服之路
step << Horde
.isQuestTurnedIn 10625
.goto Shadowmoon Valley,29.8,27.8
.accept 10633 >> 接受Teron Gorefiend-知识与传说
step
.isQuestTurnedIn 10780
.goto Shadowmoon Valley,35.4,41.8
>> 任务给予者帕沙在路上巡逻
.unitscan Parshah
.accept 10782 >> 接受植入耳机
step
.isOnQuest 10782
.goto Shadowmoon Valley,43.1,44.9
.use 31360 >> 立即装备饰品，因为它有CD，然后在祭坛附近使用
.complete 10782,1 
step
.isOnQuest 10782
.goto Shadowmoon Valley,35.4,41.8
>> 重新装备你的普通饰品！
.turnin 10782 >> 将头戴插入
step
.isQuestTurnedIn 10540
.goto Shadowmoon Valley,29.5,50.6
.accept 10541 >> 接受诅咒密码-第二个碎片恢复
step << Alliance
.isOnQuest 10744
.goto Shadowmoon Valley,35.8,57.6
>> 走下大楼的楼梯。
.turnin 10744 >> 递交胜利消息
step << Alliance
.isQuestAvailable 10772
.goto Shadowmoon Valley,36.2,57.0
.accept 10772 >> 接受征服之路
step
.isQuestTurnedIn 10578
.goto Shadowmoon Valley,47.5,57.2
.accept 10579 >> 接受诅咒密码-恢复第三段
step << Alliance
.isOnQuest 10772
.goto Shadowmoon Valley,51.8,61.0
.use 31310 >> 一旦你发现路径，就用火炬召唤鹰头狮骑士。你必须在安全的地方接触地面。
.turnin 10772 >> 转向征服之路
step << Horde
.isOnQuest 10750
.goto Shadowmoon Valley,51.4,60.4
.use 31108 >> 一旦你发现路径，就用火炬召唤飞龙骑士。你必须在安全的地方接触地面。
.turnin 10750 >> 转向征服之路
step
.itemcount 31345,1
.goto Shadowmoon Valley,51.4,72.7
.use 31345 >> 使用包中的《瓦尔扎雷克日记》接受任务
.accept 10793 >> 接受《瓦尔扎雷克杂志：战争的门户》
.turnin 10793 >> 上交《瓦尔扎雷克杂志：战争的门户》
step << Horde
.isOnQuest 10633
.goto Shadowmoon Valley,58.2,70.8
.turnin 10633 >> 上交Teron Gorefiend-Lore and Legend
step
.itemcount 32427,30
.goto Shadowmoon Valley,66.0,86.4
.accept 11015 >> 接受荷兰水晶
.turnin 11015 >> 交出下翼水晶
step
.isOnQuest 11020
.goto Shadowmoon Valley,66.0,86.4
.turnin 11020 >> 缓缓死亡
step
.itemcount 32506,1
.goto Shadowmoon Valley,66.0,86.4
.accept 11049 >> 接受伟大的下翼猎蛋
.turnin 11049 >> 完成伟大的羽翼猎蛋
step
.itemcount 32464,40
.reputation 1015,neutral,<0,1
.goto Shadowmoon Valley,66.0,86.4
.skill mining,<350,1
>> 你每天只能提交一次采集，如果你有两个采集职业，请跳过下一个。
.accept 11018 >> 接受菱铁矿
.turnin 11018 >> 交出菱铁矿
step
.itemcount 32468,40
.reputation 1015,neutral,<0,1
.goto Shadowmoon Valley,66.0,86.4
.skill herbalism,<350,1
>> 你每天只能提交一次采集，如果你有两个采集职业，请跳过下一个。
.accept 11017 >> 接受荷兰花粉
.turnin 11017 >> 交出荷兰花粉
step
.itemcount 32470,435
.reputation 1015,neutral,<0,1
.goto Shadowmoon Valley,66.0,86.4
.skill skinning,<350,1
>> 你每天只能提交一次采集，如果你有两个采集职业，请跳过下一个。
.accept 11016 >> 接受Nethermin Flayer Hide
.turnin 11016 >> 交出Nethermin Flayer Hide
step
.isQuestAvailable 11053
.goto Shadowmoon Valley,66.0,86.4
.reputation 1015,friendly,<0,1
.accept 11053 >> 接受起立，监督！
step
.isOnQuest 11053
.goto Shadowmoon Valley,66.2,85.6
.reputation 1015,friendly,<0,1
.turnin 11053 >> 起来，监督！
step
.isQuestAvailable 11075
.goto Shadowmoon Valley,66.2,86.4
.reputation 1015,friendly<0,1
.accept 11075 >> 接受荷兰水雷
step
.isQuestAvailable 11084
.goto Shadowmoon Valley,66.0,86.4
.reputation 1015,honored,<0,1
.accept 11084 >> 接受挺身而出，队长！
step
.isOnQuest 11084
.goto Shadowmoon Valley,66.2,85.6
.reputation 1015,honored,<0,1
.turnin 11084 >> 上尉，站直！
step
.isQuestAvailable 11092
.goto Shadowmoon Valley,66.0,86.4
.reputation 1015,revered,<0,1
.accept 11092 >> 接受欢呼，指挥官！
step
.isOnQuest 11092
.goto Shadowmoon Valley,66.2,85.6
.reputation 1015,revered,<0,1
.turnin 11092 >> 上车，指挥官！
step
#aldor
.isQuestAvailable 11099
.goto Shadowmoon Valley,66.2,85.6
.reputation 1015,revered,<0,1
.accept 11099 >> 接受全部杀死他们
step
#scryer
.isQuestAvailable 11094
.goto Shadowmoon Valley,66.2,85.6
.reputation 1015,revered,<0,1
.accept 11094 >> 接受全部杀死他们
step
.goto Shadowmoon Valley,66.0,86.4
.itemcount 32509,10
.turnin 11035 >> 把不那么友好的天空。。。
step
.isOnQuest 11075
.goto Shadowmoon Valley,63.0,87.8
.turnin 11075 >> 交出荷兰水雷
step
.itemcount 32724,1
>> 打开你的污泥覆盖物，直到你得到一个黑血逃生计划
.collect 32726,1,11081,1
step
.itemcount 32726,1
.goto Shadowmoon Valley,63.0,87.8
.use 32726 >> 使用包中的黑血逃生计划接受任务
.accept 11081 >> 接受大黑血暴动
.turnin 11081 >> 交出大黑血暴动
step
#scryer
.isOnQuest 11094
.goto Shadowmoon Valley,56.2,59.6
.reputation 1015,revered,<0,1
.turnin 11094 >> 上缴杀光他们
step
.isOnQuest 10707
.goto Shadowmoon Valley,58.0,48.2
.turnin 10707 >> 转入Ata'mal Terrace
step
.isOnQuest 10679
.goto Shadowmoon Valley,51.9,40.2
.use 30875 >> 在熔岩池中使用锻造伊利达里诅咒之刃
.complete 10679,1
step << Horde
.isQuestTurnedIn 10522
.goto Shadowmoon Valley,44.6,23.7
.accept 10523 >> 接受诅咒密码-恢复的第一个碎片
step
#aldor
.isOnQuest 11099
.goto Shadowmoon Valley,62.6,28.4
.reputation 1015,revered
.turnin 11099 >> 上缴杀光他们
step
.isOnQuest 10523
.goto Shadowmoon Valley,53.9,23.4
.turnin 10523 >> 交出诅咒密码-恢复的第一个碎片
step
.isOnQuest 10541
.goto Shadowmoon Valley,53.9,23.4
.turnin 10541 >> 交出诅咒密码-第二段恢复
step
.isOnQuest 10579
.goto Shadowmoon Valley,53.9,23.4
.turnin 10579 >> 交出诅咒密码-第三段恢复
step
.isOnQuest 10679
.goto Terokkar Forest,77.4,38.6
.turnin 10679 >> 转入淬火刀片
step
.itemcount 23580,1
.goto Hellfire Peninsula,28.8,81.4
.use 23580 >> 使用包中的Avruu's Orb接受任务
.accept 9418 >> 接受Avruu的球
.turnin 9418 >> 交给阿夫鲁的球
step << Alliance
.itemcount 23848,1
.goto Hellfire Peninsula,24.0,72.2
.reputation 946,friendly,<0,1 >> 这一步你至少需要友好地站着，保持荣誉。
.accept 9563 >> 接受赢得米伦的信任。
.turnin 9563 >> 交给《赢得米伦的信任》。
step << Horde
.isQuestTurnedIn 9400
.goto Hellfire Peninsula,33.6,43.6
.accept 9401 >> 接受一件奇怪的武器。
step << Horde
.isOnQuest 9401
.goto Hellfire Peninsula,55.0,36.0
.turnin 9401 >> 交出一件奇怪的武器
step << Horde
.isQuestTurnedIn 9401
.goto Hellfire Peninsula,55.0,36.0
.accept 9405 >> 接受酋长的命令。
step << Horde
.itemcount 29590,1
.goto Hellfire Peninsula,55.0,36.0
.use 29590 >> 使用背包中的燃烧军团任务来接受任务
.accept 10393 >> 接受卑鄙计划
step << Horde
.goto Hellfire Peninsula,55.0,36.0
.turnin 10393 >> 提交卑鄙计划
step << Horde
.itemcount 23892,1
.goto Hellfire Peninsula,55.0,36.0
.use 23892 >> 接受库存中不祥之信的任务
.accept 9588 >> 接受暗潮
step
.isOnQuest 9588
.goto Hellfire Peninsula,55.0,36.0
.turnin 9588 >> 在暗潮中转弯
step << Horde
.itemcount 31241,1
.goto Hellfire Peninsula,55.0,36.0
.use 31241 >> 使用库存中的Primed Key Mold接受任务
.accept 10755 >> 接受进入城堡
step << Horde
.isOnQuest 10755
.goto Hellfire Peninsula,55.0,36.0
.turnin 10755 >> 转入城堡入口
step << Horde
.isQuestTurnedIn 10755
.goto Hellfire Peninsula,55.0,36.0
.accept 10756 >> 接受罗霍克大师
step << Horde
.itemcount 32386,1
.goto Hellfire Peninsula,55.0,36.0
.use 32386 >> 使用Matheridon的头接受任务
.accept 11003 >> 接受马瑟里顿的堕落
.turnin 11003 >> 《马塞里登的堕落》
step << Horde
.itemcount 23723,1
.goto Hellfire Peninsula,55.0,36.0
.turnin 9495 >> 交出酋长的意愿
step << Horde
.isOnQuest 9405
.goto Hellfire Peninsula,54.2,37.8
.turnin 9405 >> 交出酋长的授权书。
step << Horde
.isOnQuest 10756
.goto Hellfire Peninsula,53.2,38.2
.turnin 10756 >> 交给罗霍克大师
step << Horde
.isQuestTurnedIn 10756
.goto Hellfire Peninsula,53.2,38.2
.accept 10757 >> 接受Rohok的请求
.turnin 10757 >> 提交Rohok的请求
step << Alliance
.isOnQuest 9493
.goto Hellfire Peninsula,56.8,62.6
.turnin 9493 >> 交出恶魔部落的骄傲
step << Alliance
.isQuestTurnedIn 10047
.goto Hellfire Peninsula,56.6,66.6
.accept 10093 >> 从要塞内的Warp Scryer Kryv那里接受Telhamat神庙。
step << Alliance
.itemcount 29590,1
.goto Hellfire Peninsula,56.6,66.4
.use 29590 >> 使用背包中的燃烧军团任务来接受任务
.accept 10395 >> 接受黑暗导弹
step << Alliance
.isOnQuest 10395
.goto Hellfire Peninsula,56.6,66.4
.turnin 10395 >> 交出黑暗导弹
step << Alliance
.itemcount 23890,1
.goto Hellfire Peninsula,56.6,66.4
.use 23890 >> 使用包中的不祥信接受任务
.accept 9587 >> 接受暗潮
step << Alliance
.isOnQuest 9587
.goto Hellfire Peninsula,56.6,66.4
.turnin 9587 >> 在暗潮中转弯
step << Alliance
.itemcount 32385,1
.goto Hellfire Peninsula,56.6,66.4
.use 32385 >> 使用Matheridon的头接受任务
.accept 11002 >> 接受马瑟里顿的堕落
.turnin 11002 >> 《马塞里登的堕落》
step << Alliance
.itemcount 21239,1
.goto Hellfire Peninsula,56.6,66.6
.use 21239 >> 使用库存中的Primed Key Mold接受任务
.accept 10754 >> 接受进入城堡
step << Alliance
.isOnQuest 10754
.goto Hellfire Peninsula,56.6,66.6
.turnin 10754 >> 转入城堡入口
step << Alliance
.isQuestAvailable 10762
.goto Hellfire Peninsula,56.6,66.6
.accept 10762 >> 接受大师邓普利
step << Alliance
.isOnQuest 9492
.goto Hellfire Peninsula,56.6,66.4
.turnin 9492 >> 转向转向
step << Alliance
.isOnQuest 9494
.goto Hellfire Peninsula,53.8,65.6
.turnin 9494 >> 交出Fel Embers
step << Alliance
.isOnQuest 10762
.goto Hellfire Peninsula,51.2,60.2
.turnin 10762 >> 交给大少爷邓普里
step << Alliance
.isQuestTurnedIn 10762
.goto Hellfire Peninsula,51.2,60.2
.accept 10763 >> 接受Dumphry的请求
.turnin 10763 >> 提交Dumphry的请求
step
.isOnQuest 11515
.goto Hellfire Peninsula,58.2,17.6
.turnin 11515 >> 以血换血
step
.isOnQuest 11516
.goto Hellfire Peninsula,58.2,17.6
.turnin 11516 >> 转弯炸开大门
step << Alliance
.isQuestTurnedIn 9390
.goto Hellfire Peninsula,26.8,37.6
>> 与尸体对话
.accept 9423 >> 接受返回奥巴迪。
step << Alliance
.isOnQuest 10093
.goto Hellfire Peninsula,23.4,36.6
.turnin 10093 >> 在特尔哈玛特神庙转弯。
step << Alliance
.isQuestAvailable 9423
.goto Hellfire Peninsula,23.0,40.4
.turnin 9423 >> 返回奥巴迪。
step
.itemcount 23338,1
.goto Hellfire Peninsula,15.6,52.2
.use 23338 >> 使用包中的腐蚀皮套接受任务
.accept 9373 >> 接受失踪的导弹
.turnin 9373 >> 交出失踪的导弹
step
.itemcount 29476,1
.goto Hellfire Peninsula,15.6,52.2
.use 29476 >> 使用包中的深红水晶碎片接受任务
.accept 10134 >> 接受深红水晶线索
.turnin 10134 >> 交上深红水晶线索
step << Horde
.isQuestTurnedIn 9774
.goto Zangarmarsh,85.2,54.6
.accept 9771 >> 接受搜索童子军Jyoba。
step << Horde
.isQuestAvailable 9775
.goto Zangarmarsh,85.2,54.6
.accept 9775 >> 接受报告给暗影猎人丹杰。
step << Horde
.itemcount 24484,1
.goto Zangarmarsh,85.0,54.0
.use 24484 >> 使用你的库存中的枯萎的Basidium来接受任务
.accept 9828 >> 接受枯萎的Basidium
.turnin 9828 >> 交出枯萎的Basidium
step << Horde
.isOnQuest 9771
.goto Zangarmarsh,80.8,36.2
.turnin 9771 >> 交给Searching for Scout Jyoba。
step
.isQuestTurnedIn 9731
.goto Zangarmarsh,78.4,62.0
.accept 9724 >> 接受塞纳里奥圈的警告。
step
.itemcount 24367,1
.goto Zangarmarsh,78.4,62.0
.use 24367 >> 用你包里的瓦什女士的命令接受任务
.accept 9764 >> 接受瓦什女士的命令
.turnin 9764 >> 交出瓦什女士的命令
step
.isQuestTurnedIn 9764
.goto Zangarmarsh,78.4,62.0
.accept 9765 >> 接受战争准备
.turnin 9765 >> 上缴备战
step
.isQuestAvailable 9697
.goto Zangarmarsh,78.6,63.2
.reputation 942,friendly,<0,1 >> 如果你对塞纳里奥探险队不够友好，请跳过这一步。
.accept 9697 >> 接受观察者Leesa'oh
step
.itemcount 24401,10
.goto Zangarmarsh,80.2,64.2
.accept 9802 >> 接受赞格马什的植物
.turnin 9802 >> 扎格马什岛植物的移交
step
.isQuestAvailable 9785
.goto Zangarmarsh,80.4,64.6
.accept 9785 >> 接受古人的祝福
step
.isOnQuest 9785
.goto Zangarmarsh,81.0,64.0,20,0
.goto Zangarmarsh,79.8,64.4
.skipgossip
>> 与古阿申和凯利斯交谈以获得他们的标记。
.unitscan Ashyen
.unitscan Keleth
.complete 9785,1
.complete 9785,2
step
.isOnQuest 9785
.goto Zangarmarsh,80.4,64.6
.turnin 9785 >> 上缴古人的祝福
step << skip
.isQuestAvailable 9957
.goto Zangarmarsh,78.6,63.0
.accept 9957 >> 接受塞纳里奥灌木丛有什么问题？
step
.isQuestTurnedIn 9731
.goto Hellfire Peninsula,16.0,52.2
.turnin 9724 >> 向塞纳里奥圈发出警告。
step
.isQuestTurnedIn 9731
.goto Hellfire Peninsula,16.0,52.2
.accept 9732 >> 接受返回沼泽。
step
.isQuestTurnedIn 9731
.goto Zangarmarsh,78.4,62.0
.turnin 9732 >> 返回沼泽地。
step << Alliance
.itemcount 24483,1
.goto Zangarmarsh,68.6,48.8
.use 24483 >> 使用你的库存中的枯萎的Basidium来接受任务
.accept 9827 >> 接受枯萎的Basidium
.turnin 9827 >> 交出枯萎的Basidium
step
.isQuestTurnedIn 10231
.goto Shattrath City,43.6,29.6
>> 如果“肮脏的”拉里死了，跳过这一步。
.accept 10251 >> 接受大师的宏伟设计？
step << Alliance
.isOnQuest 10863
.goto Shattrath City,52.6,20.8
.turnin 10863 >> 交上《阿拉科阿的秘密》。
step << Horde
.isOnQuest 10862
.goto Shattrath City,52.6,20.8
.turnin 10862 >> 向部落投降。
step
.isQuestTurnedIn 10009
.goto Shattrath City,77.2,34.8
.accept 10010 >> 接受就这么简单？
step
#completewith isleofquel
.goto Shattrath City,48.7,42.2
.zone 122 >> 从沙塔斯的门户到奎尔达纳斯岛
step
.isOnQuest 11521
.goto Isle of Quel'Danas,53.8,34.2
.turnin 11521 >> 重新发现你的根
step
.isOnQuest 11546
.goto Isle of Quel'Danas,53.8,34.2
.turnin 11546 >> 上缴营业执照
step
.isOnQuest 11541
.goto Isle of Quel'Danas,51.4,32.6
.turnin 11541 >> 转向扰乱格林吉尔海岸
step
.isOnQuest 11550
.goto Isle of Quel'Danas,50.2,28.2
.turnin 11550 >> 上车进入骗子。。。
step
.isOnQuest 11523
.goto Isle of Quel'Danas,47.4,30.6
.turnin 11523 >> 武装病房！
step
.isOnQuest 11525
.goto Isle of Quel'Danas,47.2,30.6
.turnin 11525 >> 提交进一步的转换
step
.isOnQuest 11533
.goto Isle of Quel'Danas,47.6,35.2
.turnin 11533 >> 空中打击必须继续
step
.isOnQuest 11547
.goto Isle of Quel'Danas,47.6,35.4
>> 如果你不打算提交祖拉曼或奥特兰山谷任务，使用它给你的卷轴奖励返回沙塔斯。
.turnin 11547 >> 上车了解你的路线
step
.isOnQuest 11536
.goto Isle of Quel'Danas,50.4,40.6
.turnin 11536 >> 上车不要停下。。。。
step
.itemcount 34501,5
.goto Isle of Quel'Danas,50.4,40.6
.turnin 11544 >> 交出Ata'mal武器
step
.isOnQuest 11542
.goto Isle of Quel'Danas,50.4,39.0
.turnin 11542 >> 转入拦截加固
step
.isOnQuest 11543
.goto Isle of Quel'Danas,50.4,39.0
.turnin 11543 >> 交出，将敌人拒之门外
step
.isOnQuest 11539
.goto Isle of Quel'Danas,49.4,40.0
.turnin 11539 >> 转入接管港口
step
#label isleofquel
.isOnQuest 11540
.goto Isle of Quel'Danas,49.4,40.0
.turnin 11540 >> 转入粉碎黎明之刃
step
.itemcount 33102,1
>> 这一步需要召唤一个幽灵之地和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.goto Ghostlands,70.4,67.8
.use 33102 >> 用祖金之血接受任务
.accept 11178 >> 接受军阀之血
.turnin 11178 >> 交出军阀的鲜血
.accept 11163 >> 接受Undercover Sister
step
.isQuestTurnedIn 11178
.goto Ghostlands,70.6,68.2
.turnin 11163 >> 交卧底修女
step << Alliance
.isOnQuest 7141
.goto Alterac Mountains,40.6,79.8
>> 这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 7141 >> 交出奥特兰克战役
step << Alliance
.isQuestAvailable 8271
.goto Alterac Mountains,40.6,79.8
>> 这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 8271 >> 交出风暴英雄
step << Alliance
.isQuestAvailable 7169
.goto Alterac Mountains,39.6,81.2
>> 这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 7169 >> 在守卫中光荣归来
step << Alliance
.isQuestAvailable 7170
.goto Alterac Mountains,39.6,81.2
>> 这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 7170 >> 获得尊敬
step << Alliance
.isQuestAvailable 7171
.goto Alterac Mountains,39.6,81.2
>> 这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 7171 >> 交出传奇英雄
step << Alliance
.isQuestAvailable 7172
.goto Alterac Mountains,39.6,81.2
>> 这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 7172 >> 交给指挥之眼
step << Horde
.isOnQuest 7142
.goto Alterac Mountains,63.0,60.0
>> 这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 7142 >> 交出奥特兰克战役
step << Horde
.isQuestAvailable 8272
.goto Alterac Mountains,63.0,60.0
>> 这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 8272 >> 交出《霜狼英雄》
step << Horde
.isQuestAvailable 7164
.goto Alterac Mountains,62.2,58.9
>> 这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 7164 >> 在守卫中光荣归来
step << Horde
.isQuestAvailable 7165
.goto Alterac Mountains,62.2,58.9
>> 这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 7165 >> 获得尊敬
step << Horde
.isQuestAvailable 7166
.goto Alterac Mountains,62.2,58.9
>> 这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 7166 >> 交出传奇英雄
step << Horde
.isQuestAvailable 7167
.goto Alterac Mountains,62.2,58.9
>> 这一步需要召唤奥特兰克山脉和一个回到沙塔斯的法师入口才能有效，如果你没有这些入口，请跳过。
.turnin 7167 >> 交给指挥之眼
step
#completewith postav
.zoneskip Ghostlands,1
.zone Shattrath City >> 抵达沙塔斯市
>> 港口至沙塔斯。请勿使用炉缸 << !Shaman
>> 沙塔斯港口或港口 << Shaman
step
#completewith postav
.zoneskip Alterac Mountains,1
.zone Shattrath City >> 抵达沙塔斯市
>> 港口至沙塔斯。请勿使用炉缸 << !Shaman
>> 沙塔斯港口或港口 << Shaman
step
#completewith postav
.zoneskip Isle of Quel'Danas,1
.zone Shattrath City >> 抵达沙塔斯市
>> 港口至沙塔斯。请勿使用炉缸 << !Shaman
>> 沙塔斯港口或港口 << Shaman
step
#sticky
#label postav
.zone Shattrath City >> 回到沙塔斯市。如果您已经在外域，请手动跳过此步骤。
step << Horde
.isQuestTurnedIn 9928
.goto Nagrand,73.8,62.6
.accept 9934 >> 接受发给Garadar的消息。
step << Alliance
.isQuestTurnedIn 9932
.goto Nagrand,73.8,62.6
.accept 9933 >> 接受发送给Telaar的消息。
step
.isOnQuest 10251
.goto Nagrand,51.8,56.8
.turnin 10251 >> 提交大师的宏伟设计？
step << Horde
.isOnQuest 9934
.goto Nagrand,55.4,37.6
.turnin 9934 >> 将消息交给Garadar。
step << Horde
.isOnQuest 9937
.goto Nagrand,55.8,37.8
.turnin 9937 >> 通缉犯：饥饿者杜伦
step << Alliance
.isOnQuest 11502
.goto Nagrand,55.8,73.6
.turnin 11502 >> 为哈拉辩护
step << Alliance
.isOnQuest 9933
.goto Nagrand,55.4,68.8
.turnin 9933 >> 将消息交给Telaar。
step << Alliance
.isOnQuest 9938
.goto Nagrand,55.8,37.8
.turnin 9938 >> 通缉犯：饥饿者杜伦
step << Alliance
.itemcount 24559,1
.goto Nagrand,55.4,68.8
.use 24559 >> 使用库存中的黑血入侵计划接受任务
.accept 9871 >> 接受混血入侵者
.turnin 9871 >> 交出黑血侵略者
step << Alliance
.itemcount 25433,10
.goto Nagrand,54.8,70.8
.accept 10476 >> 接受凶猛的敌人。
.turnin 10476 >> 交出凶猛的敌人。
step << Horde
.goto Nagrand,57.0,34.8
>> 在小屋周围找到Drakia夫人
.unitscan Matron Drakia
.accept 9944 >> 接受失踪的玛格哈里游行。
step
.goto Nagrand,31.4,57.6
.reputation 933,neutral,<0,1
.itemcount 25416,10
.accept 9882 >> 接受小偷的偷窃
.turnin 9882 >> 从小偷那里偷窃上缴
step
.goto Nagrand,31.6,56.8
.reputation 933,neutral,<0,1
.itemcount 25463,3
>> 交上一个装满象牙的脑袋，直到你友好为止。总共应该有9个营业额。
.accept 9914 >> 接受满头象牙
.turnin 9914 >> 满头象牙
step
.goto Nagrand,31.4,57.6
.reputation 933,friendly,<0,1
.itemcount 25433,10
.accept 9893 >> 接受黑曜石战珠
.turnin 9893 >> 交出黑曜石战珠
step << Horde
>> 如果由联盟控制，请跳过此步骤。
.itemcount 26042,20
.goto Nagrand,41.2,44.3
.accept 10074 >> 接受Oshu'gun水晶粉
.turnin 10074 >> 交出Oshu'gun水晶粉
step << Horde
.isOnQuest 10010
.goto Nagrand,27.4,43.0
.turnin 10010 >> 就这么简单？
step << Horde
.isOnQuest 10649
.goto Nagrand,27.4,43.0
.turnin 10649 >> 上交恶魔名录
step << Horde
.isOnQuest 9944
.goto Nagrand,32.2,36.2
.turnin 9944 >> 交上失踪的玛格哈里游行。
step << Horde
.isQuestTurnedIn 9865
.goto Nagrand,32.4,36.0
.accept 9866 >> 接受他将行走地球。。。
step << Horde
.isOnQuest 11503
.goto Nagrand,52.8,36.0
.turnin 11503 >> 交出新老敌人
step << Horde
.isOnQuest 9866
.goto Nagrand,54.8,39.8
.turnin 9866 >> 他将在地球上行走。。。
step << Horde
.itemcount 24558,1
.goto Nagrand,55.4,37.6
.use 24558 >> 使用库存中的黑血入侵计划接受任务
.accept 9872 >> 接受混血入侵者
.turnin 9872 >> 交出黑血侵略者
step << Horde
.isQuestAvailable 9870
.goto Nagrand,55.6,37.8
>> 在镇上找到元素师Yal'hah
.unitscan Elementalist Yal'hah
.accept 9870 >> 接受元素的王座。
step << Horde
.itemcount 25433,10
.goto Nagrand,55.8,37.8
.accept 10479 >> 接受证明你的力量。
.turnin 10479 >> 转而证明你的实力。
step << Horde
.isOnQuest 9870
.goto Nagrand,60.6,22.2
.turnin 9870 >> 交出元素之王座。
step << Horde
.isOnQuest 9853
.goto Nagrand,61.2,22.2
.turnin 9853 >> 交出暴徒古洛克
step << Horde
.itemcount 24504,1
.goto Nagrand,60.6,22.2
.use 24504 >> 使用库存中的啸风接受任务
.accept 9861 >> 接受呼啸的风
.turnin 9861 >> 《呼啸的风》
step << Alliance
.isOnQuest 10010
.goto Nagrand,27.4,43.0
.turnin 10010 >> 就这么简单？
step << Alliance
.isOnQuest 10649
.goto Nagrand,24.7,43.0
.turnin 10649 >> 上交恶魔名录
step << Alliance
>> 如果它被部落控制，跳过这一步。
.itemcount 26043,20
.goto Nagrand,41.2,44.2
.accept 10076 >> 接受Oshu'gun水晶粉
.turnin 10076 >> 交出Oshu'gun水晶粉
step << Alliance
.itemcount 24504,1
.goto Nagrand,60.6,22.2
.use 24504 >> 使用库存中的啸风接受任务
.accept 9861 >> 接受呼啸的风
.turnin 9861 >> 《呼啸的风》
step << Alliance
.isOnQuest 9853
.goto Nagrand,61.2,22.2
.turnin 9853 >> 交出暴徒古洛克
step
.isOnQuest 9977
.goto Nagrand,42.8,20.6
.turnin 9977 >> 交出血环：最后的挑战
step
.isOnQuest 9697
.goto Zangarmarsh,23.2,66.2
>> 如果她不在这里，可能有人最近提交了一个任务，导致她消失。如果这个地方人满为患，不要等她，跳过这一步。
.turnin 9697 >> 交给观察者Leesa'oh
step
.isQuestAvailable 9697
.goto Zangarmarsh,23.2,66.2
.accept 9701 >> 接受对Sporelings的观察
step
.itemcount 24291,6
.goto Zangarmarsh,19.0,62.6
.accept 9743 >> 接受天敌
.turnin 9743 >> 交出天敌
step
.itemcount 24290,10
.goto Zangarmarsh,19.0,62.6
.accept 9739 >> 接受Sporelings的困境
.turnin 9739 >> 把斯普林斯夫妇的困境交出来
step
.isQuestAvailable 9919
.goto Zangarmarsh,19.0,63.6
.reputation 970,neutral,<0,1 >> 你必须对斯波雷加保持中立才能接受这个任务
.accept 9919 >> 接受斯波雷加
step
.isOnQuest 9701
.goto Zangarmarsh,15.3,61.9
>> 探索该地区。
.complete 9701,1
.complete 9701,2
step
.isOnQuest 9919
.goto Zangarmarsh,19.6,52.0
.turnin 9919 >> 交给斯波雷加
step
#completewith next
.goto Zangarmarsh,19.0,62.6
.reputation 970,friendly >> 完成转向沼泽主卷须或成熟孢子囊，直到你友好。
step
.itemcount 24246,5
.goto Zangarmarsh,19.5,50.1
.reputation 970,friendly,<0,1
.accept 9715 >> 接受给我一个灌木丛！
.turnin 9715 >> 进来，给我拿灌木丛！
step
.itemcount 24449,6
.goto Zangarmarsh,19.2,49.4
.reputation 970,friendly,<0,1
.accept 9806 >> 接受可育孢子
.turnin 9806 >> 交出可育孢子
step
.goto Zangarmarsh,19.2,49.4
.reputation 970,friendly,<0,1
.itemcount 24245,10
.accept 9808 >> 接受Glowcap蘑菇
.turnin 9808 >> 倒入Glowcap蘑菇
step
#label sporenomore
.itemcount 25459,1
.goto Zangarmarsh,23.2,66.2
.use 25459 >> 使用库存中的“数”Ungula的下颌骨来接受任务
.accept 9911 >> 接受沼泽伯爵
.turnin 9911 >> 交出沼泽伯爵
step
.isOnQuest 9701
.goto Zangarmarsh,23.2,66.2
.turnin 9701 >> 轮流观察Sporelings
step << Horde
.isOnQuest 9775
.goto Zangarmarsh,30.6,50.8
>> 他在小屋的二楼
.turnin 9775 >> 向暗影猎手丹杰提交报告。
step << Horde
.isQuestAvailable 9795
.goto Zangarmarsh,30.6,50.8
.accept 9795 >> 接受食人魔威胁。
step << skip 
.isQuestTurnedIn 9968
.goto Terokkar Forest,44.4,26.2
.turnin 9957 >> 交出塞纳里昂灌木丛出了什么问题？
step << Alliance
.isQuestAvailable 9794
.goto Zangarmarsh,41.2,28.6
.accept 9794 >> 接受没有时间的好奇心。
step
.isOnQuest 9738
.goto Zangarmarsh,52.2,36.0
>> 进入湖中央的水下水库
.turnin 9738 >> Turn in Lost In Action
step
.isOnQuest 9763
.goto Zangarmarsh,52.2,36.0
.turnin 9763 >> 交出军阀的藏身处
step << Alliance
.isOnQuest 9794
.goto Blade's Edge Mountains,36.0,67.8
.turnin 9794 >> 提交“没有时间好奇”。
step << Alliance
.itemcount 29443,11
.goto Blade's Edge Mountains,37.4,64.6
.accept 10511 >> 接受奇怪的酿造。
.turnin 10511 >> 交上奇怪的啤酒。
step << Alliance
.isQuestAvailable 10581
.goto Blade's Edge Mountains,36.6,66.4
.accept 10580 >> 接受那些该死的侏儒去了哪里？
step
.isOnQuest 11000
.goto Blade's Edge Mountains,55.4,44.9
.turnin 11000 >> 转入Soulgrinder
step
.isQuestTurnedIn 11000
.goto Blade's Edge Mountains,55.4,44.9
.accept 11009 >> 接受食人魔天堂
step << Horde
.isOnQuest 10742
.goto Blade's Edge Mountains,51.8,58.4
.turnin 10742 >> 进入决战
step << Alliance
.isOnQuest 10806
.goto Blade's Edge Mountains,53.2,41.2
.turnin 10806 >> 进入决战
step << Horde
.isOnQuest 9795
.goto Blade's Edge Mountains,51.8,57.8
.turnin 9795 >> 交上食人魔威胁。
step
.isOnQuest 11009
.goto Blade's Edge Mountains,28.7,57.4
.turnin 11009 >> 交给食人魔天堂
step
.itemcount 32569,5
.goto Blade's Edge Mountains,28.8,57.4
.accept 11025 >> 接受水晶。
.turnin 11025 >> 把水晶交上来。
step
.itemcount 32598,1
.goto Blade's Edge Mountains,28.4,57.6
.accept 11030 >> 接受我们的男孩想成为一名空中警卫护卫员。
.turnin 11030 >> 上缴我们的男孩想成为一名空中警卫突击队员。
step
.itemcount 32601,1
.goto Blade's Edge Mountains,28.4,57.6
.accept 11061 >> 接受父亲的责任
.turnin 11061 >> 履行父亲的职责
step << Alliance
.isOnQuest 10580
.goto Blade's Edge Mountains,55.0,72.8
.turnin 10580 >> 上车那些该死的侏儒去哪里了？
step << Alliance
.isQuestTurnedIn 10580
.goto Blade's Edge Mountains,55.0,72.8
.accept 10581 >> 接受跟踪面包屑。
step << Alliance
.isOnQuest 10581
.goto Blade's Edge Mountains,60.4,69.0
.turnin 10581 >> 打开Follow the Breadcrumbs。
step
.itemcount 31384,1
.goto Blade's Edge Mountains,62.6,40.2
.use 31384
.accept 10810 >> 接受你库存中任务物品中的损坏面具。
.turnin 10810 >> 交回损坏的面罩。
.accept 10812 >> 接受神秘面具。
step
.itemcount 31489,1
.goto Blade's Edge Mountains,62.0,39.4
.use 31489 >> 使用你库存中的狮鹫之珠接受任务
.accept 10825 >> 接受真相
.turnin 10825 >> 揭开真相
step
.isQuestAvailable 10682
.goto Blade's Edge Mountains,62.0,39.4
.accept 10682 >> 接受谈判时间。。。
step
.isOnQuest 10682
.goto Blade's Edge Mountains,62.7,44.0,80,0
.goto Blade's Edge Mountains,58.5,39.4,80,0
.goto Blade's Edge Mountains,62.0,32.1
.line Blade's Edge Mountains,63.0,45.8,58.4,38.6,63.0,27.2
.unitscan Overseer Nuaar
>> 上上下下找监督努尔，然后和他说话
.skipgossip
.complete 10682,1
step
.isOnQuest 10682
.goto Blade's Edge Mountains,62.0,39.4
.turnin 10682 >> 提交谈判时间。。。
step
.isOnQuest 10812
.goto Blade's Edge Mountains,61.6,38.4
>> 任务给予者在城市里绕着我走了一圈。
.turnin 10812 >> 交上神秘面具。
step
.isQuestTurnedIn 10819
.goto Blade's Edge Mountains,61.6,38.4
.accept 10819 >> 接受恶棍防毒面具。
step
.isOnQuest 10819
.goto Blade's Edge Mountains,73.3,40.1
.use 31366 >> 戴上恶棍防毒面具。
.turnin 10819 >> 交上恶棍防毒面具。
step << Horde
.itemcount 31670,3
.goto Blade's Edge Mountains,76.0,60.2
.accept 10860 >> 接受Mok'Nathal Treats。
.turnin 10860 >> 提交Mok'Nathal Treats。

step
.isQuestAvailable 10317
.goto Netherstorm,34.6,37.8
.accept 10317 >> 接受与工头的交易。
step
.isOnQuest 10317
.goto Netherstorm,26.4,42.2
.turnin 10317 >> 交给矿内的工头处理。
step
.isOnQuest 9631
.goto Netherstorm,32.2,63.6
.turnin 9631 >> 提交同事的帮助。
step
.isQuestTurnedIn 10186
.goto Netherstorm,32.7,64.9
.accept 10225 >> 接受工程报告
step
.isOnQuest 10225
.goto Netherstorm,32.4,66.6
.turnin 10225 >> 向工程部提交报告
step
#aldor
.isQuestTurnedIn 10407
.goto Netherstorm,32.0,64.2
.accept 10410 >> 接受Ishanah的帮助
step
#scryer
.isQuestTurnedIn 10508
.goto Netherstorm,32.0,64.0
.accept 10509 >> 接受荣耀的约束。
step
.isQuestTurnedIn 10248
.goto Netherstorm,37.2,63.8
.accept 10249 >> 接受返回酋长！
step
.isOnQuest 10249
.goto Netherstorm,32.6,64.8
.turnin 10249 >> 交回首领！
step
.isQuestTurnedIn 10312
.goto Netherstorm,57.4,86.2
.accept 10316 >> 接受证据搜索。
step
>> 进入塔内，到达塔顶。
.itemcount 28769,1
.goto Netherstorm,58.2,86.4
.turnin 10257 >> 缴获钥匙石
step
.isQuestAvailable 10334
.goto Netherstorm,57.6,85.0
.accept 10334 >> 接受需要更多的牛铃。
step
.itemcount 29233,1
.goto Netherstorm,56.9,86.8
.use 29233 >> 使用Dathric之刃接受任务
.accept 10182 >> 接受战斗法师Dathric
step
.itemcount 29235,1
.goto Netherstorm,56.4,87.8
.use 29235 >> 使用Luminrath的斗篷接受任务
.accept 10306 >> 接受魔术师Luminrath
step
.itemcount 29236,1
.goto Netherstorm,55.5,87.0
.use 29236 >> 使用科林的帽子接受任务
.accept 10307 >> 接受科林·弗罗斯特韦弗
step
.itemcount 29234,1
.goto Netherstorm,55.5,86.5
.use 29234 >> 使用Belmara的Tome接受任务
.accept 10305 >> 接受Abjurit Belmara
step
.isOnQuest 10182
.goto Netherstorm,56.9,86.8
.use 28351 >> 使用任务物品将拿督之刃放置在市政厅内的武器架上
.complete 10182,1
step
.isOnQuest 10307
.goto Netherstorm,55.5,87.0
.use 28353 >> 使用任务物品将科琳的帽子放在房间的搁脚柜内
.complete 10307,1
step
.isOnQuest 10305
.goto Netherstorm,55.5,86.5
.use 28336 >> 使用任务物品将Belmara的Tome放在她家的书架上
.complete 10305,1
step
.isOnQuest 10306
.goto Netherstorm,56.4,87.8
.use 28352 >> 使用任务物品将Luminrath的披风放置在他家的梳妆台上
.complete 10306,1
step
.isOnQuest 10307
.goto Netherstorm,57.4,86.2
.turnin 10307 >> 交出科利安·弗罗斯特韦弗
step
.isOnQuest 10182
.goto Netherstorm,57.4,86.2
.turnin 10182 >> 交出战斗法师达思里克
step
.isOnQuest 10305
.goto Netherstorm,57.4,86.2
.turnin 10305 >> 移交Abjurit Belmara
step
.isOnQuest 10306
.goto Netherstorm,57.4,86.2
.turnin 10306 >> 交给魔术师Luminrath
step
.isOnQuest 10334
.goto Netherstorm,59.2,78.8
.turnin 10334 >> 转弯需要更多的牛铃。
step
.isOnQuest 10316
.goto Netherstorm,60.3,78.0
.turnin 10316 >> 在谷仓内寻找证据。
step
.isQuestTurnedIn 10418
.goto Netherstorm,46.4,56.4
.accept 10423 >> 接受风暴精灵。
step
.isQuestTurnedIn 10433
.goto Netherstorm,46.4,56.4
.accept 10434 >> 接受动感双人组。
step
>> 点击收发器吊舱
.isOnQuest 10408
.goto Netherstorm,56.8,38.6
.turnin 10408 >> 交给Nexus King Salhadaar
step
.itemcount 29738,1
.goto Netherstorm,59.2,32.4
.use 29738 >> 使用库存中的虚空恐怖软泥小瓶接受任务
.accept 10413 >> 接受污染的恐怖
.turnin 10413 >> 交出污染的恐怖
step
.isOnQuest 10439
.goto Netherstorm,60.0,31.8
.turnin 10439 >> 在维度中转向所有吞噬
step
.isOnQuest 10423
.goto Netherstorm,43.6,35.0
.turnin 10423 >> 转向风暴精灵。
step
.isOnQuest 10434
.goto Netherstorm,44.8,36.6
.turnin 10434 >> 打开动感双人组。
step
.isQuestTurnedIn 10276
.goto Netherstorm,45.8,36.0
>> 接受任务后，穿过左边的紫色圆圈传送带传送到沙塔斯
.accept 10280 >> 接受特快专递至沙塔斯市
step
#completewith shat
.zone Shattrath City >> 前往沙塔斯。如果你有时间之穴任务要交出，不要做壁炉。如果你有到沙塔斯城的特别配送任务，请使用它提供给沙塔斯的门户。
step
.isOnQuest 10280
.goto Shattrath City,54.0,44.6
.turnin 102080 >> 将特快专递交给沙塔斯市
step
#aldor
.isOnQuest 10410
.goto Shattrath City,24.2,29.8
.turnin 10410 >> 交给Ishanah的帮助
step
#scryer
.isOnQuest 10509
.goto Shattrath City,42.6,91.6
.turnin 10509 >> 为荣耀而战。
step
#label shat
.isOnQuest 11024
.goto Shattrath City,52.6,20.8
.turnin 11024 >> 在下城交出盟友
step
.goto Shattrath City,74.7,31.5
.reputation 989,revered,<0,1 >> 如果你受到时间守护神的尊敬，请与西风谈谈，让他把你送到时间之穴
.zone Tanaris >> 如果你受到时间守护神的尊敬，请与西风谈谈，让他把你送到时间之穴
step
.zoneskip Tanaris
.goto Tanaris,66.1,49.7
+ 获得时间之穴的召唤。如果你没有指南，指南已经完成了，如果你需要跑去那里，就不值得花时间了。去诺森德！
step
.isOnQuest 10445
.goto Tanaris,58.3,54.8
>> 阿拉兹莫杜和索里多米逆时针在房间里巡逻，四处跑，直到你找到他们。
.unitscan Soridomi
.turnin 10445 >> 把永恒的瓶子交上来
step
.goto Tanaris,58.3,54.8
.reputation 989,friendly,<0,1
>> 阿拉兹莫杜和索里多米逆时针在房间里巡逻，四处跑，直到你找到他们。接受你选择的戒指任务。这不是自动进行的，以防止拾取错误的戒指。如果没有友情戒指任务可用，请跳过此步骤。
.unitscan Soridomi
.dailyturnin 10462,10461,10460,10463 >> 递交戒指誓言
step
.goto Tanaris,58.3,54.8
.reputation 989,honored,<0,1
>> 阿拉兹莫杜和索里多米逆时针在房间里巡逻，四处跑，直到你找到他们。
.unitscan Soridomi
.daily 10464,10465,10466,10467 >> 接受誓言戒指任务
.dailyturnin 10464,10465,10466,10467 >> 交出一个誓言戒指任务
step
.goto Tanaris,58.3,54.8
.reputation 989,revered,<0,1
>> 阿拉兹莫杜和索里多米逆时针在房间里巡逻，四处跑，直到你找到他们。
.unitscan Soridomi
.daily 10468,10469,10470,10471 >> 接受誓言戒指任务
.dailyturnin 10468,10469,10470,10471 >> 交出誓言戒指任务
step
.goto Tanaris,58.3,54.8
.reputation 989,exalted,<0,1
>> 阿拉兹莫杜和索里多米逆时针在房间里巡逻，四处跑，直到你找到他们。
.unitscan Soridomi
.daily 10472,10473,10474,10475 >> 接受盟约戒指任务
.dailyturnin 10472,10473,10474,10475 >> 交出盟约戒指任务
step
.isOnQuest 10297
.goto Tanaris,57.6,62.7
>> 进入黑沼泽并完成任务
.turnin 10297 >> 打开黑暗之门
step
#label cavernsdone
+是时候去北风苔原、咆哮峡湾或直接去龙枯草岛了，如果71+，感觉很愉快。玩得高兴
]])
RXPGuides.RegisterGuide([[
#version 5
#wotlk
#group 地下城 刷本 70-80
<< Alliance
#name 70-80 联盟 地下城 刷本
step << !Mage
#completewith next
.zone Stormwind City >> 旅行或将法师传送到暴风城
.zoneskip Elwynn Forest
step << !Mage !DK !Druid
#completewith ALFP
.goto Stormwind City,60.39,75.27
.home >> 将您的炉石设置为暴风城
step << Mage
#completewith next
.zone Stormwind City >> 传送到暴风城
.xp <71,1
step << Mage
.goto Stormwind City,49.26,87.77
>>如果你预选到71岁，请接受训练
>>确保你的团队可以通过召唤石或术士召唤来召唤你
.train 43023 >> 训练你的职业咒语
.xp <71,1
step << Shaman
.goto Stormwind City,67.52,89.41
>>如果你预选到71岁，请接受训练
>>确保你的团队可以通过召唤石或术士召唤来召唤你
.train 58699 >> 训练你的职业咒语
.xp <71,1
step << Paladin
.goto Stormwind City,49.60,49.83
>>如果你预选到71岁，请接受训练
>>确保你的团队可以通过召唤石或术士召唤来召唤你
.train 54428 >> 训练你的职业咒语
.xp <71,1
step << Warlock
#completewith next
.goto Stormwind City,29.2,74.0,20,0
.goto Stormwind City,27.2,78.1,15 >> 走进屠宰羔羊，下楼去
step << Warlock
.goto Stormwind City,39.89,84.19
>>如果你预选到71岁，请接受训练
>>确保你的团队可以通过召唤石或术士召唤来召唤你
.train 47812 >> 训练你的职业咒语
.xp <71,1
step << Hunter
.goto Stormwind City,67.35,36.26
>>如果你预选到71岁，请接受训练
>>确保你的团队可以通过召唤石或术士召唤来召唤你
.train 49051 >> 训练你的职业咒语
.xp <71,1
step
#completewith Boat
+欢迎使用RXPGuides 70-80地牢裂口指南！
step << Shaman/Priest/Druid/Mage/Paladin
.goto Stormwind City,63.20,74.92
>>从大楼内的Horthus购买试剂
.collect 17030,20 << Shaman 
.collect 17029,40 << Priest 
.collect 22148,40 << Druid 
.collect 22147,40 << Druid 
.collect 17032,40 << Mage 
.collect 17020,40 << Mage 
.collect 21177,100 << Paladin 
.xp >72,1
step << Druid
#completewith next
.cast 18960 >> 铸造Teleport:Moonglade
.zoneskip Moonglade
.xp <71,1
step << Druid
.goto Moonglade,52.4,40.6
>>如果你预选到71岁，请接受训练
>>前往Moonglade。确保你的团队可以通过召唤石来召唤你到Nexus/Ragefire Chasm或术士召唤
.train 48442 >> 训练你的职业咒语
.xp <71,1
step << Druid/Shaman/Paladin/Hunter/Warlock
#completewith next
.hs >> 火炉到暴风城，或被传送/召唤到Borean Tundra/The Nexus/The Boat to Borean Tondra
.zoneskip Elwynn Forest
.zoneskip Stormwind City
.xp <71,1
step
#label Boat
.goto Stormwind City,43.5,52.7,70,0
.goto Stormwind City,17.7,25.5
.zone BoreanTundra >>前往暴风港。船到了就上船。带它去Borean Tundra
.zoneskip Dragonblight
.zoneskip ZulDrak
.zoneskip The Storm Peaks
.zoneskip Dalaran
.zoneskip 129 
.zoneskip 159 
.zoneskip 157 
.zoneskip 132 
.zoneskip 154 
.zoneskip 138 
step
.goto Stormwind City,43.5,52.7,70,0
.goto Stormwind City,17.7,25.5
.zone BoreanTundra >>前往暴风港。船到了就上船。带它去Borean Tundra
.xp >72,1
step
.goto BoreanTundra,58.97,68.29
.fp Valiance Keep >> 获取Valiance保持飞行路线
.xp >72,1
step
#completewith Hawthorn5
.groundgoto BoreanTundra,58.5,68.3,15,0
.goto BoreanTundra,58.29,68.05
>>与詹姆斯交谈
.vendor 25245 >> 买很多新食物。在下一次休息之前，你将在接下来的3个关卡中进行地下城训练 << Warrior/Rogue/DK
.vendor 25245 >> 买很多新的食物/水。在下一次休息之前，你将在接下来的3个关卡中进行地下城训练 << !Warrior !Rogue !DK
.xp >72,1
step
>>与招募官Rollick谈谈，然后是Keep内的Arlos
.accept 11672 >>接受报名日
.goto BoreanTundra,57.85,67.60
.accept 13088 >> 接受北方烹饪
.goto BoreanTundra,57.93,71.54
.turnin 11672 >>报名日上交
.accept 11727 >>接受英雄时代
.goto BoreanTundra,57.1,71.8,15,0
.goto BoreanTundra,57.2,72.3,15,0
.goto BoreanTundra,56.67,72.64
.skill cooking,<350,1
step
>>与招募官员交谈，然后与阿洛斯在要塞内交谈
.accept 11672 >>接受报名日
.goto BoreanTundra,57.85,67.60
.turnin 11672 >>报名日上交
.accept 11727 >>接受英雄时代
.goto BoreanTundra,57.1,71.8,15,0
.goto BoreanTundra,57.2,72.3,15,0
.goto BoreanTundra,56.67,72.64
step
#label Hawthorn5
>>与Hammerhill和Hawthorn交谈
.turnin 11727 >>为英雄报仇
.accept 11797 >>接受围攻
.goto BoreanTundra,56.36,69.58
.accept 11789 >>接受有需要的士兵
.goto BoreanTundra,55.00,68.91
step
.goto BoreanTundra,53.5,69.1,70,0
.goto BoreanTundra,53.1,72.8
>>杀死该地区的地穴爬虫
.complete 11797,1 
step
.goto BoreanTundra,56.36,69.58
>>返回Hammerhill
.turnin 11797 >>转入围攻
.accept 11889 >>接受来自上方的死亡
step
.goto BoreanTundra,54.8,70.2
.use 35278 >>使用袋子中的加固网击落附近飞行的火焰喷射器。杀了他们
.complete 11889,1 
step
.goto BoreanTundra,56.36,69.58
>>返回Hammerhill
.turnin 11889 >>自上而下的死亡
.accept 11897 >>接受堵塞水槽
step
.goto BoreanTundra,56.96,68.75,10,0
>>进入镇中心的风暴断路器（船）。抢劫箱子并点击船后面的祭坛
.complete 11789,1 
.goto BoreanTundra,57.50,69.27
.accept 11920 >>接受我们中间的信徒
.goto BoreanTundra,57.56,69.13
step
.goto BoreanTundra,56.96,68.75,10,0
>>从船上跑出来。与“左撇子”船长和坎特伯雷上将交谈
.turnin 11920 >>在我们中间交出信徒
.goto BoreanTundra,57.83,69.20
.accept 11791 >>接受通知Arlos
.goto BoreanTundra,57.79,69.19
step
>>在Valiance的要塞与Arlos、Talbot和Vureen交谈。然后在外面和山楂谈谈
.turnin 11791 >>上车通知Arlos
.goto BoreanTundra,56.67,72.64
.accept 12141 >>接受外交使团
.goto BoreanTundra,56.72,72.62
.accept 11792 >>接受光明的敌人
.goto BoreanTundra,56.60,72.46
.turnin 11789 >>交出需要帮助的士兵
.goto BoreanTundra,55.00,68.91
step
.goto BoreanTundra,54.08,63.73,-1
.goto BoreanTundra,54.77,63.08,-1
.use 35704 >> 在天坑处用你袋子里的易燃炸药把它封住
.complete 11897,2 
step
.loop 40,BoreanTundra,54.04,62.42,53.84,60.33,55.25,63.43,54.04,62.42
>>杀死邪教死尸。抢劫他们的公报
.complete 11792,1 
step
.goto BoreanTundra,50.46,71.38,-1
.goto BoreanTundra,50.88,72.29,-1
.use 35704 >> 在天坑处用你袋子里的易燃炸药把它封住
.complete 11897,1 
step
#completewith Karuk5
+如果你愿意的话，你可以在任何时候跳过任何激流滩任务
step
.goto BoreanTundra,47.13,75.49
>>与Karuk交谈
.turnin 12141 >>递交外交使团
.accept 11613 >>接受卡鲁克的誓言
.isOnQuest 12141
step
.goto BoreanTundra,47.13,75.49
>>与Karuk交谈
.accept 11613 >>接受卡鲁克的誓言
.isQuestTurnedIn 12141
step
#requires Cruelty1
>>杀死该地区的斯卡迪尔龙舟人和袭击者
.complete 11613,2 
.goto BoreanTundra,49.2,79.2
.complete 11613,1 
.goto BoreanTundra,44.6,80.5
.isOnQuest 11613
step
#completewith Karuk2
#label CTPrisoner2
.goto BoreanTundra,44.10,77.90,50,0
>>杀死一个（或更多）围绕被俘虏塔斯卡尔囚犯的斯卡迪尔，然后杀死Ripplash Myrmidon。之后与囚犯交谈
>>如果他现在不起来，就忽略这个
.accept 12471 >>接受克瓦尔迪尔的残忍
.unitscan Captured Tuskarr Prisoner
.isOnQuest 11613
step
#completewith end
#requires CTPrisoner2
#label Cruelty2
.goto BoreanTundra,47.13,75.49
.turnin 12471 >>交出克瓦尔迪尔的残忍
.isOnQuest 12471
step
.goto BoreanTundra,47.13,75.49
>>与Karuk交谈
.turnin 11613 >>交上卡鲁克的誓言
.accept 11619 >>接受残酷的Gamel
.isQuestComplete 11613
step
#label Karuk2
.goto BoreanTundra,47.13,75.49
>>与Karuk交谈
.accept 11619 >>接受残酷的Gamel
.isQuestTurnedIn 11613
step
#requires Cruelty2
.groundgoto BoreanTundra,46.3,78.8,20,0
.goto BoreanTundra,46.42,78.23
>>进入洞穴。杀死Gamel
.complete 11619,1 
.isOnQuest 11619
step
#completewith Karuk3
#label CTPrisoner3
.goto BoreanTundra,44.10,77.90,50,0
>>杀死一个（或更多）围绕被俘虏塔斯卡尔囚犯的斯卡迪尔，然后杀死Ripplash Myrmidon。之后与囚犯交谈
>>如果他现在不起来，就忽略这个
.accept 12471 >>接受克瓦尔迪尔的残忍
.unitscan Captured Tuskarr Prisoner
.isOnQuest 11619
step
#completewith end
#requires CTPrisoner3
#label Cruelty3
.goto BoreanTundra,47.13,75.49
.turnin 12471 >>交出克瓦尔迪尔的残忍
.isOnQuest 12471
step
.goto BoreanTundra,47.13,75.49
>>与Karuk交谈
.turnin 11619 >>把Gamel交给残忍的人
.accept 11620 >>接受父亲的话
.isQuestComplete 11619
step
#label Karuk3
.goto BoreanTundra,47.13,75.49
>>与Karuk交谈
.accept 11620 >>接受父亲的话
.isQuestTurnedIn 11619
step
#completewith Veehja
#label CTPrisoner4
.goto BoreanTundra,44.10,77.90,50,0
>>杀死一个（或更多）围绕被俘虏塔斯卡尔囚犯的斯卡迪尔，然后杀死Ripplash Myrmidon。之后与囚犯交谈
>>如果他现在不起来，就忽略这个
.accept 12471 >>接受克瓦尔迪尔的残忍
.unitscan Captured Tuskarr Prisoner
.isOnQuest 11620
step
#completewith end
#requires CTPrisoner4
.goto BoreanTundra,47.13,75.49
.turnin 12471 >>交出克瓦尔迪尔的残忍
.isOnQuest 12471
step
#completewith end
#label Veehja2
.goto BoreanTundra,43.60,80.53
>>与Veehja交谈。只有当你有足够的水上行走灵丹妙药、与一个涂有鱼油的萨满或一个涂着冰霜之路的死亡骑士结伴时，才能接受这个任务
.accept 11625 >>接受纳粹三叉戟
.isQuestTurnedIn 11619
step
#label Veehja
.goto BoreanTundra,43.60,80.53
>>与Veehja交谈 << !DK
.turnin 11620 >>交出父亲的话
.isOnQuest 11620
step
#requires Veehja2
.goto BoreanTundra,53.7,91.1,40,0
.goto BoreanTundra,54.85,88.78
>>在寺庙内杀死拉格纳尔·德拉卡隆德。为了三叉戟抢劫他
.complete 11625,1 
.isOnQuest 11625
step
.goto BoreanTundra,43.63,80.57
>>返回Veehja
.turnin 11625 >>交出纳粹三叉戟
.isQuestComplete 11625
step
.goto BoreanTundra,43.63,80.57
>>与Veehja交谈
.accept 11626 >>接受使者
.isQuestTurnedIn 11625
step
.goto BoreanTundra,51.90,88.46
.use 35850 >> 去水下利维罗斯。用你袋子里的纳粹三叉戟对他造成很大伤害，然后杀了他
.complete 11626,1 
.isQuestTurnedIn 11625
step
#completewith Karuk5
#label CTPrisoner5
.goto BoreanTundra,44.10,77.90,50,0
>>杀死一个（或更多）围绕被俘虏塔斯卡尔囚犯的斯卡迪尔，然后杀死Ripplash Myrmidon。之后与囚犯交谈
>>如果他现在不起来，就忽略这个
.accept 12471 >>接受克瓦尔迪尔的残忍
.unitscan Captured Tuskarr Prisoner
.isQuestTurnedIn 11625
step
#completewith end
#requires CTPrisoner5
.goto BoreanTundra,47.13,75.49
.turnin 12471 >>交出克瓦尔迪尔的残忍
.isOnQuest 12471
step
#label Karuk5
.goto BoreanTundra,47.13,75.49
>>返回卡鲁克
.turnin 11626 >>交出大使
.isQuestTurnedIn 11625
step
>>在Valiance要塞与Vureen交谈，然后在外面与Rollick、Hammerhill、Mark和Skyhopper交谈
.turnin 11792 >>交出光明的敌人
.accept 11793 >>接受进一步调查
.goto BoreanTundra,56.60,72.46
.turnin 13088 >> 上北方烹饪课
.goto BoreanTundra,57.93,71.54
.turnin 11897 >>转入堵塞水槽
.accept 11928 >>接受Farshire
.goto BoreanTundra,56.36,69.58
.accept 11927 >>接受街头消息
.goto BoreanTundra,56.77,69.51
.accept 11707 >>接受遇险电话
.goto BoreanTundra,58.84,68.72
.isQuestComplete 13088
.skill cooking,<350,1
step
>>在Valiance要塞与Vureen交谈，然后是Hammerhill、Mark和Skyhopperoutside
.turnin 11792 >>交出光明的敌人
.accept 11793 >>接受进一步调查
.goto BoreanTundra,56.60,72.46
.turnin 11897 >>转入堵塞水槽
.accept 11928 >>接受Farshire
.goto BoreanTundra,56.36,69.58
.accept 11927 >>接受街头消息
.goto BoreanTundra,56.77,69.51
.accept 11707 >>接受遇险电话
.goto BoreanTundra,58.84,68.72
step
.goto BoreanTundra,58.5,68.3,15,0
>>到客栈里面去。与Midge交谈
>>上楼去。与Leryssa和Yaala交谈
.accept 11575 >>接受Nick of Time
.goto BoreanTundra,58.41,67.79
.turnin 11927 >>在街上交单词
.accept 11599 >>接受Thassarian，我的兄弟
.goto BoreanTundra,58.4,67.6,15,0
.goto BoreanTundra,58.75,68.36
.turnin 11793 >>提交进一步调查
.accept 11794 >>接受狩猎开始
.goto BoreanTundra,58.55,67.29
step
>>如果你愿意，跳过这个任务
.use 35125 >> 使用包中的驱魔眼。与旅店里的“咸”约翰·索普（John Thorpe）、码头上的汤姆·海格（Tom Hegger）以及要塞下面监狱里的守卫米切尔（Mitchels）交谈。杀了他们
.complete 11794,3 
.goto BoreanTundra,58.57,67.13
.complete 11794,1 
.goto BoreanTundra,59.26,68.19
.complete 11794,2 
.goto BoreanTundra,56.9,72.2,12,0
.goto BoreanTundra,56.72,71.83
.isOnQuest 11794
.skipgossip
step
.goto BoreanTundra,58.21,62.82
>>前往Farshire。与杰拉尔德交谈
.turnin 11928 >>转入Farshire
.accept 11901 >>接受军队？什么军事？
step
.goto BoreanTundra,56.7,57.2,40,0
>>进入Farshire的矿井。点击粮食袋，与威廉的尸体对话
.turnin 11901 >>加入军队？什么军事？
.accept 11902 >>接受有害证据
.goto BoreanTundra,56.81,55.56
.turnin 11599 >>交给Thassarian，我的兄弟
.accept 11600 >>接受已故威廉·阿勒顿
.goto BoreanTundra,56.04,55.42
step
>>与杰拉尔德和耶利米交谈
.turnin 11902 >>提交恶意证据
.accept 11903 >>接受行动时间
.goto BoreanTundra,58.21,62.82
.accept 11908 >>接受参考材料
.goto BoreanTundra,58.19,62.98

.goto BoreanTundra,58.28,62.77
step
#completewith next
>> 杀死该地区的瘟疫清道夫
.complete 11903,1 
step
.goto BoreanTundra,55.75,58.32
>>抢走房子里的红色小书
.complete 11908,1 
step
.loop 50,BoreanTundra,56.84,61.57,55.59,62.11,54.56,60.67,55.89,60.80,55.32,59.32,55.81,57.69,56.83,58.39,56.84,61.57
.use 35491 >>杀死该地区的瘟疫清道夫
.complete 11903,1 
step
>>与杰拉尔德和耶利米交谈
.turnin 11903 >>行动时间到了

.goto BoreanTundra,58.21,62.82,-1
.turnin 11908 >>交回参考材料

.goto BoreanTundra,58.19,62.98,-1
step
.goto BoreanTundra,58.75,68.42
>>跳上购物车，然后跳到她的车窗底部，然后和她说话
.turnin 11600 >>上交已故威廉·阿勒顿
.accept 11601 >>接受失物招领
step
.goto BoreanTundra,58.29,68.05
>>在客栈内与詹姆斯交谈
>>上楼去和雅拉谈谈
.turnin 11601 >>上缴失物招领处
.accept 11603 >>接受葡萄酒，真理
.goto BoreanTundra,58.29,68.05
.turnin 11794 >>开始狩猎
.goto BoreanTundra,58.55,67.29
.isQuestComplete 11794
step
.goto BoreanTundra,58.29,68.05
>>在客栈内与詹姆斯交谈
.turnin 11601 >>上缴失物招领处
.accept 11603 >>接受葡萄酒，真理
.goto BoreanTundra,58.29,68.05
step
.goto BoreanTundra,61.9,65.7
>>如果你没有足够的水上行走灵丹妙药，没有与一个涂有鱼油的萨满结伴，或者没有与一位涂有冰霜之路的死亡骑士结伴，请跳过此任务
>>抢劫船内的小箱子
.complete 11603,1 
.isOnQuest 11603
step
.goto BoreanTundra,58.29,68.05
>>在客栈内与詹姆斯交谈
.turnin 11603 >>在葡萄酒中上缴，真理
.accept 11604 >>接受沙漠者
.isQuestComplete 11603
step
.goto BoreanTundra,58.29,68.05
>>在客栈内与詹姆斯交谈
.accept 11604 >>接受沙漠者
.isQuestTurnedIn 11603
step
.goto BoreanTundra,56.9,72.2,10,0
.goto BoreanTundra,56.68,71.44
>>跑下楼去要塞下面的监狱。与Brau交谈
.turnin 11604 >>移交沙漠者
.accept 11932 >>接受懦夫和傻瓜
.isQuestTurnedIn 11603
step
#completewith next
#label ALFP
.goto BoreanTundra,45.33,34.62
>>前往琥珀色壁架
.fp Amber Ledge >>获取琥珀色壁架飞行路径
.xp >72,1
step
#completewith next
.goto BoreanTundra,45.33,34.62
.fly Coldarra >> 飞往科尔达拉
.zoneskip Dragonblight
.zoneskip ZulDrak
.zoneskip The Storm Peaks
.zoneskip Dalaran
.zoneskip 129 
.zoneskip 159 
.zoneskip 157 
.zoneskip 132 
.zoneskip 154 
.zoneskip 138 
.xp >72,1
step
>>在室内与贝琳纳德交谈，然后在室外与雷洛拉斯兹和塞拉交谈

.accept 11900 >>接受仪表读数
.accept 11910 >>接受古人的秘密
.goto BoreanTundra,32.94,34.40
.accept 11918 >>接受基本培训
.goto BoreanTundra,33.32,34.54
.accept 13094 >>接受他们没有羞耻感吗？
.accept 11912 >>为浆果接受坚果
.goto BoreanTundra,33.49,34.38
.xp >74,1
step
.goto BoreanTundra,28.31,28.46
>>点击Nexus会议石旁边的小圆球
.complete 11900,1 
.isOnQuest 11900
step
#completewith next
.goto Borean Tundra,27.63,25.50
.zone 129 >> 进入Nexus
.xp >74,1
step << Druid/Mage/Shaman/Paladin/Warlock/Hunter
#completewith Nexus
.goto 129,19.23,52.43
>>在被冰冻联盟包围的血腥大厅的地上抢劫书
.complete 13094,1 
step << Druid/Mage/Shaman/Paladin/Warlock/Hunter
#completewith Nexus
.goto 129,65.19,21.67
>>在异常背后的平台上使用Interdimension Refabricator
.complete 11905,1 
.isOnQuest 11905
.use 35479
step << Druid/Mage/Shaman/Paladin/Warlock/Hunter
#completewith Nexus
.goto 129,54.43,55.35,0
.goto 129,58.06,54.54,0
.goto 129,64.85,51.62,0
.goto 129,62.90,64.02,0
.goto 129,49.80,67.54,0
>>杀死结晶保护剂。掠夺他们的分裂者
.complete 11911,1 
.isOnQuest 11911
step << Druid/Mage/Shaman/Paladin/Warlock/Hunter
#label Nexus
.xp 71 >> 研磨Nexus至71级
>>如果达到每小时锁定，请切换到Nexus锁定指南

step << Druid
#completewith next
.cast 18960 >> 铸造Teleport:Moonglade
.zoneskip Moonglade
.xp <71,1
step << Druid
.goto Moonglade,52.4,40.6
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48442 >> 训练你的职业咒语
.xp <71,1
step << Mage
#completewith next
.zone Stormwind City >> 传送到暴风城
.xp <71,1
step << Mage
.goto Stormwind City,49.26,87.77
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 43023 >> 训练你的职业咒语
.xp <71,1
step << Shaman/Paladin/Warlock/Hunter
#completewith next
.hs >> 从火炉到暴风
step << Shaman
.goto Stormwind City,67.52,89.41
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 58699 >> 训练你的职业咒语
.xp <71,1
step << Paladin
.goto Stormwind City,49.60,49.83
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 54428 >> 训练你的职业咒语
.xp <71,1
step << Warlock
.goto Stormwind City,39.89,84.19
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 47812 >> 训练你的职业咒语
.xp <71,1
step << Hunter
.goto Stormwind City,67.35,36.26
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 49051 >> 训练你的职业咒语
.xp <71,1
step << DK/Mage
#completewith Nexus2
.goto 129,19.23,52.43
>>在被冰冻联盟包围的血腥大厅的地上抢劫书
.complete 13094,1 
step << DK/Mage
#completewith Nexus2
.goto 129,65.19,21.67
>>在异常背后的平台上使用Interdimension Refabricator
.complete 11905,1 
.isOnQuest 11905
.use 35479
step << DK/Mage
#completewith Nexus2
.goto 129,54.43,55.35,0
.goto 129,58.06,54.54,0
.goto 129,64.85,51.62,0
.goto 129,62.90,64.02,0
.goto 129,49.80,67.54,0
>>杀死结晶保护剂。掠夺他们的分裂者
.complete 11911,1 
.isOnQuest 11911
step << DK/Mage
#label Nexus2
.groundgoto Borean Tundra,27.75,28.43,40,0
.goto Borean Tundra,27.63,25.09
.xp 72 >> 将Nexus研磨至72级
>>如果达到每小时锁定，请切换到Nexus锁定指南

step << DK
#completewith next
.cast 50977 >> 铸造死亡之门
.zoneskip Eastern Plaguelands
step << DK
.goto Eastern Plaguelands,80.3,48.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 49940 >> 在阿切鲁斯的Amal'Tazad训练你的职业咒语
.xp <72,1
.xp >78,1
step << Mage
#completewith next
.zone Stormwind City >> 传送到暴风城
.xp <72,1
step << Mage
.goto Stormwind City,49.26,87.77
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 42930 >> 训练你的职业咒语
.xp <72,1
step
#completewith Nexus3
.goto 129,19.23,52.43
>>在被冰冻联盟包围的血腥大厅的地上抢劫书
.complete 13094,1 
step
#completewith Nexus3
.goto 129,65.19,21.67
>>在异常背后的平台上使用Interdimension Refabricator
.complete 11905,1 
.isOnQuest 11905
.use 35479
step
#completewith Nexus3
.goto 129,54.43,55.35,0
.goto 129,58.06,54.54,0
.goto 129,64.85,51.62,0
.goto 129,62.90,64.02,0
.goto 129,49.80,67.54,0
>>杀死结晶保护剂。掠夺他们的分裂者
.complete 11911,1 
.isOnQuest 11911
step
#label Nexus3
.groundgoto Borean Tundra,27.75,28.43,40,0
.goto Borean Tundra,27.63,25.09
.xp 73 >> 将Nexus研磨至73级
>>如果达到每小时锁定，请切换到Nexus锁定指南
step << Rogue/Hunter/Warrior/Shaman/Paladin
#completewith next
.hs >> 从火炉到暴风
step << Mage
#completewith next
.zone Stormwind City >> 传送到暴风城
.xp <73,1
step << Mage
.goto Stormwind City,49.26,87.77
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 43019 >> 训练你的职业咒语
.xp <73,1
step << Rogue
.goto Stormwind City,77.42,65.31
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48667 >> 训练你的职业咒语
.xp <73,1
step << Hunter
.goto Stormwind City,67.35,36.26
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 49044 >> 训练你的职业咒语
.xp <73,1
step << Warrior
.goto Stormwind City,77.65,64.31,15,0
.goto Stormwind City,81.45,59.49,15,0
.goto Stormwind City,80.56,59.88
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 47470 >> 训练你的职业咒语
.xp <73,1
step << Shaman
.goto Stormwind City,67.52,89.41
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 49237 >> 训练你的职业咒语
.xp <73,1
step << Paladin
.goto Stormwind City,49.60,49.83
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48931 >> 训练你的职业咒语
.xp <73,1
step
#completewith Berinand
.goto BoreanTundra,33.49,34.38,-1
>>与Serrah交谈
.turnin 13094 >>他们没有羞耻感吗？
.isQuestComplete 13094
step
#completewith AmberL
.goto BoreanTundra,32.94,34.40,-1
.vendor 25314 >> Berinand的供应商和维修
.xp >74,1
step
.goto BoreanTundra,32.94,34.40,-1
>>与Berinand交谈
.turnin 11911 >>车削加速
.turnin 11905 >>营业额推迟了不可避免的事情
.isQuestComplete 11911
.isQuestComplete 11905
step
.goto BoreanTundra,32.94,34.40,-1
>>与Berinand交谈
.turnin 11911 >>车削加速
.isQuestComplete 11911
step
#label Berinand
.goto BoreanTundra,32.94,34.40,-1
>>与Berinand交谈
.turnin 11905 >>营业额推迟了不可避免的事情
.isQuestComplete 11905
step
.goto BoreanTundra,33.49,34.38
>>与Serrah交谈
.turnin 13094 >>他们没有羞耻感吗？
.isQuestComplete 13094
step
#label AmberL
#completewith next
.goto BoreanTundra,33.13,34.45
.fly Amber Ledge >>飞到琥珀色壁架
.zoneskip Dragonblight
.zoneskip ZulDrak
.zoneskip The Storm Peaks
.zoneskip Dalaran
.zoneskip 159 
.zoneskip 157 
.zoneskip 132 
.zoneskip 154 
.zoneskip 138 
step
#completewith next
.goto BoreanTundra,46.62,32.75
>>在塔内与弗雷泽交谈
.vendor 27137 >> 买很多食物。在下一次休息之前，你将在接下来的两个关卡中进行地下城训练 << Warrior/Rogue/DK
.vendor 27137 >> 买很多食物/水。在下一次休息之前，你将在接下来的两个关卡中进行地下城训练 << !Warrior !Rogue !DK
.xp >74,1
step
>>前往卡斯卡拉。与Ataika和Utaik交谈
.turnin 11932 >>收缴懦夫和傻瓜
.accept 12086 >>接受卡库特之子
.accept 11949 >>不打不接受！
.goto BoreanTundra,63.80,46.12
.daily 11945 >>接受做最坏的准备
.goto BoreanTundra,63.95,45.72
step
#requires AbandonAss
#completewith next
.goto BoreanTundra,66.2,45.9,0
.goto BoreanTundra,63.7,52.2,0
>>抢劫村庄周围的小篮子。如果你愿意，可以跳过这个，或者让你的另一个党员抢劫他们
.complete 11945,1 
.isOnQuest 11945
step
#requires AbandonAss
.goto BoreanTundra,67.3,47.7,60,0
.goto BoreanTundra,63.61,53.93
>>杀死村庄周围的袭击者
.complete 11949,1 
step
.goto BoreanTundra,66.2,45.9,60,0
.goto BoreanTundra,63.7,52.2
>>抢劫村庄周围的小篮子。如果你愿意，可以跳过这个，或者让你的另一个党员抢劫他们
.complete 11945,1 
.isOnQuest 11945
step
>>与Ataika和Utaik交谈
.turnin 11949 >>不战而归！
.accept 11950 >>接受穆希特的智慧
.goto BoreanTundra,63.80,46.12
.turnin 11945 >>上车做最坏的准备
.goto BoreanTundra,63.95,45.72
.isQuestComplete 11945
step
>>与Ataika交谈
.turnin 11949 >>不战而归！
.accept 11950 >>接受穆希特的智慧
.goto BoreanTundra,63.80,46.12
step
.goto BoreanTundra,67.21,54.86
>>前往峡湾呼吸湾。与穆希特交谈
.turnin 11950 >>交出穆希特的智慧
.accept 11961 >>接受灵魂守护我们
step
.goto BoreanTundra,67.65,50.41
>>与水下尸体交谈
.complete 11961,1 
.skipgossip
step
.goto BoreanTundra,67.21,54.86
>>返回Muahit
.turnin 11961 >>交出灵魂守护我们
.accept 11968 >>接受潮流转向
step
.goto BoreanTundra,67.41,56.87
>>杀死可怕的海加尔
.complete 11968,1 
.unitscan Heigarr the Horrible
step
>>先和穆希特谈谈，然后是和田
.turnin 11968 >>转向潮汐转向
.goto BoreanTundra,67.21,54.86


step << skip
.goto BoreanTundra,78.5,51.5
>>前往Unu'pe
.fp Unu'pe >> 获取Unu'pe飞行路线
step
#completewith next
.goto Dragonblight,12.27,55.25
.zone Dragonblight >> 前往Dragonblight
step
.goto Dragonblight,29.15,55.32
>>向东进入龙枯萎
.fp Stars' Rest >> 获取星星的休息飞行路径
step
#completewith next
.goto Dragonblight,26.15,49.48,20 >> 跳进Narjun的深坑
step
.goto Dragonblight,26.18,50.79
>>与Narjun矿坑内的Kilix交谈
.accept 13187 >>接受没有脸的人
.accept 13167 >>接受叛徒国王的死亡
.accept 13182 >>接受不要忘记鸡蛋
.xp >76,1
step
#completewith next
.goto Dragonblight,25.61,51.30
.zone 159 >>进入Azjol'Nerub
step
>>清除一次Azjol’nerub。摧毁整个Azjol'Nerub的蛋
.complete 13182,1 
step
.goto 157,62.27,48.55
>>清除一次Azjol’nerub。杀死阿努布拉克。抢走他的外壳
.complete 13167,1 
step
#completewith KilixT
.goto 157,89.25,77.99
.zone Dragonblight >> 从后门离开Azjol’nerub
step
#label KilixT
.goto Dragonblight,26.18,50.79
>>与Narjun矿坑内的Kilix交谈
.turnin 13167 >>向叛徒王投降
.turnin 13182 >>交上来别忘了鸡蛋
.xp >76,1
step
#completewith next
.goto Dragonblight,28.61,51.79
.zone 132 >>进入安卡赫：旧王国
step
#completewith AhnKahet1
.goto 132,33.38,49.79,40,0
.goto 132,27.61,50.24
>>就在《先驱报》沃拉齐之前杀死那些没脸的人
.complete 13187,1 
step
#completewith AhnKahet1
.goto 132,23.00,50.81
>>杀死先驱瓦拉齐
.complete 13187,2 
step
#label AhnKahet1
.xp 74 >> 研磨安卡赫：旧王国到74级
step << Druid
#completewith next
.cast 18960 >> 铸造Teleport:Moonglade
.zoneskip Moonglade
.xp <73,1
step << Druid
.goto Moonglade,52.4,40.6
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 53307 >> 训练你的职业咒语
.xp <74,1
step << DK
#completewith next
.cast 50977 >> 铸造死亡之门
.zoneskip Eastern Plaguelands
.xp <74,1
step << DK
.goto Eastern Plaguelands,80.3,48.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 49929 >> 在阿切鲁斯的Amal'Tazad训练你的职业咒语
.xp <74,1
.xp >80,1
step << Mage
#completewith next
.zone Stormwind City >> 传送到暴风城
.xp <74,1
step << Mage
.goto Stormwind City,49.26,87.77
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 42939 >>训练你的职业咒语
.xp <74,1
step << Shaman/Paladin/Priest/Warlock/Hunter
#completewith next
.hs >> 从火炉到暴风 << !Priest
.hs >> 火炉到暴风。如果你是神圣的或纪律性的，跳过这一步 << Priest
step << Shaman
.goto Stormwind City,67.52,89.41
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 49270 >> 训练你的职业咒语
.xp <74,1
step << Paladin
.goto Stormwind City,49.60,49.83
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48805 >> 训练你的职业咒语
.xp <74,1
step << Priest
.goto Stormwind City,49.51,45.22
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48126 >> 训练你的职业法术。如果你是神圣的或纪律性的，跳过这一步
.xp <74,1

step << Warlock
#completewith next
.goto Stormwind City,29.2,74.0,20,0
.goto Stormwind City,27.2,78.1,15 >> 走进屠宰羔羊，下楼去
step << Warlock
.goto Stormwind City,39.89,84.19
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 47892 >> 训练你的职业咒语
.xp <74,1
step << Hunter
.goto Stormwind City,67.35,36.26
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 61846 >> 训练你的职业咒语
.xp <74,1
step
.goto Dragonblight,26.18,50.79
>>与Narjun矿坑内的Kilix交谈
.turnin 13187 >>交出那些没脸的人
.isQuestComplete 13187
step
#completewith AhnKahet2
.goto 132,33.38,49.79,40,0
.goto 132,27.61,50.24
>>就在《先驱报》沃拉齐之前杀死那些没脸的人
.complete 13187,1 
step
#completewith AhnKahet2
.goto 132,23.00,50.81
>>杀死先驱瓦拉齐
.complete 13187,2 
step
#label AhnKahet2
.xp 75 >>研磨安卡赫：旧王国到75级
step << Druid
#completewith next
.cast 18960 >> 铸造Teleport:Moonglade
.zoneskip Moonglade
.xp <75,1
step << Druid
.goto Moonglade,52.4,40.6
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48440 >> 训练你的职业咒语
.xp <75,1
step << DK
#completewith next
.cast 50977 >> 铸造死亡之门
.zoneskip Eastern Plaguelands
.xp <75,1
step << DK
.goto Eastern Plaguelands,80.3,48.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 49923 >> 在阿切鲁斯的Amal'Tazad训练你的职业咒语
.xp <75,1
.xp >80,1
step << Mage
#completewith next
.zone Stormwind City >> 传送到暴风城
.xp <75,1
step << Mage
.goto Stormwind City,49.26,87.77
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 42955 >> 训练你的职业咒语
.xp <75,1
step << Shaman/Paladin/Priest/Hunter/Warrior
#completewith next
.hs >> 从火炉到暴风
step << Shaman
.goto Stormwind City,67.52,89.41
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 49280 >> 训练你的职业咒语
.xp <75,1
step << Paladin
.goto Stormwind City,49.60,49.83
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48818 >> 训练你的职业咒语
.xp <75,1
step << Priest
.goto Stormwind City,49.51,45.22
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48124 >> 训练你的职业咒语
.xp <75,1
step << Hunter
.goto Stormwind City,67.35,36.26
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 61005 >> 训练你的职业咒语
.xp <75,1
step << Warrior
.goto Stormwind City,77.65,64.31,15,0
.goto Stormwind City,81.45,59.49,15,0
.goto Stormwind City,80.56,59.88
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 55694 >> 训练你的职业咒语
.xp <75,1
step
.goto Dragonblight,26.18,50.79
>>与Narjun矿坑内的Kilix交谈
.turnin 13187 >>交出那些没脸的人
.isQuestComplete 13187
step
#completewith next
.goto Zul'Drak,18.29,84.66
.zone Zul'Drak >> 前往祖德拉克
step
>>旅行到光明的破灭。与Moky、Lantinga、Rageclaw和通缉海报交谈。如果你愿意，可以跳过这些任务，但建议你完成它们
.accept 12859 >>接受这一点：火仍然很热！
.goto ZulDrak,32.02,75.60
.accept 12902 >>接受以搜索答案
.goto ZulDrak,32.15,75.74
.accept 12861 >>接受巨魔疯了！
.goto ZulDrak,32.17,75.64
.accept 12857 >>接受通缉：Ragemane的Flipper
.goto ZulDrak,32.26,75.68
.xp >76,1
step
#completewith Ragemane
.goto ZulDrak,34.8,85.1,0
.goto ZulDrak,34.7,80.6,0
.use 41131 >>当垃圾站靠近着火的小屋时，请使用袋子里的愤怒爪灭火器。
.complete 12859,1 
.isOnQuest 12859
step
#completewith Fires
.goto ZulDrak,34.8,85.1,0
.goto ZulDrak,34.7,80.6,0
>>杀死该地区的不死巨魔。抢他们的开锁器
.use 41161 >>在俘虏的狂暴爪上使用它们来释放它们
.collect 41161,8,12861,1,-1
.complete 12861,1 
.isOnQuest 12861
step
.goto ZulDrak,34.94,83.90
>>单击浮动滚动条
.turnin 12902 >>交上来寻找答案
.accept 12883 >>接受Drakuru的订单
.isOnQuest 12902
step
.goto ZulDrak,34.94,83.90
>>单击浮动滚动条
.accept 12883 >>接受Drakuru的订单
.isQuestTurnedIn 12902
step
#label Ragemane
.goto ZulDrak,38.29,84.93
>>到水里去。杀死雷格曼。抢他的Flipper
.complete 12857,1 
.isOnQuest 12857
step
#label Fires
.goto ZulDrak,34.8,85.1,80,0
.goto ZulDrak,34.7,80.6
.use 41131 >>当靠近着火的小屋时，使用愤怒爪灭火器
.complete 12859,1 
.isOnQuest 12859
step
.goto ZulDrak,34.8,85.1,80,0
.goto ZulDrak,34.7,80.6
>>杀死该地区的不死巨魔。抢他们的开锁器（放进你的包里）
.use 41161 >>在俘虏的狂暴爪上使用它们来释放它们
.collect 41161,8,12861,1,-1
.complete 12861,1 
.isOnQuest 12861
step
#completewith end
#label Langtina1
>>与Lantinga交谈
.turnin 12883 >>提交Drakuru的订单
.accept 12884 >>接受Ebon Watch
.accept 12894 >>接受十字军前卫营地
.goto ZulDrak,32.15,75.74
.isQuestComplete 12883

step
#completewith end
#requires Langtina1
#label Langtina2
>>与Lantinga交谈
.accept 12884 >>接受Ebon Watch
.accept 12894 >>接受十字军前卫营地
.goto ZulDrak,32.15,75.74
.isQuestTurnedIn 12883
step
#completewith end
#label Rageclaw1
>>与愤怒爪对话
.turnin 12857 >>通缉犯：Ragemane的Flipper
.turnin 12861 >>投奔巨魔疯了！
.goto ZulDrak,32.2,75.7
.isQuestComplete 12857
.isQuestComplete 12861
step
#completewith end
#requires Rageclaw1
#label Rageclaw2
>>与愤怒爪对话
.turnin 12857 >>通缉犯：Ragemane的Flipper
.goto ZulDrak,32.17,75.64
.isQuestComplete 12857
step
#completewith end
#requires Rageclaw2
#label Rageclaw3
>>与愤怒爪对话
.turnin 12861 >>投奔巨魔疯了！
.goto ZulDrak,32.17,75.64
.isQuestComplete 12861
step
#completewith end
#label Moky
>>与莫基交谈
.turnin 12859 >>把这个交上来：火还热！
.goto ZulDrak,32.02,75.60
.isQuestComplete 12859
step
#requires Langtina2
step
#requires Rageclaw3
step
#requires Moky
.goto ZulDrak,32.18,74.39
>>与Danica交谈
.fp Light's Breach >>获取光的破解飞行路径
step
>>骑马前往十字军前方营地。与Mackeller交谈
.turnin 12894 >>转入十字军前卫营地
.accept 12903 >>接受这就是朋友的目的。。。
.goto ZulDrak,25.28,63.96


.isQuestTurnedIn 12883
step
.goto ZulDrak,25.05,51.61
>>靠近十字军Dargath，直到目标完成
.complete 12903,1 
.isOnQuest 12903
step
.goto ZulDrak,19.78,56.35
>>在巨大的笼子里和体操运动员交谈。尽量避免杀死该地区的瓦格尔人
.accept 12912 >>接受大风暴接近
.isOnQuest 12903
step
.goto ZulDrak,17.64,57.55
>>和瘟疫箱里的格克谈谈。尽量避免杀死该地区的瓦格尔人
.complete 12903,2 
.accept 12904 >>接受光明不会让我复仇
.isOnQuest 12903
step
#completewith next
.goto ZulDrak,19.8,56.9,0
.goto ZulDrak,23.2,54.7,0
.goto ZulDrak,21.4,51.3,0
.goto ZulDrak,15.0,61.3,0
>>杀死该地区的任何瓦格尔类人
.complete 12904,1 
.isOnQuest 12904
step << skip
#completewith next
.goto ZulDrak,19.5,58.9,0
.goto ZulDrak,15.3,62.2,0
.goto ZulDrak,13.3,59.9,0
.goto ZulDrak,18.7,54.5,0
>>收集散落在整个区域的废金属碎片
.complete 12901,1 
step
.goto ZulDrak,15.67,59.41
>>接近Burr，直到目标完成
.complete 12903,3 
.isOnQuest 12903
step << skip
#label Metal
.goto ZulDrak,19.1,61.8,70,0
.goto ZulDrak,15.3,62.2,70,0
.goto ZulDrak,13.3,59.9,70,0
.goto ZulDrak,18.7,54.5
>>收集散落在整个区域的废金属碎片
.complete 12901,1 
step
.goto ZulDrak,19.8,56.9,70,0
.goto ZulDrak,23.2,54.7,70,0
.goto ZulDrak,21.4,51.3,70,0
.goto ZulDrak,15.0,61.3
>>杀死该地区的任何瓦格尔类人
.complete 12904,1 
.isOnQuest 12904
step
.goto ZulDrak,17.64,57.55
>>与Gerk交谈
.turnin 12904 >>灯亮了不会让我复仇
.isQuestComplete 12904
step
>>返回十字军前卫营地。与Reed和MacKellar交谈
.turnin 12912 >>大风暴接近时转弯



.turnin 12903 >>交朋友就是为了。。。
.goto ZulDrak,25.28,63.96
.isQuestComplete 12903
.isOnQuest 12912
step
>>返回十字军前卫营地。与MacKellar交谈



.turnin 12903 >>交朋友就是为了。。。
.goto ZulDrak,25.28,63.96
.isQuestComplete 12903
step
>>返回十字军前卫营地。与里德交谈
.turnin 12912 >>大风暴接近时转弯
.goto ZulDrak,25.22,63.88


.isOnQuest 12912
step
.goto ZulDrak,39.43,66.96
>>前往银色看台。与Falstaav交谈

.accept 12503 >>接受防守

.xp >78,1
step
.goto ZulDrak,40.53,65.61
>>如果你认为你会有至少10个Drakkari Offerings在你们中间，把它们全部交易给某人，然后接受这个任务，让他们可以交上来。这会给他们1小时的力量祝福（攻击力）
>>与乌本戈交谈
.accept 12565 >>接受津巴布韦的祝福
.xp >78,1
step << skip
#completewith next
.goto ZulDrak,36.6,67.7,0
.use 39615 >>使用背包中的十字军降落伞对付银色十字军或盾牌兵
.complete 12740,1 
step
.goto ZulDrak,35.8,66.6
>>杀死该地区的亡灵暴徒
.complete 12503,1 
.isOnQuest 12503
step << skip
.goto ZulDrak,36.6,67.7
.use 39615 >>使用背包中的十字军降落伞对付银色十字军或盾牌兵
.complete 12740,1 
step << skip
.goto ZulDrak,35.8,66.6
>>杀死该地区的亡灵暴徒。掠夺他们以换取Drakkari优惠
.collect 38551,10 
step
.goto ZulDrak,36.70,72.72
>>点击雕像
.turnin 12565 >>交上津巴布韦的祝福
.isQuestComplete 12565
step
.goto ZulDrak,39.43,66.96
>>与Falstaav交谈

.turnin 12503 >>转身防守看台

.isQuestComplete 12503
step
#completewith next
.goto ZulDrak,40.83,66.25
>>与Marissa交谈
.vendor 28791 >>买很多新食物。在下一次休息之前，你将在接下来的两个关卡中进行地下城训练 << Warrior/Rogue/DK
.vendor 28791 >>买很多新的食物/水。在下一次休息之前，你将在接下来的两个关卡中进行地下城训练 << !Warrior !Rogue !DK
step
#completewith next
.goto ZulDrak,41.09,65.15
>>与艾丹交谈
.vendor 28800 >>供应商和维修
step
.goto ZulDrak,41.55,64.43
.fp The Argent Stand >>获取银色停机位飞行路线
step
>>完成《痛苦任务线》的剧情片。有6个精英任务可以提供大量的快速xp和一件武器，可以让你持续到80。只有当你的队伍准备好并且任务进度与你相同时才接受这个。（此问题行禁用自动接受）
.groundgoto ZulDrak,46.3,57.9,50,0
.goto ZulDrak,48.43,56.36
.accept 12932,0 >>接受痛苦的剧场：Yggdras！
.xp >78,1
step
.goto ZulDrak,47.83,56.83
>>在Anguish剧场杀死Yggdras
.complete 12932,1 
.isOnQuest 12932
step
.goto ZulDrak,48.47,56.41
>>与沃丁交谈
.turnin 12932 >>把痛苦的剧场：伊格德拉斯！
.isQuestComplete 12932
step
.goto ZulDrak,48.43,56.36
>>与Gurgthock交谈。只有当你的队伍已经准备好并且与你的任务进度相同时，才能接受这个。
.accept 12933,0 >>接受痛苦的剧场：巨无霸！
.isQuestTurnedIn 12932
step
.goto ZulDrak,47.83,56.83
>>杀死痛苦剧场的臭胡子
.complete 12933,1 
.isQuestTurnedIn 12932
step
.goto ZulDrak,48.47,56.41
>>与沃丁交谈
.turnin 12933 >>把《痛苦的剧场：大人物》交上来！
.isQuestTurnedIn 12932
step
.goto ZulDrak,48.43,56.36
>>与Gurgthock交谈。只有当你的队伍已经准备好并且与你的任务进度相同时，才能接受这个。
.accept 12934,0 >>接受痛苦的剧场：来自远方！
.isQuestTurnedIn 12932
step
.goto ZulDrak,47.83,56.83
>>杀死痛苦剧场中的元素领主
.complete 12934,1 
.isQuestTurnedIn 12932
step
.goto ZulDrak,48.47,56.41
>>与沃丁交谈
.turnin 12934 >>交出《痛苦的剧场：来自远方》！
.isQuestTurnedIn 12932
step
.goto ZulDrak,48.43,56.36
>>与Gurgthock交谈。只有当你的队伍已经准备好并且与你的任务进度相同时，才能接受这个。
.accept 12935,0 >>接受痛苦的两极加热器：Tuskarrmageddon！
.isQuestTurnedIn 12932
step
.goto ZulDrak,47.83,56.83
>>在安圭什剧场杀死奥里诺科
.complete 12935,1 
.isQuestTurnedIn 12932
step
.goto ZulDrak,48.47,56.41
>>与沃丁交谈
.turnin 12935 >>交给《痛苦的两极加热器：Tuskarrmageddon》！
.isQuestTurnedIn 12932
step
.goto ZulDrak,48.43,56.36
>>与Gurgthock交谈。只有当你的队伍已经准备好并且与你的任务进度相同时，才能接受这个。
.accept 12936,0 >>接受痛苦的剧场：血腥者科拉克！
.isQuestTurnedIn 12932
step
.goto ZulDrak,47.83,56.83
>>在安圭什剧场杀死科拉克
.complete 12936,1 
.isQuestTurnedIn 12932
step
.goto ZulDrak,48.47,56.41
>>与沃丁交谈
.turnin 12936 >>把《安圭什剧场》交上来：血行者科拉克！
.isQuestTurnedIn 12932
step
.goto ZulDrak,48.43,56.36
>>与Gurgthock交谈。只有当你的队伍已经准备好并且与你的任务进度相同时，才能接受这个。
.accept 12948,0 >>接受痛苦的冠军
.isQuestTurnedIn 12932
step
.goto ZulDrak,47.83,56.83
>>在Anguish剧场杀死Vladof
.complete 12948,1 
.isQuestTurnedIn 12932
step
.goto ZulDrak,48.47,56.41
>>与沃丁交谈
.turnin 12948 >>交出痛苦的冠军
.isQuestTurnedIn 12932
step
.groundgoto ZulDrak,51.20,54.32,60,0
>>走你身后的楼梯，向Zim'Torga走去。与托基尼交谈
.accept 13099 >>接受“仅签入”
.goto ZulDrak,59.98,57.93
.xp >78,1
step
.groundgoto ZulDrak,65.47,44.23,60,0
.goto Zul'Drak,70.06,20.92
>>与巴基尼人交谈
.turnin 13099 >> “只需签入”
.accept 13098 >> 为后代接受
.accept 13111 >> 接受一种
.xp >78,1
step
#completewith next
.goto Zul'Drak,76.02,20.79
.zone 154 >> 输入Gundrak
step
#completewith Gundrak1
.goto 154,56.80,41.61
.goto 154,52.28,68.79
.goto 154,48.64,78.52
.goto 154,49.42,81.91
.goto 154,48.27,71.79
.goto 154,44.95,67.51
.goto 154,47.97,63.31
.goto 154,46.23,52.77
.goto 154,41.46,72.29
.goto 154,30.61,76.64
.goto 154,31.80,69.53
.goto 154,32.28,65.89
.goto 154,33.63,58.70
.goto 154,36.22,58.40
.goto 154,36.24,56.40
.goto 154,32.53,56.32
.goto 154,31.81,49.55
.goto 154,31.77,45.85
.goto 154,40.21,51.56
.goto 154,39.94,47.99
.goto 154,38.92,47.34
.goto 154,43.93,31.06
.goto 154,41.51,25.48
.goto 154,39.40,21.64
.goto 154,40.03,16.82
.goto 154,46.31,22.51
.goto 154,49.21,30.61
.goto 154,49.74,27.77
.goto 154,53.08,17.08
>>抢劫在贡德拉克发现的德拉克里历史碑
.complete 13098,1 
step
#completewith Gundrak1
.goto 154,46.60,65.71
>>杀死德拉卡里巨像。抢劫它的碎片
.complete 13111,1 
step << DK/Mage/Shaman/Hunter/Rogue
#label Gundrak1
.xp 76 >>将Gundrak研磨至76级
>>如果您达到每小时锁定，请切换到Gundrak锁定指南

step << DK
#completewith next
.cast 50977 >> 铸造死亡之门
.zoneskip Eastern Plaguelands
.xp <76,1
step << DK
.goto Eastern Plaguelands,80.3,48.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 49894 >> 在阿切鲁斯的Amal'Tazad训练你的职业咒语
.xp <76,1
.xp >80,1
step << Mage
#completewith next
.zone Stormwind City >> 传送到暴风城
.xp <76,1
step << Mage
.goto Stormwind City,49.26,87.77
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 42920 >> 训练你的职业咒语
.xp <76,1
step << Shaman/Hunter/Rogue
#completewith next
.hs >> 从火炉到暴风
step << Shaman
.goto Stormwind City,67.52,89.41
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 58803 >> 训练你的职业咒语
.xp <76,1
step << Hunter
.goto Stormwind City,67.35,36.26
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 53338 >> 训练你的职业咒语
.xp <76,1
step << Rogue
.goto Stormwind City,77.42,65.31
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48637 >> 训练你的职业咒语
.xp <76,1
step
#completewith Gundrak2
.goto 154,56.80,41.61
.goto 154,52.28,68.79
.goto 154,48.64,78.52
.goto 154,49.42,81.91
.goto 154,48.27,71.79
.goto 154,44.95,67.51
.goto 154,47.97,63.31
.goto 154,46.23,52.77
.goto 154,41.46,72.29
.goto 154,30.61,76.64
.goto 154,31.80,69.53
.goto 154,32.28,65.89
.goto 154,33.63,58.70
.goto 154,36.22,58.40
.goto 154,36.24,56.40
.goto 154,32.53,56.32
.goto 154,31.81,49.55
.goto 154,31.77,45.85
.goto 154,40.21,51.56
.goto 154,39.94,47.99
.goto 154,38.92,47.34
.goto 154,43.93,31.06
.goto 154,41.51,25.48
.goto 154,39.40,21.64
.goto 154,40.03,16.82
.goto 154,46.31,22.51
.goto 154,49.21,30.61
.goto 154,49.74,27.77
.goto 154,53.08,17.08
>>抢劫在贡德拉克发现的德拉克里历史碑
.complete 13098,1 
step
#completewith Gundrak2
.goto 154,46.60,65.71
>>杀死德拉卡里巨像。抢劫它的碎片
.complete 13111,1 
step
#label Gundrak2
.xp 77 >>将Gundrak研磨至77级
>>如果您达到每小时锁定，请切换到Gundrak锁定指南
step << Warlock
#completewith next
.hs >> 从火炉到暴风
step << Warlock
#completewith next
.goto Stormwind City,29.2,74.0,20,0
.goto Stormwind City,27.2,78.1,15 >> 走进屠宰羔羊，下楼去
step << Warlock
.goto Stormwind City,39.89,84.19
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 47813 >> 训练你的职业咒语
.xp <77,1
step
.goto Zul'Drak,70.06,20.92
>>退出Gundrak。与巴基尼人交谈
.turnin 13098 >> 为后代而上
.turnin 13111 >> 上缴一种
.isQuestComplete 13098
.isQuestComplete 13111
step
.goto Zul'Drak,70.06,20.92
>>退出Gundrak。与巴基尼人交谈
.turnin 13098 >> 为后代而上
.isQuestComplete 13098
step
.goto Zul'Drak,70.06,20.92
>>退出Gundrak。与巴基尼人交谈
.turnin 13098 >> 为后代而上
.isQuestComplete 13098
step
#completewith next
.goto ZulDrak,70.47,23.30
.fp Dubra'Jin >> 获取Dubra'Jin航线
step
#completewith next
.goto ZulDrak,70.47,23.30
.fly The Argent Stand >> 飞到银色看台
step
.goto ZulDrak,40.83,66.25
>>与Marissa交谈
.vendor 25245 >>买很多食物。你将在最后3关做地牢 << Warrior/Rogue/DK
.vendor 28791 >>买很多食物/水。你将在最后3关做地牢 << !Warrior !Rogue !DK
.xp >78,1
step
.goto ZulDrak,41.09,65.15
>>与艾丹交谈
.vendor 28800 >>供应商和维修
.xp >78,1
step
#completewith next
.goto ZulDrak,40.63,66.90
>>与Teronus交谈
.accept 12796 >>接受达拉然魔法王国
.zoneskip Stormwind City
.zoneskip Dalaran
.xp >78,1
step
.goto ZulDrak,40.63,66.90
.zone Dalaran >>让泰罗诺斯被传送到达拉然
.skipgossip
.xp >78,1
step
.abandon 12796 >> 放弃达拉然魔法王国。不要把这个交进去
step << Mage
.goto Dalaran,56.3,46.7
.trainer >>进入大楼。训练您的达拉然门户
step << Mage
.goto Dalaran,55.0,46.2
.train 42985 >> 训练你的职业咒语
.xp <77,1
step
.goto Dalaran,69.81,45.45
.train 54197 >> 从Hira Snowdawn乘火车寒冷天气飞行
step << skip
.goto The Storm Peaks,65.3,60.2
.accept 13109 >>接受直径相反
.accept 13108 >>接受一切代价
step
#completewith next
.goto The Storm Peaks,45.56,21.10
.zone 138 >>进入闪电大厅
step << Warrior/Druid/DK/Mage
.xp 78 >>将闪电大厅研磨至78级
step << Druid
#completewith next
.cast 18960 >> 铸造Teleport:Moonglade
.zoneskip Moonglade
.xp <78,1
step << Druid
.goto Moonglade,52.4,40.6
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48465 >> 训练你的职业咒语
.xp <78,1
step << DK
#completewith next
.cast 50977 >> 铸造死亡之门
.zoneskip Eastern Plaguelands
.xp <78,1
step << DK
.goto Eastern Plaguelands,80.3,48.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 49941 >> 在阿切鲁斯的Amal'Tazad训练你的职业咒语。如果需要的话，把你的武器运到楼下
.xp <78,1
step << Mage
#completewith next
.zone Dalaran >> 传送至达拉然
.xp <78,1
step << Mage
.goto Dalaran,55.0,46.2
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 42914 >> 训练你的职业咒语
.xp <78,1
step << Warrior
#completewith next
.hs >> 从火炉到暴风
step << Warrior
.goto Stormwind City,77.65,64.31,15,0
.goto Stormwind City,81.45,59.49,15,0
.goto Stormwind City,80.56,59.88
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 47436 >> 训练你的职业咒语
.xp <78,1
step << Mage/Druid/DK
.xp 79 >>将闪电大厅研磨至79级
step << Mage
#completewith next
.zone Dalaran >> 传送至达拉然
.xp <79,1
step << Mage
.goto Dalaran,55.0,46.2
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 43046 >> 训练你的职业咒语
.xp <79,1
step << Druid
#completewith next
.cast 18960 >> 铸造Teleport:Moonglade
.zoneskip Moonglade
.xp <79,1
step << Druid
.goto Moonglade,52.4,40.6
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48378 >> 训练你的职业咒语
.xp <79,1
step << DK
#completewith next
.cast 50977 >> 铸造死亡之门
.zoneskip Eastern Plaguelands
.xp <79,1
step << DK
#label DKTrain1
.goto Eastern Plaguelands,80.3,48.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 55271 >> 在阿切鲁斯的Amal'Tazad训练你的职业咒语
.xp <79,1
step
.xp 80 >>将闪电大厅研磨至80级
step << skip
.goto The Storm Peaks,65.3,60.2
.turnin 13109 >>直径相反的转向
.turnin 13108 >>交出一切
>>丁80级-恭喜！
step
+恭喜您完成了RestedXP 70-80地牢裂口指南！感谢您使用RestedXP。
]])
RXPGuides.RegisterGuide([[
#version 5
#wotlk
#group 地下城 刷本 70-80
<< Alliance
#name 70-73 魔枢副本 - Coldarra
#next 70-80 联盟 地下城 刷本
step
#completewith end
+使用本指南时，每当您的锁定到期时，请切换回主地牢裂口指南
step
#completewith Weaver1
>>当你通过科尔达拉探索时：
>>-杀死你看到的所有Coldarra Spellweavers
>>-寻找地上的霜莓灌木。如果你愿意，就跳过灌木
.complete 11918,1 
.complete 11912,1 
step
.goto BoreanTundra,32.6,27.8
>>杀死该地区的科尔达拉·斯皮尔宾德斯。抢走他们以获取闪烁碎片。在您的包中点击它
.collect 35648,1,11941 
.accept 11941 >>接受拼图。。。
step
>>与Serrah、Raelorasz和Berinand交谈
.turnin 13094 >>他们没有羞耻感吗？
.goto BoreanTundra,33.49,34.38,-1
.turnin 11941 >>交给Puzzling。。。
.accept 11943 >>接受单元格
.goto BoreanTundra,33.32,34.54,-1
.turnin 11905 >>营业额推迟了不可避免的事情
.goto BoreanTundra,32.94,34.40,-1
.isQuestComplete 13094
.isQuestComplete 11905
step
>>与Serrah和Raelorasz交谈
.turnin 13094 >>他们没有羞耻感吗？
.goto BoreanTundra,33.49,34.38,-1
.turnin 11941 >>交给Puzzling。。。
.accept 11943 >>接受单元格
.goto BoreanTundra,33.32,34.54,-1
.isQuestComplete 13094
step
>>与Raelorasz和Berinand交谈
.turnin 11941 >>交给Puzzling。。。
.accept 11943 >>接受单元格
.goto BoreanTundra,33.32,34.54,-1
.turnin 11905 >>营业额推迟了不可避免的事情
.goto BoreanTundra,32.94,34.40,-1
.isQuestComplete 11905
step << skip
.goto BoreanTundra,32.94,34.40,-1
>>与Berinand交谈
.turnin 11905 >>营业额推迟了不可避免的事情
.turnin 11911 >>车削加速
.isQuestComplete 11905
.isQuestComplete 11911
step
>>与Raelorasz交谈
.turnin 11941 >>交给Puzzling。。。
.accept 11943 >>接受单元格
.goto BoreanTundra,33.32,34.54
.isQuestComplete 11941
step
#label Puzzle
>>与Raelorasz交谈
.accept 11943 >>接受单元格
.goto BoreanTundra,33.32,34.54
.isQuestTurnedIn 11941
step
#completewith end1
#level 73
+完成你即将完成的任务/认为你可以完成的任务，然后放弃所有未完成的Coldarra/Nexus相关任务
step
#completewith splinters
>>在科尔达拉周围寻找冰川古人和魔法古人。掠夺他们的分裂者
.complete 11910,1 
.complete 11910,2 
.isOnQuest 11910
step
.goto BoreanTundra,28.31,28.46
>>点击Nexus会议石旁边的小圆球
.complete 11900,1 
.isOnQuest 11900
step
.goto BoreanTundra,28.25,35.04
>>点击建筑内的蓝色小圆球（不是浮动的）
.complete 11900,2 
.isOnQuest 11900
step
.goto BoreanTundra,24.14,29.60
>>杀死战争使者戈雷德拉克。抢劫他的能量核心
.complete 11943,1 
.isOnQuest 11943
.unitscan Warbringer Goredrak
step
.goto BoreanTundra,22.62,23.42
>>点击建筑内的蓝色小圆球（不是浮动的）
.complete 11900,4 
.isOnQuest 11900
step
.goto BoreanTundra,27.32,20.41
>>杀死塞鲁伦将军。抢劫他入狱
.complete 11943,2 
.isOnQuest 11943
.unitscan General Cerulean
step
#label Weaver1
.goto BoreanTundra,31.72,20.57
>>点击建筑内的蓝色小圆球（不是浮动的）
.complete 11900,3 
.isOnQuest 11900
step
#sticky
#label berries2
.goto BoreanTundra,25.5,35.6,70,0
.goto BoreanTundra,25.0,30.6,70,0
.goto BoreanTundra,28.0,33.5,70,0
.goto BoreanTundra,32.6,28.2,70,0
.goto BoreanTundra,30.1,23.4
>>杀死你看到的所有Coldarra Spellweavers
.complete 11918,1 
.isOnQuest 11918
step
.goto BoreanTundra,21.5,26.9,70,0
.goto BoreanTundra,24.4,35.2,70,0
.goto BoreanTundra,34.3,31.2,70,0
.goto BoreanTundra,33.7,23.1
>>抢劫整个科尔达拉的霜莓灌木。如果你想跳过这个
.complete 11912,1 
.isOnQuest 11912
step
#requires berries2
step
#completewith end
#label Serrah1
>>与Serrah交谈
.turnin 11912 >>将坚果倒入浆果中
.turnin 13094 >>他们没有羞耻感吗？
.accept 11914 >>接受保持秘密安全
.goto BoreanTundra,33.49,34.38,-1
.isQuestComplete 11912
.isQuestComplete 13094
step
#completewith end
#requires Serrah1
#label Serrah2
>>与Serrah交谈
.turnin 11912 >>将坚果倒入浆果中
.accept 11914 >>接受保持秘密安全
.goto BoreanTundra,33.49,34.38,-1
.isQuestComplete 11912
step
#completewith end
#requires Serrah2
#label Serrah3
>>与Serrah交谈
.accept 11914 >>接受保持秘密安全
.goto BoreanTundra,33.49,34.38,-1
.isQuestTurnedIn 11912
step
#completewith end
#requires Serrah3
#label Serrah4
>>与Serrah交谈
.turnin 13094 >>他们没有羞耻感吗？
.goto BoreanTundra,33.49,34.38,-1
.isQuestComplete 13094
step
#completewith end
#label Raelorasz1
>>与Raelorasz交谈
.turnin 11918 >>上交基础培训
.accept 11936 >>接受填充平面
.turnin 11943 >>交出牢房
.goto BoreanTundra,33.32,34.54,-1
.isQuestComplete 11918
.isQuestComplete 11943
step
#completewith end
#requires Raelorasz1
#label Raelorasz2
>>与Raelorasz交谈
.turnin 11918 >>上交基础培训
.accept 11936 >>接受填充平面
.goto BoreanTundra,33.32,34.54,-1
.isQuestComplete 11918
step
#completewith end
#requires Raelorasz2
#label Raelorasz3
>>与Raelorasz交谈
.accept 11936 >>接受填充平面
.goto BoreanTundra,33.32,34.54,-1
.isQuestTurnedIn 11918
step
#completewith end
#requires Raelorasz3
#label Raelorasz4
>>与Raelorasz交谈
.turnin 11943 >>交出牢房
.goto BoreanTundra,33.32,34.54,-1
.isQuestComplete 11943
step
>>与Berinand交谈
.turnin 11910 >>交出古代的秘密
.turnin 11900 >>转动仪表读数
.accept 11905 >>接受推迟不可避免的事情
.accept 11911 >>接受加快
.goto BoreanTundra,32.94,34.40,-1
.isQuestComplete 11910
step
>>与Berinand交谈
.turnin 11910 >>交出古代的秘密
.turnin 11905 >>营业额推迟了不可避免的事情
.accept 11911 >>接受加快
.goto BoreanTundra,32.94,34.40,-1
.isQuestComplete 11910
.isQuestComplete 11905
step
>>与Berinand交谈
.turnin 11905 >>营业额推迟了不可避免的事情
.goto BoreanTundra,32.94,34.40,-1
.isQuestComplete 11905
step
>>与Berinand交谈
.turnin 11910 >>交出古代的秘密
.accept 11911 >>接受加快
.goto BoreanTundra,32.94,34.40,-1
.isQuestComplete 11910
step
>>与Berinand交谈
.accept 11911 >>接受加快
.goto BoreanTundra,32.94,34.40,-1
.isQuestTurnedIn 11911
step
>>与Berinand交谈
.turnin 11900 >>转动仪表读数
.accept 11905 >>接受推迟不可避免的事情
.goto BoreanTundra,32.94,34.40,-1
.isQuestComplete 11900
step
>>与Berinand交谈
.accept 11905 >>接受推迟不可避免的事情
.goto BoreanTundra,32.94,34.40,-1
.isQuestTurnedIn 11900
step
#requires Raelorasz4
.use 35671 >> 点击你包里的强化奥术监狱召唤克里斯特拉斯扎
.accept 11946 >>接受Keristrasza
.turnin 11946 >>转入Keristrasza
.accept 11951 >>接受诱饵并切换
.isQuestTurnedIn 11943
step
#requires Serrah4
#completewith next
.goto BoreanTundra,24.9,31.2,0
.goto BoreanTundra,25.2,24.2,0
>>绕过Nexus的上边缘/悬崖。掠夺地面上的紫色小水晶
.complete 11951,1 
.isOnQuest 11951
step
#requires Serrah4
.goto BoreanTundra,29.5,30.81,90,0
.goto BoreanTundra,28.7,33.6,70,0
.goto BoreanTundra,27.5,31.3,70,0
.goto BoreanTundra,24.9,31.2,70,0
.goto BoreanTundra,25.2,24.2
>>绕过Nexus的上边缘/悬崖。杀死科尔达拉·威姆金斯。掠夺他们的斧头
.collect 35586,5,11936,1 
.isOnQuest 11936
step
.goto BoreanTundra,24.9,31.2,50,0
.goto BoreanTundra,25.2,24.2
>>绕过Nexus的上边缘/悬崖。掠夺地面上的紫色小水晶
.complete 11951,1 
.isOnQuest 11951
step
.goto BoreanTundra,29.3,27.4,50,0
.goto BoreanTundra,28.2,24.4,50,0
.goto BoreanTundra,26.2,25.4
>>绕过Nexus的较低区域。杀死奥术蛇并掠夺它们的精华。
>>使用您刚刚收集的斧头，在下方区域周围打破龙蛋
.collect 35586,5,11936,1,-1 
.complete 11936,1 
.complete 11914,1 
.isOnQuest 11936
.isOnQuest 11914
step
.goto BoreanTundra,29.3,27.4,50,0
.goto BoreanTundra,28.2,24.4,50,0
.goto BoreanTundra,26.2,25.4
>>绕过Nexus的较低区域。杀死奥术蛇并掠夺它们的精华。
.complete 11914,1 
.isOnQuest 11914
step
#label splinters
.goto BoreanTundra,29.3,27.4,50,0
.goto BoreanTundra,28.2,24.4,50,0
.goto BoreanTundra,26.2,25.4
>>使用您刚刚收集的斧头，在下方区域周围打破龙蛋
.collect 35586,5,11936,1,-1 
.complete 11936,1 
.isOnQuest 11936
step
.goto BoreanTundra,30.1,23.4,70,0
.goto BoreanTundra,32.6,28.2,70,0
.goto BoreanTundra,28.0,33.5,70,0
.goto BoreanTundra,25.0,30.6,70,0
.goto BoreanTundra,25.5,35.6
>>杀死冰川古人和魔法古人。掠夺他们的分裂者
.complete 11910,1 
.complete 11910,2 
.isOnQuest 11910
step
.use 35671 >> 点击你包里的强化奥术监狱召唤凯里斯特拉斯扎。如果您丢失了它，请与Raelorasz联系，要求新的。确保至少有一名党员不使用它
.turnin 11951 >>转入诱饵和开关
.accept 11957 >>接受萨拉戈萨的终结
.isQuestComplete 11951
step
.use 35671 >> 点击你包里的强化奥术监狱召唤凯里斯特拉斯扎。如果您丢失了它，请与Raelorasz联系，要求新的。确保至少有一名党员不使用它
.accept 11957 >>接受萨拉戈萨的终结
.isQuestTurnedIn 11951
step
#completewith next
.cast 46793 >> 再和克里斯特拉斯扎谈谈，她会把你传送到萨拉戈萨登陆。抵达后，前往平台中心，使用背包中的奥术力量聚焦召唤萨拉戈萨。
.goto BoreanTundra,21.57,22.55
.use 35690 
.isOnQuest 11957
step
>>杀死萨拉戈萨。抢劫她的尸体
.complete 11957,1 
.goto BoreanTundra,22.07,22.65
.use 35690 
.skipgossip
.isOnQuest 11957
step
.use 35671 >> 点击你包里的强化奥术监狱召唤克里斯特拉斯扎
.turnin 11957 >>交回萨拉戈萨的终点
.accept 11967 >>接受召集红军
.goto BoreanTundra,21.57,22.55
.isQuestComplete 11957
step
.use 35671 >> 点击你包里的强化奥术监狱召唤克里斯特拉斯扎
.accept 11967 >>接受召集红军
.goto BoreanTundra,21.57,22.55
.isQuestTurnedIn 11957
step
.goto BoreanTundra,22.07,22.65
.goto BoreanTundra,33.21,34.31,50 >>不要骑马返回Transitus。再次与Keristrasza通话，传送回Coldarra
.isOnQuest 11967
step
#completewith end
#label Serrah5
>>与Serrah交谈
.turnin 11914 >>交上来保守秘密
.turnin 13094 >>他们没有羞耻感吗？
.goto BoreanTundra,33.49,34.38,-1
.isQuestComplete 11914
.isQuestComplete 13094
step
#completewith end
#requires Serrah5
#label Serrah6
>>与Serrah交谈
.turnin 13094 >>他们没有羞耻感吗？
.goto BoreanTundra,33.49,34.38,-1
.isQuestComplete 13094
step
#completewith end
#requires Serrah6
#label Serrah7
>>与Serrah交谈
.turnin 11914 >>交上来保守秘密
.goto BoreanTundra,33.49,34.38,-1
.isQuestComplete 11914
step
#completewith end
#label Raelorasz5
>>与Raelorasz交谈
.turnin 11967 >>轮流召集红军
.turnin 11936 >>上交绘制平面图
.goto BoreanTundra,33.32,34.54,-1
.isQuestComplete 11967
.isQuestComplete 11936
step
#completewith end
#requires Raelorasz5
#label Raelorasz6
>>与Raelorasz交谈
.turnin 11967 >>轮流召集红军
.goto BoreanTundra,33.32,34.54,-1
.isQuestComplete 11967
step
#completewith end
#requires Raelorasz6
#label Raelorasz7
>>与Raelorasz交谈
.turnin 11936 >>上交绘制平面图
.goto BoreanTundra,33.32,34.54,-1
.isQuestComplete 11936
step
#completewith end
.goto BoreanTundra,32.94,34.40,-1
>>与Berinand交谈
.vendor 25314 >> 供应商和维修
step
>>与Berinand交谈
.turnin 11900 >>轮流读取仪表
.turnin 11905 >>营业额推迟了不可避免的事情
.turnin 11910 >>交出古代的秘密
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11900
.isQuestComplete 11905
.isQuestComplete 11910

step
>>与Berinand交谈
.turnin 11900 >>轮流读取仪表
.turnin 11905 >>营业额推迟了不可避免的事情
.turnin 11911 >>转弯加速
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11900
.isQuestComplete 11905
.isQuestComplete 11911
step
>>与Berinand交谈
.turnin 11900 >>轮流读取仪表
.turnin 11911 >>转弯加速
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11900
.isQuestComplete 11911
step
>>与Berinand交谈
.turnin 11905 >>营业额推迟了不可避免的事情
.turnin 11911 >>转弯加速
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11905
.isQuestComplete 11911
step
>>与Berinand交谈
.turnin 11905 >>营业额推迟了不可避免的事情
.turnin 11910 >>交出古代的秘密
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11905
.isQuestComplete 11910
step
>>与Berinand交谈
.turnin 11900 >>轮流读取仪表
.turnin 11910 >>交出古代的秘密
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11900
.isQuestComplete 11910
step
>>与Berinand交谈
.turnin 11900 >>轮流读取仪表
.turnin 11905 >>营业额推迟了不可避免的事情
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11900
.isQuestComplete 11905
step
>>与Berinand交谈
.turnin 11900 >>轮流读取仪表
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11900
step
>>与Berinand交谈
.turnin 11905 >>营业额推迟了不可避免的事情
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11905
step
>>与Berinand交谈
.turnin 11910 >>交出古代的秘密
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11910
step
>>与Berinand交谈
.turnin 11911 >>转弯加速
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11911
step
#requires Serrah7
step
#requires Raelorasz7
#completewith Dragonblight
#level 73
#label L73one
>>放弃所有与Coldarra/Nexus相关的任务
.abandon 11900 >> 放弃抄表
.abandon 11905 >> 放弃推迟不可避免的事情
.abandon 11910 >> 放弃古人的秘密
.abandon 11918 >> 放弃基本培训
.abandon 13094 >> 放弃他们没有羞耻感吗？
.abandon 11912 >> 放弃坚果换浆果
.abandon 11943 >> 放弃牢房
step
#completewith Dragonblight
#requires L73one
#level 73
>>放弃所有与Coldarra/Nexus相关的任务
.abandon 11911 >>放弃加速
.abandon 11936 >>放弃策划（Plan）
.abandon 11967 >>放弃召集红军
.abandon 11914 >>放弃保守秘密
.abandon 13094 >>放弃他们没有羞耻感吗？
.abandon 11951 >>放弃诱饵和开关
step
#label end
.goto BoreanTundra,33.13,34.45
.fly Amber Ledge >>飞到琥珀色壁架
.zoneskip Dragonblight
.zoneskip ZulDrak
.zoneskip The Storm Peaks
.zoneskip Dalaran
.zoneskip 159 
.zoneskip 157 
.zoneskip 132 
.zoneskip 154 
.zoneskip 138 
.xp <73,1
]])
RXPGuides.RegisterGuide([[
#version 5
#wotlk
#group 地下城 刷本 70-80
<< Alliance
#name 75-77 古达克副本
#next 70-80 联盟 地下城 刷本

step
.loop 50,ZulDrak,68.00,33.67,63.78,33.81,63.72,38.24,67.38,38.75,69.52,35.43,68.00,33.67
>>使用本指南时，每当您的锁定到期时，请切换回主地牢裂口指南
.xp 77 >> 在Zol'Maz碾碎暴徒，直到你的封锁期结束。尝试在每个分区的一个角上强制进行动态重生
]])
RXPGuides.RegisterGuide([[
#version 5
#wotlk
#group 地下城 刷本 70-80
<< Horde
#name 70-80 部落 地下城 刷本
step << !Mage
#completewith next
.zone Orgrimmar >> 旅行或让法师传送到奥格瑞玛
.zoneskip Durotar
step << !Mage !DK !Druid
#completewith ALFP
.goto Orgrimmar,54.10,68.37
.home >> 将您的炉石设置为Orgrimmar
step << Mage
#completewith next
.zone Undercity >> 传送到地下城
.xp <71,1
step << Mage
.goto Undercity,85.1,10.0
>>如果你预选到71岁，请接受训练
>>确保你的团队可以通过召唤石或术士召唤来召唤你
.train 43023 >> 训练你的职业咒语
.xp <71,1
step << Shaman
.goto Orgrimmar,38.6,36.0
>>如果你预选到71岁，请接受训练
>>确保你的团队可以通过召唤石或术士召唤来召唤你
.train 58699 >> 训练你的职业咒语
.xp <71,1
step << Paladin
.goto Orgrimmar,32.3,35.7
>>如果你预选到71岁，请接受训练
>>确保你的团队可以通过召唤石或术士召唤来召唤你
.train 54428 >> 训练你的职业咒语
.xp <71,1
step << Warlock
.goto Orgrimmar,48.0,46.0
>>如果你预选到71岁，请接受训练
>>确保你的团队可以通过召唤石或术士召唤来召唤你
.train 47812 >> 训练你的职业咒语
.xp <71,1
step << Hunter
.goto Orgrimmar,66.1,18.5
>>如果你预选到71岁，请接受训练
>>确保你的团队可以通过召唤石或术士召唤来召唤你
.train 49051 >> 训练你的职业咒语
.xp <71,1
step << Mage
#completewith next
.zone Orgrimmar >> 电传至Orgrimmar
.zoneskip BoreanTundra
.zoneskip Durotar
step
#completewith Zeppelin
+欢迎使用RXPGuides 70-80地牢裂口指南！
step << Shaman/Priest/Druid/Mage/Paladin
.goto Orgrimmar,45.43,56.54
>>从大楼内的Horthus购买试剂
.collect 17030,20 << Shaman 
.collect 17029,40 << Priest 
.collect 22148,40 << Druid 
.collect 22147,40 << Druid 
.collect 17032,40 << Mage 
.collect 17020,40 << Mage 
.collect 21177,100 << Paladin 
.xp >72,1
step << Druid
#completewith next
.cast 18960 >> 铸造Teleport:Moonglade
.zoneskip Moonglade
.xp <71,1
step << Druid
.goto Moonglade,52.4,40.6
>>如果你预选到71岁，请接受训练
>>前往Moonglade。确保你的团队可以通过召唤石来召唤你到Nexus/Ragefire Chasm或术士召唤
.train 48442 >> 训练你的职业咒语
.xp <71,1
step << Druid/Shaman/Paladin/Hunter/Warlock
#completewith next
.hs >> 听到奥格瑞玛，或被传送/召唤到北风苔原/涅克斯/齐柏林飞艇去北风苔原
.zoneskip Durotar
.zoneskip BoreanTundra
.xp <71,1
step
#label Zeppelin
.goto Durotar,41.6,18.2,30,0
.goto Durotar,41.26,17.45
.zone BoreanTundra >>把齐柏林飞艇从杜隆塔尔带到伯兰苔原
.zoneskip Dragonblight
.zoneskip ZulDrak
.zoneskip The Storm Peaks
.zoneskip Dalaran
.zoneskip 129 
.zoneskip 159 
.zoneskip 157 
.zoneskip 132 
.zoneskip 154 
.zoneskip 138 
step
.goto BoreanTundra,41.62,53.98
>>与齐柏林飞艇旁边的战歌招募官交谈
.accept 11585 >>接受地狱咆哮的守夜
.xp >72,1
step
>> 去战歌要塞的底层。先和加罗什谈谈，然后再和索方谈谈
.turnin 11585 >>交出地狱咆哮的守夜
.goto BoreanTundra,41.35,53.60
.accept 11596 >>接受战歌守卫
.goto BoreanTundra,41.43,53.67
.xp >72,1
step
.goto BoreanTundra,41.92,54.49
>>与威廉姆森交谈
.vendor 25278 >> 买很多新食物。在下一次休息之前，你将在接下来的3个关卡中进行地下城训练 << Warrior/Rogue/DK
.vendor 25278 >> 买很多新的食物/水。你将在下一次休息前进行3级地下城训练 << !Warrior !Rogue !DK
.isOnQuest 11596
step
.groundgoto BoreanTundra,40.72,52.54,20,0
.goto BoreanTundra,40.36,51.39
>>走坡道，然后乘电梯到大楼顶部
.fp Warsong Hold >>获取战歌保留飞行路径
step << Mage/Priest
>>跳出室外，然后在到达底部之前使用慢速下降。你也可以在派对上使用“慢降”。与小屋内的拉兹戈交谈 << Mage
>>跳到外面，然后在到达底部之前使用漂浮物。你也可以在派对上使用Levitate。与小屋内的拉兹戈交谈 << Priest
.turnin 11596 >>交出战歌防御据点

.goto BoreanTundra,43.19,54.98
.itemcount 17056,1
step
>>乘电梯下来，然后出去。与小屋内的拉兹戈交谈 << !Paladin
>>跳到外面，然后使用神盾以避免受到坠落伤害 << Paladin
.turnin 11596 >>交出战歌防御据点

.goto BoreanTundra,43.19,54.98
.xp >72,1
step
#completewith next
#label ALFP
.goto BoreanTundra,45.33,34.62
>>前往琥珀色壁架
.fp Amber Ledge >>获取琥珀色壁架飞行路径
step
#completewith next
.goto BoreanTundra,45.33,34.62
.fly Coldarra >> 飞往科尔达拉
.zoneskip Dragonblight
.zoneskip ZulDrak
.zoneskip The Storm Peaks
.zoneskip Dalaran
.zoneskip 129 
.zoneskip 159 
.zoneskip 157 
.zoneskip 132 
.zoneskip 154 
.zoneskip 138 
step
>>在室内与贝琳纳德交谈，然后在室外与雷洛拉斯兹和塞拉交谈

.accept 11900 >>接受仪表读数
.accept 11910 >>接受古人的秘密
.goto BoreanTundra,32.94,34.40
.accept 11918 >>接受基本培训
.goto BoreanTundra,33.32,34.54
.accept 13095 >>接受他们没有羞耻感吗？
.accept 11912 >>为浆果接受坚果
.goto BoreanTundra,33.49,34.38
.xp >74,1
step
.goto BoreanTundra,28.31,28.46
>>点击Nexus会议石旁边的小圆球
.complete 11900,1 
.isOnQuest 11900
step
#completewith next
.goto Borean Tundra,27.63,25.50
.zone 129 >> 进入Nexus
step << Druid/Mage/Shaman/Paladin/Warlock/Hunter
#completewith Nexus
.goto 129,19.23,52.43
>>在被冰冻联盟包围的血腥大厅的地上抢劫书
.complete 13095,1 
step << Druid/Mage/Shaman/Paladin/Warlock/Hunter
#completewith Nexus
.goto 129,65.19,21.67
>>在异常背后的平台上使用Interdimension Refabricator
.complete 11905,1 
.isOnQuest 11905
.use 35479
step << Druid/Mage/Shaman/Paladin/Warlock/Hunter
#completewith Nexus
.goto 129,54.43,55.35,0
.goto 129,58.06,54.54,0
.goto 129,64.85,51.62,0
.goto 129,62.90,64.02,0
.goto 129,49.80,67.54,0
>>杀死结晶保护剂。掠夺他们的分裂者
.complete 11911,1 
.isOnQuest 11911
step << Druid/Mage/Shaman/Paladin/Warlock/Hunter
#label Nexus
.xp 71 >> 研磨Nexus至71级
>>如果达到每小时锁定，请切换到Nexus锁定指南

step << Druid
#completewith next
.cast 18960 >> 铸造Teleport:Moonglade
.zoneskip Moonglade
.xp <71,1
step << Druid
.goto Moonglade,52.4,40.6
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48442 >> 训练你的职业咒语
.xp <71,1
step << Mage
#completewith next
.zone Undercity >> 传送到地下城
.xp <71,1
step << Mage
.goto Undercity,85.1,10.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 43023 >> 训练你的职业咒语
.xp <71,1
step << Shaman/Paladin/Warlock/Hunter
#completewith next
.hs >> 赫斯到奥格瑞玛
step << Shaman
.goto Orgrimmar,38.6,36.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 58699 >> 训练你的职业咒语
.xp <71,1
step << Paladin
.goto Orgrimmar,32.3,35.7
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 54428 >> 训练你的职业咒语
.xp <71,1
step << Warlock
.goto Orgrimmar,48.0,46.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 47812 >> 训练你的职业咒语
.xp <71,1
step << Hunter
.goto Orgrimmar,66.1,18.5
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 49051 >> 训练你的职业咒语
.xp <71,1
step << DK/Mage
#completewith Nexus2
.goto 129,19.23,52.43
>>在被冰冻联盟包围的血腥大厅的地上抢劫书
.complete 13095,1 
step << DK/Mage
#completewith Nexus2
.goto 129,65.19,21.67
>>在异常背后的平台上使用Interdimension Refabricator
.complete 11905,1 
.isOnQuest 11905
.use 35479
step << DK/Mage
#completewith Nexus2
.goto 129,54.43,55.35,0
.goto 129,58.06,54.54,0
.goto 129,64.85,51.62,0
.goto 129,62.90,64.02,0
.goto 129,49.80,67.54,0
>>杀死结晶保护剂。掠夺他们的分裂者
.complete 11911,1 
.isOnQuest 11911
step << DK/Mage
#label Nexus2
.groundgoto Borean Tundra,27.75,28.43,40,0
.goto Borean Tundra,27.63,25.09
.xp 72 >> 将Nexus研磨至72级
>>如果达到每小时锁定，请切换到Nexus锁定指南

step << DK
#completewith next
.cast 50977 >> 铸造死亡之门
.zoneskip Eastern Plaguelands
step << DK
.goto Eastern Plaguelands,80.3,48.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 49940 >> 在阿切鲁斯的Amal'Tazad训练你的职业咒语
.xp <72,1
.xp >78,1
step << Mage
#completewith next
.zone Undercity >> 传送到地下城
.xp <72,1
step << Mage
.goto Undercity,85.1,10.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 42930 >> 训练你的职业咒语
.xp <72,1
step
#completewith Nexus3
.goto 129,19.23,52.43
>>在被冰冻联盟包围的血腥大厅的地上抢劫书
.complete 13095,1 
step
#completewith Nexus3
.goto 129,65.19,21.67
>>在异常背后的平台上使用Interdimension Refabricator
.complete 11905,1 
.isOnQuest 11905
.use 35479
step
#completewith Nexus3
.goto 129,54.43,55.35,0
.goto 129,58.06,54.54,0
.goto 129,64.85,51.62,0
.goto 129,62.90,64.02,0
.goto 129,49.80,67.54,0
>>杀死结晶保护剂。掠夺他们的分裂者
.complete 11911,1 
.isOnQuest 11911
step
#label Nexus3
.groundgoto Borean Tundra,27.75,28.43,40,0
.goto Borean Tundra,27.63,25.09
.xp 73 >> 将Nexus研磨至73级
>>如果达到每小时锁定，请切换到Nexus锁定指南
step << Rogue/Hunter/Warrior/Shaman/Paladin
#completewith next
.hs >> 赫斯到奥格瑞玛
step << Mage
#completewith next
.zone Undercity >> 传送到地下城
.xp <72,1
step << Mage
.goto Undercity,85.1,10.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 43019 >> 训练你的职业咒语
.xp <73,1
step << Rogue
.goto Orgrimmar,44.0,54.6
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48667 >> 训练你的职业咒语
.xp <73,1
step << Hunter/Warrior
#completewith next
.goto Orgrimmar,63.6,38.2,30 >> 进入荣誉谷
.xp <73,1
step << Hunter
.goto Orgrimmar,66.1,18.5
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 49044 >> 训练你的职业咒语
.xp <73,1
step << Warrior
#label HuWaTraining
.goto Orgrimmar,76.9,32.6,30,0
.goto Orgrimmar,79.8,31.4
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 47470 >> 训练你的职业咒语
.xp <73,1
step << Shaman
.goto Orgrimmar,38.6,36.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 49237 >> 训练你的职业咒语
.xp <73,1
step << Paladin
.goto Orgrimmar,32.3,35.7
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48931 >> 训练你的职业咒语
.xp <73,1
step
#completewith Berinand
.goto BoreanTundra,33.49,34.38,-1
>>与Serrah交谈
.turnin 13095 >>他们没有羞耻感吗？
.isQuestComplete 13095
step
#completewith AmberL
.goto BoreanTundra,32.94,34.40,-1
>>与Berinand交谈
.vendor 25314 >> 供应商和维修
step
.goto BoreanTundra,32.94,34.40,-1
>>与Berinand交谈
.turnin 11911 >>车削加速
.turnin 11905 >>营业额推迟了不可避免的事情
.isQuestComplete 11911
.isQuestComplete 11905
step
.goto BoreanTundra,32.94,34.40,-1
>>与Berinand交谈
.turnin 11911 >>车削加速
.isQuestComplete 11911
step
#label Berinand
.goto BoreanTundra,32.94,34.40,-1
>>与Berinand交谈
.turnin 11905 >>营业额推迟了不可避免的事情
.isQuestComplete 11905
step
.goto BoreanTundra,33.49,34.38
>>与Serrah交谈
.turnin 13095 >>他们没有羞耻感吗？
.isQuestComplete 13095
step
#label AmberL
#completewith next
.goto BoreanTundra,33.13,34.45
.fly Amber Ledge >>飞到琥珀色壁架
.zoneskip Dragonblight
.zoneskip ZulDrak
.zoneskip The Storm Peaks
.zoneskip Dalaran
.zoneskip 159 
.zoneskip 157 
.zoneskip 132 
.zoneskip 154 
.zoneskip 138 
step
#completewith next
.goto BoreanTundra,46.62,32.75
>>在塔内与弗雷泽交谈
.vendor 27137 >> 买很多食物。你将在接下来的两个关卡中进行地牢训练 << Warrior/Rogue/DK
.vendor 27137 >> 买很多食物/水。你将在接下来的两个关卡中进行地牢训练 << !Warrior !Rogue !DK
.xp >74,1
step
#completewith next
.goto Dragonblight,12.27,55.25
.zone Dragonblight >> 前往Dragonblight
step
#completewith next
.goto Dragonblight,26.15,49.48,20 >> 跳进Narjun的深坑
step
.goto Dragonblight,26.18,50.79
>>与Narjun矿坑内的Kilix交谈
.accept 13187 >>接受没有脸的人
.accept 13167 >>接受叛徒国王的死亡
.accept 13182 >>接受不要忘记鸡蛋
.accept 12040 >>接受艺术中的敌人
.xp >76,1
step
#completewith next
.goto Dragonblight,25.61,51.30
.zone 159 >>进入Azjol'Nerub
step
>>清除一次Azjol’nerub。摧毁整个Azjol'Nerub的蛋
.complete 13182,1 
step
.goto 157,62.27,48.55
>>清除一次Azjol’nerub。杀死阿努布拉克。抢走他的外壳
.complete 13167,1 
step
#completewith KilixT
.goto 157,89.25,77.99
.zone Dragonblight >> 从后门离开Azjol’nerub
step
.goto Dragonblight,25.68,48.35,30,0
.goto Dragonblight,26.23,49.33,30,0
.goto Dragonblight,28.58,49.89,30,0
.goto Dragonblight,28.58,47.39,30,0
.goto Dragonblight,25.68,48.35,30,0
.goto Dragonblight,26.23,49.33,30,0
.goto Dragonblight,28.58,49.89,30,0
.goto Dragonblight,28.58,47.39
>>在纳君坑内杀死阿努巴尔地下领主
.complete 12040,1 
step
#label KilixT
.goto Dragonblight,26.18,50.79
>>与Narjun矿坑内的Kilix交谈
.turnin 13167 >>向叛徒王投降
.turnin 13182 >>交上来别忘了鸡蛋
.turnin 12040 >>在阿尔萨斯交出敌人
.accept 12041 >>接受失落的帝国
.xp >76,1
step
#completewith next
.goto Dragonblight,28.61,51.79
.zone 132 >>进入安卡赫：旧王国
step
#completewith AhnKahet1
.goto 132,33.38,49.79,40,0
.goto 132,27.61,50.24
>>就在《先驱报》沃拉齐之前杀死那些没脸的人
.complete 13187,1 
step
#completewith AhnKahet1
.goto 132,23.00,50.81
>>杀死先驱瓦拉齐
.complete 13187,2 
step
#label AhnKahet1
.xp 74 >> 研磨安卡赫：旧王国到74级
step << Druid
#completewith next
.cast 18960 >> 铸造Teleport:Moonglade
.zoneskip Moonglade
.xp <73,1
step << Druid
.goto Moonglade,52.4,40.6
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 53307 >> 训练你的职业咒语
.xp <74,1
step << DK
#completewith next
.cast 50977 >> 铸造死亡之门
.zoneskip Eastern Plaguelands
.xp <74,1
step << DK
.goto Eastern Plaguelands,80.3,48.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 49929 >> 在阿切鲁斯的Amal'Tazad训练你的职业咒语
.xp <74,1
.xp >80,1
step << Mage
#completewith next
.zone Undercity >> 传送到地下城
.xp <74,1
step << Mage
.goto Undercity,85.1,10.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 42939 >>训练你的职业咒语
.xp <74,1
step << Shaman/Paladin/Priest/Warlock/Hunter
#completewith next
.hs >> 赫斯到奥格瑞玛 << !Priest
.hs >> 赫斯向奥格瑞玛致敬。如果你是神圣的或纪律性的，跳过这一步 << Priest
step << Shaman
.goto Orgrimmar,38.6,36.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 49270 >> 训练你的职业咒语
.xp <74,1
step << Paladin
.goto Orgrimmar,32.3,35.7
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48805 >> 训练你的职业咒语
.xp <74,1
step << Priest
.goto Orgrimmar,35.6,87.8
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48126 >> 训练你的职业法术。如果你是神圣的或纪律性的，跳过这一步
.xp <74,1

step << Warlock
.goto Orgrimmar,48.0,46.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 47892 >> 训练你的职业咒语
.xp <74,1
step << Hunter
.goto Orgrimmar,66.1,18.5
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 61846 >> 训练你的职业咒语
.xp <74,1
step
.goto Dragonblight,26.18,50.79
>>与Narjun矿坑内的Kilix交谈
.turnin 13187 >>交出那些没脸的人
.isQuestComplete 13187

step
#completewith AhnKahet2
.goto 132,33.38,49.79,40,0
.goto 132,27.61,50.24
>>就在《先驱报》沃拉齐之前杀死那些没脸的人
.complete 13187,1 
step
#completewith AhnKahet2
.goto 132,23.00,50.81
>>杀死先驱瓦拉齐
.complete 13187,2 
step
#label AhnKahet2
.xp 75 >>研磨安卡赫：旧王国到75级
step << Druid
#completewith next
.cast 18960 >> 铸造Teleport:Moonglade
.zoneskip Moonglade
.xp <75,1
step << Druid
.goto Moonglade,52.4,40.6
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48440 >> 训练你的职业咒语
.xp <75,1
step << DK
#completewith next
.cast 50977 >> 铸造死亡之门
.zoneskip Eastern Plaguelands
.xp <75,1
step << DK
.goto Eastern Plaguelands,80.3,48.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 49923 >> 在阿切鲁斯的Amal'Tazad训练你的职业咒语
.xp <75,1
.xp >80,1
step << Mage
#completewith next
.zone Undercity >> 传送到地下城
.xp <75,1
step << Mage
.goto Undercity,85.1,10.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 42955 >> 训练你的职业咒语
.xp <75,1
step << Shaman/Paladin/Priest/Hunter/Warrior
#completewith next
.hs >> 赫斯到奥格瑞玛
step << Shaman
.goto Orgrimmar,38.6,36.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 49280 >> 训练你的职业咒语
.xp <75,1
step << Paladin
.goto Orgrimmar,32.3,35.7
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48818 >> 训练你的职业咒语
.xp <75,1
step << Priest
.goto Orgrimmar,35.6,87.8
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48124 >> 训练你的职业咒语
.xp <75,1
step << Hunter
.goto Orgrimmar,66.1,18.5
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 61005 >> 训练你的职业咒语
.xp <75,1
step << Warrior
.goto Orgrimmar,76.9,32.6,30,0
.goto Orgrimmar,79.8,31.4
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 55694 >> 训练你的职业咒语
.xp <75,1
step
.goto Dragonblight,26.18,50.79
>>与Narjun矿坑内的Kilix交谈
.turnin 13187 >>交出那些没脸的人
.isQuestComplete 13187
step << skip
>>谈谈通缉海报，然后再谈谈阿格玛
.accept 12091 >>接受通缉：恐怖魔爪
.goto Dragonblight,37.67,46.55
.turnin 12041 >>归还失落的帝国
.goto Dragonblight,38.16,46.33
step
>>与Agmar交谈
.turnin 12041 >>归还失落的帝国
.goto Dragonblight,38.16,46.33
step
#completewith end
#label AgmarFP
.goto Dragonblight,37.51,45.77
.fp Agmar's Hammer >> 获取Agmar的Hammer飞行路线
step << skip
.goto Dragonblight,45.84,44.52
>>杀死山顶的恐惧魔爪
.complete 12091,1 
step << skip
>>进去和戈特谈谈
.turnin 12091 >>通缉犯：恐怖魔爪
.goto Dragonblight,35.81,48.39
.isQuestComplete 12091
step
#completewith next
.goto Zul'Drak,18.29,84.66
.zone Zul'Drak >> 前往祖德拉克
step
>>旅行到光明的破灭。与Moky、Lantinga、Rageclaw和通缉海报交谈。如果你愿意，可以跳过这些任务，但建议你完成它们
.accept 12859 >>接受这一点：火仍然很热！
.goto ZulDrak,32.02,75.60
.accept 12902 >>接受以搜索答案
.goto ZulDrak,32.15,75.74
.accept 12861 >>接受巨魔疯了！
.goto ZulDrak,32.17,75.64
.accept 12857 >>接受通缉：Ragemane的Flipper
.goto ZulDrak,32.26,75.68
.xp >76,1
step
#completewith Ragemane
.goto ZulDrak,34.8,85.1,0
.goto ZulDrak,34.7,80.6,0
.use 41131 >>当垃圾站靠近着火的小屋时，请使用袋子里的愤怒爪灭火器。
.complete 12859,1 
.isOnQuest 12859
step
#completewith Fires
.goto ZulDrak,34.8,85.1,0
.goto ZulDrak,34.7,80.6,0
>>杀死该地区的不死巨魔。抢他们的开锁器
.use 41161 >>在俘虏的狂暴爪上使用它们来释放它们
.collect 41161,8,12861,1,-1
.complete 12861,1 
.isOnQuest 12861
step
.goto ZulDrak,34.94,83.90
>>单击浮动滚动条
.turnin 12902 >>交上来寻找答案
.accept 12883 >>接受Drakuru的订单
.isOnQuest 12902
step
.goto ZulDrak,34.94,83.90
>>单击浮动滚动条
.accept 12883 >>接受Drakuru的订单
.isQuestTurnedIn 12902
step
#label Ragemane
.goto ZulDrak,38.29,84.93
>>到水里去。杀死雷格曼。抢他的Flipper
.complete 12857,1 
.isOnQuest 12857
step
#label Fires
.goto ZulDrak,34.8,85.1,80,0
.goto ZulDrak,34.7,80.6
.use 41131 >>当靠近着火的小屋时，使用愤怒爪灭火器
.complete 12859,1 
.isOnQuest 12859
step
.goto ZulDrak,34.8,85.1,80,0
.goto ZulDrak,34.7,80.6
>>杀死该地区的不死巨魔。抢他们的开锁器（放进你的包里）
.use 41161 >>在俘虏的狂暴爪上使用它们来释放它们
.collect 41161,8,12861,1,-1
.complete 12861,1 
.isOnQuest 12861
step
#completewith end
#label Langtina1
>>与Lantinga交谈
.turnin 12883 >>提交Drakuru的订单
.accept 12884 >>接受Ebon Watch
.accept 12894 >>接受十字军前卫营地
.goto ZulDrak,32.15,75.74
.isQuestComplete 12883

step
#completewith end
#requires Langtina1
#label Langtina2
>>与Lantinga交谈
.accept 12884 >>接受Ebon Watch
.accept 12894 >>接受十字军前卫营地
.goto ZulDrak,32.15,75.74
.isQuestTurnedIn 12883
step
#completewith end
#label Rageclaw1
>>与愤怒爪对话
.turnin 12857 >>通缉犯：Ragemane的Flipper
.turnin 12861 >>投奔巨魔疯了！
.goto ZulDrak,32.2,75.7
.isQuestComplete 12857
.isQuestComplete 12861
step
#completewith end
#requires Rageclaw1
#label Rageclaw2
>>与愤怒爪对话
.turnin 12857 >>通缉犯：Ragemane的Flipper
.goto ZulDrak,32.17,75.64
.isQuestComplete 12857
step
#completewith end
#requires Rageclaw2
#label Rageclaw3
>>与愤怒爪对话
.turnin 12861 >>投奔巨魔疯了！
.goto ZulDrak,32.17,75.64
.isQuestComplete 12861
step
#completewith end
#label Moky
>>与莫基交谈
.turnin 12859 >>把这个交上来：火还热！
.goto ZulDrak,32.02,75.60
.isQuestComplete 12859
step
#requires Langtina2
step
#requires Rageclaw3
step
#requires Moky
.goto ZulDrak,32.18,74.39
>>与Danica交谈
.fp Light's Breach >>获取光的破解飞行路径
step
>>骑马前往十字军前方营地。与Mackeller交谈
.turnin 12894 >>转入十字军前卫营地
.accept 12903 >>接受这就是朋友的目的。。。
.goto ZulDrak,25.28,63.96


.isQuestTurnedIn 12883
step
.goto ZulDrak,25.05,51.61
>>靠近十字军Dargath，直到目标完成
.complete 12903,1 
.isOnQuest 12903
step
.goto ZulDrak,19.78,56.35
>>在巨大的笼子里和体操运动员交谈。尽量避免杀死该地区的瓦格尔人
.accept 12912 >>接受大风暴接近
.isOnQuest 12903
step
.goto ZulDrak,17.64,57.55
>>和瘟疫箱里的格克谈谈。尽量避免杀死该地区的瓦格尔人
.complete 12903,2 
.accept 12904 >>接受光明不会让我复仇
.isOnQuest 12903
step
#completewith next
.goto ZulDrak,19.8,56.9,0
.goto ZulDrak,23.2,54.7,0
.goto ZulDrak,21.4,51.3,0
.goto ZulDrak,15.0,61.3,0
>>杀死该地区的任何瓦格尔类人
.complete 12904,1 
.isOnQuest 12904
step << skip
#completewith next
.goto ZulDrak,19.5,58.9,0
.goto ZulDrak,15.3,62.2,0
.goto ZulDrak,13.3,59.9,0
.goto ZulDrak,18.7,54.5,0
>>收集散落在整个区域的废金属碎片
.complete 12901,1 
step
.goto ZulDrak,15.67,59.41
>>接近Burr，直到目标完成
.complete 12903,3 
.isOnQuest 12903
step << skip
#label Metal
.goto ZulDrak,19.1,61.8,70,0
.goto ZulDrak,15.3,62.2,70,0
.goto ZulDrak,13.3,59.9,70,0
.goto ZulDrak,18.7,54.5
>>收集散落在整个区域的废金属碎片
.complete 12901,1 
step
.goto ZulDrak,19.8,56.9,70,0
.goto ZulDrak,23.2,54.7,70,0
.goto ZulDrak,21.4,51.3,70,0
.goto ZulDrak,15.0,61.3
>>杀死该地区的任何瓦格尔类人
.complete 12904,1 
.isOnQuest 12904
step
.goto ZulDrak,17.64,57.55
>>与Gerk交谈
.turnin 12904 >>灯亮了不会让我复仇
.isQuestComplete 12904
step
>>返回十字军前卫营地。与Reed和MacKellar交谈
.turnin 12912 >>大风暴接近时转弯



.turnin 12903 >>交朋友就是为了。。。
.goto ZulDrak,25.28,63.96
.isQuestComplete 12903
.isOnQuest 12912
step
>>返回十字军前卫营地。与MacKellar交谈



.turnin 12903 >>交朋友就是为了。。。
.goto ZulDrak,25.28,63.96
.isQuestComplete 12903
step
>>返回十字军前卫营地。与里德交谈
.turnin 12912 >>大风暴接近时转弯
.goto ZulDrak,25.22,63.88


.isOnQuest 12912
step
.goto ZulDrak,39.43,66.96
>>前往银色看台。与Falstaav交谈

.accept 12503 >>接受防守

.xp >78,1
step
.goto ZulDrak,40.53,65.61
>>如果你认为你会有至少10个Drakkari Offerings在你们中间，把它们全部交易给某人，然后接受这个任务，让他们可以交上来。这会给他们1小时的力量祝福（攻击力）
>>与乌本戈交谈
.accept 12565 >>接受津巴布韦的祝福
.xp >78,1
step << skip
#completewith next
.goto ZulDrak,36.6,67.7,0
.use 39615 >>使用背包中的十字军降落伞对付银色十字军或盾牌兵
.complete 12740,1 
step
.goto ZulDrak,35.8,66.6
>>杀死该地区的亡灵暴徒
.complete 12503,1 
.isOnQuest 12503
step << skip
.goto ZulDrak,36.6,67.7
.use 39615 >>使用背包中的十字军降落伞对付银色十字军或盾牌兵
.complete 12740,1 
step << skip
.goto ZulDrak,35.8,66.6
>>杀死该地区的亡灵暴徒。掠夺他们以换取Drakkari优惠
.collect 38551,10 
step
.goto ZulDrak,36.70,72.72
>>点击雕像
.turnin 12565 >>交上津巴布韦的祝福
.isQuestComplete 12565
step
.goto ZulDrak,39.43,66.96
>>与Falstaav交谈

.turnin 12503 >>转身防守看台

.isQuestComplete 12503
step
#completewith next
.goto ZulDrak,40.83,66.25
>>与Marissa交谈
.vendor 28791 >>买很多新食物。在下一次休息之前，你将在接下来的两个关卡中进行地下城训练 << Warrior/Rogue/DK
.vendor 28791 >>买很多新的食物/水。在下一次休息之前，你将在接下来的两个关卡中进行地下城训练 << !Warrior !Rogue !DK
.xp >78,1
step
#completewith next
.goto ZulDrak,41.09,65.15
>>与艾丹交谈
.vendor 28800 >>供应商和维修
.xp >78,1
step
.goto ZulDrak,41.55,64.43
.fp The Argent Stand >>获取银色停机位飞行路线
step
>>完成《痛苦任务线》的剧情片。有6个精英任务可以提供大量的快速xp和一件武器，可以让你持续到80。只有当你的队伍准备好并且任务进度与你相同时才接受这个。（此问题行禁用自动接受）
.goto ZulDrak,46.3,57.9,50,0
.goto ZulDrak,48.43,56.36
.accept 12932,0 >>接受痛苦的剧场：Yggdras！
.xp >78,1
step
.goto ZulDrak,47.83,56.83
>>在Anguish剧场杀死Yggdras
.complete 12932,1 
.isOnQuest 12932
step
.goto ZulDrak,48.47,56.41
>>与沃丁交谈
.turnin 12932 >>把痛苦的剧场：伊格德拉斯！
.isQuestComplete 12932
step
.goto ZulDrak,48.43,56.36
>>与Gurgthock交谈。只有当你的队伍已经准备好并且与你的任务进度相同时，才能接受这个。
.accept 12933,0 >>接受痛苦的剧场：巨无霸！
.isQuestTurnedIn 12932
step
.goto ZulDrak,47.83,56.83
>>杀死痛苦剧场的臭胡子
.complete 12933,1 
.isQuestTurnedIn 12932
step
.goto ZulDrak,48.47,56.41
>>与沃丁交谈
.turnin 12933 >>把《痛苦的剧场：大人物》交上来！
.isQuestTurnedIn 12932
step
.goto ZulDrak,48.43,56.36
>>与Gurgthock交谈。只有当你的队伍已经准备好并且与你的任务进度相同时，才能接受这个。
.accept 12934,0 >>接受痛苦的剧场：来自远方！
.isQuestTurnedIn 12932
step
.goto ZulDrak,47.83,56.83
>>杀死痛苦剧场中的元素领主
.complete 12934,1 
.isQuestTurnedIn 12932
step
.goto ZulDrak,48.47,56.41
>>与沃丁交谈
.turnin 12934 >>交出《痛苦的剧场：来自远方》！
.isQuestTurnedIn 12932
step
.goto ZulDrak,48.43,56.36
>>与Gurgthock交谈。只有当你的队伍已经准备好并且与你的任务进度相同时，才能接受这个。
.accept 12935,0 >>接受痛苦的两极加热器：Tuskarrmageddon！
.isQuestTurnedIn 12932
step
.goto ZulDrak,47.83,56.83
>>在安圭什剧场杀死奥里诺科
.complete 12935,1 
.isQuestTurnedIn 12932
step
.goto ZulDrak,48.47,56.41
>>与沃丁交谈
.turnin 12935 >>交给《痛苦的两极加热器：Tuskarrmageddon》！
.isQuestTurnedIn 12932
step
.goto ZulDrak,48.43,56.36
>>与Gurgthock交谈。只有当你的队伍已经准备好并且与你的任务进度相同时，才能接受这个。
.accept 12936,0 >>接受痛苦的剧场：血腥者科拉克！
.isQuestTurnedIn 12932
step
.goto ZulDrak,47.83,56.83
>>在安圭什剧场杀死科拉克
.complete 12936,1 
.isQuestTurnedIn 12932
step
.goto ZulDrak,48.47,56.41
>>与沃丁交谈
.turnin 12936 >>把《安圭什剧场》交上来：血行者科拉克！
.isQuestTurnedIn 12932
step
.goto ZulDrak,48.43,56.36
>>与Gurgthock交谈。只有当你的队伍已经准备好并且与你的任务进度相同时，才能接受这个。
.accept 12948,0 >>接受痛苦的冠军
.isQuestTurnedIn 12932
step
.goto ZulDrak,47.83,56.83
>>在Anguish剧场杀死Vladof
.complete 12948,1 
.isQuestTurnedIn 12932
step
.goto ZulDrak,48.47,56.41
>>与沃丁交谈
.turnin 12948 >>交出痛苦的冠军
.isQuestTurnedIn 12932
step
.groundgoto ZulDrak,51.20,54.32,60,0
>>走你身后的楼梯，向Zim'Torga走去。与托基尼交谈
.accept 13099 >>接受“仅签入”
.goto ZulDrak,59.98,57.93
.xp >78,1
step
.groundgoto ZulDrak,65.47,44.23,60,0
.goto Zul'Drak,70.06,20.92
>>与巴基尼人交谈
.turnin 13099 >> “只需签入”
.accept 13098 >> 为后代接受
.accept 13111 >> 接受一种
.xp >78,1
step
#completewith next
.goto Zul'Drak,76.02,20.79
.zone 154 >> 输入Gundrak
step
#completewith Gundrak1
.goto 154,56.80,41.61
.goto 154,52.28,68.79
.goto 154,48.64,78.52
.goto 154,49.42,81.91
.goto 154,48.27,71.79
.goto 154,44.95,67.51
.goto 154,47.97,63.31
.goto 154,46.23,52.77
.goto 154,41.46,72.29
.goto 154,30.61,76.64
.goto 154,31.80,69.53
.goto 154,32.28,65.89
.goto 154,33.63,58.70
.goto 154,36.22,58.40
.goto 154,36.24,56.40
.goto 154,32.53,56.32
.goto 154,31.81,49.55
.goto 154,31.77,45.85
.goto 154,40.21,51.56
.goto 154,39.94,47.99
.goto 154,38.92,47.34
.goto 154,43.93,31.06
.goto 154,41.51,25.48
.goto 154,39.40,21.64
.goto 154,40.03,16.82
.goto 154,46.31,22.51
.goto 154,49.21,30.61
.goto 154,49.74,27.77
.goto 154,53.08,17.08
>>抢劫在贡德拉克发现的德拉克里历史碑
.complete 13098,1 
step
#completewith Gundrak1
.goto 154,46.60,65.71
>>杀死德拉卡里巨像。抢劫它的碎片
.complete 13111,1 
step << DK/Mage/Shaman/Hunter/Rogue
#label Gundrak1
.xp 76 >>将Gundrak研磨至76级
>>如果您达到每小时锁定，请切换到Gundrak锁定指南

step << DK
#completewith next
.cast 50977 >> 铸造死亡之门
.zoneskip Eastern Plaguelands
.xp <76,1
step << DK
.goto Eastern Plaguelands,80.3,48.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 49894 >> 在阿切鲁斯的Amal'Tazad训练你的职业咒语
.xp <76,1
.xp >80,1
step << Mage
#completewith next
.zone Undercity >> 传送到地下城
.xp <76,1
step << Mage
.goto Undercity,85.1,10.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 42920 >> 训练你的职业咒语
.xp <76,1
step << Shaman/Hunter/Rogue
#completewith next
.hs >> 赫斯到奥格瑞玛
step << Shaman
.goto Orgrimmar,40.5,36.9,25,0
.goto Orgrimmar,38.6,36.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 58803 >> 训练你的职业咒语
.xp <76,1
step << Hunter
.goto Orgrimmar,63.6,38.2,30,0
.goto Orgrimmar,66.1,18.5
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 53338 >> 训练你的职业咒语
.xp <76,1
step << Rogue
.goto Orgrimmar,40.4,54.5,30,0
.goto Orgrimmar,44.0,54.6
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48637 >> 训练你的职业咒语
.xp <76,1
step
#completewith Gundrak2
.goto 154,56.80,41.61
.goto 154,52.28,68.79
.goto 154,48.64,78.52
.goto 154,49.42,81.91
.goto 154,48.27,71.79
.goto 154,44.95,67.51
.goto 154,47.97,63.31
.goto 154,46.23,52.77
.goto 154,41.46,72.29
.goto 154,30.61,76.64
.goto 154,31.80,69.53
.goto 154,32.28,65.89
.goto 154,33.63,58.70
.goto 154,36.22,58.40
.goto 154,36.24,56.40
.goto 154,32.53,56.32
.goto 154,31.81,49.55
.goto 154,31.77,45.85
.goto 154,40.21,51.56
.goto 154,39.94,47.99
.goto 154,38.92,47.34
.goto 154,43.93,31.06
.goto 154,41.51,25.48
.goto 154,39.40,21.64
.goto 154,40.03,16.82
.goto 154,46.31,22.51
.goto 154,49.21,30.61
.goto 154,49.74,27.77
.goto 154,53.08,17.08
>>抢劫在贡德拉克发现的德拉克里历史碑
.complete 13098,1 
step
#completewith Gundrak2
.goto 154,46.60,65.71
>>杀死德拉卡里巨像。抢劫它的碎片
.complete 13111,1 
step
#label Gundrak2
.xp 77 >>将Gundrak研磨至77级
>>如果您达到每小时锁定，请切换到Gundrak锁定指南
step << Warlock
#completewith next
.hs >> 赫斯到奥格瑞玛
step << Warlock
.goto Orgrimmar,40.4,54.5,30,0
.goto Orgrimmar,48.0,46.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 47813 >> 训练你的职业咒语
.xp <77,1
step
.goto Zul'Drak,70.06,20.92
>>退出Gundrak。与巴基尼人交谈
.turnin 13098 >> 为后代而上
.turnin 13111 >> 上缴一种
.isQuestComplete 13098
.isQuestComplete 13111
step
.goto Zul'Drak,70.06,20.92
>>退出Gundrak。与巴基尼人交谈
.turnin 13098 >> 为后代而上
.isQuestComplete 13098
step
.goto Zul'Drak,70.06,20.92
>>退出Gundrak。与巴基尼人交谈
.turnin 13098 >> 为后代而上
.isQuestComplete 13098
step
#completewith next
.goto ZulDrak,70.47,23.30
.fp Dubra'Jin >> 获取Dubra'Jin航线
step
#completewith next
.goto ZulDrak,70.47,23.30
.fly The Argent Stand >> 飞到银色看台
step
.goto ZulDrak,40.83,66.25
>>与Marissa交谈
.vendor 25245 >>买很多食物。你将在最后3关做地牢 << Warrior/Rogue/DK
.vendor 28791 >>买很多食物/水。你将在最后3关做地牢 << !Warrior !Rogue !DK
.xp >78,1
step
.goto ZulDrak,41.09,65.15
>>与艾丹交谈
.vendor 28800 >>供应商和维修
.xp >78,1
step
#completewith next
.goto ZulDrak,40.63,66.90
>>与Teronus交谈
.accept 12796 >>接受达拉然魔法王国
.zoneskip Orgrimmar
.zoneskip Dalaran
.xp >78,1
step
.goto ZulDrak,40.63,66.90
.zone Dalaran >>让泰罗诺斯被传送到达拉然
.skipgossip
.xp >78,1
step
.abandon 12796 >> 放弃达拉然魔法王国。不要把这个交进去
step << Mage
.goto Dalaran,56.3,46.7
.trainer >>进入大楼。训练您的达拉然门户
step << Mage
.goto Dalaran,55.0,46.2
.train 42985 >> 训练你的职业咒语
.xp <77,1
step
.goto Dalaran,69.81,45.45
.train 54197 >> 从Hira Snowdawn乘火车寒冷天气飞行
step << skip
.goto The Storm Peaks,65.3,60.2
.accept 13109 >>接受直径相反
.accept 13108 >>接受一切代价
step
#completewith next
.goto The Storm Peaks,45.56,21.10
.zone 138 >>进入闪电大厅
step << Warrior/Druid/DK/Mage
.xp 78 >>将闪电大厅研磨至78级
step << Druid
#completewith next
.cast 18960 >> 铸造Teleport:Moonglade
.zoneskip Moonglade
.xp <78,1
step << Druid
.goto Moonglade,52.4,40.6
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48465 >> 训练你的职业咒语
.xp <78,1
step << DK
#completewith next
.cast 50977 >> 铸造死亡之门
.zoneskip Eastern Plaguelands
.xp <78,1
step << DK
.goto Eastern Plaguelands,80.3,48.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 49941 >> 在阿切鲁斯的Amal'Tazad训练你的职业咒语。如果需要的话，把你的武器运到楼下
.xp <78,1
step << Mage
#completewith next
.zone Dalaran >> 传送至达拉然
.xp <78,1
step << Mage
.goto Dalaran,55.0,46.2
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 42914 >> 训练你的职业咒语
.xp <78,1
step << Warrior
#completewith next
.hs >> 赫斯到奥格瑞玛
step << Warrior
.goto Orgrimmar,63.6,38.2,30,0
.goto Orgrimmar,76.9,32.6,20,0
.goto Orgrimmar,79.8,31.4
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 47436 >> 训练你的职业咒语
.xp <78,1
step << Mage/Druid/DK
.xp 79 >>将闪电大厅研磨至79级
step << Mage
#completewith next
.zone Dalaran >> 传送至达拉然
.xp <79,1
step << Mage
.goto Dalaran,55.0,46.2
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 43046 >> 训练你的职业咒语
.xp <79,1
step << Druid
#completewith next
.cast 18960 >> 铸造Teleport:Moonglade
.zoneskip Moonglade
.xp <79,1
step << Druid
.goto Moonglade,52.4,40.6
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 48378 >> 训练你的职业咒语
.xp <79,1
step << DK
#completewith next
.cast 50977 >> 铸造死亡之门
.zoneskip Eastern Plaguelands
.xp <79,1
step << DK
#label DKTrain1
.goto Eastern Plaguelands,80.3,48.0
>>确保你的团队可以通过召唤石或术士召唤将你召唤回来
.train 55271 >> 在阿切鲁斯的Amal'Tazad训练你的职业咒语
.xp <79,1
step
.xp 80 >>将闪电大厅研磨至80级
step << skip
.goto The Storm Peaks,65.3,60.2
.turnin 13109 >>直径相反的转向
.turnin 13108 >>交出一切
>>丁80级-恭喜！
step
+恭喜您完成了RestedXP 70-80地牢裂口指南！感谢您使用RestedXP。
]])
RXPGuides.RegisterGuide([[
#version 5
#wotlk
#group 地下城 刷本 70-80
<< Horde
#name 70-73 魔枢副本 - Coldarra
#next 70-80 部落 地下城 刷本
step
#completewith end
+使用本指南时，每当您的锁定到期时，请切换回主地牢裂口指南
step
#completewith Weaver1
>>当你通过科尔达拉探索时：
>>-杀死你看到的所有Coldarra Spellweavers
>>-寻找地上的霜莓灌木。如果你愿意，就跳过灌木
.complete 11918,1 
.complete 11912,1 
step
.goto BoreanTundra,32.6,27.8
>>杀死该地区的科尔达拉·斯皮尔宾德斯。抢走他们以获取闪烁碎片。在您的包中点击它
.collect 35648,1,11941 
.accept 11941 >>接受拼图。。。
step
>>与Serrah、Raelorasz和Berinand交谈
.turnin 13095 >>他们没有羞耻感吗？
.goto BoreanTundra,33.49,34.38,-1
.turnin 11941 >>交给Puzzling。。。
.accept 11943 >>接受单元格
.goto BoreanTundra,33.32,34.54,-1
.turnin 11905 >>营业额推迟了不可避免的事情
.goto BoreanTundra,32.94,34.40,-1
.isQuestComplete 13095
.isQuestComplete 11905
step
>>与Serrah和Raelorasz交谈
.turnin 13095 >>他们没有羞耻感吗？
.goto BoreanTundra,33.49,34.38,-1
.turnin 11941 >>交给Puzzling。。。
.accept 11943 >>接受单元格
.goto BoreanTundra,33.32,34.54,-1
.isQuestComplete 13095
step
>>与Raelorasz和Berinand交谈
.turnin 11941 >>交给Puzzling。。。
.accept 11943 >>接受单元格
.goto BoreanTundra,33.32,34.54,-1
.turnin 11905 >>营业额推迟了不可避免的事情
.goto BoreanTundra,32.94,34.40,-1
.isQuestComplete 11905
step << skip
.goto BoreanTundra,32.94,34.40,-1
>>与Berinand交谈
.turnin 11905 >>营业额推迟了不可避免的事情
.turnin 11911 >>车削加速
.isQuestComplete 11905
.isQuestComplete 11911
step
>>与Raelorasz交谈
.turnin 11941 >>交给Puzzling。。。
.accept 11943 >>接受单元格
.goto BoreanTundra,33.32,34.54
.isQuestComplete 11941
step
#label Puzzle
>>与Raelorasz交谈
.accept 11943 >>接受单元格
.goto BoreanTundra,33.32,34.54
.isQuestTurnedIn 11941
step
#completewith end1
#level 73
+完成你即将完成的任务/认为你可以完成的任务，然后放弃所有未完成的Coldarra/Nexus相关任务
step
#completewith splinters
>>在科尔达拉周围寻找冰川古人和魔法古人。掠夺他们的分裂者
.complete 11910,1 
.complete 11910,2 
.isOnQuest 11910
step
.goto BoreanTundra,28.31,28.46
>>点击Nexus会议石旁边的小圆球
.complete 11900,1 
.isOnQuest 11900
step
.goto BoreanTundra,28.25,35.04
>>点击建筑内的蓝色小圆球（不是浮动的）
.complete 11900,2 
.isOnQuest 11900
step
.goto BoreanTundra,24.14,29.60
>>杀死战争使者戈雷德拉克。抢劫他的能量核心
.complete 11943,1 
.isOnQuest 11943
.unitscan Warbringer Goredrak
step
.goto BoreanTundra,22.62,23.42
>>点击建筑内的蓝色小圆球（不是浮动的）
.complete 11900,4 
.isOnQuest 11900
step
.goto BoreanTundra,27.32,20.41
>>杀死塞鲁伦将军。抢劫他入狱
.complete 11943,2 
.isOnQuest 11943
.unitscan General Cerulean
step
#label Weaver1
.goto BoreanTundra,31.72,20.57
>>点击建筑内的蓝色小圆球（不是浮动的）
.complete 11900,3 
.isOnQuest 11900
step
#sticky
#label berries2
.goto BoreanTundra,25.5,35.6,70,0
.goto BoreanTundra,25.0,30.6,70,0
.goto BoreanTundra,28.0,33.5,70,0
.goto BoreanTundra,32.6,28.2,70,0
.goto BoreanTundra,30.1,23.4
>>杀死你看到的所有Coldarra Spellweavers
.complete 11918,1 
.isOnQuest 11918
step
.goto BoreanTundra,21.5,26.9,70,0
.goto BoreanTundra,24.4,35.2,70,0
.goto BoreanTundra,34.3,31.2,70,0
.goto BoreanTundra,33.7,23.1
>>抢劫整个科尔达拉的霜莓灌木。如果你想跳过这个
.complete 11912,1 
.isOnQuest 11912
step
#requires berries2
step
#completewith end
#label Serrah1
>>与Serrah交谈
.turnin 11912 >>将坚果倒入浆果中
.turnin 13095 >>他们没有羞耻感吗？
.accept 11914 >>接受保持秘密安全
.goto BoreanTundra,33.49,34.38,-1
.isQuestComplete 11912
.isQuestComplete 13095
step
#completewith end
#requires Serrah1
#label Serrah2
>>与Serrah交谈
.turnin 11912 >>将坚果倒入浆果中
.accept 11914 >>接受保持秘密安全
.goto BoreanTundra,33.49,34.38,-1
.isQuestComplete 11912
step
#completewith end
#requires Serrah2
#label Serrah3
>>与Serrah交谈
.accept 11914 >>接受保持秘密安全
.goto BoreanTundra,33.49,34.38,-1
.isQuestTurnedIn 11912
step
#completewith end
#requires Serrah3
#label Serrah4
>>与Serrah交谈
.turnin 13095 >>他们没有羞耻感吗？
.goto BoreanTundra,33.49,34.38,-1
.isQuestComplete 13095
step
#completewith end
#label Raelorasz1
>>与Raelorasz交谈
.turnin 11918 >>上交基础培训
.accept 11936 >>接受填充平面
.turnin 11943 >>交出牢房
.goto BoreanTundra,33.32,34.54,-1
.isQuestComplete 11918
.isQuestComplete 11943
step
#completewith end
#requires Raelorasz1
#label Raelorasz2
>>与Raelorasz交谈
.turnin 11918 >>上交基础培训
.accept 11936 >>接受填充平面
.goto BoreanTundra,33.32,34.54,-1
.isQuestComplete 11918
step
#completewith end
#requires Raelorasz2
#label Raelorasz3
>>与Raelorasz交谈
.accept 11936 >>接受填充平面
.goto BoreanTundra,33.32,34.54,-1
.isQuestTurnedIn 11918
step
#completewith end
#requires Raelorasz3
#label Raelorasz4
>>与Raelorasz交谈
.turnin 11943 >>交出牢房
.goto BoreanTundra,33.32,34.54,-1
.isQuestComplete 11943
step
>>与Berinand交谈
.turnin 11910 >>交出古代的秘密
.turnin 11900 >>转动仪表读数
.accept 11905 >>接受推迟不可避免的事情
.accept 11911 >>接受加快
.goto BoreanTundra,32.94,34.40,-1
.isQuestComplete 11910
step
>>与Berinand交谈
.turnin 11910 >>交出古代的秘密
.turnin 11905 >>营业额推迟了不可避免的事情
.accept 11911 >>接受加快
.goto BoreanTundra,32.94,34.40,-1
.isQuestComplete 11910
.isQuestComplete 11905
step
>>与Berinand交谈
.turnin 11905 >>营业额推迟了不可避免的事情
.goto BoreanTundra,32.94,34.40,-1
.isQuestComplete 11905
step
>>与Berinand交谈
.turnin 11910 >>交出古代的秘密
.accept 11911 >>接受加快
.goto BoreanTundra,32.94,34.40,-1
.isQuestComplete 11910
step
>>与Berinand交谈
.accept 11911 >>接受加快
.goto BoreanTundra,32.94,34.40,-1
.isQuestTurnedIn 11911
step
>>与Berinand交谈
.turnin 11900 >>转动仪表读数
.accept 11905 >>接受推迟不可避免的事情
.goto BoreanTundra,32.94,34.40,-1
.isQuestComplete 11900
step
>>与Berinand交谈
.accept 11905 >>接受推迟不可避免的事情
.goto BoreanTundra,32.94,34.40,-1
.isQuestTurnedIn 11900
step
#requires Raelorasz4
.use 35671 >> 点击你包里的强化奥术监狱召唤克里斯特拉斯扎
.accept 11946 >>接受Keristrasza
.turnin 11946 >>转入Keristrasza
.accept 11951 >>接受诱饵并切换
.isQuestTurnedIn 11943
step
#requires Serrah4
#completewith next
.goto BoreanTundra,24.9,31.2,0
.goto BoreanTundra,25.2,24.2,0
>>绕过Nexus的上边缘/悬崖。掠夺地面上的紫色小水晶
.complete 11951,1 
.isOnQuest 11951
step
#requires Serrah4
.goto BoreanTundra,29.5,30.81,90,0
.goto BoreanTundra,28.7,33.6,70,0
.goto BoreanTundra,27.5,31.3,70,0
.goto BoreanTundra,24.9,31.2,70,0
.goto BoreanTundra,25.2,24.2
>>绕过Nexus的上边缘/悬崖。杀死科尔达拉·威姆金斯。掠夺他们的斧头
.collect 35586,5,11936,1 
.isOnQuest 11936
step
.goto BoreanTundra,24.9,31.2,50,0
.goto BoreanTundra,25.2,24.2
>>绕过Nexus的上边缘/悬崖。掠夺地面上的紫色小水晶
.complete 11951,1 
.isOnQuest 11951
step
.goto BoreanTundra,29.3,27.4,50,0
.goto BoreanTundra,28.2,24.4,50,0
.goto BoreanTundra,26.2,25.4
>>绕过Nexus的较低区域。杀死奥术蛇并掠夺它们的精华。
>>使用您刚刚收集的斧头，在下方区域周围打破龙蛋
.collect 35586,5,11936,1,-1 
.complete 11936,1 
.complete 11914,1 
.isOnQuest 11936
.isOnQuest 11914
step
.goto BoreanTundra,29.3,27.4,50,0
.goto BoreanTundra,28.2,24.4,50,0
.goto BoreanTundra,26.2,25.4
>>绕过Nexus的较低区域。杀死奥术蛇并掠夺它们的精华。
.complete 11914,1 
.isOnQuest 11914
step
#label splinters
.goto BoreanTundra,29.3,27.4,50,0
.goto BoreanTundra,28.2,24.4,50,0
.goto BoreanTundra,26.2,25.4
>>使用您刚刚收集的斧头，在下方区域周围打破龙蛋
.collect 35586,5,11936,1,-1 
.complete 11936,1 
.isOnQuest 11936
step
.goto BoreanTundra,30.1,23.4,70,0
.goto BoreanTundra,32.6,28.2,70,0
.goto BoreanTundra,28.0,33.5,70,0
.goto BoreanTundra,25.0,30.6,70,0
.goto BoreanTundra,25.5,35.6
>>杀死冰川古人和魔法古人。掠夺他们的分裂者
.complete 11910,1 
.complete 11910,2 
.isOnQuest 11910
step
.use 35671 >> 点击你包里的强化奥术监狱召唤凯里斯特拉斯扎。如果您丢失了它，请与Raelorasz联系，要求新的。确保至少有一名党员不使用它
.turnin 11951 >>转入诱饵和开关
.accept 11957 >>接受萨拉戈萨的终结
.isQuestComplete 11951
step
.use 35671 >> 点击你包里的强化奥术监狱召唤凯里斯特拉斯扎。如果您丢失了它，请与Raelorasz联系，要求新的。确保至少有一名党员不使用它
.accept 11957 >>接受萨拉戈萨的终结
.isQuestTurnedIn 11951
step
#completewith next
.cast 46793 >> 再和克里斯特拉斯扎谈谈，她会把你传送到萨拉戈萨登陆。抵达后，前往平台中心，使用背包中的奥术力量聚焦召唤萨拉戈萨。
.goto BoreanTundra,21.57,22.55
.use 35690 
.isOnQuest 11957
step
>>杀死萨拉戈萨。抢劫她的尸体
.complete 11957,1 
.goto BoreanTundra,22.07,22.65
.use 35690 
.skipgossip
.isOnQuest 11957
step
.use 35671 >> 点击你包里的强化奥术监狱召唤克里斯特拉斯扎
.turnin 11957 >>交回萨拉戈萨的终点
.accept 11967 >>接受召集红军
.goto BoreanTundra,21.57,22.55
.isQuestComplete 11957
step
.use 35671 >> 点击你包里的强化奥术监狱召唤克里斯特拉斯扎
.accept 11967 >>接受召集红军
.goto BoreanTundra,21.57,22.55
.isQuestTurnedIn 11957
step
.goto BoreanTundra,22.07,22.65
.goto BoreanTundra,33.21,34.31,50 >>不要骑马返回Transitus。再次与Keristrasza通话，传送回Coldarra
.isOnQuest 11967
step
#completewith end
#label Serrah5
>>与Serrah交谈
.turnin 11914 >>交上来保守秘密
.turnin 13095 >>他们没有羞耻感吗？
.goto BoreanTundra,33.49,34.38,-1
.isQuestComplete 11914
.isQuestComplete 13095
step
#completewith end
#requires Serrah5
#label Serrah6
>>与Serrah交谈
.turnin 13095 >>他们没有羞耻感吗？
.goto BoreanTundra,33.49,34.38,-1
.isQuestComplete 13095
step
#completewith end
#requires Serrah6
#label Serrah7
>>与Serrah交谈
.turnin 11914 >>交上来保守秘密
.goto BoreanTundra,33.49,34.38,-1
.isQuestComplete 11914
step
#completewith end
#label Raelorasz5
>>与Raelorasz交谈
.turnin 11967 >>轮流召集红军
.turnin 11936 >>上交绘制平面图
.goto BoreanTundra,33.32,34.54,-1
.isQuestComplete 11967
.isQuestComplete 11936
step
#completewith end
#requires Raelorasz5
#label Raelorasz6
>>与Raelorasz交谈
.turnin 11967 >>轮流召集红军
.goto BoreanTundra,33.32,34.54,-1
.isQuestComplete 11967
step
#completewith end
#requires Raelorasz6
#label Raelorasz7
>>与Raelorasz交谈
.turnin 11936 >>上交绘制平面图
.goto BoreanTundra,33.32,34.54,-1
.isQuestComplete 11936
step
#completewith end
.goto BoreanTundra,32.94,34.40,-1
>>与Berinand交谈
.vendor 25314 >> 供应商和维修
step
>>与Berinand交谈
.turnin 11900 >>轮流读取仪表
.turnin 11905 >>营业额推迟了不可避免的事情
.turnin 11910 >>交出古代的秘密
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11900
.isQuestComplete 11905
.isQuestComplete 11910
step
>>与Berinand交谈
.turnin 11900 >>轮流读取仪表
.turnin 11905 >>营业额推迟了不可避免的事情
.turnin 11911 >>转弯加速
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11900
.isQuestComplete 11905
.isQuestComplete 11911
step
>>与Berinand交谈
.turnin 11900 >>轮流读取仪表
.turnin 11911 >>转弯加速
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11900
.isQuestComplete 11911
step
>>与Berinand交谈
.turnin 11905 >>营业额推迟了不可避免的事情
.turnin 11911 >>转弯加速
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11905
.isQuestComplete 11911
step
>>与Berinand交谈
.turnin 11905 >>营业额推迟了不可避免的事情
.turnin 11910 >>交出古代的秘密
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11905
.isQuestComplete 11910
step
>>与Berinand交谈
.turnin 11900 >>轮流读取仪表
.turnin 11910 >>交出古代的秘密
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11900
.isQuestComplete 11910
step
>>与Berinand交谈
.turnin 11900 >>轮流读取仪表
.turnin 11905 >>营业额推迟了不可避免的事情
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11900
.isQuestComplete 11905
step
>>与Berinand交谈
.turnin 11900 >>轮流读取仪表
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11900
step
>>与Berinand交谈
.turnin 11905 >>营业额推迟了不可避免的事情
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11905
step
>>与Berinand交谈
.turnin 11910 >>交出古代的秘密
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11910
step
>>与Berinand交谈
.turnin 11911 >>转弯加速
.goto BoreanTundra,32.94,34.40
.isQuestComplete 11911
step
#requires Serrah7
step
#requires Raelorasz7
#completewith Dragonblight
#level 73
#label L73one
>>放弃所有与Coldarra/Nexus相关的任务
.abandon 11900 >> 放弃抄表
.abandon 11905 >> 放弃推迟不可避免的事情
.abandon 11910 >> 放弃古人的秘密
.abandon 11918 >> 放弃基本培训
.abandon 13095 >> 放弃他们没有羞耻感吗？
.abandon 11912 >> 放弃坚果换浆果
.abandon 11943 >> 放弃牢房
step
#completewith Dragonblight
#requires L73one
#level 73
>>放弃所有与Coldarra/Nexus相关的任务
.abandon 11911 >>放弃加速
.abandon 11936 >>放弃策划（Plan）
.abandon 11967 >>放弃召集红军
.abandon 11914 >>放弃保守秘密
.abandon 13095 >>放弃他们没有羞耻感吗？
.abandon 11951 >>放弃诱饵和开关
step
#label end
.goto BoreanTundra,33.13,34.45
.fly Amber Ledge >>飞到琥珀色壁架
.zoneskip Dragonblight
.zoneskip ZulDrak
.zoneskip The Storm Peaks
.zoneskip Dalaran
.zoneskip 159 
.zoneskip 157 
.zoneskip 132 
.zoneskip 154 
.zoneskip 138 
.xp <73,1
]])
RXPGuides.RegisterGuide([[
#version 5
#wotlk
#group 地下城 刷本 70-80
<< Horde
#name 75-77 古达克副本
#next 70-80 部落 地下城 刷本

step
.loop 50,ZulDrak,68.00,33.67,63.78,33.81,63.72,38.24,67.38,38.75,69.52,35.43,68.00,33.67
>>使用本指南时，每当您的锁定到期时，请切换回主地牢裂口指南
.xp 77 >> 在Zol'Maz碾碎暴徒，直到你的封锁期结束。尝试在每个分区的一个角上强制进行动态重生
]])
