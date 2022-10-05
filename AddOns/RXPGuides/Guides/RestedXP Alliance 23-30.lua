RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Alliance
#name 23-24 湿地
#version 1
#group RestedXP 联盟 20-32
#next 24-27 赤脊山/暮色森林
#xprate <1.5

step << Warrior wotlk
    #sticky
    #completewith exit1
    .goto StormwindClassic,64.1,61.2,0
    .goto StormwindClassic,46.7,79.0,0
    >>检查AH、贸易区的花店和法师区的炼金术店，并购买一些生命根，稍后你需要8个才能完成任务，如果你已经拥有了，跳过这一步
    .collect 3357,8 --Collect Liferoot (x8)
    #xprate <1.5
step << Human !Warlock !Paladin wotlk
	.goto Elwynn Forest,84.3,64.9
	.train 33388 >> 前往埃尔文森林的伊斯特维尔，训练/购买您的坐骑
	.money <5.0
    .skill riding,1,1
step << Paladin wotlk
	.goto StormwindClassic,38.6,32.8
	.trainer >> 训练你的职业咒语
step << Priest wotlk
	.goto StormwindClassic,38.5,26.8
	.trainer >> 训练你的职业咒语
step << Paladin wotlk
    .goto StormwindClassic,40.1,30.0
    >>与Duthorian Rall对话，右键单击提供的Tome of Valor
    .accept 1649 >>接受勇士之父
    .turnin 1649 >>交给勇敢的人
    .accept 1650 >>接受勇士之父
step << Warlock wotlk
    .goto StormwindClassic,25.3,78.7
    .trainer >> 训练你的职业咒语
step << Warlock wotlk 
    .isOnQuest 1738
    .goto StormwindClassic,25.3,78.7
    .turnin 1738 >>交给Heartswood
    .accept 1739 >>接受绑定
step << Warlock wotlk
    .isOnQuest 1739
    .goto StormwindClassic,25.2,77.5
    >>进入地下室，使用召唤圈提供的任务物品
    .complete 1739,1 --Summoned Succubus (1)
step << Warlock wotlk
    .isQuestComplete 1739
    .goto StormwindClassic,25.4,78.7
    .turnin 1739 >>交回装订本
step << Mage wotlk
    .goto StormwindClassic,39.6,79.6
    .train 3561>>火车传送：暴风
    .trainer >> 训练你的职业咒语
step << wotlk
    .goto StormwindClassic,52.61,65.71
    .home >> 将您的炉石设置为暴风城
step << Rogue wotlk
	.goto StormwindClassic,74.6,52.8
	.trainer >> 训练你的职业咒语
step << Warrior wotlk
	.goto StormwindClassic,78.6,45.8
	.trainer >> 上楼去。训练你的职业咒语
step << Rogue tbc
    #sticky
    .goto StormwindClassic,75.8,60.1
    >> 确保训练开锁和拾取口袋
    .accept 2281 >> 接受Redridge集合
    .accept 2360 >> 接受Mathias和Defias
step << Rogue
	.goto StormwindClassic,78.3,57.0
    .train 1804>>确保列车开锁
step << Rogue tbc
    .goto StormwindClassic,52.6,65.6
    .home >> 将您的炉石设置为暴风城
step << Draenei wotlk
    .goto StormwindClassic,78.4,18.3
    .accept 9429 >> 接受前往Darkhire的旅行
step << Hunter wotlk
	.goto StormwindClassic,61.7,15.4
	.trainer >> 训练你的职业咒语
step << wotlk
    .goto StormwindClassic,53.62,59.76,30,0
    .goto StormwindClassic,55.25,7.08
    .vendor 5519>> 查看矮人区的Billibub是否有铜管。如果有，就买一个
    .collect 4371,1,175,1,1
    .bronzetube
step << wotlk
    #label exit1
    .goto StormwindClassic,63.9,8.3
    .link https://www.youtube.com/watch?v=M_tXROi9nMQ >> 点击此处在电车内注销跳过
    .zone Ironforge >>进入Deeprun电车，穿过电车进入铁炉堡
    .zoneskip Dun Morogh
step << wotlk
    #sticky
    #completewith exit2
    .vendor 5175>>从齿轮切割器Cogspinner（限量供应）处购买青铜管，如果他没有或你已经有了，请跳过此步骤
    .goto Ironforge,67.86,42.87
    .collect 4371,1,175,1,1
	.bronzetube
step << !Dwarf wotlk !Gnome wotlk--Not needed, including just in case someone forgets to set HS to SW
    .goto Ironforge,55.5,47.7
    .fp Ironforge>> 获得铁炉堡飞行路线
step << Mage wotlk
    .goto Ironforge,25.5,7.1
    .train 3562>>火车传送：铁炉堡
step << wotlk !Dwarf !Gnome
    #sticky
    .goto Dun Morogh,53.2,35.3
    .zone Dun Morogh >> 前往Dun Morogh
    .zoneskip Ironforge,1
step << wotlk !Dwarf !Gnome
    #completewith next
    .goto Dun Morogh,59.5,42.8,40,0
    .goto Dun Morogh,60.4,44.1,40,0
    .goto Dun Morogh,61.1,44.1,40,0
    .goto Dun Morogh,61.2,42.3,40,0
    .goto Dun Morogh,60.8,40.9,40,0
    .goto Dun Morogh,59.0,39.5,40,0
    .goto Dun Morogh,60.3,38.6,40,0
    .goto Dun Morogh,61.7,38.7,40,0
    .goto Dun Morogh,65.7,21.6,40,0
    .goto Dun Morogh,65.8,12.5,40,0
    .goto Dun Morogh,65.6,10.8,40,0
    .goto Dun Morogh,66.5,10.0,40,0
    .goto Dun Morogh,66.9,8.5,40,0
    .goto Wetlands,20.6,67.2,50,0
    .goto Wetlands,17.7,67.7,40,0
    .goto Wetlands,16.8,65.3,40,0
    .goto Wetlands,15.1,64.0,40,0
    .goto Wetlands,12.1,60.3,40,0
    >>邓莫罗不死->湿地跳过
    .link https://www.youtube.com/watch?v=9afQTimaiZQ >> 点击此处查看视频参考
    .goto Wetlands,12.1,60.3,80 >> 前往米奈希尔港
step << wotlk !Dwarf !Gnome
    .goto Wetlands,9.5,59.7
    .fp Menethil >> 获取Menethil Harbor航线
step << Dwarf !Paladin wotlk
	#sticky
	#completewith next
	.goto Dun Morogh,63.5,50.6
	.money <5.00
	.skill riding,75 >> 前往Dun Morogh，乘坐火车并购买您的坐骑。
step << Gnome !Warlock wotlk
	#sticky
	#completewith next
	.goto Dun Morogh,49.2,48.1
	.money <5.00
	.skill riding,75 >> 前往Dun Morogh，乘坐火车并购买您的坐骑。
step << Gnome wotlk/Dwarf wotlk
    #completewith next
    .goto Ironforge,55.5,47.7
    .fly Wetlands >> 飞到湿地
step << Mage wotlk
    .goto Wetlands,10.7,60.9
    .home >> 把你的炉石放在深水酒馆
step
    .goto Wetlands,8.3,58.5
    .accept 279 >> 接受来自深处的爪子
step
    .goto Wetlands,8.6,55.8
    .accept 484 >> 接受年轻鳄鱼皮
step
    .goto Wetlands,10.8,59.6
    .accept 288 >> 接受第三舰队
    .accept 463 >> 接受绿色守卫
step
    .goto Wetlands,10.7,60.9
	>> 从店主那里买一瓶美赞臣酒
    .complete 288,1 --Collect Flagon of Mead (x1)
step
    .goto Wetlands,10.84,60.43
	>>上楼去和考古学家Flagongut谈谈
	.turnin 942 >>交回心不在焉的探矿者
	.accept 943 >>接受心不在焉的探矿者
    .isQuestTurnedIn 741
step
    .goto Wetlands,10.8,59.7
    .turnin 288 >> 交出第三舰队
step << Hunter
    .goto Wetlands,11.1,58.3
    .vendor >> 修理并重新存放箭头
step
    .goto Wetlands,11.7,58.0
    .accept 470 >> 接受在淤泥中挖掘
step
    #sticky
    #completewith exit1
    .vendor 1448>>前往仓库，从Neal Allen那里买一个铜管（限量供应），如果他没有或者你已经有了，跳过这一步
    .goto Wetlands,10.6,56.8
    .collect 4371,1,175,1,1
    .bronzetube
step
    .goto Wetlands,9.9,57.4
	>>上楼到马厩里去
    .accept 464 >> 接受战争旗帜
step
    .goto Wetlands,11.5,52.1
    .accept 305 >> 接受挖掘团队的搜索
step
	#sticky
	#label crocs
	>> 在任务之间杀死幼湿地鳄鱼。掠夺他们的皮肤
    .complete 484,1 --Collect Young Crocolisk Skin (x4)

step
    #label exit1
    .goto Wetlands,14.1,41.5,70,0
    .goto Wetlands,16.7,39.7,70,0
    .goto Wetlands,18.8,40.0
    >>杀死Gobbler，他在南部的murloc营地巡逻
    .complete 279,2 --Collect Gobbler's Head (x1)
    .complete 279,1 --Kill Bluegill Murloc (x12)
	.unitscan Gobbler
step
    #sticky
    #completewith next
    .vendor 2682>>从Fradd Swiftgear（限量供应）处购买青铜管，如果他没有或你已经有了，请跳过此步骤
    .goto Wetlands,26.4,25.8
    .collect 4371,1,175,1,1
	.bronzetube
step
    #xprate >1.5
	.goto Wetlands,34.3,41.2,60,0
    .goto Wetlands,38.2,50.9
    .accept 294 >> 接受奥默的复仇
step
    .goto Wetlands,38.8,52.3
    .turnin 305 >> 移交以搜索挖掘队
    .accept 306 >> 接受挖掘团队的搜索
step << Hunter/Warlock
    .goto Wetlands,24.7,48.6
	>> 杀死该地区的猛禽
    .complete 294,1 --Kill Mottled Raptor (x10)
    .complete 294,2 --Kill Mottled Screecher (x10)
step << Hunter/Warlock
	.goto Wetlands,34.3,41.4,80,0
    .goto Wetlands,38.2,50.9
    .turnin 294 >> 交出奥默的复仇
    .accept 295 >> 接受奥默的复仇
step << Hunter/Warlock
	.goto Wetlands,34.3,41.4,80,0
    .goto Wetlands,34.6,48.0
	>> 杀死该地区的猛禽
    .complete 295,1 --Kill Mottled Scytheclaw (x10)
    .complete 295,2 --Kill Mottled Razormaw (x10)
step << Hunter/Warlock
    .goto Wetlands,38.2,50.9
    .turnin 295 >> 交出奥默的复仇
    .accept 296 >> 接受奥默的复仇
step << Hunter/Warlock
    .goto Wetlands,31.5,48.9,50,0
    .goto Wetlands,33.3,51.5
	>>在山顶杀死萨尔托特。为他的魔爪抢劫他。小心，因为他会流鼻涕，并有6分钟的重生
    .complete 296,1 --Collect Sarltooth's Talon (x1)
step << Hunter/Warlock
    .goto Wetlands,38.2,50.9
    .turnin 296 >> 交出奥默的复仇
step
	.goto Wetlands,34.3,41.2,60,0
    .goto Wetlands,44.8,43.9
	>>杀死龙嘴兽
    .complete 464,1 --Collect Dragonmaw War Banner (x8)
step
    .goto Wetlands,49.9,39.4
    .accept 469 >> 接受每日交付
step << Warrior
    #sticky
    #completewith next
    .goto Wetlands,50.2,37.8
    .vendor 8305>>检查药草供应商并购买一些Liferoot，稍后你需要8个才能完成任务，如果你已经有了，跳过这一步
    .collect 3357,8,0,1,1 --Collect Liferoot (x8)
    #xprate <1.5
step
    .goto Wetlands,56.4,40.4
    .turnin 463 >> 交给绿衣卫
step
    .goto Wetlands,56.4,40.4
    .accept 276 >> 接受徒步舞爪
    .maxlevel 23
step
    .goto Wetlands,63.9,62.7,70,0
    .goto Wetlands,62.4,69.5,70,0
    .goto Wetlands,61.5,72.2,70,0
    .goto Wetlands,55.7,75.1
	>>杀死该地区的Mosshide Gnolls和Mongrels。侏儒更常见于营地外
    .complete 276,1 --Kill Mosshide Gnoll (x15)
    .complete 276,2 --Kill Mosshide Mongrel (x10)
    .isOnQuest 276
step
    #requires crocs
    .goto Wetlands,56.4,40.3
    .turnin 276 >> 收起徒步舞爪
    .isQuestComplete 276
step
    .isOnQuest 276
    #completewith wettylandy
    .abandon 276 >> 放弃徒步舞爪
step
    .goto Wetlands,56.4,40.3
    .accept 277 >> 接受火灾禁忌
    .isQuestTurnedIn 276
step << NightElf/Draenei/Human wotlk
    #completewith next
    .goto Wetlands,53.7,72.3,75 >> 通往莫丹湖的路从这里开始
step << NightElf/Draenei/Human wotlk
    .goto Loch Modan,25.4,10.6
    .zone Loch Modan >> 穿过隧道进入莫丹湖
step << NightElf/Draenei/Human wotlk
    .goto Loch Modan,46.0,13.3
    .accept 250 >> 接受黑暗威胁织机
    .maxlevel 23
step << NightElf/Draenei/Human wotlk
    .goto Loch Modan,56.1,13.3
    >>点击小炸药桶
    .turnin 250 >> 交出一个黑暗的威胁织机
    .accept 199 >> 接受黑暗威胁织机
    .maxlevel 23
step << NightElf/Draenei/Human wotlk
    .goto Loch Modan,46.0,13.3
    .turnin 199 >> 交出一个黑暗的威胁织机
    .isOnQuest 199
step << NightElf/Draenei/Human wotlk
    .goto Loch Modan,33.9,50.9
    .fp Thelsamar >> 获取Thelsamar飞行路线
step << Draenei tbc/NightElf tbc
    .zone Stormwind City >> 使用网站解锁功能传送到暴风城。此功能具有8小时冷却时间。如果无法正常工作，请跳过此步骤
    .link https://us.battle.net/support/en/help/product/wow/197/834/solution >> 单击此处并将链接复制粘贴到浏览器中以获取更多信息
    .zoneskip Elwynn Forest
step << wotlk
    #label wettylandy
    #completewith next
    .goto Wetlands,9.5,59.7
    .hs >> 从火炉到暴风 << !Mage
    .hs >> 赫斯对米奈希尔 << Mage
step
    .zoneskip Wetlands,1
    .goto Wetlands,8.4,58.5
    .turnin 279 >> 从深处把爪子转过来
    .accept 281 >> 接受回收货物
step
    .zoneskip Wetlands,1
    .goto Wetlands,8.6,55.8
    .turnin 469 >> 每日交付交付
    .isOnQuest 469
step
    .goto Wetlands,8.6,55.8
    .turnin 484 >> 交出小鳄鱼皮
    .isOnQuest 484
    .zoneskip Wetlands,1
step
    .goto Wetlands,8.6,55.8
    .accept 471 >> 接受学徒的职责
    .isQuestTurnedIn 484
    .zoneskip Wetlands,1
step << Mage wotlk
    .zone Stormwind City >> 传送到暴风城
step
    .zoneskip Wetlands,1
    .goto Wetlands,9.5,59.7
    >> 如果您的壁炉石设置为暴风，请加热
    .fly Stormwind City >> 飞往暴风城
]])

RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Alliance
#name 24-27 赤脊山/暮色森林
#version 1
#group RestedXP 联盟 20-32
#next 27-30 湿地/希尔斯布莱德丘陵;28-30 暮色森林
step << Warrior
    #sticky
    #completewith exit
    .goto StormwindClassic,64.1,61.2,0
    .goto StormwindClassic,46.7,79.0,0
    >>检查AH、贸易区的花店和法师区的炼金术店，并购买一些生命根，稍后你需要8个才能完成任务，如果你已经拥有了，跳过这一步
    .collect 3357,8 --Collect Liferoot (x8)
    #xprate <1.5
step << Paladin
	.goto StormwindClassic,38.6,32.8
	.trainer >> 训练你的职业咒语
step << Priest
	.goto StormwindClassic,38.5,26.8
	.trainer >> 训练你的职业咒语
step << Paladin
    .goto StormwindClassic,40.1,30.0
    >>与Duthorian Rall对话，右键单击提供的Tome of Valor
    .accept 1649 >>接受勇士之父
    .turnin 1649 >>交给勇敢的人
    .accept 1650 >>接受勇士之父
step << Warlock
    .goto StormwindClassic,25.3,78.7
    .trainer >> 训练你的职业咒语
step << Warlock
    .isOnQuest 1738
    .goto StormwindClassic,25.3,78.7
    .turnin 1738 >>交给Heartswood
    .accept 1739 >>接受绑定
step << Warlock
    .isOnQuest 1739
    .goto StormwindClassic,25.2,77.5
    >>进入地下室，使用召唤圈提供的任务物品
    .complete 1739,1 --Summoned Succubus (1)
step << Warlock
    .isQuestComplete 1739
    .goto StormwindClassic,25.4,78.7
    .turnin 1739 >>交回装订本
step << Mage
    .goto StormwindClassic,39.6,79.6
    .train 3561>>火车传送：暴风
    .trainer >> 训练你的职业咒语
step << Rogue
    >> 确保你训练了开锁和扒窃
	.goto StormwindClassic,74.6,52.8
	.trainer >> 训练你的职业咒语
step << Warrior
	.goto StormwindClassic,78.6,45.8
	.trainer >> 上楼去。训练你的职业咒语
step << Rogue tbc
    #sticky
    .goto StormwindClassic,75.8,60.1
    .accept 2281 >> 接受Redridge集合
    .accept 2360 >> 接受Mathias和Defias
step << Rogue tbc
	.goto StormwindClassic,78.3,57.0
    .train 1804>>确保列车开锁
step << Rogue tbc
    .goto StormwindClassic,52.6,65.6
    .home >> 将您的炉石设置为暴风城
step << Draenei
    .goto StormwindClassic,78.4,18.3
    .accept 9429 >> 接受前往Darkhire的旅行
step << Hunter
	.goto StormwindClassic,61.7,15.4
	.train 14323 >> 训练你的职业咒语
step
    .goto StormwindClassic,53.62,59.76,30,0
    .goto StormwindClassic,55.25,7.08
    .vendor 5519>> 查看矮人区的Billibub是否有铜管。如果有，就买一个
    .collect 4371,1,175,1,1
    .bronzetube
step << skip --Not needed, going from SW -> Duskwood later in the guide after doing the Goldshire inn quest
	.goto StormwindClassic,62.5,62.3,30,0
	.goto StormwindClassic,66.3,62.1
    .fp Stormwind >> 获取暴风城飞行路线
step << Shaman
	.goto StormwindClassic,61.9,84.0
	.trainer >> 训练你的职业咒语
step << Human !Warlock wotlk !Paladin wotlk
    .goto Elwynn Forest,65.2,69.8
	>>前往艾尔文森林的阿佐拉塔顶部
    .accept 94 >> 接受警惕的目光
step << Human !Warlock wotlk/Human !Paladin wotlk
	.goto Elwynn Forest,84.3,64.9
	.train 33388 >> 前往埃尔文森林的伊斯特维尔伐木营，训练/购买您的坐骑
	.money <5.0
    .skill riding,1,1
step << Human Paladin/Human Warlock
	.goto StormwindClassic,62.5,62.3,30,0
	.goto StormwindClassic,66.3,62.1
    .fly Redridge >> 飞到雷德里奇山脉
    .zoneskip Elwynn Forest
step << !Human
    .goto Elwynn Forest,65.2,69.8
	>>前往阿佐拉塔的顶部。您不需要获得暴风飞行路径。我们稍后会收到。 
    .accept 94 >> 接受警惕的目光
step
    #label exit
    .goto Redridge Mountains,17.4,69.6
	>>与雷德里奇山脉的守卫帕克交谈
    .accept 244 >> 接受侵扰侏儒
step
	#sticky
	#label LakeshireFP
	.goto Redridge Mountains,30.5,59.4,-1
    .fp Redridge >> 获得Redridge Mountains飞行路线
step
    .goto Redridge Mountains,30.8,60.1,-1
    .turnin 244 >> 交出侵扰侏儒
step
	#requires LakeshireFP
    .goto Redridge Mountains,33.4,49.1
    .accept 20 >> 接受黑石威胁
step << !Warlock
    >> 前往市政厅
    .goto Redridge Mountains,29.6,44.3
    .accept 91 >> 接受所罗门定律
step << Hunter
	.goto Redridge Mountains,28.8,47.3
	.vendor >> 重新放置箭头，注意你很快就会得到25级箭头。
step
    .goto Redridge Mountains,27.7,47.3
    .accept 127 >> 接受卖鱼
    .accept 150 >> 接受Murloc偷猎者
step << Rogue tbc
    .goto Redridge Mountains,28.1,52.1
    .turnin 2281 >> 在Redridge Condezvous上交
    .accept 2282 >> 接受Alther's Mill
step
    #sticky
    #label orcs1
    .goto Redridge Mountains,61.0,43.1
    >>杀死黑石兽人
    .complete 20,1 --Collect Battleworn Axe (x10)
step
    .goto Redridge Mountains,57.3,52.4
	>> 杀死murlocs。抢走他们的太阳鱼和鱼翅
    .complete 127,1 --Collect Spotted Sunfish (x10)
    .complete 150,1 --Collect Murloc Fin (x8)
step << Rogue tbc
	#completewith next
    +打开箱子训练开锁，你需要75点技能才能完成任务。在你这样做之前，不要打开棕色的箱子
step << Rogue tbc
    .goto Redridge Mountains,52.0,44.8
    .complete 2282,1 --Collect Token of Thievery (x1)
step
    #requires orcs1
    .goto Redridge Mountains,33.6,48.7
    .turnin 20 >> 提交Blackrock威胁
step
    .goto Redridge Mountains,27.8,47.4
    .turnin 127 >> 卖鱼上缴
    .turnin 150 >> 交出Murloc偷猎者
step << Rogue tbc
    .goto Redridge Mountains,28.1,52.1
    .turnin 2282 >> 转入Alther’s Mill
step << Rogue tbc
    #completewith next
    .destroy 7907 >> 删除Thievery证书
step
    .goto Redridge Mountains,26.7,46.5
	>>点击酒店外的通缉海报
    .accept 180 >> 接受通缉：Fangore中尉
step
    .goto Redridge Mountains,21.9,46.4
    .accept 34 >> 接受不受欢迎的客人
step
    .goto Redridge Mountains,15.7,49.4
	>> 杀死Bellygrub并抢走她的象牙
    .complete 34,1 --Collect Bellygrub's Tusk (x1)
step
    .goto Redridge Mountains,21.8,46.4
    .turnin 34 >> 交出不受欢迎的客人
step
    >>跑向黄昏
	.goto Duskwood,75.7,45.3
    .accept 66 >> 接受Stalvan的传说
    .accept 101 >> 接受创伤图腾
step << Rogue wotlk/!Rogue
    .goto Duskwood,73.9,44.5
    .home >> 将您的炉石设置为Darkshire
step
    .goto Duskwood,73.6,46.8
    .accept 56 >> 接受夜间监视
step
    .goto Duskwood,72.6,46.9
    .turnin 66 >> 交出《种马传奇》
    .accept 67 >> 接受Stalvan的传说
step << Draenei
    .goto Duskwood,71.8,46.4
    .turnin 9429 >> 将Travel交给Darkhire
step
    .goto Duskwood,75.3,48.6
    .accept 163 >> 接受Raven Hill
    .accept 164 >> 接受交付给Sven的货物
    .accept 165 >> 接受隐士
step
    .goto Duskwood,75.4,48.0
    .accept 173 >> 接受森林里的狼人
step
    .goto Duskwood,77.8,48.2
    .vendor >>如果没有铜管，请从Herble Baubbletump（限量供应）购买
    .bronzetube
step
    .goto Duskwood,79.8,47.9
    .accept 174 >> 接受向星星看
    .turnin 174 >> 转身看星星
    .bronzetube -1
step << Rogue
    .goto Duskwood,77.5,44.4
    .fp Duskwood >> 获得黄昏飞行点
step
    .goto Duskwood,79.8,47.9
    .accept 175 >> 接受向星星看
    .isQuestTurnedIn 174
step
	#sticky
	#completewith HistoryB
	.use 2794 >>留意书本（全区掉落）。你以后需要这个
	.collect 2794,1,337
	.accept 337 >> 接受旧历史书
step
    .goto Duskwood,82.0,59.0
    .turnin 175 >> 转身看星星
    .accept 177 >> 接受向星星看
    .isQuestTurnedIn 174
step
    .goto Duskwood,80.9,71.8
    >>在教堂杀死疯狂的食尸鬼。他也可以在外面巡逻。
    .complete 177,1 --Collect Mary's Looking Glass (x1)
    .isQuestTurnedIn 174
	.unitscan Insane Ghoul
step
    .goto Duskwood,79.3,70.3
    >> 杀死该地区的骷髅暴徒
    .complete 56,1 --Kill Skeletal Warrior (x8)
    .complete 56,2 --Kill Skeletal Mage (x6)
step
    .goto Duskwood,18.4,56.6
    .turnin 163 >> 转入Raven Hill
    .accept 5 >> 接受Jitters的咆哮
step
    .goto Duskwood,7.8,34.1
    .turnin 164 >> 将交付物交给Sven
    .accept 95 >> 接受斯文的复仇
step
    .goto Duskwood,7.7,33.3
    .accept 226 >> 接受我们脚下的狼
    .maxlevel 26
step
    .goto Duskwood,28.0,31.5
    .turnin 165 >> 交给隐士
    .accept 148 >> 接受Darkhire的补给
step
    >>沿着海岸奔跑，杀死狼
    .xp <25,1
    .goto Duskwood,17.6,24.6
    .complete 226,1 --Kill Starving Dire Wolf (x12)
    .complete 226,2 --Kill Rabid Dire Wolf (x8)
step << Rogue/Druid
    #label HistoryB
	.goto Duskwood,17.7,29.1
    .accept 225 >> 接受风化的坟墓
step << !Rogue !Druid
	.goto Duskwood,17.7,29.1
    .accept 225 >> 接受风化的坟墓
step << Rogue/Druid
    .goto Westfall,56.6,52.6
    .fp Sentinel >> 获取哨兵山飞行路线
step << Rogue tbc
    .goto Westfall,68.5,70.0
    .turnin 2360 >> 交给Mathias和Defias
    .accept 2359 >> 接受科拉文大厦
step << Rogue tbc
    .goto Westfall,70.6,72.8
    >>盗取一个Defias Drones并抢夺塔钥匙
    .complete 2359,2 --Collect Defias Tower Key (x1)
step << Rogue tbc
    .goto Westfall,70.4,74.0
    >>爬到塔顶，从地板上的小箱子里抢东西
    .complete 2359,1 --Collect Klaven Mortwake's Journal (x1)
step << Rogue/Druid
    .goto Westfall,41.5,66.8
    .turnin 67 >> 交出《种马传奇》
    .accept 68 >> 接受Stalvan的传说
step << Druid tbc
    .goto Westfall,18.0,33.2
    >>抢劫位于水下深处的锁箱
    .collect 15882,1 --Collect Half Pendant of Aquatic Endurance (x1)
step << Druid tbc
    .goto Moonglade,36.0,41.4
    >>传送到moonglade
    >>在雷穆洛斯神殿合并两个吊坠
    .complete 272,1 --Collect Pendant of the Sea Lion (x1)
step << Druid tbc
    .goto Moonglade,56.2,30.6
    >>传送回夜航
    .turnin 272 >> 海狮的审判
    .accept 5061 >> 接受水生形态
step << Druid tbc
    #sticky
    #completewith next
    .goto Moonglade,44.1,45.2
    .fly Teldrassil>> 飞往Teldrassil
step << Druid tbc
    .goto Darnassus,35.4,8.3
    .turnin 5061 >> 以水生形态交出
step << Rogue/Druid
    #sticky
    #completewith next
    .hs >> 赫斯回到镇上
step << Rogue tbc
    .goto StormwindClassic,75.9,59.9
    .turnin 2359 >> 转入Klaven’s Tower
    .accept 2607 >> 接受赞齐尔的触摸
step << Rogue tbc
    .goto StormwindClassic,78.1,59.0
    >>去地下室
    .turnin 2607 >> 《桑齐之触》（Turn in The Touch of Zanzil）
    .accept 2608 >> 接受赞齐尔的触摸
step << Rogue tbc
    .goto StormwindClassic,78.1,59.0
    >>键入/放置聊天并等待任务完成
    .complete 2608,1 --Diagnosis Complete
step << Rogue tbc
    .goto StormwindClassic,78.0,58.8
    .turnin 2608 >> 《桑齐之触》（Turn in The Touch of Zanzil）
    .accept 2609 >> 接受赞齐尔的触摸
step << Rogue tbc
    .goto StormwindClassic,78.2,59.0
    >>从阴影经销商处购买含铅小瓶
    .complete 2609,2 --Collect Leaded Vial (x1)
step << Rogue tbc
    >>去卖花的人那里
    .complete 2609,1 --Collect Simple Wildflowers (x1)
    .goto StormwindClassic,64.3,60.8
step << Rogue tbc
    #sticky
    #completewith next
    >>在拍卖行买一个铜管。这是你的无赖任务，而不是仰望星空！
    .complete 2609,3 --Collect Bronze Tube (x1)
step << Rogue tbc
    .goto StormwindClassic,53.6,59.3
    >>前往大教堂广场和公园之间桥旁的商店。这是你必须捡到的地面上的物体。
    .complete 2609,4 --Collect Spool of Light Chartreuse Silk Thread (x1)
    .goto StormwindClassic,39.8,46.5
    >>如果你找不到青铜管，你必须跳过这个任务，将急救训练到80岁，在Duskwood从蜘蛛身上种植一个小毒液囊，制作一种抗毒液并清除Zanzil毒液。
step << Rogue tbc
    .goto StormwindClassic,78.0,58.9
    .turnin 2609 >> 《桑齐之触》（Turn in The Touch of Zanzil）
step << Rogue tbc
    .goto StormwindClassic,78.2,59.0
    .vendor >>购买腐烂的灰尘和空瓶子，这样你可以制造毒药
step << Rogue tbc
    #sticky
    #completewith next
    .use 8432 >> 用解毒剂解毒。
    .destroy 8046 >> 摧毁卡恩的日记
step << Rogue tbc
    .goto StormwindClassic,66.2,62.2
    .fly Duskwood>> 飞到黄昏
step << !Rogue !Druid !Priest !Warlock
    .goto Duskwood,60.8,29.7
	>>磨合你的方式回到东部黄昏。如果现在杀死暗影编织者太难了，请跳过这一步，稍后您将完成它
    .complete 173,1 --Kill Nightbane Shadow Weaver (x6)
step
    .goto Duskwood,73.8,43.3
    .turnin 5 >> 转入Jitters的咆哮肠子
    .accept 93 >> 接受黑螃蟹蛋糕
step
    .goto Duskwood,73.6,46.8
    .turnin 56 >> 上夜班
    .accept 57 >> 接受夜间监视

step
    .goto Duskwood,72.6,47.6
    .turnin 225 >> 转入风化墓地
    .accept 227 >> 接受Morgan Ladimore
step
    .goto Duskwood,73.5,46.9
    .turnin 227 >> 交给Morgan Ladimore
    .accept 228 >> 接受莫拉迪姆
step
	#sticky
	#completewith next
	.destroy 2154 >> 您可以从库存中删除“摩根·拉迪莫尔的故事”，因为它不是必需的
step
    .goto Duskwood,75.7,45.3
    .turnin 148 >> 从Darkhire上交物资
    .accept 149 >> 接受幽灵头发线
step
    #label HistoryB
	.goto Duskwood,79.8,47.8
    .turnin 177 >> 转身看星星
    .accept 181 >> 接受向星星看
    .isQuestTurnedIn 174
step
	#sticky
	#completewith HistoryB2
	>>留意旧历史书（全区掉落）。你以后需要这个
	.collect 2794,1,337
	.accept 337 >> 接受旧历史书
step
    .goto Duskwood,81.9,59.1
    .turnin 149 >> 转入幽灵发线
    .accept 154 >> 接受并返回梳子
step
    .goto Duskwood,75.7,45.3
    .turnin 154 >> 交回梳子
    .accept 157 >> 接受并交付线程
step
    .goto Duskwood,49.9,77.8
    .turnin 95 >> 交出斯文的复仇
    .accept 230 >> 接受斯文的营地
step
	#label spiders
	#sticky
	#completewith spiderend12
	>>在达克伍德杀死蜘蛛
    .complete 93,1 --Collect Gooey Spider Leg (x6)
	.maxlevel 27
step
    .goto Duskwood,28.0,31.5
    .turnin 157 >> 交上来传递线索
    .accept 158 >> 接受僵尸汁
step
    .goto Duskwood,17.6,24.6
    .complete 226,1 --Kill Starving Dire Wolf (x12)
    .complete 226,2 --Kill Rabid Dire Wolf (x8)
    .isOnQuest 226
step << Hunter/Paladin
    .goto Duskwood,19.7,39.7
    >>杀死在墓地漫游的30级精英。在这个地区的大树周围放风筝。
    >> 当他愤怒时，跑开疗伤，利用大树腾出空间。在激怒时不要试图击毙他 << Paladin
    .complete 228,1 --Collect Mor'Ladim's Skull (x1)
step
    .goto Duskwood,7.8,34.0
    .turnin 230 >> 交出斯文的营地
    .accept 262 >> 接受阴影人物
step
    #label HistoryB2
	.goto Duskwood,7.7,33.3
    .turnin 226 >> 在我们的脚跟上交狼
    .isOnQuest 226
step << !Rogue !Druid
	#requires spiders
    .goto Westfall,56.6,52.6
    .fp Sentinel >> 获取哨兵山飞行路线
step << !Rogue !Druid
    .goto Westfall,41.5,66.8
    .turnin 67 >> 交出《种马传奇》
    .accept 68 >> 接受Stalvan的传说
step << Paladin
    .goto Westfall,42.5,88.6
    .turnin 1650 >>交给勇敢的人
    .accept 1651 >>接受勇士之父
step << Paladin
    .goto Westfall,42.5,88.6
    .complete 1651,1 --Protect Daphne Stilwell (1)
    .turnin 1651 >>交给勇敢的人
    .accept 1652 >>接受勇士之父
step << !Rogue !Druid
    #sticky
    #completewith next
    .hs >> 赫斯回到黄昏
step << Rogue/Druid
	#requires spiders
    .goto Duskwood,60.8,29.7
	>>磨蹭着回到东黄昏
    .complete 173,1 --Kill Nightbane Shadow Weaver (x6)
step
    .goto Duskwood,75.7,45.3
    .turnin 262 >> 交给阴影人物
    .accept 265 >> 接受阴影搜索继续
step
    .goto Duskwood,72.6,46.9
    .turnin 265 >> 转入阴影搜索继续
    .accept 266 >> 接受客栈询问
    .turnin 68 >> 交出《种马传奇》
    .accept 69 >> 接受Stalvan的传说
step
	#completewith next
	.vendor >> 记住购买25级食物和水
step
    .goto Duskwood,73.9,44.4
    .turnin 158 >> 加入僵尸汁
    .accept 156 >> 接受收集腐烂花朵
    .turnin 266 >> 在客栈上车询问
    .accept 453 >> 接受寻找阴影人物
step
    .goto Duskwood,73.9,43.9
    .turnin 93 >> 加入黑蟹蛋糕
    .isQuestComplete 93
step
    .goto Duskwood,73.9,43.9
    .accept 240 >> 接受返回抖动
    .isQuestTurnedIn 93
step << Hunter/Paladin
	.goto Duskwood,73.7,46.8
    .turnin 228 >> 交给莫拉迪姆
    .accept 229 >> 接受活着的女儿
step << Hunter/Paladin
    .goto Duskwood,74.5,46.1
    .turnin 229 >> 交出活着的女儿
    .accept 231 >> 接受女儿的爱
step << !Rogue !Druid
    .isOnQuest 173
    .goto Duskwood,60.8,29.7
	>>杀死黑郡上方的暗影编织者
    .complete 173,1 --Kill Nightbane Shadow Weaver (x6)
step << !Priest !Warlock
    .goto Duskwood,75.3,47.9
    .turnin 173 >> 在树林里交沃根
    .accept 221 >> 接受森林里的狼人
step
    #label spiderend12
    .goto Duskwood,77.5,44.3
 .fly Redridge >> 飞到雷德里奇
step
    .goto Redridge Mountains,31.6,57.9
    .accept 128 >> 接受黑石赏金
    .maxlevel 26 << Paladin/Hunter
step
    .goto Redridge Mountains,33.5,49.2
    .accept 19 >> 接受Tharil'zun
    .accept 115 >> 接受阴影魔法
step
    .goto Redridge Mountains,80.3,37.2
	>> 杀死法戈雷，并为他的爪子洗劫他。当许多侏儒在他周围巡逻时要小心，他是影子免疫的，可以在40码范围内的任何时候攻击所有侏儒。
    .complete 180,1 --Collect Fangore's Paw (x1)
step
    .isOnQuest 94
    .goto Redridge Mountains,84.3,46.9
    .turnin 94 >> 睁大眼睛
step
    .goto Redridge Mountains,84.3,46.9
    .accept 248 >> 接受进一步调查
    .isQuestTurnedIn 94
step << !Warlock
    .goto Redridge Mountains,74.2,42.1
	>> 杀死该地区的侏儒
    .complete 91,1 --Collect Shadowhide Pendant (x10)
step
	#sticky
	#label tharilzun
    .goto Redridge Mountains,69.2,59.8
	Kill Tharil'zun and loot his head
    .complete 19,1 --Collect Tharil'zun's Head (x1)
step
    .goto Redridge Mountains,66.6,55.4
	>>杀死黑石暗影投射者。为了午夜球而抢劫他们
    .complete 115,1 --Collect Midnight Orb (x3)
step
    .isOnQuest 248
    .goto Redridge Mountains,63.2,49.7
	>>爬到塔顶
    .turnin 248 >> 转向看得更远
step
    .goto Redridge Mountains,32.8,6.8
    .complete 128,1 --Kill Blackrock Champion (x15)
    .isOnQuest 128
step
    .goto Redridge Mountains,33.5,48.9
    .turnin 19 >> 交给Tharil'zun
	.isQuestComplete 19
step
	.goto Redridge Mountains,33.5,48.9
    .turnin 115 >> 投身暗影魔法
step << !Warlock
    .goto Redridge Mountains,29.6,44.3
    .turnin 91 >> 交出所罗门定律
step
    .goto Redridge Mountains,29.8,44.5
    .turnin 180 >> 通缉犯：Fangore中尉
step
    .goto Redridge Mountains,31.6,58.0
    .turnin 128 >> 交上黑石赏金
    .isQuestComplete 128
step
    #completewith fpwfend
	.goto Redridge Mountains,30.5,59.3
    .fly Westfall>> 飞往威斯特福尔
step
	#sticky
	#completewith HistoryB3
	>>留意旧历史书（全区掉落）。你以后需要这个
	.collect 2794,1,337
	.accept 337 >> 接受旧历史书
step
    #completewith fpwfend
    .goto Duskwood,18.4,56.5
    .turnin 453 >> 转身寻找阴影人物
    .accept 268 >> 接受返回Sven
step
    .goto Duskwood,18.4,56.5
    .turnin 240 >> 转向转向抖动
    .isOnQuest 240
step
    .goto Duskwood,7.7,34.1
    .turnin 268 >> 交回斯文
    .accept 323 >> 接受证明你的价值
step << !Hunter !Paladin
    .goto Duskwood,21.6,45.1
	>> 杀死该地区的亡灵并掠夺他们
    .complete 57,1 --Kill Skeletal Fiend (x15)
    .complete 57,2 --Kill Skeletal Horror (x15)
    .complete 156,1 --Collect Rot Blossom (x8)
    .complete 101,3 --Collect Skeleton Finger (x10)
step << Hunter/Paladin
    .goto Duskwood,17.7,29.2
    >> 单击墓碑
    .turnin 231 >> 交出女儿的爱
step << Hunter/Paladin
    .goto Duskwood,21.6,45.1
	>> 杀死该地区的亡灵并掠夺他们
    .complete 57,1 --Kill Skeletal Fiend (x15)
    .complete 57,2 --Kill Skeletal Horror (x15)
    .complete 156,1 --Collect Rot Blossom (x8)
    .complete 101,3 --Collect Skeleton Finger (x10)
step
    .goto Duskwood,16.2,38.8
    >>杀死地下室周围的暴徒，你可能需要进去杀死你需要的3个看守
    .complete 323,1 --Kill Skeletal Raider (x15)
    .complete 323,2 --Kill Skeletal Healer (x3)
    .complete 323,3 --Kill Skeletal Warder (x3)
step
	 .goto Duskwood,23.8,35.0
	.xp 27+12000>>研磨至12000+/32200xp
step << !Hunter !Paladin
    .goto Duskwood,19.7,39.7
    >>杀死在墓地漫游的30级精英。如果你不能独奏或找不到一个小组，请跳过这一步。
    >> 当他愤怒时，就逃跑，用大树放风筝，腾出空间。在激怒时不要试图击毙他
    .unitscan Mor'Ladim
    .complete 228,1 --Collect Mor'Ladim's Skull (x1)
step
    #label HistoryB3
	.goto Duskwood,7.9,34.1
    .turnin 323 >> 证明你的价值
    .accept 269 >> 接受寻求智慧
step
    #completewith next
    .deathskip >>前往Elwynn Forest，聚集一群低级暴徒，故意死亡，并在Goldshire重生。
step
    .goto Elwynn Forest,43.7,65.9
    .turnin 69 >> 交出《种马传奇》
    .accept 70 >> 接受Stalvan的传说
step
    >>到楼上那个无赖教练后面的房间里去。抢劫胸部
	.goto Elwynn Forest,44.2,65.9
    .complete 70,1 --Collect An Undelivered Letter (x1)
step << Shaman
	.goto StormwindClassic,61.9,84.0
	.trainer >> 训练你的职业咒语
step << Warrior
    .goto Elwynn Forest,41.1,65.8
    .trainer >> 训练你的职业咒语
step << Warlock
    >>进入酒店地下室
    .goto Elwynn Forest,44.4,66.2
	.trainer >> 训练你的职业咒语
step << Mage
    .goto StormwindClassic,39.6,79.6
	>> Teleport到stormwind
	.trainer >> 训练你的职业咒语
step
    #xprate <1.5
    .goto StormwindClassic,26.4,78.4
    .accept 335 >> 接受高贵的酿造
step
    .goto StormwindClassic,29.8,61.8
    .turnin 70 >> 交出《种马传奇》
    .accept 72 >> 接受Stalvan的传说
step
    .goto StormwindClassic,29.6,61.7
    .turnin 72 >> 交出《种马传奇》
    .accept 74 >> 接受Stalvan的传说
step <<!Mage
    .goto StormwindClassic,40.8,30.8
    .accept 2923 >> 接受Tinkmaster Overspark
step << Paladin
    .goto StormwindClassic,40.0,29.9
    .turnin 1652 >>交给勇敢的人
    .accept 1653 >>接受正义的考验
step
    .goto StormwindClassic,39.3,28.0
    .turnin 269 >> 转向寻求智慧
    .accept 270 >> 接受末日舰队
step
    #xprate >1.3
    .xp <28,1
    .goto StormwindClassic,41.5,31.7
	>>和巡逻的孩子谈谈
    .accept 1274 >> 接受失踪的外交官
step << Paladin
#xprate <1.5
	.goto StormwindClassic,38.6,32.8
	.trainer >> 训练你的职业咒语
step << Priest
#xprate <1.5
	.goto StormwindClassic,38.5,26.8
	.trainer >> 训练你的职业咒语
step << Hunter
#xprate <1.5
	.goto StormwindClassic,61.7,15.4
	.trainer >> 训练你的职业咒语
--????

]])

RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Alliance
#name 27-30 湿地/希尔斯布莱德丘陵
#version 1
#group RestedXP 联盟 20-32
#next 30-32 暮色森林/荆棘谷
#xprate <1.5

step
    .goto StormwindClassic,60.5,12.3,40,0
    .goto StormwindClassic,60.5,12.3,0
    .link https://www.youtube.com/watch?v=M_tXROi9nMQ >> 点击此处在电车内注销跳过
    .zone Ironforge >> 坐电车到铁炉堡
step <<!Mage
    .goto Ironforge,69.8,50.1
    .turnin 2923 >> 交给Tinkmaster Overspark
step << Rogue
    #sticky
    #completewith next
    .trainer >> 在铁炉堡训练你的职业法术。如果你刚刚在暴风城训练，请跳过。
step << Rogue
    .goto Ironforge,45.2,6.6
    >>购买31级武器升级（17dps）
    .collect 2520,1
    .collect 2526,1
    >>如果你能在拍卖行找到更好的武器，跳过这一步
step << Mage
    #completewith next
    .zone Ironforge >> 传送至铁炉堡
step << Hunter/Warrior/Paladin/Shaman/Rogue
	.goto Ironforge,61.34,89.25
	.train 197 >> 列车2H轴 << !Rogue
	.train 266 >> 训练枪 << Hunter/Warrior/Rogue
    .train 199 >> 火车2H梅斯 << Warrior/Shaman
    .train 54 >> 火车梅斯 << Rogue/Shaman/wotlk Warrior
    .train 44 >> 火车轴 << Shaman/wotlk Warrior
step << Hunter
	#sticky
	#completewith next
	.goto Ironforge,61.34,89.25
	>>走进大楼，下楼去，从Thalgus Thunderfist那里买一个30级箭袋
	.collect 7371,1
step << Paladin
    .goto Dun Morogh,52.5,36.8
    >> 前往铁炉堡大门
    .turnin 1653 >>提交正义测试
step << Dwarf !Paladin wotlk
	#sticky
	#completewith next
	.goto Dun Morogh,63.5,50.6
	.money <5.00
	.train 152 >> 前往Dun Morogh，乘坐火车并购买您的坐骑。
step << Gnome !Warlock wotlk
	#sticky
	#completewith next
	.goto Dun Morogh,49.2,48.1
	.money <5.00
	.train 553 >> 前往Dun Morogh，乘坐火车并购买您的坐骑。
step
	#label end
	.goto Ironforge,56.2,46.8
    .fly Wetlands>> 飞到湿地
step
    .goto Wetlands,8.4,58.5
    .turnin 279 >> 从深处把爪子转过来
    .accept 281 >> 接受回收货物
step
    .goto Wetlands,8.6,55.8
    .turnin 469 >> 每日交付交付
    .isOnQuest 469
step
    .goto Wetlands,8.6,55.8
    .turnin 484 >> 交出小鳄鱼皮
    .isOnQuest 484
step
    .goto Wetlands,8.6,55.8
    .accept 471 >> 接受学徒的职责
    .isQuestTurnedIn 484
step
    .goto Wetlands,10.8,59.6
    .accept 289 >> 接受受诅咒的船员
step
    .goto Wetlands,10.6,60.5
    .turnin 270 >> 交出末日舰队
    .accept 321 >> 接受Lightforge Iron
step
      .goto Wetlands,10.7,60.9
	>> 如果需要，补充食物/水。
.home >> 把你的炉石放在深水酒馆
step
    .goto Wetlands,10.9,55.9
    .accept 472 >> 接受Dun Modr的堕落
step
    .goto Wetlands,9.9,57.4
    .turnin 464 >> 交出战旗
    .accept 465 >> 接受Nek'rosh的赌注
step
    .goto Wetlands,11.7,58.0
    .accept 470 >> 接受在淤泥中挖掘
step
    .goto Wetlands,11.5,52.2
    .turnin 306 >> 移交以搜索挖掘队
step
    .goto Wetlands,13.5,41.5
    .turnin 281 >> 上缴取回货物
    .accept 284 >> 接受搜索继续
step
    .goto Wetlands,13.5,38.4
    .turnin 284 >> 交出继续搜索
    .accept 285 >> 接受搜索更多冰球
step
    .goto Wetlands,13.9,34.8
    .turnin 285 >> 投掷更多的铁球
    .accept 286 >> 接受并返回雕像
step
    .goto Wetlands,13.9,30.4
    >>要找到斯内利，从靠近海岸的船体上的孔进入船内
	>> 如果你找不到海军陆战队，向北的船通常有更多的海军陆战团。
    .complete 289,3 --Collect Snellig's Snuffbox (x1)
    .complete 289,1 --Kill Cursed Sailor (x13)
    .complete 289,2 --Kill Cursed Marine (x5)
step
    .goto Wetlands,17.8,26.3
	>> 杀死沿海的巨鳄鱼，并掠夺它们的皮毛
    .complete 471,1 --Collect Giant Crocolisk Skin (x6)
    .isQuestTurnedIn 484
step
    .goto Wetlands,38.2,50.9
    .accept 294 >> 接受奥默的复仇
step
	#label fossil
	#sticky
	#completewith Relu1
	>>杀死湿地中的猛禽
	.complete 943,1
    .isOnQuest 943
step
    .goto Wetlands,24.7,48.6
    .complete 294,1 --Kill Mottled Raptor (x10)
    .complete 294,2 --Kill Mottled Screecher (x10)
step
    .goto Wetlands,38.2,50.9
    .turnin 294 >> 交出奥默的复仇
    .accept 295 >> 接受奥默的复仇
step
    .goto Wetlands,38.8,52.3
    .turnin 305 >> 移交以搜索挖掘队
    .accept 306 >> 接受挖掘团队的搜索
step
	.goto Wetlands,38.81,52.39
	.accept 299 >>接受揭开过去
step
	#label relics
	#sticky
	.goto Wetlands,34.3,49.5,0
	>>抢劫挖掘点周围的4处遗迹
	.complete 299,1
	.complete 299,2
	.complete 299,3
	.complete 299,4
step
    .goto Wetlands,34.6,48.0
    .complete 295,1 --Kill Mottled Scytheclaw (x10)
    .complete 295,2 --Kill Mottled Razormaw (x10)
step
    .goto Wetlands,38.2,50.9
    .turnin 295 >> 交出奥默的复仇
    .accept 296 >> 接受奥默的复仇
step
    .goto Wetlands,31.5,48.9,50,0
    .goto Wetlands,33.3,51.5
	>>在山顶杀死萨尔托特。为他的魔爪抢劫他。小心，因为他会流鼻涕，并有6分钟的重生
    .complete 296,1 --Collect Sarltooth's Talon (x1)
step
	#requires relics
    .goto Wetlands,38.2,50.9
    .turnin 296 >> 交出奥默的复仇
step
	#requires relics
	.goto Wetlands,38.81,52.39
	.turnin 299 >>转身揭开过去
step
	#label Relu1
	.goto Wetlands,38.81,52.39
	>>抢劫地上的化石
	.complete 943,2
    .isOnQuest 943
step
	.goto Wetlands,34.6,48.0
	>>继续杀戮猛禽直到你洗劫了Relu之石
	.complete 943,1
    .isOnQuest 943
step
    .goto Wetlands,44.2,25.8
    >>杀死地穴周围的黏液
    .complete 470,1 --Collect Sida's Bag (x1)
step
    .goto Wetlands,44.2,33.9
	>>杀死侏儒
    .complete 277,1 --Collect Crude Flint (x9)
    .isQuestTurnedIn 276
step
    .goto Wetlands,56.3,40.5
    .turnin 277 >> 交火禁忌
    .accept 275 >> 接受大地上的水泡
    .isQuestTurnedIn 276
step
    .goto Wetlands,64.8,75.3
    >>抢劫瀑布底部的树根
    .complete 335,2 --Collect Musquash Root (x1)
    .isOnQuest 335
step << Druid
    #completewith next
    >>传送至Moonglade
    .goto Moonglade,52.4,40.6
    .trainer 12042 >> 火车咒语
step
    .hs >> 赫斯到米奈希尔港
step
    .goto Wetlands,10.8,59.6
    .turnin 289 >> 交出受诅咒的船员
    .accept 290 >> 接受解除诅咒
step
    .goto Wetlands,10.8,60.4
	>>上楼去和考古学家Flagongut谈谈
	.turnin 943 >>交回心不在焉的探矿者
    .isOnQuest 943
step
    .goto Wetlands,11.7,58.1
    .turnin 470 >> 转身在泥泞中挖掘
    .isQuestComplete 470
step
    .goto Wetlands,8.3,58.5
    .turnin 286 >> 交回雕像
step
    .goto Wetlands,8.6,55.8
    .turnin 471 >> 交出学徒的职责
    .isQuestTurnedIn 484
step
    .goto Wetlands,15.5,23.5
    >>通过破损的桅杆进入船内，杀死Halyndor船长
    .complete 290,1 --Collect Intrepid Strongbox Key (x1)
step
    .goto Wetlands,14.4,24.0
	>> 潜水。船北侧的船体上有一个洞。
    .turnin 290 >> 转身解除诅咒
    .accept 292 >> 接受Paleth之眼
step
	#sticky
    >>杀死芬·克里珀斯，他们是潜伏在河边的潜行暴徒
    .complete 275,1 --Kill Fen Creeper (x8)--O
    .isOnQuest 275
step
    .goto Wetlands,47.3,46.9
    .turnin 465 >> 交出Nek'rosh的赌注
    .accept 474 >> 接受击败Nek'rosh
step
    .goto Wetlands,53.5,54.6
	>> 杀了内克洛什，然后抢走他的头
    .complete 474,1 --Collect Nek'rosh's Head (x1)
step << Warrior
    #sticky
	#completewith next
    .goto Wetlands,50.2,37.8
    >>检查药草供应商并购买一些Liferoot，稍后你需要8个才能完成任务，如果你已经有了，跳过这一步
    .collect 3357,8 --Collect Liferoot (x8)
    #xprate <1.5
step
    .goto Wetlands,56.4,40.5
	>>在河里干掉Fen Creepers
    .turnin 275 >> 陆地上的水泡
    .isOnQuest 275
step
    #completewith next
    .goto Wetlands,49.9,18.3
    .turnin 472 >> Dun Modr秋季转身
step
    .goto Wetlands,49.9,18.3
    .accept 631 >> 接受Thandol跨度
    .accept 304 >> 接受严峻任务
    .accept 303 >> 接受黑铁战争
step
	#sticky
    #label balgaras
    >>杀死犯规的巴尔加拉斯，他可以在东边很远的营地或邓莫德的一所房子里产卵。检查完Dun Modir后往东走。抢他的耳朵。
    .complete 304,1 --Collect Ear of Balgaras (x1)
	.unitscan Balgaras the Foul
    .goto Wetlands,47.4,15.4,40,0
    .goto Wetlands,61.8,31.0,80,0
    .goto Wetlands,46.8,16.0
step--?
    .goto Wetlands,47.3,16.6
	>> 杀死该地区的黑铁矮人
    .complete 303,1 --Kill Dark Iron Dwarf (x10)
    .complete 303,2 --Kill Dark Iron Tunneler (x5)
    .complete 303,3 --Kill Dark Iron Saboteur (x5)
    .complete 303,4 --Kill Dark Iron Demolitionist (x5)
step
    #requires balgaras
    .goto Wetlands,49.7,18.3
    .turnin 303 >> 转入黑铁战争
    .turnin 304 >> 提交严峻任务
step
    .goto Wetlands,51.2,8.0
	>> 下楼，点击矮人尸体。忽略所有的暴徒。
    .turnin 631 >> 转入Thandol桥
    .accept 632 >> 接受Thandol跨度
step
    .goto Wetlands,49.9,18.3
    .turnin 632 >> 转入Thandol桥
    .accept 633 >> 接受Thandol跨度
step
    .goto Arathi Highlands,43.3,92.6
    .accept 647 >> 接受麦克雷尔的月光
    >>如果你没有任何速度提升或缓慢下降，你仍然可以获得这个任务
    .link https://www.twitch.tv/videos/646111384 >>单击此处以供参考
step
#xprate <1.5
    .goto Arathi Highlands,44.3,93.0
	.use 4433 >>跳下去，从水下尸体上抢走信件
    .accept 637 >> 接受萨利·巴鲁的信
step
    #completewith next
    .goto Arathi Highlands,52.5,90.4,30 >> 向东游向这里的斜坡
step
    .goto Arathi Highlands,48.7,87.9
    .complete 633,1 --Collect Cache of Explosives Destroyed (x1)
step
    .goto Wetlands,49.9,18.3
    .turnin 633 >> 转入Thandol桥
    .accept 634 >> 接受对联盟的请求
step
    .goto Arathi Highlands,45.9,47.5
    .turnin 634 >> 向联盟递交请愿书
step
    #xprate >1.3
    .goto Arathi Highlands,46.6,47.0
    .turnin 690 >> 提交Malin的请求
    .isOnQuest 690
step
    .goto Arathi Highlands,45.8,46.1
    .fp Arathi >> 获取Arathi Highlands航线
step
.isOnQuest 647
>>跑到南岸，在客栈下楼。定时器还没到就开始工作。当心路上的快递员。
	.unitscan Forsaken Bodyguard
.goto Hillsbrad Foothills,52.2,58.6
    .turnin 647 >> 交上麦克雷尔的月光
step
	.goto Hillsbrad Foothills,50.5,57.2
    .turnin 538 >> 在南岸转弯
	.isOnQuest 538
step << !Warlock
#xprate <1.5
    .goto Hillsbrad Foothills,51.9,58.7
    .accept 555 >> 接受安抚乌龟饼干
step
    .xp <30,1
    .goto Hillsbrad Foothills,51.4,58.5
    .accept 536 >> 接受沿海地区
step
    .goto Hillsbrad Foothills,50.9,58.8
    .accept 9435 >> 接受丢失的晶体
step <<  Hunter tbc
     #completewith next
    .goto Hillsbrad Foothills,50.2,58.8
     .stable >> 稳定你的宠物，向东走
step << Hunter tbc
    .xp <30,1
    .goto Hillsbrad Foothills,56.6,53.8
    .train 17264 >> 驯服一只老苔藓爬行动物，用它攻击暴徒以学习咬等级4
	.unitscan Elder Moss Creeper
step
    .xp <30,1
    .goto Hillsbrad Foothills,44.0,67.6
	>> 杀死该地区的墨洛克人
    .complete 536,1 --Kill Torn Fin Tidehunter (x10)
    .complete 536,2 --Kill Torn Fin Oracle (x10)
step
    .xp <30,1
    .goto Hillsbrad Foothills,51.4,58.5
    .turnin 536 >> 沿海岸转弯
    .accept 559 >> 接受Farren的证明
step
    .xp <30,1
    .goto Hillsbrad Foothills,42.3,68.3
	>> 杀死墨洛克人并掠夺他们的头
    .complete 559,1 --Collect Murloc Head (x10)
step
    .xp <30,1
    .goto Hillsbrad Foothills,51.4,58.5
    .turnin 559 >> 提交Farren的证明
    .accept 560 >> 接受Farren的证明
step
    .xp <30,1
    .goto Hillsbrad Foothills,49.5,58.8
    .turnin 560 >> 提交Farren的证明
    .accept 561 >> 接受Farren的证明
step
    .xp <30,1
    .goto Hillsbrad Foothills,51.4,58.4
    .turnin 561 >> 提交Farren的证明
    .accept 562 >> 接受风暴浩！
step
    .xp <30,1
    .goto Hillsbrad Foothills,57.1,67.4
	>> 杀死该地区的纳加，如果你不幸产卵，你可能需要下水
    .complete 562,1 --Kill Daggerspine Shorehunter (x10)
    .complete 562,2 --Kill Daggerspine Siren (x10)
step
    .xp <30,1
    .goto Hillsbrad Foothills,51.4,58.5
    .turnin 562 >> 在暴风雨中！
    .accept 563 >> 接受重新分配
step
    .goto Hillsbrad Foothills,49.3,52.3
    .fp Southshore >> 获得南岸航线
step
    .goto Western Plaguelands,42.9,85.0
    >>沿着河流向北养殖龟肉，一旦到达河流的尽头，向西北方向驶入WPL。你还不需要全部10块肉。
    .fp Chillwind >> 获取奇风营地飞行路线
    .fly Wetlands>> 飞到湿地
step
    .goto Wetlands,10.6,60.5
    .turnin 292 >> 交给Paleth的眼睛
    .accept 293 >> 接受眼部清洁
step
    .goto Wetlands,12.1,64.1
    .turnin 321 >> 交给Lightforge熨斗
    .accept 324 >> 接受丢失的钢锭
step
    .goto Wetlands,10.1,69.5
	>> 杀死墨洛克人并掠夺他们的铸锭。下降率可能非常低。
    .complete 324,1 --Collect Lightforge Ingot (x5)
step
    .goto Wetlands,10.6,60.4
    .turnin 324 >> 交回丢失的钢锭
    .accept 322 >> 接受祝福之臂
step
    .goto Wetlands,9.9,57.4
    .turnin 474 >> 投奔击败内克罗什
step << !Mage
	.goto Wetlands,9.3,59.4
    .fly Ironforge>> 飞往铁炉堡
step << Mage
    .zone Ironforge >> 传送至铁炉堡
step
    .goto Ironforge,63.8,67.8
    .turnin 637 >> 交回萨利·巴鲁的信
    .accept 683 >> 接受Sara Balloo的请求
step
    .goto Ironforge,39.3,55.9
    .turnin 683 >> 提交Sara Balloo的请求
    .accept 686 >> 接受国王的贡品
step
    .goto Ironforge,38.7,87.2
    .turnin 686 >> 上缴国王贡品
    .accept 689 >> 接受国王的贡品
]])

RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Alliance
#name 30-32 暮色森林/荆棘谷
#version 1
#group RestedXP 联盟 20-32
#next RestedXP 联盟 32-47\32-33 千针石林
#xprate <1.5
step << !Mage
	.goto Ironforge,74.5,50.5,20,0
	.goto StormwindClassic,51.7,12.3
    .link https://www.youtube.com/watch?v=M_tXROi9nMQ >> 点击此处在电车内注销跳过
    .zone Stormwind City>> 乘坐电车前往暴风城
step << Mage
	>> Teleport到stormwind
    .goto StormwindClassic,39.6,79.6
	.trainer >> 训练你的职业咒语
step << Hunter
	.goto StormwindClassic,61.7,15.4
	.trainer >> 训练你的职业咒语
	.train 14924>> 宠物训练师处训练咆哮4
step
    #sticky
    #completewith exit
    >>从拍卖行购买铜管
    .complete 174,1
	.bronzetube
step << Human Paladin
    #sticky
	#completewith next
    >>如果你还没有，就去拍卖行买10块亚麻布
    .collect 2589,10,1644
step << Paladin
    .goto StormwindClassic,40.0,29.9
    .turnin 1652 >>交给勇敢的人
    .accept 1653 >>接受正义的考验
step << Paladin
	.goto StormwindClassic,38.6,32.8
	.trainer >> 训练你的职业咒语
step << Priest
	.goto StormwindClassic,38.5,26.8
	.trainer >> 训练你的职业咒语
step
    .goto StormwindClassic,39.3,28.0
    .turnin 269 >> 转向寻求智慧
    .accept 270 >> 接受末日舰队
step
    .isOnQuest 322
    .goto StormwindClassic,51.7,12.3
    .turnin 322 >> 交给上帝的手臂
    .accept 325 >> 接受武装并准备就绪
step
	#sticky
	#label MDiplomats
	#completewith nomorekid
    .xp <28,1
    .goto StormwindClassic,41.5,31.7
	>>和巡逻的孩子谈谈
    .accept 1274 >> 接受失踪的外交官
step
    .goto StormwindClassic,39.7,27.6
    .turnin -293 >> 轮流清洁眼睛
step
	#label nomorekid
	#requires MDiplomats
	.zone Stormwind City >> 离开教堂
step << Human Paladin
    .goto StormwindClassic,39.8,30.1
    >>与Duthorian Rall对话，点击提供的神圣之门
    .accept 1642 >>接受神性之父
    .turnin 1642 >>交上神性之父
    .accept 1643 >>接受神性之父
step << Warlock
    .goto StormwindClassic,25.3,78.7
	.trainer >> 训练你的职业咒语
step
    .itemcount 2794,1
    >> 前往暴风谷
	.goto StormwindClassic,74.1,7.6
    .accept 337 >> 接受旧历史书
    .turnin 337 >> 交出一本旧历史书
step
    .isQuestTurnedIn 337
    .goto StormwindClassic,74.1,7.6
    .accept 538 >> 接受Southshore
step
    .isOnQuest 1274
    .goto StormwindClassic,78.1,25.1
    .turnin 1274 >> 交出失踪的外交官
    .accept 1241 >> 接受失踪的外交官
step << Hunter
    .goto StormwindClassic,72.8,16.1
    .turnin 563 >> 移交重新分配
    .isOnQuest 563
step << Human Paladin
    .goto StormwindClassic,56.9,61.9
    .turnin 1643 >>交上神性之父
    .accept 1644 >>接受神性之父
step << Human Paladin
    .goto StormwindClassic,56.9,61.9
    .complete 1644,1
    .turnin 1644 >>交上神性之父
    .accept 1780 >>接受神性之父
step << Shaman
    .goto StormwindClassic,61.9,83.9
    .accept 10491 >> 接受空中呼叫
	.trainer >> 训练你的职业咒语
step << Warrior
	.goto StormwindClassic,78.6,45.8
	.trainer >> 上楼去。训练你的职业咒语
step << Rogue
	.goto StormwindClassic,74.6,52.8
	.trainer >> 训练你的职业咒语
step
    .isOnQuest 1241
    .goto StormwindClassic,73.1,78.3
    .turnin 1241 >> 交出失踪的外交官
    .accept 1242 >> 接受失踪的外交官
step
    .isOnQuest 1242
    .goto StormwindClassic,60.1,64.4
    .turnin 1242 >> 交出失踪的外交官
    .accept 1243 >> 接受失踪的外交官
step << Human Paladin
    .goto StormwindClassic,40.1,29.9
    .turnin 1780 >>交上神性之父
    .accept 1781 >>接受神性之父
step << Human Paladin
    .goto StormwindClassic,38.7,26.6
    .turnin 1781 >>交上神性之父
    .accept 1786 >>接受神性之父
step
	#label exit
	.goto StormwindClassic,66.2,62.1
    .fly Duskwood>> 飞到黄昏
step
	#completewith notubeandy
    .goto Duskwood,79.8,47.9
    .itemcount 4371,1
    .accept 174 >> 接受向星星看
    .turnin 174 >> 转身看星星
step
    .goto Duskwood,79.8,47.9
    .accept 175 >> 接受向星星看
    .isQuestTurnedIn 174
step
    .goto Duskwood,82.0,59.0
    .turnin 175 >> 转身看星星
    .accept 177 >> 接受向星星看
    .isQuestTurnedIn 174
step
    .goto Duskwood,80.9,71.8
    >>在教堂杀死疯狂的食尸鬼
    .complete 177,1 --Collect Mary's Looking Glass (x1)
    .isQuestTurnedIn 174
	.unitscan Insane Ghoul
step
    .goto Duskwood,79.8,47.8
    .turnin 177 >> 转身看星星
    .accept 181 >> 接受向星星看
    .isQuestTurnedIn 174
step
	#label notubeandy
    .goto Duskwood,73.8,44.5
    .turnin 156 >> 转入采集腐烂花朵
    .accept 159 >> 接受果汁配送
step
    .home >> 将您的炉石设置为Darkshire
step << !Hunter !Paladin
    .goto Duskwood,73.7,46.8
    .turnin 57 >> 上夜班
    .accept 58 >> 接受夜间监视
    .turnin 228 >> 交给莫拉迪姆
    .accept 229 >> 接受活着的女儿
step << Paladin/Hunter
    .goto Duskwood,73.7,46.8
    .turnin 57 >> 上夜班
    .accept 58 >> 接受夜间监视
step << !Hunter !Paladin
	.goto Duskwood,73.7,46.8
    .turnin 228 >> 交给莫拉迪姆
    .accept 229 >> 接受活着的女儿
step << !Hunter !Paladin
    .goto Duskwood,74.5,46.1
    .turnin 229 >> 交出活着的女儿
    .accept 231 >> 接受女儿的爱
step
    .isOnQuest 1243
    .goto Duskwood,72.6,33.9
    .turnin 1243 >> 交出失踪的外交官
    .accept 1244 >> 接受失踪的外交官
step
    .goto Duskwood,60.8,29.7
    .complete -173,1 --Kill Nightbane Shadow Weaver (x6)
step
    .goto Elwynn Forest,84.6,69.5
	>> 向北行驶至埃尔文森林的伊斯特维尔伐木营
    .turnin 74 >> 交出《种马传奇》
    .accept 75 >> 接受Stalvan的传说
step
    .goto Elwynn Forest,85.6,69.6
    >>上楼抢劫箱子
    .complete 75,1 --Collect A Faded Journal Page (x1)
step
    .goto Elwynn Forest,84.7,69.4
    .turnin 75 >> 交出《种马传奇》
    .accept 78 >> 接受Stalvan的传说
step << Human !Paladin !Warlock tbc
	#level 30
	.goto Elwynn Forest,84.2,65.2
	.train 148 >> 乘坐火车并购买您的坐骑。
	.money <35.00
step << Shaman
    #completewith next
    .hs >> 赫斯到达克希尔
step << Shaman
    .goto Duskwood,73.9,44.5
    .turnin 78 >> 交出《种马传奇》
    .accept 79 >> 接受Stalvan的传说
step << Shaman
    .goto Duskwood,73.6,46.7
    .turnin 79 >> 交出《种马传奇》
    .accept 80 >> 接受Stalvan的传说
step << Shaman
    .goto Duskwood,72.6,46.9
    .turnin 80 >> 交出《种马传奇》
    .accept 97 >> 接受Stalvan的传说
step << Shaman
    .goto Duskwood,73.5,46.8
    .turnin 97 >> 交出《种马传奇》
    .accept 98 >> 接受Stalvan的传说
step << Shaman
    #sticky
	#label TearT
	.goto Duskwood,78.4,35.9
    >>在地上找一朵小花
    .complete 335,1 --Collect Tear of Tilloa (x1)
    .isOnQuest 335
step << Shaman
    .goto Duskwood,77.4,36.1
	>> 杀死房子里的亡灵，并抢夺他的戒指
    .complete 98,1 --Collect Mistmantle Family Ring (x1)
step << Shaman
    #requires TearT
	.goto Duskwood,75.7,45.3
    .turnin 98 >> 交出《种马传奇》
step << Shaman
    #completewith next
	.goto Duskwood,77.6,44.6
    .fly Westfall>> 飞往威斯特福尔
step << Human Paladin
    .goto Elwynn Forest,72.7,51.5
    >>在亨泽·福克身上使用生命的象征
    .turnin 1786 >>交上神性之父
    .accept 1787 >>接受神性之父
step << Human Paladin
    .goto Elwynn Forest,73.5,51.3
    >>杀死岛上的德菲亚斯巫师
    .complete 1787,1 --Defias Script (1)
step
    .goto Duskwood,28.0,31.6
	>> 返回Duskwood
    .turnin 159 >> 交付果汁
    .accept 133 >> 接受食尸鬼雕像
step
	#sticky
	#completewith HistoryB4
	>>留意旧历史书（全区掉落）。你以后需要这个
	.collect 2794,1,337
	.accept 337 >> 接受旧历史书
step
    .goto Duskwood,23.6,35.0
	>> 杀死地穴中的瘟疫传播者并将其洗劫一空
    .complete 133,1 --Collect Ghoul Rib (x7)
    .complete 58,1 --Kill Plague Spreader (x20)
    .complete 101,1 --Collect Ghoul Fang (x10)
step
    .goto Duskwood,28.0,31.5
    .turnin 133 >> 交上食尸鬼雕像
    .accept 134 >> 接受食人贼
step
    .goto Duskwood,23.9,72.0
    >>在小房子里抢劫箱子
    .complete 1244,1 --Collect Defias Docket (x1)
step
    .goto Duskwood,33.5,76.3
    >>抢劫洞穴入口旁边的板条箱
    .complete 134,1 --Collect Abercrombie's Crate (x1)
step
    .goto Duskwood,36.8,83.8
    .isOnQuest 181
    >>杀死Zzarc’Vul并为他的单片眼镜抢劫他
	.unitscan Zzarc'Vul
    .complete 181,1 --Collect Ogre's Monocle (x1)
step
    .goto Duskwood,31.6,45.4
	>> 杀死蜘蛛并掠夺它们的毒液
    .complete 101,2 --Collect Vial of Spider Venom (x5)
step
    .goto Duskwood,28.1,31.5
    .turnin 134 >> 收缴食人贼
    .accept 160 >> 接受市长的通知
step << !Hunter !Paladin
    .goto Duskwood,17.7,29.2
    >> 单击墓碑
    .turnin 231 >> 交出女儿的爱
step << !Dwarf/!Paladin
    .goto Duskwood,7.8,34.1
    .turnin 325 >> 缴械并准备就绪
    .accept 55 >> 接受Morbent Fel
step << !Dwarf/!Paladin
    .goto Duskwood,17.2,33.4
    >>使用提供的副手武器削弱莫本特·费尔
    .complete 55,1 --Kill Weakened Morbent Fel (x1)
step << !Dwarf/!Paladin
    .goto Duskwood,7.8,34.3
    .turnin 55 >> 转入Morbent Fel
step << Shaman/Dwarf Paladin/wotlk
    #sticky
    #completewith ds1
    .hs >> 赫斯到达克希尔
step << !Shaman !Paladin/!Dwarf Paladin
    .goto Westfall,56.5,52.6
    >>如果你的HS处于冷却状态，请飞往Darkhire << wotlk
    .fly Darkshire>> 飞到Darkhire
    .cooldown item,6948,<1 << wotlk
step
    .goto Duskwood,79.8,47.9
    .isOnQuest 181
    .turnin 181 >> 转身看星星
step
    .goto Duskwood,75.3,47.9
    .turnin 173 >> 在树林里交沃根
    .accept 221 >> 接受森林里的狼人
step
    #label ds1
    .goto Duskwood,75.7,45.3
    .turnin 101 >> 交出铭文图腾
step << !Shaman
    .goto Duskwood,73.9,44.5
    .turnin 78 >> 交出《种马传奇》
    .accept 79 >> 接受Stalvan的传说
step
    .goto Duskwood,73.6,46.7
    .turnin 58 >> 上夜班
    .turnin 79 >> 交出《种马传奇》 << !Shaman
    .accept 80 >> 接受Stalvan的传说 << !Shaman
step << !Shaman
    .goto Duskwood,72.6,46.9
    .turnin 80 >> 交出《种马传奇》
    .accept 97 >> 接受Stalvan的传说
step
    .goto Duskwood,71.9,46.6
    .turnin 160 >> 向市长提交便条
    .accept 251 >> 接受翻译Abercrombie的笔记
step
    .goto Duskwood,72.6,47.7
    .turnin 251 >> 交上Translate Abercrombie的笔记
    .accept 401 >> 接受等待Sirra完成
    .turnin 401 >> 转入等待Sirra完成
    .accept 252 >> 接受Ello的翻译
step
    .goto Duskwood,71.9,46.6
    .turnin 252 >> 将翻译交给Ello
    .accept 253 >> 接受刽子手新娘
step
	#sticky
	#completewith next
	.destroy 3248 >> 你可以从你的包中删除“来自防腐者的翻译信”，因为它不再需要了
step << !Shaman
    .goto Duskwood,73.5,46.8
    .turnin 97 >> 交出《种马传奇》
    .accept 98 >> 接受Stalvan的传说
step
    .isOnQuest 1244
    .goto Duskwood,72.6,33.9
    .turnin 1244 >> 交出失踪的外交官
    .accept 1245 >> 接受失踪的外交官
step << !Shaman
    .goto Duskwood,77.4,36.1
    .complete 98,1 --Collect Mistmantle Family Ring (x1)
step << !Shaman
    .goto Duskwood,78.4,35.9
    >>在地上找一朵小花
    .complete 335,1 --Collect Tear of Tilloa (x1)
    .isOnQuest 335
step << !Shaman
    .goto Duskwood,75.7,45.3
    .turnin 98 >> 交出《种马传奇》
step
    .goto Duskwood,64.7,49.7
    .complete 221,1 --Kill Nightbane Dark Runner (x12)
step
    .goto Duskwood,75.3,48.1
    .turnin 221 >> 在树林里交沃根
    .accept 222 >> 接受森林里的狼人
step
    #label HistoryB4
	.goto Duskwood,73.0,75.0
    .complete 222,1 --Kill Nightbane Vile Fang (x8)
    .complete 222,2 --Kill Nightbane Tainted One (x8)
step
    .goto Stranglethorn Vale,38.2,4.1
    .fp Rebel >> 获取叛军营地的飞行路线
step
	#sticky
	#completewith thorsen
	    .goto Stranglethorn Vale,40.4,8.4,0
	>>当你进行任务时，注意二等兵托森的RP活动，他每隔约30分钟巡查一次
	.accept 215 >> 接受丛林秘密
step
    .goto Stranglethorn Vale,35.6,10.5
    .accept 583 >> 接受欢迎来到丛林
step
    .goto Stranglethorn Vale,35.7,10.8
    .turnin 583 >> 上车欢迎来到丛林
    .accept 185 >> 接受老虎精通
    .accept 190 >> 接受黑豹精通
step
	#sticky
	#completewith thorsen
	#label tigers
    .complete 185,1 --Kill Young Stranglethorn Tiger (x10)
step
    .goto Stranglethorn Vale,42.1,11.2
    .complete 190,1 --Kill Young Panther (x10)
step
	#requires tigers
	#label thorsen
    .goto Stranglethorn Vale,35.6,10.6
    .turnin 185 >> 上交老虎精通
    .accept 186 >> 接受老虎精通
    .turnin 190 >> 交出黑豹大师
    .accept 191 >> 接受黑豹精通
step
    .goto Duskwood,28.8,30.9
    >>跑回Duskwood，点击土丘召唤Eliza
    .complete 253,1 --Collect The Embalmer's Heart (x1)
step << Druid
    >>传送至Moonglade
    .goto Moonglade,52.4,40.6
    .trainer 12042 >> 火车咒语
step << !Dwarf/!Paladin
    #sticky
    #completewith next
    .hs >> 赫斯到达克希尔
step << Dwarf Paladin
    .goto Duskwood,7.8,34.1
    .turnin 325 >> 缴械并准备就绪
    .accept 55 >> 接受Morbent Fel
step << Dwarf Paladin
    .goto Duskwood,17.2,33.4
    >>使用提供的副手武器削弱莫本特·费尔
    .complete 55,1 --Kill Weakened Morbent Fel (x1)
step << Dwarf Paladin
    .goto Duskwood,7.8,34.3
    .turnin 55 >> 转入Morbent Fel
step << Dwarf Paladin
    .goto Westfall,56.5,52.6,12
    .fly Darkshire>> 飞到Darkhire
step
    .goto Duskwood,72.0,46.6
    .turnin 253 >> 交给防腐工的新娘
step
    .goto Duskwood,75.7,47.6
    .turnin 222 >> 在树林里交沃根
    .accept 223 >> 接受森林里的狼人
step
    .goto Duskwood,75.3,48.9
    .turnin 223 >> 在树林里交沃根
step << !Mage
	.goto Duskwood,77.5,44.2
    .fly Stormwind>> 飞到暴风城
step << Mage
	>> Teleport到stormwind
    .goto StormwindClassic,39.6,79.6
	.trainer >> 训练你的职业咒语
step << Dwarf Paladin
    #sticky
	#completewith next
    >>从拍卖行购买10块亚麻布
    .complete 1648,1
step
    .isOnQuest 1245
    .goto StormwindClassic,60.1,64.4
    .turnin 1245 >> 交出失踪的外交官
    .accept 1246 >> 接受失踪的外交官
step << Paladin
	.goto StormwindClassic,38.6,32.8
	.trainer >> 训练你的职业咒语
step << Priest
	.goto StormwindClassic,38.5,26.8
	.trainer >> 训练你的职业咒语
step << Warrior
    #sticky
    #completewith next
    .goto StormwindClassic,64.1,61.2
    .goto StormwindClassic,46.7,79.0
    >>检查AH、贸易区的花店和法师区的炼金术店，并购买一些生命根，稍后你需要8个才能完成任务，如果你已经拥有了，跳过这一步
    .collect 3357,8 --Collect Liferoot (x8)
    #xprate <1.5
step << Warrior
    .goto StormwindClassic,78.8,45.3
    .accept 1718 >> 接受岛民
	.trainer >> 训练类咒语
step << Shaman
    .goto StormwindClassic,61.9,83.9
	.trainer >> 训练你的职业咒语
step << Rogue
	.goto StormwindClassic,74.6,52.8
	.trainer >> 训练你的职业咒语
step
    .isOnQuest 1246
    .goto StormwindClassic,70.3,44.8
    >>击败Dashel Stonefist
    .turnin 1246 >> 交出失踪的外交官
step
    .isQuestTurnedIn 1246
    .goto StormwindClassic,70.3,44.8
    .accept 1447 >> 接受失踪的外交官
    .turnin 1447 >> 交出失踪的外交官
step
    .isQuestTurnedIn 1447
    .goto StormwindClassic,70.3,44.8
    .accept 1247 >> 接受失踪的外交官
step
    .isOnQuest 1247
    .goto StormwindClassic,60.1,63.9
    .turnin 1247 >> 交出失踪的外交官
    .accept 1248 >> 接受失踪的外交官
step
   	#sticky
	#completewith next
	.goto StormwindClassic,55.4,68.3,20 >> 如果需要，请在这里存款
step
    .goto StormwindClassic,39.9,81.3
    .accept 690 >> 接受Malin的请求
step
    .goto StormwindClassic,40.6,91.7
    .accept 1301 >> 接受James Hyal
step
    .goto StormwindClassic,26.4,78.3
    .turnin 335 >> 上交高贵的啤酒
    .isQuestComplete 335
step
    .goto StormwindClassic,26.4,78.3
    .accept 336 >> 接受高贵的酿造
    .isQuestTurnedIn 335
step << Warlock
    .goto StormwindClassic,25.3,78.5
    .accept 4738 >>接受以搜索Menara Voidrender
    .xp <31,1
step << Warlock
    .goto StormwindClassic,25.3,78.5
    .accept 1798 >>接受寻找斯特拉哈德
	.trainer >> 训练你的职业咒语
step << Human Paladin
    .goto StormwindClassic,38.6,26.7
    .turnin 1787 >>交上神性之父
    .accept 1788 >>接受神性之父
step << Human Paladin
    .goto StormwindClassic,39.9,29.8
    .turnin 1788 >>交上神性之父
step
    .goto StormwindClassic,74.3,30.3
    .accept 543 >> 接受Perenolde Tiara
step
    .goto StormwindClassic,75.1,31.4
    .turnin 336 >> 上交高贵的啤酒
    .isOnQuest 336
step
    .goto StormwindClassic,74.1,7.6
    .accept 337 >> 接受旧历史书
    .turnin 337 >> 交出一本旧历史书
    .accept 538 >> 接受Southshore
step << Dwarf Paladin/Mage
    #sticky
	#completewith next
    .zone Ironforge >> 前往铁炉堡
step << Dwarf Paladin
    .goto Ironforge,18.5,51.6
    .home >>将HS设置为Ironforge
step << Dwarf Paladin
    .goto Ironforge,23.3,6.1
    .accept 2999 >>接受神之汤姆
step << Dwarf Paladin
    .goto Ironforge,27.4,12.1
    >>上楼去和蒂扎战斗堡垒通话
    .turnin 2999 >>交给神之汤姆
    .accept 1645 >>接受神性之父
    .turnin 1645 >>交上神性之父
    .accept 1646 >>接受神性之父
    .turnin 1646 >>交上神性之父
    .accept 1647 >>接受神性之父
step << Dwarf Paladin
    >>与约翰·特纳交谈，他在城市的外环漫步
    .turnin 1647 >>交上神性之父
    .accept 1648 >>接受神性之父
    .turnin 1648 >>交上神性之父
    .accept 1778 >>接受神性之父
step << Dwarf Paladin
    .goto Ironforge,27.7,12.3
    >>返回Tiza Battleforge
    .turnin 1778 >>交上神性之父
    .accept 1779 >>接受神性之父
step << Dwarf Paladin
    .goto Ironforge,23.6,8.6
    >>与缪尔登·巴特尔福格交谈
    .turnin 1779 >>交上神性之父
    .accept 1783 >>接受神性之父
step << Dwarf Paladin
    #completewith next
    .goto Dun Morogh,53.2,35.3
    .zone Dun Morogh >> 前往Dun Morogh
step << Dwarf Paladin
    .goto Dun Morogh,78.3,58.1
    >>在纳姆·福克身上使用生命的象征
    .turnin 1783 >>交上神性之父
    .accept 1784 >>接受神性之父
step << Dwarf Paladin
    .goto Dun Morogh,77.3,60.5
    >>杀死黑铁间谍
    .complete 1784,1 --Dark Iron Script (1)
step << Dwarf Paladin
    #completewith next
    .hs >> 炉到铁炉
step << Dwarf Paladin
    .goto Ironforge,23.6,8.5
    >>和楼上的缪尔登谈谈
    .turnin 1784 >>交上神性之父
    .accept 1785 >>接受神性之父
step << Dwarf Paladin
    .goto Ironforge,27.4,11.9
    .turnin 1785 >>交上神性之父
step << Dwarf !Paladin tbc
	.skill riding,75,1
	.money <35.0
	.goto StormwindClassic,66.2,62.2
	.fly Ironforge >> 飞到铁炉堡，我们要训练我们的坐骑。
step << Dwarf !Paladin tbc
	.money <35.0
	.goto Dun Morogh,63.5,50.6
	.train 152 >> 坐火车，买你的坐骑
step << Gnome !Warlock tbc
	.skill riding,75,1
	.money <35.0
	.goto StormwindClassic,66.2,62.2
	.fly Ironforge >> 飞到铁炉堡，我们要训练我们的坐骑。
step << Gnome !Warlock tbc
	.money <35.0
	.goto Dun Morogh,49.2,48.1
	.train 553 >> 坐火车，买你的坐骑
step << Gnome !Warlock/Dwarf
	.zoneskip Wetlands
	.skill riding,75,1
	.goto Ironforge,55.5,47.2
	.fly Wetlands>> 飞到湿地
step << !Gnome Warlock/!Dwarf
	.skill riding,<75,1
	.zoneskip Wetlands
	.goto StormwindClassic,66.2,62.2
	.fly Wetlands>> 飞到湿地
step << Gnome !Warlock/Dwarf !Paladin
	.zoneskip Wetlands
	.goto StormwindClassic,66.2,62.2
	.fly Wetlands>> 飞到湿地
step
    .goto Wetlands,10.6,60.7
    .home >> 将您的炉石设置为湿地
step
    .isOnQuest 1248
    .goto Wetlands,10.6,60.7
    .turnin 1248 >> 交出失踪的外交官
    .accept 1249 >> 接受失踪的外交官
step
    >>一旦你接受了任务，你必须在Tapoke Jhan试图逃离客栈时与他交战
    .complete 1249,1 --Defeat Tapoke Jahn
step
    .isOnQuest 1249
    .goto Wetlands,10.6,60.7
    .turnin 1249 >> 交出失踪的外交官
step
    .isOnQuest 1250
    .goto Wetlands,10.6,60.3
    .accept 1250 >> 接受失踪的外交官
step
    .isOnQuest 1250
    .goto Wetlands,10.6,60.7
    .turnin 1250 >> 交出失踪的外交官
    .accept 1264 >> 接受失踪的外交官
step
    .goto Wetlands,8.4,61.6
    .turnin 1301 >> 交给詹姆斯·海尔
    .accept 1302 >> 接受James Hyal
step << Draenei !Shaman tbc
	.goto Wetlands,4.8,57.3,50,0
	.goto Darkshore,31.0,41.1,30.0
	.goto The Exodar,81.5,52.5,40,0
	.goto Wetlands,5.2,63.3,50,0
	.money <35.00
	>> 乘船去Darkshore，然后乘船去Exodar，买你的坐骑。否则跳过此步骤
	.hs >>然后前往米奈希尔港，乘船前往塞拉莫尔。
step << NightElf tbc
	.goto Wetlands,4.8,57.3,50,0
	.goto Darkshore,33.1,40.3,30,0
	.goto Darnassus,38.1,15.3,30,0
	.goto Wetlands,5.2,63.3,50,0
	.money <35.00
	.train 150 >> 乘船去达克肖，然后去达纳苏斯，买你的坐骑。
	.hs >> 然后返回米奈希尔港，乘船前往塞拉莫尔。
step << Shaman
    #sticky
    #completewith next
    .zone The Exodar >> 乘小船去Darkshore，然后去Exodar。
    >>如果您有35g，请购买坐骑并进行训练，否则请跳过此步骤。 << tbc
	.goto The Exodar,81.5,52.5,40,0
step << Shaman
    .goto The Exodar,29.9,33.0
    .turnin 10491 >> 接通空中通话
    .accept 9552 >> 接受空中呼叫
step << Shaman
    #completewith next
    .fly Bloodmyst Isle>> 飞往血腥岛
step << Shaman
    .goto Bloodmyst Isle,32.3,16.2
    .turnin 9504 >> 水的召唤
    .accept 9508 >> 接受水的召唤
step << Shaman
    .goto Bloodmyst Isle,26.0,40.9
	>>杀死Tel’athion并抢劫他的头
    .complete 9508,1 --Collect Head of Tel'athion (x1)
step << Shaman
    .goto Bloodmyst Isle,32.2,16.1
    .turnin 9508 >> 水的召唤
    .accept 9509 >> 接受水的召唤
step << Shaman
	#sticky
	#completewith ZExodar
	.deathskip >> 淹没自己和灵魂rez
step << Shaman
	#sticky
	#completewith next
	.goto Bloodmyst Isle,57.7,53.9
	>>跑回血腥观察站，然后飞到外族人
    .fly The Exodar>> 飞到外族人
step << Shaman
	#label ZExodar
	.zone The Exodar >> 前往外族
step << Shaman
    .goto Azuremyst Isle,26.8,27.3,42
    >>从主入口离开Exodar，沿着山向左行进，直到到达荒风小道
step << Shaman
    .goto Azuremyst Isle,24.9,35.9
    .turnin 9552 >> 接通空中通话
    .accept 9553 >> 接受空中呼叫
step << Shaman
    .goto Azuremyst Isle,22.3,32.5
    .turnin 9553 >> 接通空中通话
    .accept 9554 >> 接受空中呼叫
step << Shaman
    #sticky
    #completewith next
    .zone The Exodar>>再和苏苏罗斯谈谈，这样他就可以把你送回去了
step << Shaman
    .goto The Exodar,30.0,33.1
    .turnin 9509 >> 水的召唤
step << Shaman
    .goto The Exodar,29.6,33.4
    .turnin 9554 >> 接通空中通话
	>>这将给你一个1小时长的buff，提供40%的移动速度和30%的攻击速度。小心不要AFK
step << Shaman
    .hs >> 炉膛到湿地
]])

--1.5x guides:


RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Alliance
#name 28-30 暮色森林
#version 1
#group RestedXP 联盟 20-32
#next 30-32 希尔斯布莱德丘陵
#xprate >1.3
step
    #sticky
    #completewith exit
    >>从拍卖行购买铜管
    .complete 174,1
	.bronzetube
step << Paladin
    .goto StormwindClassic,40.0,29.9
    .turnin 1652 >>交给勇敢的人
    .accept 1653 >>接受正义的考验
step << Paladin
	.goto StormwindClassic,38.6,32.8
	.trainer >> 训练你的职业咒语
step << Priest
	.goto StormwindClassic,38.5,26.8
	.trainer >> 训练你的职业咒语
step
    .goto StormwindClassic,39.3,28.0
    .turnin 269 >> 转向寻求智慧
    .accept 270 >> 接受末日舰队
step
    .isOnQuest 322
    .goto StormwindClassic,51.7,12.3
    .turnin 322 >> 交给上帝的手臂
    .accept 325 >> 接受武装并准备就绪
step
	#sticky
	#label MDiplomats
	#completewith nomorekid
    .xp <28,1
    .goto StormwindClassic,41.5,31.7
	>>和巡逻的孩子谈谈
    .accept 1274 >> 接受失踪的外交官
step
    .goto StormwindClassic,39.7,27.6
    .turnin -293 >> 轮流清洁眼睛
step
	#label nomorekid
	#requires MDiplomats
	.zone Stormwind City >> 离开教堂
step << Human Paladin
    .goto StormwindClassic,39.8,30.1
    >>与Duthorian Rall对话，点击提供的神圣之门
    .accept 1642 >>接受神性之父
    .turnin 1642 >>交上神性之父
    .accept 1643 >>接受神性之父
step << Warlock
    .goto StormwindClassic,25.3,78.7
	.trainer >> 训练你的职业咒语
step
   .isOnQuest 337
	.goto StormwindClassic,74.1,7.6
    .accept 337 >> 接受旧历史书
    .turnin 337 >> 交出一本旧历史书
    .accept 538 >> 接受Southshore
step
    .isOnQuest 1274
    .goto StormwindClassic,78.1,25.1
    .turnin 1274 >> 交出失踪的外交官
    .accept 1241 >> 接受失踪的外交官
step << Hunter
    .goto StormwindClassic,72.8,16.1
    .turnin 563 >> 移交重新分配
    .isOnQuest 563
step << Human Paladin
    #completewith linen
    >>如果你还没有，就去拍卖行买10块亚麻布
    .collect 2589,10,1644,1
step << Human Paladin
    .goto StormwindClassic,56.9,61.9
    .turnin 1643 >>交上神性之父
    .accept 1644 >>接受神性之父
step << Human Paladin
    #label linen
    .goto StormwindClassic,56.9,61.9
    .complete 1644,1
    .turnin 1644 >>交上神性之父
    .accept 1780 >>接受神性之父
step << Warrior
	.goto StormwindClassic,78.6,45.8
	.trainer >> 上楼去。训练你的职业咒语
step << Rogue
	.goto StormwindClassic,74.6,52.8
	.trainer >> 训练你的职业咒语
step
    .isOnQuest 1241
    .goto StormwindClassic,73.1,78.3
    .turnin 1241 >> 交出失踪的外交官
    .accept 1242 >> 接受失踪的外交官
step
    .isOnQuest 1242
    .goto StormwindClassic,60.1,64.4
    .turnin 1242 >> 交出失踪的外交官
    .accept 1243 >> 接受失踪的外交官
step << Human Paladin
    .goto StormwindClassic,40.1,29.9
    .turnin 1780 >>交上神性之父
    .accept 1781 >>接受神性之父
step << Human Paladin
    .goto StormwindClassic,38.7,26.6
    .turnin 1781 >>交上神性之父
    .accept 1786 >>接受神性之父
step
	#label exit
	.goto StormwindClassic,66.2,62.1
    .fly Duskwood>> 飞到黄昏
step
    #completewith next
    .skill riding,75 >>如果您在这台服务器上有更多黄金，请给自己邮寄至少5枚黄金，我们很快就会购买坐骑。
    .money >5.00
step
	#completewith notubeandy
    .goto Duskwood,79.8,47.9
    .itemcount 4371,1
    .accept 174 >> 接受向星星看
    .turnin 174 >> 转身看星星
step
    .goto Duskwood,79.8,47.9
    .accept 175 >> 接受向星星看
    .isQuestTurnedIn 174
step
    .goto Duskwood,82.0,59.0
    .turnin 175 >> 转身看星星
    .accept 177 >> 接受向星星看
    .isQuestTurnedIn 174
step
    .goto Duskwood,80.9,71.8
    >>在教堂杀死疯狂的食尸鬼
    .complete 177,1 --Collect Mary's Looking Glass (x1)
    .isQuestTurnedIn 174
	.unitscan Insane Ghoul
step
    .goto Duskwood,79.8,47.8
    .turnin 177 >> 转身看星星
    .accept 181 >> 接受向星星看
    .isQuestTurnedIn 174
step
	#label notubeandy
    .goto Duskwood,73.8,44.5
    .turnin 156 >> 转入采集腐烂花朵
    .accept 159 >> 接受果汁配送
step << !NightElf !Draenei
    .home >> 将您的炉石设置为Darkshire
step << Shaman
    .home >> 将您的炉石设置为Darkshire
step << !Hunter !Paladin
    .goto Duskwood,73.7,46.8
    .turnin 57 >> 上夜班
    .accept 58 >> 接受夜间监视
    .turnin 228 >> 交给莫拉迪姆
    .accept 229 >> 接受活着的女儿
step << Paladin/Hunter
    .goto Duskwood,73.7,46.8
    .turnin 57 >> 上夜班
    .accept 58 >> 接受夜间监视
step << !Hunter !Paladin
	.goto Duskwood,73.7,46.8
    .turnin 228 >> 交给莫拉迪姆
    .accept 229 >> 接受活着的女儿
step << !Hunter !Paladin
    .goto Duskwood,74.5,46.1
    .turnin 229 >> 交出活着的女儿
    .accept 231 >> 接受女儿的爱
step
    .isOnQuest 1243
    .goto Duskwood,72.6,33.9
    .turnin 1243 >> 交出失踪的外交官
    .accept 1244 >> 接受失踪的外交官
step
    .goto Duskwood,60.8,29.7
    .complete -173,1 --Kill Nightbane Shadow Weaver (x6)
step
    .goto Elwynn Forest,84.6,69.5
	>> 向北行驶至埃尔文森林的伊斯特维尔伐木营
    .turnin 74 >> 交出《种马传奇》
    .accept 75 >> 接受Stalvan的传说
step
    .goto Elwynn Forest,85.6,69.6
    >>上楼抢劫箱子
    .complete 75,1 --Collect A Faded Journal Page (x1)
step
    .goto Elwynn Forest,84.7,69.4
    .turnin 75 >> 交出《种马传奇》
    .accept 78 >> 接受Stalvan的传说
step << Human !Paladin !Warlock tbc
	#level 30
	.goto Elwynn Forest,84.2,65.2
	.train 148 >> 乘坐火车并购买您的坐骑。
	.money <35.00
step << Human !Paladin !Warlock wotlk
	.goto Elwynn Forest,84.2,65.2
	.train 148 >> 乘坐火车并购买您的坐骑。
	.money <5.00
step << Shaman
    #completewith next
    .hs >> 赫斯到达克希尔
step << Shaman
    .goto Duskwood,73.9,44.5
    .turnin 78 >> 交出《种马传奇》
    .accept 79 >> 接受Stalvan的传说
step << Shaman
    .goto Duskwood,73.6,46.7
    .turnin 79 >> 交出《种马传奇》
    .accept 80 >> 接受Stalvan的传说
step << Shaman
    .goto Duskwood,72.6,46.9
    .turnin 80 >> 交出《种马传奇》
    .accept 97 >> 接受Stalvan的传说
step << Shaman
    .goto Duskwood,73.5,46.8
    .turnin 97 >> 交出《种马传奇》
    .accept 98 >> 接受Stalvan的传说
step << Shaman
    #sticky
	#label TearT
	.goto Duskwood,78.4,35.9
    >>在地上找一朵小花
    .complete 335,1 --Collect Tear of Tilloa (x1)
    .isOnQuest 335
step << Shaman
    .goto Duskwood,77.4,36.1
	>> 杀死房子里的亡灵，并抢夺他的戒指
    .complete 98,1 --Collect Mistmantle Family Ring (x1)
step << Shaman
    #requires TearT
	.goto Duskwood,75.7,45.3
    .turnin 98 >> 交出《种马传奇》
step << Shaman
    #completewith next
	.goto Duskwood,77.6,44.6
    .fly Westfall>> 飞往威斯特福尔
step << Human Paladin
    .goto Elwynn Forest,72.7,51.5
    >>在亨泽·福克身上使用生命的象征
    .turnin 1786 >>交上神性之父
    .accept 1787 >>接受神性之父
step << Human Paladin
    .goto Elwynn Forest,73.5,51.3
    >>杀死岛上的德菲亚斯巫师
    .complete 1787,1 --Defias Script (1)
step
    .goto Duskwood,28.0,31.6
	>> 返回Duskwood
    .turnin 159 >> 交付果汁
    .accept 133 >> 接受食尸鬼雕像
step
	#sticky
	#completewith HistoryB4
	>>留意旧历史书（全区掉落）。你以后需要这个
	.collect 2794,1,337
	.accept 337 >> 接受旧历史书
step
    .goto Duskwood,23.6,35.0
	>> 杀死地穴中的瘟疫传播者并将其洗劫一空
    .complete 133,1 --Collect Ghoul Rib (x7)
    .complete 58,1 --Kill Plague Spreader (x20)
    .complete 101,1 --Collect Ghoul Fang (x10)
step
    .goto Duskwood,28.0,31.5
    .turnin 133 >> 交上食尸鬼雕像
    .accept 134 >> 接受食人贼
step
    .goto Duskwood,23.9,72.0
    >>在小房子里抢劫箱子
    .complete 1244,1 --Collect Defias Docket (x1)
step
    .goto Duskwood,33.5,76.3
    >>抢劫洞穴入口旁边的板条箱
    .complete 134,1 --Collect Abercrombie's Crate (x1)
step
    .goto Duskwood,36.8,83.8
    >>杀死Zzarc’Vul并为他的单片眼镜抢劫他
	.unitscan Zzarc'Vul
    .isOnQuest 181
    .complete 181,1 --Collect Ogre's Monocle (x1)
step
    .goto Stranglethorn Vale,38.2,4.1
    >>走出洞穴，然后向南到STV。或者跳到横幅上跳过注销。
    .link https://www.youtube.com/watch?v=i5dIhfOmyd8 >> 单击此处观看如何跳过注销的视频
    .fp Rebel >> 获取叛军营地的飞行路线
step
    .goto Duskwood,31.6,45.4
	>> 杀死蜘蛛并掠夺它们的毒液
    .complete 101,2 --Collect Vial of Spider Venom (x5)
step
    .goto Duskwood,28.1,31.5
    .turnin 134 >> 收缴食人贼
    .accept 160 >> 接受市长的通知
step << !Hunter !Paladin
    .goto Duskwood,17.7,29.2
    >> 单击墓碑
    .turnin 231 >> 交出女儿的爱
step << Shaman tbc/Dwarf Paladin tbc/wotlk
    #sticky
    #completewith ds2
    .hs >> 赫斯到达克希尔
step
#completewith next
    .goto Westfall,56.5,52.6
    >>如果你的HS处于冷却状态，请飞往Darkhire << wotlk
    .fly Darkshire>> 飞到Darkhire
    .cooldown item,6948,<1 << wotlk
step
    .goto Duskwood,79.8,47.9
    .isOnQuest 181
    .turnin 181 >> 转身看星星
step
    .goto Duskwood,75.3,47.9
    .turnin 173 >> 在树林里交沃根
    .accept 221 >> 接受森林里的狼人
step
    #label ds2
    .goto Duskwood,75.7,45.3
    .turnin 101 >> 交出铭文图腾
step << !Shaman
    .goto Duskwood,73.9,44.5
    .turnin 78 >> 交出《种马传奇》
    .accept 79 >> 接受Stalvan的传说
step
    .goto Duskwood,73.6,46.7
    .turnin 58 >> 上夜班
    .turnin 79 >> 交出《种马传奇》 << !Shaman
    .accept 80 >> 接受Stalvan的传说 << !Shaman
step << !Shaman
    .goto Duskwood,72.6,46.9
    .turnin 80 >> 交出《种马传奇》
    .accept 97 >> 接受Stalvan的传说
step
    .goto Duskwood,71.9,46.6
    .turnin 160 >> 向市长提交便条
    .accept 251 >> 接受翻译Abercrombie的笔记
step
    .goto Duskwood,72.6,47.7
    .turnin 251 >> 交上Translate Abercrombie的笔记
    .accept 401 >> 接受等待Sirra完成
    .turnin 401 >> 转入等待Sirra完成
    .accept 252 >> 接受Ello的翻译
step
    .goto Duskwood,71.9,46.6
    .turnin 252 >> 将翻译交给Ello
    .accept 253 >> 接受刽子手新娘
step
	#sticky
	#completewith next
	.destroy 3248 >> 你可以从你的包中删除“来自防腐者的翻译信”，因为它不再需要了
step << !Shaman
    .goto Duskwood,73.5,46.8
    .turnin 97 >> 交出《种马传奇》
    .accept 98 >> 接受Stalvan的传说
step
    .isOnQuest 1244
    .goto Duskwood,72.6,33.9
    >> 他沿着北路巡逻
    .turnin 1244 >> 交出失踪的外交官
    .accept 1245 >> 接受失踪的外交官
step << !Shaman
    .goto Duskwood,77.4,36.1
    >> 杀戮并掠夺Stalvan Mistmantle
    .complete 98,1 --Collect Mistmantle Family Ring (x1)
step << !Shaman
    .isOnQuest 335
    .goto Duskwood,78.4,35.9
    >>在地上找一朵小花
    .complete 335,1 --Collect Tear of Tilloa (x1)
step << !Shaman
    .goto Duskwood,75.7,45.3
    .turnin 98 >> 交出《种马传奇》
step
    .goto Duskwood,64.7,49.7
    >> 杀死该地区的虫子
    .complete 221,1 --Kill Nightbane Dark Runner (x12)
step
    .goto Duskwood,75.3,48.1
    .turnin 221 >> 在树林里交沃根
    .accept 222 >> 接受森林里的狼人
step
    #label HistoryB4
    >> 杀死该地区的沃根
	.goto Duskwood,73.0,75.0
    .complete 222,1 --Kill Nightbane Vile Fang (x8)
    .complete 222,2 --Kill Nightbane Tainted One (x8)
step
    .xp 30-10575
step
    .goto Duskwood,75.7,47.6
    .turnin 222 >> 在树林里交沃根
    .accept 223 >> 接受森林里的狼人
step
    .goto Duskwood,75.3,48.9
    .turnin 223 >> 在树林里交沃根
step << !Mage
	.goto Duskwood,77.5,44.2
    .fly Stormwind>> 飞到暴风城
step << Shaman
    .goto StormwindClassic,61.9,83.9
    .accept 10491 >> 接受空中呼叫
    .trainer >> 训练你的职业咒语
    .xp <30,1
step << Mage
	>> Teleport到stormwind
    .goto StormwindClassic,39.6,79.6
	.trainer >> 训练你的职业咒语
step << Dwarf Paladin
    #sticky
	#completewith next
    >>从拍卖行购买10块亚麻布
    .complete 1648,1
step
    .isOnQuest 1245
    .goto StormwindClassic,60.1,64.4
    .turnin 1245 >> 交出失踪的外交官
    .accept 1246 >> 接受失踪的外交官
step << Paladin
	.goto StormwindClassic,38.6,32.8
	.trainer >> 训练你的职业咒语
step << Priest
	.goto StormwindClassic,38.5,26.8
	.trainer >> 训练你的职业咒语
step << Warrior
    #sticky
    #completewith next
    .goto StormwindClassic,64.1,61.2
    .goto StormwindClassic,46.7,79.0
    >>检查AH、贸易区的花店和法师区的炼金术店，并购买一些生命根，稍后你需要8个才能完成任务，如果你已经拥有了，跳过这一步
    .collect 3357,8 --Collect Liferoot (x8)
    #xprate <1.5
step << Warrior
    .goto StormwindClassic,78.8,45.3
    .accept 1718 >> 接受岛民
	.trainer >> 训练类咒语
    .xp <30,1
step << Rogue
	.goto StormwindClassic,74.6,52.8
	.trainer >> 训练你的职业咒语
step
    .isOnQuest 1246
    .goto StormwindClassic,70.3,44.8
    >>击败Dashel Stonefist
    .turnin 1246 >> 交出失踪的外交官
    .accept 1447 >> 接受失踪的外交官
    .turnin 1447 >> 交出失踪的外交官
    .accept 1247 >> 接受失踪的外交官
step
    .isOnQuest 1247
    .goto StormwindClassic,60.1,63.9
    .turnin 1247 >> 交出失踪的外交官
    .accept 1248 >> 接受失踪的外交官
step << NightElf/Draenei
    #completewith next
    .home >> 在暴风城设置您的炉石
step
    .goto StormwindClassic,39.9,81.3
    .accept 690 >> 接受Malin的请求
step
    .goto StormwindClassic,40.6,91.7
    .accept 1301 >> 接受James Hyal
step << Warlock
    .goto StormwindClassic,25.3,78.5
    .accept 4738 >>接受以搜索Menara Voidrender
    .xp <31,1
step << Warlock
    .goto StormwindClassic,25.3,78.5
    .accept 1798 >>接受寻找斯特拉哈德
	.trainer >> 训练你的职业咒语
step << Human Paladin
    .goto StormwindClassic,38.6,26.7
    .turnin 1787 >>交上神性之父
    .accept 1788 >>接受神性之父
step << Human Paladin
    .goto StormwindClassic,39.9,29.8
    .turnin 1788 >>交上神性之父
step
    .goto StormwindClassic,74.1,7.6
    >>点击包里的旧历史书，如果没有找到，跳过这一步
    .accept 337 >> 接受旧历史书
    .turnin 337 >> 交出一本旧历史书
    .use 2794
step
    .goto StormwindClassic,74.1,7.6
    .accept 538 >> 接受Southshore
    .isQuestTurnedIn 337
step << NightElf wotlk
	.goto Stormwind City,4.8,57.3,50,0
	.goto Darkshore,33.1,40.3,30,0
	.goto Darnassus,38.1,15.3,30,0
	.goto Wetlands,5.2,63.3,50,0
	.money <5.00
	.skill riding,75 >> 乘船去达克肖，然后去达纳苏斯，买你的坐骑。然后回到暴风城
step << Draenei !Shaman !Paladin wotlk
	.goto Stormwind City,4.8,57.3,50,0
	.goto Darkshore,31.0,41.1,30.0
	.goto The Exodar,81.5,52.5,40,0
	.goto Wetlands,5.2,63.3,50,0
	.money <5.00
	.skill riding,75 >> 乘船去Darkshore，然后乘船去Exodar，买你的坐骑。然后壁炉到暴风城
step
    #sticky
	#completewith next
    .goto StormwindClassic,60.5,12.3,40,0
    .goto StormwindClassic,60.5,12.3,0
    .link https://www.youtube.com/watch?v=M_tXROi9nMQ >> 点击此处在电车内注销跳过
    .zone Ironforge >> 坐电车到铁炉堡
    >>如果你已经训练了那个咒语，请改为传送到铁炉堡 << Mage
    .zoneskip Wetlands
step
    .goto Ironforge,69.8,50.1
    .turnin 2923 >> 交给Tinkmaster Overspark
    .isOnQuest 2923
    .zoneskip Wetlands
step << Rogue
    #sticky
    #completewith end
    .trainer >> 在铁炉训练你的职业法术
step << Rogue
    .goto Ironforge,45.2,6.6
    >>购买31级武器升级（17dps）
    .collect 2520,1
    .collect 2526,1
    >>如果你能在拍卖行找到更好的武器，跳过这一步
step << Hunter/Warrior/Paladin/Shaman/Rogue
	.goto Ironforge,61.34,89.25
	.train 197 >> 列车2H轴 << !Rogue
	.train 266 >> 训练枪 << Hunter/Warrior/Rogue
    .train 199 >> 火车2H梅斯 << Warrior/Shaman
    .train 198 >> 火车梅斯 << Rogue/Shaman
    .train 44 >> 火车轴 << Warrior wotlk/Shaman/Rogue wotlk
    .zoneskip Wetlands
step << Hunter
	#sticky
	#completewith next
	.goto Ironforge,61.34,89.25
	>>走进大楼，下楼去，从Thalgus Thunderfist那里买一个30级箭袋
	.collect 7371,1
step << !Dwarf !Gnome wotlk
    .goto Ironforge,55.5,47.7
    .fp Ironforge>> 获得铁炉堡飞行路线
step
    .goto Ironforge,18.5,51.6
    .home >>把你的炉石放在铁炉堡
step << Dwarf Paladin
    .goto Ironforge,23.3,6.1
    .accept 2999 >>接受神之汤姆
step << Dwarf Paladin
    .goto Ironforge,27.4,12.1
    >>上楼去和蒂扎战斗堡垒通话
    .turnin 2999 >>交给神之汤姆
    .accept 1645 >>接受神性之父
    .turnin 1645 >>交上神性之父
    .accept 1646 >>接受神性之父
    .turnin 1646 >>交上神性之父
    .accept 1647 >>接受神性之父
step << Dwarf Paladin
    >>与约翰·特纳交谈，他在城市的外环漫步
    .turnin 1647 >>交上神性之父
    .accept 1648 >>接受神性之父
    .turnin 1648 >>交上神性之父
    .accept 1778 >>接受神性之父
step << Dwarf Paladin
    .goto Ironforge,27.7,12.3
    >>返回Tiza Battleforge
    .turnin 1778 >>交上神性之父
    .accept 1779 >>接受神性之父
step << Dwarf Paladin
    .goto Ironforge,23.6,8.6
    >>与缪尔登·巴特尔福格交谈
    .turnin 1779 >>交上神性之父
    .accept 1783 >>接受神性之父
step << Dwarf Paladin
    #completewith next
    .goto Dun Morogh,53.2,35.3
    .zone Dun Morogh >> 前往Dun Morogh
step << Paladin
    .goto Dun Morogh,52.5,36.8
    >> 前往铁炉堡大门 << !Dwarf
    .turnin 1653 >>提交正义测试
step << Dwarf Paladin
    .goto Dun Morogh,78.3,58.1
    >>在纳姆·福克身上使用生命的象征
    .turnin 1783 >>交上神性之父
    .accept 1784 >>接受神性之父
step << Dwarf Paladin
    .goto Dun Morogh,77.3,60.5
    >>杀死黑铁间谍
    .complete 1784,1 --Dark Iron Script (1)
step << Dwarf Paladin
    #completewith next
    .hs >> 炉到铁炉
step << Dwarf Paladin
    .goto Ironforge,23.6,8.5
    >>和楼上的缪尔登谈谈
    .turnin 1784 >>交上神性之父
    .accept 1785 >>接受神性之父
step << Dwarf Paladin
    .goto Ironforge,27.4,11.9
    .turnin 1785 >>交上神性之父
step << Dwarf !Paladin tbc
	.money <35.0
	.goto Dun Morogh,63.5,50.6
	.train 152 >> 坐火车，买你的坐骑
step << Gnome !Warlock tbc
	.money <35.0
	.goto Dun Morogh,49.2,48.1
	.train 553 >> 坐火车，买你的坐骑
step << Mage
    .goto Ironforge,25.5,7.1
    .train 3562>>火车传送：铁炉堡
step << Gnome/Dwarf/tbc
    .goto Ironforge,55.5,47.7
    .fly Wetlands>> 飞到湿地
step << wotlk !Dwarf !Gnome
    #sticky
    .goto Dun Morogh,53.2,35.3
    .zone Dun Morogh >> 前往Dun Morogh
    .zoneskip Ironforge,1
step << wotlk !Dwarf !Gnome
    #completewith next
    .goto Dun Morogh,59.5,42.8,40,0
    .goto Dun Morogh,60.4,44.1,40,0
    .goto Dun Morogh,61.1,44.1,40,0
    .goto Dun Morogh,61.2,42.3,40,0
    .goto Dun Morogh,60.8,40.9,40,0
    .goto Dun Morogh,59.0,39.5,40,0
    .goto Dun Morogh,60.3,38.6,40,0
    .goto Dun Morogh,61.7,38.7,40,0
    .goto Dun Morogh,65.7,21.6,40,0
    .goto Dun Morogh,65.8,12.5,40,0
    .goto Dun Morogh,65.6,10.8,40,0
    .goto Dun Morogh,66.5,10.0,40,0
    .goto Dun Morogh,66.9,8.5,40,0
    .goto Wetlands,20.6,67.2,50,0
    .goto Wetlands,17.7,67.7,40,0
    .goto Wetlands,16.8,65.3,40,0
    .goto Wetlands,15.1,64.0,40,0
    .goto Wetlands,12.1,60.3,40,0
    >>邓莫罗不死->湿地跳过
    .link https://www.youtube.com/watch?v=9afQTimaiZQ >> 点击此处查看视频参考
    .goto Wetlands,12.1,60.3,80 >> 前往米奈希尔港
step << wotlk !Dwarf !Gnome
    .goto Wetlands,9.5,59.7
    .fp Menethil >> 获取Menethil Harbor航线
step << Dwarf !Paladin wotlk
	#sticky
	#completewith next
	.goto Dun Morogh,63.5,50.6
	.money <5.00
	.skill riding,75 >> 前往Dun Morogh，乘坐火车并购买您的坐骑。
step << Gnome !Warlock wotlk
	#sticky
	#completewith next
	.goto Dun Morogh,49.2,48.1
	.money <5.00
	.skill riding,75 >> 前往Dun Morogh，乘坐火车并购买您的坐骑。

]])


RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Alliance
#version 1
#group RestedXP 联盟 20-32
#name 30-32 希尔斯布莱德丘陵
#next RestedXP 联盟 32-47\32-33 千针石林
#xprate >1.3

step
    .goto Wetlands,10.8,59.6
    .accept 288 >> 接受第三舰队
step
    .goto Wetlands,10.6,60.5
    .turnin 270 >> 交出末日舰队
    .accept 321 >> 接受Lightforge Iron
step
    #label mead
    #sticky
    .goto Wetlands,10.7,60.9
    >> 从店主那里买一瓶美赞臣酒
    .complete 288,1 --Collect Flagon of Mead (x1)
step
    .goto Wetlands,10.84,60.43
    >>上楼去和考古学家Flagongut谈谈
    .turnin 942 >>交回心不在焉的探矿者
    .isOnQuest 942
step << wotlk
    #completewith next
    + 如果你还没有坐骑，如果可以的话，给自己邮寄5克。很快就会有更多机会。
step
    #requires mead
    .isOnQuest 1248
    .goto Wetlands,10.6,60.7
    .turnin 1248 >> 交出失踪的外交官
    .accept 1249 >> 接受失踪的外交官
step
    >>一旦你接受了任务，你就必须在塔波克·贾恩试图逃离客栈时与他交战。两个34级敌人会攻击你。如果你不能杀死他们，你可能需要跳过这一步，稍后再做。
    .complete 1249,1 --Defeat Tapoke Jahn
step
    .isOnQuest 1249
    .goto Wetlands,10.6,60.7
    .turnin 1249 >> 交出失踪的外交官
    .accept 1250 >> 接受失踪的外交官
step
    .isOnQuest 1250
    .goto Wetlands,10.6,60.7
    .turnin 1250 >> 交出失踪的外交官
    .accept 1264 >> 接受失踪的外交官
step
    .goto Wetlands,10.8,59.7
    .turnin 288 >> 交出第三舰队
    .accept 289 >> 接受受诅咒的船员
step
    .goto Wetlands,8.4,61.6
    .turnin 1301 >> 交给詹姆斯·海尔
    .accept 1302 >> 接受James Hyal
step << Draenei !Shaman tbc
	.goto Wetlands,4.8,57.3,50,0
	.goto Darkshore,31.0,41.1,30.0
	.goto The Exodar,81.5,52.5,40,0
	.goto Wetlands,5.2,63.3,50,0
	.money <35.00
	>> 乘船去Darkshore，然后乘船去Exodar，买你的坐骑。否则跳过此步骤
	.hs >>然后前往米奈希尔港，乘船前往塞拉莫尔。
step << NightElf tbc
	.goto Wetlands,4.8,57.3,50,0
	.goto Darkshore,33.1,40.3,30,0
	.goto Darnassus,38.1,15.3,30,0
	.goto Wetlands,5.2,63.3,50,0
	.money <35.00
	.train 150 >> 乘船去达克肖，然后去达纳苏斯，买你的坐骑。
	.hs >> 然后返回米奈希尔港，乘船前往塞拉莫尔。
step << Shaman
    #sticky
    #completewith next
    .zone The Exodar >> 乘小船去Darkshore，然后去Exodar。如果您有35g，请购买坐骑并进行训练，否则请跳过此步骤。
	.goto The Exodar,81.5,52.5,40,0
step << Shaman
    .goto The Exodar,29.9,33.0
    .turnin 10491 >> 接通空中通话
    .accept 9552 >> 接受空中呼叫
step << Shaman
.isQuestTurnedIn 9508
    .fly Bloodmyst Isle>> 飞往血腥岛
step << Shaman
    .goto Bloodmyst Isle,32.3,16.2
    .turnin 9504 >> 水的召唤
    .accept 9508 >> 接受水的召唤
step << Shaman
    .goto Bloodmyst Isle,26.0,40.9
	>>杀死Tel’athion并抢劫他的头
    .complete 9508,1 --Collect Head of Tel'athion (x1)
step << Shaman
    .goto Bloodmyst Isle,32.2,16.1
    .turnin 9508 >> 水的召唤
    .accept 9509 >> 接受水的召唤
step << Shaman
	#sticky
	#completewith ZExodar
	.deathskip >> 淹没自己和灵魂rez
step << Shaman
	#sticky
	#completewith next
	.goto Bloodmyst Isle,57.7,53.9
	>>跑回血腥观察站，然后飞到外族人
    .fly The Exodar>> 飞到外族人
step << Shaman
	#label ZExodar
	.zone The Exodar >> 前往外族
step << Shaman
    .goto Azuremyst Isle,26.8,27.3,42
    >>从主入口离开Exodar，沿着山向左行进，直到到达荒风小道
step << Shaman
    .goto Azuremyst Isle,24.9,35.9
    .turnin 9552 >> 接通空中通话
    .accept 9553 >> 接受空中呼叫
step << Shaman
    .goto Azuremyst Isle,22.3,32.5
    .turnin 9553 >> 接通空中通话
    .accept 9554 >> 接受空中呼叫
step << Shaman
    #sticky
    #completewith next
    .zone The Exodar>>再和苏苏罗斯谈谈，这样他就可以把你送回去了
step << Shaman
    .goto The Exodar,30.0,33.1
    .turnin 9509 >> 水的召唤
step << Shaman
    .goto The Exodar,29.6,33.4
    .turnin 9554 >> 接通空中通话
	>>这将给你一个1小时长的buff，提供40%的移动速度和30%的攻击速度。小心不要AFK
step << Shaman
    .hs >> 炉膛到湿地
step
    .goto Wetlands,12.1,64.1
    .turnin 321 >> 交给Lightforge熨斗
    .accept 324 >> 接受丢失的钢锭
step
    .goto Wetlands,10.1,69.5
	>> 杀死墨洛克人并掠夺他们的铸锭。下降率可能非常低。
    .complete 324,1 --Collect Lightforge Ingot (x5)
step
    .goto Wetlands,10.6,60.4
    .turnin 324 >> 交回丢失的钢锭
    .accept 322 >> 接受祝福之臂
step
    .goto Wetlands,10.9,55.9
    .accept 472 >> 接受Dun Modr的堕落
step
    .isOnQuest 464
    .goto Wetlands,9.9,57.4
    .turnin 464 >> 交出战旗
step
    .isOnQuest 281
    .goto Wetlands,13.5,41.5
    .turnin 281 >> 上缴取回货物
    .accept 284 >> 接受搜索继续
step
    .isOnQuest 284
    .goto Wetlands,13.5,38.4
    .turnin 284 >> 交出继续搜索
    .accept 285 >> 接受搜索更多冰球
step
    .isOnQuest 285
    .goto Wetlands,13.9,34.8
    .turnin 285 >> 投掷更多的铁球
    .accept 286 >> 接受并返回雕像
step
    .goto Wetlands,13.9,30.4
    >>要找到斯内利，从靠近海岸的船体上的孔进入船内
    >> 如果你找不到海军陆战队，向北的船通常有更多的海军陆战团。
    .complete 289,3 --Collect Snellig's Snuffbox (x1)
    .complete 289,1 --Kill Cursed Sailor (x13)
    .complete 289,2 --Kill Cursed Marine (x5)
step
    .isOnQuest 470
    .goto Wetlands,44.2,25.8
    >>杀死地穴周围的黏液
    .complete 470,1 --Collect Sida's Bag (x1)
    step
    #completewith next
    .goto Wetlands,49.9,18.3
    .turnin 472 >> Dun Modr秋季转身
step
    .goto Wetlands,49.9,18.3
    .accept 631 >> 接受Thandol跨度
    .accept 304 >> 接受严峻任务
    .accept 303 >> 接受黑铁战争
step
	#sticky
    #label balgaras
    >>杀死犯规的巴尔加拉斯，他可以在东边很远的营地或邓莫德的一所房子里产卵。检查完Dun Modir后往东走。抢他的耳朵。
    .complete 304,1 --Collect Ear of Balgaras (x1)
	.unitscan Balgaras the Foul
    .goto Wetlands,47.4,15.4,40,0
    .goto Wetlands,61.8,31.0,80,0
    .goto Wetlands,46.8,16.0
step--?
    .goto Wetlands,47.3,16.6
	>> 杀死该地区的黑铁矮人
    .complete 303,1 --Kill Dark Iron Dwarf (x10)
    .complete 303,2 --Kill Dark Iron Tunneler (x5)
    .complete 303,3 --Kill Dark Iron Saboteur (x5)
    .complete 303,4 --Kill Dark Iron Demolitionist (x5)
step
    #requires balgaras
    .goto Wetlands,49.7,18.3
    .turnin 303 >> 转入黑铁战争
    .turnin 304 >> 提交严峻任务
step
    .goto Wetlands,51.2,8.0
	>> 下楼，点击矮人尸体。忽略所有的暴徒。
    .turnin 631 >> 转入Thandol桥
    .accept 632 >> 接受Thandol跨度
step
    .goto Wetlands,49.9,18.3
    >> 跑回外面，在任务中转身
    .turnin 632 >> 转入Thandol桥
    .accept 633 >> 接受Thandol跨度
step
    .goto Arathi Highlands,43.3,92.6
    .accept 647 >> 接受麦克雷尔的月光
    >>如果你没有任何速度提升或缓慢下降，你仍然可以获得这个任务
    .link https://www.twitch.tv/videos/646111384 >>单击此处以供参考
    .timer 900,Moonshine Expiration Time
step
    .goto Arathi Highlands,44.3,93.0
	>>跳下去，从水下尸体上抢走信件
    .accept 637 >> 接受萨利·巴鲁的信
step
    #completewith next
    .goto Arathi Highlands,52.5,90.4,30 >> 向东游向这里的斜坡
step
    .goto Arathi Highlands,48.7,87.9
    .complete 633,1 --Collect Cache of Explosives Destroyed (x1)
step
    .goto Wetlands,49.9,18.3
    .turnin 633 >> 转入Thandol桥
    .accept 634 >> 接受对联盟的请求
step
    .goto Arathi Highlands,45.9,47.5
    .turnin 634 >> 向联盟递交请愿书
step
    #xprate >1.3
    .goto Arathi Highlands,46.6,47.0
    .turnin 690 >> 提交Malin的请求
    .isOnQuest 690
step
    .goto Arathi Highlands,45.8,46.1
    .fp Arathi >> 获取Arathi Highlands航线
step
.isOnQuest 647
>>跑到南岸，在客栈下楼。定时器还没到就开始工作。当心路上的快递员。
	.unitscan Forsaken Bodyguard
.goto Hillsbrad Foothills,52.2,58.6
    .turnin 647 >> 交上麦克雷尔的月光
step
#xprate <1.5
    .goto Hillsbrad Foothills,51.9,58.7
    .accept 555 >> 接受安抚乌龟饼干
step
    .xp <30,1
    .goto Hillsbrad Foothills,51.4,58.5
    .accept 536 >> 接受沿海地区
step
    .goto Hillsbrad Foothills,50.9,58.8
    .accept 9435 >> 接受丢失的晶体
step <<  Hunter tbc
     #completewith next
    .goto Hillsbrad Foothills,50.2,58.8
     .stable >> 稳定你的宠物，向东走
step << Hunter tbc
    .xp <30,1
    .goto Hillsbrad Foothills,56.6,53.8
    .train 17264 >> 驯服一只老苔藓爬行动物，用它攻击暴徒以学习咬等级4
	.unitscan Elder Moss Creeper
step
	.goto Hillsbrad Foothills,50.5,57.2
    .turnin 538 >> 在南岸转弯
	.isOnQuest 538
step
    .xp <30,1
    .goto Hillsbrad Foothills,44.0,67.6
	>> 杀死该地区的墨洛克人
    .complete 536,1 --Kill Torn Fin Tidehunter (x10)
    .complete 536,2 --Kill Torn Fin Oracle (x10)
step
    .xp <30,1
    .goto Hillsbrad Foothills,51.4,58.5
    .turnin 536 >> 沿海岸转弯
    .accept 559 >> 接受Farren的证明
step
    .xp <30,1
    .goto Hillsbrad Foothills,42.3,68.3
	>> 杀死墨洛克人并掠夺他们的头
    .complete 559,1 --Collect Murloc Head (x10)
step
    .xp <30,1
    .goto Hillsbrad Foothills,51.4,58.5
    .turnin 559 >> 提交Farren的证明
    .accept 560 >> 接受Farren的证明
step
    .xp <30,1
    .goto Hillsbrad Foothills,49.5,58.8
    .turnin 560 >> 提交Farren的证明
    .accept 561 >> 接受Farren的证明
step
    .xp <30,1
    .goto Hillsbrad Foothills,51.4,58.4
    .turnin 561 >> 提交Farren的证明
    .accept 562 >> 接受风暴浩！
step
    .xp <30,1
    .goto Hillsbrad Foothills,57.1,67.4
	>> 杀死该地区的纳加，如果你不幸产卵，你可能需要下水
    .complete 562,1 --Kill Daggerspine Shorehunter (x10)
    .complete 562,2 --Kill Daggerspine Siren (x10)
step
    .xp <30,1
    .goto Hillsbrad Foothills,51.4,58.5
    .turnin 562 >> 在暴风雨中！
    .accept 563 >> 接受重新分配
step
    .goto Hillsbrad Foothills,50.9,58.8
    .accept 9435 >> 接受丢失的晶体
step
    .goto Hillsbrad Foothills,49.3,52.3
    .fp Southshore >> 获得南岸航线
step
    .goto Hillsbrad Foothills,55.6,35.1
    >>在被摧毁的塔内寻找木箱
    .complete 9435,1 --Collect Shipment of Rare Crystals (x1)
step
    .goto Alterac Mountains,58.4,67.9
	>>点击小桌子顶部的地图
    .accept 510 >> 接受预感计划
    .accept 511 >> 接受加密信函
step
    .goto Western Plaguelands,42.9,85.0
    >>向北前往西部瘟疫地区
    .fp Chillwind >> 获取奇风营地飞行路线
step
    #completewith next
    .goto Western Plaguelands,42.9,85.0
    .fly Southshore>> 飞往南岸
step
    .goto Hillsbrad Foothills,50.5,57.1
    .turnin 511 >> 提交加密信件
    .accept 514 >> 接受给Stormpike的信
step
    .goto Hillsbrad Foothills,48.2,59.3
    .turnin 510 >> 提交预兆计划
step
    .goto Hillsbrad Foothills,50.9,58.8
    .turnin 9435 >> 交回丢失的晶体
step
    #completewith next
    .hs >> 炉到铁炉
step
    .goto Ironforge,63.79,67.78
    .turnin 637 >>交回萨利·巴鲁的信
step
    .goto Ironforge,74.64,11.74
    .turnin 514 >>把信交给Stormpike
step
    .goto Ironforge,63.79,67.78
    .accept 683 >>接受Sara Balloo的请求
step
    .goto Ironforge,39.10,56.19
    .turnin 683 >>提交Sara Balloo的请求
    .accept 686 >>接受国王的贡品
step
    .goto Ironforge,38.75,87.04
    .turnin 686 >>上缴国王贡品
step 
	.goto Ironforge,69.8,83.0 << Hunter
	.goto Ironforge,66.4,88.7 << Warrior
	.goto Ironforge,24.7,8.8 << Priest
	.goto Ironforge,24.6,9.2 << Paladin
	.goto Ironforge,50.3,5.8 << Warlock
	.goto Ironforge,51.6,15.2 << Rogue
	.goto Ironforge,55.4,29.1 << Shaman
    .goto Ironforge,28.6,7.2 << Mage
	.trainer >> 训练你的法术
step
    .goto Ironforge,55.5,47.7
    .fly Wetlands>> 飞到湿地
step
    .goto Wetlands,10.8,59.6
    .turnin 289 >> 交出受诅咒的船员
]])
