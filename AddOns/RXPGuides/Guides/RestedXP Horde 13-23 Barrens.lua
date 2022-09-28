RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Horde
#name 13-23 贫瘠之地
#version 1
#group RestedXP 部落 1-30
#defaultfor Shaman/Warrior
#next 23-27 希尔斯布莱德丘陵 / 灰谷
step << Tauren Shaman
    .goto Durotar,50.8,43.6
    .accept 840 >>接受部落征兵
step << Tauren Shaman
    .isOnQuest 1525
    .goto Durotar,52.8,28.7,25 >> 到这里的洞穴里去
step << Tauren Shaman
    >>为了袋子杀死燃烧之刃信徒
    .goto Durotar,52.5,26.7
    .complete 1525,2 --Reagent Pouch (1)
step << Tauren Shaman
    .isOnQuest 1525
    .goto Durotar,52.8,28.7,20 >> 离开洞穴
step << Tauren Shaman
    .goto The Barrens,62.2,19.4
    .turnin 840 >>交出部落征兵
    .accept 842 >>接受十字路口征兵
step << !Tauren
#xprate >1.499
    .goto The Barrens,52.2,31.8
    .accept 870 >>接受被遗忘的水池
step << !Tauren
#xprate >1.499
    #completewith next
    .goto The Barrens,52.3,32.0
    .vendor >> 根据需要购买6个槽袋
step << !Tauren
#xprate >1.499
    .goto The Barrens,52.2,31.0
    .turnin 842 >>交出十字路口征兵
    .accept 844 >>接受平原漫游者威胁
step << Orc/Troll
#xprate >1.499
    .goto The Barrens,52.5,29.8
    .accept 6365 >>接受Orgrimmar的肉类
step << !Tauren
#xprate >1.499
    .goto The Barrens,51.9,30.3
    .accept 869 >>接受猛禽窃贼
step << !Tauren
#xprate >1.499
    .goto The Barrens,51.5,30.8
    .accept 871 >>接受破坏攻击
    .accept 5041 >>接受十字路口的补给
step << !Tauren
#xprate >1.499
    .goto The Barrens,51.5,30.4
    .fp >>获取十字路口飞行路线
step << Orc/Troll
#xprate >1.499
    >>不要飞往奥格瑞玛
.goto The Barrens,51.5,30.3
    .turnin 6365 >>将肉类交给Orgrimmar
    .accept 6384 >>接受前往Orgrimmar的骑行
step << !Tauren
#xprate >1.499
.goto The Barrens,51.5,30.1
    .accept 1492 >>接受码头管理员Dizzywig
        .accept 848 >>接受真菌孢子
step << Orc/Troll
#xprate <1.5
    .goto The Barrens,52.6,29.9
    .turnin 6386 >>转入返回十字路口。   
step << Warrior
    .isOnQuest 1502
    .goto The Barrens,57.9,25.5,30 >>在这里跑上山
step << Warrior
    >>去山顶
    .goto The Barrens,57.2,30.3
    .turnin 1502 >>星期四的严酷火神
    .accept 1503 >>接受锻钢
step << Warrior
    #sticky
    #completewith next
    .goto The Barrens,55.6,26.6
    >>杀死该地区的Quillboars
    .complete 871,2 --Razormane Thornweaver (8)
    .complete 871,1 --Razormane Water Seeker (8)
    .complete 871,3 --Razormane Hunter (3)
step << Warrior
    #label Steel
    >>抢劫灰色箱子以获得锻钢棒
    .goto The Barrens,55.0,26.7
    .complete 1503,1 --Forged Steel Bars (1)
step << Warrior
    #sticky
    #completewith next
    #requires Steel
    >>在途中杀死一些平原漫游者。抢走他们的喙 << !Tauren
    .complete 844,1 --Plainstrider Beak (7) << !Tauren
    .goto The Barrens,54.7,28.0,20 >>在这里跑上山
step << Warrior
    #requires Steel
.goto The Barrens,57.2,30.3
    .turnin 1503 >>转入锻钢
step << Shaman
    #sticky
    >>杀死并掠夺剃须刀以获取火油
    .complete 1525,1 --Fire Tar (1)
step
    #sticky
    #completewith next
    >>检查陈氏空桶的位置。抢走它，开始任务。否则你以后会得到它。
.goto The Barrens,55.7,27.3
.collect 4926,1,819 --Collect Chen's Empty Keg
.accept 819 >> 收下陈的空桶
step
    .goto The Barrens,55.6,26.6
    >>杀死该地区的Quillboars
    .complete 871,2 --Razormane Thornweaver (8)
    .complete 871,1 --Razormane Water Seeker (8)
    .complete 871,3 --Razormane Hunter (3)
step << !Tauren
    #completewith next
    .goto The Barrens,62.4,20.0
    .cooldown item,4986,<5m >>删除你的缺陷能量石，然后回去再次掠夺阿克泽洛斯旁边的紫石。
step << !Tauren
    .goto The Barrens,62.4,20.0
        .turnin 926 >>交出有缺陷的能量石
step << !Tauren
    #sticky
#completewith BeakCave
>>如果你有时间在瑕疵能量石上杀死一些平原漫游者。抢走他们的喙
    .complete 844,1 --Plainstrider Beak (7)
step << !Tauren
    .isOnQuest 924
.goto The Barrens,50.4,22.0,50 >>在这里跑上山
step << !Tauren
    .isOnQuest 924
    #label BeakCave
.goto The Barrens,47.6,19.2,30 >>前往被燃烧之刃兽人包围的洞穴
step << !Tauren
    >>右键单击祭坛
.goto The Barrens,48.0,19.1
.collect 4986,1,924 --Collect Flawed Power Stone
    .complete 924,1 --Destroy the Demon Seed (1)
step
    #sticky
    #completewith next
    >>杀死你看到的猛禽。掠夺他们以获取猛禽头颅-稍后你会得到更多
    .complete 869,1 --Raptor Head (12)
step << !Tauren
    >>杀死平原漫游者。抢走他们的喙
.goto The Barrens,50.8,32.1
    .complete 844,1 --Plainstrider Beak (7)
step << Tauren
    .goto The Barrens,55.7,24.0,40,0
    .goto The Barrens,53.8,23.1,40,0
        .goto The Barrens,52.1,21.1,40,0
    .goto The Barrens,51.3,22.9,40,0
    .goto The Barrens,48.3,23.5,40,0
    .goto The Barrens,49.8,31.2
    >>杀死平原漫游者。抢走他们的喙
    .complete 844,1 --Plainstrider Beak (7)
step
    >>塔顶
.goto The Barrens,51.5,30.9
    .turnin 871 >>转入干扰攻击
    .accept 872 >>接受干扰结束
    .accept 867 >>接受哈比突袭者
step
    .goto The Barrens,52.2,31.0
    .turnin 844 >>提交平原漫游者威胁
    .accept 845 >>接受Zhevra
step << Tauren Shaman
    .goto The Barrens,52.2,31.0
    .turnin 842 >>交出十字路口征兵
step
    .goto The Barrens,52.0,29.9
    .home >> 把你的炉石放在十字路口
step << !Hunter !Rogue !Warlock !Mage !Priest
     #sticky
    #completewith next
    .money <0.75
    >> 检查利扎里克（地精商人）是否在十字路口。如果是的话，买些药水和一把重钉锤。
    .unitscan Lizzarik
    .goto The Barrens,52.5,30.7,20,0
.collect 4778,1 --Collect Heavy Spiked Mace
step
    .isOnQuest 872
    .goto The Barrens,57.1,25.3,250 >> 跑到这里
step
    #sticky
    #completewith Crates
    >>在得到板条箱和杀死克雷尼格的同时杀死剃刀人
    .complete 872,1 --Razormane Geomancer (8)
    .complete 872,2 --Razormane Defender (8)
step
    #sticky
    #completewith Kreenig
>>抢劫在该地区发现的补给箱
    .complete 5041,1 --Crossroads' Supply Crates (1)
step
    #label Kreenig
>>杀死Krenig Snarlsnout。抢他的牙
.goto The Barrens,58.6,27.1
    .complete 872,3 --Kreenig Snarlsnout's Tusk (1)
    .unitscan Kreenig Snarlsnout
step
#label Crates
>>抢劫在该地区发现的板条箱
.goto The Barrens,58.5,27.3,40,0
    .goto The Barrens,58.4,27.0,40,0
    .goto The Barrens,58.5,25.8,40,0
    .goto The Barrens,59.4,24.8
    .complete 5041,1 --Crossroads' Supply Crates (1)
step
.goto The Barrens,56.7,25.3
    >>杀死剃须刀
    .complete 872,1 --Razormane Geomancer (8)
    .complete 872,2 --Razormane Defender (8)
step << Warrior
    >> 在这里抢劫酒桶。如果还没有恢复，就等待重生。
.goto The Barrens,55.8,20.0
.collect 4926,1,819 --Collect Chen's Empty Keg
.accept 819 >> 收下陈的空桶
step << !Tauren !Undead
    #sticky
    #completewith next
    >>杀死你看到的任何哲夫拉。抢走他们的马蹄
    .complete 845,1 --Zhevra Hooves (4)
step << Tauren Warrior
    .goto The Barrens,56.7,19.8,60 >> 快跑到这里，途中有暴徒在捣乱
step << !Tauren !Undead
    .goto The Barrens,62.3,20.1
    .turnin 924 >>交出恶魔种子
step << Shaman
    .goto Durotar,38.5,58.9
    .turnin 1525 >>交火召唤
    .accept 1526 >>接受火灾召唤
step << Shaman
    .use 6636 >>跑到山顶。使用火萨普塔查看并杀死火元素。抢走他们，然后点击铜器
.goto Durotar,39.0,58.2
    .complete 1526,1 --Glowing Ember (1)
step << Shaman
    .goto Durotar,38.9,58.2
    .turnin 1526 >>交火召唤
    .accept 1527 >>接受火灾召唤
step << Shaman
    #sticky
    #completewith next
    >>杀死你看到的任何哲夫拉。抢走他们的马蹄
    .complete 845,1 --Zhevra Hooves (4)
step << Shaman
    .goto The Barrens,55.9,19.9
    .turnin 1527 >>交火召唤
step << Shaman
     >> 在这里抢劫酒桶。如果还没有恢复，就等待重生。
    .goto The Barrens,55.8,20.0
    .collect 4926,1,819 --Collect Chen's Empty Keg
    .accept 819 >> 收下陈的空桶
step
    >>杀死你看到的任何哲夫拉。抢走他们的马蹄。在进入棘轮之前，确保您有4个
    .goto The Barrens,63.9,35.8
    .complete 845,1 --Zhevra Hooves (4)
step
    >>向南前往途中的棘轮研磨。去大楼的顶层
    .goto The Barrens,62.7,36.3
    .accept 887 >>接受Southsea Freebooters
step
    .goto The Barrens,63.1,37.1
    #completewith ratchetfp
    .fp Ratchet >>获取棘轮飞行路径
step
    .goto The Barrens,63.0,37.2
    .accept 894 >>接受Samophlange
step
    #xprate <1.5
    .maxlevel 16
    .goto The Barrens,63.1,37.6
    .accept 959 >>在码头接受麻烦
step
    .goto The Barrens,63.3,38.4
    .turnin 1492 >>交码头管理员Dizzywig
    .accept 896 >>接受矿工的命运
step
    >>单击通缉海报。如果你想，也可以在这里存款
    .goto The Barrens,62.6,37.5
    .accept 895 >>接受通缉：Longshore男爵
step
    .goto The Barrens,62.4,37.7
    .accept 865 >>接受猛禽角
step
    .goto The Barrens,62.3,38.4
    .turnin 819 >>交回陈的空桶
    .accept 821 >>收下陈的空桶
step
    #label rachetfp
    .goto The Barrens,62.05,39.41
    >> 这里的五级鱼食非常便宜，请备货 << Warrior/Rogue
    .vendor >> 补充食物/水
step
    #sticky
    #completewith next
    >>杀死该地区的南海暴徒
    .complete 887,1 --Southsea Brigand (12)
    .complete 887,2 --Southsea Cannoneer (6)
step
    .goto The Barrens,64.2,47.1,40,0
    .goto The Barrens,63.6,49.1,40,0
    .goto The Barrens,62.6,49.7,40,0
    .goto The Barrens,64.2,47.1,40,0
    .goto The Barrens,63.6,49.1,40,0
    .goto The Barrens,62.6,49.7,40,0
    .goto The Barrens,64.2,47.1,40,0
    .goto The Barrens,63.6,49.1,40,0
    .goto The Barrens,62.6,49.7
    >>在其中一个营地找到并杀死男爵Longshore。抢他的头
    .complete 895,1 --Baron Longshore's Head (1)
    .unitscan Baron Longshore
step
    >>杀死南海暴徒
    .goto The Barrens,64.2,47.1,40,0
    .goto The Barrens,63.6,49.1,40,0
    .goto The Barrens,62.6,49.7,40,0
    .goto The Barrens,64.2,47.1,40,0
    .goto The Barrens,63.6,49.1,40,0
    .goto The Barrens,62.6,49.7,40,0
    .goto The Barrens,64.2,47.1,40,0
    .goto The Barrens,63.6,49.1,40,0
    .goto The Barrens,62.6,49.7
    .complete 887,1 --Southsea Brigand (12)
    .complete 887,2 --Southsea Cannoneer (6)
step << Druid
    >>传送至Moonglade
    .goto Moonglade,52.4,40.6
    .trainer 12042 >> 火车咒语
step
    #completewith next
    .hs >>炉膛到十字路口
    .cooldown item,6948,>0   
step
    .goto The Barrens,51.5,30.8
    .turnin 5041 >>十字路口的上缴物资
    .turnin 872 >>颠覆性结束
step
    .goto The Barrens,52.0,31.6
    .accept 899 >>接受仇恨所消耗
    .accept 4921 >>接受战败
step
    .goto The Barrens,52.2,31.0
    .turnin 845 >>交出哲夫拉
    .accept 903 >>接受贫瘠的游荡者
step
    #sticky
    #completewith next
>>杀死平原漫游者。抢劫他们的肾脏
    .complete 821,2 --Plainstrider Kidney (5)
step
    .goto The Barrens,45.4,28.4
    .accept 850 >>接受Kolkar领导人
step << !Tauren
#xprate >1.499
    #sticky
    #completewith next
    >>收集遗忘池周围的白蘑菇。尽量避免暴徒。
.complete 848,1 --Collect Fungal Spores (x4)
step << !Tauren
#xprate >1.499
>>潜水至气泡裂缝
.goto The Barrens,45.1,22.5
    .complete 870,1 --Explore the waters of the Forgotten Pools
step << !Tauren
#xprate >1.499
>>收集遗忘池周围的白蘑菇。尽量避免暴徒。
.goto The Barrens,45.2,23.3,40,0
.goto The Barrens,45.2,22.0,40,0
    .goto The Barrens,44.6,22.5,40,0
    .goto The Barrens,43.9,24.4,40,0
.complete 848,1 --Collect Fungal Spores (x4)
step
>>杀死科多班。抢他的头。在途中碾碎暴徒。
.goto The Barrens,42.8,23.5
    .complete 850,1 --Kodobane's Head (1)
step
    #sticky
    #completewith Claws
    >>杀死你看到的猛禽。掠夺他们以获取猛禽头-不要担心完成后会得到更多
    .complete 869,1 --Raptor Head (12)
step
    #sticky
    #completewith Claws
    #label Tusks
.goto The Barrens,41.4,24.5,40,0
    .goto The Barrens,40.4,20.0,40,0
.goto The Barrens,41.4,24.5,40,0
    .goto The Barrens,40.4,20.0
    .complete 821,1 --Savannah Lion Tusk (5)
step
    #label Claws
>>杀死游荡者。掠夺他们的爪牙
.goto The Barrens,41.4,24.5
    .complete 903,1 --Prowler Claws (7)
step
    #requires Claws
step
    #requires Tusks
.goto The Barrens,40.2,18.9,40,0
    .goto The Barrens,40.7,14.6,40,0
    .goto The Barrens,42.6,15.1,40,0
.goto The Barrens,40.2,18.9,40,0
    .goto The Barrens,40.7,14.6,40,0
    .goto The Barrens,42.6,15.1
    >>杀死哈比。掠夺他们的魔爪
    .complete 867,1 --Witchwing Talon (8)
step
    #sticky
    #completewith next
>>杀死平原漫游者。抢劫他们的肾脏。这不需要马上完成，但只要你看到他们就把他们杀死。在到达萨莫夫兰奇之前，至少要获得2/5个猛禽角。
    .complete 821,2 --Plainstrider Kidney (5)
    .complete 865,1 --Intact Raptor Horn (5)
    .complete 869,1 --Raptor Head (12)
step
    >>单击控制台
.goto The Barrens,52.4,11.6
    .turnin 894 >>交给Samophlange
    .accept 900 >>接受Samophlange
step
    >>点击阀门
.goto The Barrens,52.4,11.4
    .complete 900,2 --Shut off Fuel Control Valve (1)
step
    >>单击“阀”。暴徒会滋生
.goto The Barrens,52.3,11.4
    .complete 900,3 --Shut off Regulator Valve (1)
step
    >>单击“阀”。暴徒会滋生
    .goto The Barrens,52.3,11.6
    .complete 900,1 --Shut off Main Control Valve (1)
step
    >>单击控制台
.goto The Barrens,52.4,11.6
    .turnin 900 >>交给Samophlange
    .accept 901 >>接受Samophlange
step
    >>杀死大楼里的小精灵补锅匠。抢他拿控制台钥匙
.goto The Barrens,52.8,10.4
    .complete 901,1 --Console Key (1)
    .unitscan Tinkerer Sniggles
step
    .goto The Barrens,52.4,11.6
    .turnin 901 >>交给Samophlange
    .accept 902 >>接受Samophlange 
step
    >>接受碎纸机的点火。如果有人最近开始护送，你需要等待他重生。
.goto The Barrens,56.5,7.5
    .accept 858 >>接受点火
step
    >>杀死监督员Lugwizzle（他在整个塔上巡逻）。抢他取点火钥匙
.goto The Barrens,56.3,8.6
    .complete 858,1 --Ignition Key (1)
    .unitscan Supervisor Lugwizzle
step
    >>这将开始护送。准备好后启动。
.goto The Barrens,56.5,7.5
    .turnin 858 >>接通点火开关
    .accept 863 >>接受逃脱
step
    #label Slugs
>>2个暴徒会在某个时候繁殖。杀死他们，然后等待他的角色扮演活动结束。角色扮演大约需要20秒。
.goto The Barrens,55.3,7.8
    .complete 863,1 --Escort Wizzlecrank out of the Venture Co. drill site (1)
step
.goto The Barrens,55.8,6.2,40,0
    .goto The Barrens,57.2,6.6,40,0
.goto The Barrens,60.0,7.6,40,0
.goto The Barrens,60.8,10.6,40,0
    .goto The Barrens,60.4,1.2,40,0
.goto The Barrens,61.2,13.2
>>完成猛禽和平原漫游任务。
    .complete 821,2 --Plainstrider Kidney (5)
    .complete 865,1 --Intact Raptor Horn (5)
    .complete 869,1 --Raptor Head (12)
step
    >>在该地区捣乱暴徒。掠夺他们直到猫眼祖母绿掉落
.goto The Barrens,61.5,4.3
    .complete 896,1 -- Cats Eye Emerald (1)
step
    #completewith next
    .goto Orgrimmar,11.5,67.0,50 >>跑到奥格瑞玛的西入口
step << Orc/Troll
#xprate >1.499
    .goto Orgrimmar,54.2,68.6
    .turnin 6384 >>转入骑行前往奥格瑞玛
    .accept 6385 >>接受风骑士大师多拉斯
step << Orc/Troll
#xprate >1.499
    .goto Orgrimmar,45.2,64.0
     >> 交出任务，但不要飞回十字路口
    .turnin 6385 >>交给风骑士大师多拉斯
    .accept 6386 >>接受返回十字路口。
step << Tauren/Undead/BloodElf
    #completewith next
    >>跑到Flight Master塔台。获取飞行路径
    .goto Orgrimmar,45.2,63.8
    .fp Orgrimmar >>获取Orgrimmar飞行路线
step
    >>拥抱左侧。跑去Grommash Hold
.goto Orgrimmar,39.1,38.1
    .accept 1061 >>接受石爪的精神
step << Paladin
    #completewith next
    .goto Orgrimmar,32.3,35.7
    .trainer >> 去训练你的职业咒语
step << Shaman
    .goto Orgrimmar,38.8,36.4
.train 8045 >> 列车接地冲击r3
.train 8019 >> 训练摇滚武器r3
.train 325 >> 列车避雷针r2
.train 526 >> 火车治疗毒药
.train 8154 >>训练石肤图腾2
step << Warrior
    .goto Orgrimmar,80.4,32.4
    .train 1160 >> 列车泄气喊叫r1
    .train 285 >> 训练英雄打击r3
step
    #completewith next
    .hs >>炉膛到十字路口
    .cooldown item,6948,>0
step
    .goto The Barrens,51.9,30.3
    .turnin 869 >>收缴猛禽窃贼
    .accept 3281 >>接受被盗的银子
step << !Tauren
#xprate >1.499
    .goto The Barrens,51.5,30.1
    .turnin 848 >>倒入真菌孢子
step
    >>塔顶
.goto The Barrens,51.6,30.9
    .turnin 867 >>交出哈比突袭者
step
#xprate <1.5
    .maxlevel 17
    .goto The Barrens,51.6,30.9
    .accept 875 >>接受哈比中尉
step << !Tauren
#xprate >1.499
    .goto The Barrens,52.2,31.8
    .turnin 870 >>把被遗忘的水池交出来
    .accept 877 >>接受停滞的绿洲
step
    .goto The Barrens,52.3,31.0
    .turnin 903 >>收缴贫瘠的游荡者
    .accept 881 >>接受Echeyakee
step << Orc/Troll
#xprate >1.499
    .goto The Barrens,52.6,29.9
    .turnin 6386 >>转入返回十字路口。
step
#xprate <1.5
    .isOnQuest 875
.goto The Barrens,39.8,17.3,40,0
    .goto The Barrens,37.4,15.8,40,0
    .goto The Barrens,40.3,15.2,40,0
.goto The Barrens,39.8,17.3,40,0
    .goto The Barrens,37.4,15.8,40,0
    .goto The Barrens,40.3,15.2,40,0
.goto The Barrens,39.8,17.3,40,0
    .goto The Barrens,37.4,15.8,40,0
    .goto The Barrens,40.3,15.2
    >>杀死巫师之翼杀戮者。抢劫他们以换取哈比中尉戒指
    .complete 875,1 --Harpy Lieutenant Ring (6)
step
    #label LionTusks
.goto The Barrens,54.3,14.7
    >>杀死该地区的萨凡纳游荡者。掠夺他们的象牙
    .complete 821,1 --Savannah Lion Tusk (5)
step
    .use 10327 >>用你袋子里的Echeyakee之角召唤Echeyake。杀了他，抢了他的皮
.goto The Barrens,55.5,17.3
    .complete 881,1 --Echeyakee's Hide (1)
step
    >> 返回十字路口
    .goto The Barrens,52.2,31.0
    .turnin 881 >>交给Echeyakee
    .accept 905 >>接受愤怒的镰刀
step
#xprate <1.5
    .isOnQuest 875
    >>塔顶
.goto The Barrens,51.6,30.9
    .turnin 875 >>交出哈比中尉
    .accept 876 >>接受Serena Bloodfeather
step
    #completewith next
    .goto The Barrens,51.5,30.3
    .fly Ratchet >> 飞到棘轮
step
    >> 头部至棘轮
    .goto The Barrens,63.0,37.2
    .turnin 902 >>交给Samophlange
    .turnin 863 >>上车逃生
    .accept 1483 >>接受Ziz Fizziks
step
    .goto The Barrens,62.7,36.3
    .turnin 887 >>交出南海自由球员
    .accept 890 >>接受丢失的装运
    .turnin 895 >>通缉犯：Longshore男爵
step
    .goto The Barrens,63.3,38.4
    .turnin 896 >>交给矿工的财富
    .turnin 890 >>交回丢失的货物
    .accept 892 >>接受丢失的装运
step
    .goto The Barrens,62.4,37.6
    .accept 1069 >>接受Deepmoss蜘蛛蛋
    .turnin 865 >>转入猛禽角
    .accept 1491 >>接受智能饮料
step
    .goto The Barrens,62.7,36.3
    .turnin 892 >>交回丢失的货物
    .accept 888 >>接受被盗战利品
step
    >>抢劫板条箱
.goto The Barrens,63.6,49.2
    .complete 888,2 --Telescopic Lens (1)
step
    >>抢劫板条箱
.goto The Barrens,62.6,49.6
    .complete 888,1 --Shipment of Boots (1)
step
    .isOnQuest 865
.goto The Barrens,57.4,52.4,50 >>在前往猛禽场的途中进行研磨
step
    #sticky
    #completewith Nest
    >>杀死你看到的任何猛禽。掠夺他们的角和羽毛。离开前你需要3根羽毛
    *Be careful as the raptors have a thrash ability.
    .collect 5165,3 --Sunscale Feather (3)
step
    >>抢走被盗的银子
    .goto The Barrens,58.0,53.9
    .complete 3281,1 --Stolen Silver (1)
step
    >>点击水下的气泡裂缝
    .goto The Barrens,55.6,42.7
    .complete 877,1 --Test the Dried Seeds (1)
step
    #sticky
    #label nestegg
    >>为三个猛禽巢穴收集3根日照羽毛
    .collect 5165,3,905,0x3,-1
step
    >>单击鸡蛋。你需要猛禽队的日晷羽毛
    .goto The Barrens,52.6,46.2
    .complete 905,1 --Visit Blue Raptor Nest (1)
step
    >>单击鸡蛋。你需要猛禽队的日晷羽毛
    .goto The Barrens,52.5,46.6
    .complete 905,3 --Visit Red Raptor Nest (1)
step
    #label Nest
    >>单击鸡蛋。你需要猛禽队的日晷羽毛
    .goto The Barrens,52.0,46.5
    .complete 905,2 --Visit Yellow Raptor Nest (1)
step
    >>与Mankrik的妻子交谈
.goto The Barrens,49.3,50.4
    .complete 4921,1 --Find Mankrik's Wife (1)
    .skipgossip
step
    .goto The Barrens,45.6,59.0
    #completewith next
    .home >>将您的炉石设置为陶拉霍营地
step
    .goto The Barrens,45.6,59.0
    .vendor >> 补充食物/水，前方有一段艰难的任务
step
    .goto The Barrens,44.5,59.2
    .accept 878 >>战争中接受部落
step
    .goto The Barrens,44.5,59.2
    #completewith next
    .fly Crossroads >>飞向十字路口
step
    .goto The Barrens,51.9,30.3
    .turnin 3281 >>交出被盗的银子
step
    .goto The Barrens,52.2,31.0
    .turnin 905 >>交上愤怒的镰刀
    .accept 3261 >>接受Jorn Skyseer
step
    .goto The Barrens,52.2,31.9
    .turnin 877 >>转入停滞的绿洲
    .accept 880 >>接受改变的存在
step
    .goto The Barrens,52.0,31.6
    .turnin 4921 >>交出战败
step
    .goto The Barrens,46.1,36.7,35 >>进入WC洞穴。
    .isOnQuest 959
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
    >>杀死胞浆以获得哭泣精华。留心洞穴深处的两个稀有物种（Trigore和Boahn），因为它们会掉落蓝色的BoE武器。
    .complete 1491,1 --Wailing Essence (6)
    .unitscan Trigore the Lasher
    .unitscan Boahn
    .isOnQuest 1491
step
    >> 返回Kolkar前哨
    .goto The Barrens,45.4,28.4
    .turnin 850 >> 移交Kolkar领导人
    .isOnQuest 850
step
#xprate <1.5
    >>杀死Serena Bloodfeather。抢她的头
.goto The Barrens,39.2,12.2
    .complete 876,1 --Serena's Head (1)
step
    .goto The Barrens,35.3,27.9
    >> 前往石爪山
    .isOnQuest 1061
    .turnin 1061 >> 《石爪之魂》（The Spirits of Stonetalon）上映
step
    .goto The Barrens,35.3,27.9    
    .accept 1062 >> 接受地精侵略者
step
    .maxlevel 22
    .goto The Barrens,35.3,27.9
    >> 前往石爪山
    .accept 6548 >> 接受复仇我的村庄
step
    .isOnQuest 6548
    .goto Stonetalon Mountains,80.7,89.2,50,0
    .goto Stonetalon Mountains,82.0,86.0,50,0
    .goto Stonetalon Mountains,84.7,84.3,50,0
    .goto Stonetalon Mountains,82.3,90.0,50,0
    .goto Stonetalon Mountains,80.7,89.2,50,0
    .goto Stonetalon Mountains,82.0,86.0,50,0
    .goto Stonetalon Mountains,84.7,84.3,50,0
    .goto Stonetalon Mountains,82.3,90.0
    >>杀死该地区的格里姆特姆斯
    .complete 6548,2 --Kill Grimtotem Mercenary (x6)
    .complete 6548,1 --Kill Grimtotem Ruffian (x8)
step
    .isOnQuest 6548
    .goto The Barrens,35.2,27.8
    >> 回到荒野中的任务给予者那里
    .turnin 6548 >> 上缴复仇我的村庄
    .accept 6629 >> 接受Kill Grundig Darkcloud
step
.goto Stonetalon Mountains,82.3,98.5,40 >>跑到这里的山上去
step
    .goto Stonetalon Mountains,71.4,95.1
    .accept 6461 >> 接受输血器
step
    #sticky
    #completewith next
    .isOnQuest 6629
    .goto Stonetalon Mountains,71.7,86.7,40 >>跑到这里的小路上
step
    .isOnQuest 6629
    >>在开始内部任务之前，确保杀死所有6只野兽。在主帐篷前杀死格隆迪希
    .goto Stonetalon Mountains,74.0,86.2
    .complete 6629,1 --Kill Grundig Darkcloud (x1)
    .complete 6629,2 --Kill Grimtotem Brute (x6)
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
step << Druid
    #requires deepmossegg
    >>传送至Moonglade
    .goto Moonglade,52.4,40.6
    .trainer 12042 >> 火车咒语
step
    #requires deepmossegg
    #completewith next
    .hs >> Hearth前往陶拉霍营地
step
    #label eggend
    .goto The Barrens,44.9,59.1
    .turnin 3261 >>交给Jorn Skyseer
    .accept 882 >>接受Ishamuhale
step
    #sticky
    #label Lizard
    >>杀死风暴吹牛。抢走他们的一只角
    .complete 821,3 --Thunder Lizard Horn (1)
step
    #sticky
    #label Lakota1
    #completewith next
    .goto The Barrens,50.0,53.1,0
    .goto The Barrens,46.0,49.2,0
    .goto The Barrens,45.3,52.5,0
    .goto The Barrens,45.0,51.8,0
    .use 5099 >>找到并杀死该地区的拉科塔·马尼（格雷·科多）。抢走他的蹄子。如果你找不到他，跳过这个任务。
    .collect 5099,1,883 --Collect Hoof of Lakota'Mani
    .accept 883 >>接受Lakota'Mani
    .unitscan Lakota'mani
step
    >>杀死大量的绒猪。尽可能优先考虑荆棘侠、找水者和风水师。掠夺他们的象牙。保存你得到的血块
    *Water Seekers only spawn in the south western most camps. Go East or North West for Geomancers / Thornweavers.
.goto The Barrens,44.3,52.3,50,0
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
    #requires Lizard
    >>绕着湖去杀海龟。抢他们的壳
.goto The Barrens,55.5,42.6
    .complete 880,1 --Altered Snapjaw Shell (8)
step
    >>在该地区杀死一名哲夫拉。抢劫尸体
.goto The Barrens,61.0,32.2
.collect 10338,1 --Collect Fresh Zhevra Carcass
step
    .use 10338 >>用枯树上的新鲜哲夫拉尸体召唤Ishamuhale。杀了他，抢了他的牙
.goto The Barrens,59.9,30.4
    .complete 882,1 --Ishamuhale's Fang (1)
step
    >>跑回棘轮
.goto The Barrens,62.7,36.3
    .turnin 888 >>交出被盗战利品
step
    .goto The Barrens,63.0,37.2
    .turnin 1094 >>提交进一步说明
    .accept 1095 >>接受进一步指示
step
    .isOnQuest 959
    .goto The Barrens,63.1,37.6
    .turnin 959 >>码头上的麻烦
step
    .goto The Barrens,62.4,37.6
    .turnin 1069 >>交上深苔藓蜘蛛蛋
    .turnin 1491 >>提交智能饮料
step
    #completewith next
    .destroy 5570 >> 你现在可以销毁任何剩下的深苔藓蜘蛛蛋了
step
    .goto The Barrens,62.3,38.4
    .turnin 821 >>交回陈的空桶
step << Warrior
    .goto The Barrens,62.2,38.4
    .vendor >> 检查Grazlix的强力链裤。有钱就买
step << Druid/Rogue/Warrior/Hunter/Shaman
    .goto The Barrens,62.2,38.5
    .vendor >> 检查Vexspindle的Wolf Bracers。有钱就买
step
    .goto The Barrens,63.1,37.1
    #completewith next
    .fly Crossroads >>飞向十字路口
step
#xprate <1.5
    >>塔顶
.goto The Barrens,51.6,30.9
    .turnin 876 >>交给Serena Bloodfeather
    .accept 1060 >>接受给金子的信
step
    .goto The Barrens,52.0,31.6
    .turnin 899 >>因仇恨而上缴
step
    .goto The Barrens,52.2,31.9
    .turnin 880 >>交出改变的存在
    .accept 1489 >>接受Hamuul Runetotem
    .accept 3301 >>接受Mura Runetotem
step
    #completewith camptflight
    .goto The Barrens,51.5,30.3
    .fly Camp Taurajo >>飞往陶拉霍营地
step
    .goto The Barrens,53.0,52.1
    >>为了血块杀死公毛猪
.collect 5075 --Collect Blood Shard (1)
step
    #label camptflight
    .goto The Barrens,44.6,59.2
    .turnin 878 >>战争中沦陷的部落
    .accept 5052 >>接受阿加马根的血片
    .turnin 5052 >>交出阿加马根血片
step
    >> 用你的血碎片来拯救风之精灵
    .accept 889 >> 接受风的精神
    .turnin 889 >> 风之灵归来
step
    .isOnQuest 883
.goto The Barrens,44.8,59.1
    .turnin 882 >>转入Ishamuhale
    .accept 907 >>接受愤怒的雷霆蜥蜴
    .turnin 883 >>交给Lakota’mani
    .accept 1130 >>接受Melor发送消息
    .accept 6382 >>接受灰谷狩猎
step
    .goto The Barrens,44.8,59.1
    .turnin 882 >>转入Ishamuhale
    .accept 907 >>接受愤怒的雷霆蜥蜴
    .accept 1130 >>接受Melor发送消息
    .accept 6382 >>接受灰谷狩猎
step
#sticky
#label Owatanka2
#completewith next
.goto The Barrens,44.2,62.1,75,0
.goto The Barrens,49.2,62.6,75,0
.goto The Barrens,49.6,60.0,75,0
.goto The Barrens,44.2,62.1,75,0
.goto The Barrens,49.2,62.6,75,0
.goto The Barrens,49.6,60.0
>>在该区域周围搜索Owatanka（蓝雷蜥蜴）。如果你找到他，抢走他的尾钉并开始任务。如果你找不到他，跳过这个任务
.collect 5102,1,884 --Collect Owatanka's Tailspike
.accept 884 >>接受Owatanka
    .unitscan Owatanka
step
.goto The Barrens,42.5,60.3,50,0
    .goto The Barrens,47.1,63.7,50,0
    .goto The Barrens,50.0,61.1
>>杀死雷霆蜥蜴。抢他们的血
    .complete 907,1 --Thunder Lizard Blood (3)
step
.goto The Barrens,44.9,59.1
    .turnin 907 >>交出愤怒的雷霆蜥蜴
    .accept 913 >>接受雷鹰的哭泣
step
    .isOnQuest 884
.goto The Barrens,44.9,59.1    
    .turnin 884 >>交给Owatanka
step
.goto The Barrens,44.8,63.2,30,0
.goto The Barrens,47.0,61.6,30,0
.goto The Barrens,44.8,63.2,30,0
.goto The Barrens,47.0,61.6,30,0
.goto The Barrens,44.8,63.2,30,0
.goto The Barrens,47.0,61.6
    >>杀死一只雷鹰。掠夺它的翅膀
    .complete 913,1 --Thunderhawk Wings (1)
step
    .goto The Barrens,44.8,59.1
    .turnin 913 >>交出雷鹰的哭声
    .accept 874 >>接受Mahren Skyseer
step
#xprate <1.5
    .goto The Barrens,44.5,59.1
    #completewith next
    .fly Thunder Bluff >>飞向雷霆崖
step
#xprate >1.499
    .goto Thunder Bluff,45.9,64.7
    #completewith next
    >> 步行至Thunderbluff。
    .home >>将您的炉石设置为雷霆崖
step
#xprate <1.5
    .goto Thunder Bluff,45.9,64.7
    #completewith next
    .home >>将您的炉石设置为雷霆崖
step << Warrior wotlk
	.train 198 >> 火车1h梅斯
    .goto Thunder Bluff,40.93,62.71
    .vendor >> 购买连枷
    .collect 925,1
    .goto Thunder Bluff,53.20,58.27
step << Warrior tbc/Shaman
    #sticky
    #completewith next
    +如果更便宜，请从拍卖行购买一个绿色的2小时锤。如果你要运行哀嚎洞穴，跳过这一步，任务组会更好。
step << Warrior tbc/Shaman
    .goto Thunder Bluff,53.2,58.2
    .vendor >> 买一把锤子
    .collect 924,1
step
    .goto Thunder Bluff,61.4,80.9
    .turnin -1130 >>交出Melor发送消息
    .accept 1131 >>接受Steelsnap
step << Warrior
    .goto Thunder Bluff,57.2,87.4
    .accept 1823 >>接受与Ruga交谈
    .train 845 >>列车开槽
    .train 6547 >>列车Rend r3
    .train 20230 >>培训报复  
step
    .goto Thunder Bluff,54.7,51.1
    .accept 1195 >>接受圣火  
step
    #xprate <1.5
    .maxlevel 21
    .goto Thunder Bluff,22.8,20.9
    >> 进入精神升起下方的视野池
    .accept 962 >>接受蛇花
step << Shaman
    .goto Thunder Bluff,23.6,19.1
    .accept 1529 >>接受水的召唤
    .train 2645 >>训练幽灵狼
.train 8004 >>训练更小的治愈波
.train 6363 >>火车灼热图腾2
.train 913 >>训练治愈波r4
.train 8052 >>火车火焰冲击r2
.train 6390 >>火车石爪图腾2
.train 8056 >> 火车霜冻冲击
step
    #completewith next
    .goto Thunder Bluff,46.9,49.9
    .fly Crossroads >>飞向十字路口
step << !Tauren
#xprate >1.499
    .goto The Barrens,51.5,30.1
    .accept 853 >>接受药剂师Zamah
step
    .goto The Barrens,35.3,27.9
    .isOnQuest 1062
    .turnin 1062 >>交出地精侵略者
    .accept 1063 >>接受长老克罗恩
step
    .isOnQuest 6629
    .goto The Barrens,35.3,27.9
    .turnin 6629 >>移交Kill Grundig Darkcloud
step
    .isOnQuest 6523
    .goto The Barrens,35.3,27.9
    .turnin 6523 >>交出保护Kaya
    .accept 6401 >>接受Kaya的活着
step
    .isOnQuest 1060
    >>再次上山，然后进入洞穴
.goto Stonetalon Mountains,74.5,97.8
    .turnin 1060 >>把信交给金子
step
    .goto Stonetalon Mountains,71.3,95.1
    .turnin 6461 >>收起输血器
step
#xprate >1.499
    .isOnQuest 1095
    >> 前往山后的小妖精小屋
    .goto Stonetalon Mountains,59.0,62.6
    .turnin 1095 >> 提交进一步说明
step
#xprate <1.5
    >> 前往太阳岩度假区
    >> 到达太阳岩后，沿着左边的山路走
    .goto Stonetalon Mountains,49.0,62.8,40,0
    .goto Stonetalon Mountains,47.3,64.2
    .accept 6562 >> 接受深层次的麻烦
    .maxlevel 24
step
    .goto Stonetalon Mountains,47.2,61.1
    .turnin 6284 >> 上缴阿拉伯恐惧症
    .isQuestComplete 6284
step
    .goto Stonetalon Mountains,47.5,58.3
    .turnin 6401 >> 活捉Kaya
    .isQuestComplete 6401
step
    .goto Stonetalon Mountains,45.1,59.8
    .fp Sun Rock >>获得太阳岩撤退飞行路线
step
    .isOnQuest 1095
    .goto Stonetalon Mountains,59.0,62.6
    .turnin 1095 >>提交进一步说明
step
#xprate <1.5
    #sticky
    #completewith next
    .goto Stonetalon Mountains,78.2,42.8,30 >>前往Talondep Path
    .maxlevel 22
step
#xprate <1.5
    .goto Ashenvale,42.3,71.0,20 >>穿过洞穴跑到灰谷
    .maxlevel 22
step
#xprate <1.5
    .goto Ashenvale,16.3,29.8,90 >>前往Zoram'gar前哨。途中一定要避开阿斯特拉纳卫队
    .maxlevel 22
step
#xprate <1.5
    .goto Ashenvale,12.3,33.8
    .fp Zoram >> 获取Zoram'gar前哨飞行路线
    .maxlevel 22
step
#xprate <1.5
    .goto Ashenvale,11.8,34.7
    .accept 216 >> 在石头和蓟马之间接受
    .maxlevel 22
step
#xprate <1.5
    >> 与小屋里的巨魔交谈
    .goto Ashenvale,11.6,34.9
    .accept 6442 >> 在Zoram Strand接受Naga
    .accept 6462 >> 接受巨魔魅力
    .maxlevel 22
step
#xprate <1.5
    .isOnQuest 6562
    .goto Ashenvale,11.6,34.3
    .turnin 6562 >> 深陷困境
step
#xprate <1.5
    .goto Ashenvale,11.6,34.3
    .accept 6563 >> 接受阿库迈的精髓
    .maxlevel 22
step
#xprate <1.5
    >>接受此任务将启动护送。跟着他
    .goto Ashenvale,12.1,34.4
    .accept 6641 >> 接受伏尔莎的激光
    .maxlevel 22
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
    >>在水下游泳，进入黑深潭。杀死女祭司直到一张湿纸条掉落（任务）。然后右击它并接受任务。
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
    .isOnQuest 6641
step
#xprate <1.5
    .goto Ashenvale,11.6,34.3
    .turnin 6563 >> 交回阿库迈的精华
    .isOnQuest 6553
step
#xprate <1.5
    #sticky
    #completewith next
    .destroy 16784 >> 摧毁所有阿库迈剩余的蓝宝石
step
#xprate <1.5
    .goto Ashenvale,11.6,34.3
    .turnin 6564 >> 效忠旧神
    .isOnQuest 6564
step
#xprate <1.5
    .goto Ashenvale,11.7,34.9
    .turnin 6442 >> 在Zoram Strand上交给Naga
    .isOnQuest 6442
step << Druid
    >>传送至Moonglade
    .goto Moonglade,52.4,40.6
    .trainer 12042 >> 火车咒语
step
    .zoneskip Stonetalon Mountains
    #completewith eldercr
    .hs >> 火炉到雷霆崖
    .cooldown item,6948,>0
step
    #completewith next
    .goto Stonetalon Mountains,45.1,59.8
    .fly Thunder Bluff >> 飞向雷霆崖 
    .zoneskip Thunder Bluff
step
    #label eldercr
    .isOnQuest 1063
    .goto Thunder Bluff,69.8,30.8
    .turnin 1063 >> 交给克罗恩长老
    >> 等待角色扮演结束
    .accept 1064 >> 接受被遗弃的援助
step
    .isOnQuest 1489
    .goto Thunder Bluff,78.4,28.8
    .turnin 1489 >>交给Hamuul Runetotem
step
    .isQuestAvailable 1490
    .goto Thunder Bluff,78.1,29.3
    .accept 1490 >>接受Nara Wildmane
step
    .isOnQuest 1490
    .goto Thunder Bluff,75.7,31.3
    .turnin 1490 >>交给奈拉·威尔德曼
step
    .isOnQuest 1064
    >> 前往灵泉下的水池
    .goto Thunder Bluff,22.9,21.1
    .turnin 1064 >> 交出被遗弃的援助
    .accept 1065 >> 接受塔伦磨坊之旅
step << !Tauren
#xprate >1.499
    .goto Thunder Bluff,23.0,21.1
    .turnin 853 >>交给药剂师Zamah
step << !Shaman
    .goto Thunder Bluff,46.9,49.9
    #completewith next
    .fly Orgrimmar >>飞往奥格瑞玛
step << Shaman
    .goto Thunder Bluff,46.9,49.9
    #completewith next
    .fly Ratchet >>飞到棘轮
step << Shaman
    .goto The Barrens,65.8,43.8
    .turnin 1529 >>水的召唤
    .accept 1530 >>接受水的召唤
    .turnin 874 >>提交Mahren Skyseer
    .accept 873 >>接受Isha Awak
step << Shaman
    .goto The Barrens,63.1,37.1
    #completewith next
    .fly Camp Taurajo >>飞往陶拉霍营地
step << Shaman
    .goto The Barrens,45.6,59.0
    #completewith next
    .home >>将您的炉石设置为陶拉霍营地
step << Shaman
    .goto The Barrens,43.4,77.4
    .turnin 1530 >>水的召唤
    .accept 1535 >>接受水的召唤
step << Shaman
    .goto The Barrens,44.1,76.9
    .complete 1535,1 --Filled Brown Waterskin (1)
step << Shaman
    .goto The Barrens,43.4,77.4
    .turnin 1535 >>水的召唤
    .accept 1536 >>接受水的召唤
step << Shaman
    .goto Thunder Bluff,44.4,59.0
    #completewith next
    .fly Orgrimmar >>飞往奥格瑞玛
step << Shaman
.goto Orgrimmar,38.6,36.0
    #completewith next
.trainer >> 去训练你的职业咒语
step << Paladin
    .goto Orgrimmar,32.3,35.7
        #completewith next
    .trainer >> 去训练你的职业咒语
step << Warrior
.goto Orgrimmar,79.7,31.4
        #completewith next
.trainer >> 去训练你的职业咒语
step << Warrior
    .goto Orgrimmar,81.2,19.0
    .collect 29009,1 >> 从曾道剑处购买一把重型飞刀
step << Warrior/Paladin/Shaman
    .goto Orgrimmar,81.5,19.6
    .train 197 >>列车2h轴
step
    .destroy 11149 >>删除Samophlange手册
]])
