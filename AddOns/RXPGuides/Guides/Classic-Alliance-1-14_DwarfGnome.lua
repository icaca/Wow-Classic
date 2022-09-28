RXPGuides.RegisterGuide([[
#classic
#era/som
<< Alliance !Hunter
#name 1-6 寒脊山谷
#version 1
#group RestedXP 联盟 1-20
#defaultfor Dwarf/Gnome
#next 6-11 丹莫罗
step << !Gnome !Dwarf
    #sticky
    #completewith next
    .goto Dun Morogh,29.9,71.2
    +你选择了一个为侏儒和侏儒准备的向导。你应该选择与你开始时相同的起始区域
step << Mage
    #completewith next
    +请注意，您已经选择了单目标法师指南。单目标比AoE Mage安全得多，但速度慢得多
step
    >>删除您的炉石 << !Warlock
    .goto Dun Morogh,29.9,71.2
    .accept 179 >> 接受矮人装扮
step << Warrior/Warlock
    #sticky
    #completewith next
    .goto Dun Morogh,28.6,72.2,20,0
    +杀死狼群10美分以上的小贩垃圾，然后进入大楼
step << Warrior/Warlock
    .goto Dun Morogh,28.8,69.2,30 >>进入大楼
step << Warrior
    .goto Dun Morogh,28.7,67.7
    .vendor >> 供应商垃圾
step << Warrior
    .goto Dun Morogh,28.8,67.2
    .trainer >>火车战斗呐喊
step << Warlock
    .goto Dun Morogh,28.8,66.2
    .vendor >> 到后面，楼上，然后和恶魔训练师谈谈。供应商垃圾
step << Warlock
    .goto Dun Morogh,28.6,66.1
    .trainer >>火车献祭
    .accept 1599 >> 接受开始
step
    >>杀死狼。抢他们的肉
    .goto Dun Morogh,28.7,74.8
    .complete 179,1 --Collect Tough Wolf Meat (x8)
step
    .xp 2 >> 研磨至2
step << Warlock
    #softcore
    #sticky
    #completewith next
    .goto Dun Morogh,26.8,79.8,40,0
    .goto Dun Morogh,30.1,82.4,30 >> 在途中杀死一些狼，然后看这个
    .link https://www.youtube.com/watch?v=iUvGsRbIVp8 >> 单击此处
step << Warlock
    >>杀死洞穴内的霜鬃新手。掠夺他们的羽毛魅力
    .goto Dun Morogh,29.0,82.6,50,0
    .goto Dun Morogh,29.0,81.2,60,0
    .goto Dun Morogh,30.1,82.4
    .complete 1599,1 --Collect Feather Charm (x3)
step << Warlock
    #softcore
    .goto Dun Morogh,29.5,69.8,100 >> 在精神治疗师处死亡并重生
step << Warlock
    #hardcore
    .hs >> Hearth返回Coldridge Valley
step << Warlock
    >>回到术士训练师那里
    .goto Dun Morogh,28.6,66.1
    .turnin 1599 >> 开始时交上来
step << Priest/Mage/Warlock
    .goto Dun Morogh,30.0,71.5
    >>召唤你的小鬼并在途中拒绝恶魔皮肤 << Warlock
    .vendor >>供应商垃圾，修理。购买15杯水。如果你没有足够的钱，就多磨几只狼
    .collect 159,15 --Collect Refreshing Spring Water (x15)
step << Paladin/Warrior
    .goto Dun Morogh,30.0,71.5
    .vendor >>供应商垃圾
step
    .goto Dun Morogh,29.9,71.2
    .turnin 179 >> 交出矮人套装
    .accept 233 >> 接受Coldridge Valley邮件递送
    .accept 3106 >> 接受简单符文 << Dwarf Warrior
    .accept 3107 >> 接受神圣符文 << Paladin
    .accept 3109 >> 接受加密符文 << Dwarf Rogue
    .accept 3110 >> 接受神圣符文 << Priest
    .accept 3112 >> 接受简单备忘录 << Gnome Warrior
    .accept 3113 >> 接受加密备忘录 << Gnome Rogue
    .accept 3114 >> 接受字形备忘录 << Mage
    .accept 3115 >> 接受被篡改的备忘录 << Gnome Warlock
step
    #era
    .goto Dun Morogh,29.7,71.2
    .accept 170 >> 接受新威胁
step
    #sticky
    #completewith Rockjaw
    #era
    >>杀死你看到的普通岩颚巨魔
    .complete 170,1 --Kill Rockjaw Trogg (x6)
step
    #era
    .goto Dun Morogh,26.9,72.7,80,0
    .goto Dun Morogh,25.1,72.1,80,0
    .goto Dun Morogh,26.9,72.7
    >>杀死Burly Rockjaw Troggs
    .complete 170,2 --Kill Burly Rockjaw Trogg (x6)
step
    .goto Dun Morogh,22.6,71.4
    .turnin 233 >> 提交科尔德里奇谷邮件递送
    .accept 183 >> 接受野猪猎人
    .accept 234 >> 接受Coldridge Valley邮件递送
step
    .goto Dun Morogh,22.2,72.5,100,0
    .goto Dun Morogh,20.5,71.4,100,0
    .goto Dun Morogh,21.1,69.0,100,0
    .goto Dun Morogh,22.8,69.6,100,0
    .goto Dun Morogh,22.2,72.5,100,0
    .goto Dun Morogh,20.5,71.4,100,0
    .goto Dun Morogh,21.1,69.0
    >>杀死该地区的野猪
    .complete 183,1 --Kill Small Crag Boar (x12)
step
    .goto Dun Morogh,22.6,71.4
    .turnin 183 >> 上缴猎野猪者
step << Paladin/Mage/Warlock
    #era
    .xp 3+1130>>研磨至1130+/1400xp
    .goto Dun Morogh,23.0,75.0,100,0
    .goto Dun Morogh,24.2,72.5,100,0
    .goto Dun Morogh,27.7,76.3,100,0
    .goto Dun Morogh,23.0,75.0,100,0
    .goto Dun Morogh,24.2,72.5
step << Paladin/Mage/Warlock
    #som
    .xp 3+1022>>研磨至1022+/1400xp
    .goto Dun Morogh,23.0,75.0,100,0
    .goto Dun Morogh,24.2,72.5,100,0
    .goto Dun Morogh,27.7,76.3,100,0
    .goto Dun Morogh,23.0,75.0,100,0
    .goto Dun Morogh,24.2,72.5
step
    #label Rockjaw
    .goto Dun Morogh,25.1,75.7
    .turnin 234 >> 提交科尔德里奇谷邮件递送
    .accept 182 >> 接受巨魔洞穴
step << Paladin/Mage/Warlock
    .goto Dun Morogh,25.0,76.0
    .accept 3364 >> 接受烫发晨报递送
    >> 一旦接受，将启动5分钟计时器。放松并遵循指南
step << Paladin/Mage/Warlock
    #era
    .goto Dun Morogh,28.7,77.5
    >>如果你现在还没有处理完Troggs，就在这里杀了他们
    .complete 170,1 --Kill Rockjaw Trogg (x6)
step << Paladin/Mage/Warlock
    #sticky
    #completewith Scalding1
    >>如果你速度太慢，无法完成定时任务，请再去捡一次
    .goto Dun Morogh,25.0,76.0,0
    .accept 3364 >> 接受烫发晨报递送
    .goto Dun Morogh,28.8,66.4
    .turnin 3364 >> 交付烫伤晨报
step << Paladin/Mage/Warlock
    #label Scalding1
    .goto Dun Morogh,28.8,66.4
    .turnin 3364 >> 交付烫伤晨报
    .accept 3365 >> 接受带回马克杯
    .vendor >> 供应商垃圾
step << Dwarf Paladin
    .goto Dun Morogh,28.8,68.3
    .turnin 3107 >> 交上神圣符文
    .trainer >> 训练你的职业咒语
step << Gnome Mage
    .goto Dun Morogh,28.7,66.4
    .turnin 3114 >> 递交字形备忘录
    .trainer >> 训练你的职业咒语
step << Warlock
    .goto Dun Morogh,28.6,66.1
    .trainer >> 上楼去。培养你的腐败
    .turnin 3115 >> 交回被篡改的备忘录
step << Paladin/Mage/Warlock
    #era
    .goto Dun Morogh,29.7,71.2
    .turnin 170 >> 提交新威胁
step << Mage/Warlock
    .goto Dun Morogh,30.0,71.5
    .vendor >>供应商，购买10水
    .collect 159,10 --Collect Refreshing Spring Water (x10)
step << !Paladin !Mage
    #era
    #sticky
    #label TrollTroggs
    >>在玩巨魔的时候，杀死你在附近看到的任何岩颚巨魔
    .complete 170,1 --Kill Rockjaw Trogg (x6)
step << Paladin/Mage/Warlock
    .goto Dun Morogh,26.3,79.2,90,0
    .goto Dun Morogh,22.7,79.3,90,0
    .goto Dun Morogh,20.9,75.7,90,0
    .goto Dun Morogh,22.7,79.3,90,0
    .goto Dun Morogh,20.9,75.7
    >>杀死霜鬃巨魔幼崽
    .complete 182,1 --Kill Frostmane Troll Whelp (x14)
    .goto Dun Morogh,25.1,75.7
step << !Paladin !Mage !Warlock
    .goto Dun Morogh,22.7,79.3,90,0
    .goto Dun Morogh,20.9,75.7,90,0
    .goto Dun Morogh,22.7,79.3,90,0
    .goto Dun Morogh,20.9,75.7,90,0
    .goto Dun Morogh,22.7,79.3,90,0
    .goto Dun Morogh,20.9,75.7,90,0
    .goto Dun Morogh,22.7,79.3
    >>杀死霜鬃巨魔幼崽
    .complete 182,1 --Kill Frostmane Troll Whelp (x14)
    .goto Dun Morogh,25.1,75.7
step << !Paladin !Mage !Warlock
    .goto Dun Morogh,25.0,76.0
    .abandon 3364 >> 放弃烫发晨报-你还不需要它
step << !Paladin !Mage !Warlock
    .xp 4 >> 研磨至4
step << !Paladin !Mage !Warlock
    #era
    #requires TrollTroggs
    .goto Dun Morogh,25.1,75.7
    .turnin 182 >> 转入巨魔洞穴
    .accept 218 >> 接受被盗日记
step << !Paladin !Mage !Warlock
    #som
    .goto Dun Morogh,25.1,75.7
    .turnin 182 >> 转入巨魔洞穴
    .accept 218 >> 接受被盗日记
step << Paladin/Mage/Warlock
    .goto Dun Morogh,25.1,75.7
    .turnin 182 >> 转入巨魔洞穴
    .accept 218 >> 接受被盗日记
step << !Paladin !Mage !Warlock
    #softcore
    .goto Dun Morogh,25.0,76.0
    .accept 3364 >> 接受烫发晨报递送
    >>你现在有500万美元要拿到《华尔街日报》，然后交上《晨报》。如果你的任务失败了，死后再捡起来
step << Paladin/Mage/Warlock
    .goto Dun Morogh,25.0,76.0
    .turnin 3365 >> 把杯子拿回来
step
    .goto Dun Morogh,26.8,79.9,30,0
    .goto Dun Morogh,29.0,79.0,15,0
    .goto Dun Morogh,30.6,80.3
    >>进入巨魔洞穴。杀了格里克尼尔，然后把他抢走作为格雷林的日记
    .complete 218,1 --Collect Grelin Whitebeard's Journal (x1)
step << !Paladin !Mage !Warlock
    #hardcore
    .goto Dun Morogh,25.0,76.0
    .accept 3364 >> 接受烫发晨报递送
step << !Paladin !Mage !Warlock
    #hardcore
    >>磨碎一点回到这里
    .goto Dun Morogh,25.1,75.8
    .turnin 218 >> 交出被盗日记
    .accept 282 >> 接受Senir的意见
step << !Paladin !Mage !Warlock
    #softcore
    .goto Dun Morogh,29.5,69.8,100 >> 在精神治疗者处死亡并重生
step << !Paladin !Mage !Warlock
    #sticky
    #completewith Scalding2
    >>如果你速度太慢，无法完成定时任务，请再去捡一次
    .goto Dun Morogh,25.0,76.0,0
    .accept 3364 >> 接受烫发晨报递送
    .goto Dun Morogh,28.8,66.4
    .turnin 3364 >> 交付烫伤晨报
step << !Paladin !Mage !Warlock
    #label Scalding2
    .goto Dun Morogh,28.8,66.4
    .turnin 3364 >> 交付烫伤晨报
    .accept 3365 >> 接受带回马克杯
step << Rogue
    .goto Dun Morogh,28.4,67.5
    .turnin 3113 >> 提交加密备忘录 << Gnome Rogue
    .turnin 3109 >> 提交加密符文 << Dwarf Rogue
step << Dwarf Priest
    .goto Dun Morogh,28.6,66.4
    .turnin 3110 >> 交出神圣符文
    .trainer >> 训练你的职业咒语
step << Warrior
    .goto Dun Morogh,28.8,67.2
    .turnin 3106 >> 交出简单符文 << Dwarf Warrior
    .turnin 3112 >> 提交简单备忘录 << Gnome Warrior
    .trainer >> 训练你的职业咒语
step << !Paladin !Mage !Warlock
    #era
    .goto Dun Morogh,29.7,71.2
    .turnin 170 >> 提交新威胁
step << Priest
    .money <0.0025
    .goto Dun Morogh,30.0,71.5
    .vendor >> 最多购买10瓶水
step
    >>磨碎一点回到这里
    .goto Dun Morogh,25.1,75.8
    .turnin 218 >> 交出被盗日记
    .accept 282 >> 接受Senir的意见
step << !Paladin !Mage !Warlock
    .goto Dun Morogh,25.0,76.0
    .turnin 3365 >> 把杯子拿回来
step
    .goto Dun Morogh,33.5,71.8
    .turnin 282 >> 提交Senir的观察结果
    .accept 420 >> 接受Senir的意见
step
    .goto Dun Morogh,33.9,72.2
    .accept 2160 >> 接受供应给Tannok
step
    .goto Dun Morogh,34.1,71.6,20,0
    .goto Dun Morogh,35.7,66.0,0
    .goto Dun Morogh,35.7,66.0,20 >>穿过隧道

]])

RXPGuides.RegisterGuide([[
#era/som
#classic
<< Alliance !Hunter
#name 6-11 丹莫罗
#version 1
#group RestedXP 联盟 1-20
#defaultfor Dwarf/Gnome
#next 10-11 艾尔文森林 (矮人/侏儒)
step << Paladin/Warrior/Rogue
    #sticky
    #completewith BearFur
    >> 杀死野猪以获得4块野猪肉
    .collect 769,4 --Collect Chunk of Boar Meat (x4)
step << !Paladin !Warrior !Rogue
    #sticky
    #completewith BoarMeat44
    >> 杀死野猪，获得4块野猪肉供日后食用
    .collect 769,4 --Collect Chunk of Boar Meat (x4)
step
    #sticky
    #completewith Ribs
    >> 杀死野猪以获得6根野猪肋骨供日后使用
    .collect 2886,6 --Collect Crag Boar Rib (x6)
step << Priest
    >>将野猪磨碎，东北至哈拉诺斯
    .goto Dun Morogh,36.4,62.9,45,0
    .goto Dun Morogh,37.7,60.5,45,0
    .goto Dun Morogh,43.9,55.7
    .xp 5+2145>>研磨至2145/+2800xp
step << !Priest
    >>将野猪磨碎，东北至哈拉诺斯
    .goto Dun Morogh,36.4,62.9,45,0
    .goto Dun Morogh,37.7,60.5,45,0
    .goto Dun Morogh,43.9,55.7
    .xp 5+2415>>研磨至2415/+2800xp
step
    #completewith next
    #softcore
    .deathskip >> 在精神疗愈者处死亡并重生，或者跑向哈拉诺斯。确保你的分区不是Coldridge Pass
step
    #softcore
    .goto Dun Morogh,46.7,53.8
    .turnin 420 >> 提交Senir的观察结果
    .vendor >>供应商垃圾
step
    #hardcore
    >>在前往哈拉诺斯的途中磨碎野猪
    .goto Dun Morogh,46.7,53.8
    .turnin 420 >> 提交Senir的观察结果
    .vendor >>供应商垃圾
step << Warlock
    .goto Dun Morogh,47.3,53.7
    .trainer >> 从Gimrizz训练你的职业咒语
    .vendor >> 如果你在接受Dannie的训练后有钱，就买血盟书（否则以后再买）
step << !Priest
    .goto Dun Morogh,48.3,57.0
    .xp 6 >> 研磨至6
step
    .goto Dun Morogh,46.8,52.4
    .accept 384 >> 接受啤酒烤猪排
step
    .goto Dun Morogh,47.2,52.2
    .turnin 2160 >> 向Tannok移交物资
step << Rogue
    .goto Dun Morogh,47.2,52.4
    .vendor >> 购买克雷格投掷的3级。装备它
step << Rogue
    .goto Dun Morogh,47.6,52.6
    .trainer >> 训练你的职业咒语
step << Mage
    .goto Dun Morogh,47.5,52.1
    .trainer >> 训练你的职业咒语
step << Paladin
    .goto Dun Morogh,47.6,52.1
    .trainer >> 训练你的职业咒语
step << Priest
    .goto Dun Morogh,47.3,52.2
    .accept 5625 >> 接受光明之衣
step << Priest
    >>使用较低治疗等级2，然后使用咒语：登山者杜尔夫的坚韧
    .goto Dun Morogh,45.8,54.6
     .complete 5625,1 --Heal and fortify Mountaineer Dolf
step << Priest
    .goto Dun Morogh,47.3,52.2
    .turnin 5625 >> 交出光明的衣裳
    .trainer >> 训练你的职业咒语
step << Priest
    .xp 6 >> 研磨至6
step << Priest/Mage/Warlock
    .goto Dun Morogh,47.4,52.5
    .home >> 将您的炉石设置为Thunderbrew酒厂
    .vendor >> 尽可能多地购买5级饮料
step << !Mage !Priest !Warlock
    .goto Dun Morogh,47.4,52.5
    .home >> 将您的炉石设置为Thunderbrew酒厂
    .vendor >> 供应商垃圾
step << Warrior
    .goto Dun Morogh,47.4,52.6
    .trainer >> 训练你的职业咒语
step << Paladin/Warrior
    .goto Dun Morogh,45.8,51.8,20 >> 进入大楼
step << Gnome Warrior
    .goto Dun Morogh,45.3,52.2
    >>修理你的武器。如果你有足够的钱（5s36c），从Grawn买一辆Gladius。否则，请跳过此步骤（稍后再回来）
    .collect 2488,1 --Collect Gladius (1)
step << Dwarf Warrior
    .goto Dun Morogh,45.3,52.2
     >>修理你的武器。如果你有足够的钱（4s84c），从Grawn买一把大斧子。否则，请跳过此步骤（稍后再回来）
    .collect 2491,1 --Collect Large Axe (1)
step << Rogue
    .goto Dun Morogh,45.3,52.2
    >>修理你的武器。如果你有足够的钱（4s1c），从Grawn买一个细高跟鞋。否则，请跳过此步骤（稍后再回来）
    .collect 2494,1 --Collect Stiletto (1)
step << Paladin
    .goto Dun Morogh,45.3,52.2
    >>修理你的武器。如果你有足够的钱（7s1c），从Grawn买一把木制锤子。否则，请跳过此步骤（稍后再回来）
    .collect 2493,1 --Collect Wooden Mallet (1)
step << Warrior/Rogue
    .goto Dun Morogh,45.3,51.9
    .trainer >> 火车铁匠。这将允许你为你的武器制造+2伤害磨石，这些磨石非常坚固。
    >> 如果你想从事自己的职业，跳过这一步
step << Paladin
    .goto Dun Morogh,45.3,51.9
    .trainer >> 火车铁匠。这将允许你为你的武器制造+2点非常强大的伤害重石。
    >> 如果你想从事自己的职业，跳过这一步
step
    .goto Dun Morogh,46.0,51.7
    .accept 400 >> 钢格栅的验收工具
step
    .goto Dun Morogh,49.4,48.4
    >>不要在途中杀死熊
    .accept 317 >> 接受库存Jetsteam
step
    .goto Dun Morogh,49.6,48.6
    .accept 313 >> 接受Grizzled Den
step
    .goto Dun Morogh,50.4,49.1
    .turnin 400 >> 钢格栅上交工具
step
    #label BoarMeat44
    .goto Dun Morogh,50.1,49.4
    .accept 5541 >> 接受弹药以防隆隆枪击
step << Warrior/Paladin/Rogue
    .money <0.0091
    .goto Dun Morogh,50.1,49.4
    .collect 2901,1 >> 如果你训练了锻造，就买一把采矿镐
step << Warrior/Paladin/Rogue
    .goto Dun Morogh,50.01,50.31
    .trainer >>进屋去。训练采矿，铸造寻找矿物
step << Paladin/Warrior/Rogue
    #sticky
    #completewith BearFur
    >>获取熊皮毛，以便在您的任务中为喷气式飞机提供库存
    .complete 317,2 --Collect Thick Bear Fur (x2)
step << !Paladin !Warrior !Rogue
    .goto Dun Morogh,52.0,50.1,100,0
    .goto Dun Morogh,51.5,53.9,100,0
    .goto Dun Morogh,50.1,53.9,100,0
    .goto Dun Morogh,49.9,50.9,100,0
    .goto Dun Morogh,48.0,49.5,100,0
    .goto Dun Morogh,48.2,46.9,100,0
    .goto Dun Morogh,43.5,52.5,100,0
    .goto Dun Morogh,52.0,50.1,100,0
    .goto Dun Morogh,51.5,53.9,100,0
    .goto Dun Morogh,50.1,53.9,100,0
    .goto Dun Morogh,49.9,50.9,100,0
    .goto Dun Morogh,48.0,49.5,100,0
    .goto Dun Morogh,48.2,46.9,100,0
    .goto Dun Morogh,43.5,52.5,100,0
    .goto Dun Morogh,52.0,50.1,100,0
    .goto Dun Morogh,51.5,53.9,100,0
    .goto Dun Morogh,50.1,53.9,100,0
    .goto Dun Morogh,49.9,50.9,100,0
    .goto Dun Morogh,48.0,49.5,100,0
    .goto Dun Morogh,48.2,46.9,100,0
    .goto Dun Morogh,43.5,52.5,100,0
    .goto Dun Morogh,52.0,50.1,0
    .goto Dun Morogh,51.5,53.9,0
    .goto Dun Morogh,50.1,53.9,0
    .goto Dun Morogh,49.9,50.9,0
    .goto Dun Morogh,48.0,49.5,0
    .goto Dun Morogh,48.2,46.9,0
    .goto Dun Morogh,43.5,52.5
    >>获取Jetsteam库存物品
    .complete 317,1 --Collect Chunk of Boar Meat (x4)
    .complete 317,2 --Collect Thick Bear Fur (x2)
step << !Paladin !Warrior !Rogue
    .goto Dun Morogh,49.4,48.4
    .turnin 317 >> 上缴库存Jetsteam
    .accept 318 >> 接受Evershine
step << Warrior
    .goto Dun Morogh,46.9,52.1,20,0
    .goto Dun Morogh,47.4,52.5
    .vendor >> 尽可能多地购买5级食物
step << Priest/Mage/Warlock
    .goto Dun Morogh,46.9,52.1,20,0
    .goto Dun Morogh,47.4,52.5
    .vendor >> 尽可能多地购买5级饮料
step
    .goto Dun Morogh,42.25,53.68,40,0
    .goto Dun Morogh,41.07,49.04,50,0
    .goto Dun Morogh,42.25,53.68
    >> 到洞里去。杀死Wendigos。掠夺他们的鬃毛 << !Warrior !Rogue !Paladin
    >> 杀死Wendigos。掠夺他们的鬃毛。留意纹理，为武器打磨石头而获得粗糙的石头 << Warrior/Rogue
    >> 杀死Wendigos。掠夺他们的鬃毛。留心纹理，为武器的配重块获取粗糙的石头 << Paladin
    .complete 313,1 --Collect Wendigo Mane (x8)
step
    >>抢劫板条箱
    .goto Dun Morogh,44.1,56.9
    .complete 5541,1 --Collect Rumbleshot's Ammo (x1)
step
    #label BearFur
    .goto Dun Morogh,40.6,62.6,50,0
    .goto Dun Morogh,40.7,65.1
    .turnin 5541 >> 交出弹药进行隆布尔枪击
    .vendor >> 供应商和维修
step << !Paladin !Warrior !Rogue
    .xp 7 >> 研磨至7
step << Paladin/Warrior/Rogue
    .goto Dun Morogh,51.4,50.4
    >>杀死熊和野猪。抢他们的皮毛和肉
    .complete 317,2 --Collect Thick Bear Fur (x2)
    .complete 317,1 --Collect Chunk of Boar Meat (x4)
step << Warrior/Paladin/Rogue
    .goto Dun Morogh,49.4,48.4
    .turnin 317 >> 上缴库存Jetsteam
    .accept 318 >> 接受Evershine
step << Warrior/Paladin/Rogue
    .goto Dun Morogh,49.6,48.6
    .turnin 313 >> 在Grizzled Den转弯
step << Warrior/Paladin/Rogue
    .goto Dun Morogh,50.1,49.4
    .collect 2901,1 >> 购买采矿镐
step << Warrior/Paladin/Rogue
    #era
    .xp 7 >> 研磨至7
step << Warrior/Rogue
    #som
    .xp 8 >> 将附近的暴徒碾碎至8
step << Rogue
    #som
    .goto Dun Morogh,47.6,52.6
    .trainer >> 训练你的职业咒语
step << Paladin
    #som
    #level 8
    .goto Dun Morogh,47.60,52.07
    .trainer >> 训练你的职业咒语
step << Warrior
    #som
    .goto Dun Morogh,47.4,52.6
    .trainer >> 训练你的职业咒语
step << Rogue
    .goto Dun Morogh,45.3,52.2
    >>修理你的武器。如果你有足够的钱（4s1c），从Grawn买一个细高跟鞋。否则，请跳过此步骤（稍后再回来）
    .collect 2494,1 --Collect Stiletto (1)
step << Gnome Warrior
    .goto Dun Morogh,45.3,52.2
    >>修理你的武器。如果你有足够的钱（5s36c），从Grawn买一辆Gladius。否则，请跳过此步骤（稍后再回来）
    .collect 2488,1 --Collect Gladius (1)
step << Dwarf Warrior
    .goto Dun Morogh,45.3,52.2
     >>修理你的武器。如果你有足够的钱（4s84c），从Grawn买一把大斧子。否则，请跳过此步骤（稍后再回来）
    .collect 2491,1 --Collect Large Axe (1)
step << Paladin
    .goto Dun Morogh,45.3,52.2
    >>修理你的武器。如果你有足够的钱（7s1c），从Grawn买一把木制锤子。否则，请跳过此步骤（稍后再回来）
    .collect 2493,1 --Collect Wooden Mallet (1)
step << Warrior/Rogue
    .goto Dun Morogh,47.4,52.5
    .vendor >> 购买最多20种5级食物
step << Paladin
    .goto Dun Morogh,47.4,52.5
    .vendor >> 购买最多10种5级食物
step << Paladin/Warrior/Rogue
    >>在途中碾碎一些暴徒
    .goto Dun Morogh,43.0,47.4,100,0
    .goto Dun Morogh,39.6,48.9,100,0
    .goto Dun Morogh,34.6,51.7
    .accept 312 >> 接受Tundra MacGrann被盗的Stash
step << !Paladin !Warrior !Rogue
    >>在途中碾碎一些暴徒
    .goto Dun Morogh,35.2,56.4,100,0
    .goto Dun Morogh,36.0,52.0,100,0
    .goto Dun Morogh,34.6,51.7
    .accept 312 >> 接受Tundra MacGrann被盗的Stash
step << !Mage !Priest
    #completewith next
    .goto Dun Morogh,30.5,46.0
    .vendor >> 供应商垃圾
step << Priest/Mage/Warlock
    #completewith next
    .goto Dun Morogh,30.5,46.0
    .vendor >> 小贩购买最多20杯5级饮料
step
    .goto Dun Morogh,30.2,45.8
    .turnin 318 >> 交给Evershine
    .accept 319 >> 接受对Evershine的支持
    .accept 315 >> 接受完美的烈性酒
step
    .goto Dun Morogh,30.2,45.5
    .accept 310 >> 接受残酷的竞争对手
step
    #label Ribs
    .goto Dun Morogh,31.5,38.9,100,0
    .goto Dun Morogh,28.3,39.9,100,0
    .goto Dun Morogh,28.7,43.7,100,0
    .goto Dun Morogh,25.8,47.2,100,0
    .goto Dun Morogh,25.8,47.2,100,0
    .goto Dun Morogh,30.0,51.8,100,0
    .goto Dun Morogh,31.5,38.9,100,0
    .goto Dun Morogh,28.3,39.9,100,0
    .goto Dun Morogh,28.7,43.7,100,0
    .goto Dun Morogh,25.8,47.2,100,0
    .goto Dun Morogh,25.8,47.2,100,0
    .goto Dun Morogh,30.0,51.8,100,0
    .goto Dun Morogh,28.7,43.7
    >> 杀死熊、野猪和豹子
    .complete 319,1 --Kill Ice Claw Bear (x6)
    .complete 319,2 --Kill Elder Crag Boar (x8)
    .complete 319,3 --Kill Snow Leopard (x8)
step
    >>完成野猪肋
    .complete 384,1 --Collect Crag Boar Rib (x6)
step
    .goto Dun Morogh,30.2,45.7
    .turnin 319 >> 为Evershine提供支持
    .accept 320 >> 接受返回Bellowfiz
step
    .isQuestTurnedIn 384
    .xp 7+4360>>研磨至4360+/4500xp
step
    .xp 7+3735>>研磨至3735+/4500xp
    .goto Dun Morogh,31.5,38.9,100,0
    .goto Dun Morogh,28.3,39.9,100,0
    .goto Dun Morogh,28.7,43.7,100,0
    .goto Dun Morogh,25.8,47.2,100,0
    .goto Dun Morogh,25.8,47.2,100,0
    .goto Dun Morogh,30.0,51.8,100,0
    .goto Dun Morogh,31.5,38.9,100,0
    .goto Dun Morogh,28.3,39.9,100,0
    .goto Dun Morogh,28.7,43.7,100,0
    .goto Dun Morogh,25.8,47.2,100,0
    .goto Dun Morogh,25.8,47.2,100,0
    .goto Dun Morogh,30.0,51.8,100,0
step
    #softcore
    .goto Dun Morogh,30.3,37.5,60 >> 跑到这里
step
    #softcore
    .goto Dun Morogh,30.9,33.1,15 >>向北跑上山
step
    #softcore
    .goto Dun Morogh,32.4,29.1,15 >>继续到这里
step
    #softcore
    .goto Dun Morogh,33.0,27.2,15,0
    .goto Dun Morogh,33.0,25.2,15,0
    .goto Wetlands,11.6,43.4,60,0
    .goto Wetlands,11.6,43.4,0
    .deathskip >>继续向北跑，一旦General Chat变为湿地，就跳下去死去，然后在Menethil港重生
step
    #softcore
    #completewith next
    .goto Wetlands,12.7,46.7,30 >> 游到岸上
step
    #softcore
    .goto Wetlands,9.5,59.7
    .fp Wetlands>> 获取Menethil Harbor航线
step
	#completewith next
    .hs >> 赫斯到哈拉诺斯
step
    .goto Dun Morogh,47.4,52.5
    >> 从Belm购买狂想曲麦芽和雷霆啤酒
    .complete 384,2 --Collect Rhapsody Malt (x1)
    .collect 2686,1,311 --Collect Thunder Ale (x1)
step
    .goto Dun Morogh,47.6,52.4,15,0
    >>进客栈老板后面的房间。下楼去，然后和贾文谈谈，给他雷霆啤酒
    >>等待木桶鼠标移到“无人看守”位置，然后handin
    .turnin 310 >> 在激烈的竞争中获胜
    .accept 311 >> 接受返回Marleth
step
    .goto Dun Morogh,46.8,52.4
    .turnin 384 >> 翻啤酒扒猪排
     >>当你下一个供应商时出售配方
step << !Paladin !Rogue !Warrior
    .xp 8 >> 研磨至8
step << Warlock
    .goto Dun Morogh,47.3,53.7
    >>与Gimrizz交谈
    .trainer >> 训练你的职业咒语
    .vendor >> 如果您在培训后有钱，请购买Firebolt书籍（否则请稍后购买）
step << Rogue
    .goto Dun Morogh,47.6,52.6
    .trainer >> 训练你的职业咒语
step << Mage
    .goto Dun Morogh,47.5,52.1
    .trainer >> 训练你的职业咒语
step << Paladin
    .goto Dun Morogh,47.60,52.07
    .trainer >> 训练你的职业咒语
step << Priest
    .goto Dun Morogh,47.3,52.2
    .trainer >> 训练你的职业咒语
step << Warrior
    .goto Dun Morogh,47.4,52.6
    .trainer >> 训练你的职业咒语
step << Warrior/Rogue/Paladin
    .money <0.01
    .goto Dun Morogh,47.2,52.6
    .trainer >> 训练绷带急救
step << Rogue
    .goto Dun Morogh,45.3,52.2
    >>修理你的武器。如果你有足够的钱（4s1c），从Grawn买一个细高跟鞋。否则，请跳过此步骤（稍后再回来）
    .collect 2494,1 --Collect Stiletto (1)
step << Paladin
    .goto Dun Morogh,45.3,52.2
    >>修理你的武器。如果你有足够的钱（7s1c），从Grawn买一把木制锤子。否则，请跳过此步骤（稍后再回来）
    .collect 2493,1 --Collect Wooden Mallet (1)
step << Gnome Warrior
    .goto Dun Morogh,45.3,52.2
    >>修理你的武器。如果你有足够的钱（5s36c），从Grawn买一辆Gladius。否则，请跳过此步骤（稍后再回来）
    .collect 2488,1 --Collect Gladius (1)
step << Dwarf Warrior
    .goto Dun Morogh,45.3,52.2
     >>修理你的武器。如果你有足够的钱（4s84c），从Grawn买一把大斧子。否则，请跳过此步骤（稍后再回来）
    .collect 2491,1 --Collect Large Axe (1)
step << Warrior/Rogue
    .goto Dun Morogh,47.4,52.5
    .vendor >> 从客栈老板那里购买最多30种五级食物
step << Paladin
    .goto Dun Morogh,47.4,52.5
    .vendor >> 从客栈老板那里购买最多15种五级食物
step << Priest/Mage/Warlock
    .goto Dun Morogh,47.4,52.5
    .vendor >> 从客栈老板那里购买至多30杯5级饮料
step
    .goto Dun Morogh,46.7,53.8
    .accept 287 >> 接受Frostmane保持
step
    .goto Dun Morogh,49.6,48.6
    .turnin 313 >> 在Grizzled Den转弯
step
    .goto Dun Morogh,49.4,48.4
    >>选择野营刀。保存以备以后使用 << Rogue
    .turnin 320 >> 转身返回贝洛菲兹
step
    #era << Warlock
    >>建筑物内部
    .goto Dun Morogh,45.8,49.4
    .accept 412 >> 接受操作重组
step
    #completewith next
    .goto Dun Morogh,43.1,45.0,20,0
    .goto Dun Morogh,42.1,45.4,20 >> 跑上坡道到Shimmerweed
step
    .goto Dun Morogh,40.9,45.3,50,0
    .goto Dun Morogh,41.5,43.6,50,0
    .goto Dun Morogh,39.7,40.0,50,0
    .goto Dun Morogh,42.1,34.3,50,0
    .goto Dun Morogh,39.5,43.0
    .goto Dun Morogh,41.5,36.0
    >>清除这个地区的暴徒。如果你需要清理中间营地，请小心。如果你需要更多的暴徒，你可以把暴徒拉到小屋里，视线（LoS）在小屋后面。如果你运气不好，就跑到另一个地方去
    >>在地上抢劫篮子
    >>如果你在这里抢劫亚麻布，就要做砝码 << Paladin
    .complete 315,1 --Collect Shimmerweed (x6)
step << !Mage !Warlock
    .goto Dun Morogh,38.5,54.0
    >>等到老冰胡子离开山洞，你就可以偷偷进去洗劫箱子，或者这样做
        .link https://www.youtube.com/watch?v=o55Y3LjgKoE >>点击此处查看视频参考
    .complete 312,1 --MacGrann's Dried Meats (1)
step << Mage/Warlock
    >> 变形老冰胡子，然后洗劫肉 << Mage
    >> 害怕老冰胡子，然后洗劫肉 << Warlock
    .goto Dun Morogh,38.5,53.9
    .complete 312,1 --Collect MacGrann's Dried Meats (x1)
step
    .goto Dun Morogh,34.6,51.7
    .turnin 312 >> 交出Tundra MacGrann被盗的Stash
step << Mage/Priest/Warlock
    #completewith next
    .goto Dun Morogh,30.4,45.8
    .vendor >> 最多再购买10杯5级饮料
step << Warrior/Paladin/Rogue
    #completewith next
    .goto Dun Morogh,30.4,45.8
    .vendor >> 供应商垃圾
step
    .goto Dun Morogh,30.2,45.7
    .turnin 315 >> 交上完美的烈酒
    .accept 413 >> 接受Shimmer Stout
step
    .goto Dun Morogh,30.2,45.5
    .turnin 311 >> 交给马利思
step
    #era << Warlock
    .goto Dun Morogh,27.2,43.0,80,0
    .goto Dun Morogh,24.8,39.3,80,0
    .goto Dun Morogh,25.6,43.4,80,0
    .goto Dun Morogh,24.3,44.0,80,0
    .goto Dun Morogh,25.4,45.4,80,0
    .goto Dun Morogh,25.00,43.50
    >>杀死麻风侏儒。抢劫他们的装备和鞋帽
    .complete 412,2 --Collect Gyromechanic Gear (x8)
    .complete 412,1 --Collect Restabilization Cog (x8)
step
    #era
    .xp 9 >> 研磨至9
step
    .goto Dun Morogh,24.5,50.8,40,0
    .goto Dun Morogh,22.1,50.3,40,0
    .goto Dun Morogh,21.3,52.9,40,0
    .goto Dun Morogh,24.5,50.8,0
    .goto Dun Morogh,22.1,50.3,0
    .goto Dun Morogh,21.3,52.9,0
    >>杀死洞穴内的猎头
    .complete 287,1 --Kill Frostmane Headhunter (x5)
step
    #softcore
    .goto Dun Morogh,23.4,51.5,15 >>返回洞穴
step
    #softcore
    >>跳进下面的角落
    .goto Dun Morogh,23.0,52.2
    .complete 287,2 --Fully explore Frostmane Hold
step
    #softcore
    #completewith next
    .deathskip >> 在哈拉诺死后重生
step
    #hardcore
    >>小心地磨进洞里的这个角落
    .goto Dun Morogh,23.0,52.2
    .complete 287,2 --Fully explore Frostmane Hold
step
    #hardcore
   .goto Dun Morogh,46.7,53.8,150 >> 如果没问题的话，就把炉子烧了，否则就要碾回哈拉诺斯
step
    .goto Dun Morogh,46.7,53.8
    .turnin 287 >> 交给Frostmane Hold
    .accept 291 >> 接受报告
step << Rogue
    #level 10
    .goto Dun Morogh,47.6,52.6
    .accept 2218 >> 接受救世之路
step << !Paladin !Priest
    .goto Dun Morogh,47.2,52.6
    .train 3273 >> 培训急救
step
    #era << Warlock
    >>建筑物内部
    .goto Dun Morogh,45.8,49.4
    .turnin 412 >> 转入操作再栓塞
step << Warrior
    #sticky
    #completewith next
    .money >0.1000
    +开始研磨，直到你有10个可售物品，然后跑进铁炉堡
step << Warrior
    .goto Dun Morogh,53.5,34.9,30 >> 跑进铁炉堡
step << Warrior
    >>进入大楼
    .goto Ironforge,61.2,89.5
    .trainer >>列车2h梅斯
step << Warrior
    #sticky
    #completewith next
    .goto Dun Morogh,53.5,34.9,100 >>冲出铁炉堡
step
    .goto Dun Morogh,60.1,52.6,50,0
    .goto Dun Morogh,63.1,49.8
    .accept 314 >> 接受保护羊群
step
    #sticky
    #completewith next
    .goto Dun Morogh,62.3,50.3,14,0
    .goto Dun Morogh,62.2,49.4,10 >>跑上山的这一部分
step
    >>杀死瓦加什。抢他的牙
    >>把他引到牧场南边的守卫那里。确保你对他造成51%+的伤害
    >>小心，因为这个任务很难完成
    .goto Dun Morogh,62.6,46.1
    .complete 314,1 --Collect Fang of Vagash (1)
    .link https://www.youtube.com/watch?v=ZJX6sCkm5JY >> 单击此处了解如何独奏瓦加什
step
    .goto Dun Morogh,63.1,49.8
    .turnin 314 >> 转身保护羊群
step
    >>途中磨碎一点
    .goto Dun Morogh,68.6,54.7
    .vendor >>供应商垃圾箱。如果需要，买一些食物 << Warrior/Rogue
    .vendor >>供应商垃圾箱。如果需要，购买一些食物/水 << !Warrior !Rogue
step
    .goto Dun Morogh,68.4,54.5
    .train 2550 >> Ghilm的火车烹饪
step
    .goto Dun Morogh,68.7,56.0
    .accept 433 >> 接受公务员
step
    #completewith next
    .goto Dun Morogh,68.9,55.9
    .vendor >> 供应商垃圾，修理
step
    .goto Dun Morogh,69.1,56.3
    .accept 432 >> 接受那些被炸死的流浪汉！
step
    .goto Dun Morogh,70.7,56.4,40,0
    .goto Dun Morogh,70.62,52.39,25,0
    .goto Dun Morogh,70.7,56.4
    >>杀死洞穴内的Troggs
    .complete 432,1 --Kill Rockjaw Skullthumper (x6)
    .complete 433,1 --Kill Rockjaw Bonesnapper (x10)
step
    .goto Dun Morogh,69.1,56.3
    .turnin 432 >> 把那些被炸死的暴徒交上来！
step
    #completewith next
    .goto Dun Morogh,68.9,55.9
    .vendor >> 供应商垃圾，修理
step
    .goto Dun Morogh,68.7,56.0
    .turnin 433 >> 上缴公务员
step
    #era
    .goto Dun Morogh,67.1,59.7
    .xp 10 >> 在拖架上研磨至10
step
    .goto Dun Morogh,83.8,39.2
    .accept 419 >> 接受迷失的飞行员
step
    >>途中研磨
    .goto Dun Morogh,79.7,36.2
    .turnin 419 >> 交出失踪的飞行员
    .accept 417 >> 接受飞行员的复仇
step
    >>杀死芒格克劳。抢走他的爪子
    .goto Dun Morogh,78.97,37.14
    .complete 417,1 --Collect Mangy Claw (x1)
step
    .goto Dun Morogh,83.9,39.2
    .turnin 417 >> 提交飞行员的复仇
step
    .goto Dun Morogh,79.6,50.7,50,0
    .goto Dun Morogh,82.3,53.5,25,0
    .goto Dun Morogh,86.3,48.8
    .turnin 413 >> 转入Shimmer Stout
    .accept 414 >> 接受斯托特到卡德雷尔
step
    >>穿过隧道进入Loch
    .goto Loch Modan,22.1,73.1
    .accept 224 >> 接受保护国王的土地
step
    .goto Loch Modan,23.2,73.7
    >>从后面进入沙坑
    .accept 267 >> 接受Trogg威胁
step
    .goto Loch Modan,32.6,49.9,80.0,0
    .goto Loch Modan,37.2,46.1,80.0,0
    .goto Loch Modan,36.7,41.6
    >>找到卡德雷尔。他沿着塞尔萨马尔公路巡逻
    .turnin 414 >> 把斯托特交给卡德雷尔
    .accept 416 >> 接受捕鼠
    .accept 1339 >> 接受登山者Stormpike的任务
step
    >>进入大楼，然后下楼。与Brock交谈
    .goto Loch Modan,37.2,46.9,15,0
    .goto Loch Modan,37.0,47.8
    .accept 6387 >> 接受荣誉学生
step
    .goto Loch Modan,34.8,49.3
    .accept 418 >> 接受Thelsamar鲜血香肠
step
    .goto Loch Modan,34.8,48.6
    .vendor >>购买6槽包
step << !Paladin
    .goto Loch Modan,35.5,48.4
    .home >> 把你的炉石放在塞尔萨马尔
step << skip
    #sticky
    #completewith next
    +磨碎暴徒，直到你至少有33银币和可售物品
--N rogue money gate for cutlass+1h剑
step
    #sticky
    #completewith Thelsamar1
    >>为了塞尔萨马尔血香肠杀死区域内的蜘蛛
    .complete 418,1 --Collect Boar Intestines (x3)
    .complete 418,2 --Collect Bear Meat (x3)
    .complete 418,3 --Collect Spider Ichor (x3)
    >>也把你得到的大块野猪肉留着以后烹饪
step
    >>跑到北方的掩体
    .goto Loch Modan,24.8,18.4
    .accept 307 >> 接受肮脏的爪子
    .turnin 1339 >> 提交登山者Stormpike的任务
    .accept 1338 >> 接受Stormpike的命令
step
    #completewith next
    .deathskip >> 在塞尔萨马尔死亡并重生
step
    #label Thelsamar1
    .goto Loch Modan,33.9,51.0
    .turnin 6387 >> 移交荣誉学生
    .accept 6391 >> 接受铁炉堡之旅
step
    .goto Loch Modan,33.9,51.0
    .fly Ironforge >> 飞往铁炉堡
step
    .goto Ironforge,51.5,26.3
    .turnin 6391 >> 上交骑行前往铁炉堡
    .accept 6388 >> 接受Gryth Thurden
step
    .goto Ironforge,39.5,57.5
    .turnin 291 >> 提交报告
step
    >>不要在任何地方飞行
    .goto Ironforge,55.5,47.8
    .turnin 6388 >> 转入Gryth Thurden
    .accept 6392 >> 接受返回Brock
step
    #completewith next
    +执行注销跳过，跳到鹰头狮的头上，注销，然后再重新登录
    .link https://www.youtube.com/watch?v=PWMJhodh6Bw >> 单击此处
step
    .goto Ironforge,74.40,51.10,30,0
    .goto Ironforge,74.40,51.10,0
     >> 进入Deeprun Tram，在中间平台与侏儒交谈
    .accept 6661 >> 接受Deeprun老鼠围捕
step
    >>用你的长笛对付四处散落的老鼠
    .complete 6661,1 --Rats Captured (x5)
step
    .turnin 6661 >> 交给Deeprun老鼠围捕
    .accept 6662 >> 接受我，兄弟，尼普西
step
     .isOnQuest 6662
    >> 乘电车去暴风城，到了电车的另一边后再转弯
    .turnin 6662 >> 交给我，兄弟，尼普西
    >>在等待/乘坐电车时进行急救训练，您需要80分的急救积分才能完成24级任务 << Rogue
step
    #completewith next
    .goto StormwindClassic,60.5,12.3
    .zone Stormwind City >>下车进入暴风城
step
    .goto StormwindClassic,51.6,12.2
    .accept 353 >> 接受Stormpike的交付
step
    .goto StormwindClassic,58.1,16.5
    .turnin 1338 >> 提交Stormpike的命令
step << Priest
    #completewith next
    >>进入大教堂
    .goto StormwindClassic,38.54,26.86
    .trainer >> 训练你的职业咒语
    .turnin 5634 >> 递交绝望祈祷
step << Priest
    .goto StormwindClassic,38.62,26.10
    .train 13908 >> 训练绝望祈祷
step << Warrior
    #completewith next
    .goto StormwindClassic,74.91,51.55,20 >> 进入指挥中心
step << Warrior
    .goto StormwindClassic,78.67,45.80
    .trainer >> 上楼去。训练你的职业咒语
    .accept 1638 >> 接受战士训练
step << Warrior
    #sticky
    #completewith next
    .goto StormwindClassic,71.7,39.9,20 >>进入酒馆
step << Warrior
    .goto StormwindClassic,74.3,37.3
    .turnin 1638 >> 交战士训练
    .accept 1639 >> 接受醉汉巴特比
step << Warrior
    .goto StormwindClassic,73.8,36.3
    .turnin 1639 >> 交给醉汉巴特比
    .accept 1640 >> 接受Beat Bartleby
    .complete 1640,1 --Beat Bartleby
step << Warrior
    .goto StormwindClassic,73.8,36.3
    .turnin 1640 >> 加入Beat Bartleby
    .accept 1665 >> 接受巴特比的马克杯
step << Warrior
    >>你现在将学习防御姿态和破甲
    .goto StormwindClassic,74.3,37.3
    .turnin 1665 >> 交给巴特比的马克杯
step << Warlock
    #sticky
    #completewith next
    .goto StormwindClassic,29.2,74.0,20,0
    .goto StormwindClassic,27.2,78.1,15 >> 走进屠宰羔羊，下楼去
step << Warlock
    .goto StormwindClassic,26.12,77.20
    .trainer >> 训练你的职业咒语
step << Warlock
    .goto StormwindClassic,25.2,78.5
    .accept 1688 >> 接受Surena Caledon
step
    .goto StormwindClassic,57.1,57.7
    .trainer >>训练1h剑 << Rogue
    .trainer >>火车杆 << Priest
    .trainer >>训练1小时剑和棍 << Warlock/Mage
    .trainer >>训练2h剑 << Warrior/Paladin
step << Rogue
    .goto StormwindClassic,57.6,57.1
    .vendor >> 如果你有钱，就从Gunther那里买把弯刀并装备起来。在你的副手上装备早期的工匠匕首
step << Rogue
    >>进入大楼
    .goto StormwindClassic,57.32,62.08,20,0
    .goto StormwindClassic,58.37,61.69
    .vendor >> 购买瑟曼的11级投掷。11级时装备它
]])

RXPGuides.RegisterGuide([[
#era/som
#classic
<< Alliance !Hunter
#name 10-11 艾尔文森林 (矮人/侏儒)
#version 1
#group RestedXP 联盟 1-20
#defaultfor Gnome/Dwarf
#next 11-14 洛克莫丹 (矮人/侏儒)
--#era << !Warlock

step << Warlock
     #softcore
    #completewith next
     +在前往飞行大师的途中开始生活攻关
step
    .goto StormwindClassic,66.20,62.40
    .fp Stormwind City >> 获得暴风城飞行路线
step << Warlock
     #softcore
    #completewith next
     >> 跳下飞行管理员旁边的壁架（而不是水），自杀，跳之前确保使用活水龙头
    .deathskip >>Goldshire的Spirit rez
step
    .goto Elwynn Forest,42.10,65.90
     >>前往Goldshire
    .accept 62 >> 接受Fargodeep矿井
step
    >>在你靠近的左边
    .goto Elwynn Forest,43.3,65.7
    .accept 60 >> 接受Kobold Candles
step << Mage
    .goto Elwynn Forest,43.25,66.19
    .trainer >> 上楼去。训练你的职业咒语
step << Rogue
    .goto Elwynn Forest,43.88,65.93
    .trainer >> 上楼去。训练你的职业咒语
step
    .goto Elwynn Forest,42.10,67.30
    .accept 40 >> 接受鱼的危险
    .accept 47 >> 接受金尘交换
step << Warlock
    >>点击周围任何通缉海报
    .goto Elwynn Forest,24.6,74.7
    .accept 176 >> 接受通缉：“Hogger”
step << Warlock
    #sticky
    #completewith collector
    >>请留意取金时间表（幸运滴），或Gruff Swiftbite的100%滴（罕见）。额外210xp
    .collect 1307,1,123 --Collect Gold Pickup Schedule (x1)
    .accept 123 >> 接受催收员
step << Warlock
    #label Hogger
    .unitscan Hogger
    .goto Elwynn Forest,27.0,86.7,100,0
    .goto Elwynn Forest,26.1,89.9,100,0
    .goto Elwynn Forest,25.2,92.7,100,0
    .goto Elwynn Forest,27.0,93.9,100,0
    .goto Elwynn Forest,27.0,86.7,100,0
    .goto Elwynn Forest,26.1,89.9,100,0
    .goto Elwynn Forest,25.2,92.7,100,0
    .goto Elwynn Forest,27.0,93.9,100,0
    .goto Elwynn Forest,27.0,86.7,100,0
    .goto Elwynn Forest,26.1,89.9,100,0
    .goto Elwynn Forest,25.2,92.7,100,0
    .goto Elwynn Forest,27.0,93.9,100,0
    .goto Elwynn Forest,25.9,93.9
    >>Hogger可以出现在该地区的多个地点。让他恐惧重重，和/或在24,80时以<60%的马力将他风筝到塔上。抢走他的爪子
    >>小心，因为这可能很困难
    .complete 176,1 --Huge Gnoll Claw (1)
step
    .accept 88 >> 接受公主必死无疑！
    .goto Elwynn Forest,34.60,84.50
    .accept 85 >> 接受丢失的项链
    .goto Elwynn Forest,34.40,84.2
step
    .goto Elwynn Forest,43.0,85.8
    .turnin 85 >> 交回丢失的项链
    .accept 86 >> 为比利接受派
step
    #sticky
    #label Fargodeep
    >>从该地区的Kobolds人手中抢夺蜡烛和灰尘
    .complete 60,1 --Kobold Candle (8)
    .complete 47,1 --Gold Dust (10)
step
    .goto Elwynn Forest,40.5,82.3
    >>进入矿井
    .complete 62,1 --Scout Through the Fargodeep Mine
step
    #softcore
    #requires Fargodeep
    #completewith next
    .deathskip >> 在Goldshire死亡并重生
step << !Warlock
    #requires Fargodeep
    .goto Elwynn Forest,42.20,66.00
    .turnin 62 >> 交给Fargodeep矿井
    .turnin 40 >> 陷入困境
    .accept 35 >> 接受进一步关注
step << Warlock
    #requires Fargodeep
    .goto Elwynn Forest,42.1,65.9
    >>选择棍子，然后装备它
    .turnin 176 >> 通缉犯：“Hogger”
    .turnin 62 >> 交给Fargodeep矿井
    .turnin 40 >> 陷入困境
    .accept 35 >> 接受进一步关注
step << Warlock
    #label collector
    .goto Elwynn Forest,42.1,65.9
    .turnin 123 >> 交回收集器
    .isOnQuest 123
step
    .goto Elwynn Forest,43.30,65.70
    .turnin 60 >> 交上Kobold Candles
    .accept 61 >> 接受装运至暴风城
step
    .goto Elwynn Forest,42.20,67.20
    .turnin 47 >> 交金换尘
step
    .goto Elwynn Forest,73.90,72.30
    .turnin 35 >> 提交更多问题
step
    #era
    .goto Elwynn Forest,73.90,72.30
    .accept 37 >> 接受寻找丢失的守卫
    .accept 52 >> 接受保护边境
step
    #era
    #sticky
    #completewith Prowlers
    >>在执行其他任务时杀死潜行者
    .complete 52,1 --Kill Prowler (x8)
step
    #era
    #sticky
    #completewith Bears
    >>在执行其他任务时杀死熊。杀死你看到的任何人
    .complete 52,2 --Kill Young Forest Bear (x5)
step
    #era
    >>单击地面上的骨骼
    .goto Elwynn Forest,72.7,60.3
    .turnin 37 >> 上缴找到丢失的守卫
    .accept 45 >> 接受发现罗尔夫的命运
step
    #era
    .goto Elwynn Forest,81.38,66.11
    .accept 5545 >> 接受一堆麻烦
step
    #era
    #sticky
    #completewith next
    >>留心树下的一捆捆原木
    .collect 13872,8,5545,1 --Collect Bundle of Wood (x8)
step
    #era
    .goto Elwynn Forest,79.80,55.50
     >> 单击骨骼堆。小心点，因为你可能需要在小屋前处理2次拖拉
    .turnin 45 >> 交给《发现罗尔夫的命运》
    .accept 71 >> 接受向托马斯报告
step
    #era
    .goto Elwynn Forest,76.8,62.4,40,0
    .goto Elwynn Forest,83.7,59.4,40,0
    .goto Elwynn Forest,76.8,62.4,40,0
    .goto Elwynn Forest,83.7,59.4,40,0
    .goto Elwynn Forest,76.8,62.4,40,0
    .goto Elwynn Forest,83.7,59.4,40,0
    >>开始后退，完成包裹
    .collect 13872,8,5545,1 --Collect Bundle of Wood (x8)
step
    #era
    #label Prowlers
    .goto Elwynn Forest,81.4,66.1
    .turnin 5545 >> 交一堆麻烦
step
    #era
    #label Bears
    .goto Elwynn Forest,79.5,68.8
    .accept 83 >> 接受红色亚麻制品
step
    #era
    .goto Elwynn Forest,76.7,75.6,40,0
    .goto Elwynn Forest,79.7,83.7,40,0
    .goto Elwynn Forest,82.0,76.8,40,0
    .goto Elwynn Forest,76.7,75.6,40,0
    .goto Elwynn Forest,79.7,83.7,40,0
    .goto Elwynn Forest,82.0,76.8,40,0
    >>杀死最后一批暴徒保护边境
    .complete 52,1 --Kill Prowler (x8)
    .complete 52,2 --Kill Young Forest Bear (x5)
step
    #era
    .goto Elwynn Forest,74.0,72.2
    .turnin 52 >> 上缴保卫边疆
    .turnin 71 >> 向托马斯提交报告
    .accept 39 >> 接受并交付Thomas的报告
    .accept 109 >> 接受Gryan Stoutmantle的报告
step << Warlock
    >>杀死房子里的暴徒，让摩根保持恐惧（他凿伤并杀死宠物），核弹袭击苏雷纳。为她的喉咙抢劫她
    .goto Elwynn Forest,71.0,80.8
    .complete 1688,1 --Surena's Choker (1)
step
    .goto Elwynn Forest,69.3,79.0
    >>杀死公主，小心点，她有2个加法，她的冲锋很猛烈
    .complete 88,1
step
    #sticky
    #completewith next
    >>留意德菲亚斯（Defias）的《威斯特福尔契约》（lucky drop）
    .collect 1972,1,184 --Collect Westfall Deed (x1)
    .accept 184 >> 接受Furlbrow的契约
step
    #era
    .goto Elwynn Forest,70.5,77.6,60,0
    .goto Elwynn Forest,68.1,77.5,60,0
    .goto Elwynn Forest,68.2,81.4,60,0
    .goto Elwynn Forest,70.8,80.9,60,0
    .goto Elwynn Forest,70.5,77.6,60,0
    .goto Elwynn Forest,68.1,77.5,60,0
    .goto Elwynn Forest,68.2,81.4,60,0
    .goto Elwynn Forest,70.8,80.9,60,0
    .goto Elwynn Forest,70.5,77.6,60,0
    .goto Elwynn Forest,68.1,77.5,60,0
    .goto Elwynn Forest,68.2,81.4,60,0
    .goto Elwynn Forest,70.8,80.9,60,0
    .goto Elwynn Forest,69.3,79.0
    >>开始围着农场转，杀掉德菲亚斯，然后抢劫他们的头巾
    .complete 83,1 --Collect Red Linen Bandana (x6)
step
    #era
    #softcore
    #sticky
    #completewith next
    .goto Elwynn Forest,83.6,69.7,120 >>如果你的生命值低，在精神治疗者处死亡并重生，否则只需跑回并处理
step
    #era
    #label Deed
    .goto Elwynn Forest,79.45,68.78
    .turnin 83 >> 交出红色亚麻制品
step
    >>向东前往Redridge
    >>警卫在树桩周围巡逻了一会儿
    .goto Elwynn Forest,91.7,72.3,150,0
    .goto Redridge Mountains,17.4,69.6
    .accept 244 >> 接受侵扰侏儒
step
    >>小心路上的高级暴徒
    .goto Redridge Mountains,30.7,60.0
    .turnin 244 >> 交出侵扰侏儒
step
    .goto Redridge Mountains,30.6,59.4
    .fly Stormwind >> 飞到暴风城
step
    .goto Elwynn Forest,26.21,39.66
    >>选择火箭队作为奖励。这些有很好的伤害，可以用来劈开
    .turnin 61 >> 将货物交给Stormwind
step << Warlock
    >>回到术士训练师那里
    .goto StormwindClassic,25.2,78.5
    .trainer >> 训练你的职业咒语
    .turnin 1688 >> 交给Surena Caledon
    .accept 1689 >> 接受绑定
step << Warlock
    .goto StormwindClassic,25.2,80.7,18,0
    .goto StormwindClassic,23.2,79.5,18,0
    .goto StormwindClassic,26.3,79.5,18,0
    .goto StormwindClassic,25.5,78.1
    >>去地下室的底部。用血石窒息器召唤虚空行者并杀死它
    .complete 1689,1 --Kill Summoned Voidwalker (x1)
step << Warlock
     #softcore
    >>在返回术士训练师的途中进行生命分流
    .goto StormwindClassic,25.2,78.5
    .turnin 1689 >> 交回装订本
step << Warlock
     #hardcore
    .goto StormwindClassic,25.2,78.5
    .turnin 1689 >> 交回装订本
step << Warlock
    #softcore
    #completewith next
    .goto StormwindClassic,25.2,78.5
    .deathskip >> 使用生命水龙头并站在你旁边的篝火上，在精神治疗者处死亡并重生
step << Warrior
    .goto Elwynn Forest,41.09,65.77
    >>前往Goldshire
    .trainer >> 训练你的职业咒语
step
    #era
    .goto Elwynn Forest,42.10,65.92
    >>前往Goldshire
    .turnin 39 >> 提交提交托马斯的报告
step << Mage
    .goto Elwynn Forest,43.25,66.20
    >>前往Goldshire Inn
    .trainer >> 上楼去。训练你的职业咒语
step << Priest
    .goto Elwynn Forest,43.28,65.72
    >>前往Goldshire Inn
    .trainer >> 上楼去。训练你的职业咒语
step << Rogue
    .goto Elwynn Forest,43.87,65.94
    >>前往Goldshire Inn
    .trainer >> 上楼去。训练你的职业咒语
step
    .turnin 88 >> 公主必须死！
    .goto Elwynn Forest,34.66,84.48
step
    .turnin 86 >> 把馅饼交给比利
    .goto Elwynn Forest,34.40,84.2
    .isQuestComplete 86
step
    #sticky
    .abandon 86 >> 给比利的放弃派
step
    .goto Westfall,59.95,19.35
    .turnin 184>> 交出弗尔布罗的契约
    .isOnQuest 184
step
    .goto Westfall,59.95,19.35
    .accept 64 >> 接受被遗忘的传家宝
    .accept 36 >> 接受Westfall Stew
    .accept 151 >> 接受可怜的老布兰奇
step
    .goto Westfall,56.10,31.30
    .accept 9 >> 接受杀戮场
step
    .goto Westfall,56.40,30.50
    .turnin 36 >> 转入威斯特福尔炖菜
    .accept 38 >> 接受Westfall Stew
    .accept 22 >> 接受Goretusk肝派
step
    #softcore
    #sticky
    #completewith next
    .deathskip >> 在精神疗愈者处死亡并重生，或跑到哨兵山
step
    #era
    .goto Westfall,56.40,47.60
    .turnin 109 >> 向Gryan Stoutmantle提交报告
step
    .goto Westfall,56.40,47.60
    .accept 12 >> 接受人民民兵
step
    #era
    .goto Westfall,56.40,47.60
    .accept 102 >> 接受巡逻Westfall
step
    .goto Westfall,54.00,53.00
    .accept 153 >> 接受红色皮革头巾
step << Dwarf Paladin
    .goto Westfall,48.6,45.8
    >>确保你有10块亚麻布用于即将到来的圣骑士任务
    .collect 2589,10,1648,1
step
    .goto Westfall,56.6,52.6
    .fp Sentinel Hill >> 获取哨兵山飞行路线
    .fly Stormwind >> 飞到暴风城 << !Paladin
step << Paladin
    .goto StormwindClassic,60.5,12.3,40,0
    .goto StormwindClassic,60.5,12.3,0
    .zone Ironforge >> 坐电车回铁炉堡
step << !Paladin
    .hs >> 赫斯到莫丹湖
]])

RXPGuides.RegisterGuide([[
#era/som
#classic
<< Alliance !Hunter
#name 11-14 洛克莫丹 (矮人/侏儒)
#version 1
#group RestedXP 联盟 1-20
#defaultfor Gnome/Dwarf
#next 13-15 西部荒野

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
step << !Warlock
    #som << !Paladin
    .goto Ironforge,55.5,47.8
    .fly Loch >> 飞往莫丹湖
step
    .goto Loch Modan,34.76,48.62
    .vendor >> 如果你需要的话，买6个老虎袋。
step
    #completewith next
    .goto Loch Modan,35.54,48.40
    .vendor >> 如果需要，买一些食物 << Warrior/Rogue
    .vendor >> 如果需要，购买一些食物/水 << !Warrior !Rogue
step
    >>进入大楼，然后下楼。与Brock交谈
    .goto Loch Modan,37.2,46.9,15,0
    .goto Loch Modan,37.0,47.8
    .turnin 6392 >> 交回Brock
step
    #sticky
    #completewith next
    >>在Thelsamar鲜血香肠区杀死熊/野猪/蜘蛛
    .complete 418,1 --Collect Boar Intestines (x3)
    .complete 418,2 --Collect Bear Meat (x3)
    .complete 418,3 --Collect Spider Ichor (x3)
step
    #completewith next
    .goto Loch Modan,39.3,27.0,130 >>途中为野猪肠、熊肉和蜘蛛丝碾碎一些暴徒
step
    .goto Loch Modan,35.5,18.2,40,0
    .goto Loch Modan,35.75,22.42
    >>去科博尔德洞穴。收集你在里面找到的板条箱
    .complete 307,1 --Collect Miners' Gear (x4)
step << Paladin/Warrior
    #sticky
    #completewith Kobolds
    .goto Loch Modan,42.9,9.9
    .vendor >> 向销售商查询他可以销售的绿色2小时狼牙棒。如果你有足够的钱，买了它。否则，就在这里从科波德斯那里磨钱，直到你有足够的钱
step
    #label Kobolds
    >> 杀死科波德斯。抢走他们的耳朵
    .complete 416,1 --Collect Tunnel Rat Ear (x12)
step
    #completewith next
    .goto Loch Modan,24.1,18.2
    .vendor >>跑回沙坑。供应商和维修
step
    .goto Loch Modan,24.76,18.39
    .turnin 307 >> 交上脏爪子
    .turnin 353 >> 交给Stormpike的交货
step
    #sticky
    #label Meat9
    .goto Loch Modan,26.9,10.7,90,0
    .goto Loch Modan,30.9,10.6,90,0
    .goto Loch Modan,28.6,15.4,90,0
    .goto Loch Modan,30.5,26.6,90,0
    .goto Loch Modan,33.4,30.3,90,0
    .goto Loch Modan,39.4,33.3,90,0
    .goto Loch Modan,26.9,10.7,90,0
    .goto Loch Modan,30.9,10.6,90,0
    .goto Loch Modan,28.6,15.4,90,0
    .goto Loch Modan,30.5,26.6,90,0
    .goto Loch Modan,33.4,30.3,90,0
    .goto Loch Modan,39.4,33.3,90,0
    .goto Loch Modan,26.9,10.7
    >>杀死熊。抢他们的肉
    .complete 418,2 --Bear Meat (3)
step
    #sticky
    #label Ichor9
    .goto Loch Modan,31.9,16.4,90,0
    .goto Loch Modan,28.0,20.6,90,0
    .goto Loch Modan,33.8,40.5,90,0
    .goto Loch Modan,36.2,30.9,90,0
    .goto Loch Modan,39.0,32.1,90,0
    .goto Loch Modan,31.9,16.4,90,0
    .goto Loch Modan,28.0,20.6,90,0
    .goto Loch Modan,33.8,40.5,90,0
    .goto Loch Modan,36.2,30.9,90,0
    .goto Loch Modan,39.0,32.1,90,0
    .goto Loch Modan,31.9,16.4
    >>杀死蜘蛛。为伊科尔抢走他们
    .complete 418,3 --Spider Ichor (3)
step
    .goto Loch Modan,38.0,34.9,90,0
    .goto Loch Modan,37.1,39.8,90,0
    .goto Loch Modan,29.8,35.9,90,0
    .goto Loch Modan,27.7,25.3,90,0
    .goto Loch Modan,28.6,22.6,90,0
    .goto Loch Modan,38.0,34.9,90,0
    .goto Loch Modan,37.1,39.8,90,0
    .goto Loch Modan,29.8,35.9,90,0
    .goto Loch Modan,27.7,25.3,90,0
    .goto Loch Modan,28.6,22.6,90,0
    .goto Loch Modan,38.0,34.9
    >>杀死野猪。掠夺他们的肠道
    .complete 418,1 --Boar Intestines (3)
step
    #requires Meat9
step
    #sticky
    #label RatCatching
    #requires Ichor9
    .goto Loch Modan,32.6,49.9,80.0,0
    .goto Loch Modan,37.2,46.1,80.0,0
    .goto Loch Modan,36.7,41.6
    >>找到卡德雷尔。他沿着塞尔萨马尔公路巡逻
    .turnin 416 >> 上缴捕鼠
step
    .goto Loch Modan,34.82,49.28
    .turnin 418 >> 加入塞尔萨马尔鲜血香肠
step
    .goto Loch Modan,34.8,48.6
    .vendor >> 购买1块燧石和火药，以及2块简单木材。如果需要，购买更多6个插槽
    .collect 4470,2 --Simple Wood (2)
    .collect 4471,1 --Flint and Tinder (1)
step
    #requires RatCatching
    .goto Loch Modan,27.4,48.4
    >>杀死石刺怪。抢走他们的牙齿
    .complete 224,1 --Kill Stonesplinter Trogg (x10)
    .complete 224,2 --Kill Stonesplinter Scout (x10)
    .complete 267,1 --Collect Trogg Stone Tooth (x8)
step
    #era
    .goto Loch Modan,27.4,48.4
    .xp 13+9600>>研磨至9600+/11400xp
step
    #som
    .goto Loch Modan,27.4,48.4
    .xp 14-2300 >> 研磨直到距离14级2300xp（9100/11400）
step
    .goto Loch Modan,22.07,73.12
    .turnin 224 >> 为保卫国王的土地而投降
step
    .goto Loch Modan,23.23,73.67
    .turnin 267 >> 提交Trogg威胁
step << !Dwarf/!Paladin
    .goto Loch Modan,33.93,50.95
    .fly Ironforge>> 飞往铁炉堡
step << Dwarf Paladin
    #completewith next
    .goto Dun Morogh,87.1,51.1
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
    .hs >> 从火炉到暴风
step << Warrior
    .goto Ironforge,65.89,88.43
    .trainer >> 训练你的职业咒语
step << Warrior
    .goto Ironforge,62.0,89.6
    .train 176 >>火车抛锚
step << Mage
    .goto Ironforge,27.18,8.61
    .trainer >> 训练你的职业咒语
step << Mage/Priest/Warlock
    #softcore
    #sticky
    #label Wand1
    #completewith Wand2
     >>如果价格<33秒40美分，请尝试从AH购买一个更大的魔杖
    .goto Ironforge,25.74,75.43
    .collect 11288,1 --Greater Magic Wand (1)
step << Mage/Priest/Warlock
    #softcore
    #label Wand2
    #completewith Wand1
     >>如果你找不到价格合适的大魔杖，请从魔杖供应商处购买阴燃魔杖
    .goto Ironforge,24.09,16.63,14,0
    .goto Ironforge,23.13,15.96
    .collect 5208,1 --Smoldering Wand (1)
step << Mage/Priest/Warlock
    #hardcore
     >>进入大楼。购买阴燃魔杖
    .goto Ironforge,24.09,16.63,14,0
    .goto Ironforge,23.13,15.96
    .collect 5208,1 --Smoldering Wand (1)
step << Warlock
    #softcore
    #requires Wand2
    .goto Ironforge,51.1,8.7,15,0 >> 进入大楼
    .goto Ironforge,50.4,6.3
    .trainer >> 训练你的职业咒语
step << Warlock
    #hardcore
    .goto Ironforge,51.1,8.7,15,0 >> 进入大楼
    .goto Ironforge,50.4,6.3
    .trainer >> 训练你的职业咒语
step << Warlock
    .goto Ironforge,53.2,7.8,15,0 >> 进入大楼
    .goto Ironforge,53.0,6.4
    .vendor >> 购买消耗阴影r1，然后牺牲r1书籍（如果你有钱）
step << Rogue
    #sticky
    #label Salvation
    .isOnQuest 2218
    .goto Ironforge,51.50,15.34
    .turnin 2218 >> 转向救世之路
step << Rogue
    .goto Ironforge,51.50,15.34
    .trainer >> 上楼去。训练你的职业咒语
step << Priest
    .goto Ironforge,25.20,10.75
    .trainer >> 训练你的职业咒语
step << Paladin
   .goto StormwindClassic,42.66,33.75,30,0
    .goto StormwindClassic,38.68,32.85
    .trainer >> 训练你的职业咒语
step << Rogue
    #requires Salvation
    #completewith next
    +执行注销跳过，跳到鹰头狮的头上，注销，然后再重新登录
    .link https://www.youtube.com/watch?v=PWMJhodh6Bw >> 单击此处
step << !Paladin !Rogue
    #completewith next
    +执行注销跳过，跳到鹰头狮的头上，注销，然后再重新登录
    .link https://www.youtube.com/watch?v=PWMJhodh6Bw >> 单击此处
step << Rogue
    #requires Salvation
    .goto Ironforge,76.54,51.15,60,0
    .goto Ironforge,76.54,51.15,0
    .zone Stormwind City >> 乘电车去暴风城
    >>在等待/乘坐电车时进行急救训练，您需要80分的急救积分才能完成24级任务 << Rogue
step << !Paladin !Rogue
    .goto Ironforge,76.54,51.15,60,0
    .goto Ironforge,76.54,51.15,0
    .zone Stormwind City >> 乘电车去暴风城
]])

RXPGuides.RegisterGuide([[
#classic
#era/som
<< Alliance Hunter
#name 1-6 寒脊山谷 (猎人)
#version 1
#group RestedXP 联盟 1-20
#defaultfor Dwarf
#next 6-11 丹莫罗 (猎人)
step << !Gnome !Dwarf
    #sticky
    #completewith next
    .goto Dun Morogh,29.9,71.2
    +你选择了一个为侏儒和侏儒准备的向导。你应该选择与你开始时相同的起始区域
step
    .goto Dun Morogh,29.9,71.2
    >>与Sten Stoutarm交谈
    .accept 179 >>接受矮人装扮
step
    .goto Dun Morogh,29.0,74.4
    .complete 179,1 --Tough Wolf Meat (8)
step
    .goto Dun Morogh,29.9,71.3
    .turnin 179 >>交出矮人套装
    .accept 233 >>接受Coldridge Valley邮件递送
    .accept 3108 >>接受蚀刻符文
step
    .goto Dun Morogh,29.7,71.3
    >>与巴里尔冰锤对话
    .accept 170 >>接受新威胁
step
    #sticky
    #label Rockjaw
    >>杀死罗克贾夫特罗格斯（Rockjaw Troggs）
    .goto Dun Morogh,29.20,76.08,0
    .goto Dun Morogh,26.38,73.07,0
    .complete 170,1 --Kill Rockjaw Trogg (x6)
    .complete 170,2 --Kill Burly Rockjaw Trogg (x6)
step
    .goto Dun Morogh,22.6,71.4
    >>与塔林·基尼交谈
    .turnin 233 >>提交科尔德里奇谷邮件递送
    .accept 234 >>接受Coldridge Valley邮件递送
    .accept 183 >>接受野猪猎人
step
    .goto Dun Morogh,22.2,72.5,100,0
    .goto Dun Morogh,20.5,71.4,100,0
    .goto Dun Morogh,21.1,69.0,100,0
    .goto Dun Morogh,22.8,69.6,100,0
    .goto Dun Morogh,22.2,72.5,100,0
    .goto Dun Morogh,20.5,71.4,100,0
    .goto Dun Morogh,21.1,69.0
    >>杀死该地区的野猪
    .complete 183,1 --Kill Small Crag Boar (x12)
step
    .goto Dun Morogh,22.6,71.4
    .turnin 183 >>上缴猎野猪者
step
    .goto Dun Morogh,25.1,75.7
    >>与格雷林·白胡子交谈
    .turnin 234 >>提交科尔德里奇谷邮件递送
    .accept 182 >>接受巨魔洞穴
step
    #completewith next
    .goto Dun Morogh,22.7,79.3
    .goto Dun Morogh,20.9,75.7,0
    .goto Dun Morogh,27.3,79.7,0
    >>杀死霜鬃巨魔幼崽
    .complete 182,1 --Kill Frostmane Troll Whelp (x14)
step
    .xp 4 >> 研磨至4
step
    #requires Rockjaw
    .goto Dun Morogh,25.0,75.9
    .accept 3364 >>接受烫发晨报递送
step
    #completewith next
    .hs >> 炉底回到起始区域
step
    .goto Dun Morogh,29.7,71.3
    >>与巴里尔冰锤对话
    .turnin 170 >>提交新威胁
step
    #completewith next
    .goto Dun Morogh,30.09,71.58
    >>购买2堆弹药
    .collect 2516,400
step
    .goto Dun Morogh,29.1,67.5
    >>与索加斯·格里姆森交谈
    .turnin 3108 >>交上蚀刻的符文
        .train 1978 >> 火车蛇刺
step
    .goto Dun Morogh,28.8,66.5
    >>与Durnan Furcutter交谈
    .turnin 3364 >>交付烫伤晨报
    .accept 3365 >>接受带回马克杯
step
    .goto Dun Morogh,25.0,75.9
    .turnin 3365 >>把杯子拿回来
step
    .goto Dun Morogh,22.7,79.3
    .goto Dun Morogh,20.9,75.7,0
    .goto Dun Morogh,27.3,79.7,0
    >>杀死霜鬃巨魔幼崽
    .complete 182,1 --Kill Frostmane Troll Whelp (x14)
    .goto Dun Morogh,25.1,75.7
step
    .goto Dun Morogh,25.0,75.9
    .turnin 182 >>转入巨魔洞穴
    .accept 218 >>接受被盗日记
step
    .goto Dun Morogh,26.8,79.9,40,0
    .goto Dun Morogh,29.0,79.0,25,0
    .goto Dun Morogh,30.6,80.3
    >>进入巨魔洞穴。杀了格里克尼尔，然后把他抢走作为格雷林的日记
    .complete 218,1 --Collect Grelin Whitebeard's Journal (x1)
step
    #completewith next
    .goto Dun Morogh,28.4,79.7,35,0
    .goto Dun Morogh,26.8,79.6,25 >>跑出洞穴
step
    .goto Dun Morogh,25.1,75.7
    .turnin 218 >> 交出被盗日记
    .accept 282 >> 接受Senir的意见
step
    .goto Dun Morogh,33.5,71.8
    >>与登山者Thalos交谈
    .turnin 282 >>提交Senir的观察结果
    .accept 420 >>接受Senir的意见
step
    .goto Dun Morogh,33.8,72.2
    >>与手对话弹簧链轮
    .accept 2160 >>接受供应给Tannok
step
    .goto Dun Morogh,34.1,71.6,20,0
    .goto Dun Morogh,35.7,66.0,0
    .goto Dun Morogh,35.7,66.0,20 >>穿过隧道
]])

RXPGuides.RegisterGuide([[
#classic
#era/som
<< Alliance Hunter
#name 6-11 丹莫罗 (猎人)
#version 1
#group RestedXP 联盟 1-20
#defaultfor Dwarf Hunter
#next 11-13 洛克莫丹 (猎人)
step
    #completewith ribs1
    >> 杀死野猪以获得一些野猪肉/排骨供稍后使用
    .collect 769,4 --Collect Chunk of Boar Meat (x4)
    .collect 2886,6 --Collect Crag Boar Rib (x6)
step
    .goto Dun Morogh,46.7,53.8
    .turnin 420 >> 提交Senir的观察结果
step
    #label ribs1
    .goto Dun Morogh,46.8,52.4
    .accept 384 >>接受啤酒烤猪排
step
    .goto Dun Morogh,47.2,52.2
    .turnin 2160 >>向Tannok移交物资
step
    .goto Dun Morogh,46.0,51.7
    .accept 400 >>钢格栅的验收工具
step
    .goto Dun Morogh,49.5,48.3
    .accept 317 >>接受库存Jetsteam
step
    .goto Dun Morogh,49.6,48.5
    .accept 313 >>接受Grizzled Den
step
    .goto Dun Morogh,50.1,49.4
    .accept 5541 >>接受弹药以防隆隆枪击
step
    .goto Dun Morogh,50.4,49.1
    .turnin 400 >>钢格栅上交工具
step
    #sticky
    #completewith BoarRibs2
    >> 杀死野猪以获得野猪肋骨
    .collect 2886,6 --Collect Crag Boar Rib (x6)
step
    .goto Dun Morogh,52.0,50.1,100,0
    .goto Dun Morogh,51.5,53.9,100,0
    .goto Dun Morogh,50.1,53.9,100,0
    .goto Dun Morogh,49.9,50.9,100,0
    .goto Dun Morogh,48.0,49.5,100,0
    .goto Dun Morogh,48.2,46.9,100,0
    .goto Dun Morogh,43.5,52.5,100,0
    .goto Dun Morogh,52.0,50.1,100,0
    .goto Dun Morogh,51.5,53.9,100,0
    .goto Dun Morogh,50.1,53.9,100,0
    .goto Dun Morogh,49.9,50.9,100,0
    .goto Dun Morogh,48.0,49.5,100,0
    .goto Dun Morogh,48.2,46.9,100,0
    .goto Dun Morogh,43.5,52.5,100,0
    .goto Dun Morogh,52.0,50.1,100,0
    .goto Dun Morogh,51.5,53.9,100,0
    .goto Dun Morogh,50.1,53.9,100,0
    .goto Dun Morogh,49.9,50.9,100,0
    .goto Dun Morogh,48.0,49.5,100,0
    .goto Dun Morogh,48.2,46.9,100,0
    .goto Dun Morogh,43.5,52.5,100,0
    .goto Dun Morogh,52.0,50.1,0
    .goto Dun Morogh,51.5,53.9,0
    .goto Dun Morogh,50.1,53.9,0
    .goto Dun Morogh,49.9,50.9,0
    .goto Dun Morogh,48.0,49.5,0
    .goto Dun Morogh,48.2,46.9,0
    .goto Dun Morogh,43.5,52.5
    >>获取Jetsteam库存物品
    .complete 317,1 --Collect Chunk of Boar Meat (x4)
    .complete 317,2 --Collect Thick Bear Fur (x2)
step
    .goto Dun Morogh,49.4,48.4
    >>与飞行员Bellowfiz交谈
    .turnin 317 >>上缴库存Jetsteam
    .accept 318 >>接受Evershine
step
    .xp 6
step << Hunter
    .goto Dun Morogh,45.8,53.1
    .train 3044 >> 火车奥术射击
step
    >>抢劫板条箱
.goto Dun Morogh,44.1,56.9
    .complete 5541,1 --Rumbleshot's Ammo (1)
step
    .goto Dun Morogh,40.7,65.1
    >>与Hegnar Rumbleshot交谈
    .turnin 5541 >>交出弹药进行隆布尔枪击
step << Hunter
    .goto Dun Morogh,40.7,65.1
    >>购买4级枪升级，如果你没有钱，跳过这一步
    .collect 2509,1
step
    .goto Dun Morogh,42.25,53.68,40,0
    .goto Dun Morogh,41.07,49.04,50,0
    .goto Dun Morogh,42.25,53.68
    >> 到洞里去。杀死Wendigos。掠夺他们的鬃毛
    .complete 313,1 --Collect Wendigo Mane (x8)
step
    .xp 7
step
    >>在途中碾碎一些暴徒
    .goto Dun Morogh,35.2,56.4,60,0
    .goto Dun Morogh,36.0,52.0,60,0
    .goto Dun Morogh,34.6,51.7
    .accept 312 >> 接受Tundra MacGrann被盗的Stash
step << !Mage
    .goto Dun Morogh,38.5,54.0
    >>等到老冰胡子离开山洞，你就可以偷偷进去洗劫箱子，或者这样做
        .link https://www.youtube.com/watch?v=o55Y3LjgKoE >>单击此处
    .complete 312,1 --MacGrann's Dried Meats (1)
step
    .goto Dun Morogh,34.6,51.6
    .turnin 312 >>交出Tundra MacGrann被盗的Stash
step
    .goto Dun Morogh,30.4,45.8
    .vendor >> 供应商垃圾
step
    .goto Dun Morogh,30.2,45.8
    >>与Rejold Barleybrew交谈
    .turnin 318 >>交给Evershine
    .accept 319 >>接受对Evershine的支持
    .accept 315 >>接受完美的烈性酒
step
    #label BoarRibs2
    .goto Dun Morogh,30.2,45.4
    >>与Marleth Barleybrew交谈
    .accept 310 >>接受残酷的竞争对手
step
    #completewith next
    >> 杀死熊、野猪和豹子
    .complete 319,1 --Kill Ice Claw Bear (x6)
    .complete 319,2 --Kill Elder Crag Boar (x8)
    .complete 319,3 --Kill Snow Leopard (x8)
step << Hunter
    #era
    .goto Dun Morogh,46.7,53.8
    .complete 384,1
    .xp 8-1400 >>研磨，直到距离等级8 1400 xp。
step << Hunter
    #som
    .goto Dun Morogh,46.7,53.8
    .complete 384,1
    .xp 8-1950 >>研磨，直到距离8级1950 xp。
step
    #completewith next
    .deathskip >> 故意死亡并在哈拉诺斯重生
step << Hunter
    .goto Dun Morogh,49.6,48.5
    .turnin 313 >>在Grizzled Den转弯
step
    .goto Dun Morogh,47.4,52.5
    >>向客栈老板购买以下物品：
    .complete 384,2 --Rhapsody Malt (1)
    .collect 2686,1,311 --Thunder Ale
step
    .goto Dun Morogh,47.7,52.6
    >>下楼，把雷霆啤酒给贾文，然后点击无人看守的桶
    .turnin 310 >>在激烈的竞争中获胜
    .accept 311 >>接受返回Marleth
step
    .goto Dun Morogh,47.3,52.5
    .home >> 将您的炉石设置为Kharanos
step
    .goto Dun Morogh,46.9,52.4
    >>与Ragnar Thunderbrew交谈
    .turnin 384 >>翻啤酒扒猪排
step
    .goto Dun Morogh,46.7,53.9
    .accept 287 >>接受Frostmane保持
step << !Hunter
    .goto Dun Morogh,49.6,48.5
    .turnin 313 >>在Grizzled Den转弯
step << Hunter
    .goto Dun Morogh,45.8,53.0
    .train 5116>> 火车震荡射击
step
    #sticky
    #label favor
    >> 杀死熊、野猪和豹子
    .complete 319,1 --Kill Ice Claw Bear (x6)
    .complete 319,2 --Kill Elder Crag Boar (x8)
    .complete 319,3 --Kill Snow Leopard (x8)
step
    .goto Dun Morogh,63.1,49.8
    >>与Rudra Amberstill交谈
    .accept 314 >>接受保护羊群
step
    #sticky
    #completewith next
    .goto Dun Morogh,62.3,50.3,12,0
    .goto Dun Morogh,62.2,49.4,8 >>跑上山的这一部分
step
    .goto Dun Morogh,62.6,46.1
    >>杀死瓦加什。抢他的牙，这个任务很难，试着把他放在十字路口的警卫那里
    .complete 314,1 --Collect Fang of Vagash (x)
    .link https://www.youtube.com/watch?v=ZJX6sCkm5JY >> 单击此处了解如何独奏瓦加什
step
    .goto Dun Morogh,63.1,49.8
    .turnin 314 >> 转身保护羊群
    .isQuestComplete 314
step
    .goto Dun Morogh,83.8,39.2
    .accept 419 >> 接受迷失的飞行员
step
    .goto Dun Morogh,79.7,36.2
    .turnin 419 >> 交出失踪的飞行员
    .accept 417 >> 接受飞行员的复仇
step
    >>杀死芒格克劳。抢劫他的爪子，这个任务可能很难，把他放在任务给予者旁边的警卫那里
    .goto Dun Morogh,80.0,36.4
    .complete 417,1 --Collect Mangy Claw (x1)
step
    .goto Dun Morogh,83.9,39.2
    .turnin 417 >> 提交飞行员的复仇
step
    #hardcore
    .hs >> 赫斯到哈拉诺斯
step
    #softcore
    .goto Dun Morogh,47.11,55.01
    .deathskip >> 故意死亡并在哈拉诺斯重生
step
    #era
    .goto Dun Morogh,45.8,49.4
    .accept 412 >> 接受操作重组
step
    #completewith next
    .goto Dun Morogh,43.1,45.0,20,0
    .goto Dun Morogh,42.1,45.4,20 >> 跑上坡道到Shimmerweed
step
    .goto Dun Morogh,40.9,45.3,50,0
    .goto Dun Morogh,41.5,43.6,50,0
    .goto Dun Morogh,39.7,40.0,50,0
    .goto Dun Morogh,42.1,34.3,50,0
    .goto Dun Morogh,39.5,43.0
    .goto Dun Morogh,41.5,36.0
    >>清除这个地区的暴徒。如果你需要清理中间营地，请小心。如果你需要更多的暴徒，你可以把暴徒拉到小屋里，视线（LoS）在小屋后面。如果你运气不好，就跑到另一个地方去
    .complete 315,1 --Collect Shimmerweed (x6)
step
    #sticky
    #requires favor
    #label return
    .goto Dun Morogh,30.2,45.7
    >>与Rejold Barleybrew交谈
    .turnin 319 >>为Evershine提供支持
    .accept 320 >>接受返回Bellowfiz
step
    .goto Dun Morogh,30.2,45.5
    .turnin 311 >>交给马利思
    .turnin 315 >>交上完美的烈酒
    .accept 413 >>接受Shimmer Stout
step
    #requires return
    >>进入巨魔洞穴
    >>小心别死在这里
    .goto Dun Morogh,22.3,50.7,30,0
    .goto Dun Morogh,22.5,51.5,30,0
    .goto Dun Morogh,22.7,52.0
    .complete 287,1 --Fully explore Frostmane Hold (1)
    .complete 287,2 --Frostmane Headhunter (5)
step
    #era
    .goto Dun Morogh,27.2,43.0,80,0
    .goto Dun Morogh,24.8,39.3,80,0
    .goto Dun Morogh,25.6,43.4,80,0
    .goto Dun Morogh,24.3,44.0,80,0
    .goto Dun Morogh,25.4,45.4,80,0
    .goto Dun Morogh,25.00,43.50
    >>杀死麻风侏儒。抢夺他们的高跟鞋和齿轮
    .complete 412,1 --Collect Restabilization Cog (x8)
    .complete 412,2 --Collect Gyromechanic Gear (x8)
step
    #hardcore
    #completewith next
    .goto Dun Morogh,46.3,52.1,200 >> 开始跑回哈拉诺斯
step
    #era
    .xp 10-1470 >> 研磨，直到距离10级1450xp
step
    #som
    .xp 10-2050 >> 研磨直到距离10级2050xp
step
    #softcore
    .goto Dun Morogh,30.9,33.1,15 >>向北跑上山
step
    #softcore
    .goto Dun Morogh,32.4,29.1,15 >>继续到这里
step
    #softcore
    .goto Dun Morogh,33.0,27.2,25,0
    .goto Dun Morogh,33.0,25.2,25,0
    .goto Wetlands,11.6,43.4,60,0
    .goto Wetlands,11.6,43.4,0
    .deathskip >>继续向北奔跑，一旦General Chat变为湿地，跳下来死去，然后在Menethil Harbor重生
step
    #completewith next
    #softcore
    .goto Wetlands,12.7,46.7,80,0 >> 游到岸上
step
    #softcore
    .goto Wetlands,9.5,59.7
    .fp Menethil>> 获取Menethil Harbor航线
step
    #softcore
    #completewith next
    .hs >> 赫斯回到哈拉诺斯
step
    .goto Dun Morogh,46.7,53.7
    .turnin 287 >>交给Frostmane Hold
    .accept 291 >>接受报告
step
    #era
    .goto Dun Morogh,45.9,49.4
    .turnin 412 >>转入操作再栓塞
step
    .goto Dun Morogh,49.4,48.3
    .turnin 320 >>转身返回贝洛菲兹
step
    .goto Dun Morogh,45.8,53.0
    .accept 6064 >>接受驯服野兽
step
    .goto Dun Morogh,48.3,56.9
    >>点击你包里的驯养棒来驯养一头大野猪。尝试在最大射程（30码）进行
    .complete 6064,1 --Tame a Large Crag Boar (1)
step
    .goto Dun Morogh,45.8,53.0
    .turnin 6064 >>转身驯服野兽
    .accept 6084 >>接受驯服野兽
step
    .goto Dun Morogh,49.4,59.4
    >>点击你包里的驯雪豹棒。尝试在最大射程（30码）进行
    .complete 6084,1 --Tame a Snow Leopard (1)
step
    .goto Dun Morogh,45.8,53.0
    .turnin 6084 >>转身驯服野兽
    .accept 6085 >>接受驯服野兽
step
    .goto Dun Morogh,50.4,59.7
    >>点击你包里的驯冰爪熊棒。尝试在最大射程（30码）进行
    .complete 6085,1 --Tame an Ice Claw Bear (1)
step
    .goto Dun Morogh,45.8,53.0
    .turnin 6085 >>转身驯服野兽
    .accept 6086 >>接受训练野兽
step
    .goto Dun Morogh,68.7,56.0
    .accept 433 >> 接受公务员
step
    .goto Dun Morogh,69.1,56.3
    .accept 432 >> 接受那些被炸死的流浪汉！
step
    .goto Dun Morogh,70.7,56.4,50,0
    .goto Dun Morogh,70.62,52.39
    >>在山洞里杀死Troggs
    .complete 432,1 --Kill Rockjaw Skullthumper (x6)
    .complete 433,1 --Kill Rockjaw Bonesnapper (x10)
step
    .goto Dun Morogh,69.1,56.3
    .turnin 432 >> 把那些被炸死的暴徒交上来！
step
    .goto Dun Morogh,68.7,56.0
    .turnin 433 >> 上缴公务员
step << skip
    .goto Dun Morogh,68.4,54.5
    .train 2550 >> Ghilm的火车烹饪
step
    .goto Dun Morogh,86.3,48.8
    .turnin 413 >> 转入Shimmer Stout
    .accept 414 >> 接受斯托特到卡德雷尔
]])

RXPGuides.RegisterGuide([[
#classic
#era/som
<< Alliance Hunter
#name 11-13 洛克莫丹 (猎人)
#version 1
#group RestedXP 联盟 1-20
#defaultfor Dwarf
#next 11-16 黑海岸

step
    .goto Loch Modan,22.07,73.12
    >>前往莫丹湖
    .accept 224 >> 接受保护国王的土地
step
    .goto Loch Modan,23.23,73.67
    .accept 267 >> 接受Trogg威胁
step
    #sticky
    #label ratcatching
     >> 与巡逻塞尔萨马尔的警卫交谈
    .accept 416 >> 接受捕鼠
    .accept 1339 >> 接受登山者Stormpike的任务
step
    .goto Loch Modan,34.82,49.28
    .accept 418 >> 接受Thelsamar鲜血香肠
step
       .goto Loch Modan,35.5,48.4
    .home >> 将您的炉石设置为莫丹湖
step
    .goto Loch Modan,37.01,47.80
    .accept 6387 >> 接受荣誉学生
step
    #requires ratcatching
    .goto Loch Modan,33.93,50.95
    .turnin 6387 >> 移交荣誉学生
    .accept 6391 >> 接受铁炉堡之旅
step
     #completewith next
    .fly Ironforge>> 飞往铁炉堡
step
    .goto Ironforge,51.52,26.31
    .turnin 6391 >> 上交骑行前往铁炉堡
    .accept 6388 >> 接受Gryth Thurden
step
    .goto Dun Morogh,57.42,30.31
    .turnin 291 >> 提交报告
step <<  Hunter
    .goto Ironforge,70.86,85.83
    .turnin 6086 >> 上缴训练野兽
step
    .goto Ironforge,55.50,47.74
    .turnin 6388 >> 转入Gryth Thurden
    .accept 6392 >> 接受返回Brock
step
    #completewith next
    .fly Loch Modan>> 飞往莫丹湖
step
    .goto Loch Modan,37.0,47.8
    >>进入大楼，然后下楼。与Brock交谈
    .turnin 6392 >> 交回Brock
step
    .goto Loch Modan,35.8,43.5
    >>如果你还有13发子弹，请从Vrok Blunderblast购买9级枪升级
    .collect 2511,1
step
    #completewith sausage
     >> 杀死蜘蛛/熊/野猪
    .complete 418,1
    .complete 418,2
    .complete 418,3
step
    .goto Loch Modan,24.76,18.39
    .turnin 1339 >> 提交登山者Stormpike的任务
step
    .goto Loch Modan,24.76,18.39
    .accept 307 >> 接受肮脏的爪子
step
    .goto Loch Modan,24.76,18.39
    .accept 1338 >> 接受Stormpike的命令
step
    #sticky
    #label crates
    .goto Loch Modan,35.48,24.36
     >> 抢劫矿井内的板条箱
    .complete 307,1
step
    #sticky
    #requires crates
    #label q307
    .goto Loch Modan,24.76,18.39
    .turnin 307 >> 交上脏爪子
step
    .goto Loch Modan,24.3,30.3
    .goto Loch Modan,36.42,24.56
     >> 杀死kobolds
    .complete 416,1
step
    #requires q307
    #label sausage
    >>在返回塞尔萨马尔的路上完成野猪/熊/蜘蛛
    .turnin 418 >> 加入塞尔萨马尔鲜血香肠
    .goto Loch Modan,34.82,49.28
    .turnin 416 >> 上缴捕鼠
    .goto Loch Modan,34.26,47.70
step
    .goto Loch Modan,32.55,74.61
    >>杀死Troggs
    .complete 224,1
    .complete 224,2
    .complete 267,1
step
    .goto Loch Modan,22.07,73.12
    .turnin 224 >> 为保卫国王的土地而投降
step
    .goto Loch Modan,23.23,73.67
    .turnin 267 >> 提交Trogg威胁
step
    .goto Loch Modan,65.93,65.62
    .accept 298 >> 接受开挖进度报告
step
    .goto Loch Modan,83.46,65.45
    .accept 257 >> 接受猎人的夸耀
step
    .goto Loch Modan,77.30,61.45
    >>杀死狩猎小屋周围的鸟，这是一个困难的任务，但它给你一个很好的武器升级
    .complete 257,1
step
    .goto Loch Modan,83.46,65.45
    .turnin 257 >> 交出猎人的狂言
step
    #sticky
    .goto Loch Modan,82.60,63.40
     >> 购买制作营火的材料
    .collect 4470,1
    .collect 4471,1
step
    #hardcore
    .hs >> 希斯玛之炉
step
     #completewith next
    .deathskip >> 拉暴徒，故意死亡，在塞尔萨马尔重生
step
    .goto Loch Modan,37.23,47.38
    .turnin 298 >> 移交挖掘进度报告
    .accept 301 >> 接受向铁炉堡的报告
step
    .goto Loch Modan,33.93,50.95
    .fly Ironforge>> 飞往铁炉堡
step
    .goto Ironforge,60.0,36.8
    .train 2550 >> 确保在铁炉堡培训烹饪
step
    .goto Ironforge,74.64,11.74
    .turnin 301 >> 向铁炉堡提交报告
step
    .goto Ironforge,74.40,51.10,30,0
    .goto Ironforge,74.40,51.10,0
     >> 进入Deeprun Tram，在中间平台与侏儒交谈
    .accept 6661 >> 接受Deeprun老鼠围捕
step
    >>使用车站周围老鼠身上提供的长笛
    .complete 6661,1
step
    .turnin 6661 >> 交给Deeprun老鼠围捕
    .accept 6662 >> 接受我，兄弟，尼普西
step
     >> 骑到电车的另一侧，然后转弯
    .turnin 6662 >> 交给我，兄弟，尼普西
step
    #completewith next
    .goto StormwindClassic,60.5,12.3
    .zone Stormwind City >>下车进入暴风城
step
    #softcore
    .goto StormwindClassic,51.75,12.06
    .accept 353 >> 接受Stormpike的交付
step
    .goto StormwindClassic,58.08,16.52
    .turnin 1338 >> 提交Stormpike的命令
step
    .goto StormwindClassic,57.23,57.29
    .trainer >> 火车杆
step
    #softcore
    .hs >> 炉背
step
    #softcore
    .goto Loch Modan,24.76,18.39
    .turnin 353 >> 交给Stormpike的交货
step
     #completewith next
     .deathskip >> 死后在墓地重生
step
    #softcore
    #completewith next
    .goto Loch Modan,33.93,50.95
    .fly Wetlands>> 飞到湿地
step
    #hardcore
    .goto Dun Morogh,52.6,36.0
    .zone Dun Morogh >> 乘坐电车返回铁炉堡，前往邓莫罗
step
    #hardcore
    #label skip1
    #completewith fp
    .goto Dun Morogh,60.6,44.1,25,0
    .goto Dun Morogh,62.1,41.5,20,0
    .goto Dun Morogh,61.3,32.5,20,0
    .goto Dun Morogh,61.8,17.0,20,0
    .goto Dun Morogh,61.1,13.6,15,0
    .goto Dun Morogh,60.7,9.8,15,0
    .goto Wetlands,18.9,71.8,40,0
    .zone >>湿地山地跳跃吗
    .goto Dun Morogh,60.6,44.1,0
    .goto Dun Morogh,62.1,41.5,0
    .goto Dun Morogh,61.3,32.5,0
    .goto Dun Morogh,61.8,17.0,0
    .goto Dun Morogh,61.1,13.6,0
    .goto Dun Morogh,60.7,9.8,0
    .goto Wetlands,18.9,71.8,0
    .link https://www.twitch.tv/videos/729674651 >> 此跳过很难，请单击此处查看视频参考
step
    #hardcore
    #label skip2
    #requires skip1
    #completewith fp
    .goto Wetlands,17.9,67.9,30,0
    .goto Wetlands,16.0,67.2,20,0
    .goto Wetlands,17.0,64.1,20,0
    .goto Wetlands,14.9,63.7,20,0
    +前往米奈希尔港，横渡大海时，请确保避免侵犯鳄鱼。
    .goto Wetlands,17.9,67.9,0
    .goto Wetlands,16.0,67.2,0
    .goto Wetlands,17.0,64.1,0
    .goto Wetlands,14.9,63.7,0
    .link https://www.twitch.tv/videos/729674651 >> 此跳过很难，请单击此处查看视频参考
step
    #hardcore
    #label fp
    .goto Wetlands,9.5,59.7
    .fp Menethil Harbor >> 获取Menethil Harbor航线
step
    .goto Wetlands,4.6,57.2
    .zone Darkshore >>前往Menethil Harbor码头，乘船前往Darkshore
    >>在你等待的时候生篝火并平铺烹饪
    >>在等待船只的同时进行急救训练，您需要80分的急救积分才能完成24级任务 << Rogue
]])

RXPGuides.RegisterGuide([[
#classic
#som
#phase 3-6
<< Alliance !Hunter
#name 1-6 寒脊山谷
#version 1
#group RestedXP 联盟 1-20
#defaultfor Dwarf/Gnome
#next 6-12 丹莫罗
step << !Gnome !Dwarf
    #completewith next
    .goto Dun Morogh,29.9,71.2
    +你选择了一个为侏儒和侏儒准备的向导。你应该选择与你开始时相同的起始区域
step << Mage
    #completewith next
    +请注意，您已经选择了单目标法师指南。单目标比AoE Mage安全得多，并且随着新的100%任务经验变化速度更快
step
    >>删除您的炉石 << !Warlock
    .goto Dun Morogh,29.9,71.2
    .accept 179 >> 接受矮人装扮
step << Warrior/Warlock
    #sticky
    #completewith next
    .goto Dun Morogh,28.6,72.2,20,0
    +杀死狼群10美分以上的小贩垃圾，然后进入大楼
step << Warrior/Warlock
    .goto Dun Morogh,28.8,69.2,30 >>进入大楼
step << Warrior
    .goto Dun Morogh,28.7,67.7
    .vendor >> 供应商垃圾
step << Warrior
    .goto Dun Morogh,28.8,67.2
    .trainer >>火车战斗呐喊
step << Warlock
    .goto Dun Morogh,28.8,66.2
    .vendor >> 到后面，楼上，然后和恶魔训练师谈谈。供应商垃圾
step << Warlock
    .goto Dun Morogh,28.6,66.1
    .trainer >>火车献祭
    .accept 1599 >> 接受开始
step
    >>杀死狼。抢他们的肉
    .goto Dun Morogh,28.7,74.8
    .complete 179,1 --Collect Tough Wolf Meat (x8)
step
    .xp 2 >> 研磨至2
step << Warlock
    #softcore
    #sticky
    #completewith next
    .goto Dun Morogh,26.8,79.8,40,0
    .goto Dun Morogh,30.1,82.4,30 >> 在途中杀死一些狼，然后看这个
    .link https://www.youtube.com/watch?v=iUvGsRbIVp8 >> 单击此处
step << Warlock
    >>杀死洞穴内的霜鬃新手。掠夺他们的羽毛魅力
    .goto Dun Morogh,29.0,82.6,50,0
    .goto Dun Morogh,29.0,81.2,60,0
    .goto Dun Morogh,30.1,82.4
    .complete 1599,1 --Collect Feather Charm (x3)
step << Warlock
    #softcore
    .goto Dun Morogh,29.5,69.8,100 >> 在精神治疗师处死亡并重生
step << Warlock
    #hardcore
    .hs >> Hearth返回Coldridge Valley
step << Warlock
    >>回到术士训练师那里
    .goto Dun Morogh,28.6,66.1
    .turnin 1599 >> 开始时交上来
step << Priest/Mage/Warlock
    .goto Dun Morogh,30.0,71.5
    >>召唤你的小鬼并在途中拒绝恶魔皮肤 << Warlock
    .vendor >>供应商垃圾，修理。购买15杯水。如果你没有足够的钱，就多磨几只狼
    .collect 159,15 --Collect Refreshing Spring Water (x15)
step << Paladin/Warrior
    .goto Dun Morogh,30.0,71.5
    .vendor >>供应商垃圾
step
    .goto Dun Morogh,29.9,71.2
    .turnin 179 >> 交出矮人套装
    .accept 233 >> 接受Coldridge Valley邮件递送
    .accept 3106 >> 接受简单符文 << Dwarf Warrior
    .accept 3107 >> 接受神圣符文 << Paladin
    .accept 3109 >> 接受加密符文 << Dwarf Rogue
    .accept 3110 >> 接受神圣符文 << Priest
    .accept 3112 >> 接受简单备忘录 << Gnome Warrior
    .accept 3113 >> 接受加密备忘录 << Gnome Rogue
    .accept 3114 >> 接受字形备忘录 << Mage
    .accept 3115 >> 接受被篡改的备忘录 << Gnome Warlock
step
    .goto Dun Morogh,22.6,71.4
    .turnin 233 >> 提交科尔德里奇谷邮件递送
    .accept 183 >> 接受野猪猎人
    .accept 234 >> 接受Coldridge Valley邮件递送
step
    .goto Dun Morogh,22.2,72.5,100,0
    .goto Dun Morogh,20.5,71.4,100,0
    .goto Dun Morogh,21.1,69.0,100,0
    .goto Dun Morogh,22.8,69.6,100,0
    .goto Dun Morogh,22.2,72.5,100,0
    .goto Dun Morogh,20.5,71.4,100,0
    .goto Dun Morogh,21.1,69.0
    >>杀死该地区的野猪
    .complete 183,1 --Kill Small Crag Boar (x12)
step
    .goto Dun Morogh,22.6,71.4
    .turnin 183 >> 上缴猎野猪者
step << Paladin/Mage/Warlock
    .xp 3+860>>研磨至860+/1400xp
    .goto Dun Morogh,23.0,75.0,100,0
    .goto Dun Morogh,24.2,72.5,100,0
    .goto Dun Morogh,27.7,76.3,100,0
    .goto Dun Morogh,23.0,75.0,100,0
    .goto Dun Morogh,24.2,72.5
step
    #label Rockjaw
    .goto Dun Morogh,25.1,75.7
    .turnin 234 >> 提交科尔德里奇谷邮件递送
    .accept 182 >> 接受巨魔洞穴
step << Paladin/Mage/Warlock
    .goto Dun Morogh,25.0,76.0
    .accept 3364 >> 接受烫发晨报递送
    >> 一旦接受，将启动5分钟计时器。放松并遵循指南
step << Paladin/Mage/Warlock
    #sticky
    #completewith Scalding1
    >>如果你速度太慢，无法完成定时任务，请再去捡一次
    .goto Dun Morogh,25.0,76.0,0
    .accept 3364 >> 接受烫发晨报递送
    .goto Dun Morogh,28.8,66.4
    .turnin 3364 >> 交付烫伤晨报
step << Paladin/Mage/Warlock
    #label Scalding1
    .goto Dun Morogh,28.8,66.4
    .turnin 3364 >> 交付烫伤晨报
    .accept 3365 >> 接受带回马克杯
    .vendor >> 供应商垃圾
step << Paladin/Mage/Warlock
    .goto Dun Morogh,28.55,67.64
    .accept 3361 >>接受难民的困境
step << Dwarf Paladin
    .goto Dun Morogh,28.8,68.3
    .turnin 3107 >> 交上神圣符文
    .trainer >> 训练你的职业咒语
step << Gnome Mage
    .goto Dun Morogh,28.7,66.4
    .turnin 3114 >> 递交字形备忘录
    .trainer >> 训练你的职业咒语
step << Warlock
    .goto Dun Morogh,28.6,66.1
    .trainer >> 上楼去。培养你的腐败
    .turnin 3115 >> 交回被篡改的备忘录
step << Mage/Warlock
    .goto Dun Morogh,30.0,71.5
    .vendor >>供应商，购买10水
    .collect 159,10 --Collect Refreshing Spring Water (x10)
step << Paladin/Mage/Warlock
    #completewith FelixB
    .goto Dun Morogh,20.9,75.7,0
    >>杀死霜鬃巨魔幼崽
    .complete 182,1 --Kill Frostmane Troll Whelp (x14)
step << Paladin/Mage/Warlock
    >>抢劫地上的水桶
    .goto Dun Morogh,26.33,79.28
    .complete 3361,3 --Felix's Bucket of Bolts (1)
step << Paladin/Mage/Warlock
    >>在地上抢劫箱子
    .goto Dun Morogh,22.78,80.00
    .complete 3361,2 --Felix's Chest (1)
step << Paladin/Mage/Warlock
    #label FelixB
    >>抢劫地上的箱子
    .goto Dun Morogh,20.88,76.07
    .complete 3361,1 --Felix's Box (1)
step << Paladin/Mage/Warlock
    .goto Dun Morogh,26.3,79.2,90,0
    .goto Dun Morogh,22.7,79.3,90,0
    .goto Dun Morogh,20.9,75.7,90,0
    .goto Dun Morogh,22.7,79.3,90,0
    .goto Dun Morogh,20.9,75.7
    >>杀死霜鬃巨魔幼崽
    .complete 182,1 --Kill Frostmane Troll Whelp (x14)
    .goto Dun Morogh,25.1,75.7
step << !Paladin !Mage !Warlock
    .goto Dun Morogh,22.7,79.3,90,0
    .goto Dun Morogh,20.9,75.7,90,0
    .goto Dun Morogh,22.7,79.3,90,0
    .goto Dun Morogh,20.9,75.7,90,0
    .goto Dun Morogh,22.7,79.3,90,0
    .goto Dun Morogh,20.9,75.7,90,0
    .goto Dun Morogh,22.7,79.3
    >>杀死霜鬃巨魔幼崽
    .complete 182,1 --Kill Frostmane Troll Whelp (x14)
    .goto Dun Morogh,25.1,75.7
step << !Paladin !Mage !Warlock
    .goto Dun Morogh,25.0,76.0
    .abandon 3364 >> 放弃烫发晨报-你还不需要它
step << !Paladin !Mage !Warlock
    .xp 4 >> 研磨至4
step << !Paladin !Mage !Warlock
    .goto Dun Morogh,25.1,75.7
    .turnin 182 >> 转入巨魔洞穴
    .accept 218 >> 接受被盗日记
step << Paladin/Mage/Warlock
    .goto Dun Morogh,25.1,75.7
    .turnin 182 >> 转入巨魔洞穴
    .accept 218 >> 接受被盗日记
step << !Paladin !Mage !Warlock
    #softcore
    .goto Dun Morogh,25.0,76.0
    .accept 3364 >> 接受烫发晨报递送
    >>你现在有500万美元要拿到《华尔街日报》，然后交上《晨报》。如果你的任务失败了，死后再捡起来
step << Paladin/Mage/Warlock
    .goto Dun Morogh,25.0,76.0
    .turnin 3365 >> 把杯子拿回来
step
    #softcore
    .goto Dun Morogh,26.8,79.9,30,0
    .goto Dun Morogh,29.0,79.0,15,0
    .goto Dun Morogh,30.6,80.3
    >>进入巨魔洞穴。杀了格里克尼尔，然后把他抢走作为格雷林的日记
    >>杀死格里克尼尔后，准备在精神治疗者处死亡和重生
    .complete 218,1 --Collect Grelin Whitebeard's Journal (x1)
step
    #hardcore
    .goto Dun Morogh,26.8,79.9,30,0
    .goto Dun Morogh,29.0,79.0,15,0
    .goto Dun Morogh,30.6,80.3
    >>进入巨魔洞穴。杀了格里克尼尔，然后把他抢走作为格雷林的日记
    .complete 218,1 --Collect Grelin Whitebeard's Journal (x1)
step << !Paladin !Mage !Warlock
    #hardcore
    .goto Dun Morogh,25.0,76.0
    .accept 3364 >> 接受烫发晨报递送
step << !Paladin !Mage !Warlock
    #hardcore
    .goto Dun Morogh,25.1,75.8
    .turnin 218 >> 交出被盗日记
    .accept 282 >> 接受Senir的意见
step
    #softcore
    .goto Dun Morogh,29.5,69.8,100 >> 在精神治疗者处死亡并重生
step << !Paladin !Mage !Warlock
    #sticky
    #completewith Scalding2
    >>如果你速度太慢，无法完成定时任务，请再去捡一次
    .goto Dun Morogh,25.0,76.0,0
    .accept 3364 >> 接受烫发晨报递送
    .goto Dun Morogh,28.8,66.4
    .turnin 3364 >> 交付烫伤晨报
step << !Paladin !Mage !Warlock
    #label Scalding2
    .goto Dun Morogh,28.8,66.4
    .turnin 3364 >> 交付烫伤晨报
    .accept 3365 >> 接受带回马克杯
    .vendor >> 供应商垃圾
step << Paladin/Mage/Warlock
    .goto Dun Morogh,28.55,67.64
    >>进入大楼
    .turnin 3361 >>移交难民的困境
step << Rogue
    .goto Dun Morogh,28.4,67.5
    .turnin 3113 >> 提交加密备忘录 << Gnome Rogue
    .turnin 3109 >> 提交加密符文 << Dwarf Rogue
step << Dwarf Priest
    .goto Dun Morogh,28.6,66.4
    .turnin 3110 >> 交出神圣符文
    .trainer >> 训练你的职业咒语
step << Warrior
    .goto Dun Morogh,28.8,67.2
    .turnin 3106 >> 交出简单符文 << Dwarf Warrior
    .turnin 3112 >> 提交简单备忘录 << Gnome Warrior
    .trainer >> 训练你的职业咒语
step << Priest
    .money <0.0025
    .goto Dun Morogh,30.0,71.5
    .vendor >> 最多购买10瓶水
step
    .goto Dun Morogh,25.1,75.8
    .turnin 218 >> 交出被盗日记
    .accept 282 >> 接受Senir的意见
step << !Paladin !Mage !Warlock
    .goto Dun Morogh,25.0,76.0
    .turnin 3365 >> 把杯子拿回来
step
    .goto Dun Morogh,33.5,71.8
    .turnin 282 >> 提交Senir的观察结果
    .accept 420 >> 接受Senir的意见
step
    .goto Dun Morogh,33.9,72.2
    .accept 2160 >> 接受供应给Tannok
step
    .goto Dun Morogh,34.1,71.6,20,0
    .goto Dun Morogh,35.7,66.0,0
    .goto Dun Morogh,35.7,66.0,20 >>穿过隧道
]])

RXPGuides.RegisterGuide([[
#classic
#som
#phase 3-6
<< Alliance !Hunter
#name 6-12 丹莫罗
#version 1
#group RestedXP 联盟 1-20
#defaultfor Dwarf/Gnome
#next 11-12 艾尔文森林 术士 << Warlock
#next 11-14 洛克莫丹 << !Warlock
step << Paladin/Warrior/Rogue
    #sticky
    #completewith BearFur
    >> 杀死野猪以获得4块野猪肉
    .collect 769,4 --Collect Chunk of Boar Meat (x4)
step << !Paladin !Warrior !Rogue
    #sticky
    #completewith BoarMeat44
    >> 杀死野猪，获得4块野猪肉供日后食用
    .collect 769,4 --Collect Chunk of Boar Meat (x4)
step
    #sticky
    #completewith Ribs
    >> 杀死野猪以获得6根野猪肋骨供日后使用
    .collect 2886,6 --Collect Crag Boar Rib (x6)
step << Priest
    >>将野猪磨碎，东北至哈拉诺斯
    .goto Dun Morogh,36.4,62.9,45,0
    .goto Dun Morogh,37.7,60.5,45,0
    .goto Dun Morogh,43.9,55.7
    .xp 5+2145>>研磨至2145/+2800xp
step << !Priest
    >>将野猪磨碎，东北至哈拉诺斯
    .goto Dun Morogh,36.4,62.9,45,0
    .goto Dun Morogh,37.7,60.5,45,0
    .goto Dun Morogh,43.9,55.7
    .xp 5+2415>>研磨至2415/+2800xp
step
    #completewith next
    #softcore
    .deathskip >> 在精神疗愈者处死亡并重生，或者跑向哈拉诺斯。确保你的分区不是Coldridge Pass
step
    #softcore
    .goto Dun Morogh,46.7,53.8
    .turnin 420 >> 提交Senir的观察结果
    .vendor >>供应商垃圾
step
    #hardcore
    >>在前往哈拉诺斯的途中磨碎野猪
    .goto Dun Morogh,46.7,53.8
    .turnin 420 >> 提交Senir的观察结果
    .vendor >>供应商垃圾
step << Warlock
    .goto Dun Morogh,47.3,53.7
    .trainer >> 从Gimrizz训练你的职业咒语
    .vendor >> 如果你在接受Dannie的训练后有钱，就买血盟书（否则以后再买）
step << !Priest
    .goto Dun Morogh,48.3,57.0
    .xp 6 >> 研磨至6
step
    .goto Dun Morogh,46.8,52.4
    .accept 384 >> 接受啤酒烤猪排
step
    .goto Dun Morogh,47.2,52.2
    .turnin 2160 >> 向Tannok移交物资
step << Rogue
    .goto Dun Morogh,47.2,52.4
    .vendor >> 购买克雷格投掷的3级。装备它
step << Rogue
    .goto Dun Morogh,47.6,52.6
    .trainer >> 训练你的职业咒语
step << Mage
    .goto Dun Morogh,47.5,52.1
    .trainer >> 训练你的职业咒语
step << Paladin
    .goto Dun Morogh,47.6,52.1
    .trainer >> 训练你的职业咒语
step << Priest
    .goto Dun Morogh,47.3,52.2
    .accept 5625 >> 接受光明之衣
step << Priest
    >>使用较低治疗等级2，然后使用咒语：登山者杜尔夫的坚韧
    .goto Dun Morogh,45.8,54.6
     .complete 5625,1 --Heal and fortify Mountaineer Dolf
step << Priest
    .goto Dun Morogh,47.3,52.2
    .turnin 5625 >> 交出光明的衣裳
    .trainer >> 训练你的职业咒语
step << Priest
    .xp 6 >> 研磨至6
step << Priest/Mage/Warlock
    .goto Dun Morogh,47.4,52.5
    .home >> 将您的炉石设置为Thunderbrew酒厂
    .vendor >> 尽可能多地购买5级饮料
step << !Mage !Priest !Warlock
    .goto Dun Morogh,47.4,52.5
    .home >> 将您的炉石设置为Thunderbrew酒厂
    .vendor >> 供应商垃圾
step << Warrior
    .goto Dun Morogh,47.4,52.6
    .trainer >> 训练你的职业咒语
step << Paladin/Warrior
    .goto Dun Morogh,45.8,51.8,20 >> 进入大楼
step << Gnome Warrior
    .goto Dun Morogh,45.3,52.2
    >>修理你的武器。如果你有足够的钱（5s36c），从Grawn买一辆Gladius。否则，请跳过此步骤（稍后再回来）
    .collect 2488,1 --Collect Gladius (1)
step << Dwarf Warrior
    .goto Dun Morogh,45.3,52.2
     >>修理你的武器。如果你有足够的钱（4s84c），从Grawn买一把大斧子。否则，请跳过此步骤（稍后再回来）
    .collect 2491,1 --Collect Large Axe (1)
step << Rogue
    .goto Dun Morogh,45.3,52.2
    >>修理你的武器。如果你有足够的钱（4s1c），从Grawn买一个细高跟鞋。否则，请跳过此步骤（稍后再回来）
    .collect 2494,1 --Collect Stiletto (1)
step << Paladin
    .goto Dun Morogh,45.3,52.2
    >>修理你的武器。如果你有足够的钱（7s1c），从Grawn买一把木制锤子。否则，请跳过此步骤（稍后再回来）
    .collect 2493,1 --Collect Wooden Mallet (1)
step << Warrior/Rogue
    .goto Dun Morogh,45.3,51.9
    .trainer >> 火车铁匠。这将允许你为你的武器制造+2伤害磨石，这些磨石非常坚固。
    >> 如果你想从事自己的职业，跳过这一步
step << Paladin
    .goto Dun Morogh,45.3,51.9
    .trainer >> 火车铁匠。这将允许你为你的武器制造+2点非常强大的伤害重石。
    >> 如果你想从事自己的职业，跳过这一步
step
    .goto Dun Morogh,46.0,51.7
    .accept 400 >> 钢格栅的验收工具
step
    .goto Dun Morogh,49.4,48.4
    >>不要在途中杀死熊
    .accept 317 >> 接受库存Jetsteam
step
    .goto Dun Morogh,49.6,48.6
    .accept 313 >> 接受Grizzled Den
step
    .goto Dun Morogh,50.4,49.1
    .turnin 400 >> 钢格栅上交工具
step
    #label BoarMeat44
    .goto Dun Morogh,50.1,49.4
    .accept 5541 >> 接受弹药以防隆隆枪击
step << Warrior/Paladin/Rogue
    .money <0.0091
    .goto Dun Morogh,50.1,49.4
    .collect 2901,1 >> 如果你训练了锻造，就买一把采矿镐
step << Warrior/Paladin/Rogue
    .goto Dun Morogh,50.01,50.31
    .trainer >>进屋去。训练采矿，铸造寻找矿物
step
    #sticky
    #completewith BearFur
    >>获取熊皮毛，以便在您的任务中为喷气式飞机提供库存
    .complete 317,2 --Collect Thick Bear Fur (x2)
step << !Paladin !Warrior !Rogue
    .goto Dun Morogh,52.0,50.1,100,0
    .goto Dun Morogh,51.5,53.9,100,0
    .goto Dun Morogh,50.1,53.9,100,0
    .goto Dun Morogh,49.9,50.9,100,0
    .goto Dun Morogh,48.0,49.5,100,0
    .goto Dun Morogh,48.2,46.9,100,0
    .goto Dun Morogh,43.5,52.5,100,0
    .goto Dun Morogh,52.0,50.1,100,0
    .goto Dun Morogh,51.5,53.9,100,0
    .goto Dun Morogh,50.1,53.9,100,0
    .goto Dun Morogh,49.9,50.9,100,0
    .goto Dun Morogh,48.0,49.5,100,0
    .goto Dun Morogh,48.2,46.9,100,0
    .goto Dun Morogh,43.5,52.5,100,0
    .goto Dun Morogh,52.0,50.1,100,0
    .goto Dun Morogh,51.5,53.9,100,0
    .goto Dun Morogh,50.1,53.9,100,0
    .goto Dun Morogh,49.9,50.9,100,0
    .goto Dun Morogh,48.0,49.5,100,0
    .goto Dun Morogh,48.2,46.9,100,0
    .goto Dun Morogh,43.5,52.5,100,0
    .goto Dun Morogh,52.0,50.1,0
    .goto Dun Morogh,51.5,53.9,0
    .goto Dun Morogh,50.1,53.9,0
    .goto Dun Morogh,49.9,50.9,0
    .goto Dun Morogh,48.0,49.5,0
    .goto Dun Morogh,48.2,46.9,0
    .goto Dun Morogh,43.5,52.5
    >>获取Jetsteam库存物品
    .complete 317,1 --Collect Chunk of Boar Meat (x4)
    .complete 317,2 --Collect Thick Bear Fur (x2)
step << !Paladin !Warrior !Rogue
    .goto Dun Morogh,49.4,48.4
    .turnin 317 >> 上缴库存Jetsteam
    .accept 318 >> 接受Evershine
step << Warrior
    .goto Dun Morogh,46.9,52.1,20,0
    .goto Dun Morogh,47.4,52.5
    .vendor >> 尽可能多地购买5级食物
step << Priest/Mage/Warlock
    .goto Dun Morogh,46.9,52.1,20,0
    .goto Dun Morogh,47.4,52.5
    .vendor >> 尽可能多地购买5级饮料
step
    .goto Dun Morogh,42.25,53.68,40,0
    .goto Dun Morogh,41.07,49.04,50,0
    .goto Dun Morogh,42.25,53.68
    >> 到洞里去。杀死Wendigos。掠夺他们的鬃毛 << !Warrior !Rogue !Paladin
    >> 杀死Wendigos。掠夺他们的鬃毛。留意纹理，为武器打磨石头而获得粗糙的石头 << Warrior/Rogue
    >> 杀死Wendigos。掠夺他们的鬃毛。留心纹理，为武器的配重块获取粗糙的石头 << Paladin
    .complete 313,1 --Collect Wendigo Mane (x8)
step
    >>抢劫板条箱
    .goto Dun Morogh,44.1,56.9
    .complete 5541,1 --Collect Rumbleshot's Ammo (x1)
step
    #label BearFur
    .goto Dun Morogh,40.6,62.6,50,0
    .goto Dun Morogh,40.7,65.1
    .turnin 5541 >> 交出弹药进行隆布尔枪击
    .vendor >> 供应商和维修
step << !Paladin !Warrior !Rogue
    .xp 7 >> 研磨至7
step << Paladin/Warrior/Rogue
    .goto Dun Morogh,51.4,50.4
    >>杀死熊和野猪。抢他们的皮毛和肉
    .complete 317,2 --Collect Thick Bear Fur (x2)
    .complete 317,1 --Collect Chunk of Boar Meat (x4)
step << Warrior/Paladin/Rogue
    .goto Dun Morogh,49.4,48.4
    .turnin 317 >> 上缴库存Jetsteam
    .accept 318 >> 接受Evershine
step << Warrior/Paladin/Rogue
    .goto Dun Morogh,49.6,48.6
    .turnin 313 >> 在Grizzled Den转弯
step << Warrior/Paladin/Rogue
    .goto Dun Morogh,50.1,49.4
    .collect 2901,1 >> 购买采矿镐
step << Warrior/Rogue/Paladin
    .xp 8 >> 将附近的暴徒碾碎至8
step << Rogue
    .goto Dun Morogh,47.6,52.6
    .trainer >> 训练你的职业咒语
step << Paladin
    .goto Dun Morogh,47.60,52.07
    .trainer >> 训练你的职业咒语
step << Warrior
    .goto Dun Morogh,47.4,52.6
    .trainer >> 训练你的职业咒语
step << Rogue
    .goto Dun Morogh,45.3,52.2
    >>修理你的武器。如果你有足够的钱（4s1c），从Grawn买一个细高跟鞋。否则，请跳过此步骤（稍后再回来）
    .collect 2494,1 --Collect Stiletto (1)
step << Gnome Warrior
    .goto Dun Morogh,45.3,52.2
    >>修理你的武器。如果你有足够的钱（5s36c），从Grawn买一辆Gladius。否则，请跳过此步骤（稍后再回来）
    .collect 2488,1 --Collect Gladius (1)
step << Dwarf Warrior
    .goto Dun Morogh,45.3,52.2
     >>修理你的武器。如果你有足够的钱（4s84c），从Grawn买一把大斧子。否则，请跳过此步骤（稍后再回来）
    .collect 2491,1 --Collect Large Axe (1)
step << Paladin
    .goto Dun Morogh,45.3,52.2
    >>修理你的武器。如果你有足够的钱（7s1c），从Grawn买一把木制锤子。否则，请跳过此步骤（稍后再回来）
    .collect 2493,1 --Collect Wooden Mallet (1)
step << Warrior/Rogue
    .goto Dun Morogh,47.4,52.5
    .vendor >> 购买最多20种5级食物
step << Paladin
    .goto Dun Morogh,47.4,52.5
    .vendor >> 购买最多10种5级食物
step << Paladin/Warrior/Rogue
    .goto Dun Morogh,43.0,47.4,100,0
    .goto Dun Morogh,39.6,48.9,100,0
    .goto Dun Morogh,34.6,51.7
    .accept 312 >> 接受Tundra MacGrann被盗的Stash
step << !Paladin !Warrior !Rogue
    .goto Dun Morogh,35.2,56.4,100,0
    .goto Dun Morogh,36.0,52.0,100,0
    .goto Dun Morogh,34.6,51.7
    .accept 312 >> 接受Tundra MacGrann被盗的Stash
step << !Mage !Priest
    #completewith next
    .goto Dun Morogh,30.5,46.0
    .vendor >> 供应商垃圾
step << Priest/Mage/Warlock
    #completewith next
    .goto Dun Morogh,30.5,46.0
    .vendor >> 小贩购买最多20杯5级饮料
step
    .goto Dun Morogh,30.2,45.8
    .turnin 318 >> 交给Evershine
    .accept 319 >> 接受对Evershine的支持
    .accept 315 >> 接受完美的烈性酒
step
    .goto Dun Morogh,30.2,45.5
    .accept 310 >> 接受残酷的竞争对手
step
    #label Ribs
    .goto Dun Morogh,31.5,38.9,100,0
    .goto Dun Morogh,28.3,39.9,100,0
    .goto Dun Morogh,28.7,43.7,100,0
    .goto Dun Morogh,25.8,47.2,100,0
    .goto Dun Morogh,25.8,47.2,100,0
    .goto Dun Morogh,30.0,51.8,100,0
    .goto Dun Morogh,31.5,38.9,100,0
    .goto Dun Morogh,28.3,39.9,100,0
    .goto Dun Morogh,28.7,43.7,100,0
    .goto Dun Morogh,25.8,47.2,100,0
    .goto Dun Morogh,25.8,47.2,100,0
    .goto Dun Morogh,30.0,51.8,100,0
    .goto Dun Morogh,28.7,43.7
    >> 杀死熊、野猪和豹子
    .complete 319,1 --Kill Ice Claw Bear (x6)
    .complete 319,2 --Kill Elder Crag Boar (x8)
    .complete 319,3 --Kill Snow Leopard (x8)
step
    >>完成野猪肋
    .complete 384,1 --Collect Crag Boar Rib (x6)
step
    .goto Dun Morogh,30.2,45.7
    .turnin 319 >> 为Evershine提供支持
    .accept 320 >> 接受返回Bellowfiz
step
    #softcore
    .goto Dun Morogh,30.3,37.5,60 >> 跑到这里
step
    #softcore
    .goto Dun Morogh,30.9,33.1,15 >>向北跑上山
step
    #softcore
    .goto Dun Morogh,32.4,29.1,15 >>继续到这里
step
    #softcore
    .goto Dun Morogh,33.0,27.2,15,0
    .goto Dun Morogh,33.0,25.2,15,0
    .goto Wetlands,11.6,43.4,60,0
    .goto Wetlands,11.6,43.4
    .deathskip >>继续向北跑，一旦General Chat变为湿地，就跳下去死去，然后在Menethil港重生
step
    #softcore
    #completewith next
    .goto Wetlands,12.7,46.7,30 >> 游到岸上
step
    #softcore
    .goto Wetlands,9.5,59.7
    .fp Wetlands>> 获取Menethil Harbor航线
step
    .hs >> 赫斯到哈拉诺斯
step
    .goto Dun Morogh,47.4,52.5
    >> 从Belm购买狂想曲麦芽和雷霆啤酒
    .complete 384,2 --Collect Rhapsody Malt (x1)
    .collect 2686,1,311 --Collect Thunder Ale (x1)
step
    .goto Dun Morogh,47.6,52.4,15,0
    >>进客栈老板后面的房间。下楼去，然后和贾文谈谈，给他雷霆啤酒
    >>等待木桶鼠标移到“无人看守”位置，然后handin
    .turnin 310 >> 在激烈的竞争中获胜
    .accept 311 >> 接受返回Marleth
step
    .goto Dun Morogh,46.8,52.4
    .turnin 384 >> 翻啤酒扒猪排
     >>当你下一个供应商时出售配方
step << Warlock
    .goto Dun Morogh,47.3,53.7
    >>与Gimrizz交谈
    .trainer >> 训练你的职业咒语
    .vendor >> 如果您在培训后有钱，请购买Firebolt书籍（否则请稍后购买）
step << Mage
    .goto Dun Morogh,47.5,52.1
    .trainer >> 训练你的职业咒语
step << Priest
    .goto Dun Morogh,47.3,52.2
    .trainer >> 训练你的职业咒语
step << Warrior/Rogue/Paladin
    .money <0.01
    .goto Dun Morogh,47.2,52.6
    .trainer >> 训练绷带急救
step << Rogue
    .goto Dun Morogh,45.3,52.2
    >>修理你的武器。如果你有足够的钱（4s1c），从Grawn买一个细高跟鞋。否则，请跳过此步骤（稍后再回来）
    .collect 2494,1 --Collect Stiletto (1)
step << Paladin
    .goto Dun Morogh,45.3,52.2
    >>修理你的武器。如果你有足够的钱（7s1c），从Grawn买一把木制锤子。否则，请跳过此步骤（稍后再回来）
    .collect 2493,1 --Collect Wooden Mallet (1)
step << Gnome Warrior
    .goto Dun Morogh,45.3,52.2
    >>修理你的武器。如果你有足够的钱（5s36c），从Grawn买一辆Gladius。否则，请跳过此步骤（稍后再回来）
    .collect 2488,1 --Collect Gladius (1)
step << Dwarf Warrior
    .goto Dun Morogh,45.3,52.2
     >>修理你的武器。如果你有足够的钱（4s84c），从Grawn买一把大斧子。否则，请跳过此步骤（稍后再回来）
    .collect 2491,1 --Collect Large Axe (1)
step << Warrior/Rogue
    .goto Dun Morogh,47.4,52.5
    .vendor >> 从客栈老板那里购买最多30种五级食物
step << Paladin
    .goto Dun Morogh,47.4,52.5
    .vendor >> 从客栈老板那里购买最多15种五级食物
step << Priest/Mage/Warlock
    .goto Dun Morogh,47.4,52.5
    .vendor >> 从客栈老板那里购买至多30杯5级饮料
step
    .goto Dun Morogh,46.7,53.8
    .accept 287 >> 接受Frostmane保持
step
    .goto Dun Morogh,49.6,48.6
    .turnin 313 >> 在Grizzled Den转弯
step
    .goto Dun Morogh,49.4,48.4
    >>选择野营刀。保存以备以后使用 << Rogue
    .turnin 320 >> 转身返回贝洛菲兹
step << Warrior
    >>建筑物内部
    .goto Dun Morogh,45.8,49.4
    .accept 412 >> 接受操作重组
step
    #completewith next
    .goto Dun Morogh,43.1,45.0,20,0
    .goto Dun Morogh,42.1,45.4,20 >> 跑上坡道到Shimmerweed
step
    .goto Dun Morogh,40.9,45.3,50,0
    .goto Dun Morogh,41.5,43.6,50,0
    .goto Dun Morogh,39.7,40.0,50,0
    .goto Dun Morogh,42.1,34.3,50,0
    .goto Dun Morogh,39.5,43.0
    .goto Dun Morogh,41.5,36.0
    >>清除这个地区的暴徒。如果你需要清理中间营地，请小心。如果你需要更多的暴徒，你可以把暴徒拉到小屋里，视线（LoS）在小屋后面。如果你运气不好，就跑到另一个地方去
    >>在地上抢劫篮子
    >>如果你在这里抢劫亚麻布，就要做砝码 << Paladin
    .complete 315,1 --Collect Shimmerweed (x6)
step << !Mage !Warlock
    .goto Dun Morogh,38.5,54.0
    >>等到老冰胡子离开山洞，你就可以偷偷进去洗劫箱子，或者这样做
        .link https://www.youtube.com/watch?v=o55Y3LjgKoE >>点击此处查看视频参考
    .complete 312,1 --MacGrann's Dried Meats (1)
step << Mage/Warlock
    >> 变形老冰胡子，然后洗劫肉 << Mage
    >> 害怕老冰胡子，然后洗劫肉 << Warlock
    .goto Dun Morogh,38.5,53.9
    .complete 312,1 --Collect MacGrann's Dried Meats (x1)
step
    .goto Dun Morogh,34.6,51.7
    .turnin 312 >> 交出Tundra MacGrann被盗的Stash
step << Mage/Priest/Warlock
    #completewith next
    .goto Dun Morogh,30.4,45.8
    .vendor >> 最多再购买10杯5级饮料
step << Warrior/Paladin/Rogue
    #completewith next
    .goto Dun Morogh,30.4,45.8
    .vendor >> 供应商垃圾
step
    .goto Dun Morogh,30.2,45.7
    .turnin 315 >> 交上完美的烈酒
    .accept 413 >> 接受Shimmer Stout
step
    .goto Dun Morogh,30.2,45.5
    .turnin 311 >> 交给马利思
step << Warrior
    .goto Dun Morogh,27.2,43.0,80,0
    .goto Dun Morogh,24.8,39.3,80,0
    .goto Dun Morogh,25.6,43.4,80,0
    .goto Dun Morogh,24.3,44.0,80,0
    .goto Dun Morogh,25.4,45.4,80,0
    .goto Dun Morogh,25.00,43.50
    >>杀死麻风侏儒。抢劫他们的装备和鞋帽
    .complete 412,2 --Collect Gyromechanic Gear (x8)
    .complete 412,1 --Collect Restabilization Cog (x8)
step << Paladin
    #completewith EndDM
    >>将10块亚麻布放在包里，以备以后圣骑士任务之用
    .collect 2589,10 --Linen Cloth (10)
step
    .goto Dun Morogh,24.5,50.8,40,0
    .goto Dun Morogh,22.1,50.3,40,0
    .goto Dun Morogh,21.3,52.9,40,0
    .goto Dun Morogh,24.5,50.8,0
    .goto Dun Morogh,22.1,50.3,0
    .goto Dun Morogh,21.3,52.9,0
    >>杀死洞穴内的猎头
    .complete 287,1 --Kill Frostmane Headhunter (x5)
step
    #softcore
    .goto Dun Morogh,23.4,51.5,15 >>返回洞穴
step
    #softcore
    >>跳进下面的角落
    .goto Dun Morogh,23.0,52.2
    .complete 287,2 --Fully explore Frostmane Hold
step
    #softcore
    #completewith next
    .deathskip >> 在哈拉诺死后重生
step
    #hardcore
    >>小心地磨进洞里的这个角落
    .goto Dun Morogh,23.0,52.2
    .complete 287,2 --Fully explore Frostmane Hold
step
    #hardcore
   .goto Dun Morogh,46.7,53.8,150 >> 如果没问题的话，就把炉子烧了，否则就要碾回哈拉诺斯
step
    .goto Dun Morogh,46.7,53.8
    .turnin 287 >> 交给Frostmane Hold
    .accept 291 >> 接受报告
step
    #completewith EndDM
    >>在前往其他任务的途中杀死野猪，获得8块野猪肉，以便稍后执行任务。现在不要太专注于这个
    .collect 769,8 --Collect Chunk of Boar Meat (x8)
step << Rogue
    .goto Dun Morogh,47.6,52.6
    .accept 2218 >> 接受救世之路
    .trainer >> 训练你的职业咒语
    >>装备早期的野营刀
step << Warlock
    .goto Dun Morogh,47.3,53.7
    >>与Gimrizz交谈
    .trainer >> 训练你的职业咒语
step << Mage
    .goto Dun Morogh,47.5,52.1
    .trainer >> 训练你的职业咒语
step << Priest
    .goto Dun Morogh,47.3,52.2
    .trainer >> 训练你的职业咒语
step << Paladin
    .goto Dun Morogh,47.60,52.07
    .trainer >> 训练你的职业咒语
step << Warrior
    .goto Dun Morogh,47.4,52.6
    .trainer >> 训练你的职业咒语
step << !Paladin !Priest
    .goto Dun Morogh,47.2,52.6
    .train 3273 >> 培训急救
step << Warrior
    >>建筑物内部
    .goto Dun Morogh,45.8,49.4
    .turnin 412 >> 转入操作再栓塞
step << Warrior
    #sticky
    #completewith next
    .money >0.1000
    +开始研磨，直到你有10个可售物品，然后跑进铁炉堡
step << Warrior
    .goto Dun Morogh,53.5,34.9,30 >> 跑进铁炉堡
step << Warrior
    >>进入大楼
    .goto Ironforge,61.2,89.5
    .trainer >>列车2h梅斯
step << Warrior
    #sticky
    #completewith next
    .goto Dun Morogh,53.5,34.9,100 >>冲出铁炉堡
step
    .goto Dun Morogh,60.1,52.6,50,0
    .goto Dun Morogh,63.1,49.8
    .accept 314 >> 接受保护羊群
step
    #completewith next
    .goto Dun Morogh,62.3,50.3,14,0
    .goto Dun Morogh,62.2,49.4,10 >>跑上山的这一部分
step
    >>杀死瓦加什。抢他的牙
    >>把他引到牧场南边的守卫那里。确保你对他造成51%+的伤害
    >>小心，因为这个任务很难完成
    .goto Dun Morogh,62.6,46.1
    .complete 314,1 --Collect Fang of Vagash (1)
    .link https://www.youtube.com/watch?v=ZJX6sCkm5JY >> 单击此处了解如何独奏瓦加什
step
    .goto Dun Morogh,63.1,49.8
    .turnin 314 >> 转身保护羊群
step
    >>途中磨碎一点
    .goto Dun Morogh,68.6,54.7
    .vendor >>供应商垃圾箱。如果需要，买一些食物 << Warrior/Rogue
    .vendor >>供应商垃圾箱。如果需要，购买一些食物/水 << !Warrior !Rogue
step
    .goto Dun Morogh,68.4,54.5
    .train 2550 >> Ghilm的火车烹饪
step
    .goto Dun Morogh,68.7,56.0
    .accept 433 >> 接受公务员
step
    #completewith next
    .goto Dun Morogh,68.9,55.9
    .vendor >> 供应商垃圾，修理
step
    .goto Dun Morogh,69.1,56.3
    .accept 432 >> 接受那些被炸死的流浪汉！
step
    .goto Dun Morogh,70.7,56.4,40,0
    .goto Dun Morogh,70.62,52.39,25,0
    .goto Dun Morogh,70.7,56.4
    >>杀死洞穴内的Troggs
    .complete 432,1 --Kill Rockjaw Skullthumper (x6)
    .complete 433,1 --Kill Rockjaw Bonesnapper (x10)
step
    .goto Dun Morogh,69.1,56.3
    .turnin 432 >> 把那些被炸死的暴徒交上来！
step
    #completewith next
    .goto Dun Morogh,68.9,55.9
    .vendor >> 供应商垃圾，修理
step
    .goto Dun Morogh,68.7,56.0
    .turnin 433 >> 上缴公务员
step
    .goto Dun Morogh,83.8,39.2
    .accept 419 >> 接受迷失的飞行员
step
    .goto Dun Morogh,79.7,36.2
    .turnin 419 >> 交出失踪的飞行员
    .accept 417 >> 接受飞行员的复仇
step
    >>杀死芒格克劳。抢走他的爪子
    .goto Dun Morogh,78.97,37.14
    .complete 417,1 --Collect Mangy Claw (x1)
step
    #label EndDM
    .goto Dun Morogh,83.9,39.2
    .turnin 417 >> 提交飞行员的复仇
step
    .goto Dun Morogh,79.6,50.7,50,0
    .goto Dun Morogh,82.3,53.5,25,0
    .goto Dun Morogh,86.3,48.8
    .turnin 413 >> 转入Shimmer Stout
    .accept 414 >> 接受斯托特到卡德雷尔
]])

RXPGuides.RegisterGuide([[
#classic
#som
#phase 3-6
<< Alliance Warlock
#name 11-12 艾尔文森林 术士
#version 1
#group RestedXP 联盟 1-20
#defaultfor Gnome/Dwarf
#next 12-14 洛克莫丹
step
    >>穿过隧道进入Loch
    .goto Loch Modan,22.1,73.1
    .accept 224 >> 接受保护国王的土地
step
    .goto Loch Modan,23.2,73.7
    >>从后面进入沙坑
    .accept 267 >> 接受Trogg威胁
step
    .goto Loch Modan,32.6,49.9,80.0,0
    .goto Loch Modan,37.2,46.1,80.0,0
    .goto Loch Modan,36.7,41.6
    >>找到卡德雷尔。他沿着塞尔萨马尔公路巡逻
    .turnin 414 >> 把斯托特交给卡德雷尔
    .accept 416 >> 接受捕鼠
    .accept 1339 >> 接受登山者Stormpike的任务
step
    >>进入大楼，然后下楼。与Brock交谈
    .goto Loch Modan,37.2,46.9,15,0
    .goto Loch Modan,37.0,47.8
    .accept 6387 >> 接受荣誉学生
step
    .goto Loch Modan,34.82,49.28
    .accept 418 >> 接受Thelsamar鲜血香肠
step
    .goto Loch Modan,34.8,48.6
    .vendor >>购买6槽包
step
    .goto Loch Modan,35.5,48.4
    .home >> 把你的炉石放在塞尔萨马尔
step
    #sticky
    #completewith Thelsamar1
    >>在肠道、肉类和蜱虫区杀死野猪、熊和蜘蛛
    .complete 418,1 --Collect Boar Intestines (x3)
    .complete 418,2 --Collect Bear Meat (x3)
    .complete 418,3 --Collect Spider Ichor (x3)
step
    >>跑到北方的掩体
    .goto Loch Modan,24.8,18.4
    .accept 307 >> 接受肮脏的爪子
    .turnin 1339 >> 提交登山者Stormpike的任务
    .accept 1338 >> 接受Stormpike的命令
step
    #label Thelsamar1
    .deathskip >> 在塞尔萨马尔死亡并重生
step
    .goto Loch Modan,33.9,51.0
    .turnin 6387 >> 移交荣誉学生
    .accept 6391 >> 接受铁炉堡之旅
step
    .goto Loch Modan,33.9,51.0
    .fly Ironforge >> 飞往铁炉堡
step
    .goto Ironforge,51.5,26.3
    .turnin 6391 >> 上交骑行前往铁炉堡
    .accept 6388 >> 接受Gryth Thurden
step
    .goto Ironforge,39.5,57.5
    .turnin 291 >> 提交报告
step
    >>不要在任何地方飞行
    .goto Ironforge,55.5,47.8
    .turnin 6388 >> 转入Gryth Thurden
    .accept 6392 >> 接受返回Brock
step
    #completewith next
    +执行注销跳过，跳到鹰头狮的头上，注销，然后再重新登录
    .link https://www.youtube.com/watch?v=PWMJhodh6Bw >> 单击此处
step
    .goto Ironforge,74.40,51.10,30,0
    .goto Ironforge,74.40,51.10,0
     >> 进入Deeprun Tram，在中间平台与侏儒交谈
    .accept 6661 >> 接受Deeprun老鼠围捕
step
    >>用你的长笛对付四处散落的老鼠
    .complete 6661,1 --Rats Captured (x5)
step
    .turnin 6661 >> 交给Deeprun老鼠围捕
    .accept 6662 >> 接受我，兄弟，尼普西
step
     .isOnQuest 6662
    >> 乘电车去暴风城，到了电车的另一边后再转弯
    .turnin 6662 >> 交给我，兄弟，尼普西
    >>在等待/乘坐电车时进行急救训练，您需要80分的急救积分才能完成24级任务 << Rogue
step
    #completewith next
    .goto StormwindClassic,60.5,12.3
    .zone Stormwind City >>下车进入暴风城
step
    .goto StormwindClassic,51.6,12.2
    .accept 353 >> 接受Stormpike的交付
step
    .goto StormwindClassic,58.1,16.5
    .turnin 1338 >> 提交Stormpike的命令
step
    #sticky
    #completewith next
    .goto StormwindClassic,29.2,74.0,20,0
    .goto StormwindClassic,27.2,78.1,15 >> 走进屠宰羔羊，下楼去
step
    .goto StormwindClassic,26.12,77.20
    .trainer >> 训练你的职业咒语
step
    .goto StormwindClassic,25.2,78.5
    .accept 1688 >> 接受Surena Caledon
step
    .goto StormwindClassic,57.1,57.7
    .trainer >>火车站。如果你有闲钱，训练1小时剑
step
     #softcore
    #completewith next
     +在前往飞行大师的途中开始生活攻关
step
    .goto StormwindClassic,66.20,62.40
    .fp Stormwind City >> 获得暴风城飞行路线
step
     #softcore
    #completewith next
     >> 跳下飞行管理员旁边的壁架（而不是水），自杀，跳之前确保使用活水龙头
    .deathskip >>Goldshire的Spirit rez
step
    .goto Elwynn Forest,42.10,65.90
     >>前往Goldshire
    .accept 62 >> 接受Fargodeep矿井
step
    >>在你靠近的左边
    .goto Elwynn Forest,43.3,65.7
    .accept 60 >> 接受Kobold Candles
step
    .goto Elwynn Forest,42.10,67.30
    .accept 40 >> 接受鱼的危险
    .accept 47 >> 接受金尘交换
step
    >>点击周围任何通缉海报
    .goto Elwynn Forest,24.6,74.7
    .accept 176 >> 接受通缉：“Hogger”
step
    #sticky
    #completewith collector
    >>请留意取金时间表（幸运滴），或Gruff Swiftbite的100%滴（罕见）。额外210xp
    .collect 1307,1,123 --Collect Gold Pickup Schedule (x1)
    .accept 123 >> 接受催收员
step
    #label Hogger
    .unitscan Hogger
    .goto Elwynn Forest,27.0,86.7,100,0
    .goto Elwynn Forest,26.1,89.9,100,0
    .goto Elwynn Forest,25.2,92.7,100,0
    .goto Elwynn Forest,27.0,93.9,100,0
    .goto Elwynn Forest,27.0,86.7,100,0
    .goto Elwynn Forest,26.1,89.9,100,0
    .goto Elwynn Forest,25.2,92.7,100,0
    .goto Elwynn Forest,27.0,93.9,100,0
    .goto Elwynn Forest,27.0,86.7,100,0
    .goto Elwynn Forest,26.1,89.9,100,0
    .goto Elwynn Forest,25.2,92.7,100,0
    .goto Elwynn Forest,27.0,93.9,100,0
    .goto Elwynn Forest,25.9,93.9
    >>Hogger可以出现在该地区的多个地点。让他恐惧重重，和/或在24,80时以<60%的马力将他风筝到塔上。抢走他的爪子
    >>小心，因为这可能很困难
    .complete 176,1 --Huge Gnoll Claw (1)
step
    .accept 88 >> 接受公主必死无疑！
    .goto Elwynn Forest,34.60,84.50
    .accept 85 >> 接受丢失的项链
    .goto Elwynn Forest,34.40,84.2
step
    .goto Elwynn Forest,43.0,85.8
    .turnin 85 >> 交回丢失的项链
    .accept 86 >> 为比利接受派
step
    #sticky
    #label Fargodeep
    >>从该地区的Kobolds人手中抢夺蜡烛和灰尘
    .complete 60,1 --Kobold Candle (8)
    .complete 47,1 --Gold Dust (10)
step
    .goto Elwynn Forest,40.5,82.3
    >>进入矿井
    .complete 62,1 --Scout Through the Fargodeep Mine
step
    #softcore
    #requires Fargodeep
    #completewith next
    .deathskip >> 在Goldshire死亡并重生
step
    #requires Fargodeep
    .goto Elwynn Forest,42.1,65.9
    >>选择棍子，然后装备它
    .turnin 176 >> 通缉犯：“Hogger”
    .turnin 62 >> 交给Fargodeep矿井
    .turnin 40 >> 陷入困境
    .accept 35 >> 接受进一步关注
    .turnin 123 >> 交回收集器
    .isOnQuest 123
step
    #requires Fargodeep
    .goto Elwynn Forest,42.1,65.9
    >>选择棍子，然后装备它
    .turnin 176 >> 通缉犯：“Hogger”
    .turnin 62 >> 交给Fargodeep矿井
    .turnin 40 >> 陷入困境
    .accept 35 >> 接受进一步关注
step
    .goto Elwynn Forest,43.30,65.70
    .turnin 60 >> 交上Kobold Candles
    .accept 61 >> 接受装运至暴风城
step
    .goto Elwynn Forest,42.20,67.20
    .turnin 47 >> 交金换尘
step
    .goto Elwynn Forest,73.90,72.30
    .turnin 35 >> 提交更多问题
step
    >>杀死房子里的暴徒，让摩根保持恐惧（他凿伤并杀死宠物），核弹袭击苏雷纳。为她的喉咙抢劫她
    .goto Elwynn Forest,71.0,80.8
    .complete 1688,1 --Surena's Choker (1)
step
    .goto Elwynn Forest,69.3,79.0
    >>杀死公主，小心点，她有2个加法，她的冲锋很猛烈
    .complete 88,1
step << skip
    #completewith next
    >>留意德菲亚斯（Defias）的《威斯特福尔契约》（lucky drop）
    .collect 1972,1,184 --Collect Westfall Deed (x1)
    .accept 184 >> 接受Furlbrow的契约
step
    >>向东前往Redridge
    >>警卫在树桩周围巡逻了一会儿
    .goto Elwynn Forest,91.7,72.3,150,0
    .goto Redridge Mountains,17.4,69.6
    .accept 244 >> 接受侵扰侏儒
step
    >>小心路上的高级暴徒
    .goto Redridge Mountains,30.7,60.0
    .turnin 244 >> 交出侵扰侏儒
step
    .goto Redridge Mountains,30.6,59.4
    .fly Stormwind >> 飞到暴风城
step
    .goto Elwynn Forest,26.21,39.66
    >>选择火箭队作为奖励。这些有很好的伤害，可以用来劈开
    .turnin 61 >> 将货物交给Stormwind
step << Warlock
    >>回到术士训练师那里
    .goto StormwindClassic,25.2,78.5
    .trainer >> 训练你的职业咒语
    .turnin 1688 >> 交给Surena Caledon
    .accept 1689 >> 接受绑定
step << Warlock
    .goto StormwindClassic,25.2,80.7,18,0
    .goto StormwindClassic,23.2,79.5,18,0
    .goto StormwindClassic,26.3,79.5,18,0
    .goto StormwindClassic,25.5,78.1
    >>去地下室的底部。用血石窒息器召唤虚空行者并杀死它
    .complete 1689,1 --Kill Summoned Voidwalker (x1)
step << Warlock
     #softcore
    >>在返回术士训练师的途中进行生命分流
    .goto StormwindClassic,25.2,78.5
    .turnin 1689 >> 交回装订本
step << Warlock
     #hardcore
    .goto StormwindClassic,25.2,78.5
    .turnin 1689 >> 交回装订本
step << Warlock
    #softcore
    #completewith next
    .goto StormwindClassic,25.2,78.5
    .deathskip >> 使用生命水龙头并站在你旁边的篝火上，在精神治疗者处死亡并重生
step
    .turnin 88 >> 公主必须死！
    .goto Elwynn Forest,34.66,84.48
step
    .turnin 86 >> 把馅饼交给比利
    .goto Elwynn Forest,34.40,84.2
    .isQuestComplete 86
step
    .hs >> 希斯玛之炉
]])

RXPGuides.RegisterGuide([[
#classic
#som
#phase 3-6
<< Alliance !Hunter
#name 12-14 洛克莫丹
#version 1
#group RestedXP 联盟 1-20
#defaultfor Dwarf/Gnome
#next 14-19 黑海岸

step << Paladin
    #completewith TroggT
    >>将10块亚麻布放在包里，以备以后圣骑士任务之用
    .collect 2589,10 --Linen Cloth (10)
step
    #completewith EndLoch
    >>将野猪磨成8块野猪肉，以便稍后进行任务
    .collect 769,8 --Collect Chunk of Boar Meat (x8)
step
    >>穿过隧道进入Loch
    .goto Loch Modan,22.1,73.1
    .accept 224 >> 接受保护国王的土地
step
    #label TroggT
    .goto Loch Modan,23.2,73.7
    >>从后面进入沙坑
    .accept 267 >> 接受Trogg威胁
step << Paladin
    .goto Loch Modan,27.4,48.4
    >>研磨战车，在你的包里装上10块亚麻布，以备稍后圣骑士任务之用
    .collect 2589,10 --Linen Cloth (10)
step
    .goto Loch Modan,32.6,49.9,80.0,0
    .goto Loch Modan,37.2,46.1,80.0,0
    .goto Loch Modan,36.7,41.6
    >>找到卡德雷尔。他沿着塞尔萨马尔公路巡逻
    .turnin 414 >> 把斯托特交给卡德雷尔
    .accept 416 >> 接受捕鼠
    .accept 1339 >> 接受登山者Stormpike的任务
step
    >>进入大楼，然后下楼。与Brock交谈
    .goto Loch Modan,37.2,46.9,15,0
    .goto Loch Modan,37.0,47.8
    .accept 6387 >> 接受荣誉学生
step
    .goto Loch Modan,34.82,49.28
    .accept 418 >> 接受Thelsamar鲜血香肠
step
    .goto Loch Modan,34.8,48.6
    .vendor >> 购买1块燧石和火药，以及1块简单木材。如果需要，请购买6槽包
    .collect 4470,1 --Simple Wood (1)
    .collect 4471,1 --Flint and Tinder (1)
step << Mage
    .goto Loch Modan,35.5,48.4
    .home >> 把你的炉石放在塞尔萨马尔
step << Mage/Paladin
    #completewith next
    >>在肠道、肉类和蜱虫区杀死野猪、熊和蜘蛛
    .complete 418,1 --Collect Boar Intestines (x3)
    .complete 418,2 --Collect Bear Meat (x3)
    .complete 418,3 --Collect Spider Ichor (x3)
step << Mage/Paladin
    .xp 11+6615>>研磨至6615+/8800xp
    .goto Loch Modan,38.0,34.9,90,0
    .goto Loch Modan,37.1,39.8,90,0
    .goto Loch Modan,29.8,35.9,90,0
    .goto Loch Modan,27.7,25.3,90,0
    .goto Loch Modan,28.6,22.6,90,0
    .goto Loch Modan,38.0,34.9,90,0
    .goto Loch Modan,37.1,39.8,90,0
    .goto Loch Modan,29.8,35.9,90,0
    .goto Loch Modan,27.7,25.3,90,0
    .goto Loch Modan,28.6,22.6,90,0
    .goto Loch Modan,38.0,34.9
step << Mage/Paladin
    .goto Loch Modan,33.9,51.0
    .turnin 6387 >> 移交荣誉学生
    .accept 6391 >> 接受铁炉堡之旅
    .fp Thelsamar >> 获取Thelsamar飞行路线
    .fly Ironforge >> 飞往铁炉堡
step << Mage/Paladin
    .goto Ironforge,51.5,26.3
    .turnin 6391 >> 上交骑行前往铁炉堡
    .accept 6388 >> 接受Gryth Thurden
step << Mage/Paladin
    .goto Ironforge,39.5,57.5
    .turnin 291 >> 提交报告
step << Mage/Paladin
    .goto Ironforge,27.17,8.57 << Mage
    .goto Ironforge,23.3,6.1 << Paladin
     .trainer >> 训练你的职业咒语
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
    .goto Ironforge,18.15,51.45
    .home >> 将您的炉石设置为铁炉堡
step << Dwarf Paladin
    .goto Ironforge,21.40,50.25,60,0
    .goto Ironforge,45.40,84.65
    .unitscan John Turner
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
step << Mage/Paladin
    .goto Ironforge,55.5,47.8
    .turnin 6388 >> 转入Gryth Thurden
    .accept 6392 >> 接受返回Brock
    .fly Thelsamar >> 飞往塞尔斯马尔
step << skip
    #sticky
    #completewith next
    +磨碎暴徒，直到你至少有33银币和可售物品
--N rogue money gate for cutlass+1h剑
step
    #sticky
    #completewith Tunnel
    >>在肠道、肉类和蜱虫区杀死野猪、熊和蜘蛛
    .complete 418,1 --Collect Boar Intestines (x3)
    .complete 418,2 --Collect Bear Meat (x3)
    .complete 418,3 --Collect Spider Ichor (x3)
step
    >>跑到北方的掩体
    .goto Loch Modan,24.8,18.4
    .accept 307 >> 接受肮脏的爪子
    .turnin 1339 >> 提交登山者Stormpike的任务
    .accept 1338 >> 接受Stormpike的命令 << !Warlock !Mage
    .turnin 353 >> 交给Stormpike的交货 << Warlock
step
    #label Tunnel
    #completewith next
    .goto Loch Modan,35.46,18.78,50 >>途中为野猪肠、熊肉和蜘蛛丝碾碎一些暴徒
step
    .goto Loch Modan,35.75,22.42
    >>去科博尔德洞穴。收集你在里面找到的板条箱。
    >>抢劫一个后，板条箱可能会在你身后靠近洞口的地方产卵，请务必在抢劫2或3个后进行检查
    .complete 307,1 --Collect Miners' Gear (x4)
step
    .goto Loch Modan,35.46,18.78
    >> 杀死科波德斯。抢走他们的耳朵
    .complete 416,1 --Collect Tunnel Rat Ear (x12)
step
    #completewith next
    .goto Loch Modan,24.1,18.2
    .vendor >>跑回沙坑。供应商和维修
step
    .goto Loch Modan,24.76,18.39
    .turnin 307 >> 交上脏爪子
step
    #sticky
    #label Meat9
    .goto Loch Modan,26.9,10.7,90,0
    .goto Loch Modan,30.9,10.6,90,0
    .goto Loch Modan,28.6,15.4,90,0
    .goto Loch Modan,30.5,26.6,90,0
    .goto Loch Modan,33.4,30.3,90,0
    .goto Loch Modan,39.4,33.3,90,0
    .goto Loch Modan,26.9,10.7,90,0
    .goto Loch Modan,30.9,10.6,90,0
    .goto Loch Modan,28.6,15.4,90,0
    .goto Loch Modan,30.5,26.6,90,0
    .goto Loch Modan,33.4,30.3,90,0
    .goto Loch Modan,39.4,33.3,90,0
    .goto Loch Modan,26.9,10.7
    >>杀死熊。抢他们的肉
    .complete 418,2 --Bear Meat (3)
step
    #sticky
    #label Ichor9
    .goto Loch Modan,31.9,16.4,90,0
    .goto Loch Modan,28.0,20.6,90,0
    .goto Loch Modan,33.8,40.5,90,0
    .goto Loch Modan,36.2,30.9,90,0
    .goto Loch Modan,39.0,32.1,90,0
    .goto Loch Modan,31.9,16.4,90,0
    .goto Loch Modan,28.0,20.6,90,0
    .goto Loch Modan,33.8,40.5,90,0
    .goto Loch Modan,36.2,30.9,90,0
    .goto Loch Modan,39.0,32.1,90,0
    .goto Loch Modan,31.9,16.4
    >>杀死蜘蛛。为伊科尔抢走他们
    .complete 418,3 --Spider Ichor (3)
step
    .goto Loch Modan,38.0,34.9,90,0
    .goto Loch Modan,37.1,39.8,90,0
    .goto Loch Modan,29.8,35.9,90,0
    .goto Loch Modan,27.7,25.3,90,0
    .goto Loch Modan,28.6,22.6,90,0
    .goto Loch Modan,38.0,34.9,90,0
    .goto Loch Modan,37.1,39.8,90,0
    .goto Loch Modan,29.8,35.9,90,0
    .goto Loch Modan,27.7,25.3,90,0
    .goto Loch Modan,28.6,22.6,90,0
    .goto Loch Modan,38.0,34.9
    >>杀死野猪。掠夺他们的肠道
    .complete 418,1 --Boar Intestines (3)
step
    #requires Meat9
step
    #sticky
    #label RatCatching
    #requires Ichor9
    .goto Loch Modan,32.6,49.9,80.0,0
    .goto Loch Modan,37.2,46.1,80.0,0
    .goto Loch Modan,36.7,41.6
    >>找到卡德雷尔。他沿着塞尔萨马尔公路巡逻
    .turnin 416 >> 上缴捕鼠
step
    #requires RatCatching
    .goto Loch Modan,34.82,49.28
    .turnin 418 >> 加入塞尔萨马尔鲜血香肠
step
    .goto Loch Modan,34.8,48.6
    .vendor >> 如果需要，请购买更多6个老虎袋
step
    .goto Loch Modan,27.4,48.4
    >>杀死石刺怪。抢走他们的牙齿
    .complete 224,1 --Kill Stonesplinter Trogg (x10)
    .complete 224,2 --Kill Stonesplinter Scout (x10)
    .complete 267,1 --Collect Trogg Stone Tooth (x8)
step << !Mage !Paladin
    .goto Loch Modan,27.4,48.4
    .xp 13+5615>>研磨至5615+/11400xp
step << Mage/Paladin
    .goto Loch Modan,27.4,48.4
    .xp 13+7800>>研磨至7800+/11400xp
step << Rogue
    .goto Loch Modan,27.4,48.4
    .money >0.4315
    >>研磨，直到你有43秒15美分以上的钱/可出售物品。这是用于邪恶打击3级、1小时武器技能训练、短刀（武器）和飞往铁炉堡
step
    .goto Loch Modan,22.07,73.12
    .turnin 224 >> 为保卫国王的土地而投降
step
    .goto Loch Modan,23.23,73.67
    .turnin 267 >> 提交Trogg威胁
step << Dwarf Paladin
    #completewith next
    .goto Dun Morogh,87.1,51.1
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
    .goto Dun Morogh,70.66,56.70,40,0
    .goto Dun Morogh,70.60,54.87
    >>在特罗格洞穴中执行注销跳过，以传送回铁炉堡
    .link https://www.youtube.com/watch?v=kbUSo62CfAM >> 单击此处以供参考
step << Mage
    .hs >> 希斯玛之炉
step << !Dwarf/!Paladin
    .goto Loch Modan,33.9,51.0
    .turnin 6387 >> 移交荣誉学生 << !Mage
    .accept 6391 >> 接受铁炉堡之旅 << !Mage
    .fp Thelsamar >> 获取Thelsamar飞行路线 << !Mage
    .fly Ironforge >> 飞往铁炉堡
step << !Mage !Paladin
    .goto Ironforge,51.5,26.3
    .turnin 6391 >> 上交骑行前往铁炉堡
    .accept 6388 >> 接受Gryth Thurden
step << !Mage !Paladin !Warlock
    .goto Ironforge,18.15,51.45
    .home >> 将您的炉石设置为铁炉堡
step << !Mage !Paladin
    .goto Ironforge,39.5,57.5
    .turnin 291 >> 提交报告
step << !Mage !Paladin
    .goto Ironforge,55.5,47.8
    .turnin 6388 >> 转入Gryth Thurden
-- .accept 6392 >> 接受返回Brock
step << Warrior
    .goto Ironforge,62.0,89.6
    .train 176 >>火车抛锚
step << Mage/Priest/Warlock
    #softcore
    #sticky
    #label Wand1
    #completewith Wand2
     >>如果价格<33秒40美分，请尝试从AH购买一个更大的魔杖
    .goto Ironforge,25.74,75.43
    .collect 11288,1 --Greater Magic Wand (1)
step << Mage/Priest/Warlock
    #softcore
    #label Wand2
    #completewith Wand1
     >>如果你找不到价格合适的大魔杖，请从魔杖供应商处购买阴燃魔杖
    .goto Ironforge,24.09,16.63,14,0
    .goto Ironforge,23.13,15.96
    .collect 5208,1 --Smoldering Wand (1)
step << Mage/Priest/Warlock
    #hardcore
     >>进入大楼。如果你有33摄氏度40摄氏度，买一个阴燃魔杖+
    .goto Ironforge,24.09,16.63,14,0
    .goto Ironforge,23.13,15.96
    .collect 5208,1 --Smoldering Wand (1)
step << Warlock
    #softcore
    #requires Wand2
    .goto Ironforge,51.1,8.7,15,0 >> 进入大楼
    .goto Ironforge,50.4,6.3
    .trainer >> 训练你的职业咒语
step << Warlock
    #hardcore
    .goto Ironforge,51.1,8.7,15,0 >> 进入大楼
    .goto Ironforge,50.4,6.3
    .trainer >> 训练你的职业咒语
step << Warlock
    .goto Ironforge,53.2,7.8,15,0 >> 进入大楼
    .goto Ironforge,53.0,6.4
    .vendor >> 购买消耗阴影r1，然后牺牲r1书籍（如果你有钱）
step << Rogue
    #sticky
    #completewith next
    .isOnQuest 2218
    .goto Ironforge,51.50,15.34
    .turnin 2218 >> 转向救世之路
step << !Druid !Warlock
    .goto Ironforge,65.90,88.41 << Warrior
    .goto Ironforge,51.50,15.34 << Rogue
    .goto Ironforge,25.21,10.75 << Priest
    .goto Ironforge,27.17,8.57 << Mage
    .goto Ironforge,24.55,4.46 << Paladin
     .trainer >> 训练你的职业咒语
step << !Warlock
    #completewith next
    +执行注销跳过，跳到鹰头狮的头上，注销，然后再重新登录
    .link https://www.youtube.com/watch?v=PWMJhodh6Bw >> 单击此处
step << !Warlock
    .goto Ironforge,74.40,51.10,30,0
    .goto Ironforge,74.40,51.10,0
     >> 进入Deeprun Tram，在中间平台与侏儒交谈
    .accept 6661 >> 接受Deeprun老鼠围捕
step << !Warlock
    >>用你的长笛对付四处散落的老鼠
    .complete 6661,1 --Rats Captured (x5)
step << !Warlock
    .turnin 6661 >> 交给Deeprun老鼠围捕
    .accept 6662 >> 接受我，兄弟，尼普西 << !Mage
    >>如果你不需要钱（5s60c），而且电车已经到了，你可以跳过Nipsy << !Mage
step << !Warlock !Mage
     .isOnQuest 6662
    >> 乘电车去暴风城，到了电车的另一边后再转弯
    .turnin 6662 >> 交给我，兄弟，尼普西
    >>在等待/乘坐电车时进行急救训练，您需要80分的急救积分才能完成24级任务 << Rogue
step << !Warlock !Mage
    #completewith next
    .goto StormwindClassic,60.5,12.3
    .zone Stormwind City >>下车进入暴风城
step << skip
    .goto StormwindClassic,51.6,12.2
    .accept 353 >> 接受Stormpike的交付
step << !Warlock !Mage
    .goto StormwindClassic,58.1,16.5
    .turnin 1338 >> 提交Stormpike的命令
step << Priest
    #completewith next
    >>进入大教堂
    .goto StormwindClassic,38.54,26.86
    .trainer >> 训练你的职业咒语
    .turnin 5634 >> 递交绝望祈祷
step << Priest
    .goto StormwindClassic,38.62,26.10
    .train 13908 >> 训练绝望祈祷
step << Warrior
    #completewith next
    .goto StormwindClassic,74.91,51.55,20 >> 进入指挥中心
step << Warrior
    .goto StormwindClassic,78.67,45.80
    .trainer >> 上楼去。训练你的职业咒语
    .accept 1638 >> 接受战士训练
step << Warrior
    #sticky
    #completewith next
    .goto StormwindClassic,71.7,39.9,20 >>进入酒馆
step << Warrior
    .goto StormwindClassic,74.3,37.3
    .turnin 1638 >> 交战士训练
    .accept 1639 >> 接受醉汉巴特比
step << Warrior
    .goto StormwindClassic,73.8,36.3
    .turnin 1639 >> 交给醉汉巴特比
    .accept 1640 >> 接受Beat Bartleby
    .complete 1640,1 --Beat Bartleby
step << Warrior
    .goto StormwindClassic,73.8,36.3
    .turnin 1640 >> 加入Beat Bartleby
    .accept 1665 >> 接受巴特比的马克杯
step << Warrior
    >>你现在将学习防御姿态和破甲
    .goto StormwindClassic,74.3,37.3
    .turnin 1665 >> 交给巴特比的马克杯
step << !Warlock !Mage
    .goto StormwindClassic,57.1,57.7
    .trainer >>训练1h剑 << Rogue
    .trainer >>火车杆 << Priest
    .trainer >>火车站。如果你有多余的钱，训练1小时的剑 << Warlock/Mage
    .trainer >>训练2h剑 << Warrior/Paladin
step << Rogue
    .goto StormwindClassic,57.6,57.1
    .vendor >> 如果你有钱，从冈瑟那里买一把弯刀并装备它。在你的副手上装备早期的工匠匕首
step << Rogue/Warrior
    >>进入大楼
    .goto StormwindClassic,57.32,62.08,20,0
    .goto StormwindClassic,58.37,61.69
    .vendor >> 购买瑟曼的11级投掷。装备它
step << !Warlock !Mage
    .hs >> 炉到铁炉
step
    #softcore
    #completewith next
    .goto Ironforge,55.5,47.8
    .fly Wetlands>> 飞到湿地
step
    #hardcore
    .goto Dun Morogh,52.6,36.0
    .zone Dun Morogh >> 离开铁炉堡，前往邓莫罗
step
    #hardcore
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
    +打开此链接并在另一个屏幕上进行跟踪。
    >>邓莫罗不死->湿地跳过
    .link https://www.youtube.com/watch?v=9afQTimaiZQ >> 单击此处以供参考
    .goto Wetlands,9.5,59.7,80 >> 前往米奈希尔港
step
    #hardcore
	#label EndLoch
    .goto Wetlands,9.5,59.7
    .fp Menethil Harbor >> 获取Menethil Harbor航线
step
    .goto Wetlands,4.6,57.2
    .zone Darkshore >>前往Menethil Harbor码头，乘船前往Darkshore
	>>用早先的食物生篝火，开始烹饪野猪肉，直到你拥有10以上的技能
    >>在等待船只的同时进行急救训练，您需要80分的急救积分才能完成24级任务 << Rogue
]])

RXPGuides.RegisterGuide([[
#classic
#som
#phase 3-6
<< Alliance Hunter
#name 1-7 寒脊山谷 (猎人)
#version 1
#group RestedXP 联盟 1-20
#defaultfor Dwarf
#next 6-12 丹莫罗 (猎人)
step << !Gnome !Dwarf
    #sticky
    #completewith next
    .goto Dun Morogh,29.9,71.2
    +你选择了一个为侏儒和侏儒准备的向导。你应该选择与你开始时相同的起始区域
step
    .goto Dun Morogh,29.9,71.2
    >>与Sten Stoutarm交谈
    .accept 179 >>接受矮人装扮
step
    .goto Dun Morogh,29.0,74.4
    .complete 179,1 --Tough Wolf Meat (8)
step
    .goto Dun Morogh,29.9,71.3
    .turnin 179 >>交出矮人套装
    .accept 233 >>接受Coldridge Valley邮件递送
    .accept 3108 >>接受蚀刻符文
step
    .goto Dun Morogh,29.7,71.3
    >>与巴里尔冰锤对话
    .accept 170 >>接受新威胁
step
    #sticky
    #label Rockjaw
    >>杀死罗克贾夫特罗格斯（Rockjaw Troggs）
    .goto Dun Morogh,29.20,76.08,0
    .goto Dun Morogh,26.38,73.07,0
    .complete 170,1 --Kill Rockjaw Trogg (x6)
    .complete 170,2 --Kill Burly Rockjaw Trogg (x6)
step
    .goto Dun Morogh,22.6,71.4
    >>与塔林·基尼交谈
    .turnin 233 >>提交科尔德里奇谷邮件递送
    .accept 234 >>接受Coldridge Valley邮件递送
    .accept 183 >>接受野猪猎人
step
    .goto Dun Morogh,22.2,72.5,100,0
    .goto Dun Morogh,20.5,71.4,100,0
    .goto Dun Morogh,21.1,69.0,100,0
    .goto Dun Morogh,22.8,69.6,100,0
    .goto Dun Morogh,22.2,72.5,100,0
    .goto Dun Morogh,20.5,71.4,100,0
    .goto Dun Morogh,21.1,69.0
    >>杀死该地区的野猪
    .complete 183,1 --Kill Small Crag Boar (x12)
step
    .goto Dun Morogh,22.6,71.4
    .turnin 183 >>上缴猎野猪者
step
    .goto Dun Morogh,25.1,75.7
    >>与格雷林·白胡子交谈
    .turnin 234 >>提交科尔德里奇谷邮件递送
    .accept 182 >>接受巨魔洞穴
step
    .xp 4 >> 研磨至4
step
    .goto Dun Morogh,25.0,75.9
    .accept 3364 >>接受烫发晨报递送
step
    #requires Rockjaw
    .goto Dun Morogh,29.7,71.3
    >>与巴里尔冰锤对话
    .turnin 170 >>提交新威胁
step
    #completewith next
    .goto Dun Morogh,30.09,71.58
    >>购买2堆弹药
    .collect 2516,400
step
    .goto Dun Morogh,29.1,67.5
    >>与索加斯·格里姆森交谈
    .turnin 3108 >>交上蚀刻的符文
        .train 1978 >> 火车蛇刺
step
    .goto Dun Morogh,28.8,66.5
    >>与Durnan Furcutter交谈
    .turnin 3364 >>交付烫伤晨报
    .accept 3365 >>接受带回马克杯
step
    .goto Dun Morogh,25.0,75.9
    .turnin 3365 >>把杯子拿回来
step
    .goto Dun Morogh,22.7,79.3
    .goto Dun Morogh,20.9,75.7,0
    .goto Dun Morogh,27.3,79.7,0
    >>杀死霜鬃巨魔幼崽
    .complete 182,1 --Kill Frostmane Troll Whelp (x14)
    .goto Dun Morogh,25.1,75.7
step
    .goto Dun Morogh,25.0,75.9
    .turnin 182 >>转入巨魔洞穴
    .accept 218 >>接受被盗日记
step
    .goto Dun Morogh,26.8,79.9,40,0
    .goto Dun Morogh,29.0,79.0,25,0
    .goto Dun Morogh,30.6,80.3
    >>进入巨魔洞穴。杀了格里克尼尔，然后把他抢走作为格雷林的日记
    .complete 218,1 --Collect Grelin Whitebeard's Journal (x1)
step
    #completewith next
    .goto Dun Morogh,28.4,79.7,35,0
    .goto Dun Morogh,26.8,79.6,25 >>跑出洞穴
step
    .goto Dun Morogh,25.1,75.7
    .turnin 218 >> 交出被盗日记
    .accept 282 >> 接受Senir的意见
step
    .goto Dun Morogh,33.5,71.8
    >>与登山者Thalos交谈
    .turnin 282 >>提交Senir的观察结果
    .accept 420 >>接受Senir的意见
step
    .goto Dun Morogh,33.8,72.2
    >>与手对话弹簧链轮
    .accept 2160 >>接受供应给Tannok
step
    .goto Dun Morogh,34.1,71.6,20,0
    .goto Dun Morogh,35.7,66.0,0
    .goto Dun Morogh,35.7,66.0,20 >>穿过隧道
]])

RXPGuides.RegisterGuide([[
#classic
#som
#phase 3-6
<< Alliance Hunter
#name 6-12 丹莫罗 (猎人)
#version 1
#group RestedXP 联盟 1-20
#defaultfor Dwarf Hunter
#next 11-14 洛克莫丹 (猎人)
step
    #completewith ribs1
    >> 杀死野猪以获得一些野猪肉/排骨供稍后使用
    .collect 769,4 --Collect Chunk of Boar Meat (x4)
    .collect 2886,6 --Collect Crag Boar Rib (x6)
step
    .goto Dun Morogh,46.7,53.8
    .turnin 420 >> 提交Senir的观察结果
step
    #label ribs1
    .goto Dun Morogh,46.8,52.4
    .accept 384 >>接受啤酒烤猪排
step
    .goto Dun Morogh,47.2,52.2
    .turnin 2160 >>向Tannok移交物资
step
    .goto Dun Morogh,46.0,51.7
    .accept 400 >>钢格栅的验收工具
step
    .goto Dun Morogh,49.5,48.3
    .accept 317 >>接受库存Jetsteam
step << skip
    .goto Dun Morogh,49.6,48.5
    .accept 313 >>接受Grizzled Den
step
    .goto Dun Morogh,50.1,49.4
    .accept 5541 >>接受弹药以防隆隆枪击
step
    .goto Dun Morogh,50.4,49.1
    .turnin 400 >>钢格栅上交工具
step
    #sticky
    #completewith BoarRibs2
    >> 杀死野猪以获得野猪肋骨
    .collect 2886,6 --Collect Crag Boar Rib (x6)
step
    .goto Dun Morogh,52.0,50.1,100,0
    .goto Dun Morogh,51.5,53.9,100,0
    .goto Dun Morogh,50.1,53.9,100,0
    .goto Dun Morogh,49.9,50.9,100,0
    .goto Dun Morogh,48.0,49.5,100,0
    .goto Dun Morogh,48.2,46.9,100,0
    .goto Dun Morogh,43.5,52.5,100,0
    .goto Dun Morogh,52.0,50.1,100,0
    .goto Dun Morogh,51.5,53.9,100,0
    .goto Dun Morogh,50.1,53.9,100,0
    .goto Dun Morogh,49.9,50.9,100,0
    .goto Dun Morogh,48.0,49.5,100,0
    .goto Dun Morogh,48.2,46.9,100,0
    .goto Dun Morogh,43.5,52.5,100,0
    .goto Dun Morogh,52.0,50.1,100,0
    .goto Dun Morogh,51.5,53.9,100,0
    .goto Dun Morogh,50.1,53.9,100,0
    .goto Dun Morogh,49.9,50.9,100,0
    .goto Dun Morogh,48.0,49.5,100,0
    .goto Dun Morogh,48.2,46.9,100,0
    .goto Dun Morogh,43.5,52.5,100,0
    .goto Dun Morogh,52.0,50.1,0
    .goto Dun Morogh,51.5,53.9,0
    .goto Dun Morogh,50.1,53.9,0
    .goto Dun Morogh,49.9,50.9,0
    .goto Dun Morogh,48.0,49.5,0
    .goto Dun Morogh,48.2,46.9,0
    .goto Dun Morogh,43.5,52.5
    >>获取Jetsteam库存物品
    .complete 317,1 --Collect Chunk of Boar Meat (x4)
    .complete 317,2 --Collect Thick Bear Fur (x2)
step
    .goto Dun Morogh,49.4,48.4
    >>与飞行员Bellowfiz交谈
    .turnin 317 >>上缴库存Jetsteam
    .accept 318 >>接受Evershine
step
    .xp 6
step << Hunter
    .goto Dun Morogh,45.8,53.1
    .train 3044 >> 火车奥术射击
step
    >>抢劫板条箱
.goto Dun Morogh,44.1,56.9
    .complete 5541,1 --Rumbleshot's Ammo (1)
step
    .goto Dun Morogh,40.7,65.1
    >>与Hegnar Rumbleshot交谈
    .turnin 5541 >>交出弹药进行隆布尔枪击
step << Hunter
    .goto Dun Morogh,40.7,65.1
    >>购买4级枪升级，如果你没有钱，跳过这一步
    .collect 2509,1
step << skip
    .goto Dun Morogh,42.25,53.68,40,0
    .goto Dun Morogh,41.07,49.04,50,0
    .goto Dun Morogh,42.25,53.68
    >> 到洞里去。杀死Wendigos。掠夺他们的鬃毛
    .complete 313,1 --Collect Wendigo Mane (x8)
step
    .xp 7
step
    >>在途中碾碎一些暴徒
    .goto Dun Morogh,35.2,56.4,60,0
    .goto Dun Morogh,36.0,52.0,60,0
    .goto Dun Morogh,34.6,51.7
    .accept 312 >> 接受Tundra MacGrann被盗的Stash
step << !Mage
    .goto Dun Morogh,38.5,54.0
    >>等到老冰胡子离开山洞，你就可以偷偷进去洗劫箱子，或者这样做
        .link https://www.youtube.com/watch?v=o55Y3LjgKoE >>单击此处
    .complete 312,1 --MacGrann's Dried Meats (1)
step
    .goto Dun Morogh,34.6,51.6
    .turnin 312 >>交出Tundra MacGrann被盗的Stash
step
    .goto Dun Morogh,30.4,45.8
    .vendor >> 供应商垃圾
step
    .goto Dun Morogh,30.2,45.8
    >>与Rejold Barleybrew交谈
    .turnin 318 >>交给Evershine
    .accept 319 >>接受对Evershine的支持
    .accept 315 >>接受完美的烈性酒
step
    #label BoarRibs2
    .goto Dun Morogh,30.2,45.4
    >>与Marleth Barleybrew交谈
    .accept 310 >>接受残酷的竞争对手
step
    #completewith next
    >> 杀死熊、野猪和豹子
    .complete 319,1 --Kill Ice Claw Bear (x6)
    .complete 319,2 --Kill Elder Crag Boar (x8)
    .complete 319,3 --Kill Snow Leopard (x8)
step << Hunter
	#hardcore
    .goto Dun Morogh,46.7,53.8
    .complete 384,1
    .xp 8-1540 >>研磨，直到距离8级1540 xp。
step << Hunter
	#softcore
    .goto Dun Morogh,30.9,35.1
    .complete 384,1
    .xp 8-1540 >>研磨，直到距离8级1540 xp。
step
    #softcore
    .goto Dun Morogh,30.9,33.1,15 >>向北跑上山
step
    #softcore
    .goto Dun Morogh,32.4,29.1,15 >>继续到这里
step
    #softcore
    .goto Dun Morogh,33.0,27.2,25,0
    .goto Dun Morogh,33.0,25.2,25,0
    .goto Wetlands,11.6,43.4,60,0
    .goto Wetlands,11.6,43.4,0
    .deathskip >>继续向北奔跑，一旦General Chat变为湿地，跳下来死去，然后在Menethil Harbor重生
step
    #completewith next
    #softcore
    .goto Wetlands,12.7,46.7,80,0 >> 游到岸上
step
    #softcore
    .goto Wetlands,9.5,59.7
    .fp Menethil>> 获取Menethil Harbor航线
step
    #softcore
    #completewith next
    .hs >> 赫斯回到哈拉诺斯
step << skip
    .goto Dun Morogh,49.6,48.5
    .turnin 313 >>在Grizzled Den转弯
step
    .goto Dun Morogh,47.4,52.5
    >>向客栈老板购买以下物品：
    .complete 384,2 --Rhapsody Malt (1)
    .collect 2686,1,311 --Thunder Ale
step
    .goto Dun Morogh,47.7,52.6
    >>下楼，把雷霆啤酒给贾文，然后点击无人看守的桶
    .turnin 310 >>在激烈的竞争中获胜
    .accept 311 >>接受返回Marleth
step
    .goto Dun Morogh,47.3,52.5
    .home >> 将您的炉石设置为Kharanos
step
    .goto Dun Morogh,46.9,52.4
    >>与Ragnar Thunderbrew交谈
    .turnin 384 >>翻啤酒扒猪排
step
    .goto Dun Morogh,46.7,53.9
    .accept 287 >>接受Frostmane保持
step  << skip
    .goto Dun Morogh,49.6,48.5
    .turnin 313 >>在Grizzled Den转弯
step << Hunter
    .goto Dun Morogh,45.8,53.0
    .train 5116>> 火车震荡射击
step
    #sticky
    #label favor
    >> 杀死熊、野猪和豹子
    .complete 319,1 --Kill Ice Claw Bear (x6)
    .complete 319,2 --Kill Elder Crag Boar (x8)
    .complete 319,3 --Kill Snow Leopard (x8)
step
    #completewith next
    .goto Dun Morogh,43.1,45.0,20,0
    .goto Dun Morogh,42.1,45.4,20 >> 跑上坡道到Shimmerweed
step
    .goto Dun Morogh,40.9,45.3,50,0
    .goto Dun Morogh,41.5,43.6,50,0
    .goto Dun Morogh,39.7,40.0,50,0
    .goto Dun Morogh,42.1,34.3,50,0
    .goto Dun Morogh,39.5,43.0
    .goto Dun Morogh,41.5,36.0
    >>清除这个地区的暴徒。如果你需要清理中间营地，请小心。如果你需要更多的暴徒，你可以把暴徒拉到小屋里，视线（LoS）在小屋后面。如果你运气不好，就跑到另一个地方去
    .complete 315,1 --Collect Shimmerweed (x6)
step
    #sticky
    #requires favor
    #label return
    .goto Dun Morogh,30.2,45.7
    >>与Rejold Barleybrew交谈
    .turnin 319 >>为Evershine提供支持
    .accept 320 >>接受返回Bellowfiz
step
    .goto Dun Morogh,30.2,45.5
    .turnin 311 >>交给马利思
    .turnin 315 >>交上完美的烈酒
    .accept 413 >>接受Shimmer Stout
step
    #requires return
    >>进入巨魔洞穴
    >>小心别死在这里
    .goto Dun Morogh,22.3,50.7,30,0
    .goto Dun Morogh,22.5,51.5,30,0
    .goto Dun Morogh,22.7,52.0
    .complete 287,1 --Fully explore Frostmane Hold (1)
    .complete 287,2 --Frostmane Headhunter (5)
step
    #hardcore
    #completewith next
    .goto Dun Morogh,46.3,52.1,200 >> 开始跑回哈拉诺斯
step
    #era
    .xp 10-1470 >> 研磨，直到距离10级1450xp
step
    #som
	#phase 1-2
    .xp 10-2050 >> 研磨直到距离10级2050xp
step
	#som
	#phase 3-6
	.xp 10-2950 >> 研磨直到距离10级2950xp
step
	#completewith next
	#hardcore
	.hs >> 赫斯到哈拉诺斯
step
	#completewith next
	#softcore
	.deathskip >> 在哈拉诺死后重生
step
    .goto Dun Morogh,46.7,53.7
    .turnin 287 >>交给Frostmane Hold
    .accept 291 >>接受报告
step
    .goto Dun Morogh,49.4,48.3
    .turnin 320 >>转身返回贝洛菲兹
step
    .goto Dun Morogh,45.8,53.0
    .accept 6064 >>接受驯服野兽
step
    .goto Dun Morogh,48.3,56.9
    >>点击你包里的驯养棒来驯养一头大野猪。尝试在最大射程（30码）进行
    .complete 6064,1 --Tame a Large Crag Boar (1)
step
    .goto Dun Morogh,45.8,53.0
    .turnin 6064 >>转身驯服野兽
    .accept 6084 >>接受驯服野兽
step
    .goto Dun Morogh,49.4,59.4
    >>点击你包里的驯雪豹棒。尝试在最大射程（30码）进行
    .complete 6084,1 --Tame a Snow Leopard (1)
step
    .goto Dun Morogh,45.8,53.0
    .turnin 6084 >>转身驯服野兽
    .accept 6085 >>接受驯服野兽
step
    .goto Dun Morogh,50.4,59.7
    >>点击你包里的驯冰爪熊棒。尝试在最大射程（30码）进行
    .complete 6085,1 --Tame an Ice Claw Bear (1)
step
    .goto Dun Morogh,45.8,53.0
    .turnin 6085 >>转身驯服野兽
    .accept 6086 >>接受训练野兽
step
    .goto Dun Morogh,63.1,49.8
    >>与Rudra Amberstill交谈
    .accept 314 >>接受保护羊群
step
    #sticky
    #completewith next
    .goto Dun Morogh,62.3,50.3,12,0
    .goto Dun Morogh,62.2,49.4,8 >>跑上山的这一部分
step
    .goto Dun Morogh,62.6,46.1
    >>杀死瓦加什。抢他的牙，这个任务很难，试着把他放在十字路口的警卫那里
    .complete 314,1 --Collect Fang of Vagash (x)
    .link https://www.youtube.com/watch?v=6PfhYU-9hoA >> 点击此处查看视频参考
step
    .goto Dun Morogh,63.1,49.8
    .turnin 314 >> 转身保护羊群
    .isQuestComplete 314
step
    .goto Dun Morogh,69.1,56.3
    .accept 432 >> 接受那些被炸死的流浪汉！
step
    .goto Dun Morogh,70.7,56.4,50,0
    .goto Dun Morogh,70.62,52.39
    >>在洞穴和采石场周围杀死特罗格斯
    .complete 432,1 --Kill Rockjaw Skullthumper (x6)
    --.complete 433,1 --Kill Rockjaw Bonesnapper (x10)
step
    .goto Dun Morogh,69.1,56.3
    .turnin 432 >> 把那些被炸死的暴徒交上来！
step << skip
    .goto Dun Morogh,68.4,54.5
    .train 2550 >> Ghilm的火车烹饪
step
    .goto Dun Morogh,83.8,39.2
    .accept 419 >> 接受迷失的飞行员
step
    .goto Dun Morogh,79.7,36.2
    .turnin 419 >> 交出失踪的飞行员
    .accept 417 >> 接受飞行员的复仇
step
    >>杀死芒格克劳。抢劫他的爪子，这个任务可能很难，把他放在任务给予者旁边的警卫那里
    .goto Dun Morogh,80.0,36.4
    .complete 417,1 --Collect Mangy Claw (x1)
step
    .goto Dun Morogh,83.9,39.2
    .turnin 417 >> 提交飞行员的复仇

step
    .goto Dun Morogh,86.3,48.8
    .turnin 413 >> 转入Shimmer Stout
    .accept 414 >> 接受斯托特到卡德雷尔
]])

RXPGuides.RegisterGuide([[
#classic
#som
#phase 3-6
<< Alliance Hunter
#name 11-14 洛克莫丹 (猎人)
#version 1
#group RestedXP 联盟 1-20
#defaultfor Dwarf
#next 11-16 黑海岸

step
    .goto Loch Modan,22.07,73.12
    >>前往莫丹湖
    .accept 224 >> 接受保护国王的土地
step
    .goto Loch Modan,23.23,73.67
    .accept 267 >> 接受Trogg威胁
step
    #sticky
    #label ratcatching
     >> 与巡逻塞尔萨马尔的警卫交谈
    --.accept 416 >> 接受捕鼠
    .accept 1339 >> 接受登山者Stormpike的任务
step
       .goto Loch Modan,35.5,48.4
    .home >> 将您的炉石设置为莫丹湖
step
    .goto Loch Modan,37.01,47.80
    .accept 6387 >> 接受荣誉学生
step
    #requires ratcatching
    .goto Loch Modan,33.93,50.95
    .turnin 6387 >> 移交荣誉学生
    .accept 6391 >> 接受铁炉堡之旅
step
     #completewith next
    .fly Ironforge>> 飞往铁炉堡
step
    .goto Ironforge,51.52,26.31
    .turnin 6391 >> 上交骑行前往铁炉堡
    .accept 6388 >> 接受Gryth Thurden
step
    .goto Dun Morogh,57.42,30.31
    .turnin 291 >> 提交报告
step <<  Hunter
    .goto Ironforge,70.86,85.83
    .turnin 6086 >> 上缴训练野兽
step
    .goto Ironforge,55.50,47.74
    .turnin 6388 >> 转入Gryth Thurden
    .accept 6392 >> 接受返回Brock
step
    #completewith next
    .fly Loch Modan>> 飞往莫丹湖
step
    .goto Loch Modan,37.0,47.8
    >>进入大楼，然后下楼。与Brock交谈
    .turnin 6392 >> 交回Brock
step << Hunter
    .goto Loch Modan,35.8,43.5
    >>如果你还有13秒的剩余时间，请从Vrok Blunderblast购买9级枪升级，否则请跳过此步骤
    .collect 2511,1
step
    .goto Loch Modan,32.55,74.61
    >>杀死Troggs
    .complete 224,1
    .complete 224,2
    .complete 267,1
step
    .goto Loch Modan,22.07,73.12
    .turnin 224 >> 为保卫国王的土地而投降
step
    .goto Loch Modan,23.23,73.67
    .turnin 267 >> 提交Trogg威胁
step
    .goto Loch Modan,24.76,18.39
    .turnin 1339 >> 提交登山者Stormpike的任务
step
    .goto Loch Modan,24.76,18.39
    .accept 1338 >> 接受Stormpike的命令
step
	#softcore
    #completewith next
    .deathskip >> 拉暴徒，故意死亡，在塞尔萨马尔重生
step
    .goto Loch Modan,33.93,50.95
    .fly Ironforge>> 飞往铁炉堡
step
    .goto Ironforge,60.0,36.8
    .train 2550 >> 确保在铁炉堡培训烹饪
step
    .goto Ironforge,74.64,11.74
    .turnin 301 >> 向铁炉堡提交报告
step
    .goto Ironforge,74.40,51.10,30,0
    .goto Ironforge,74.40,51.10,0
     >> 进入Deeprun Tram，在中间平台与侏儒交谈
    .accept 6661 >> 接受Deeprun老鼠围捕
step
    >>使用车站周围老鼠身上提供的长笛
    .complete 6661,1
step
    .turnin 6661 >> 交给Deeprun老鼠围捕
    .accept 6662 >> 接受我，兄弟，尼普西
step
     >> 骑到电车的另一侧，然后转弯
    .turnin 6662 >> 交给我，兄弟，尼普西
step
    #completewith next
    .goto StormwindClassic,60.5,12.3
    .zone Stormwind City >>下车进入暴风城
step
    #softcore
    .goto StormwindClassic,51.75,12.06
    .accept 353 >> 接受Stormpike的交付
step
    .goto StormwindClassic,58.08,16.52
    .turnin 1338 >> 提交Stormpike的命令
step
    .goto StormwindClassic,57.23,57.29
    .trainer >> 火车杆
step
	#completewith next
    .hs >> 如果您的炉灶仍在冷却，请返回瑟萨马尔，乘坐电车前往铁炉堡，然后飞往莫丹湖
step
    .goto Loch Modan,24.76,18.39
    .turnin 353 >> 交给Stormpike的交货
step
	#softcore
     #completewith next
     .deathskip >> 死后在墓地重生
step
    #softcore
    #completewith next
    .goto Loch Modan,33.93,50.95
    .fly Wetlands>> 飞到湿地
step
    #hardcore
    .goto Dun Morogh,52.6,36.0
    .zone Dun Morogh >> 乘坐电车返回铁炉堡，前往邓莫罗
step
    #hardcore
    #label skip1
    #completewith fp
	+如果莫丹湖湿地运行，你可以通过一系列的跳山来节省大量时间，请看下面的视频
    .link https://www.youtube.com/watch?v=q-yHviS7baQ >> 此跳过很难，请单击此处查看视频参考
step
    #hardcore
    #label fp
    .goto Wetlands,9.5,59.7
    .fp Menethil Harbor >> 获取Menethil Harbor航线
step << Hunter
	.goto Wetlands,11.4,59.6
	>>从铁匠内部的穆丹德那里购买16级武器升级，如果你没有足够的钱，跳过这一步
	.collect 3023,1
step
    .goto Wetlands,4.6,57.2
    .zone Darkshore >>前往Menethil Harbor码头，乘船前往Darkshore
    >>在你等待的时候生篝火并平铺烹饪
    >>在等待船只的同时进行急救训练，您需要80分的急救积分才能完成24级任务 << Rogue
]])
