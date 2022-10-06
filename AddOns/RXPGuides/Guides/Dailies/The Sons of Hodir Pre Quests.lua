RXPGuides.RegisterGuide([[
#version 1
#group +RestedXP诺森德每日任务
#subgroup 阵营每日任务
#wotlk
#name 霍迪尔之子开启每日任务

step
    +您已经完成了霍迪尔之子任务前链。请使用《霍迪尔之子每日任务路线指南》完成每日任务
	.isQuestTurnedIn 13047
step
	.goto TheStormPeaks,41.15,86.14
	>>飞到K3
    >>到客栈里面去。与格雷琴交谈
    .accept 12843 >>接受他们带走了我们的人！
step
    .goto TheStormPeaks,40.1,73.8,70,0
    .goto TheStormPeaks,40.3,69.8,70,0
    .goto TheStormPeaks,42.2,71.0,70,0
    .goto TheStormPeaks,41.6,73.7,60,0
    .goto TheStormPeaks,40.7,72.7
	>>飞到Sifreldar村
	>>为了冷铁钥匙杀死西弗莱达。使用该地区地精囚犯笼子上的钥匙
    .collect 40641,5,12843,1,-1
    .complete 12843,1 --Goblin Prisoner freed (5)
step
    .goto TheStormPeaks,41.15,86.14
	>>返回K3。在客栈内与格雷琴交谈
    .turnin 12843 >>他们带走了我们的人！
    .accept 12846 >>接受，不要留下地精
step
    .goto TheStormPeaks,42.1,69.5,60,0
    .goto TheStormPeaks,42.80,68.90
	>>进入Forlon Mine。与洛克丽拉交谈
    .turnin 12846 >>上车不要留下地精
    .accept 12841 >>接受Crone的讨价还价
step
    .goto TheStormPeaks,44.3,67.1,30,0
    .goto TheStormPeaks,44.1,70.2,30,0
    .goto TheStormPeaks,45.1,71.0
	>>杀死Forlon矿井内的监督人Syra。为了伊尔克文的符文而抢劫她
    .complete 12841,1 --Runes of the Yrkvinn (1)
	.unitscan Overseer Syra
step
    .goto TheStormPeaks,42.80,68.90
	>>返回洛克利拉
    .turnin 12841 >>提交Crone的交易
    .accept 12905 >>接受米尔德里德的残忍
step
    .goto TheStormPeaks,44.39,68.93
	>>上楼去。与米尔德里德交谈
    .turnin 12905 >>交出残忍的米尔德里德
    .accept 12906 >>接受纪律
step
    .goto TheStormPeaks,44.8,67.2,40,0
    .goto TheStormPeaks,44.6,70.6,40,0
    .goto TheStormPeaks,44.1,69.9,40,0
    .goto TheStormPeaks,44.8,71.3,40,0
    .goto TheStormPeaks,44.3,66.8,40,0
    .goto TheStormPeaks,43.0,68.0,40,0
    .goto TheStormPeaks,43.4,70.5
	.use 42837 >>用你袋子里的惩戒棒对付矿井里精疲力竭的维库尔
    .complete 12906,1 --Exhausted Vrykul Disciplined (6)
step
    .goto TheStormPeaks,44.39,68.93
	>>与米尔德里德交谈
    .turnin 12906 >>交班纪律
    .accept 12907 >>接受要制作的示例
step
    .goto TheStormPeaks,45.40,69.10
	>>在米尔德里德东边的山洞里杀死加哈尔
    .complete 12907,1 --Garhal (1)
step
    .goto TheStormPeaks,44.39,68.93
	>>与米尔德里德交谈
    .turnin 12907 >>交出要制作的示例
    .accept 12908 >>接受某个囚犯
step
    .goto TheStormPeaks,42.80,68.90
	>>与洛克丽拉交谈
    .turnin 12908 >>移交某个囚犯
    .accept 12921 >>接受风景的改变
step
    .goto TheStormPeaks,41.8,69.6,30,0
    .goto TheStormPeaks,47.47,69.09
	>>离开福隆矿。飞往Brunnhildar村
    .turnin 12921 >>换个场景
    .accept 12969 >>接受这是你的地精吗？
step
    .goto TheStormPeaks,48.25,69.77
	>>与Agnetta交谈。杀了她来解救Zeev
    .complete 12969,1 --Agnetta Tyrsdottar (1)
	.skipgossip
step
    .goto TheStormPeaks,47.47,69.09
	>>与洛克丽拉交谈
    .turnin 12969 >>上车是你的地精吗？
    .accept 12970 >>接受Hyldsmet
	>>与克罗地亚人洛克丽拉谈论她的求婚
    .complete 12970,1 --Listen to Lok'lira's proposal (1)
	.skipgossip 29975,1
    .turnin 12970 >>交给Hyldsmet
    .accept 12971 >>接受挑战
step
    .goto TheStormPeaks,50.5,68.1,30,0
    .goto TheStormPeaks,51.5,66.2
	>>与该地区的胜利挑战者对话，攻击他们。杀了他们
    .complete 12971,1 --Victorious Challenger (6)
	.skipgossip
step
    .goto TheStormPeaks,47.47,69.09
	>>与洛克丽拉交谈
    .turnin 12971 >>开始挑战所有挑战者
    .accept 12972 >>接受你需要一只熊
step
    .goto TheStormPeaks,53.14,65.72
	>>与Brijana交谈
    .turnin 12972 >>上车你需要一只熊
    .accept 12851 >>接受Bearly挂起
step
   	#completewith next
    .goto The Storm Peaks,53.12,65.61
	.vehicle >>冰方山就在布里亚纳旁边
step
    .goto TheStormPeaks,53.1,65.6,0
    .goto TheStormPeaks,57.4,63.0
	>>使用火焰箭(1)燃烧霜虫和霜巨人。不要使用速度爆发(2)，只专注于打击所有目标
    .complete 12851,1 --Frostworgs Burned (7)
    .complete 12851,2 --Frost Giants Burned (15)
step
    .goto TheStormPeaks,53.14,65.72
	>>使用“速度爆发”(2)更快地返回布里亚纳。和她谈谈
    .turnin 12851 >>打开Bearly Hanging
    .accept 12856 >>接受冷酷
step
    #completewith next
    .goto TheStormPeaks,63.20,62.88
	.vehicle >>飞往Dun Niffelem。登上一辆囚禁的原德雷克，他们被拴在邓尼弗莱姆外墙周围的大冰柱上
step
    .waypoint TheStormPeaks,53.1,65.7,0,niffelen,VEHICLE_PASSENGERS_CHANGED,VEHICLE_UPDATE
    .goto The Storm Peaks,66.75,60.63
	>>当你靠近一名冻结在冰块中的Brunnhildar囚犯时，使用你的德雷克的第一个技能。
    >>当你的神龙上有3名囚犯时，返回布伦希达尔。这样做3次
    .complete 12856,1 --Rescued Brunnhildar Prisoners (9)
    .complete 12856,2 --Freed Proto-Drakes (3)
step
    .goto TheStormPeaks,53.14,65.72
	>>与Brijana交谈
    .turnin 12856 >>转入冷心
    .accept 13063 >>接受视为有价值
step
    .goto TheStormPeaks,49.75,71.81
	>>返回Brunnhildar。与Astrid交谈
    .turnin 13063 >>提交被视为有价值的文件
    .accept 12900 >>接受制作线束
step
    .goto TheStormPeaks,48.3,74.7,70,0
    .goto TheStormPeaks,48.3,77.1,70,0
    .goto TheStormPeaks,44.8,74.1
	>>杀死冰岛人叶蒂斯。抢劫他们的藏身之处
    .complete 12900,1 --Icemane Yeti Hide (3)
step
    .goto TheStormPeaks,49.75,71.81
	>>与Astrid交谈
    .turnin 12900 >>轮流制作线束
    .accept 12983 >>接受她最后一个同类
    .accept 12989 >>接受滑溜的黑暗
step
    #completewith next
    .goto TheStormPeaks,55.8,63.9,30 >>进入冬眠洞穴
step
    .goto TheStormPeaks,54.8,60.4
	>>杀死山洞里的乔蒙加
 	>>不要把受伤的熊骑到山洞中央
    .complete 12989,1 --Ravenous Jormungar (8)
step
	#completewith next
    .goto TheStormPeaks,54.79,60.37
	.vehicle >>右击冰爪王母骑出冬眠洞穴
step
    .goto TheStormPeaks,49.82,71.12
	>>把熊骑回布伦希达尔。这需要1米8秒，因此您可以在此期间休息
    .complete 12983,1 --Icemaw Matriarch Rescued (1)
step
    .goto TheStormPeaks,49.75,71.81
	>>与Astrid交谈
    .turnin 12983 >>交出她最后一个同类
    .accept 12996 >>接受热身
    .turnin 12989 >>在滑溜的黑暗中转身
step
	#completewith next
    .goto TheStormPeaks,50.79,67.68
	.vehicle >>飞往基尔加拉克。使用包中的战熊母马缰绳来安装它。
	.use 42481
step
    .goto TheStormPeaks,50.79,67.68
	.use 42481 >>杀死Kirgaraak。使用重锤(1)造成伤害。使用粉碎(2)进入冲锋(3)造成额外伤害。
    .complete 12996,1 --Kirgaraak Defeated (1)
step
	.goto TheStormPeaks,49.75,71.81
	>>卸下熊。与Astrid交谈
    .turnin 12996 >>开始热身
    .accept 12997 >>接受入坑
step
	#completewith next
    .goto TheStormPeaks,49.24,68.46
	.vehicle >>飞到毒牙坑。使用包中的战熊母马缰绳来安装它。
	.use 42499
step
    .goto TheStormPeaks,49.24,68.46
	.use 42499 >>杀死坑里的战熊。使用重锤(1)造成伤害。使用粉碎(2)进入冲锋(3)造成额外伤害。
    .complete 12997,1 --Hyldsmeet Warbear (6)
step
    .goto TheStormPeaks,49.75,71.81
	>>卸下熊。与Astrid交谈
    .turnin 12997 >>转入深坑
    .accept 13061 >>接受为荣耀做准备
step
    .goto TheStormPeaks,47.47,69.09
	>>与洛克丽拉交谈
    .turnin 13061 >>上缴准备荣耀
    .accept 13062 >>接受洛克丽拉的告别礼物
step
    .goto TheStormPeaks,50.88,65.58
	>>与格雷塔交谈
    .turnin 13062 >>交上洛克丽拉的告别礼物
    .accept 12886 >>接受Drakkensryd
step
    .goto TheStormPeaks,35.4,57.8
	.use 41058 >>乘龙战机飞到风暴神殿(这需要1米10秒，所以你可以在此期间休息一下)。用你袋子里的海尔德尼尔鱼叉跳到有龙骑士的龙兽身上。杀了他们
    .complete 12886,1 --Hyldsmeet Drakerider Defeated (10)
step
    .goto TheStormPeaks,33.42,57.95
	>>在风暴神庙的柱子上使用柱饰上的海尔德尼尔鱼叉(较小的球体)跳到上面。
	>>与索里姆交谈
    .turnin 12886 >>交给Drakkensryd
    .accept 13064 >>接受兄弟竞争
	>>与索里姆交谈
    .complete 13064,1 --Thorim's History Heard (1)
	.skipgossip 29445,1
    .turnin 13064 >>同父异母
    .accept 12915 >>接受修补围栏
	.use 41058
step
	#completewith Giants
	#label Slag
    .goto TheStormPeaks,71.8,61.1,0
	>>杀死暴风铁巨人。抢劫他们的矿渣覆盖金属。开始任务
	.collect 41556,1,12922,1 --Slag Covered Metal (1)
    .accept 12922 >>接受精炼厂之火
step
	#completewith next
	#requires Slag
    .goto TheStormPeaks,70.7,56.7,70,0
    .goto TheStormPeaks,69.6,62.0,70,0
    .goto TheStormPeaks,76.8,62.9
	>>杀死所有你看到的血腥恶魔。掠夺他们的火花
    .complete 12922,1 --Furious Spark (10)
step
	#label Giants
    .goto TheStormPeaks,75.0,63.6,70,0
    .goto TheStormPeaks,71.8,61.1
	>>抢劫在弗罗斯菲尔德湖和福约恩斯铁砧发现的花岗岩巨砾(你一次只能携带一块)
	.use 41505 >>当你在Stormforged Iron Giants有一块巨石时，使用你袋子里的Thorim’s Charm of Earth来帮助杀死他们
	.collect 41506,1,12915,1,-1
    .complete 12915,2 --Stormforged Iron Giants (5)
step
    .goto TheStormPeaks,71.8,61.1
	>>杀死暴风铁巨人。抢劫他们的矿渣覆盖金属。开始任务
	.collect 41505,1,12922,1 --Slag Covered Metal (1)
    .accept 12922 >>接受精炼厂之火
step
    .goto TheStormPeaks,70.7,56.7,70,0
    .goto TheStormPeaks,69.6,62.0,70,0
    .goto TheStormPeaks,76.8,62.9
	>>杀死冒汗的叛徒。掠夺他们的火花
    .complete 12922,1 --Furious Spark (10)
step
	#completewith end
	#label FjornAnvil
    .goto TheStormPeaks,77.17,62.84
	>>单击Fjorn的铁砧
    .turnin 12922 >>交出精炼厂的火
    .accept 12956 >>接受希望的火花
step
    .goto TheStormPeaks,77.34,62.87
	>>抢劫在弗罗斯菲尔德湖和福约恩斯铁砧发现的花岗岩巨砾(你一次只能携带一块)
	.use 41505 >>当你在Fjorn有一块巨石时，用你袋子里的托里姆的地球魅力来帮助杀死他
    .complete 12915,1 --Fjorn (1)
step
	#label Thorim1
    .goto TheStormPeaks,33.4,57.9
	>>飞到托里姆
    .turnin 12915 >>上交修补围栏
    .turnin 12956 >>点燃希望之火
    .accept 12924 >>接受打造联盟
step
	.goto TheStormPeaks,65.45,60.16
	>>与约库姆国王交谈
    .accept 12966 >>接受你不能错过他
step
	.goto TheStormPeaks,75.37,63.57
	>>与Njormeld交谈
    .turnin 12966 >>你不能错过他
    .accept 12967 >>接受与元素的战斗
step
    #completewith next
    .goto TheStormPeaks,75.71,63.91
    .vehicle >>右击斯诺里骑上他：3
step
    .goto TheStormPeaks,77.2,62.7
	>>使用“收集雪”(1)从附近的雪堆中获取雪。使用“投掷雪球”(2)杀死冒泡的恶魔。
    .complete 12967,1 --Seething Revenants (10)
step
    .goto TheStormPeaks,75.37,63.57
	>>与Njormeld交谈
    .turnin 12967 >>投身对抗自然
    .complete 12924,1 --Fjorn's Anvil Brought to Dun Niffelem (1)
step << Human
	>>返回Dun Niffelem。与恩约梅尔德和铁砧交谈
    .turnin 12924 >>投身打造联盟
    .accept 13009 >>接受新的开始
    .accept 12985 >>接受锻造头部
    .goto TheStormPeaks,63.20,63.27
	.daily 12981 >>接受高温和低温
    .goto TheStormPeaks,63.13,62.94
	.isQuestAvailable 13047
step << !Human
	>>返回Dun Niffelem。与恩约梅尔德和铁砧交谈
    .turnin 12924 >>投身打造联盟
    .accept 13009 >>接受新的开始
    .goto TheStormPeaks,63.20,63.27
	.daily 12981 >>接受高温和低温
    .goto TheStormPeaks,63.13,62.94
	.isQuestAvailable 13047
step << Human
    .goto TheStormPeaks,65.45,60.16
	>>与约库姆国王交谈
    .accept 13011 >>接受Culling Jorcuttar
    .accept 12975 >>接受纪念
step << !Human
    .goto TheStormPeaks,65.45,60.16
	>>与约库姆国王交谈
    .accept 12975 >>接受纪念
step << Human
	#completewith HornF
	>>请注意该区域内的Everfrost Chips物体。如果你看到一个，把它抢走并开始任务
	.accept 13420 >>接受Everfrost
step << Human
    .goto TheStormPeaks,69.6,58.8,70,0
    .goto TheStormPeaks,70.3,62.2
	>>杀死脆性叛徒。掠夺他们以获取冰的精华
	.use 42424 >>在死铁巨人身上使用钻石尖劈。杀死繁殖的暴徒，然后掠夺他们的风暴眼
	.collect 42246,6 --Essence of Ice (6)
	.complete 12985,1 --Stormforged Eye (8)
	.isQuestAvailable 13047
step << !Human
    .goto TheStormPeaks,69.6,58.8,70,0
    .goto TheStormPeaks,70.3,62.2
	>>杀死脆性叛徒。掠夺他们以获取冰的精华
	.collect 42246,6 --Essence of Ice (6)
	.isOnQuest 12981
	.isQuestAvailable 13047
step
    .goto TheStormPeaks,73.5,62.9,70,0
    .goto TheStormPeaks,76.2,63.4
	.use 42246 >>使用弗约恩铁砧周围阴燃残渣旁边的冰块精华。抢劫冷冻铁屑
    .complete 12981,1 --Frozen Iron Scrap (6)
	.isQuestAvailable 13047
step
	#label HornF
    .goto TheStormPeaks,71.7,47.6
	>>抢劫该地区地面上的小扁石
    .complete 12975,1 --Horn Fragment (8)
step << Human
	>>返回Dun Niffelem。与考尔德、约库姆国王、恩约梅尔德、福约恩铁砧和霍迪尔之角交谈
	.turnin 13420 >>交给Everfrost
    .goto TheStormPeaks,67.11,60.97
    .turnin 12975 >>交回纪念
    .accept 12976 >>接受堕落者纪念碑
    .goto TheStormPeaks,65.45,60.16
    .turnin 12976 >>把纪念碑交给堕落者
    .turnin 12985 >>转动锻造头部
    .accept 12987 >>接受放置Hodir的头盔
    .goto TheStormPeaks,63.20,63.27
    .turnin 12981 >>转入冷热状态
    .goto TheStormPeaks,63.13,62.94
    .daily 12977 >>接受Hodir的呼叫
    .goto TheStormPeaks,64.17,65.01
	.isOnQuest 13420
	.isQuestAvailable 13047
step << Human
	>>返回Dun Niffelem。与约库姆国王、恩约梅尔德和福约恩铁砧交谈
    .turnin 12975 >>交回纪念
    .accept 12976 >>接受堕落者纪念碑
    .goto TheStormPeaks,65.45,60.16
    .turnin 12976 >>把纪念碑交给堕落者
    .turnin 12985 >>转动锻造头部
    .accept 12987 >>接受放置Hodir的头盔
    .goto TheStormPeaks,63.20,63.27
    .turnin 12981 >>转入冷热状态
    .goto TheStormPeaks,63.13,62.94
	.isQuestAvailable 13047
step << !Human
	>>返回Dun Niffelem。与约库姆国王、福约恩铁砧和恩约梅尔德交谈
    .turnin 12975 >>交回纪念
    .accept 12976 >>接受堕落者纪念碑
    .goto TheStormPeaks,65.45,60.16
    .turnin 12981 >>转入冷热状态
    .goto TheStormPeaks,63.13,62.94
    .turnin 12976 >>把纪念碑交给堕落者
    .accept 12985 >>接受锻造头部
    .goto TheStormPeaks,63.20,63.27
	.isQuestAvailable 13047
step << !Human
    .goto TheStormPeaks,69.6,58.8,70,0
    .goto TheStormPeaks,70.3,62.2
	.use 42424 >>在死铁巨人身上使用钻石尖劈。杀死繁殖的暴徒，然后掠夺他们的风暴眼
	.complete 12985,1 --Stormforged Eye (8)
step << !Human
	>>返回Dun Niffelem。与恩约梅尔德和霍迪尔之角交谈
    .turnin 12985 >>转动锻造头部
    .accept 12987 >>接受放置Hodir的头盔
    .goto TheStormPeaks,63.20,63.27
    .daily 12977 >>接受Hodir的呼叫
    .goto TheStormPeaks,64.17,65.01
	.isQuestAvailable 13047
step
    .goto TheStormPeaks,64.24,59.23
	.use 42442 >>飞到Dun Niffelem的闪闪发光的冰棍。坐在飞行坐骑上时，请使用包中的发音板
    .complete 12987,1 --Hodir's Helm Mounted (1)
step
    .goto TheStormPeaks,63.20,63.27
	>>与Njormeld交谈
    .turnin 12987 >>轮流放置Hodir头盔
step
    .goto TheStormPeaks,64.22,59.39
	>>与你刚刚安置的头盔交谈
    .daily 13006 >>接受粘性清洁
	.isQuestAvailable 13047
step << !Human
    .goto TheStormPeaks,65.45,60.16
	>>与约库姆国王交谈
    .accept 13011 >>接受Culling Jorcutta
step
	#completewith Jorcuttar
    .goto TheStormPeaks,54.4,63.2,0
	>>在冬眠洞穴杀死粘性油。掠夺他们的石油
    .complete 13006,1 --Viscous Oil (5)
	.isQuestAvailable 13047
step
    .goto TheStormPeaks,55.8,63.9,30,0
    .goto TheStormPeaks,54.7,60.6
	.use 42732 >>进入冬眠洞穴，拥抱它的右侧。在死亡的冰爪熊身上使用长霜剃须刀，直到你得到冰爪熊侧翼
	.collect 42733,1 --Icemaw Bear Flank (1)
	.isQuestAvailable 13047
step
	#label Jorcuttar
    .goto TheStormPeaks,54.8,60.8
	.use 42733 >>继续拥抱洞穴的右侧，直到你到达主房间。在结冰的棘状湖中使用冰壶熊的侧翼-杀死乔卡塔
    .complete 13011,1 --Jorcuttar (1)
step
    .goto TheStormPeaks,54.4,63.2
	>>在冬眠洞穴杀死粘性油。掠夺他们的石油
    .complete 13006,1 --Viscous Oil (5)
	.isQuestAvailable 13047
step
    .goto TheStormPeaks,33.42,57.95
	>>飞到风暴神庙顶上的索里姆。跟他谈谈
    .turnin 13009 >>开创新的开端
    .accept 13050 >>接受Veranus
step
    .goto TheStormPeaks,45.4,66.9,40,0
    .goto TheStormPeaks,43.7,67.5
	>>抢劫山顶巢穴中的鸡蛋
    .complete 13050,1 --Small Proto-Drake Egg (5)
step
    .goto TheStormPeaks,33.42,57.95
	>>飞到风暴神庙顶上的索里姆。跟他谈谈
    .turnin 13050 >>交Veranus
    .accept 13051 >>接受区域侵入
step
    .goto TheStormPeaks,38.73,65.54
	.cast 56788 >>在Broodmother的巢穴上用你袋子里被偷的原始龙蛋引诱Veranus
	.timer 42,Veranus RP (CONTINUE QUESTING)
	.use 42797
	.isQuestAvailable 13047
step
    .goto TheStormPeaks,33.42,57.95
	>>飞到风暴神庙顶上的索里姆。和他谈谈。在索里姆等待前一个任务的RP完成。大约需要1分钟
    .turnin 13051 >>移交领土侵入
    .accept 13010 >>接受风暴之锤克罗米尔
step
	#completewith DunNif2
    .goto TheStormPeaks,29.5,74.3
	>>飞往Dun Niffelem
	.isQuestAvailable 13047
step
	>>与霍迪尔之角交谈
    .daily 12977 >>接受Hodir的呼叫
    .goto TheStormPeaks,64.17,65.01
	.isQuestAvailable 13047
step
	#label DunNif2
	>>在Dun Niffelem与Hodir’s Helmet和King Jokkum交谈
    .turnin 13006 >>交粘性清洁剂
    .goto TheStormPeaks,64.22,59.39
    .turnin 13011 >>卡林·约卡特尔上任
	.vehicle >>与约库姆国王交谈。带他去雷霆城
	.timer 118,Krolmir, Hammer of Storms RP
	.skipgossip
	.isQuestAvailable 13047
step
	#completewith TerraceM
	>>请注意该区域内的Everfrost Chips物体。如果你看到一个，把它抢走并开始任务
	.accept 13420 >>接受Everfrost
	.isQuestAvailable 13047
step
	#completewith ThorimRP
    .goto TheStormPeaks,70.7,47.3,0
    .goto TheStormPeaks,70.1,52.5,0
    .goto TheStormPeaks,72.7,52.1,0
    .goto TheStormPeaks,74.7,48.3,0
	.use 42164 >>杀死该地区的尼弗莱姆祖先和不安的弗罗斯特伯恩。用你袋子里的霍迪尔号角放在他们的尸体上解救他们
	>>您可以在RP事件发生时执行此操作
    .complete 12977,1 --Niffelem Forefather freed (5)
    .complete 12977,2 --Restless Frostborn freed (5)
	.isQuestAvailable 13047
step
    .goto TheStormPeaks,71.37,48.78
	>>等待RP完成
    .complete 13010,1 --Krolmir's Fate Discovered (1)
	.isQuestAvailable 13047
step
	#label ThorimRP
    .goto TheStormPeaks,71.37,48.78
	>>在索里姆消失之前和他谈谈
    .turnin 13010 >>交给克洛米尔，风暴之锤
    .accept 13057 >>接受创客平台
	.isQuestAvailable 13047
step
    .goto TheStormPeaks,70.7,47.3,60,0
    .goto TheStormPeaks,70.1,52.5,60,0
    .goto TheStormPeaks,72.7,52.1,60,0
    .goto TheStormPeaks,74.7,48.3
	.use 42164 >>杀死该地区的尼弗莱姆祖先和不安的弗罗斯特伯恩。用你袋子里的霍迪尔号角放在他们的尸体上解救他们
    .complete 12977,1 --Niffelem Forefather freed (5)
    .complete 12977,2 --Restless Frostborn freed (5)
	.isQuestAvailable 13047
step
	#label TerraceM
    .goto TheStormPeaks,56.26,51.36
	>>在创客平台与索里姆交谈
    .turnin 13057 >>在庄家的露台上转弯
    .accept 13005 >>接受地球誓言
    .accept 13035 >>接受洛肯的走狗
	.isQuestAvailable 13047
step
	#completewith Duronn
    .goto TheStormPeaks,52.0,50.4,0
	.use 42840 >>使用背包中的尖峰之角，帮助你在前往指定暴徒的途中杀死铁矮人和铁哨兵
    .complete 13005,1 --Iron Sentinel (7)
    .complete 13005,2 --Iron Dwarf Assailant (20)
	.isQuestAvailable 13047
step
    .goto TheStormPeaks,48.72,45.65
	.use 42840 >>用你袋子里的尖峰之角召唤一支小部队。用它杀死Halefnir
    .complete 13035,2 --Halefnir the Windborn (1)
step
	#label Duronn
    .goto TheStormPeaks,44.94,38.03
	.use 42840 >>用你袋子里的尖峰之角召唤一支小部队。用它来杀Duronn
    .complete 13035,3 --Duronn the Runewrought (1)
step
	#completewith next
    .goto TheStormPeaks,57.7,44.5,50,0
    .goto TheStormPeaks,57.7,44.5,0
	.use 42840 >>使用尖峰之角帮助你杀死艾森福斯特洞穴外的铁哨兵
    .complete 13005,1 --Iron Sentinel (7)
step
    .goto TheStormPeaks,56.9,44.1,30,0
    .goto TheStormPeaks,55.30,43.32
	>>进入东侧山脚的塑造者大厅
	.use 42840 >>使用尖峰之角召唤一支小型军队。用它杀死艾森福斯特
    .complete 13035,1 --Eisenfaust (1)
step
    .goto TheStormPeaks,58.48,45.21
	.use 42840 >>用你袋子里的尖峰之角来帮助你杀死该地区的铁矮人和铁哨兵
    .complete 13005,1 --Iron Sentinel (7)
    .complete 13005,2 --Iron Dwarf Assailant (20)
step
    .goto TheStormPeaks,56.26,51.36
	>>在创客平台与索里姆交谈
    .turnin 13005 >>宣誓入狱
    .turnin 13035 >>交出洛肯的走狗
    .accept 13047 >>接受清算
step
    #completewith next
	.goto TheStormPeaks,44.49,28.19
	>>飞到乌尔杜尔城外
    .fp Ulduar >>获取Ulduar飞行路线
    .skill riding,<300,1
step
    .goto TheStormPeaks,35.93,31.52
	>>飞往乌尔杜尔郊外的索里姆。与他交谈，等待RP活动结束
    .complete 13047,1 --Witness the Reckoning (1)
	.skipgossip
	.timer 91,The Reckoning RP
step
	#completewith end
    .goto TheStormPeaks,44.49,28.19
	>>飞到乌尔杜尔城外
    .fp Ulduar >>获取Ulduar飞行路线
	.fly Dun Niffelem >>飞往Dun Niffelem。这需要1米44秒，所以你可以在此期间休息一下
    .skill riding,300,1
step
	#completewith next
    .goto TheStormPeaks,36.2,49.3,200 >>乘坐飞行坐骑飞往Dun Niffelem
    .skill riding,<300,1
step
	>>返回Dun Niffelem。与Jokkum、Calder和Hodir’s Horn交谈
    .turnin 13047 >>提交清算
--  .accept 13108 >>接受一切！
    .goto TheStormPeaks,65.45,60.16
	.turnin 13420 >>交给Everfrost
    .goto TheStormPeaks,67.11,60.97
    .turnin 12977 >>交给霍迪尔的电话
    .goto TheStormPeaks,64.17,65.01
	.isOnQuest 13420
step
	#label end
	>>返回Dun Niffelem。与乔库姆和霍迪尔之角交谈
    .turnin 13047 >>提交清算
--  .accept 13108 >>接受一切！
    .goto TheStormPeaks,65.45,60.16
    .turnin 12977 >>交给霍迪尔的电话
    .goto TheStormPeaks,64.17,65.01
	.isOnQuest 12977
step -- checking that player has honored with hodir to get this quest. will only be humans and any other that turned in rep items
	>>在Dun Niffelem与学究Randvir交谈
	.goto TheStormPeaks,64.84,59.05
	.accept 13001 >>接受锻造霍迪尔长矛
	.reputation 1119,honored,<0,1
step
	>>杀死斯多葛猛犸。抢劫他们的藏身之处
	.goto TheStormPeaks,58.68,60.94,60,0
	>>在冬眠洞穴中掠夺长霜碎片
	.complete 13001,2 --Stoic Mammoth Hide (3)
	.complete 13001,1 --Everfrost Shard (3)
	.goto TheStormPeaks,55.84,63.94,50,0
   	.goto TheStormPeaks,54.72,60.82
	.isOnQuest 13001
step
	>>在Dun Niffelem与学究Randvir交谈
	.goto TheStormPeaks,64.84,59.05
	.turnin 13001 >>交出锻造霍迪尔长矛
	.isQuestComplete 13001
step
    +您已经完成了霍迪尔之子任务前链。请使用Hodir之子每日任务路线指南完成每日任务。请注意，由于已提前完成，有些可能今天无法提供
	.isQuestTurnedIn 13047
]])
