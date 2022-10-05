RXPGuides.RegisterGuide([[
#classic
<< Horde
#name 1-10 杜隆塔尔
#version 1
#group RestedXP 部落 1-22
#defaultfor Troll/Orc
#next 10-12 杜隆塔尔

step << !Orc !Troll
    #sticky
    #completewith next
    .goto Durotar,43.3,68.5
    +您选择了一个为兽人和巨魔准备的指南。你应该选择与你开始时相同的起始区域
step
    .goto Durotar,43.3,68.5
    .accept 4641 >>接受你在世界上的位置
step << Warlock
    #sticky
    #completewith next
    +杀死野猪10美分以上的供应商垃圾
    .goto Durotar,44.0,71.3,60,0
step << Warlock
    .goto Durotar,42.6,69.0
    .accept 1485 >>接受邪恶的家人
step << Warrior/Shaman
    #sticky
    #completewith next
    +杀死野猪10美分以上的供应商垃圾
    .goto Durotar,44.2,65.9,40,0
step << Warrior/Shaman
    .goto Durotar,42.6,67.3
    .vendor >>供应商垃圾。供应商铠装（如果低于10c）
step << Warrior
    .goto Durotar,42.9,69.4
    .train 6673 >>火车战斗呐喊
step << Shaman
    .goto Durotar,42.4,69.0
    .train 8017 >>训练投石武器
step
    .goto Durotar,42.1,68.4
    .turnin 4641 >>在世界上找到你的位置
    .accept 788 >>接受切削齿
step << Warlock
    .goto Durotar,40.6,68.4
    .vendor >>恶魔驯兽师的小贩垃圾
step << Warlock
     .goto Durotar,40.6,68.5
    .train 348 >>火车献祭
step << !Warlock
	#som
	#phase 3-6
	#completewith BoarsX
    .goto Durotar,41.9,63.7,0
	>>在执行其他任务时杀死野猪
    .complete 788,1 --Mottled Boar (10)
step << !Warlock
    #sticky
    #label mboars
	#era/som
    .goto Durotar,41.9,63.7
    .complete 788,1 --Mottled Boar (10)
step << Warlock
    #completewith next
	>>在前往卑鄙家族的途中杀死斑纹野猪。在进入Familiars之前，尝试进入2级。不要坐着喝酒
    .complete 788,1 --Mottled Boar (10)
step << Warlock
    #label WarlockBoars
    .goto Durotar,45.0,57.4,90 >> 跑向家人
step << Warlock
    .goto Durotar,45.3,56.9
    >>杀死邪恶家族的头颅
    .complete 1485,1 --Vile Familiar Head (6)
step << Warlock
	#completewith BoarAndyW
    .goto Durotar,40.6,62.6,0
    >>结束杀死斑纹野猪
    .complete 788,1 --Mottled Boar (10)
step << Warlock
	>>途中磨碎野猪
    .goto Durotar,40.6,62.6
    .accept 790 >>接受Sarkoth
step << !Warlock
    .goto Durotar,40.6,62.6
    .accept 790 >>接受Sarkoth
step
    >>杀死萨科特。抢走他的爪子
    .goto Durotar,40.7,65.2,30,0
    .goto Durotar,40.7,67.3
    .complete 790,1 --Sarkoth's Mangled Claw (1)
step
    #label BoarAndyW
    .goto Durotar,40.6,62.6
    .turnin 790 >>转入Sarkoth
    .accept 804 >>接受Sarkoth
step << !Warlock
    #requires mboars
step << Warlock
    .goto Durotar,40.6,62.6
    >>结束杀死斑纹野猪
    .complete 788,1 --Mottled Boar (10)
step << Warlock
	#era/som
    .xp 3+850>>在回镇的路上研磨至850+/1400xp
step << Warlock
	#som
	#phase 3-6
    .xp 3 >> 在回镇的路上磨合到3级
step << Warlock
	#era/som
	.goto Durotar,42.6,67.3
    .vendor >>供应商垃圾和购买10水
step << Warlock
	#som
	#phase 3-6
	.goto Durotar,42.6,67.3
    .vendor >>供应商垃圾和购买10水
step << Warlock
    .goto Durotar,42.6,69.0
    .turnin 1485 >>交给卑鄙的家人
    .accept 1499 >>接受邪恶的家人
step << Warlock
    >>选择匕首并装备它。记得召唤你的小鬼
	.goto Durotar,42.9,69.1
    .turnin 1499 >>交给卑鄙的家人
    .accept 794 >>接受燃烧之刃奖章
step
	#era/som
    .goto Durotar,42.1,68.3
    .turnin 788 >>转入切削齿
    .turnin 804 >>转入Sarkoth
    .accept 789 >>接受蝎子的刺
    .accept 2383 >>接受简单的羊皮纸 << Orc Warrior
    .accept 3065 >>接受简单平板电脑 << Troll Warrior
    .accept 3082 >>接受蚀刻片 << Troll Hunter
    .accept 3083 >>接受加密平板电脑 << Troll Rogue
    .accept 3084 >>接受符文书写板 << Troll Shaman
    .accept 3085 >>接受神圣平板电脑 << Troll Priest
    .accept 3086 >>接受字形数字化仪 << Troll Mage
    .accept 3087 >>接受蚀刻羊皮纸 << Orc Hunter
    .accept 3088 >>接受加密的羊皮纸 << Orc Rogue
    .accept 3089 >>接受铭文羊皮纸 << Orc Shaman
    .accept 3090 >>接受染色羊皮纸 << Orc Warlock
step
	#som
	#phase 3-6
    .goto Durotar,42.1,68.3
    .turnin 804 >>转入Sarkoth
    .turnin 788 >>转入切削齿
    .accept 2383 >>接受简单的羊皮纸 << Orc Warrior
    .accept 3065 >>接受简单平板电脑 << Troll Warrior
    .accept 3082 >>接受蚀刻片 << Troll Hunter
    .accept 3083 >>接受加密平板电脑 << Troll Rogue
    .accept 3084 >>接受符文书写板 << Troll Shaman
    .accept 3085 >>接受神圣平板电脑 << Troll Priest
    .accept 3086 >>接受字形数字化仪 << Troll Mage
    .accept 3087 >>接受蚀刻羊皮纸 << Orc Hunter
    .accept 3088 >>接受加密的羊皮纸 << Orc Rogue
    .accept 3089 >>接受铭文羊皮纸 << Orc Shaman
    .accept 3090 >>接受染色羊皮纸 << Orc Warlock
	.isQuestComplete 788
step
	#som
	#phase 3-6
    .goto Durotar,42.1,68.3
    .turnin 804 >>转入Sarkoth
    .accept 2383 >>接受简单的羊皮纸 << Orc Warrior
    .accept 3065 >>接受简单平板电脑 << Troll Warrior
    .accept 3082 >>接受蚀刻片 << Troll Hunter
    .accept 3083 >>接受加密平板电脑 << Troll Rogue
    .accept 3084 >>接受符文书写板 << Troll Shaman
    .accept 3085 >>接受神圣平板电脑 << Troll Priest
    .accept 3086 >>接受字形数字化仪 << Troll Mage
    .accept 3087 >>接受蚀刻羊皮纸 << Orc Hunter
    .accept 3088 >>接受加密的羊皮纸 << Orc Rogue
    .accept 3089 >>接受铭文羊皮纸 << Orc Shaman
    .accept 3090 >>接受染色羊皮纸 << Orc Warlock
step << Orc Rogue
      .goto Durotar,41.3,68.0
    .turnin 3088 >>交上加密羊皮纸
step << Troll Rogue
      .goto Durotar,41.3,68.0
    .turnin 3083 >>提交加密平板电脑
step << Orc Warlock
    #completewith next
	.goto Durotar,40.6,68.4
    .vendor >>恶魔驯兽师的小贩垃圾
step << Orc Warlock
     .goto Durotar,40.6,68.5
    .turnin 3090>>交上染色的羊皮纸
    .trainer >> 训练你的职业咒语
step << Shaman/Priest/Mage
    .goto Durotar,42.6,67.3
    .vendor >>供应商垃圾和购买10水
step << Warrior/Rogue
    .goto Durotar,42.6,67.3
    .vendor >>供应商垃圾
step << Hunter
    .goto Durotar,42.6,67.3
    .vendor >>供应商垃圾。购买箭，直到你的Quiver满为止（1000支箭）
step
    #era
	.goto Durotar,42.7,67.3
    .accept 4402 >>接受Galgar的仙人掌苹果惊喜
step << Orc Hunter
    .goto Durotar,42.8,69.3
    .turnin 3087 >>交上蚀刻羊皮纸
step << Troll Hunter
    .goto Durotar,42.8,69.3
    .turnin 3082 >>上交蚀刻片
step << Troll Mage
    .goto Durotar,42.5,69.0
    .turnin 3086 >>上交字形写字板
    .trainer >> 训练你的职业咒语
step << Troll Priest
    .goto Durotar,42.4,68.8
    .turnin 3085 >>交上神圣的平板电脑
    .trainer >> 训练你的职业咒语
step << Troll Shaman
    .goto Durotar,42.4,69.0
    .turnin 3084 >>交上符文书写板
step << Orc Shaman
    .goto Durotar,42.4,69.0
    .turnin 3089 >>交上铭文羊皮纸
step << Orc Warrior
    .goto Durotar,42.9,69.4
    .turnin 2383 >>交上简单的羊皮纸
step << Troll Warrior
    .goto Durotar,42.9,69.4
    .turnin 3065 >>交回简单平板电脑
step << !Warlock
    .goto Durotar,42.9,69.1
    .accept 792 >>接受邪恶的家人
step
    .goto Durotar,44.6,68.7
    .accept 5441 >>接受懒惰的Peons
step
       #era
	#sticky
    #label Apples
    >>掠夺你看到的带苹果的仙人掌
    .complete 4402,1 --Cactus Apple (10)
step
    #sticky
    #label Peons
   .use 16114 >>用Foreman的21点叫醒树旁熟睡的Peons（把它放在你的吧台上，让它更容易使用）
    .complete 5441,1 --Peons Awoken (5)
step << !Warlock
	#era/som
    #sticky
    #completewith imps
    .goto Durotar,47.1,65.2,30,0
    >>在去洞穴的路上杀死蝎子以获取一些尾巴
    .complete 789,1 --Scorpid Worker Tail (10)
step << Warlock
	#era/som
    >>杀死蝎子的尾巴
    .complete 789,1 --Scorpid Worker Tail (10)
    .goto Durotar,47.1,65.2,80,0
    .goto Durotar,46.6,58.2,80,0
    .goto Durotar,39.8,63.5
step << !Warlock
    #label imps
    .goto Durotar,45.2,56.8
    >>在山洞前杀死小鬼
    .complete 792,1 --Vile Familiar (12)
step << !Warlock
	#era/som
    >>完成蝎子尾巴
    .goto Durotar,39.8,63.5
    .complete 789,1 --Scorpid Worker Tail (10)
step
    #era
    #requires Apples
step
    #requires Peons
step
    #era
    .goto Durotar,44.0,65.3
    >>完成对仙人掌苹果的掠夺
    .complete 4402,1 --Cactus Apple (10)
step
	#label BoarsX
    .goto Durotar,47.09,57.93
   .use 16114 >>把树周围的Peons叫醒。如果你很难找到睡觉的地方，就退一步。
    .complete 5441,1 --Peons Awoken (5)
step << !Warlock
	#som
	#phase 3-6
    .goto Durotar,41.9,63.7
	>>杀死野猪
    .complete 788,1 --Mottled Boar (10)
step
    #era
    .goto Durotar,42.7,67.2
    .turnin 4402 >>交给Galgar的仙人掌苹果惊喜
step << !Mage !Priest !Warlock
    .goto Durotar,42.6,67.3
    .vendor >>供应商垃圾
step << Mage/Priest/Warlock
    .goto Durotar,42.6,67.3
    .vendor >>供应商垃圾。购买10杯水
step
	#era/som
    .goto Durotar,42.1,68.3
    .turnin 789 >>掉进蝎子刺
step << !Warlock
	#som
	#phase 3-6
    .goto Durotar,42.1,68.3
    .turnin 788 >>转入切削齿
step << Shaman
    .goto Durotar,42.4,69.1
    .accept 1516 >>接受地球的召唤
    .trainer >> 训练你的职业咒语
step << Shaman
    .goto Durotar,42.9,69.1
    >>选择员工
    .turnin 792 >>交给卑鄙的家人
    .accept 794 >>接受燃烧之刃奖章
step << Mage
    .goto Durotar,42.5,69.0
    .trainer >> 训练你的职业咒语
step << Priest
    .goto Durotar,42.4,68.8
    .trainer >> 训练你的职业咒语
step << !Shaman !Warlock
    .goto Durotar,42.9,69.1
    .turnin 792 >>交给卑鄙的家人
    .accept 794 >>接受燃烧之刃奖章
step << Hunter
    .goto Durotar,42.8,69.3
    .trainer >> 训练你的职业咒语
step << Warrior
    .goto Durotar,42.9,69.4
    .trainer >> 训练你的职业咒语
step
    .goto Durotar,44.6,68.7
    .turnin 5441 >>交上懒惰的Peons
    .accept 6394 >>接受Thaz'ril的选择
step << Shaman
    #sticky
	#label Hooves
    >>为了蹄子杀死恶棍
    .complete 1516,1 --Felstalker Hoof (2)
step
    >>跑进山洞。走进中间的房间，抢走皮克
    .goto Durotar,45.2,56.8,60,0
    .goto Durotar,43.7,53.8
    .complete 6394,1 --Thazz'ril's Pick (1)
step
    #sticky
	#label Yarrog
    .goto Durotar,44.7,54.0,30,0
    .goto Durotar,43.4,52.0,30,0
    >>杀死亚罗格。抢他拿奖章
    .goto Durotar,42.7,53.0
    .complete 794,1 --Burning Blade Medallion (1)
step << !Shaman
	#som
	#phase 3-6
    .xp 5+650>>研磨至650+/2800xp
step << !Shaman
	#som
	#phase 1-2
    .xp 5+1225>>研磨至1225+/2800xp
step << !Shaman
	#era
    .xp 5+1680>>研磨至1680+/2800xp
step << Shaman
	#era/som
	#requires Hooves
    .xp 5+690>>研磨至690+/2800xp
step << Shaman
	#som
	#phase 3-6
	#requires Hooves
    .xp 5+200>>研磨至200+/2800xp
step
    #requires Yarrog
	.hs >>从炉膛到审判谷
step
    .goto Durotar,44.6,68.6
    .turnin 6394 >>交给Thaz'ril的Pick
step
    >>保存你得到的治疗药水，你以后可能需要它来对付半人马
    .goto Durotar,42.8,69.1
    .turnin 794 >>交出燃烧之刃奖章
    .accept 805 >>接受向森津村的报告
step << !Shaman
    .xp 6 >> 研磨至6级
step << Priest
    .goto Durotar,42.4,68.8
    .accept 5649 >> 有利于精神
    .trainer >> 训练你的职业咒语
step << Mage
    .goto Durotar,42.5,69.0
    .trainer >> 训练你的职业咒语
step << Shaman
    .goto Durotar,42.4,69.2
    .turnin 1516 >>地球的召唤
    .accept 1517 >>接受地球的召唤
step << Hunter
    .goto Durotar,42.8,69.3
    .trainer >> 训练你的职业咒语
step << Warrior
    .goto Durotar,42.9,69.4
    .trainer >> 训练你的职业咒语
step << Rogue
    .goto Durotar,41.3,68.0
    .trainer >> 训练你的职业咒语
step << Warlock
    .goto Durotar,40.6,68.5
    .trainer >> 训练你的职业咒语
    .goto Durotar,40.6,68.4
    .vendor >> 如果你在训练后有钱，就买血盟书（否则以后再买）
step << Shaman
    .goto Durotar,43.0,71.2,22,0
    .goto Durotar,41.5,73.3,14,0
    .goto Durotar,40.8,74.1,14,0
    .goto Durotar,41.8,74.8,14 >>运行隐藏路径
step << Shaman
    >>用你袋子里的地球皂甙
    .goto Durotar,44.0,76.2
    .turnin 1517 >>地球的召唤
    .accept 1518 >>接受地球的召唤
step << Shaman
    .goto Durotar,42.4,69.1
    .turnin 1518 >>地球的召唤
    .trainer >> 训练你的职业咒语
step
    >>离开起始区域
    .goto Durotar,52.1,68.3
    .accept 2161 >>接受佩恩的负担
step
	#era/som
    .goto Durotar,54.3,73.3,25,0
    .goto Durotar,54.5,75.0,25,0
    .goto Durotar,54.1,76.6,25,0
    .goto Durotar,54.1,76.6,0
    >>探索者巡视了一下
    .accept 786 >>接受Thwarting Kolkar侵略
step
    .goto Durotar,56.0,73.9
    .accept 817 >>接受实际猎物
step
    .goto Durotar,55.9,74.4
    .accept 818 >>接受溶剂精神
step
    .goto Durotar,55.9,74.7
    .turnin 805 >>向森津村提交报告
    .accept 808 >>接受Minshina的骷髅
    .accept 826 >>接受Zalazane
    .accept 823 >>接受向Orgnil的报告
step << Rogue
    .goto Durotar,56.29,73.40
    .vendor >> 购买K'Waii投掷的3级装备
step << Shaman
    .goto Durotar,56.5,73.1
    >>修理你的武器。如果你有足够的钱（5s4c），请从Traxexir购买一根手杖。否则，请跳过此步骤（稍后再回来）
    .collect 2495,1 --Collect Walking Stick
step << Rogue
    .goto Durotar,56.5,73.1
     >>修理你的武器。如果你有足够的钱（4s1c），请从Traxexir购买细高跟鞋。否则，请跳过此步骤（稍后再回来）
    .collect 2494,1 --Collect Stiletto
step << Orc Warrior
    .goto Durotar,56.5,73.1
    >>修理你的武器。如果你有足够的钱（4s84c），请从Traxexir购买一把大斧头。否则，请跳过此步骤（稍后再回来）
    .collect 2491,1 --Collect Large Axe
step << Troll Warrior
    .goto Durotar,56.5,73.1
    >>修理你的武器。如果你有足够的钱（5s40c），就从Traxexir买一辆Tomahawk。否则，请跳过此步骤（稍后再回来）
    .collect 2490,1 --Collect Tomahawk
step << Hunter
    .goto Durotar,56.5,73.1
    >>修理你的武器。如果你有足够的钱（2秒85美分），请从Traxexir购买Hornwood Recurrive Bow。否则，请跳过此步骤（稍后再回来）
    .collect 2506,1 --Collect Hornwood Recurve Bow
step
	#era/som
    #sticky
    #completewith next
    .goto Durotar,59.7,71.7,50,0
    .goto Durotar,57.6,77.9,50,0
    >> 沿着海滩奔跑，尽可能多地杀死爬行动物和马克鲁拉，以获取黏液和眼睛。您不必在此处完成此步骤。
    .complete 818,2 --Crawler Mucus (8)
    .complete 818,1 --Intact Makrura Eye (4)
step
	#era/som
    .goto Durotar,52.1,83.3,75 >> 到达海滩尽头
step
	#era/som
    .goto Durotar,50.9,79.2,30 >>进入科尔卡基地
step << Priest
	#era/som
    #sticky
	#softcore
    >>在整个杜隆塔尔，开始收集3堆亚麻布。这将用于稍后制作魔杖
    >>如果你已经买了根魔杖，或者可以从AH那里买到便宜的，那么跳过这一步。
    .collect 2589,60 --Linen Cloth (60)
step << Priest
	#era/som
    #sticky
	#hardcore
    >>在整个杜隆塔尔，开始收集3堆亚麻布。这将用于稍后制作魔杖
    .collect 2589,60 --Linen Cloth (60)
step
	#era/som
    .unitscan Warlord Kolkanis
    #sticky
    #completewith Bonfire
    +如果是稀有的，在你7级时杀死它。确保使用早期的治疗药剂。
step
	#era/som
    >>在帐篷里的地上焚烧卷轴
    .goto Durotar,49.8,81.2
    .complete 786,1 --Attack Plan: Valley of Trials destroyed (1)
step
	#era/som
    >>在地上焚烧卷轴
    .goto Durotar,47.7,77.4
    .complete 786,2 --Attack Plan: Sen'jin Village destroyed (1)
step
	#era/som
    #label Bonfire
    >>在地上焚烧卷轴
    .goto Durotar,46.3,79.0
    .complete 786,3 --Attack Plan: Orgrimmar destroyed (1)
step
	#era/som
    #softcore
    .goto Durotar,57.5,73.3,200 >> 在篝火中死去，在精神治疗者那里重生，或者逃跑
step << Shaman
	#era/som
    #softcore
    .goto Durotar,56.5,73.1
    >>修理你的武器。如果你有足够的钱（5s4c），请从Traxexir购买一根手杖。否则，请跳过此步骤（稍后再回来）
	>>你可以从外面和他说话
    .collect 2495,1 --Collect Walking Stick
step << Rogue
	#era/som
    #softcore
    .goto Durotar,56.5,73.1
     >>修理你的武器。如果你有足够的钱（4s1c），请从Traxexir购买细高跟鞋。否则，请跳过此步骤（稍后再回来）
	>>你可以从外面和他说话
    .collect 2494,1 --Collect Stiletto
step << Orc Warrior
	#era/som
    #softcore
    .goto Durotar,56.5,73.1
    >>修理你的武器。如果你有足够的钱（4s84c），请从Traxexir购买一把大斧头。否则，请跳过此步骤（稍后再回来）
	>>你可以从外面和他说话
    .collect 2491,1 --Collect Large Axe
step << Troll Warrior
	#era/som
    #softcore
    .goto Durotar,56.5,73.1
    >>修理你的武器。如果你有足够的钱（5s40c），就从Traxexir买一辆Tomahawk。否则，请跳过此步骤（稍后再回来）
	>>你可以从外面和他说话
    .collect 2490,1 --Collect Tomahawk
step << Hunter
	#era/som
    #softcore
    .goto Durotar,56.5,73.1
    >>修理你的武器。如果你有足够的钱（2秒85美分），请从Traxexir购买Hornwood Recurrive Bow。否则，请跳过此步骤（稍后再回来）
	>>你可以从外面和他说话
    .collect 2506,1 --Collect Hornwood Recurve Bow
step
    #softcore
    #completewith next
    .goto Durotar,57.3,53.5,120 >>死于地拉加德要塞外的北塔。在剃刀山重生
step
	#era/som
    #hardcore
    #completewith next
    .goto Durotar,50.9,79.2,50,0
    .goto Durotar,52.5,44.4,120 >>离开科尔卡尔基地。在去剃须刀山的路上碾碎暴徒
step
	#som
	#phase 3-6
    #hardcore
    #completewith next
    .goto Durotar,52.2,43.2,120 >>前往剃须山
step
    .goto Durotar,52.2,43.2
    .turnin 823 >>向Orgnil提交报告
    .accept 806 >>接受黑暗风暴
step
    >>煤仓内，顶层
    .goto Durotar,51.9,43.5
    .accept 784 >>接受征服背叛者
    .accept 837 >>接受侵犯
step
    .goto Durotar,51.1,42.4
    .accept 815 >>接受打破几个鸡蛋
step
    #completewith next
    .goto Durotar,50.2,43.1,15 >>沿着这条小路走
step
    >>爬上塔楼
    .goto Durotar,49.9,40.3
    .accept 791 >>接受负重
step << Shaman
    .goto Durotar,52.0,40.5
    >>修理你的武器。如果你有足够的钱（5s4c），从乌戈尔买一根拐杖。否则，请跳过此步骤（稍后再回来）
    .collect 2495,1 --Collect Walking Stick
step << Rogue
    .goto Durotar,52.0,40.5
     >>修理你的武器。如果你有足够的钱（4s1c），从乌戈尔买一个细高跟鞋。否则，请跳过此步骤（稍后再回来）
    .collect 2494,1 --Collect Stiletto
step << Orc Warrior
    .goto Durotar,52.0,40.5
    >>修理你的武器。如果你有足够的钱（4s84c），从乌戈尔买一把大斧子。否则，请跳过此步骤（稍后再回来）
    .collect 2491,1 --Collect Large Axe
step << Troll Warrior
    .goto Durotar,52.0,40.5
    >>修理你的武器。如果你有足够的钱（5s40c），从乌戈尔买一辆战斧。否则，请跳过此步骤（稍后再回来）
    .collect 2490,1 --Collect Tomahawk
step << Hunter
	#completewith next
    .goto Durotar,53.0,41.0
    >>修理你的武器。如果你有足够的钱（2s85c），从Ghrawt买一把Hornwood Recurve Bow。否则，请跳过此步骤（稍后再回来）
    .collect 2506,1 --Collect Hornwood Recurve Bow
step << Hunter
    .goto Durotar,53.0,41.0
    .vendor >> 从Ghrawt那里买足够的箭来装满你的箭袋
step << Warrior/Rogue
    .goto Durotar,52.0,40.7
    .money <0.0020
    .train 2018 >> 火车铁匠。锻造允许你制造锐化宝石（+2武器伤害，持续1小时）。如果你愿意，可以跳过锻造和采矿
step << Warrior/Rogue
    .goto Durotar,51.8,40.9
    .money <0.0010
    .trainer 2580 >> 训练采矿。在你的魔法书中施放“寻找矿物”
step << Warrior/Rogue
    .goto Durotar,53.0,42.0
    .money <0.0081
    .collect 2901,1 >> 购买采矿镐。留意我的静脉，用铁匠技术为你的武器制作磨石
step << !Warrior !Rogue !Hunter
    .goto Durotar,51.5,41.6
    .turnin 2161 >>交出佩恩的负担
    .home >> 把你的炉石放在剃刀山
    .vendor >> 尽可能多地购买5级水
step << Warrior/Rogue/Hunter
    .goto Durotar,51.5,41.6
    .turnin 2161 >>交出佩恩的负担
    .home >> 把你的炉石放在剃刀山
    .vendor >> 购买最多20种5级食物
step << Priest
    .goto Durotar,54.3,42.9
    .turnin 5649 >> 有利于精神
    .accept 5648 >> 灵性服装
step << Priest
    >>在咕哝Kor'ja身上使用Lesser Heal Rank 2和Power Word：坚韧
    .goto Durotar,53.1,46.5
    .complete 5648,1 --Heal and fortify Grunt Kor'ja
step << Priest
    .goto Durotar,54.3,42.9
    .turnin 5648 >>穿上灵性的衣服
step << Priest
	#som
	#phase 3-6
    #sticky
	#softcore
    >>在整个杜隆塔尔，开始收集3堆亚麻布。这将用于稍后制作魔杖
    >>如果你已经买了根魔杖，或者可以从AH那里买到便宜的，那么跳过这一步。
    .collect 2589,60 --Linen Cloth (60)
step << Priest
	#som
	#phase 3-6
    #sticky
	#hardcore
    >>在整个杜隆塔尔，开始收集3堆亚麻布。这将用于稍后制作魔杖
    .collect 2589,60 --Linen Cloth (60)
step
    #sticky
    #label KulTiras
    .goto Durotar,58.14,57.56,0
    >>杀死Kul Tiras暴徒。抢走他们的碎片
    .complete 784,1 --Kul Tiras Sailor (10)
    .complete 784,2 --Kul Tiras Marine (8)
    .complete 791,1 --Canvas Scraps (8)
step
    .goto Durotar,59.2,58.3,25 >>进入要塞
step
    .goto Durotar,59.7,58.3
    >>去要塞的顶层。杀死Benedict中尉并抢走他的钥匙-小心他使用盾牌猛击（打断）
    .complete 784,3 --Lieutenant Benedict (1)
    .collect 4882,1 --Collect Benedict's Key (1)
step
    .goto Durotar,59.8,57.8,12,0
    .goto Durotar,59.9,57.5,12 >>在这里上楼梯
    >>抢劫胸部。从物品中接受任务
    .goto Durotar,59.3,57.6
    .collect 4881,1,830 --Collect Aged Envelope (1)
    .accept 830 >>接受上将的命令
step
	#era
    .goto Durotar,58.4,57.2
    .xp 7+2195>>研磨至2195+/4500xp
step
	#som
	#phase 1-2
    .goto Durotar,58.4,57.2
    .xp 7+1890>>研磨至1890+/4500xp
step
	#som
	#phase 3-6
    .goto Durotar,58.4,57.2
    .xp 7+750>>研磨至750+/4500xp
step
    #softcore
    #requires KulTiras
    .goto Durotar,53.5,44.5,120 >> 在精神治疗者处死亡并重生，或者逃跑
step
    #softcore
    .goto Durotar,51.9,43.5
    .turnin 784 >>交出征服背叛者
    .accept 825 >>从残骸中接受。。。。
    .turnin 830 >>提交上将命令
    .accept 831 >>接受上将的命令
step
    #hardcore
    #requires KulTiras
    >>跑回Razor Hill
    .goto Durotar,51.9,43.5
    .turnin 784 >>交出征服背叛者
    .accept 825 >>从残骸中接受。。。。
    .turnin 830 >>提交上将命令
    .accept 831 >>接受上将的命令
step
    .goto Durotar,49.9,40.3
    .turnin 791 >>转身负重
step << Shaman
    .goto Durotar,52.0,40.5
    >>修理你的武器。如果你有足够的钱（5s4c），从乌戈尔买一根拐杖。否则，请跳过此步骤（稍后再回来）
    .collect 2495,1 --Collect Walking Stick
step << Rogue
    .goto Durotar,52.0,40.5
     >>修理你的武器。如果你有足够的钱（4s1c），从乌戈尔买一个细高跟鞋。否则，请跳过此步骤（稍后再回来）
    .collect 2494,1 --Collect Stiletto
step << Orc Warrior
    .goto Durotar,52.0,40.5
    >>修理你的武器。如果你有足够的钱（4s84c），从乌戈尔买一把大斧子。否则，请跳过此步骤（稍后再回来）
    .collect 2491,1 --Collect Large Axe
step << Troll Warrior
    .goto Durotar,52.0,40.5
    >>修理你的武器。如果你有足够的钱（5s40c），从乌戈尔买一辆战斧。否则，请跳过此步骤（稍后再回来）
    .collect 2490,1 --Collect Tomahawk
step << Hunter
	#completewith next
    .goto Durotar,53.0,41.0
    >>修理你的武器。如果你有足够的钱（2s85c），从Ghrawt买一把Hornwood Recurve Bow。否则，请跳过此步骤（稍后再回来）
    .collect 2506,1 --Collect Hornwood Recurve Bow
step << Hunter
    .goto Durotar,53.0,41.0
    .vendor >> 从Ghrawt那里买足够的箭来装满你的箭袋
step << Warrior/Rogue
    .goto Durotar,52.0,40.7
    .money <0.0020
    .train 2018 >> 火车铁匠。锻造允许你制造锐化宝石（+2武器伤害，持续1小时）。如果你愿意，可以跳过锻造和采矿
step << Warrior/Rogue
    .goto Durotar,51.8,40.9
    .money <0.0010
    .trainer 2580 >> 训练采矿。在你的魔法书中施放“寻找矿物”
step << Warrior/Rogue
    .goto Durotar,53.0,42.0
    .money <0.0081
    .collect 2901,1 >> 购买采矿镐。留意我的静脉，用铁匠技术为你的武器制作磨石
step << Shaman
    .goto Durotar,54.4,42.6
    .trainer >> 训练你的职业咒语
step << Priest
    .goto Durotar,54.3,42.9
    .trainer >> 训练你的职业咒语
step << Warrior
    .goto Durotar,54.2,42.5
    .trainer >> 训练你的职业咒语
step << Hunter
    .goto Durotar,51.8,43.5
    .trainer >> 训练你的职业咒语
step << Rogue
    .goto Durotar,52.0,43.7
    .trainer >> 训练你的职业咒语
step << Warlock
    .goto Durotar,54.4,41.2
    .trainer >> 训练你的职业咒语
    .goto Durotar,54.7,41.5
    .vendor >> 如果您在培训后有钱，请购买Firebolt书籍（否则请稍后购买）
step << Warrior/Rogue
    .goto Durotar,54.2,41.9
    .money <0.01
    .trainer >>培训急救
step
    .goto Durotar,54.4,42.2
    .money <0.1250
    .vendor >>从Jark那里买一个6槽包
step << Priest/Warlock/Mage
    .goto Durotar,51.5,41.6
    .vendor >> 尽可能多地购买5级水
step << Warrior/Rogue/Hunter
    .goto Durotar,51.5,41.6
    .vendor >> 购买最多20种5级食物
step
    #sticky
    #completewith Tools
    >>在这里杀死一些Makrura以换取眼睛/爬行动物以换取黏液
    .complete 818,1 --Intact Makrura Eye (4)
    .complete 818,2 --Crawler Mucus (8)
step
    #label Tools
    >>检查离海岸最近的船上的工具箱。如果找不到这些产卵，请查看其他船只。它们可能有点难看
    .goto Durotar,61.9,55.5,12 >> 在水下的窗户里
    .goto Durotar,62.3,56.3,12 >> 水下的
    .goto Durotar,61.4,56.1,12 >> 靠近海岸
    .complete 825,1 --Gnomish Tools (3)
step
    #sticky
    #completewith Fur
    >>杀死所有你看到的老虎的皮毛。现在不需要完成。
    .complete 817,1 --Durotar Tiger Fur (4)
step
    >>游到岛上。在这个岛上的地上掠夺Taillasher鸡蛋。他们通常由Taillasher看守
    .goto Durotar,68.8,71.5
    .complete 815,1 --Taillasher Egg (3)
step
    #sticky
    #completewith next
    >>在这里杀死一些Makrura以获取眼睛和爬行器以获取粘液。现在不需要完成。
    .complete 818,1 --Intact Makrura Eye (4)
    .complete 818,2 --Crawler Mucus (8)
step
    .goto Durotar,66.9,80.0,175 >>游到另一个岛
step
    #sticky
    #completewith Trolls
    >>杀死该地区的巨魔。当巫毒巨魔痊愈时要小心
    .complete 826,1 --Hexed Troll (8)
    .complete 826,2 --Voodoo Troll (8)
step
    .goto Durotar,67.4,87.8
    >>杀死扎拉扎内。当他施放治愈之波时，保存你的地球冲击。抢劫他的头 << Shaman
    >>杀死扎拉扎内。把你的凿击术留到他施放治疗波的时候。抢劫他的头 << Rogue
    >>杀死扎拉扎内。小心，因为他可以治愈（你可能需要治疗药剂）。抢劫他的头 << !Shaman !Rogue
    .complete 826,3 --Zalazane's Head (1)
step
    #label Trolls
    .goto Durotar,67.4,87.8
    >>在地上抢劫一个头骨
    .complete 808,1 --Minshina's Skull (1)
step
    #label Fur
    .goto Durotar,68.34,83.54
    >>杀死其余的巨魔。巫毒巨魔痊愈时要小心
    .complete 826,1 --Hexed Troll (8)
    .complete 826,2 --Voodoo Troll (8)
step
    >>获取剩余的虎皮
    .goto Durotar,64.7,88.5,90,0
    .goto Durotar,65.2,80.8,90,0
    .goto Durotar,59.9,83.6,90,0
    .goto Durotar,64.7,88.5,90,0
    .goto Durotar,65.2,80.8,90,0
    .goto Durotar,59.9,83.6,90,0
    .goto Durotar,59.9,83.6
    .complete 817,1 --Durotar Tiger Fur (4)
step
    #softcore
    .goto Durotar,57.5,73.3,200 >> 在精神治疗者处死亡并重生，或者逃跑
step
    >> 从Makrura/爬虫手中抢走剩余的眼睛和黏液
    .goto Durotar,59.7,71.7,100,0
    .goto Durotar,57.6,77.9,100,0
    .goto Durotar,59.7,71.7,100,0
    .goto Durotar,57.6,77.9,100,0
    .goto Durotar,59.7,71.7
    .complete 818,1 --Intact Makrura Eye (4)
    .complete 818,2 --Crawler Mucus (8)
step
    .goto Durotar,56.48,73.11
    .vendor >> Trayexir的供应商垃圾处理和维修。你可以在小屋外面和他说话
step << Mage
    >>到帐篷里去
    .goto Durotar,56.3,75.1
    .trainer >> 训练你的职业咒语
step
	#completewith SkullX
    +把微弱发光的骷髅从转弯处保存起来，以便以后使用（你会被告知何时使用）
step
    .goto Durotar,55.9,74.7
    .turnin 808 >>交出Minshina的头骨
    .turnin 826 >>转入Zalazane
step
    .goto Durotar,56.0,74.3
    .turnin 818 >>上缴溶剂油
step
    .goto Durotar,56.0,73.9
    .turnin 817 >>交出实际猎物
step
	#era/som
    .goto Durotar,54.3,73.3
    .turnin 786 >>交出Thwarting Kolkar侵略
step
	#som
	#phase 3-6
    .goto Durotar,43.8,39.1
    .xp 9+4500>>研磨至4500+/6500xp
step
	#som
	#phase 3-6
    .goto Durotar,51.1,42.4
    .turnin 815 >>轮流打碎几个鸡蛋
step
	#som
	#phase 3-6
    .goto Durotar,51.9,43.5
    .turnin 825 >>从残骸上车。。。。
step << Shaman
	#som
	#phase 3-6
    .goto Durotar,54.4,42.5
    .accept 2983 >>接受火灾召唤
    .trainer >> 训练你的职业咒语
step << Priest
	#som
	#phase 3-6
    .goto Durotar,54.3,42.9
    .trainer >> 训练你的职业咒语
step << Orc Warrior/Troll Warrior
	#som
	#phase 3-6
    .goto Durotar,54.2,42.5
    .accept 1505 >>接受退伍军人乌泽克
    .trainer >> 训练你的职业咒语
step << Rogue
	#som
	#phase 3-6
    .goto Durotar,52.0,43.7
    .trainer >> 训练你的职业咒语
step << Warrior/Rogue
	#som
	#phase 3-6
    .goto Durotar,54.2,41.9
    .money <0.01
    .train 3273 >>培训急救
step << Warlock
	#som
	#phase 3-6
    .goto Durotar,54.4,41.2
    .trainer >> 训练你的职业咒语
    .accept 1506 >>接受甘鲁的召唤
step << Hunter
	#som
	#phase 3-6
    .goto Durotar,51.8,43.5
    .trainer >> 训练你的职业咒语
    .accept 6062 >>接受驯服野兽
step << Hunter
	#som
	#phase 3-6
    .goto Durotar,51.8,43.5
    .trainer >> 训练你的职业咒语
    .accept 6062 >>接受驯服野兽
step << Hunter
	#som
	#phase 3-6
    >>单击包中的驯鹿棒。尝试在最大射程（30码）进行
    .goto Durotar,51.5,50.0
    .complete 6062,1 --Tame a Dire Mottled Boar
step << Hunter
	#som
	#phase 3-6
    .goto Durotar,51.8,43.5
    .turnin 6062 >>转身驯服野兽
    .accept 6083 >>接受驯服野兽
step << Hunter
	#som
	#phase 3-6
    >>不要杀死你看到的装甲蝎子。你以后会需要的
    .goto Durotar,59.3,27.6
    .complete 6083,1 --Tame a Surf Crawler
step << Hunter
	#som
	#phase 3-6
    .goto Durotar,51.8,43.5
    .turnin 6083 >>转身驯服野兽
    .accept 6082 >>接受驯服野兽
step << Hunter
	#som
	#phase 3-6
    .use 15920 >>点击你包里的驯蝎棒。尝试在最大射程（30码）进行
    .goto Durotar,59.3,27.6
    .complete 6082,1 --Tame an Armored Scorpid
step << Hunter
	#som
	#phase 3-6
    .goto Durotar,51.8,43.5
    .turnin 6082 >>转身驯服野兽
    .accept 6081 >>接受训练野兽
step << Hunter
	#som
	#phase 3-6
    .goto Durotar,53.0,41.0
    .vendor >>供应商垃圾箱。购买10级箭，直到你的Quiver满为止（1000支箭）
step
    .goto Durotar,48.9,48.5
    >>杀死该地区的Quilboars和Scouts
    .complete 837,1 --Razormane Quilboar (4)
    .complete 837,2 --Razormane Scout (4)
step
    .goto Durotar,43.8,39.1
    >>杀死该地区的除尘兵和战警。吸尘器施放回春（治疗），而战警则是坦克。
    .complete 837,3 --Razormane Dustrunner (4)
    .complete 837,4 --Razormane Battleguard (4)
step << Warlock/Hunter
	#era/som
    .xp 9+4500>>研磨至4500+/6500xp
step << Warlock/Hunter
	#era/som
    .goto Durotar,51.1,42.4
    .turnin 815 >>轮流打碎几个鸡蛋
step << Warlock/Hunter
	#era/som
    .goto Durotar,51.9,43.5
    .turnin 825 >>从残骸上车。。。。
    .turnin 837 >>交出侵占
step << Warlock
	#era/som
    .goto Durotar,54.4,41.2
    .trainer >> 训练你的职业咒语
    .accept 1506 >>接受甘鲁的召唤
step << Hunter
	#era/som
    .goto Durotar,51.8,43.5
    .trainer >> 训练你的职业咒语
    .accept 6062 >>接受驯服野兽
step << Hunter
	#era/som
    .use 15917 >>单击包中的驯鹿棒。尝试在最大射程（30码）进行
    .goto Durotar,51.5,50.0
    .complete 6062,1 --Tame a Dire Mottled Boar
step << Hunter
	#era/som
    .goto Durotar,51.8,43.5
    .turnin 6062 >>转身驯服野兽
    .accept 6083 >>接受驯服野兽
step << Hunter
	#era/som
   .use 15919 >>不要杀死你看到的装甲蝎子。你以后会需要的
    .goto Durotar,59.3,27.6
    .complete 6083,1 --Tame a Surf Crawler
step << Hunter
	#era/som
    .goto Durotar,51.8,43.5
    .turnin 6083 >>转身驯服野兽
    .accept 6082 >>接受驯服野兽
step << Hunter
	#era/som
    .use 15920 >>点击你包里的驯蝎棒。尝试在最大射程（30码）进行
    .goto Durotar,59.3,27.6
    .complete 6082,1 --Tame an Armored Scorpid
step << Hunter
	#era/som
    .goto Durotar,51.8,43.5
    .turnin 6082 >>转身驯服野兽
    .accept 6081 >>接受训练野兽
step << Hunter
	#era/som
    .goto Durotar,53.0,41.0
    .vendor >>供应商垃圾箱。购买10级箭，直到你的Quiver满为止（1000支箭）
step
    .goto Durotar,43.1,30.3
    .accept 816 >>接受丢失但不遗忘
step
    .goto Durotar,46.4,22.9
    .accept 834 >>接受沙漠中的风
step
    >>抢劫地上的小麻袋
    .goto Durotar,51.7,27.7
    .complete 834,1 --Sack of Supplies (5)
step
	#label SkullX
    .goto Durotar,46.4,22.9
    .turnin 834 >>沙漠中的风
    .accept 835 >>接受固定线路
step << Warlock
	#som
	#phase 3-6
	>>遇到奥格瑞玛
    .goto Orgrimmar,48.3,45.3
    .turnin 1506 >>递交甘鲁尔的传票
    .accept 1501 >>接受虚空生物
step << Warlock
	#softcore
	#som
	#phase 3-6
	#completewith next
	+跑到附近的火盆上。垃圾生命水龙头让你失去健康，然后死于火灾
	>>或者，跑进烈火峡谷，死在里面的暴徒手中
step << Warlock
	#som
	#phase 3-6
    .goto Durotar,47.3,17.9,200 >> Orgrimmar出口
step
    #completewith next
    .goto Durotar,41.7,25.5,120 >>跳进雷霆岭
step
	#softcore
    .use 4945 >>杀死菲兹尔，并为他的爪子抢劫他。尽量清除周围营地的暴徒，腾出空间。很多时候，先杀死他的宠物是有道理的。如果需要，使用您的骷髅健康锅。一个很好的开场白是粘胶他，然后走出暗影箭射程，杀死他的宠物而不被他击中。
	>>如果你正在努力，请分组完成此任务
    .goto Durotar,41.9,26.0
    .complete 806,1 --Fizzle's Claw (1)
step
	#hardcore
    .use 4945 >>杀死菲兹尔，并为他的爪子抢劫他。尽量清除周围营地的暴徒，腾出空间。在很多时候，先杀死他的宠物是有意义的，如果需要的话，可以使用你的骷髅和健康锅。一个很好的开场白是粘胶他，然后走出暗影箭射程，杀死他的宠物而不被他击中。
    .goto Durotar,41.9,26.0
    .complete 806,1 --Fizzle's Claw (1)
--N add a link for warrior/rogue? Also needs more specific wording per class
step
    #softcore
	#era/som
	.goto Durotar,41.5,18.6
    >> 战斗出雷脊区域或死亡跳跃到墓地。
    .accept 812 >>接受治疗需要
step << !Warrior !Shaman
	#som
	#phase 3-6
	.hs >> 炉底到剃须山
step
    #hardcore
	#era/som
    .goto Durotar,39.18,31.65,90,0
	.goto Durotar,41.5,18.6
    >> 冲出雷脊地区
    .accept 812 >>接受治疗需要
step
	#era/som
    #completewith next
    .goto Orgrimmar,49.0,94.2,80 >>遇到奥格瑞玛
step << Rogue
	#era/som
    .goto Orgrimmar,48.13,80.55
    .vendor >> 购买Trak'gen投掷的等级11。11级时装备它
step << Hunter
	#era/som
    #completewith next
    .goto Orgrimmar,37.40,52.32
    .vendor >> 从山体买些苹果喂你的宠物
    .collect 4536,10 --Shiny Red Apple (10)
step
	#era/som
    .goto Orgrimmar,34.3,36.4
    .turnin 831 >>提交上将命令
step
	#era/som
    .goto Orgrimmar,31.9,37.7
    .accept 5726 >>接受隐藏的敌人
step << Hunter
	#era/som
    .goto Orgrimmar,66.0,18.5
    .turnin 6081 >>上缴训练野兽
step << Warlock
	#era/som
    .goto Orgrimmar,48.3,45.3
    .turnin 1506 >>递交甘鲁尔的传票
    .accept 1501 >>接受虚空生物
step << Rogue
	#era/som
    .goto Orgrimmar,42.72,53.56
	.accept 1963 >> 接受破碎的手
	.trainer >> 训练你的职业咒语
step
	#era/som
    .goto Orgrimmar,47.2,53.4
    .accept 813 >>接受寻找解药
    >>在酒吧里放上“野兽训练”。记得稍后教你的宠物技能 << Hunter
step
	#era/som
    >>放弃治疗的需要。这将删除任务上的计时器，但仍允许您继续执行
    .abandon 812 >>放弃治疗需求
step
	#era/som
    #completewith next
    .hs >> 炉底到剃须山
step << !Warlock !Hunter
	#era/som
    .goto Durotar,51.1,42.4
    .turnin 815 >>轮流打碎几个鸡蛋
step << !Warlock !Hunter
	#era/som
    .goto Durotar,51.9,43.5
    .turnin 825 >>从残骸上车。。。。
    .turnin 837 >>交出侵占
step
	#som
	#phase 3-6
    .goto Durotar,51.9,43.5
    .turnin 837 >>交出侵占
step
    .goto Durotar,52.3,43.1
    .turnin 806 >>转入黑暗风暴
    .accept 828 >>接受Margoz
step << Shaman
	#era/som
    .goto Durotar,54.4,42.5
    .accept 2983 >>接受火灾召唤
    .trainer >> 训练你的职业咒语
step << Priest
	#era/som
    .goto Durotar,54.3,42.9
    .trainer >> 训练你的职业咒语
step << Orc Warrior/Troll Warrior
	#era/som
    .goto Durotar,54.2,42.5
    .accept 1505 >>接受退伍军人乌泽克
    .trainer >> 训练你的职业咒语
step << Rogue
	#era/som
    .goto Durotar,52.0,43.7
    .trainer >> 训练你的职业咒语
step << Warrior/Rogue
	#era/som
    .goto Durotar,54.2,41.9
    .money <0.01
    .train 3273 >>培训急救
]])

RXPGuides.RegisterGuide([[
#classic
<< Horde
#name 10-12 杜隆塔尔
#version 1
#group RestedXP 部落 1-22
#defaultfor Troll/Orc
#next 11-14 银松森林 << Troll Rogue/Orc Rogue
#next 12-17 贫瘠之地 << Troll !Rogue/Orc !Rogue

step << Hunter
    #completewith next
    .goto Durotar,52.98,41.03
    >>如果你买得起，请从供应商处购买层压递归弓（和箭头）
    .collect 2507,1 --Laminated Recurve Bow (1)
step
    .goto Durotar,50.8,43.6
    .accept 840 >>接受部落征兵
step << Warrior/Shaman
    .goto The Barrens,62.2,19.4
    .turnin 840 >>交出部落征兵
    .accept 842 >>接受十字路口征兵
step << Warrior
    .goto The Barrens,61.4,21.1
    .turnin 1505 >>交给退伍军人乌泽克
    .accept 1498 >>接受防御之路
step << Orc Shaman/Troll Shaman
    .goto The Barrens,55.8,20.0
    .turnin 2983 >>交火召唤
    .accept 1524 >>接受火灾召唤
step << Warrior/Shaman
    .goto The Barrens,52.0,30.5,150 >> 跑到十字路口
step << Warrior/Shaman
    .goto The Barrens,52.2,31.8
    .accept 870 >>接受被遗忘的水池
step << Warrior/Shaman
    .goto The Barrens,52.2,31.0
    .turnin 842 >>交出十字路口征兵
    .accept 844 >>接受平原漫游者威胁
step << !Tauren Warrior/!Tauren Shaman
    .goto The Barrens,52.5,29.8
    .accept 6365 >>接受Orgrimmar的肉类
step << Warrior/Shaman
    .goto The Barrens,51.9,30.3
    .accept 869 >>接受猛禽窃贼
step << Warrior/Shaman
    .goto The Barrens,51.5,30.8
    .accept 871 >>接受破坏攻击
    .accept 5041 >>接受十字路口的补给
step << Warrior/Shaman
    .goto The Barrens,51.5,30.4
    .fp The Crossroads >> 获得the Crossroads飞行路线
step << !Tauren Warrior/!Tauren Shaman
    >>不要去奥格瑞玛
    .goto The Barrens,51.5,30.3
    .turnin 6365 >>将肉类交给Orgrimmar
    .accept 6384 >>接受前往Orgrimmar的骑行 << !Rogue
step << Warrior/Shaman
    .goto The Barrens,51.5,30.1
    .accept 848 >>接受真菌孢子
    .accept 1492 >>接受码头管理员Dizzywig
step << Warrior/Shaman
    #hardcore
    #sticky
    #completewith next
    +下一个任务可能很难，要格外小心
step << Warrior/Shaman
    #sticky
    #completewith next
    >>收集遗忘池周围的白蘑菇
    .complete 848,1 --Collect Fungal Spores (x4)
step << Warrior/Shaman
    >>潜水至气泡裂缝
    .goto The Barrens,45.1,22.5
    .complete 870,1 --Explore the waters of the Forgotten Pools
step << Warrior/Shaman
    >>收集遗忘池周围的白蘑菇
    .goto The Barrens,45.2,23.3,40,0
    .goto The Barrens,45.2,22.0,40,0
    .goto The Barrens,44.6,22.5,40,0
    .goto The Barrens,43.9,24.4,40,0
    .goto The Barrens,45.2,23.3
    .complete 848,1 --Collect Fungal Spores (x4)
step << Warrior/Shaman
    #softcore
    #completewith next
    .deathskip >> 在精神治疗师处死亡并重生
step << Warrior/Shaman
    #softcore
    .turnin 848 >>倒入真菌孢子
    .accept 853 >>接受药剂师Zamah
step << Warrior/Shaman
    #hardcore
    >>跑回十字路口
    .goto The Barrens,51.5,30.1
    .turnin 848 >>倒入真菌孢子
    .accept 853 >>接受药剂师Zamah
step << Warrior/Shaman
    .goto The Barrens,52.2,31.8
    .turnin 870 >>把被遗忘的水池交出来
    .accept 877 >>接受停滞的绿洲
step << Warrior/Shaman
    >>沿着这条路跑。小心路上的高级暴徒
    .goto The Barrens,44.4,59.2
    .fp Camp Taurajo >> 获得Taurajo营地飞行路线
step << Warrior/Shaman
    >>向西进入Mulgore，寻找Morin Cloudstaller。他沿着东路巡逻
    .goto Mulgore,59.7,62.5,70,0
    .goto Mulgore,51.1,58.6,70,0
    .goto Mulgore,51.1,58.6
    .accept 749 >>接受被摧毁的商队
	.unitscan Morin Cloudstalker
step << Warrior/Shaman
	#som
	#phase 3-6
    .goto Mulgore,53.7,48.1
    .turnin 749 >>收缴被摧毁的商队
step << Warrior/Shaman
	#era/som
    .goto Mulgore,48.7,59.3
    .accept 761 >>接受Swoop狩猎
step << Warrior/Shaman
	#era/som
    .goto Mulgore,47.5,60.2
    .accept 767 >>接受视觉仪式
    .accept 746 >>接受矮人挖掘
step << Warrior/Shaman
	#era/som
    .goto Mulgore,47.3,62.0
    .accept 743 >>接受风怒的危险
step << Warrior/Shaman
	#era/som
    .goto Mulgore,47.8,57.6
    .turnin 767 >>皈依视觉仪式
    .accept 771 >>接受视觉仪式
step << Warrior/Shaman
	#era/som
    .goto Mulgore,47.0,57.0
    .accept 766 >>接受Mazzranache
step << Warrior/Shaman
	#era/som
    #sticky
    #label Mulgoreall
    .complete 766,1 --Prairie Wolf Heart (1)
    .complete 766,2 --Flatland Cougar Femur (1)
    .complete 766,3 --Plainstrider Scale (1)
    .complete 766,4 --Swoop Gizzard (1)
    .complete 761,1 --Trophy Swoop Quill (8)
step << Warrior/Shaman
	#era/som
	#completewith CaravanR
	.use 4854 >>留心鬼嚎（稀有狼）。他在穆尔戈雷北部巡逻。杀死并抢劫他以换取恶魔疤痕斗篷。从物品中接受任务
	.collect 4854,1,770
	.unitscan Ghost Howl
step << Warrior/Shaman
	#era/som
    .goto Mulgore,52.0,61.1,10,0
    .goto Mulgore,50.0,66.4,10,0
    .goto Mulgore,50.4,66.5,10,0
    .goto Mulgore,52.0,61.1,10,0
    .goto Mulgore,50.0,66.4,10,0
    .goto Mulgore,50.4,66.5,0
    >>在树下的地面上收集看起来像橡子的物品
    .complete 771,2 --Ambercorn (2)
step << Warrior/Shaman
	#era/som
    .goto Mulgore,53.7,66.3
    >>打劫水井周围的石头
    .complete 771,1 --Well Stone (2)
step << Warrior/Shaman
	#era/som
   .goto Mulgore,47.8,57.5
    .turnin 771 >>皈依视觉仪式
    .accept 772 >>接受视觉仪式
step << Warrior/Shaman
    .goto Thunder Bluff,32.0,66.9,60 >>跑向电梯，进入雷霆崖
step << Warrior
    .goto Thunder Bluff,40.9,62.7
    .train 227 >>火车杆
    .train 199 >>列车2h梅斯
step << Warrior/Shaman
    >>去塔的顶层
    .goto Thunder Bluff,45.6,52.0,25,0
    .goto Thunder Bluff,46.8,49.9
    .fp Thunder Bluff >> 获得Thunder Bluff飞行路线
step << Warrior/Shaman
	>>进入雷霆崖洞穴
    .goto Thunder Bluff,29.6,29.7,25,0
    .goto Thunder Bluff,23.0,21.1
    .turnin 853 >>交给药剂师Zamah
step << Warrior/Shaman
	#era/som
	>>跑出洞穴，然后跳下桥下的某个地方离开雷霆崖
	>>跑到你南边的洞穴
    .goto Thunder Bluff,29.04,37.68,55,0
    .goto Mulgore,33.48,36.68,40,0
    .goto Mulgore,32.7,36.1
    .turnin 772 >>皈依视觉仪式
    .accept 773 >>接受智慧仪式
step << Warrior/Shaman
	#era/som
    >>杀死哈比。掠夺他们的魔爪
    .goto Mulgore,31.9,41.7
    .complete 743,1 --Windfury Talon (8)
step << Warrior/Shaman
	#era/som
    .goto Mulgore,31.3,49.9
   >>为探矿者选择杀死矮人暴徒
   .use 4702 >>使用锻炉上的镐，直到你打碎了其中的5个为止。这是在矮人营地完成的。
	.collect 4702,5,746,1
    .complete 746,1 --Broken Tools (5)
--N needs testing
step << Warrior/Shaman
	#era/som
    .goto Mulgore,59.9,25.6
    .accept 833 >>接受神圣的葬礼
step << Warrior/Shaman
	#era/som
    >>杀死该地区的狐狸精
    .goto Mulgore,61.5,21.9
    .complete 833,1 --Bristleback Interloper (8)
step << Warrior/Shaman
	#era/som
    .goto Mulgore,61.5,21.1
    .turnin 773 >>上交智慧礼
step << Warrior/Shaman
	#era/som
    .goto Mulgore,59.8,25.6
    .turnin 833 >>上缴圣葬
step << Warrior/Shaman
	#era/som
    #requires Mulgoreall
	#label CaravanR
    .goto Mulgore,53.7,48.1
    .turnin 749 >>收缴被摧毁的商队
    .accept 751 >>接受被摧毁的商队
step << Warrior/Shaman
	#era/som
    .goto Mulgore,47.0,57.2
    .turnin 766 >>转入Mazzranache
step << Warrior/Shaman
	#era/som
	.isOnQuest 770
	.goto Mulgore,46.75,60.23
	>>把斗篷翻进去。小心，因为这会将其从角色/库存中删除
    .turnin 770 >>交上恶魔疤痕斗篷
step << Warrior/Shaman
	#era/som
    .goto Mulgore,47.5,60.2
    .turnin 746 >>转入矮人挖掘
step << Warrior/Shaman
	#era/som
    .goto Mulgore,47.4,62.0
    .turnin 743 >>交出风怒的危险
step << Warrior/Shaman
	#era/som
    .goto Mulgore,48.7,59.4
    .turnin 761 >>提交Swoop Hunting
step << Warrior/Shaman
	#era/som
    >>寻找Morin Cloudstaller。他沿着东路巡逻
    .goto Mulgore,51.1,58.6,70,0
    .goto Mulgore,59.7,62.5,70,0
    .goto Mulgore,51.1,58.6,70,0
    .goto Mulgore,59.7,62.5,70,0
    .goto Mulgore,51.1,58.6,70,0
    .goto Mulgore,59.7,62.5,70,0
    .goto Mulgore,59.7,62.5
    .turnin 751 >> 收缴被摧毁的商队
    .accept 764 >>接受合资公司。
    .accept 765 >>接受主管Fizspholler
	.unitscan Morin Cloudstalker
step << Warrior/Shaman
	#era/som
    #sticky
    #label Workers
    >>杀死风险投资公司的暴徒
    .goto Mulgore,63.0,44.3
    .complete 764,1 --Venture Co. Worker (14)
    .complete 764,2 --Venture Co. Supervisor (6)
step << Warrior/Shaman
	#era/som
    >>跑进矿井，然后拥抱右边/东边。杀死监督员Fizspholler。抢他的剪贴板
    .goto Mulgore,64.9,43.3
    .complete 765,1 --Fizsprocket's Clipboard (1)
step << Warrior/Shaman
	#era/som
    #requires Workers
    .xp 11+7150>>研磨至7150+/8700xp
step << Warrior/Shaman
	#era/som
    >>寻找Morin Cloudstaller。他沿着东路巡逻
    .goto Mulgore,51.1,58.6,70,0
    .goto Mulgore,59.7,62.5,70,0
    .goto Mulgore,51.1,58.6,70,0
    .goto Mulgore,59.7,62.5,70,0
    .goto Mulgore,51.1,58.6,70,0
    .goto Mulgore,59.7,62.5,70,0
    .goto Mulgore,59.7,62.5
    .turnin 764 >>交给创业公司。
    .turnin 765 >>移交主管Fizspholler
	.unitscan Morin Cloudstalker
step << Warrior/Shaman
    #completewith next
    .hs >>炉底到剃须山
step << Shaman
	#level 12
    .goto Durotar,54.4,42.5
  .trainer >> 训练你的职业咒语
step << Orc Warrior/Troll Warrior
	#level 12
    .goto Durotar,54.2,42.5
    .trainer >> 训练你的职业咒语
step << Priest
    #sticky
    #label Linen
    >>在整个杜隆塔尔，开始收集3堆亚麻布。这将用于稍后制作魔杖
    >>如果你已经买了根魔杖，或者可以从AH那里买到便宜的，请跳过这一步
    .collect 2589,60 --Linen Cloth (60)
step << Troll Shaman/Orc Shaman
    .goto Durotar,36.6,58.0,25 >>沿着山路跑
step << Troll Shaman/Orc Shaman
    .goto Durotar,38.6,59.0
    .turnin 1524 >>交火召唤
    .accept 1525 >>接受火灾召唤
step << Warrior
    .goto Durotar,54.4,42.2
    .vendor >>从Jark购买6个老虎袋，直到你无法装备新袋子
step << Hunter
    .goto Durotar,53.0,41.0
    .vendor >> 如果你有钱，就买层压递归弓。
step
    .goto Durotar,56.4,20.1
    .turnin 828 >>交给Margoz
    .accept 827 >>接受骷髅石
step << Hunter
    .goto Durotar,57.2,12.0
    .spell 1515 >>驯服冲浪爬虫
step
	#era/som
    #label scorp2
    #sticky
    >>杀死该区域的蝎子以获得毒囊
    .goto Durotar,55.7,15.7,0
    .goto Durotar,39.67,18.83,0
    .complete 813,1 --Venomtail Poison Sac (4)
step << Hunter
    .goto Durotar,55.06,9.91,60 >> 跑向骷髅岩
step
	#era/som
    #sticky
    #label Collars2
    .goto Durotar,53.08,9.19,0
    >>在骷髅岩杀死燃烧之刃暴徒以获得灼热的项圈，直到中尉的徽章掉落
    .complete 827,1 --Searing Collar (6)
    .complete 5726,1 --Lieutenant's Insignia (1)
step
	#som
	#phase 3-6
    #sticky
    #label Collars2
    .goto Durotar,53.08,9.19,0
    >>在骷髅岩杀死燃烧的刀锋暴徒以烧灼项圈
    .complete 827,1 --Searing Collar (6)
step << Warlock
    .goto Durotar,53.6,8.5,25,0
    .goto Durotar,51.8,8.1,25,0
    .goto Durotar,51.6,9.8
    >> 沿着洞穴的正确路径走。继续跟踪洞穴，在洞穴尽头抢劫箱子。
    .complete 1501,1 --Tablet of Verga (1)
step
    >>为了燃烧的阴影之眼杀死加兹乌斯。他可能在洞穴的多个区域。
    >>在虚空行者身上使用粘胶以避免被击中，使用治疗药剂恢复健康。使用LoS（视线）避开Gazz'uz的暗影箭
    >>杀死Gazz'uz后，你可以跑到洞穴内发现的水体中躲避虚空行者
    >>他很难相处，所以要小心。如果需要，可以跳过此任务
    .goto Durotar,51.8,10.0
    .collect 4903,1,832 --Collect Eye of Burning Shadow
    .accept 832 >>接受燃烧的阴影
	.unitscan Gazz'uz
step
    #requires Collars2
    .goto Durotar,56.4,20.1
    .turnin 827 >>转入骷髅岩
    .accept 829 >>接受Neeru Fireblade
step << Shaman
    #completewith next
    .goto Durotar,52.8,28.7,40 >> 到这里的洞穴里去
step << Shaman
    >>为了袋子杀死燃烧之刃信徒
    .goto Durotar,52.5,26.7
    .complete 1525,2 --Reagent Pouch (1)
step
    .goto Durotar,54.0,27.7,90,0
    .goto Durotar,51.3,23.5,90,0
    .goto Durotar,51.5,19.1,90,0
    .goto Durotar,54.0,27.7,90,0
    .goto Durotar,51.3,23.5,90,0
    .goto Durotar,51.5,19.1,90,0
    .goto Durotar,51.3,23.5
    >>杀死该地区的哈比
    .complete 835,1 --Dustwind Savage (12)
    .complete 835,2 --Dustwind Storm Witch (8)
step
    #softcore
    .deathskip >> 在精神治疗师处死亡并重生
step
    #softcore
    .goto Durotar,46.4,22.9
    .turnin 835 >>转向固定管路
step
    #hardcore
    >>跑回山洞，然后回到地精那里
    .goto Durotar,53.75,27.74,60,0
    .goto Durotar,51.75,27.40,60,0
    .goto Durotar,46.4,22.9
    .turnin 835 >>转向固定管路
step
    #completewith next
	#requires scorp2
    .goto Durotar,45.50,11.70,70 >> 遇到奥格瑞玛
step << Rogue
	#som
	#phase 3-6
    .goto Orgrimmar,48.13,80.55
    .vendor >> 购买Trak'gen投掷的等级11。11级时装备它
step << Hunter
	#som
	#phase 3-6
    #completewith next
    .goto Orgrimmar,37.40,52.32
    .vendor >> 从山体买些苹果喂你的宠物
    .collect 4536,10 --Shiny Red Apple (10)
step
	#som
	#phase 3-6
    .goto Orgrimmar,34.3,36.4
    .turnin 831 >>提交上将命令
step << Hunter
	#som
	#phase 3-6
    .goto Orgrimmar,66.0,18.5
    .turnin 6081 >>上缴训练野兽
step << Warrior/Shaman
    #requires scorp2
    .goto Orgrimmar,54.2,68.4
    .turnin 6384 >>转入骑行前往奥格瑞玛
    .accept 6385 >> 接受风骑士大师多拉斯
step << Warrior/Shaman
    .goto Orgrimmar,45.2,63.8
    .turnin 6385 >> 交给风骑士大师多拉斯
    .accept 6386 >> 接受返回十字路口
step
	#era/som
    #requires scorp2
    .goto Orgrimmar,31.8,37.8
    .turnin 5726 >>交出隐藏的敌人
step << Rogue
	#level 12
    .goto Orgrimmar,42.8,53.4
    .accept 1963 >> 接受破碎的手
	.trainer >> 训练你的职业咒语
step << Rogue
    .goto Orgrimmar,42.8,53.4
    .accept 1963 >> 接受破碎的手
step << Priest
    #sticky
    #label Robes
    #requires Linen
    >>如果你已经买了根魔杖，或者可以从AH那里买到便宜的，请跳过这一步
    >>去裁缝培训师那里学习裁缝。
    >>把你所有的亚麻布都拧成螺栓。从教练那里学习棕色亚麻长袍，并根据需要购买尽可能多的粗线来制作所有长袍
    .goto Orgrimmar,63.28,50.68
    .collect 6238,9 --Brown Linen Robe (9)
step << Priest
    #sticky
    #requires Robes
    >>如果你已经买了根魔杖，或者可以从AH那里买到便宜的，请跳过这一步
    >>列车魅力。开始解开你早先做的所有棕色亚麻长袍。如果您没有买到任何Lesser Magic Essence，请向供应商咨询并购买，或者稍后再来
    >>买一根铜棒，然后做一根刻字铜棒。
    >>从教练那里训练小魔杖。制作一个小魔杖。
    .goto Orgrimmar,53.77,38.37
    .collect 11287,1 --Lesser Magic Wand (1)
step
	#era/som
    .goto Orgrimmar,47.0,53.4
    .turnin 813 >>轮流寻找解药
step << Warlock
    .goto Orgrimmar,48.3,45.3
    .turnin 1501 >>空虚的生物
    .accept 1504 >>接受绑定
step
	.isOnQuest 832
	.goto Orgrimmar,49.4,50.5
    .turnin 832 >>交出燃烧的阴影
step
	.goto Orgrimmar,49.4,50.5
    .turnin 829 >>交出Neeru Fireblade
    .accept 809 >>接受Ak'Zeloth
step
	.goto Orgrimmar,49.4,50.5
    .turnin 829 >>交出Neeru Fireblade
    .accept 809 >>接受Ak'Zeloth
step << Warlock
    .goto Orgrimmar,49.5,50.0
    >>使用召唤雕文召唤一个虚空行者。杀了它
    .complete 1504,1 --Summoned Voidwalker (1)
step << Warlock
    >>你现在可以召唤一个虚空行者
    .goto Orgrimmar,48.3,45.3
    .turnin 1504 >>交回装订本
step
	#softcore
	#completewith next
    .goto Orgrimmar,52.76,48.95
	.deathskip >> 进入阴影裂缝中的愤怒火焰裂缝。死在里面的暴徒中，在精神治疗者那里重生。
step
	#era/som
	#softcore
    .goto Durotar,41.6,18.7
    .accept 812 >>接受治疗需要
    .turnin 812 >>需要治疗
step
	#era/som
	#hardcore
	>>逃离Orgrimmar
    .goto Durotar,41.6,18.7
    .accept 812 >>接受治疗需要
    .turnin 812 >>需要治疗
step << Warrior
    .goto Durotar,42.01,24.33,90,0
    .goto Durotar,39.18,31.65
    >>掉进雷脊。杀死闪电隐藏和雷霆蜥蜴。抢走他们的歌声
    .complete 1498,1 --Singed Scale (5)
step
    >>开始为护身符杀死鳄鱼
    .goto Durotar,35.2,27.5,60,0
    .goto Durotar,35.7,57.8
    .complete 816,1 --Kron's Amulet (1)
step
    .goto Durotar,43.1,30.3
    .turnin 816 >>上缴失落但未被遗忘
step << !Shaman !Warrior
    .goto The Barrens,62.2,19.4
    .turnin 840 >>交出部落征兵
    .accept 842 >>接受十字路口征兵
step
    .goto The Barrens,62.3,20.1
    .turnin 809 >>交给Ak'Zeloth
    .accept 924 >>接受恶魔种子
step
    .goto The Barrens,62.3,20.0
    >>抢劫阿克泽洛斯旁边的紫石。这个项目有一个30分钟的计时器，所以一定要快点
    .turnin 926 >>交出有缺陷的能量石
step << Warrior
    .goto The Barrens,61.4,21.1
    .turnin 1498 >>转入防御之路
    .accept 1502 >>接受Thun'grim Firegake
step << Rogue
    #label BeakCave
    .goto The Barrens,47.6,19.2,70 >>前往被燃烧之刃兽人包围的洞穴
step << Rogue
    >>右键单击祭坛
    .goto The Barrens,48.0,19.1
    .collect 4986,1,924 --Collect Flawed Power Stone
    .complete 924,1 --Destroy the Demon Seed (1)
step << !Shaman !Warrior
    .goto The Barrens,52.0,30.5,150 >> 跑到十字路口
step << !Shaman !Warrior
    .goto The Barrens,52.2,31.8
    .accept 870 >>接受被遗忘的水池
step << !Shaman !Warrior
    .goto The Barrens,52.2,31.0
    .turnin 842 >>交出十字路口征兵
    .accept 844 >>接受平原漫游者威胁
step << Orc !Warrior !Shaman/Troll !Warrior !Shaman
    .goto The Barrens,52.5,29.8
    .accept 6365 >>接受Orgrimmar的肉类
step << Shaman Troll/Shaman Orc/Warrior Orc/Warrior Troll
    .goto The Barrens,52.5,29.8
    .turnin 6386 >> 转弯返回十字路口
step
    .goto The Barrens,51.99,29.89
	.home >> 把炉子放在十字路口
step << !Shaman !Warrior
    .goto The Barrens,51.9,30.3
    .accept 869 >>接受猛禽窃贼
step << !Shaman !Warrior
    .goto The Barrens,51.5,30.8
    .accept 871 >>接受破坏攻击
    .accept 5041 >>接受十字路口的补给
step << !Shaman !Warrior
    .goto The Barrens,51.5,30.4
    .fp The Crossroads >> 获得the Crossroads飞行路线
step << Orc !Warrior !Shaman/Troll !Warrior !Shaman
    >>不要去奥格瑞玛
    .goto The Barrens,51.5,30.3
    .turnin 6365 >>将肉类交给Orgrimmar
    .accept 6384 >>接受前往Orgrimmar的骑行 << !Rogue
step << !Shaman !Warrior
    .goto The Barrens,51.5,30.1
    .accept 848 >>接受真菌孢子
    .accept 1492 >>接受码头管理员Dizzywig
step << Mage
	#era/som
    +如果您计划通过AoE调平，请手动选择“荒地AoE指南”。否则，选择12-17 贫瘠之地 Guide
step << Mage
	#som
	#phase 3-6
    +如果您计划通过AoE调平，请手动选择“荒地AoE指南”。否则，请选择12-17 贫瘠之地 Guide。请注意，随着最近100%任务xp SoM的变化，Mage AoE研磨比任务路线更糟糕
step << Rogue
    .goto The Barrens,51.5,30.3
    .fly >> 飞往奥格瑞玛
step << Rogue
    .goto Orgrimmar,54.2,68.4
    .turnin 6384 >>转入骑行前往奥格瑞玛
    .accept 6385 >> 接受风骑士大师多拉斯
step << Rogue
    .goto Orgrimmar,45.2,63.8
    .turnin 6385 >> 交给风骑士大师多拉斯
    .accept 6386 >> 接受返回十字路口
step << Rogue
    #sticky
    #completewith next
    .goto Durotar,50.8,13.8,40 >> 去齐柏林塔。带着齐柏林飞艇去幽暗城
step << Rogue
    .zone Tirisfal Glades >>抵达提里斯福尔
step << Rogue
	#som
	#phase 3-6
    .goto Tirisfal Glades,61.87,65.02,40 >> 跑到地下城
step << Rogue
	#som
	#phase 3-6
    .goto Tirisfal Glades,61.81,74.42,30 >> 跑到电梯间
step << Rogue
	#som
	#phase 3-6
    >>把其中一部电梯放下
    .goto Undercity,63.25,48.56
    .fp Undercity >> 获取幽暗城飞行路线
step << Rogue
	#som
	#phase 3-6
    .money <0.3023
    .goto Tirisfal Glades,64.16,75.54
    >>与查尔斯交谈。买一把弯刀或弯刀。你很快就会训练剑（节省10银子）。如果你的武器更好，或者AH上有更好的东西，跳过这个
    .vendor >> 买一把弯刀或弯刀，确保你还有10个银币。
step << Rogue
	#som
	#phase 3-6
    #softcore
    .goto Undercity,57.32,32.77
    .trainer >> 训练剑。如果你之前没有足够的钱买一把弯刀，那么在买完之后，检查AH是否有武器
step << Rogue
	#completewith Barrens
    #som
    #phase 3-6
	.hs >> 如果你的炉子没火了，就把炉子放回十字路口
step << Rogue
	#completewith next
    #som
    #phase 3-6
    .goto Tirisfal Glades,60.89,59.06,30,0
    .goto Tirisfal Glades,60.73,58.76
    .zone Durotar >> 把齐柏林飞艇带到杜隆塔尔
step << Rogue
    #som
    #phase 3-6
    >>跑向Razor Hill
    .goto Durotar,50.85,43.59
    .accept 840 >>接受部落征兵
step << Rogue
	#label Barrens
    #som
    #phase 3-6
    .goto The Barrens,62.26,19.38
	.zone The Barrens >> 前往荒野
step << Rogue
    #som
    #phase 3-6
    >>跑到荒野
    .goto The Barrens,62.26,19.38
    .turnin 840 >>交出部落征兵
    .accept 842 >>接受十字路口征兵
step << Rogue
    #som
    #phase 3-6
    .goto The Barrens,52.23,31.01
    .turnin 842 >>交出十字路口征兵
    .accept 844 >>接受平原漫游者威胁
]])
