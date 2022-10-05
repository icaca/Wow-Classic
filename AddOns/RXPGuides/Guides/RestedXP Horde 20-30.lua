RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Horde !Warrior !Shaman
#name 20-23 石爪山脉 / 贫瘠之地
#version 1
#group RestedXP 部落 1-30
#next 23-27 希尔斯布莱德丘陵 / 灰谷
step << wotlk
    #completewith next
    +如果您可以访问此服务器上的gold，请尽快将gold邮寄给自己，以便进行挂载训练！
step
    .zone Orgrimmar >> 遇到奥格瑞玛
step
    >>去塔顶
    .goto Orgrimmar,45.1,63.9
    .fp Orgrimmar >> 获取Orgrimmar飞行路线
step
    .goto Orgrimmar,39.8,37.0,20 >>跑进要塞
    .zoneskip Orgrimmar,1
step << BloodElf
    .isOnQuest 9626
    .goto Orgrimmar,31.8,38.1
    .turnin 9626 >> 上交与总司令会面
    .accept 9627 >> 接受对部落的忠诚
step << !BloodElf
    .isOnQuest 9813
    .goto Orgrimmar,31.8,38.1
    .turnin 9813 >> 上交与总司令会面
step
    .goto Orgrimmar,39.0,38.3
    .accept 1061 >> 接受石爪的精神
step << Warlock tbc
    #sticky
    >>你必须放弃卡伦丁的召唤任务才能接受灵魂吞噬者
    .abandon 10605 >>放弃卡伦丁传票
    .isOnQuest 10605
step << Warlock tbc
    .goto Orgrimmar,48.2,45.3
    .accept 1507 >>接受灵魂吞噬者
step << Warlock tbc
    .goto Orgrimmar,47.0,46.5
    .turnin 1507 >>交给灵魂吞噬者
    .accept 1508 >>接受盲Cazul
step << Warlock tbc
    .goto Orgrimmar,37.0,59.4
    .turnin 1508 >>转入盲卡祖
    .accept 1509 >>接受Dogran的消息
step << BloodElf
    #xprate <1.5
    .goto Orgrimmar,31.8,38.2
    .accept 9428 >> 接受报告至Splinterree Post
    .maxlevel 21
step << Mage
    .goto Orgrimmar,38.7,85.4
    .train 11417 >> Go and train门户网站：Orgrimmar
step << Orc !Warlock wotlk
	.money <5.00
	.goto Orgrimmar,63.3,12.8
	.train 149 >> 前往荣誉谷。乘坐火车并购买您的坐骑
step
    .goto Orgrimmar,52.5,85.1,50,0
    .goto Orgrimmar,49.1,94.3,50 >>Orgrimmar出口
    .zoneskip Orgrimmar,1
step << Troll !Warlock wotlk
	.money <5.00
	.goto Durotar,55.2,75.5
	.train 533 >> 前往Durotar的Sen'jin村乘坐火车并购买您的坐骑
step
    >>一直跑到棘轮，找到飞行路线。
    .goto The Barrens,63.1,37.1
    .fp Ratchet >> 获取棘轮飞行路径
step
    #xprate <1.5
    >> 接受棘轮周围的任务
    .accept 1483 >>接受Ziz Fizziks
    .goto The Barrens,63.0,37.2
    .accept 959 >>在码头接受麻烦
    .goto The Barrens,63.1,37.6
    .accept 865 >>接受猛禽角
    .goto The Barrens,62.4,37.6
    .maxlevel 21
step
    .goto The Barrens,62.4,37.6
    .accept 1069 >>接受Deepmoss蜘蛛蛋
step << Rogue
	.goto The Barrens,65.0,45.4
    >>跑到船上，然后下到二楼。开始挑选锁箱，直到你拥有80种挑选锁的技能。
	.skill lockpicking,>80
step
    #xprate <1.5
    .maxlevel 21
    >>跑到十字路口接受任务
    .accept 870 >>接受被遗忘的水池
    .goto The Barrens,52.3,31.9
step
    .goto The Barrens,51.9,31.6
    .accept 899 >>接受仇恨所消耗
    .accept 4921 >>接受战败
step
    #completewith next    
    .goto The Barrens,52.0,29.9
	.home >> 把你的炉石放在十字路口
step << Warlock tbc
    .goto The Barrens,51.9,30.3
    .turnin 1509 >>上交《狗跑新闻》
    .accept 1510 >>接受Dogran的消息
step
    .goto The Barrens,51.5,30.3
    .fp The Crossroads >> 获得the Crossroads飞行路线
step
    #xprate <1.5
    .goto The Barrens,51.5,30.1
    .accept 848 >> 接受真菌孢子
    .maxlevel 21
step
    #xprate <1.5
    >> 向西走出十字路口
    .goto The Barrens,45.4,28.4
    .accept 850 >> 接受Kolkar领导人
    .maxlevel 21
step
    #sticky
    #completewith next
    >>收集遗忘池周围的白蘑菇
    .complete 848,1 --Collect Fungal Spores (x4)
    .isOnQuest 848
step
    >>潜水至气泡裂缝
    .goto The Barrens,45.1,22.5
    .complete 870,1 --Explore the waters of the Forgotten Pools
    .isOnQuest 870
step
    >>收集完遗忘池周围的白蘑菇
    .goto The Barrens,45.2,23.3,40,0
    .goto The Barrens,45.2,22.0,40,0
    .goto The Barrens,44.6,22.5,40,0
    .goto The Barrens,43.9,24.4
    .complete 848,1 --Collect Fungal Spores (x4)
    .isOnQuest 848
step
    >>杀死科多班。抢他的头
    .goto The Barrens,42.9,23.5
    .complete 850,1 --Collect Kodobane's Head (x1)
	.unitscan Barak Kodobane
    .isOnQuest 859
step
    #sticky
    #completewith next
    .goto The Barrens,35.3,27.9
    >>杀死并掠夺16级以上猛禽
    .complete 865,1 --Collect Intact Raptor Horn (x5)
    .isOnQuest 865
step
    .isOnQuest 1061
    .goto The Barrens,35.3,27.9
    .turnin 1061 >> 《石爪之魂》（The Spirits of Stonetalon）上映
    .accept 1062 >> 接受地精侵略者
step
    #xprate <1.5
    .goto The Barrens,35.3,27.9
    .accept 6548 >> 接受复仇我的村庄
    .maxlevel 21
step
    .goto Stonetalon Mountains,81.8,96.1
    .zone Stonetalon Mountains >> 前往石爪山
step
    >>杀死该地区的格里姆特姆斯
    .goto Stonetalon Mountains,80.7,89.2,50,0
    .goto Stonetalon Mountains,82.0,86.0,50,0
    .goto Stonetalon Mountains,84.7,84.3,50,0
    .goto Stonetalon Mountains,82.3,90.0,50,0
    .goto Stonetalon Mountains,80.7,89.2,50,0
    .goto Stonetalon Mountains,82.0,86.0,50,0
    .goto Stonetalon Mountains,84.7,84.3,50,0
    .goto Stonetalon Mountains,82.3,90.0
    .complete 6548,2 --Kill Grimtotem Mercenary (x6)
    .complete 6548,1 --Kill Grimtotem Ruffian (x8)
    .isOnQuest 6548
step
    .goto The Barrens,35.2,27.8
    >> 回到荒野中的任务给予者那里
    .turnin 6548 >> 上缴复仇我的村庄
    .accept 6629 >> 接受Kill Grundig Darkcloud
    .isOnQuest 6548
step
    #sticky
    #completewith next
	.goto Stonetalon Mountains,82.3,98.5,40 >>跑到这里的山上去
step << Warlock tbc
    .goto Stonetalon Mountains,73.2,95.1
    .turnin 1510 >>上交《狗跑新闻》
    .accept 1511 >>接受Ken'zigla的吃水
step
    .goto Stonetalon Mountains,71.4,95.1
    >> 在小屋里与Xen'Zilla交谈
    .accept 6461 >> 接受输血器
step
    #sticky
    #completewith next
	.goto Stonetalon Mountains,71.7,86.7,40 >>跑到这里的小路上
    .isOnQuest 6629
step
    >>在开始内部任务之前，确保杀死所有6只野兽。在主帐篷前杀死格隆迪希
	.goto Stonetalon Mountains,74.0,86.2
    .complete 6629,1 --Kill Grundig Darkcloud (x1)
    .complete 6629,2 --Kill Grimtotem Brute (x6)
	.unitscan Grundig Darkcloud
    .isOnQuest 6629
step
    >>启动卡亚护送
    .goto Stonetalon Mountains,73.5,85.8
    .accept 6523 >> 接受保护Kaya
    .isOnQuest 6629
step
       >>护送Kaya并靠近她。3灰熊会在篝火旁产卵。在她到达营地之前吃/喝
    .goto Stonetalon Mountains,75.8,91.4
    .complete 6523,1 --Kaya Escorted to Camp Aparaje
    .isOnQuest 6523
step
    #sticky
    #completewith next
    >> 在前往通缉海报的途中杀死迪普莫斯爬虫。你现在不必完成任务。
    .complete 6461,1 --Kill Deepmoss Creeper (x10)
step
    >>点击沿路通缉海报
    .goto Stonetalon Mountains,59.0,75.7
    .accept 6284 >> 接受阿拉伯恐惧症
step
    .goto Stonetalon Mountains,57.5,76.2,30 >>沿着这条小路跑到西希尔峡谷
step
    #sticky
    #label deepmossegg
    #completewith spiderend
    >>点击树旁的蜘蛛卵。小心，因为暴徒可能会从蛋中产卵
    .complete 1069,1 --Collect Deepmoss Egg (x15)
    .isOnQuest 1069
step
    #sticky
    #label besseleth
    #completewith spiderend
    .goto Stonetalon Mountains,54.7,71.9,40,0
    .goto Stonetalon Mountains,52.6,71.8,40,0
    .goto Stonetalon Mountains,52.2,75.6,40,0
    .goto Stonetalon Mountains,53.9,74.2,40,0
    .goto Stonetalon Mountains,54.7,71.9,40,0
    .goto Stonetalon Mountains,52.6,71.8,40,0
    .goto Stonetalon Mountains,52.2,75.6,40,0
    .goto Stonetalon Mountains,53.9,74.2
    >> 杀死并掠夺贝塞莱斯的毒牙
    .complete 6284,1 --Collect Besseleth's Fang (x1)
	.unitscan Besseleth
    .isOnQuest 6284
step
    >>杀死该地区的Deepmoss Spiders和Besseleth。掠夺贝塞莱斯的毒牙
    .goto Stonetalon Mountains,54.7,71.9,40,0
    .goto Stonetalon Mountains,52.6,71.8,40,0
    .goto Stonetalon Mountains,52.2,75.6,40,0
    .goto Stonetalon Mountains,53.9,74.2,40,0
    .goto Stonetalon Mountains,54.7,71.9,40,0
    .goto Stonetalon Mountains,52.6,71.8,40,0
    .goto Stonetalon Mountains,52.2,75.6,40,0
    .goto Stonetalon Mountains,53.9,74.2
    .complete 6461,1 --Kill Deepmoss Creeper (x10)
    .complete 6461,2 --Kill Deepmoss Venomspitter (x7)
    .isOnQuest 6461
step
    #requires besseleth
step
    #label spiderend
    >> 前往山后的小妖精小屋
    .goto Stonetalon Mountains,59.0,62.6
    .turnin 1483 >> 交给Ziz Fizziks
    .isOnQuest 1483
step
    >> 前往山后的小妖精小屋
    .goto Stonetalon Mountains,59.0,62.6
    .accept 1093 >> 接受超级收割者6000
step
    #sticky
    #completewith next
    >>在搜索操作员以获取蓝图时杀死记录器
    .complete 1062,1 --Kill Venture Co. Logger (x15)
    .isOnQuest 1062
step
    >>杀死Venture Co.Operators直到你拿到蓝图
    .goto Stonetalon Mountains,62.8,53.7,40,0
    .goto Stonetalon Mountains,61.7,51.5,40,0
    .goto Stonetalon Mountains,66.8,45.3,40,0
    .goto Stonetalon Mountains,71.7,49.9,40,0
    .goto Stonetalon Mountains,74.3,54.7,40,0
    .goto Stonetalon Mountains,62.8,53.7
    .complete 1093,1 --Collect Super Reaper 6000 Blueprints (x1)
step
    >>结束杀死记录器
    .goto Stonetalon Mountains,64.1,56.7,40,0
    .goto Stonetalon Mountains,73.4,54.3,40,0
    .goto Stonetalon Mountains,64.1,56.7,40,0
    .goto Stonetalon Mountains,73.4,54.3,40,0
    .goto Stonetalon Mountains,64.1,56.7,40,0
    .goto Stonetalon Mountains,73.4,54.3,40,0
    .goto Stonetalon Mountains,64.1,56.7,40,0
    .goto Stonetalon Mountains,73.4,54.3
    .complete 1062,1 --Kill Venture Co. Logger (x15)
    .isOnQuest 1062
step
    .goto Stonetalon Mountains,59.0,62.6
    .turnin 1093 >> 转入超级收割台6000
    .accept 1094 >> 接受进一步指示
step
    #requires deepmossegg
    .goto The Barrens,52.2,31.9
    .hs >> 炉膛到十字路口
step
    .isOnQuest 870
    .goto The Barrens,52.2,31.9
    .turnin 870 >> 把被遗忘的水池交出来
step
    .isQuestTurnedIn 870
    .goto The Barrens,52.2,31.9
    .accept 877 >> 接受停滞的绿洲
step
    .goto The Barrens,52.3,31.9
    .vendor >> 供应商清理并修理您的装备。
step
    .isOnQuest 848
    >>把这个交上来会开始一个定时任务。如果您在接下来的45多分钟内会很忙，请在此处注销。
    .goto The Barrens,51.5,30.2
    .turnin 848 >> 倒入真菌孢子
step
    .isQuestTurnedIn 848
    >> 等待角色扮演，然后接受任务
    .goto The Barrens,51.5,30.2
    .accept 853 >> 接受药剂师Zamah
step
    .isOnQuest 853
    #sticky
    #completewith Zamah
    +您有45分钟的时间来完成药剂师任务，所以请注意计时器。如果失败，请跳过任务
step
    #sticky
    #completewith Horns
    >>杀死并掠夺你看到的任何等级16+猛禽
    .complete 865,1 --Collect Intact Raptor Horn (x5)
    .isOnQuest 865
step
    >>点击水下的气泡裂缝
    .goto The Barrens,55.6,42.7
    .complete 877,1 --Collect Test the Dried Seeds (x1)
    .isOnQuest 877
step
    #label Horns
    .goto The Barrens,52.2,46.6,40,0
    .goto The Barrens,57.8,54.1,40,0
    .goto The Barrens,52.2,46.6,40,0
    .goto The Barrens,57.8,54.1,40,0
    .goto The Barrens,52.2,46.6,40,0
    .goto The Barrens,57.8,54.1
    >>完成对猛禽角剩余部分的掠夺
    .complete 865,1 --Collect Intact Raptor Horn (x5)
    .isOnQuest 865
step
    .goto The Barrens,49.3,50.4
    >> 前往南边公路旁的小哨所
    .complete 4921,1 --Find Mankrik's Wife
    .skipgossip
step
    #sticky
    #label Lakota1
    #completewith weapons
	.goto The Barrens,50.0,53.1,75,0
    .goto The Barrens,46.0,49.2,75,0
    .goto The Barrens,45.3,52.5	
    .unitscan Lakota'mani
    >>找到并杀死该地区的拉科塔·马尼（格雷·科多）。抢走他的蹄子。如果你找不到他，跳过这个任务。
    .collect 5099,1,883 --Collect Hoof of Lakota'Mani
    .use 5099
    .accept 883 >>接受Lakota'Mani
    .unitscan Lakota'Mani
step
    #requires Lakota1
    #label weapons
step
    #xprate <1.5
    .goto The Barrens,45.1,57.7
    .accept 893 >>接受首选武器
    .maxlevel 25
step
    .isOnQuest 883
    .goto The Barrens,44.7,59.1
    .turnin 883 >> 交给Lakota’mani
step
    .goto The Barrens,44.8,59.1
    .accept 1130 >> 接受Melor发送消息
step << Warlock tbc
    .goto The Barrens,44.6,59.3
    .turnin 1511 >>交上Ken'zigla的草稿
    .accept 1515 >>接受道根的俘虏
step
    .goto The Barrens,44.5,59.2
    .accept 878 >> 战争中接受部落
step
    .goto The Barrens,44.5,59.2
    .fp Camp Taurajo >> 获得Taurajo营地飞行路线
step << Warlock tbc
    >>在去这里的路上杀死Quillboars
    .goto The Barrens,43.3,47.9
    .turnin 1515 >>交出Dogran的俘虏
    .accept 1512 >>接受爱的礼物
step
    >>杀死大量的绒猪。尽可能优先考虑荆棘侠、找水者和风水师。掠夺他们的象牙。保存你得到的血块
    *Water Seekers only spawn in the south western most camps. Go East or North West for Geomancers / Thornweavers.
    .goto The Barrens,47.1,53.3,50,0
    .goto The Barrens,42.2,48.3,50,0
    .goto The Barrens,44.3,52.3,50,0
    .goto The Barrens,47.1,53.3,50,0
    .goto The Barrens,53.2,54.3,50,0
    .goto The Barrens,53.3,51.3,50,0
    .goto The Barrens,53.2,54.3,50,0
    .goto The Barrens,53.3,51.3,50,0
    .goto The Barrens,44.3,52.3,50,0
    .goto The Barrens,47.1,53.3,50,0
    .goto The Barrens,45.2,54.3
    .complete 878,1 --Kill Bristleback Water Seeker (x6)
    .complete 878,2 --Kill Bristleback Thornweaver (x12)
    .complete 878,3 --Kill Bristleback Geomancer (x12)
    .complete 899,1 --Collect Bristleback Quilboar Tusk (x60)
step
    .goto The Barrens,44.2,62.1,75,0
    .goto The Barrens,49.2,62.6,75,0
    .goto The Barrens,49.6,60.0,75,0
    .goto The Barrens,44.2,62.1,75,0
    .goto The Barrens,49.2,62.6,75,0
    .goto The Barrens,49.6,60.0
    >>在该区域周围搜索Owatanka（蓝雷蜥蜴）。如果你找到他，抢走他的尾钉并开始任务。如果找不到他，就跳过这个任务
    .collect 5102,1,884 --Collect Owatanka's Tailspike
    .use 5102
    .accept 884 >>接受Owatanka
    .unitscan Owatanka
step    
    .goto The Barrens,44.6,59.2
    .turnin 878 >> 战争中沦陷的部落
    .accept 5052 >>接受阿加马根的血片
    .turnin 5052 >>交出阿加马根血片
	>> 用你的血碎片来拯救风之精灵
    .accept 889 >> 接受风的精神
    .turnin 889 >> 风之灵归来
step
    #completewith tbroute
    .destroy 5075 >> 销毁所有剩余血块
    .itemcount 5075,1
step
    .isOnQuest 884
    .goto The Barrens,44.9,59.1
    .turnin 884 >> 交给Owatanka
step
	.isOnQuest 883
        .goto The Barrens,44.9,59.1
    .turnin 883 >> 交给Lakota’mani
step << !Tauren
    #label tbroute
    .goto Thunder Bluff,32.1,67.2,30 >>奔向雷霆崖
step << !Tauren
    #completewith next
    .goto Thunder Bluff,45.8,64.7
	.home >> 将您的炉石设置为雷霆崖
step << Warlock
    .goto Thunder Bluff,40.9,62.7
    .train 227 >>火车杆
step << Tauren wotlk
    .money <5.00
    .goto Mulgore,47.5,58.5
    .train 713 >> 前往血蹄村。坐火车，买你的坐骑
step << Tauren
    #completewith next
    .goto The Barrens,44.4,59.2
	.fly Thunder Bluff >>飞或跑去雷霆崖
step << Druid
	#completewith next
	.goto Thunder Bluff,76.5,27.2
	.accept 27 >>接受教训以学习 << tbc
	.trainer >> 去训练你的职业咒语
step
    #xprate <1.5
    .goto Thunder Bluff,30.1,30.0,25 >>进入精神升起下方的视觉池
step
    #xprate <1.5
    #label Zamah
    >>与Clarice Foster交谈
    .goto Thunder Bluff,27.5,24.7
    .accept 264 >> 接受直到死亡我们分开
    .maxlevel 21
step
    .isOnQuest 853
    .goto Thunder Bluff,23.0,20.9
    >> 如果你失败了Zamah任务，就放弃它
    .turnin 853 >> 交给药剂师Zamah
step
    .isOnQuest 853
    .abandon 853 >> 放弃药剂师Zamah
step
    #xprate <1.5
    .goto Thunder Bluff,23.0,20.9
    .accept 962 >> 接受蛇花
    .maxlevel 21
step << Tauren
    #completewith next
    .goto Thunder Bluff,45.8,64.7
    .home >> 将您的炉石设置为雷霆崖
step
    .goto Thunder Bluff,61.4,80.9
    >> 走向猎人的崛起
    .turnin 1130 >> 交出Melor发送消息
    .accept 1131 >> 接受Steelsnap
step
    .goto Thunder Bluff,54.9,51.4
    .accept 1195 >> 接受圣火
step << !Tauren
    >>爬上塔楼
    .goto Thunder Bluff,47.0,49.8
    .fp Thunder Bluff >>获得雷霆崖飞行路线
step
    #completewith ratchetanchor1
    .goto Thunder Bluff,47.0,49.8
    .fly Ratchet >> 飞到棘轮
step
    .isOnQuest 865
    .goto The Barrens,62.4,37.6
    .turnin 865 >> 转入猛禽角
step
    #xprate <1.5
    .isQuestTurnedIn 865
    .goto The Barrens,62.4,37.6
    .accept 1491 >>接受智能饮料
step
    #label ratchetanchor1
    .goto The Barrens,62.4,37.6
    .turnin 1069 >> 交上深苔藓蜘蛛蛋
step
    #sticky
    #completewith next
    .itemcount 5570,1
    .destroy 5570 >> 销毁所有剩余的深苔藓蜘蛛蛋
step
    .goto The Barrens,63.0,37.2
    .turnin 1094 >> 提交进一步说明
    .accept 1095 >> 接受进一步指示
step
    #completewith next
    .goto The Barrens,63.1,37.2
    .fly Crossroads >> 飞向十字路口
step
    .goto The Barrens,52.0,31.6
    .turnin 4921 >> 交出战败
    .turnin 899 >> 因仇恨而上缴
step
    #sticky
    #completewith next
    .destroy 5085 >> 销毁所有剩余的Quilboar Tusks
    .itemcount 5085,1
step
    .goto The Barrens,52.2,31.9
    .turnin 877 >> 转入停滞的绿洲
    .isOnQuest 877
step
    .goto The Barrens,47.0,34.7,15,0
    .goto The Barrens,46.4,34.9,15,0
    .goto The Barrens,46.6,34.8,10 >>在这里上山
    .isOnQuest 959
step
    .goto Kalimdor,51.9,55.4,30,0
    .goto Kalimdor,51.9,55.6,15 >> 小心地滑到洞口（你可能需要步行或踩下踏板）
    .isOnQuest 959
step
    >>进入洞眼
    .goto Kalimdor,51.9,55.4
    .accept 1486 >>接受偏差隐藏
    .isOnQuest 959
step
    .goto The Barrens,46.1,36.7,35 >>离开眼睛。去洞口
    .isOnQuest 959
step
    #sticky
    #label Deviate
    >>杀死邪恶暴徒。抢他们的皮
    .complete 1486,1 --Deviate Hide (20)
    .isOnQuest 1486
step
    #sticky
    #label Serpentbloom
    >>寻找地面上的绿色和红色花朵
    .complete 962,1 --Serpentbloom (10)
    .isOnQuest 962
step
    .goto Kalimdor,52.0,55.4,20,0
    .goto Kalimdor,52.2,55.2,35,0
    .goto Kalimdor,51.8,54.8,20,0
    .goto Kalimdor,52.0,55.4,20,0
    .goto Kalimdor,52.2,55.2,35,0
    .goto Kalimdor,51.8,54.8,20,0
    .goto Kalimdor,52.0,55.4,20,0
    .goto Kalimdor,52.2,55.2,35,0
    .goto Kalimdor,51.8,54.8,20,0
    .goto Kalimdor,52.0,55.4,20,0
    .goto Kalimdor,52.2,55.2,35,0
    .goto Kalimdor,51.8,54.8,20,0
    .goto Kalimdor,52.2,55.2
    >>寻找疯狂的马格利什（小妖精）。他是隐形的，有多个繁殖点。杀了他，抢了他99岁的港口
    .complete 959,1 --Collect 99-Year-Old Port (1)
    .unitscan Mad Magglish
    .isOnQuest 959
step
    .goto Kalimdor,51.9,54.9,20 >>进入洞穴深处
    .isOnQuest 1491
step
    .goto Kalimdor,52.1,54.5,30,0
    .goto Kalimdor,52.3,54.6,30,0
    .goto Kalimdor,52.4,55.1,30,0
    .goto Kalimdor,52.8,54.8,30,0
    .goto Kalimdor,52.6,54.5,30,0
    .goto Kalimdor,52.1,54.5,30,0
    .goto Kalimdor,52.3,54.6,30,0
    .goto Kalimdor,52.4,55.1,30,0
    .goto Kalimdor,52.8,54.8,30,0
    .goto Kalimdor,52.6,54.5,30,0
    .goto Kalimdor,52.1,54.5,30,0
    .goto Kalimdor,52.3,54.6,30,0
    .goto Kalimdor,52.4,55.1,30,0
    .goto Kalimdor,52.8,54.8,30,0
    .goto Kalimdor,52.6,54.5,30,0
	.goto Kalimdor,52.6,54.5
    >>杀死胞浆以获得哭泣精华。留心洞穴深处的两个稀有物种（Trigore和Boahn），因为它们会掉落蓝色的BoE物品
    .complete 1491,1 --Wailing Essence (6)
    .isOnQuest 1491
step
    #requires Serpentbloom
    .isOnQuest 962
step
    #requires Deviate
    >>跑回洞口
    .goto Kalimdor,51.9,55.4
    .turnin 1486 >>交出离群的藏身处
    .isOnQuest 1486
step
    >> 返回Kolkar前哨
    .goto The Barrens,45.4,28.4
    .turnin 850 >> 移交Kolkar领导人
    .isOnQuest 850
step
    .isOnQuest 1062
    >> 前往石爪
    .goto The Barrens,35.3,27.8
    .turnin 1062 >> 交出地精侵略者
    .accept 1063 >> 接受长老克罗恩
step
    .isOnQuest 6523
    >> 前往石爪
    .goto The Barrens,35.3,27.8
    .turnin 6629 >> 移交Kill Grundig Darkcloud
    .turnin 6523 >> 交出保护Kaya
step
    .isQuestTurnedIn 6523
    .goto The Barrens,35.3,27.8
    .accept 6401 >> 接受Kaya的活着 
step
	.goto Stonetalon Mountains,82.3,98.5,40 >>跑到这里的山上去
    .isOnQuest 6461
step
    .goto Stonetalon Mountains,71.3,95.0
    .turnin 6461 >> 收起输血器
    .isOnQuest 6461 
step
    #xprate >1.499
    .isOnQuest 1095
    >> 前往山后的小妖精小屋
    .goto Stonetalon Mountains,59.0,62.6
    .turnin 1095 >> 提交进一步说明
step << !Rogue
    #xprate <1.5
    >> 前往太阳岩度假区
    >> 到达太阳岩后，沿着左边的山路走
    .goto Stonetalon Mountains,49.0,62.8,40,0
    .goto Stonetalon Mountains,47.3,64.2
    .accept 6562 >> 接受深层次的麻烦
    .maxlevel 23
step << Rogue
    >> 前往太阳岩度假区
    >> 到达太阳岩后，沿着左边的山路走
    .goto Stonetalon Mountains,49.0,62.8,40,0
    .goto Stonetalon Mountains,47.3,64.2
    .accept 6562 >> 接受深层次的麻烦
step
    .goto Stonetalon Mountains,47.2,61.1
    .turnin 6284 >> 上缴阿拉伯恐惧症
    .isOnQuest 6284
step
    #xprate <1.5
    .goto Stonetalon Mountains,45.1,59.8
    .fp Sun Rock >>获得太阳岩撤退飞行路线
    .maxlevel 23
step
    .goto Stonetalon Mountains,47.5,58.3
    .turnin 6401 >> 活捉Kaya
    .isOnQuest 6401
step
    .goto Stonetalon Mountains,45.1,59.8
    .fp Sun Rock >>获得太阳岩撤退飞行路线
step
    .isOnQuest 1095
    >> 返回山后的小妖精小屋
    .goto Stonetalon Mountains,59.0,62.6
    .turnin 1095 >> 提交进一步说明
    .maxlevel 23
step
    #xprate <1.5
    #sticky
    #completewith next
    .goto Stonetalon Mountains,78.2,42.8,30 >>前往Talondep Path
    .maxlevel 23
step
    #xprate <1.5
    .goto Ashenvale,42.3,71.0,20 >>穿过洞穴跑到灰谷
    .maxlevel 23
step
    #xprate <1.5
    .goto Ashenvale,16.3,29.8,90 >>前往Zoram'gar前哨。途中一定要避开阿斯特拉纳卫队
    .maxlevel 23
step
    #xprate <1.5
    .goto Ashenvale,12.3,33.8
    .fp Zoram >> 获取Zoram'gar前哨飞行路线
    .maxlevel 23
step
    #xprate <1.5
    .goto Ashenvale,11.8,34.7
    .accept 216 >> 在石头和蓟马之间接受
    .maxlevel 23
step
    #xprate <1.5
    >> 与小屋里的巨魔交谈
    .goto Ashenvale,11.6,34.9
    .accept 6442 >> 在Zoram Strand接受Naga
    .accept 6462 >> 接受巨魔魅力
    .maxlevel 23
step
    #xprate <1.5
    .isQuestComplete 6562
    .goto Ashenvale,11.6,34.3
    .turnin 6562 >> 深陷困境
step
    #xprate <1.5
    .goto Ashenvale,11.6,34.3
    .accept 6563 >> 接受阿库迈的精髓
    .maxlevel 23
step
    #xprate <1.5
    >>接受此任务将启动护送。跟着他
    .goto Ashenvale,12.1,34.4
    .accept 6641 >> 接受伏尔莎的激光
    .maxlevel 23
step
    #xprate <1.5
    #sticky
    #label wrathtailhead
    >>杀死海滩附近的那加人。抢他们的头
    .goto Ashenvale,15.5,17.1
    .complete 6442,1 --Collect Wrathtail Head (x20)
    .isOnQuest 6442
step
    #xprate <1.5
    >>单击钎焊器。会有纳加海浪产卵。一旦沃沙出来，让莫格拉什在与他战斗之前先发脾气。
    .goto Ashenvale,9.8,27.4
    .complete 6641,1 --Defeat Vorsha the Lasher
    .isOnQuest 6641
step
    #xprate <1.5
    .goto Ashenvale,14.2,14.7,40 >>从洞里钻入黑深洞
    .isOnQuest 6442
step
    #xprate <1.5
    #sticky
    #label Sapphires
    #completewith zoramend
    .goto Ashenvale,13.0,13.2,30,0
    .goto Ashenvale,13.6,9.0,30,0
    .goto Ashenvale,13.0,13.2,30,0
    .goto Ashenvale,13.6,9.0,30,0
    .goto Ashenvale,13.0,13.2,30,0
    .goto Ashenvale,13.6,9.0,30,0
    .goto Ashenvale,13.0,13.2,30,0
    .goto Ashenvale,13.6,9.0
    .use 16790 >>在水下游泳，进入黑深潭。杀死女祭司直到一张湿纸条掉落（任务）。然后右击它并接受任务。
    .collect 16790,1,6564 --Collect Damp Note
    .accept 6564 >> 接受对旧神的忠诚
    .isOnQuest 6442
step
    #xprate <1.5
    #requires Sapphires
    >> 从隧道的墙上抢走蓝宝石。
    .goto Ashenvale,13.0,13.2,30,0
    .goto Ashenvale,13.6,9.0,30,0
    .goto Ashenvale,13.0,13.2,30,0
    .goto Ashenvale,13.6,9.0,30,0
    .goto Ashenvale,13.0,13.2,30,0
    .goto Ashenvale,13.6,9.0,30,0
    .goto Ashenvale,13.0,13.2,30,0
    .goto Ashenvale,13.6,9.0
    .complete 6563,1 --Collect Sapphire of Aku'Mai (x20)
    .isOnQuest 6563
step
    #xprate <1.5
    #label zoramend
    #requires wrathtailhead
    >>返回佐拉姆加前哨。
    .goto Ashenvale,12.2,34.2
    .turnin 6641 >> 交给伏尔莎激光器
    .isQuestComplete 6641
step
    #xprate <1.5
    .goto Ashenvale,11.6,34.3
    .turnin 6563 >> 交回阿库迈的精华
    .isQuestComplete 6553
step
    #xprate <1.5
    #sticky
    #completewith next
    .destroy 16784 >> 摧毁所有阿库迈剩余的蓝宝石
    .itemcount 16784,1
step
    #xprate <1.5
    .goto Ashenvale,11.6,34.3
    .turnin 6564 >> 效忠旧神
    .isOnQuest 6564
step
    #xprate <1.5
    .goto Ashenvale,11.7,34.9
    .turnin 6442 >> 在Zoram Strand上交给Naga
    .isQuestComplete 6442
step << Druid tbc
    #sticky
    #completewith next
     +研磨或注销，直到炉灰冷却时间少于5分钟
    .cooldown item,6948,<5m
step << Druid tbc
    .cast 18960 >> 一旦你的炉石可用，使用“传送：月光”咒语
    >>上楼去
     .goto Moonglade,56.2,30.6
    .turnin 27 >>交一堂课来学习
    .accept 28 >>接受湖的审判
step << Druid tbc
	#completewith next
    .goto Moonglade,52.5,40.5
    .trainer >> 去训练你的职业咒语
step << Druid tbc
    >>在湖里找一个花瓶。抢走它作为神龛饰品
    .goto Moonglade,54.6,46.5,25,0
    .goto Moonglade,53.0,48.4
    .collect 15877,1
step << Druid tbc
    .use 15877 >>使用Shrine Bauble
    .goto Moonglade,36.2,41.8
    .complete 28,1 --Complete the Trial of the Lake. (1)
step << Druid tbc
    .goto Moonglade,36.5,40.1
    .turnin 28 >>《湖的试航》（Turn in Trial of the Lake）
    .accept 30 >>接受海狮的审判
step
    #completewith next
    .hs >> 火炉到雷霆崖
    .cooldown item,6948,>0
    .zoneskip Stonetalon Mountains
step
    #completewith next
    .goto Stonetalon Mountains,45.1,59.8
    .fly Thunder Bluff >> 飞向雷霆崖 
    .zoneskip Stonetalon Mountains,1
step
    .isOnQuest 1063
    .goto Thunder Bluff,69.8,30.8
    .turnin 1063 >> 交给克罗恩长老
    >> 等待角色扮演结束
    .accept 1064 >> 接受被遗弃的援助
step
    .isOnQuest 1064
    >> 前往灵泉下的水池
    .goto Thunder Bluff,22.9,21.1
    .turnin 1064 >> 交出被遗弃的援助
    .accept 1065 >> 接受塔伦磨坊之旅
step
    .isOnQuest 1489
    .goto Thunder Bluff,78.4,28.4
    .turnin 1489 >> 交给Hamuul Runetotem
    .accept 1490 >> 接受Nara Runetotem
step
    .isQuestTurnedIn 1489
    .goto Thunder Bluff,75.6,31.2
    .turnin 1490 >> 交给奈拉·伦托姆
step
    .isOnQuest 962
    >> 前往灵泉下的水池
    .goto Thunder Bluff,22.9,21.1
    .turnin 962 >> 转入蛇花
step << Tauren wotlk
    .money <5.00
    .goto Mulgore,47.5,58.5
    .train 713 >> 前往血蹄村。坐火车，买你的坐骑
step << !Druid
	#completewith troubleatdocks1
    .isOnQuest 959
    .goto Thunder Bluff,47.0,49.9
    .fly Ratchet >> 飞到棘轮
step << Druid
	#completewith next
    .goto Thunder Bluff,47.0,49.9
    .fly Ratchet >> 飞到棘轮
step
    #label troubleatdocks1
    .isOnQuest 959
    .goto The Barrens,63.1,37.6
    .turnin 959 >>码头上的麻烦
step
    .isOnQuest 1491
    .goto The Barrens,62.4,37.6
    .turnin 1491 >>提交智能饮料
step << Druid tbc
    >>在水下抢劫灰色箱子
    .goto The Barrens,56.7,8.3
    .collect 15883,1
step << Druid tbc
    #sticky
    #completewith next
    .goto Orgrimmar,12.4,66.1,40 >>从西入口进入奥格瑞玛
step << Druid wotlk/!Druid
    #completewith next
    .goto The Barrens,63.1,37.1,-1    
    .goto Thunder Bluff,47.0,49.9,-1
    .fly Orgrimmar >> 飞往奥格瑞玛
step << Paladin
    #completewith next
    .goto Orgrimmar,32.4,35.8
    .trainer >> 去训练你的职业咒语
step << Shaman
    #completewith next
    .goto Orgrimmar,38.6,36.0
    .trainer >> 去训练你的职业咒语
step << Hunter
    #completewith next
    .goto Orgrimmar,66.1,18.5
    .trainer >> 去训练你的职业咒语
step << Hunter
    #completewith next
    .goto Orgrimmar,66.3,14.8
    .trainer >> 去训练你的宠物法术吧
step << Warrior
    #completewith next
    .goto Orgrimmar,79.7,31.4
    .trainer >> 去训练你的职业咒语
step << Rogue
    #completewith next
    .goto Orgrimmar,44.0,54.6
    .trainer >> 去训练你的职业咒语
step << Warlock
    #completewith next
    .goto Orgrimmar,48.0,46.0
    .trainer >> 去训练你的职业咒语
step << Warlock tbc
	#completewith next
	.goto Orgrimmar,47.5,46.7
    .vendor >> 购买舒缓之吻
	.collect 16375,1
    >>如果你喜欢虚空行者，你也可以买虚空行者的书。
step << Mage
    #completewith next
    .goto Orgrimmar,38.8,85.6
        .trainer >> 去训练你的职业咒语
step << Priest
    #completewith next
    .goto Orgrimmar,35.6,87.8
    .trainer >> 去训练你的职业咒语
step << Rogue tbc
    .goto Orgrimmar,43.1,53.7
    .accept 2460 >>接受破碎的问候
step << Rogue tbc
    >>瞄准Shenthul并键入/敬礼
	.emote SALUTE,3401
    .complete 2460,1 --Shattered Salute Performed (1)
step << Rogue
    .goto Orgrimmar,43.1,53.7
    .turnin 2460 >>交上破碎的礼炮 << tbc
    .accept 2458 >>接受深度覆盖 << tbc
    .train 1725 >>列车分心
    .train 1856 >>火车消失
    .train 1759 >>火车罪恶打击r4
step << Rogue tbc
	#completewith next
    .goto Orgrimmar,42.1,49.5
    .vendor >> 从Rekkul购买至少1种闪粉
    .collect 5140,1 --Collect Flash Powder
step << Rogue tbc
    #sticky
    #completewith next
    +确保你的库存中有一把匕首。如果没有，就买你能找到的最便宜的
step << Rogue tbc
    .use 8051 >>当你距离任务主管菲祖尔大约50码时，使用火炬枪。然后向他致敬。当他变得友好时和他说话
	.emote SALUTE,7233
.goto The Barrens,55.4,5.6
    .turnin 2458 >>转入深覆盖
    .accept 2478 >>任务：可能但不可能
step << Rogue tbc
	.cast 5967 >>秘密和扒手Silixiz为他的塔钥匙。让你尽可能多地拥抱塔壁，然后走到他身后去扒窃他。如果他说了什么，退后，然后从另一个角度靠近，试图再次扒窃他。不要杀了他
    .goto The Barrens,54.8,5.9
    .complete 2478,5 --Silixiz's Tower Key (1)
step << Rogue tbc
    .cast 8676 >>进入塔内，装备匕首。伏击其中一架无人机。这将立即杀死他们。逃跑，回来，对另一个无人机做同样的事
    .goto The Barrens,54.7,5.7
    .complete 2478,1 --Mutated Venture Co. Drone (2)
step << Rogue tbc
    .cast 1943 >>上楼到下一层。重新装备你的主要武器。使用1连击点破解来杀死暴徒。这应该每次为他们带来50%的健康
    .goto The Barrens,54.7,5.8
.complete 2478,3 --Venture Co. Patroller (2)
step << Rogue tbc
    .cast 6761 >>到塔的三楼去。使用1连击点剔骨杀死怪物。这应该每次为他们带来50%的健康
    .goto The Barrens,54.6,5.6
    .complete 2478,2 --Venture Co. Lookout (2)
step << Rogue tbc
    >>去塔的顶层。再次装备你的匕首（确保你的冷却时间结束）。伏击水枪，然后重新装备你的主要武器在你的主要手中。使用你所有的冷却时间和药剂杀死Gallywix。在你杀了他之后，抢走他的头。
    .goto The Barrens,54.8,5.6
    .complete 2478,4 --Gallywix's Head (1)
step << Rogue tbc
    >>将顶层Gallywix前面的箱子用锁撬开，以掠夺改性混合物
	.goto The Barrens,54.8,5.6
	.complete 2478,6 --Cache of Zanzil's Altered Mixture (1)
step << Rogue tbc
    #sticky
    #completewith next
	>>从西入口返回奥格瑞玛
    .goto Orgrimmar,11.6,66.9,30
step << Rogue tbc
	>>你现在将获得为期一周的降级，使你无法使用隐形。只需继续沿着路线走。
	.goto Orgrimmar,43.1,53.7
    .turnin 2478 >>移交任务：可能但不可能
    .accept 2479 >>接受Hinott的帮助
step << Warlock tbc
    .goto Orgrimmar,48.2,45.3
    .turnin 1512 >>交出爱的礼物
    .accept 1513 >>接受绑定
step << Warlock tbc
    .use 6626 >>使用道根的吊坠在建筑的圆圈处召唤魔术师。杀了她
	.goto Orgrimmar,49.4,50.0
    .complete 1513,1 --Summoned Succubus (1)
step << Warlock tbc
    >>从现在开始使用魔术师
    .goto Orgrimmar,48.2,45.3
    .turnin 1513 >>交回装订本
    .isQuestComplete 1513
step << Warlock
    .goto Orgrimmar,48.2,45.3
    .trainer >> 训练你的职业咒语
step << wotlk
    +如果您可以访问此服务器上的gold，请尽快将gold邮寄给自己，以便进行挂载训练！
]])

RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Horde
#name 23-27 希尔斯布莱德丘陵 / 灰谷
#version 1
#group RestedXP 部落 1-30
#next 27-30 贫瘠之地 / 千针石林

step << !Shaman
    #completewith next
    .goto Orgrimmar,54.1,68.5
    .home >> 将您的炉石设置为Orgrimmar
step << Orc !Warlock wotlk
	.money <5.00
	.goto Orgrimmar,63.3,12.8
	.train 149 >> 前往荣誉谷。乘坐火车并购买您的坐骑
step << Troll !Warlock wotlk
	.money <5.00
	.goto Durotar,55.2,75.5
	.train 533 >> 前往Durotar的Sen'jin村乘坐火车并购买您的坐骑
step
	>>去齐柏林塔。把齐柏林飞艇带到提里斯法
	.goto Durotar,50.8,13.8
	.zone Tirisfal Glades >>抵达提里斯法尔·格拉德斯
step << Undead !Warlock wotlk
    .money <5.00
    .goto Tirisfal Glades,60.1,52.6
    .train 554 >> 乘坐火车并购买您的坐骑
    .zoneskip Tirisfal Glades,1
step << Blood Elf !Warlock wotlk
    .money <5.00
    .goto Undercity,66.3,4.5,30,0
    .goto Undercity,54.9,11.3
    .zone Silvermoon City >> 点击易位球前往银月城
step << Blood Elf !Warlock wotlk
    .money <5.00
    .goto Eversong Woods,61.1,54.7,5,0
    .goto Eversong Woods,61.4,54.0
    .train 33388 >> 离开银月城，然后乘火车去买你的坐骑。
step << Blood Elf !Warlock wotlk
    .goto Silvermoon City,49.4,14.3
    >> 如果可以的话，传送到幽暗城 << Mage
    .zone Undercity >> 点击易位之珠前往幽冥城
step << Druid tbc
    >>在水下打劫泡沫裂缝旁边的灰色胸部（疲劳中）。
    .goto Silverpine Forest,30.0,29.1
    .collect 15882,1
    --Video link in future?
    .isOnQuest 30
step
    >>跑向坟墓
	.goto Silverpine Forest,42.9,40.9
    .accept 493 >> 接受Hillsbrad Foothills之旅
step
    >>点击地面上的石墓
    .goto Silverpine Forest,44.1,42.5
    .turnin 264 >> 至死不渝
    .isOnQuest 264
step
    .isOnQuest 3301
    .goto Silverpine Forest,43.0,42.0
    .turnin 3301 >> 提交Mara Runetotem
step
    .goto Silverpine Forest,45.6,42.6
    .fp The Sepulcher >> 获得the Sepulcher飞行路线
step
    .goto Hillsbrad Foothills,20.80,47.40
    .accept 494 >> 接受罢工时间
step
    .goto Hillsbrad Foothills,60.10,18.60
    .fp Tarren Mill>> 获取Tarren Mill飞行路线
step << Shaman
	.goto Hillsbrad Foothills,62.2,20.8
    >>在井里填满水膜
    .complete 1536,1 --Filled Red Waterskin (1)
step
    .goto Hillsbrad Foothills,61.5,19.2
    .turnin 493 >> 转入Hillsbrad Foothills之旅
step
    .isOnQuest 1065
    .goto Hillsbrad Foothills,61.5,19.2
    .turnin 1065 >> 前往塔伦磨坊的旅程
    .accept 1066 >> 接受无辜者的鲜血
step
    .goto Hillsbrad Foothills,61.50,19.20
    .accept 496 >> 接受痛苦药剂
    .accept 501 >> 接受疼痛药剂
step
    .goto Hillsbrad Foothills,62.50,19.70
     >> 点击酒店外的通缉海报
    .accept 567 >> 接受危险！
step
    .goto Hillsbrad Foothills,62.20,20.50
    .turnin 494 >> 上缴时间打击
    .accept 527 >> 接受希尔斯布拉德战役
step
    .goto Hillsbrad Foothills,62.60,20.70
    >>点击Melisara旁边的通缉海报
    .accept 549 >> 接受通缉：辛迪加人员
step
    .goto Hillsbrad Foothills,63.20,20.70
    .accept 498 >> 接受救援
step << Hunter
	#completewith next
	.goto Hillsbrad Foothills,62.56,19.91
	.vendor >> 买箭直到你的箭袋装满
step
    .goto Hillsbrad Foothills,62.79,19.05
	.vendor 2388 >> 到客栈里面去。供应商垃圾，并从Shay那里购买食物/水
step << Shaman
    .goto Hillsbrad Foothills,60.4,26.2
    .vendor >> 如果你有足够的钱，去供应商那里买一把无情的斧子。它并不总是在商店里。
    .collect 12249,1
step << Rogue/Warrior
    .goto Hillsbrad Foothills,60.4,26.2
    .vendor >> 如果你有足够的钱，去供应商那里买一把宽刃刀。它并不总是在商店里。
    .collect 12247,1
step
	#era
	#completewith next
	>>在前往辛迪加的途中杀死熊和蜘蛛
	.complete 496,1 --Collect Gray Bear Tongue (x10)
    .complete 496,2 --Collect Creeper Ichor (x1) 
step
	#era
	    .goto Hillsbrad Foothills,78.46,43.06,200 >> 跑到Dornholde Keep
step
    #sticky
	#label syndicateq
	>>消灭该地区的辛迪加
	.goto Hillsbrad Foothills,77.8,44.1,0
    .complete 549,1 --Kill Syndicate Rogue (x10)
	.complete 549,2 --Kill Syndicate Watchman (x10)
step
    #sticky
    #label shadowmage
    .goto Hillsbrad Foothills,80.61,45.40,0
    >>杀死暗影法师。掠夺他们以获取瓶无辜的血液
	.complete 1066,1 --Collect Vial of Innocent Blood (x5)
step << !Rogue !Hunter !Shaman
    #completewith next
	.goto Hillsbrad Foothills,80.1,38.9
    .vendor >> 供应商垃圾箱，必要时进行维修
step << Rogue/Hunter/Shaman
	#completewith Drull
	.goto Hillsbrad Foothills,80.1,38.9
    .vendor >> 供应商和维修（如果需要）。如果商店里有跟踪裤和/或狼护腕，请购买
step
	#completewith next
	.goto Hillsbrad Foothills,79.8,39.3
    .unitscan Jailor Marlgen
	>>杀死Jailor Marlgen。抢走他抛光的金钥匙
    .collect 3499,1
step
    >>单击球和链条
	.goto Hillsbrad Foothills,79.8,39.6
    .complete 498,2 --Rescue Tog'thar (1)
step
	#completewith next
    >>杀死Jailor Eston。抢走他的钝铁钥匙，他可以在顶层产卵，也可以在底层的一个小屋内产卵
	.goto Hillsbrad Foothills,79.4,41.6
	.collect 3467,1
	.unitscan Jailor Eston
step
	#label Drull
    >>单击球和链条
	.goto Hillsbrad Foothills,75.3,41.5
    .complete 498,1 --Rescue Drull (1)
step
	#som
	#requires shadowmage
step
        #requires shadowmage
	#completewith next
	>>杀死熊。抢走他们的舌头
	.complete 496,1 --Collect Gray Bear Tongue (x10)
step
        #requires syndicateq
	>>杀死蜘蛛。抢劫他们直到爬行动物伊科掉下来
	.goto Hillsbrad Foothills,63.5,33.0,100,0
    .goto Hillsbrad Foothills,57.9,34.5,100,0
    .goto Hillsbrad Foothills,57.2,22.1,100,0
	.goto Hillsbrad Foothills,63.5,33.0,100,0
    .goto Hillsbrad Foothills,57.9,34.5,100,0
    .goto Hillsbrad Foothills,57.2,22.1,100,0
	.goto Hillsbrad Foothills,63.5,33.0
    .complete 496,2 --Collect Creeper Ichor (x1) 
step
	#completewith next
    >>在前往田野的途中杀死熊和山狮。抢走他们的舌头和鲜血
	.complete 496,1 --Collect Gray Bear Tongue (x10)
	.complete 501,1 --Collect Mountain Lion Blood (x10)
step
    .goto Hillsbrad Foothills,36.02,39.19,150 >> 跑到希尔斯布拉德球场
step
	#sticky
	#label Farmers
	>>杀死田里和周围的农民
    .complete 527,1 --Kill Hillsbrad Farmer (x6)
	.complete 527,2 --Kill Hillsbrad Farmhand (x6)
step
    #sticky
    #label Getz
    >>杀死Farmer Getz。他可以在房子、谷仓或田里
    .goto Hillsbrad Foothills,36.7,39.4,60,0
    .goto Hillsbrad Foothills,35.2,37.6,45,0
    .goto Hillsbrad Foothills,35.1,41.0,60,0
    .goto Hillsbrad Foothills,36.7,39.4,60,0
    .goto Hillsbrad Foothills,35.2,37.6,45,0
    .goto Hillsbrad Foothills,35.1,41.0,60,0
    .goto Hillsbrad Foothills,36.7,39.4
    .complete 527,4 --Farmer Getz (1)
step
    >>杀死农夫雷。他可以在房子的一楼或二楼。他也可以在外面的葡萄藤下（小屋）
    .goto Hillsbrad Foothills,33.7,35.5,20,0
    .goto Hillsbrad Foothills,33.2,34.8,20,0
    .goto Hillsbrad Foothills,33.7,35.5,20,0
    .goto Hillsbrad Foothills,33.2,34.8,20,0
    .goto Hillsbrad Foothills,33.7,35.5,20,0
    .goto Hillsbrad Foothills,33.2,34.8,20,0
    .goto Hillsbrad Foothills,33.7,35.5,20,0
    .goto Hillsbrad Foothills,33.2,34.8,20,0
    .goto Hillsbrad Foothills,33.7,35.5,20,0
    .goto Hillsbrad Foothills,33.2,34.8,20,0
    .goto Hillsbrad Foothills,33.2,34.8
    .complete 527,3 --Farmer Ray (1)
step
	#requires Getz
step
	#requires Farmers
	#completewith next
    >>杀死熊和山狮。抢走他们的舌头和鲜血
	.complete 496,1 --Collect Gray Bear Tongue (x10)
	.complete 501,1 --Collect Mountain Lion Blood (x10)
--N Claw rank 3?
step
	#requires syndicateq
    .goto Hillsbrad Foothills,61.5,19.1
    .turnin 1066 >> 无辜者的血
step
    .goto Hillsbrad Foothills,62.38,20.52
	.turnin 549 >> 需要上缴：财团人员
step
    .goto Hillsbrad Foothills,63.2,20.7
    .turnin 498 >> 移交救援人员
step << Hunter
	#completewith next
	.goto Hillsbrad Foothills,62.56,19.91
	.vendor >> 买箭直到你的箭袋装满
step
    .goto Hillsbrad Foothills,62.79,19.05
	.vendor 2388 >> 到客栈里面去。供应商垃圾，并从Shay那里购买食物/水	
step
	#requires Farmers
	>>返回塔伦磨坊
    .goto Hillsbrad Foothills,62.3,20.2
    .turnin 527 >> 希尔斯布拉德战役
step
    .goto Hillsbrad Foothills,62.5,20.3
    .accept 528 >> 接受希尔斯布拉德战役
    .accept 546 >> 接受死亡纪念品
step
	#completewith next
    >>杀死熊和山狮。抢走他们的舌头和鲜血
	.goto Hillsbrad Foothills,54.9,29.8,90,0
    .goto Hillsbrad Foothills,50.5,37.7,90,0
    .goto Hillsbrad Foothills,43.7,39.9,90,0
    .goto Hillsbrad Foothills,38.4,34.9,90,0
    .goto Hillsbrad Foothills,39.1,45.4,90,0
	.goto Hillsbrad Foothills,54.9,29.8
	.complete 496,1 --Collect Gray Bear Tongue (x10)
	.complete 501,1 --Collect Mountain Lion Blood (x10)
step
    .goto Hillsbrad Foothills,36.02,39.19,150 >> 跑到希尔斯布拉德球场
step
    #sticky
    #label Wilkes
	.unitscan Citizen Wilkes
    >>杀死公民威尔克斯。他巡视镇上的每条路
	.complete 567,2 --Kill Citizen Wilkes (x1)
step
    #sticky
    #label Kalaba
	.unitscan Farmer Kalaba
    >>杀死农夫卡拉巴。她在农民的田里巡逻
	.goto Hillsbrad Foothills,35.2,46.5
    .complete 567,4 --Kill Farmer Kalaba (x1)
step
    #label Peasants
	>>杀死田里和周围的农民
	.goto Hillsbrad Foothills,35.2,46.5
	.complete 528,1 --Kill Hillsbrad Peasant (x15)
step
    #requires Wilkes
step
    #requires Kalaba
    >>杀死熊和山狮。抢走他们的舌头和鲜血
    .goto Hillsbrad Foothills,39.1,45.4,90,0
    .goto Hillsbrad Foothills,38.4,34.9,90,0
    .goto Hillsbrad Foothills,43.7,39.9,90,0
    .goto Hillsbrad Foothills,50.5,37.7,90,0
	.goto Hillsbrad Foothills,54.9,29.8,90,0
    .goto Hillsbrad Foothills,39.1,45.4
	.complete 496,1 --Collect Gray Bear Tongue (x10)
	.complete 501,1 --Collect Mountain Lion Blood (x10)
step
	>>跑回塔伦磨坊
	.goto Hillsbrad Foothills,62.4,20.3
    .turnin 528 >> 希尔斯布拉德战役
    .accept 529 >> 接受希尔斯布拉德战役
step
    .goto Hillsbrad Foothills,61.5,19.1
    .turnin 496 >> 上缴痛苦灵丹妙药
    .accept 499 >> 接受痛苦药剂
    .turnin 501 >> 上缴止痛药
    .accept 502 >> 接受疼痛药剂
    .turnin 499 >> 上缴痛苦灵丹妙药
    .accept 1067 >> 接受重返雷霆崖
step << Shaman/Warrior
    .goto Hillsbrad Foothills,60.4,26.2
    .vendor >> 如果你第一次没有得到无情斧头，现在就去商店买。
    .collect 12249,1
step << Rogue
    .goto Hillsbrad Foothills,60.4,26.2
    .vendor >> 如果你第一次没有得到宽刃刀，现在就去商店买。
    .collect 12247,1
step
    #sticky
    #completewith next
    +在交出痛苦药剂时，你可以在获得额外经验后杀死斯坦利
step
	.goto Hillsbrad Foothills,32.6,35.6
    .turnin 502 >> 上缴止痛药
step
	.isOnQuest 546
	#sticky
    #label humanskull
	>>杀死人类。抢劫他们的头骨
    .complete 546,1 --Collect Hillsbrad Human Skull (x30)
step
	>>杀死Verringtan铁匠和他的学徒
	.goto Hillsbrad Foothills,32.1,45.3
	.complete 529,1 --Kill Blacksmith Verringtan (x1)
    .complete 529,2 --Kill Hillsbrad Apprentice Blacksmith (x4)
    .complete 529,3 --Collect Shipment of Iron (x1)
step
    #xprate >1.499 
	.goto Hillsbrad Foothills,62.4,20.3
    #requires humanskull
    .turnin 529 >> 希尔斯布拉德战役
    .turnin 546 >> 递交死亡纪念品
step << Druid
#completewith next
	.cast 18960 >> 使用魔法传送：月光
    .goto Moonglade,52.5,40.5
	.trainer >> 去训练你的职业咒语
step << Druid tbc
    .use 15883 >>点击包中的半吊坠（蓝色），打造吊坠
	.goto Moonglade,36.2,41.8
    .complete 30,1 --Pendant of the Sea Lion (1)
step << Druid tbc
    >>上楼去
    .goto Moonglade,56.2,30.6
    .turnin 30 >>海狮的审判
    .accept 31 >>接受水生形态
step << !Shaman
	#completewith next
	#requires Crate
	>>我们要到稍后才会提交这些任务。
	.hs >> 赫斯到奥格瑞玛
step << Shaman
	#completewith next
	#requires Crate
	>>我们要到稍后才会提交这些任务。
	.hs >> Hearth前往陶拉霍营地
step << Shaman
	.goto The Barrens,43.4,77.4
	.turnin 1536 >>水的召唤
	.accept 1534 >>接受水的召唤
step << Shaman
	#completewith next
	.goto The Barrens,44.5,59.1
	.fly Orgrimmar >>飞往奥格瑞玛
step
    .goto Orgrimmar,54.2,68.4
    .vendor >>与旅店老板格里什卡谈谈，如果需要的话，买些食物/水。此外，一定要检查拍卖行是否有武器升级。你很快就会进行大量跑步。
step << Paladin
    #completewith next
    .goto Orgrimmar,32.4,35.8
.trainer >> 去训练你的职业咒语
step << Shaman
    #completewith next
    .goto Orgrimmar,38.6,36.0
.trainer >> 去训练你的职业咒语
step << Hunter
    #completewith next
    .goto Orgrimmar,66.1,18.5
.trainer >> 去训练你的职业咒语
step << Hunter
    #completewith next
    .goto Orgrimmar,66.3,14.8
.trainer >> 去训练你的宠物法术吧
step << Warrior
    #completewith next
    .goto Orgrimmar,79.7,31.4
.trainer >> 去训练你的职业咒语
step << Rogue
    #completewith next
    .goto Orgrimmar,44.0,54.6
.trainer >> 去训练你的职业咒语
step << Warlock
    #completewith next
    .goto Orgrimmar,48.0,46.0
.trainer >> 去训练你的职业咒语
step << Mage
    #completewith next
    .goto Orgrimmar,38.8,85.6
.trainer >> 去训练你的职业咒语
step << Priest
    #completewith next
    .goto Orgrimmar,35.6,87.8
.trainer >> 去训练你的职业咒语
step << Orc !Warlock wotlk
	.money <5.00
	.goto Orgrimmar,63.3,12.8
	.train 149 >> 前往荣誉谷。乘坐火车并购买您的坐骑
step << Troll !Warlock wotlk
	.money <5.00
	.goto Durotar,55.2,75.5
	.train 533 >> 前往Durotar的Sen'jin村乘坐火车并购买您的坐骑
step
    #completewith fp12
    .goto Orgrimmar,16.2,62.2,30  >> 从西边出口离开Orgrimmar
step
    #completewith fp12
    .goto Ashenvale,94.7,76.8,30  >> 沿着河边跑
step
    #completewith fp12
    .goto Ashenvale,90.8,66.9,30  >> 在这里跑上坡道
step
    #completewith fp12
    .goto Ashenvale,89.2,68.4,30  >> 爬上斜坡。小心28/29级蜘蛛暴徒
step
    #completewith fp12
    .goto Ashenvale,88.5,64.9,40  >> 跑向伐木营地
step
    #completewith fp12
    .goto Ashenvale,81.7,62.9,80  >> 穿过营地跑到这里
step
    #label fp12
    .goto Ashenvale,73.2,61.6
    .fp Splintertree >> 获取Splinterree Post飞行路径
step
    .goto Orgrimmar,45.1,63.9
    .fly Splintertree >> 飞到Splinterree Post
    .zoneskip Ashenvale
step
    .accept 6441 >> 接受萨蒂尔喇叭
    .goto Ashenvale,73.1,61.5
    .turnin 6383 >> 交出灰谷狩猎
    .goto Ashenvale,73.8,61.5
step
    #completewith next
    .isOnQuest 216
    .goto Ashenvale,74.0,60.6
	.home >> 将炉石设置为Splinterree Post
step
    .goto Ashenvale,73.6,60.0
    .accept 25 >> 接受Stonetalon停止
step << BloodElf
    .goto Ashenvale,71.3,67.8
    .turnin 9428 >> 向Splinterree Post提交报告
    .isOnQuest 9428
step
    .goto Ashenvale,71.1,68.1
    .accept 6503 >> 接受灰谷领先者
step
 >>杀死在该地区潜行的灰谷先锋。
.goto Ashenvale,72.5,72.5,40,0
    .goto Ashenvale,76.3,71.1,40,0
    .goto Ashenvale,76.3,67.3,40,0
    .goto Ashenvale,72.5,72.5
    .complete 6503,1 --Kill Ashenvale Outrunner (x9)
    .unitscan Ashenvale Outrunner
step
    .goto Ashenvale,68.3,75.3
    .accept 6544 >> 接受Torek的袭击
step
    >>跟随Torek。这个任务可能有点难。它会在建筑内产生一个波浪敌人。您可能需要跳过。
    >> 尽可能跑进大楼。让Torek干掉一些暴徒。如果你死了，放弃这个任务。 
    * Use your voidwalker here << Warlock
    .goto Ashenvale,64.6,75.3
    .complete 6544,1 --Take Silverwing Outpost.
step
    #sticky
    #completewith next
	.goto Ashenvale,72.3,49.8,50 >>沿着河边跑到这里
step
    >>杀死该地区的萨特尔斯。抢走他们的角
.goto Ashenvale,68.2,54.0
    .complete 6441,1 --Collect Satyr Horns (x16)
step
    #sticky
    #completewith next
    >>杀死笑姐妹直到她们掉下一个蚀刻的药水
    .collect 5867 --Collect Etched Phial (x1)
step
    .use 16304 >>寻找黑影（一只黑豹）并掠夺她以获得黑影之头，然后点击它接受任务。
	.goto Ashenvale,62.2,49.6,40,0
    .goto Ashenvale,58.0,56.2,40,0
    .goto Ashenvale,51.9,54.3,40,0
    .goto Ashenvale,61.2,51.5,40,0
	.goto Ashenvale,62.2,49.6,40,0
    .goto Ashenvale,58.0,56.2,40,0
    .goto Ashenvale,51.9,54.3,40,0
    .goto Ashenvale,61.2,51.5
    .collect 16304,1,24 --Collect Shadumbra's Head
	.accept 24 >> 接受阴影的头部
	.unitscan Shadumbra
step
    >>杀死笑姐妹直到她们掉下蚀刻的药水
    .goto Ashenvale,61.3,51.9
    .collect 5867 --Collect Etched Phial (x1)
step << Rogue
    .goto Ashenvale,16.3,29.8,90 >>前往Zoram'gar前哨。途中一定要避开阿斯特拉纳卫队
step << Rogue
    .goto Ashenvale,12.3,33.8
    .fp Zoram >> 获取Zoram'gar前哨飞行路线
step << Rogue
    .goto Ashenvale,11.8,34.7
    .accept 216 >> 在石头和蓟马之间接受
step << Rogue
    >> 与小屋里的巨魔交谈
    .goto Ashenvale,11.6,34.9
    .accept 6462 >> 接受巨魔魅力
step << Rogue
    .isQuestComplete 6562
    .goto Ashenvale,11.6,34.3
    .turnin 6562 >> 深陷困境
step << Rogue
    >>接受此任务将启动护送。跟着他
    .goto Ashenvale,12.1,34.4
    .accept 6641 >> 接受伏尔莎的激光
step << Rogue
    >>单击钎焊器。会有纳加海浪产卵。一旦沃沙出来，让莫格拉什在与他战斗之前先发脾气。
    .goto Ashenvale,9.8,27.4
    .complete 6641,1 --Defeat Vorsha the Lasher
    .isOnQuest 6641
step
    #requires Phial
	.goto Ashenvale,38.5,36.1,50 >>跑到Thistlefur村
    .isOnQuest 216
step
    #sticky
    #completewith next
    >>在前往洞穴的途中杀死一些伏波族人
    .complete 216,2 --Kill Thistlefur Shaman (x8)
    .complete 216,1 --Kill Thistlefur Avenger (x8)
    .isOnQuest 216
step
    .goto Ashenvale,38.4,30.6,30 >>撞上Thistlefur Hold
    .isOnQuest 216
step
    #sticky
    #label Charms
    >>抢劫隧道内的小箱子。
    .complete 6462,1 --Collect Troll Charm (x8)
    .isOnQuest 6462
step
    >>这将启动护送。准备好后启动。
    .goto Ashenvale,41.5,34.5
    .accept 6482 >> 接受鲁尔的自由
    .isOnQuest 216
step
    .goto Ashenvale,38.5,36.4
    .complete 6482,1 --Escort Ruul from the Thistlefurs.
    .isOnQuest 6482
step
    #requires Charms
    >>完成杀死Furbolgs
	.goto Ashenvale,35.9,36.7
    .complete 216,2 --Kill Thistlefur Shaman (x8)
	.complete 216,1 --Kill Thistlefur Avenger (x8)
    .isOnQuest 216
step << Shaman
    .use 7767 >>填充水膜
    .goto Ashenvale,33.5,67.5
    .complete 1534,1 --Filled Blue Waterskin (1)
step
    .goto Ashenvale,41.5,67.4,40,0
    .goto Ashenvale,44.3,68.6,40,0
    .goto Ashenvale,43.8,63.6,40,0
    .goto Ashenvale,41.4,65.9,40,0
    .goto Ashenvale,41.5,67.4,40,0
    .goto Ashenvale,44.3,68.6,40,0
    .goto Ashenvale,43.8,63.6,40,0
    .goto Ashenvale,41.4,65.9,40,0
    .goto Ashenvale,41.5,67.4,40,0
    .goto Ashenvale,44.3,68.6,40,0
    .goto Ashenvale,43.8,63.6,40,0
    .goto Ashenvale,41.4,65.9,40,0
    .goto Ashenvale,41.5,67.4,40,0
    .goto Ashenvale,44.3,68.6,40,0
    .goto Ashenvale,43.8,63.6,40,0
    .goto Ashenvale,41.4,65.9,40,0
    .goto Ashenvale,44.3,68.6
    .use 16303 >>寻找乌尔桑古斯（熊）。他顺时针巡逻。为乌尔桑戈斯之爪杀死并掠夺他，然后点击它接受任务。
    .collect 16303,1,23 --Collect Ursangous's Paw (x1)
    .accept 23 >> 接受乌尔桑戈斯的爪子
	.unitscan Ursangous
step
    #sticky
    #label Tideress
    .use 16408 >>杀死湖心附近的守卫。抢她一个被污染的水球，然后点击它接受任务
    .collect 16408,1,1918 --Collect Befouled Water Globe (x1)
    .accept 1918 >>接受斜面元素
	.unitscan Tideress
step
    #sticky
    #completewith next
    >>杀死湖中的水元素
    .complete 25,1 --Kill Befouled Water Elemental (x12)
step
    >>在湖心的凉亭下奔跑
	.goto Ashenvale,48.9,69.6
    .complete 25,2 --Scout the gazebo on Mystral Lake that overlooks the nearby Alliance outpost.
step
    >>杀死湖中的水元素
	.goto Ashenvale,48.9,69.6
    .complete 25,1 --Kill Befouled Water Elemental (x12)
step
    #requires Tideress
	.use 5867 >>使用早期月光井的蚀刻Phial
	.goto Ashenvale,60.2,72.9
    .complete 1195,1 --Collect Filled Etched Phial (x1)
step << !Rogue
    #xprate >1.499 
    .hs >> 壁炉到Splinterree Post
	>> 如果需要，购买食物/水
step
    #xprate <1.5
    .goto Ashenvale,71.2,68.1
    .turnin 6503 >> 交给灰谷队的领先者
step
    .goto Ashenvale,72.4,72.1,40,0
    .goto Ashenvale,75.7,70.0,40,0
    .goto Ashenvale,78.2,65.5,40,0
    .goto Ashenvale,72.4,72.1,40,0
    .goto Ashenvale,75.7,70.0,40,0
    .goto Ashenvale,78.2,65.5,40,0
    .goto Ashenvale,75.3,72.0,0
	.use 16305 >>找夏普塔隆（大鸟）。他顺时针巡逻。杀了他，抢走了他的利爪。接受它的任务。将他单独降到大约60%的生命值，然后风筝将他带到亡灵营地杀死他。
    .collect 16305,1,2 --Collect Sharptalon's Claw
    .accept 2 >> 接受夏普塔龙之爪
	.unitscan Sharptalon
step
    .isQuestComplete 6544
    >>回镇上去
    .turnin 6544 >> 交出Torek的袭击
    .goto Ashenvale,73.1,62.5
step    
    .goto Ashenvale,73.8,61.5
    .turnin 2 >> 交给沙普塔龙的爪子
    .turnin 24 >> 翻转阴影的头部
    .turnin 23 >> 交出乌尔桑戈斯的爪子
    .turnin 247 >> 交出狩猎完成
step
    .goto Ashenvale,73.7,60.0
    .turnin 25 >> 转入Stonetalon静止状态
    .turnin 1918 >> 交出斜面元素
step
    .goto Ashenvale,73.1,61.5
    .turnin 6441 >> 交出赛特角
step
    .goto Ashenvale,73.7,60.0
    .abandon 1918 >> 放弃被污染的元素
    .destroy 16408 >> 摧毁被污染的水球
step
    #xprate <1.5
    .goto Ashenvale,73.7,60.0
    .isOnQuest 216
    .accept 824 >> 接受土戒Je'neu
step
    >> 前往客栈
    .goto Ashenvale,74.1,60.9
    .turnin 6482 >> 把自由交给鲁尔
    .isOnQuest 6482
step
    #xprate >1.499 
    .goto Ashenvale,71.2,68.1
    .turnin 6503 >> 交给灰谷队的领先者
step
    #xprate <1.5
	#completewith next
    .isOnQuest 216
    .goto Ashenvale,73.2,61.5
    .fly Zoram'gar >> 飞往佐拉姆加前哨
step
    #xprate <1.5
    .goto Ashenvale,11.9,34.5
    .turnin 216 >> 在岩石和蓟马之间转弯
    .isOnQuest 216
step
    #xprate <1.5
    .goto Ashenvale,11.7,34.8
    .turnin 6462 >> 加入巨魔魅力
    .isOnQuest 6462
step
    #xprate <1.5
    .isQuestTurnedIn 6462
    .goto Ashenvale,11.6,34.3
    .turnin 824 >> 交回土戒的Je'neu
step << Rogue
    #label zoramend
    #requires wrathtailhead
    >>返回佐拉姆加前哨。
    .goto Ashenvale,12.2,34.2
    .turnin 6641 >> 交给伏尔莎激光器
    .isQuestComplete 6641
step << Rogue
    .goto Ashenvale,11.59,34.27
    .accept 6921 >>在废墟中接受
    .accept 6563 >>接受阿库迈的精髓
step << Rogue
    .goto Ashenvale,14.0,15.0,100 >> 前往Blackfathom Deeps的入口
step << Rogue
    .goto Ashenvale,13.15,12.96
	>> 杀死布莱克法索姆潮汐女祭司直到湿气音符掉落。开始任务
	.collect 16790,1,6564
    .accept 6564 >> 接受对旧神的忠诚
step << Rogue
    .goto Ashenvale,17.04,12.29
	>> 潜入地牢，抢劫墙上的20个蓝宝石
    .complete 6563,1 --Sapphire of Aku'Mai (20)
step << Rogue
	#completewith next
	+要独奏这个任务，你需要以两种方式正确演奏。首先，你不需要死气沉沉，这意味着在你与老板争吵之前，你应该充分呼吸。第二件事要注意的是，你需要尽可能地踢出每一个冰雹，并在踢过之后使用回避。他的大部分损失将来自霜冻。记住，你可以消失，5分钟后再试一次，只要你不气死。
	.link https://youtu.be/ehXV0stmDrM?t=202 >> 单击此处获取有关此部分的指南
step << Rogue
	>> 一路潜行到月光废墟，然后在桥下游泳，为老板做准备（使用你所有的增益）
	>> 掠夺深渊核心，这就产生了首领。
	>> 从阿奎尼斯男爵手中抢走地球仪。接受任务
	.collect 16762,1,6922 
	.accept 6922 >> 接受阿奎尼斯男爵
step << Rogue
    .hs >> 壁炉到Splinterree Post
	>> 如果需要，购买食物/水
step << Druid
#completewith next
    .cast 18960 >> 使用“传送到月光”法术
    .goto Moonglade,52.5,40.5
	.trainer >> 去训练你的职业咒语
step
    #completewith next
    .hs >> 用你的炉灰
step << !Warrior !Hunter !Shaman !Druid !Mage !Priest
    .goto Ashenvale,73.2,61.6
    .fly Orgrimmar >> 飞往奥格瑞玛
    .zoneskip Ashenvale,1
step << Paladin
	#completewith flytimebabyyy
    .goto Orgrimmar,32.4,35.8
	.trainer >> 去训练你的职业咒语
step << Warlock
	#completewith flytimebabyyy
    .goto Orgrimmar,48.0,46.0
	.trainer >> 去训练你的职业咒语
step << Warlock tbc
	#completewith flytimebabyyy
    .goto Orgrimmar,47.5,46.7
	.vendor >> 购买诱惑格栅
	.collect 16379,1
step << Rogue
    #completewith flytimebabyyy
    .goto Orgrimmar,44.0,54.6
	.trainer >> 去训练你的职业咒语
step
    #label flytimebabyyy
step
	.goto Orgrimmar,45.2,63.8,-1
    .goto Ashenvale,73.2,61.6,-1
    .fly Thunder Bluff >> 飞向雷霆崖
]])

RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Horde
#name 27-30 贫瘠之地 / 千针石林
#version 1
#group RestedXP 部落 1-30
#next RestedXP 部落 30-45\30-34 希尔斯布莱德丘陵 / 阿拉希高地 / 千针石林

step
	.goto Thunder Bluff,55.2,51.5
    .turnin 1195 >> 交出圣火
    .accept 1196 >> 接受圣火
step << Warrior tbc/Paladin/Shaman
    .goto Thunder Bluff,54.0,57.3
    .vendor >> 如果你在希尔斯布拉德没有得到一把无情的斧头，就买一把吧
    .collect 12249,1
step << Hunter
    .goto Thunder Bluff,46.9,45.7
    .vendor >> 如果商店里有Sturdy Recurve，那就去买。
    .collect 11306,1
step << Druid
    .goto Thunder Bluff,77.0,29.9
	.trainer >> 去训练你的职业咒语
	.turnin 31 >>以水生形态交出 << tbc
step << Hunter
	#completewith next
    .goto Thunder Bluff,59.1,86.9
	.trainer >> 去训练你的职业咒语
step << Hunter
	#completewith next
    .goto Thunder Bluff,54.1,83.9
	.trainer >> 去训练你的宠物法术吧
step << Warrior
	#completewith next
    .goto Thunder Bluff,57.6,85.5
	.trainer >> 去训练你的职业咒语
step << Shaman
	#completewith next
    .goto Thunder Bluff,22.8,21.0
	.trainer >> 去训练你的职业咒语
step << Priest
	#completewith next
    .goto Thunder Bluff,24.6,22.6
	.trainer >> 去训练你的职业咒语
step << Mage
	#completewith next
    .goto Thunder Bluff,25.2,20.9
	.trainer >> 去训练你的职业咒语
step
    .goto Thunder Bluff,61.0,81.0
    .accept 1131 >> 接受Steelsnap
step
    >>在灵魂升起下面的水池里
	.goto Thunder Bluff,23.1,21.0
    .turnin 1067 >> 投奔雷霆崖
    .isOnQuest 1067
step
	#completewith next
	.goto Thunder Bluff,45.8,64.7
	.home >> 将您的炉石设置为雷霆崖
step << Tauren wotlk
    .money <5.00
    .goto Mulgore,47.5,58.5
    .train 713 >> 前往血蹄村。坐火车，买你的坐骑
step
    >> 前往图腾塔
    .goto Thunder Bluff,46.8,50.1
    .fly Camp Taurajo >> 飞往陶拉霍营地
step << Warrior
    >>在大楼里
	.goto The Barrens,44.7,59.4
	.turnin 1823 >>转身与鲁加交谈
    .accept 1824 >>在巨人球场接受审判
step
    .maxlevel 28
    >> 与笼子里的芒果对话，如果你上次没有抓到的话，就从鞑靼人那里捡起选择武器
    .accept 879 >> 接受内部背叛
    .goto The Barrens,44.6,59.2
    .accept 893 >> 接受首选武器
    .goto The Barrens,45.0,57.6
step
	#sticky
	#label Owatanka2
	#completewith next
    .maxlevel 29
	.goto The Barrens,44.2,62.1,75,0
	.goto The Barrens,49.2,62.6,75,0
	.goto The Barrens,49.6,60.0,75,0
	>>在该区域周围搜索Owatanka（蓝雷蜥蜴）。如果你找到他，抢走他的尾钉并开始任务。如果你找不到他，跳过这个任务
	.collect 5102,1,884 --Collect Owatanka's Tailspike
    .use 5102
	.accept 884 >>接受Owatanka
	.unitscan Owatanka
step << Warrior
    >>杀死该地区的Silithid暴徒。抢走他们的Twitching Antenna。速度要快，因为他们有15米的持续时间
	.goto The Barrens,48.1,70.3
	.complete 1824,1 --Twitching Antenna (5)
step << Warrior
    >>在大楼里
	.goto The Barrens,44.7,59.4
    .turnin -1824 >>在巨人球场接受审判
step << Warrior
    #xprate <1.5
    .goto The Barrens,44.7,59.4
    .accept 1825 >>接受与Thun'grim交谈
step << Shaman
    .goto The Barrens,43.4,77.4
    .turnin 1534 >>水的召唤
    .accept 220 >>接受水的召唤
step
    #sticky
    #label Washte
    #completewith next
    .goto The Barrens,44.7,74.7,0
    .goto The Barrens,44.7,77.8,0
    .goto The Barrens,47.6,79.8,0
    >>在该区域周围搜索Washte Pawne（红风蛇）。他放弃了一项任务。 
    .collect 5103,1,885 --Collect Washte Pawne's Feather
    .accept 885 >>接受Washte Pawne
    .unitscan Washte Pawne
step
    .goto The Barrens,46.0,76.2,50,0
    .goto The Barrens,46.0,81.2,50,0
    .goto The Barrens,46.0,76.2,50,0
    .goto The Barrens,46.0,81.2,50,0
    .accept 843 >> 接受甘恩的复垦。他沿路巡逻。
    .unitscan Gann Stonespire
    .maxlevel 28
step
    #sticky
    #label Washte
    #completewith next
    .goto The Barrens,44.7,74.7,0
    >>在该区域周围搜索Washte Pawne（红风蛇）。他放弃了一项任务。如果你在最后一个地方找不到他，就跳过任务
    .collect 5103,1,885 --Collect Washte Pawne's Feather
    .accept 885 >>接受Washte Pawne
    .unitscan Washte Pawne
step
    #sticky
    #label Weapons
    .isOnQuest 893
    .goto The Barrens,43.4,78.8,30,0
    .goto The Barrens,40.4,80.8,30,0
    .goto The Barrens,43.8,83.5,30,0
    >>在选择武器区杀死暴徒。追踪者或探路者的暗杀者、先知的魔杖和战争狂乱的盾牌
    .complete 893,1 --Collect Razormane Backstabber (x1)
    .complete 893,2 --Collect Charred Razormane Wand (x1)
    .complete 893,3 --Collect Razormane War Shield (x1)
step
	.goto The Barrens,43.4,78.8
    >> 库兹绕着山脊走。杀了她，抢了她的头骨。
    .complete 879,1 --Collect Kuz's Skull (x1)
	.unitscan Kuz 
step
    .goto The Barrens,40.4,80.8
    >> 洛克在斜坡上的大楼里。杀掉并抢劫他的头骨。
    .complete 879,3 --Collect Lok's Skull (x1)
	.unitscan Lok Orcbane
step
    .goto The Barrens,43.8,83.5
    >> 纳克位于山脊的南部。杀掉并抢劫他的头骨。
    .complete 879,2 --Collect Nak's Skull (x1)
	.unitscan Nak
step
    #requires Weapons
    #sticky
    #label Baeldun
	.goto The Barrens,48.3,86.2,0,0
    >>为了甘恩的复垦，杀死该地区的矮人
    .complete 843,1 --Kill Bael'dun Excavator (x15)
    .complete 843,2 --Kill Bael'dun Foreman (x5)
step
    #requires Weapons
	>>杀死探矿者哈兹戈姆。抢他的日记
	.goto The Barrens,48.3,86.2
	.complete 843,3 --Collect Khazgorm's Journal (x1)
step
    #sticky
    #label Washte
    #completewith next
    >>在该区域周围搜索Washte Pawne（红风蛇）。他放弃了一项任务。如果你找不到他，就跳过任务
    .collect 5103,1,885 --Collect Washte Pawne's Feather
    .accept 885 >>接受Washte Pawne
    .unitscan Washte Pawne
step
    .isOnQuest 843
    .unitscan Gann Stonespire
    .goto The Barrens,46.0,81.2,50,0
    .goto The Barrens,46.0,76.2,50,0
    .goto The Barrens,46.0,81.2,50,0
    .goto The Barrens,46.0,76.2,50,0
    >> 再次在路上找到甘恩
    .turnin 843 >> 移交甘恩的复垦
step
    .goto The Barrens,46.0,81.2,50,0
    .goto The Barrens,46.0,76.2,50,0
    .goto The Barrens,46.0,81.2,50,0
    .goto The Barrens,46.0,76.2,50,0
    .accept 846 >> 接受甘恩的复仇
step << Hunter/Warlock
    .goto The Barrens,48.9,86.2
    >> 前往矮人地堡
    .accept 857 >> 接受月亮的眼泪
step
    >>杀掉暴徒并掠夺他们以报仇甘恩
	.goto The Barrens,49.4,84.3
    .complete 846,1 --Collect Nitroglycerin (x6)
    .complete 846,2 --Collect Wood Pulp (x6)
    .complete 846,3 --Collect Sodium Nitrate (x6)
step << Hunter/Warlock
    >>下楼到大楼的主房间。你可以让你的宠物坦克来对抗暴徒。（把离你最近的怪物拉过来，不要直接拉双胞胎）。或者，你可以把你的宠物送进去，洗劫箱子，然后死后跑回。
    .goto The Barrens,49.1,84.3
    .complete 857,1 --Collect Tear of the Moons (x1)
step
    #sticky
    #label Washte
    #completewith wpscout1
    >>在该区域周围搜索Washte Pawne（红风蛇）。他放弃了一项任务。如果你找不到他，就跳过任务
    .collect 5103,1,885 --Collect Washte Pawne's Feather
    .accept 885 >>接受Washte Pawne
    .unitscan Washte Pawne
step
    #label wpscout1
    .isQuestComplete 846
    .goto The Barrens,46.0,81.2,50,0
    .goto The Barrens,46.0,76.2,50,0
    .goto The Barrens,46.0,81.2,50,0
    .goto The Barrens,46.0,76.2,50,0
    >> 再次在路上找到甘恩
    .turnin 846 >> 交出甘恩的复仇
    .unitscan Gann Stonespire
step
    .isQuestTurnedIn 846
    .goto The Barrens,46.0,81.2,50,0
    .goto The Barrens,46.0,76.2,50,0
    .goto The Barrens,46.0,81.2,50,0
    .goto The Barrens,46.0,76.2,50,0
    .accept 849 >> 接受甘恩的复仇
step << Hunter/Warlock
    .goto The Barrens,48.9,86.3
    >> 抬头经过矮人掩体
    .turnin 857 >> 《月亮的眼泪》
step
    .isOnQuest 849
    >>右击发射台顶部的飞行机器
    .goto The Barrens,47.0,85.6
    .complete 849,1 --Collect Bael Modan Flying Machine destroyed (x1)
step
    #sticky
    #label Washte
    #completewith wpscout2
    >>在该区域周围搜索Washte Pawne（红风蛇）。他放弃了一项任务。如果你找不到他，就跳过任务
    .collect 5103,1,885 --Collect Washte Pawne's Feather
    .accept 885 >>接受Washte Pawne
    .unitscan Washte Pawne
step
    #label wpscout2
    .isOnQuest 849
    .goto The Barrens,46.0,81.2,50,0
    .goto The Barrens,46.0,76.2,50,0
    .goto The Barrens,46.0,81.2,50,0
    .goto The Barrens,46.0,76.2,50,0
    >> 再次找到甘恩
    .turnin 849 >> 交出甘恩的复仇
    .unitscan Gann Stonespire
step
    .goto Thousand Needles,32.2,22.2
    >> 向南朝向千针
    .accept 4542 >> 接受发送给Freewind Post的消息
step
    #sticky
    #completewith next
    .use 12564 >>注意Galak Messenger。如果你看到了，杀了他，抢走笔记，接受任务。如果你找不到他，你也可以找他。
    .collect 12564,1,4881 --Collect Assassination Note
    .accept 4881 >>接受刺杀阴谋
    .unitscan Galak Messenger
step
    #sticky
    #completewith next
    >>乘电梯下来，然后跑到Freewind Post
    .goto Thousand Needles,47.1,48.3,60
step
    >> 接受Freewind Post周围的任务
    .accept 9431 >> 接受不同的方法
    .goto Thousand Needles,46.1,50.5
    .accept 5147 >> 接受通缉-Arnak Grimtotem
    .goto Thousand Needles,45.9,50.9
step
    .goto Thousand Needles,46.1,51.7
    .isOnQuest 1196
    .turnin 1196 >> 交出圣火
    .accept 1197 >> 接受圣火
step
    .goto Thousand Needles,45.6,50.8
    .turnin 4542 >> 向Freewind Post提交消息
    .accept 4841 >> 接受安抚半人马座
step
    .goto Thousand Needles,45.1,49.2
    .fp Freewind Post >> 获取Freewind Post飞行路径
step
    .accept 4767 >> 接受风骑士
    .goto Thousand Needles,44.8,49.1
    .accept 4821 >> 接受异形蛋
    .goto Thousand Needles,44.7,50.2
step << Hunter
#completewith next
    .goto Thousand Needles,44.9,50.7
    .vendor >> 如果商店里有密集短裤，就去买。
    .collect 11305,1
step
    #sticky
    #completewith next
    .isOnQuest 1197
    >>进入Galak洞穴。沿着左边跑。杀死途中的半人马
    .goto Thousand Needles,44.0,37.4,40
step
    #sticky
    #completewith next
    >>杀死该地区的半人马
    .goto Thousand Needles,41.3,37.7,0,0
    .complete 4841,3 --Kill Galak Windchaser (x6)
    .complete 4841,1 --Kill Galak Scout (x12)
    .complete 4841,2 --Kill Galak Wrangler (x10)    
step
    >>抢劫洞穴系统末端的铜器。一旦你到了山洞的十字路口，向左拐。
    .goto Thousand Needles,42.0,31.5
    .complete 1197,1 --Collect Cloven Hoof (x1)
step
    >>杀死该地区的半人马
    .goto Thousand Needles,41.3,37.7
    .complete 4841,3 --Kill Galak Windchaser (x6)
    .complete 4841,1 --Kill Galak Scout (x12)
    .complete 4841,2 --Kill Galak Wrangler (x10)
step
    #sticky
    #completewith next
    >>沿着这条小路跑，然后进入洞穴
    .goto Thousand Needles,54.6,44.3,30
step
    .goto Thousand Needles,53.9,41.5
    .accept 1149 >> 接受信仰测试
step
    .isOnQuest 1149
    >>从木平台的一端跳下来，你不会死的。
    .goto Thousand Needles,26.4,32.6,15
step
    .goto Thousand Needles,53.9,41.7
    .turnin 1149 >> 信仰的交验
    .accept 1150 >> 接受耐久性试验
step
    #sticky
    #label Egg5
    >>寻找外星人蛋。这是其中一个营地里的一件可掠夺物品。它看起来像蜘蛛蛋。
    .goto Thousand Needles,56.3,50.4,20,0
    .goto Thousand Needles,52.4,55.2,20,0
    .goto Thousand Needles,37.7,56.1,20,0
    .goto Thousand Needles,56.3,50.4,20,0
    .goto Thousand Needles,52.4,55.2,20,0
    .goto Thousand Needles,37.7,56.1
    .complete 4821,1 --Collect Alien Egg (x1)
step
    >>杀死雷霆博德金斯。掠夺他们净化地球
    .goto Thousand Needles,65.2,62.4
    .complete 9431,1 --Collect Purifying Earth (x2)
step
    #requires Egg5
    >>返回Freewind Post
    .goto Thousand Needles,45.6,50.8
    .turnin 4841 >> 交出安抚半人马座
    .accept 5064 >> 接受Grimtotem间谍
step << tbc
    #completewith exitfreewind33
    +如果您可以在此服务器上访问更多黄金，请给自己发邮件35g。我们很快就会买你的坐骑。
step
    .goto Thousand Needles,46.1,51.7
    .turnin 1197 >> 交出圣火
step
    .goto Thousand Needles,44.7,50.3
    .turnin 4821 >> 交上外星人蛋
    .accept 4865 >> 接受野蛇
step
    #label exitfreewind33
    .isOnQuest 1150
    .goto Thousand Needles,27.7,50.0,20 >> 从Freewind Point往下走，然后沿着这条小路跑
step
    .isOnQuest 1150
    .goto Thousand Needles,27.3,51.2,20 >>进入洞穴
    >> 记住，这里的小妖精可以保持沉默 << Priest/Warlock/Druid/Paladin/Mage/Shaman
step
    >>走到洞穴的尽头，打开板条箱。杀死格伦卡并抢劫她
    .goto Thousand Needles,25.9,54.6
    .complete 1150,1 --Collect Grenka's Claw (x1)
step
    .isOnQuest 4767
    >>离开洞穴，然后沿着这条小路跑
    .goto Thousand Needles,13.9,31.7,25
step
    #sticky
    #label Eggs
    #completewith Paoka
    >>抢劫该地区地面上的鸡蛋。抢劫你看到的任何东西
    .complete 4767,1 --Collect Highperch Wyvern Egg (x10)
step
    .isOnQuest 4767
    .goto Thousand Needles,13.2,39.7,20 >>沿着这条路跑
step
        >>这将启动护送。准备好后启动。开始前试着吃5-6个鸡蛋，这样你就可以在出去的路上吃完。
    .goto Thousand Needles,17.8,40.6
    .accept 4770 >> 接受返程
step
    #label Paoka
    >>护送保卡下山。当三只飞龙到达该区域的中部时会产卵。
    .goto Thousand Needles,14.6,32.7
    .complete 4770,1 --Escort Pao'ka from Highperch
step
    .goto Thousand Needles,10.8,34.7
    >>回去把剩下的怀文蛋抢走
    .complete 4767,1 --Collect Highperch Wyvern Egg (x10)
step
.goto Thousand Needles,21.5,32.3
    .turnin 4865 >> 《狂蛇归来》
    .accept 5062 >> 接受圣火
    .turnin 9431 >> 换一种方式
    .accept 5151 >> 接受超级电容器Gizmo
    .accept 9433 >> 在月井里沉沦
    .turnin 4770 >> 转入返程
step
    #sticky
    #completewith steelsnap
 >>留心Steelsnap。他在该地区巡逻。
    .complete 1131,1 --Collect Steelsnap's Rib (x1)
	.unitscan Steelsnap
step
#sticky
#completewith messenger
.use 12564 >>找到巡逻该区域的Galak Messenger。杀了他，抢了他的纸条。
    .collect 12564,1,4881 --Collect Assassination Note (x1)
.accept 4881 >> 接受刺杀阴谋
step
    #label steelsnap
    .use 23675 >>使用隐藏在窗台上方灌木丛中的Robotron控制单元。 
    >> 进入机器人后，你可以走到月光井，并使用宠物动作栏按钮收集水。
    * Note: the quest arrow won't move when controlling the robot. Click the buff off once you're done.
    .goto Thousand Needles,12.0,18.8,15,0
    .goto Thousand Needles,10.7,17.6,15,0
    .goto Thousand Needles,9.5,18.7,10,0
    .goto Feralas,89.6,46.3
    .complete 9433,1 --Collect Thalanaar Moonwell Water (x1)
step
    #xprate <1.5
    .goto Thousand Needles,18.7,22.2,40,0
    .xp 29+500>>研磨至500+/36300 xp
step
    #label messenger
>>搜索Steelsnap（Hyena）。他逆时针巡逻
	.goto Thousand Needles,10.9,23.2,40,0
    .goto Thousand Needles,17.1,18.4,40,0
    .goto Thousand Needles,18.3,26.8,40,0
    .goto Thousand Needles,15.2,30.5,40,0
    .goto Thousand Needles,18.3,26.8,40,0
    .goto Thousand Needles,17.1,18.4,40,0
	.goto Thousand Needles,10.9,23.2,40,0
    .goto Thousand Needles,17.1,18.4,40,0
    .goto Thousand Needles,18.3,26.8,40,0
    .goto Thousand Needles,15.2,30.5
	.complete 1131,1 --Collect Steelsnap's Rib (x1)
	.unitscan Steelsnap
step
    .goto Thousand Needles,21.5,32.5
    .turnin 9433 >> 在月井里转一圈
    .accept 9434 >> 接受Tonic测试
step
.use 12564 >>搜索Galak Messenger。他从一个营地出发，上路，然后去另一个营地
    .goto Thousand Needles,18.4,22.2,40,0
    .goto Thousand Needles,25.2,33.8,40,0
    .goto Thousand Needles,36.0,29.0,40,0
    .goto Thousand Needles,39.6,33.6,40,0
    .goto Thousand Needles,36.0,29.0,40,0
    .goto Thousand Needles,25.2,33.8,40,0
    .goto Thousand Needles,18.4,22.2,40,0
    .goto Thousand Needles,25.2,33.8,40,0
    .goto Thousand Needles,36.0,29.0,40,0
    .goto Thousand Needles,39.6,33.6
    .collect 12564,1,4881 --Collect Assassination Note (x1)
    .accept 4881 >> 接受刺杀阴谋
	.unitscan Galak Messenger
step
    .goto Thousand Needles,37.5,38.4,30,0
    .goto Thousand Needles,33.5,32.4,30,0
    .goto Thousand Needles,37.5,38.4,30,0
    .goto Thousand Needles,33.5,32.4,30,0
    .goto Thousand Needles,37.5,38.4,30,0
    .goto Thousand Needles,33.5,32.4,30,0
    .goto Thousand Needles,37.5,38.4,30,0
    .goto Thousand Needles,33.5,32.4,30,0
    .goto Thousand Needles,37.5,38.4,30,0
    .goto Thousand Needles,33.5,32.4,30,0
    .goto Thousand Needles,37.5,38.4,30,0
    .goto Thousand Needles,33.5,32.4,30,0
    .goto Thousand Needles,37.5,38.4,30,0
    .goto Thousand Needles,33.5,32.4,30,0
    .goto Thousand Needles,37.5,38.4,30,0
    .goto Thousand Needles,33.5,32.4
    >>在水池里来回走动，在水边和水下采集黄色植物。
    >>元素免疫霜冻伤害并高度抵抗火焰。尽量避免他们 << Mage
    .complete 5062,1 --Collect Incendia Agave (x10)
step
	#completewith next
    .hs >> 火炉到雷霆崖
    .cooldown item,6948,>0
step << Druid
	#completewith next
    .goto Thunder Bluff,77.0,29.9
    .trainer >> 去训练你的职业咒语
step << Hunter
	#completewith next
    .goto Thunder Bluff,59.1,86.9
    .trainer >> 去训练你的职业咒语
step << Hunter
	#completewith next
    .goto Thunder Bluff,54.1,83.9
    .trainer >> 去训练你的宠物法术吧
step << Warrior
	#completewith next
    .goto Thunder Bluff,57.6,85.5
    .trainer >> 去训练你的职业咒语
step << Shaman
	#completewith next
    .goto Thunder Bluff,22.8,21.0
    .trainer >> 去训练你的职业咒语
step << Priest
	#completewith next
    .goto Thunder Bluff,24.6,22.6
    .trainer >> 去训练你的职业咒语
step << Mage
	#completewith next
    .goto Thunder Bluff,25.2,20.9
    .trainer >> 去训练你的职业咒语
step
    .goto Thunder Bluff,61.4,80.8
    .turnin 1131 >> 转入Steelsnap
step
    .goto Thunder Bluff,60.8,81.5
    .accept 1136 >> 接受Frostmaw
step
    .goto Thunder Bluff,69.7,30.9
    .turnin 5062 >> 交出圣火
step
    .goto Thunder Bluff,70.1,30.9
    .accept 5088 >> 接受Arikara
step << Tauren wotlk
    .money <5.00
    .goto Mulgore,47.5,58.5
    .train 713 >> 前往血蹄村。坐火车，买你的坐骑
step << Tauren tbc
    #level 30
    .money <35.00
    .goto Mulgore,47.5,58.5
    .train 713 >> 前往血蹄村。坐火车，买你的坐骑
step
	#completewith next
    .goto Thunder Bluff,46.9,49.4
    .isOnQuest 879
    .fly Camp Taurajo >> 飞往陶拉霍营地
step
    .goto The Barrens,44.6,59.2
    >> 与笼子里的芒果对话
    .isOnQuest 879
    .turnin 879 >> 自首背叛
    .accept 906 >> 接受内部背叛
step
    .goto The Barrens,45.1,57.7
    .isOnQuest 893
    .turnin 893 >> 交出首选武器
    .accept 1153 >> 接受新的矿石样本
step
    .isOnQuest 885
    .goto The Barrens,44.9,59.1
    .turnin 885 >> 交给Washte Pawne
step
    .isOnQuest 884
    .goto The Barrens,44.9,59.1
    .turnin 884 >> 交给Owatanka
step
    .isOnQuest 883
    .goto The Barrens,44.9,59.1
    .turnin 883 >> 交给Lakota’mani
step
    #completewith next
    .goto The Barrens,44.4,59.0
    .fly Freewind Post >> 飞到Freewind Post
step
    #label flyskip
    .turnin 4767 >> 转入Wind Rider
    .goto Thousand Needles,44.8,49.0
    .turnin 9434 >> 开始测试补药
    .goto Thousand Needles,46.2,50.5
step << !Warrior
	#completewith next
    .goto Thousand Needles,46.1,51.5
    .home >> 将您的炉石设置为Freewind Post
step
    #sticky
    #completewith OreSample
    >>在执行其他任务时杀死你看到的科波德斯。掠夺他们以获取未经提炼的矿石样本
    .collect 5842,1 --Collect Unrefined Ore Sample (x1)
step
    .goto Thousand Needles,54.0,41.4
    >> 前往东北洞穴
    .turnin 1150 >> 耐久性转入试验
    .accept 1151 >> 接受强度试验
step
    >>杀死洛克阿利姆（岩石元素）。抢劫他的碎片。他在西部千针周围巡逻了一大圈。
    .goto Thousand Needles,29.3,33.6,40,0
    .goto Thousand Needles,27.1,28.7,40,0
    .goto Thousand Needles,22.5,31.3,40,0
    .goto Thousand Needles,17.5,27.0,40,0
    .goto Thousand Needles,12.8,20.9,40,0
    .goto Thousand Needles,9.3,21.0,40,0
    .goto Thousand Needles,21.1,40.6,40,0
    .goto Thousand Needles,34.3,37.5,40,0
    .goto Thousand Needles,33.2,53.5,40,0
    .goto Thousand Needles,29.3,33.6,40,0
    .goto Thousand Needles,27.1,28.7,40,0
    .goto Thousand Needles,22.5,31.3,40,0
    .goto Thousand Needles,17.5,27.0,40,0
    .goto Thousand Needles,12.8,20.9,40,0
    .goto Thousand Needles,9.3,21.0,40,0
    .goto Thousand Needles,21.1,40.6,40,0
    .goto Thousand Needles,34.3,37.5,40,0
    .unitscan Rok'Alim the Pounder
    .complete 1151,1 --Collect Fragments of Rok'Alim (x1)
step
	.goto Thousand Needles,31.2,36.9,30 >>沿着这条路跑
    .isOnQuest 5064
step
>>爬上山，穿过桥去寻找音符。抢劫箱子
    .goto Thousand Needles,32.0,32.6
    .complete 5064,1 --Collect Secret Note #1 (x1)
step
    .goto Thousand Needles,33.9,39.9
    .complete 5064,2 --Collect Secret Note #2 (x1)
step
    .goto Thousand Needles,39.3,41.6
    .complete 5064,3 --Collect Secret Note #3 (x1)
step
    .use 12785 >>清除篝火周围的暴徒，然后点燃篝火，然后杀死阿里卡拉。抢劫她
    .goto Thousand Needles,37.9,35.3
    .complete 5088,1 --Collect Arikara Serpent Skin (x1)
    .complete 5088,2 --Light the Sacred Fire of Life
step
    >>杀死Arnak Grimtotem。抢走他的蹄子
.goto Thousand Needles,38.6,27.4
    .complete 5147,1 --Collect Arnak's Hoof (x1)
	.unitscan Arnak Grimtotem
step
    .goto Thousand Needles,38.1,26.6
    .accept 4904 >> 最终免费接受
step
    >>跟随拉科塔，在整个护送过程中保护她。暴徒将定期在平台上滋生。
    .goto Thousand Needles,30.7,37.1
    .complete 4904,1 --Escort Lakota Windsong from the Darkcloud Pinnacle.
step
>>打开豹笼并杀死它。确保有冷却液/药剂可用
    .goto Thousand Needles,23.3,23.3
    .complete 5151,1 --Collect Hypercapacitor Gizmo (x1)
step
    .isOnQuest 4881
	>>当你接受任务的下一部分时，护送会开始。
	.goto Thousand Needles,21.3,32.0
	.turnin 4881 >> 交出刺杀阴谋
step
    .isQuestTurnedIn 4881
	>>当你接受任务的下一部分时，护送会开始。
	.goto Thousand Needles,21.3,32.0    
	.accept 4966 >> 接受保护Kanati Greycloud
step
    .isOnQuest 4966
	>>将产生3个暴徒。让卡纳提挑衅，然后干脆杀了他们
	.goto Thousand Needles,21.4,31.8
    .complete 4966,1 --Protect Kanati Greycloud
step
    .isQuestComplete 4966
	.goto Thousand Needles,21.4,31.8    
    .turnin 4966 >> 投案保护卡纳蒂·格雷科洛德
step
    #label OreSample
.goto Thousand Needles,21.5,32.3
    .turnin 5088 >> 交给Arikara
    .turnin 5151 >> 打开超级电容器Gizmo
step
    >>杀死该地区的Kobolds。掠夺他们以获取未经提炼的矿石样本
.goto Thousand Needles,9.2,21.0
    .collect 5842,1 --Collect Unrefined Ore Sample (x1)
step
    >>跑向费拉拉斯。我们将获得稍后的飞行路线
	.goto Feralas,88.9,41.2,50,0
    .goto Feralas,75.4,44.3
    .fp Mojache >> 获取Mojache营地飞行路线
step
	#completewith next
    .goto Feralas,75.4,44.4
    .fly Freewind Post >> 飞到Freewind Post
step
    .goto Thousand Needles,45.7,50.8
    .turnin 5064 >> 加入Grimtotem Spying
    .turnin 5147 >> 通缉犯-Arnak Grimtotem
step
    .goto Thousand Needles,46.0,51.5
    .turnin 4904 >> 最后免费上缴
step
    .goto Thousand Needles,53.9,41.4
    .turnin 1151 >> 强度转入试验
step
    .goto Thousand Needles,67.6,64.0
    .xp 30 >> 研磨至30级
step
    .isOnQuest 1146
    .goto Thousand Needles,67.6,64.0
    .turnin 1146 >> 加入蜂群成长
    .accept 1147 >> 接受蜂群的成长
step
    .xp <33,1
    >> 接受赛道周围的任务
	.accept 1110 >> 接受火箭汽车零件
    .goto Thousand Needles,77.8,77.2
	.accept 1104 >> 接受盐平毒液
    .goto Thousand Needles,77.9,77.2
    .accept 1105 >> 接受硬化壳
    .goto Thousand Needles,78.1,77.1
step
    .goto Thousand Needles,77.8,77.3
    .accept 1111 >> 接受码头管理员Dizzywig
    .accept 5762 >> 接受Hemet Nesingwarve Jr。
step
    .xp <33,1
    .accept 1176 >> 接受负载减轻
    .goto Thousand Needles,80.2,75.8
    .accept 1175 >> 接受道路上的碰撞
    .goto Thousand Needles,81.7,78.0
step
    .xp <33,1
	#sticky
	#completewith ShimmeringF
	>>把龟肉留着以后找。
	.collect 3712,10
step
    .isOnQuest 1175
   >>杀死该地区的Gazers。也杀死一些你看到的水晶皮
	.goto Thousand Needles,78.4,89.1
	.complete 1175,3 --Kill Saltstone Gazer (x6)
step
	#label ShimmeringF
    .isOnQuest 1110
	>>圈出杀戮和收集闪光平地任务的区域
	.complete -1110,1 --Collect Rocket Car Parts (x30)
	.complete -1104,1 --Collect Salty Scorpid Venom (x6)
	.complete -1176,1 --Collect Hollow Vulture Bone (x10)
    .complete -1105,1 --Collect Hardened Tortoise Shell (x9)
	.complete -1175,1 --Kill Saltstone Basilisk (x10)
	.complete -1175,2 --Kill Saltstone Crystalhide (x10)
step
	#sticky
	#label partsoftheswarm
    .isOnQuest 1110
	>>研磨硅磷脂生物直到你得到一个开裂的硅磷脂甲壳。点击它接受任务。
	.collect 5877,1,1148
	.accept 1148 >> 接受部分Swarm
step
    .isQuestTurnedIn 1146
    .goto Thousand Needles,67.8,85.7
	.complete -1148,1 --Collect Silithid Heart (x1)
    .complete -1148,2 --Collect Silithid Talon (x5)
    .complete -1147,3 --Kill Silithid Invader (x5)	
    .complete -1147,1 --Kill Silithid Searcher (x5)
    .complete -1148,3 --Collect Intact Silithid Carapace (x3)
    .complete -1147,2 --Kill Silithid Hive Drone (x5)	
step
	#requires partsoftheswarm
    .turnin -1147 >> 加入蜂群成长
    .goto Thousand Needles,67.6,63.9
step
    .turnin -1110 >> 交回火箭汽车零件
    .goto Thousand Needles,77.8,77.2
    .turnin -1104 >> 加入盐平毒液
    .goto Thousand Needles,78.0,77.1
    .turnin -1105 >> 转入硬化壳
    .goto Thousand Needles,78.1,77.1
step
    .xp <33,1
    .isQuestTurnedIn 1104
    .accept 1107 >> 接受包裹的尾翼
    .accept 1106 >> 接受流亡者马泰克
step
    .isOnQuest 1176
    .goto Thousand Needles,80.2,75.8
    .turnin 1176 >> 转向负载减轻
    .accept 1178 >> 接受地精赞助
step
    .isOnQuest 1175
    .goto Thousand Needles,81.6,78.0
    .turnin 1175 >> 在道路上转弯
step
    .isOnQuest 1152
    .goto Tanaris,51.6,25.4
    .abandon 1152 >> 放弃知识测试
step
    .goto Tanaris,51.6,25.4
    .fp Gadgetzan >> 获取Gadgetzan飞行路线
step << tbc
    #completewith next
    +如果您可以访问此服务器上的gold，请尽快将gold邮寄给自己，以便进行挂载训练！
step
    .zoneskip Tanaris,1
	#completewith next
    .hs >> Hearth to Freewind Post公司 << !Warrior
    .hs >> 火炉或飞向雷霆崖 << Warrior
    .cooldown item,6948,>0
step << !Warrior
    .goto Thousand Needles,45.1,49.2,-1
    .goto Tanaris,51.6,25.4,-1
    .fly Camp Taurajo >> 飞往陶拉霍营地
step << Warrior
    #completewith next
    .goto Thousand Needles,45.1,49.2,-1
    .goto Tanaris,51.6,25.4,-1
    .fly Thunder Bluff >> 飞向雷霆崖
    .zoneskip Thunder Bluff
step << Warrior
    .isOnQuest 1145
	#completewith next
    .goto Thunder Bluff,57.4,87.2
    .accept 1718 >>接受岛民
    .trainer >> 去训练你的职业咒语
step << Warrior
    .isOnQuest 1153
    .goto Thunder Bluff,47.0,49.8
    .fly Camp Taurajo >> 飞往陶拉霍营地
step << !Warrior
    .isOnQuest 1153
    .goto The Barrens,44.9,59.1
    .zone The Barrens >> 抵达荒野
step
    .isOnQuest 1153
    .goto The Barrens,45.1,57.7
    .turnin 1153 >> 交出新的矿石样本
step
    #completewith swarmgrows
    .goto The Barrens,44.4,59.1,-1
    .goto Thunder Bluff,47.0,49.8,-1
    .fly Crossroads >> 飞向十字路口
step
    .isOnQuest 906
    .goto The Barrens,51.5,30.9
    .turnin 906 >> 自首背叛
step
    #label swarmgrows
    .isQuestAvailable 1145
    .goto The Barrens,51.1,29.7
    .accept 1145 >> 接受蜂群的成长
step
    .isOnQuest 1148
    .goto The Barrens,51.1,29.6
    .turnin 1148 >> 交出部分蜂群
    .accept 1184 >> 接受部分Swarm
step
	#completewith next
    .goto The Barrens,51.5,30.3
    .fly Ratchet >> 飞到棘轮
step
    .goto The Barrens,63.3,38.4
    .turnin 1111 >> 交码头管理员Dizzywig
    .accept 1112 >> 接受Kravel的零件
step << Warrior
    .isOnQuest 874
    .goto The Barrens,65.8,43.8
    .turnin 874 >>提交Mahren Skyseer
    .accept 873 >>接受Isha Awak
step << Warrior
    .isOnQuest 873
	.goto The Barrens,65.6,47.1,40,0
    .goto The Barrens,63.3,54.2,40,0
	.goto The Barrens,65.6,47.1,40,0
    .goto The Barrens,63.3,54.2,40,0
	.goto The Barrens,65.6,47.1,40,0
    .goto The Barrens,63.3,54.2,40,0
	.goto The Barrens,65.6,47.1,40,0
    .goto The Barrens,63.3,54.2
    >>在水中寻找Isha Awak（红门槛）。杀死并掠夺它的心脏
    .complete 873,1 --Heart of Isha Awak (1)
	.unitscan Isha Awak
step << Warrior
    .isOnQuest 1718
    >>游到岛上
    .goto The Barrens,68.6,49.2
    .turnin 1718 >>《岛上居民》
    .accept 1719 >>接受争吵
step << Warrior
    .isOnQuest 1719
    .goto The Barrens,68.6,48.7
    .complete 1719,1 --Step on the grate to begin the Affray (1)
    .complete 1719,2 --Big Will (1)
step << Warrior tbc
    .isOnQuest 1719
    .goto The Barrens,68.6,49.2
    .turnin 1719 >>交出争吵
    .accept 1791 >>接受Windwatcher
step << Warrior wotlk
    #xprate >1.499 
    .isOnQuest 1719
    .goto The Barrens,68.6,49.2
    .turnin 1719 >>交出争吵
step << Warrior
    .isOnQuest 873
    .goto The Barrens,65.8,43.8
    .turnin 873 >>交给Isha Awak
step << Warrior
    .abandon 1838 >>抛弃残忍的盔甲
step
    .xp <33,1
    #completewith next
	+去码头。乘船去荆棘谷
   .goto The Barrens,63.7,38.6,15,0
	.goto The Barrens,63.7,38.6
step
    .xp <33,1
	.maxlevel 36
	.zone Stranglethorn Vale >>抵达荆棘谷
step << Shaman
    .xp <33,1
	.maxlevel 36
	#label Protection
	#completewith BigStick
 .goto Stranglethorn Vale,28.3,75.5
    .vendor >> 去小贩那里，如果商店里有保护人员或大棒，就去买。
    .collect 12252,1
step << Shaman
    .xp <33,1
	.maxlevel 36
	#label BigStick
	#completewith Protection 
 .goto Stranglethorn Vale,28.3,75.5
    .collect 12251,1
step
    .xp <33,1
	.isQuestTurnedIn 1178
    .goto Stranglethorn Vale,26.4,73.5
    .turnin 1180 >> 提交地精赞助
    .accept 1181 >> 接受地精赞助
step
    .xp <33,1
	.isQuestTurnedIn 1180
	>> 前往建筑物的第二层
    .goto Stranglethorn Vale,28.3,77.6
    .accept 575 >> 接受供应和需求
step
    .xp <33,1
	.isQuestTurnedIn 1180
	>> 去客栈吧，这个任务在底层
    .goto Stranglethorn Vale,27.0,77.2
    .accept 605 >> 接受唱蓝碎片
step
    .xp <33,1
	.isQuestTurnedIn 1180
	>> 这些任务在客栈的顶层
	.goto Stranglethorn Vale,27.1,77.3
    .accept 189 >> 接受血鳞耳
    .accept 213 >> 接受敌对接管
    .accept 201 >> 接受调查营地
step
    .xp <33,1
	.isQuestTurnedIn 1180
    .goto Stranglethorn Vale,27.2,76.9
    .turnin 1181 >> 提交地精赞助
    .accept 1182 >> 接受地精赞助
step << Rogue
    .xp <33,1
	.isQuestTurnedIn 1180
	#completewith next
    .goto Stranglethorn Vale,26.8,77.2
	.trainer >> 去训练你的职业咒语
step
    .xp <33,1
	.isQuestTurnedIn 1180
    .goto Stranglethorn Vale,26.9,77.0
    .fp Booty Bay >> 获取Booty Bay飞行路线
step
    .xp <33,1
    #completewith next
	+去码头。把船带回棘轮。
   .goto The Barrens,63.7,38.6,15,0
	.goto The Barrens,63.7,38.6
step
    .xp <33,1
	.maxlevel 36
	.zone The Barrens >>乘坐棘轮抵达
step
    .xp >33,1
    .goto Ashenvale,73.2,61.5,-1
    .goto The Barrens,63.1,37.1,-1
    .fly Orgrimmar >> 飞往奥格瑞玛
step << Paladin
    .xp >33,1
    .isOnQuest 1145
	#completewith next
    .goto Orgrimmar,32.4,35.8
    .trainer >> 去训练你的职业咒语
step << Shaman
    .xp >33,1
    .isOnQuest 1145
	#completewith next
    .goto Orgrimmar,38.6,36.0
    .trainer >> 去训练你的职业咒语
step << Hunter
    .xp >33,1
    .isOnQuest 1145
	#completewith next
    .goto Orgrimmar,66.1,18.5
    .trainer >> 去训练你的职业咒语
step << Hunter
    .xp >33,1
    .isOnQuest 1145
	#completewith next
    .goto Orgrimmar,66.3,14.8
    .trainer >> 去训练你的宠物法术吧
step << Rogue
    .xp >33,1
    .isOnQuest 1145
	#completewith next
    .goto Orgrimmar,44.0,54.6
    .trainer >> 去训练你的职业咒语
step << Warlock
    .xp >33,1
    .isOnQuest 1145
	#completewith next
    .goto Orgrimmar,48.0,46.0
    .trainer >> 去训练你的职业咒语
step << Warlock
    .xp >33,1
    .isOnQuest 1145
	#completewith next
    .goto Orgrimmar,47.5,46.7
    .vendor >> 买你的宠物书
	.collect 16368,1
step << Mage
    .xp >33,1
    .isOnQuest 1145
	#completewith next
    .goto Orgrimmar,38.8,85.6
    .trainer >> 去训练你的职业咒语
step << Priest
    .xp >33,1
    .isOnQuest 1145
	#completewith next
    .goto Orgrimmar,35.6,87.8
    .trainer >> 去训练你的职业咒语
step
    .xp >33,1
    .isOnQuest 1145
    .goto Orgrimmar,75.2,34.2
    .turnin 1145 >> 加入蜂群成长
    .accept 1146 >> 接受蜂群的成长
step << !Shaman !Warrior
    .maxlevel 32
    .goto Orgrimmar,54.1,68.4
    .home >>将你的炉石置于力量谷
step << Orc !Warlock tbc
	#sticky
	#completewith next
	.money <35.00
	.goto Orgrimmar,63.3,12.8
	.train 149 >> 前往荣誉谷。乘坐火车并购买您的坐骑
step << Troll !Warlock tbc
	#sticky
	#completewith next
	.money <35.00
	.goto Durotar,55.2,75.5
	.train 533 >> 前往Durotar的Sen'jin村乘坐火车并购买您的坐骑
step << Shaman
    .isOnQuest 874
	#completewith next
    .goto Orgrimmar,45.1,63.9
    .fly Ratchet >>飞到棘轮
step << Shaman
    .isOnQuest 874
    .goto The Barrens,65.8,43.8
    .turnin 874 >>提交Mahren Skyseer
    .accept 873 >>接受Isha Awak
step << Shaman
    .isOnQuest 220
    .goto The Barrens,65.8,43.8
    .turnin 220 >>水的召唤
    .accept 63 >>接受水的召唤
step << Shaman
    .isOnQuest 873
	.goto The Barrens,65.6,47.1,40,0
    .goto The Barrens,63.3,54.2,40,0
	.goto The Barrens,65.6,47.1,40,0
    .goto The Barrens,63.3,54.2,40,0
	.goto The Barrens,65.6,47.1,40,0
    .goto The Barrens,63.3,54.2,40,0
	.goto The Barrens,65.6,47.1,40,0
    .goto The Barrens,63.3,54.2
    >>在水中寻找Isha Awak（红门槛）。杀死并掠夺它的心脏
    .complete 873,1 --Heart of Isha Awak (1)
	.unitscan Isha Awak
step << Shaman
    .isOnQuest 873
    .goto The Barrens,65.8,43.8
    .turnin 873 >>交给Isha Awak
step << Tauren tbc
    .money <35.00
    .goto The Barrens,63.1,37.1,-1
    .goto Orgrimmar,45.1,63.9,-1
    .fly Thunder Bluff >>飞到雷霆崖，我们要去乘火车
step << Tauren tbc
    .money <35.00
    .goto Mulgore,47.5,58.5
    .train 713 >> 沿着电梯走下去，然后去血蹄村。坐火车，买你的坐骑
step << Warrior/Shaman
	#completewith next
    .goto The Barrens,63.1,37.1,-1
    .goto Thunder Bluff,46.9,49.9,-1
    .fly Orgrimmar >>飞往奥格瑞玛
step << Tauren
    #completewith next
    .goto Thunder Bluff,46.9,49.9,-1
    .fly Orgrimmar >>飞往奥格瑞玛    
step << Shaman
    .isQuestAvailable 1531
    .goto Orgrimmar,38.0,37.7
    .accept 1531 >>接受空中呼叫
step << Warrior
	#completewith next
	.goto Orgrimmar,81.5,19.6
	.train 2567 >> 从河岸扔来的火车
step << Warrior/Shaman
	#completewith next
    .xp <33,1
    .goto Orgrimmar,54.1,68.4
    .home >>将你的炉石置于力量谷
step << Undead !Warlock tbc
    .money <35.00
    .goto Durotar,50.8,13.7
    .zone Tirisfal Glades >> 登上齐柏林飞艇前往蒂里斯法尔·格拉德斯，我们要买我们的坐骑。
    >> 如果你能传送到幽暗城，跳过这一步 << Mage
step << Undead !Warlock tbc
    .money <35.00
    .goto Tirisfal Glades,60.1,52.6
    .train 554 >> 乘坐火车并购买您的坐骑
    .zoneskip Tirisfal Glades,1
step << Blood Elf !Warlock tbc
    .money <35.00
    .goto Durotar,50.8,13.7
    .zone Tirisfal Glades >> 登上齐柏林飞艇前往蒂里斯法尔·格拉德斯，我们要买我们的坐骑。
    >> 如果你可以传送到地下城或银月，请跳过此步骤 << Mage
step << Blood Elf !Warlock tbc
    .money <35.00
    .goto Undercity,66.3,4.5,30,0
    .goto Undercity,54.9,11.3
    .zone Silvermoon City >> 点击易位球前往银月城
    .zoneskip Orgrimmar
step << Blood Elf !Warlock tbc
    .money <35.00
    .goto Eversong Woods,61.1,54.7,5,0
    .goto Eversong Woods,61.4,54.0
    .train 33388 >> 离开银月城，然后乘火车去买你的坐骑。
    .zoneskip Orgrimmar
step << Blood Elf !Warlock tbc
    .goto Silvermoon City,49.4,14.3
    >> 如果可以的话，传送到幽暗城 << Mage
    .zone Undercity >> 点击易位之珠前往幽冥城
    .zoneskip Orgrimmar
step << Blood Elf !Warlock tbc
    .goto Tirisfal Glades,61.9,59.1
    .zone Stranglethorn Vale >> 登上齐柏林飞艇前往荆棘谷
    .zoneskip Tirisfal Glades,1
step << Undead !Warlock tbc
    .goto Tirisfal Glades,61.9,59.1
    .zone Stranglethorn Vale >> 登上齐柏林飞艇前往荆棘谷
    .zoneskip Tirisfal Glades,1
]])
