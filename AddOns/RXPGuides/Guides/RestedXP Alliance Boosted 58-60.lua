RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Alliance
#name 提升角色 58-60
#version 1
#group RestedXP 联盟 Boosted 58-60
#defaultfor 58Boost
#next RestedXP 联盟 60-70\59-61 地狱火半岛
step << Warrior
.accept 64028 >>接受新的开始
    .turnin 64028 >>开创新的开端
    .accept 64031 >>接受生存工具
    .complete 64031,1 --1/1 Open the Survival Kit (1)
    .complete 64031,2 --1/1 Equip a Weapon (1)
step << Warrior
    .goto StormwindClassic,78.3,47.4
    .turnin 64031 >>上缴生存工具
    .accept 64034 >>接受战斗训练
    .complete 64034,1 --1/1 Train a Spell (1)
step << Warrior
    .goto StormwindClassic,78.3,47.4
    .turnin 64034 >>交战训练
    .accept 64035 >>接受人才
    .complete 64035,1 --5 Talent Points Allocated (1)
step << Warrior
    .goto StormwindClassic,78.3,47.4
    .turnin 64035 >>上缴人才
    .accept 64038 >>接受黑暗之门
--
step << Paladin
    .goto StormwindClassic,37.3,33.0
    .accept 64028 >>接受新的开始
step << Paladin
    .goto StormwindClassic,37.2,33.2
    .turnin 64028 >>开创新的开端
    .accept 64031 >>接受生存工具
    .complete 64031,1 --1/1 Open the Survival Kit (1)
    .complete 64031,2 --1/1 Equip a Weapon (1)
step << Paladin
    .goto StormwindClassic,37.2,33.2
    .turnin 64031 >>上缴生存工具
    .accept 64034 >>接受战斗训练
    .complete 64034,1 --1/1 Train a Spell (1)
step << Paladin
    .goto StormwindClassic,37.2,33.2
    .turnin 64034 >>交战训练
    .accept 64035 >>接受人才
    .complete 64035,1 --5 Talent Points Allocated (1)
step << Paladin
    .goto StormwindClassic,37.2,33.2
    .turnin 64035 >>上缴人才
    .accept 64038 >>接受黑暗之门
--
step << Rogue
    .goto StormwindClassic,78.3,57.3
    .accept 64028 >>接受新的开始
    .turnin 64028 >>开创新的开端
    .accept 64031 >>接受生存工具
    .complete 64031,1 --1/1 Open the Survival Kit (1)
    .complete 64031,2 --1/1 Equip a Weapon (1)
step << Rogue
    .goto StormwindClassic,78.3,57.3
    .turnin 64031 >>上缴生存工具
    .accept 64034 >>接受战斗训练
    .complete 64034,1 --1/1 Train a Spell (1)
step << Rogue
    .goto StormwindClassic,78.3,57.3
    .turnin 64034 >>交战训练
    .accept 64035 >>接受人才
    .complete 64035,1 --5 Talent Points Allocated (1)
step << Rogue
    .goto StormwindClassic,78.3,57.3
    .turnin 64035 >>上缴人才
    .accept 64038 >>接受黑暗之门
--
step << Priest
    .goto StormwindClassic,38.8,26.4
    .accept 64028 >>接受新的开始
    .turnin 64028 >>开创新的开端
    .accept 64031 >>接受生存工具
    .complete 64031,1 --1/1 Open the Survival Kit (1)
    .complete 64031,2 --1/1 Equip a Weapon (1)
step << Priest
    .goto StormwindClassic,38.8,26.4
    .turnin 64031 >>上缴生存工具
    .accept 64034 >>接受战斗训练
    .complete 64034,1 --1/1 Train a Spell (1)
step << Priest
    .goto StormwindClassic,38.8,26.4
    .turnin 64034 >>交战训练
    .accept 64035 >>接受人才
    .complete 64035,1 --5 Talent Points Allocated (1)
step << Priest
    .goto StormwindClassic,38.8,26.4
    .turnin 64035 >>上缴人才
    .accept 64038 >>接受黑暗之门

--
step << Mage
    .goto StormwindClassic,38.7,79.3
    .accept 64028 >>接受新的开始
    .turnin 64028 >>开创新的开端
    .accept 64031 >>接受生存工具
    .complete 64031,1 --1/1 Open the Survival Kit (1)
    .complete 64031,2 --1/1 Equip a Weapon (1)
step << Mage
    .goto StormwindClassic,38.7,79.3
    .turnin 64031 >>上缴生存工具
    .accept 64034 >>接受战斗训练
    .complete 64034,1 --1/1 Train a Spell (1)
step << Mage
    .goto StormwindClassic,38.7,79.3
    .turnin 64034 >>交战训练
    .accept 64035 >>接受人才
    .complete 64035,1 --5 Talent Points Allocated (1)
step << Mage
    .goto StormwindClassic,38.7,79.3
    .turnin 64035 >>上缴人才
    .accept 64038 >>接受黑暗之门

--
step << Warlock
    .goto StormwindClassic,26.0,77.4
    .accept 64028 >>接受新的开始
    .turnin 64028 >>开创新的开端
    .accept 64031 >>接受生存工具
    .complete 64031,1 --1/1 Open the Survival Kit (1)
    .complete 64031,2 --1/1 Equip a Weapon (1)
step << Warlock
    .goto StormwindClassic,26.0,77.4
    .turnin 64031 >>上缴生存工具
    .accept 64034 >>接受战斗训练
    .complete 64034,1 --1/1 Train a Spell (1)
step << Warlock
    .goto StormwindClassic,26.0,77.4
    .turnin 64034 >>交战训练
    .accept 64035 >>接受人才
    .complete 64035,1 --5 Talent Points Allocated (1)
step << Warlock
    .goto StormwindClassic,26.1,77.4
    .turnin 64035 >>上缴人才
    .accept 64038 >>接受黑暗之门

--
step << Hunter
    .goto StormwindClassic,61.7,15.2
    .accept 64028 >>接受新的开始
    .turnin 64028 >>开创新的开端
    .accept 64031 >>接受生存工具
    .complete 64031,1 --1/1 Open the Survival Kit (1)
    .complete 64031,2 --1/1 Equip a Weapon (1)
step << Hunter
    .goto StormwindClassic,61.7,15.2
    .turnin 64031 >>上缴生存工具
    .accept 64034 >>接受战斗训练
    .complete 64034,1 --1/1 Train a Spell (1)
step << Hunter
    .goto StormwindClassic,61.7,15.2
    .turnin 64034 >>交战训练
    .accept 64035 >>接受人才
    .complete 64035,1 --5 Talent Points Allocated (1)
step << Hunter
    .goto StormwindClassic,61.7,15.2
    .turnin 64035 >>上缴人才
    .accept 64038 >>接受黑暗之门

step << Druid
    .goto StormwindClassic,21.4,51.4
    .turnin 64028 >>开创新的开端
    .accept 64031 >>接受生存工具
    .complete 64031,1 --1/1 Open the Survival Kit (1)
    .complete 64031,2 --1/1 Equip a Weapon (1)
step << Druid
    .goto StormwindClassic,21.4,51.4
    .turnin 64031 >>上缴生存工具
    .accept 64034 >>接受战斗训练
    .complete 64034,1 --1/1 Train a Spell (1)
step << Druid
    .goto StormwindClassic,21.4,51.4
    .turnin 64034 >>交战训练
    .accept 64035 >>接受人才
    .complete 64035,1 --5 Talent Points Allocated (1)
step << Druid
    .goto StormwindClassic,21.4,51.4
    .turnin 64035 >>上缴人才
    .accept 64038 >>接受黑暗之门
step << skip
    #completewith bs1
    .goto StormwindClassic,78.0,18.2
    .accept 6182 >>接受第一个和最后一个
    >>奥妮克希亚调谐任务中有一个长脚本RP序列，这使得伯瓦尔在几分钟内无法与玩家互动，如果是这样的话，跳过这一步，在完成燃烧的阶梯后再尝试获得这个任务
step
    #label bs1
    .goto StormwindClassic,66.2,62.2
    .complete 64038,1 --Speak to Dungar Longdrink, the Gryphon Master (1)
    .fly Morgan's Vigil>>飞往摩根守夜
step
    .goto Burning Steppes,85.8,69.0
    .accept 4182 >>接受龙皮威胁
step
    .goto Burning Steppes,87.7,46.1
    .goto Burning Steppes,88.8,37.6
    .goto Burning Steppes,88.3,41.4
    .goto Burning Steppes,88.6,53.4
    .complete 4182,1 --Black Broodling (15)
    .complete 4182,2 --Black Dragonspawn (10)
    .complete 4182,3 --Black Drake (1)
    .complete 4182,4 --Black Wyrmkin (4)
step
    .goto Burning Steppes,85.8,68.9
    .turnin 4182 >>上缴龙皮威胁
    .accept 4183 >>接受真正的大师
step
    .goto Burning Steppes,84.4,68.4
    .fly Lakeshire >>飞往莱克郡
step
    .goto Redridge Mountains,29.8,44.5
    .turnin 4183 >>交上真正的大师赛
    .accept 4184 >>接受真正的大师
step
    .goto Redridge Mountains,30.58,59.41
    .fly Stormwind>>飞到暴风城
step
    .goto StormwindClassic,78.0,18.2
    .turnin 4184 >>交上真正的大师赛
    .accept 4185 >>接受真正的大师
-- .accept 6182 >>接受第一个和最后一个
step
    .goto StormwindClassic,78.11,17.75
    >>与Prestor女士交谈
    .complete 4185,1 --Advice from Lady Prestor (1)
step
    .goto StormwindClassic,78.0,18.2
    .turnin 4185 >>交上真正的大师赛
    .accept 4186 >>接受真正的大师
step << skip
    .goto StormwindClassic,75.9,59.8
    .turnin 6182 >>交第一个和最后一个
    .accept 6183 >>接受尊敬死者
    .turnin 6183 >>向死者致敬
    .accept 6184 >>接受Flint Shadowmore
step
    .goto StormwindClassic,66.2,62.3
    .fly Lakeshire >>飞往莱克郡
step
    .goto Redridge Mountains,29.8,44.5
    .turnin 4186 >>交上真正的大师赛
    .accept 4223 >>接受真正的大师
step
    .goto Redridge Mountains,30.6,59.4
    .fly Morgan's Vigil >>飞往摩根守夜
step
    .goto Burning Steppes,84.6,68.9
    .turnin 4223 >>交上真正的大师赛
step
    .goto Burning Steppes,84.4,68.3
    .fly Southshore >>飞往南岸
step
    .goto Hillsbrad Foothills,51.1,58.9
    .home >>把你的炉石放在南岸
step
    .goto Hillsbrad Foothills,49.4,52.3
    .fly Chillwind Camp >>飞往奇风营地
step
    #completewith mark1
    .goto Western Plaguelands,42.9,84.6,0
    >>与《奇风》中的德莱尼NPC对话
    .accept 9474 >>接受光明使者的标记
    >>任务给予者是长脚本RP序列的一部分，如果你找不到他，请跳过这一步
step
    .goto Western Plaguelands,42.8,84.0
    .accept 5092 >>接受让路
step
    .goto Western Plaguelands,43.4,84.8
    .accept 5903 >>接受你身上的瘟疫
step << skip
    .goto Western Plaguelands,43.7,84.5
    .turnin 6184 >>加入Flint Shadowmore
    .accept 6185 >>接受东部瘟疫
step
    #label mark1
    .goto Western Plaguelands,42.9,85.0
    .fly Light's Hope Chapel >>飞向光明的希望教堂
step
    .goto Eastern Plaguelands,79.5,64.0
    .accept 6021 >>接受被驱逐的扎达尔
    .accept 5281 >>接受不安宁的灵魂
step << Hunter
    #sticky
    .tame 8602 >> 如果你的宠物除了咆哮之外没有其他能力，那么在前往普雷格伍德的路上，抛弃你的宠物并驯服一只58级蝙蝠
    >>买些真菌喂你的新宠物
    .collect 8948,20
    .goto Eastern Plaguelands,79.5,64.0
step
    #sticky
    .abandon 5211 >>如果你有这个任务，放弃达罗郡守卫
step
    .goto Eastern Plaguelands,34.0,28.1
	>>在Plaguewood周围寻找白蚁丘
    .complete 5903,1 --Collect Plagueland Termites (x100)
step
    .goto Eastern Plaguelands,14.5,33.7
    .turnin 5281 >>交回不安宁的灵魂
    .accept 5282 >>接受不安宁的灵魂
step
    #completewith next
    .hs >> Hearth到Southshore
step
    .goto Hillsbrad Foothills,49.4,52.3
    .fly Chillwind Camp >>飞往奇风营地
step
    #completewith tower
    .goto Western Plaguelands,42.9,84.6,0
    >>与《奇风》中的德莱尼NPC对话
    .accept 9474 >>接受光明使者的标记
    >>任务给予者是一个长脚本RP序列的一部分，如果他不在奇风，只要在你通过区域进行任务时注意它即可
step
    .goto Western Plaguelands,50.4,76.4
    .complete 5092,2 --Slavering Ghoul (10)
    .complete 5092,1 --Skeletal Flayer (10)
step
    .goto Western Plaguelands,49.19,78.64
    >>与房子里的玛琳·雷德帕斯交谈
    .accept 5142 >>接受小帕梅拉
step
    .goto Western Plaguelands,42.8,84.0
    .turnin 5092 >>转弯让路
    .accept 5097 >>沿望塔全部接受
    .accept 5215 >>接受天灾大锅
step
    .goto Western Plaguelands,43.0,84.6
    .turnin 5215 >>交出天灾大锅
    .accept 5216 >>接受目标：Felstone油田
step
    .goto Western Plaguelands,43.4,84.8
    .turnin 5903 >>向你倾诉瘟疫
    .accept 5904 >>接受你身上的瘟疫
step
    .goto Western Plaguelands,40.0,71.8
	>>在塔楼门口的袋子里使用信标火炬
    .complete 5097,1 --Tower One marked (1)
step
    .goto Western Plaguelands,37.1,56.9
    >>杀死釜主，抢夺釜钥匙
    .turnin 5216 >>转入目标：Felstone油田
    .accept 5217 >>接受返回奇风营地
step
    .goto Western Plaguelands,42.3,66.2
	>>在塔楼门口的袋子里使用信标火炬
    .complete 5097,2 --Tower Two marked (1)
step
    .goto Western Plaguelands,43.0,84.4
    .turnin 5217 >>返回奇风营地
    .accept 5219 >>接受目标：Dalson的眼泪
step
    .goto Western Plaguelands,46.7,71.0
	>>在塔楼门口的袋子里使用信标火炬
    .complete 5097,4 --Tower Four marked (1)
step
    .goto Western Plaguelands,53.7,64.7
    .accept 4984 >>接受野生动物的痛苦
step
	#completewith Businessman
    .goto Western Plaguelands,46.0,47.7,0
	>>病狼与腐烂潜伏者分享产卵。如果你找不到狼，也杀了他们。
    .complete 4984,1 --Kill Diseased Wolf (x8)
	.unitscan Diseased Wolf
step
    .goto Western Plaguelands,47.8,50.8
	>>点击谷仓内的日记
    .turnin 5058 >> 交上Dalson夫人日记
step
	#completewith DalsonsT
    .goto Western Plaguelands,46.9,51.5,0
	>>寻找在农舍周围巡逻的流浪骷髅
    .collect 12738,1 --Collect Dalson Outhouse Key (x1)
	.unitscan Wandering Skeleton
step
    .goto Western Plaguelands,46.0,52.4
    .complete 5219,1 --Collect Dalson's Tears Cauldron Key (x1)
step
	#label DalsonsT
    .goto Western Plaguelands,46.2,52.1
    .turnin 5219 >> 上缴目标：Dalson的眼泪
    .accept 5220 >> 接受返回奇风营地
step
    .goto Western Plaguelands,46.9,51.5
	>>寻找在农舍周围巡逻的流浪骷髅
    .collect 12738,1 --Collect Dalson Outhouse Key (x1)
	.unitscan Wandering Skeleton
step
	#completewith next
    .goto Western Plaguelands,48.2,49.7
	>>在睡觉前确保身体健康
    .turnin 5059 >> 转入锁定状态
step
    .goto Western Plaguelands,48.2,49.7
	>>杀死Farmer Dalson。抢他的钥匙
    .collect 12739,1 --Collect Dalson Cabinet Key (x1)
step
    .goto Western Plaguelands,47.4,49.7
	>>点击农舍顶层的橱柜
    .turnin 5060 >> 转入锁定状态
step
    .goto Western Plaguelands,48.4,31.9
    .turnin 5904 >>向你倾诉瘟疫
    .accept 6389 >>接受你身上的瘟疫
step
    .goto Western Plaguelands,51.9,28.1
    .accept 6004 >>接受未完成的业务
step
    .goto Western Plaguelands,52.0,44.3,70,0
    .goto Western Plaguelands,50.3,41.1,70,0
    .goto Western Plaguelands,40.7,52.2,70,0
    .goto Western Plaguelands,50.3,41.1,70,0
    .goto Western Plaguelands,52.0,44.3
	>>杀死血腥暴徒。如果你找不到医护人员和猎人，在营地杀死暴徒，迫使他们重生，因为他们与其他暴徒类型共享重生
	>>如果你找不到法师，杀死骑士（因为他们共享后代）
    .complete 6004,1 --Scarlet Medic (2)
    .complete 6004,2 --Scarlet Hunter (2)
    .complete 6004,3 --Scarlet Mage (2)
    .complete 6004,4 --Scarlet Knight (2)
step
    .goto Western Plaguelands,51.9,28.1
    .turnin 6004 >>移交未完成的业务
    .accept 6023 >>接受未完成的业务
step
	#label Businessman
    .goto Western Plaguelands,55.1,23.5
    >>寻找在塔楼上下巡逻的指定暴徒
    .complete 6023,2 --Kill Cavalier Durgen (x1)
    *There is a level 63 elite mob that can spawn at the tower, if that's the case just be patient and wait for Durgen to come down
	.unitscan Cavalier Durgen
step
    #label tower
    .goto Western Plaguelands,55.1,23.5
    >>抢劫塔顶的箱子，如果63级稀有精英挡道，请跳过此步骤
    .complete 9474,1 --Collect Mark of the Lightbringer (x1)
    .isOnQuest 9474
step
    .goto Western Plaguelands,57.5,35.2
    .complete 6023,1 --Huntsman Radley (1)
step
    .goto Western Plaguelands,52.0,28.1
    .turnin 6023 >>移交未完成的业务
    .accept 6025 >>接受未完成的业务
step
	>>跑到Hearthglen的塔顶
    .goto Western Plaguelands,45.6,18.6
    .complete 6025,1 --Overlook Hearthglen from a high vantage point (1)
step
    .goto Western Plaguelands,52.0,28.1
    .turnin 6025 >>移交未完成的业务
step
    .goto Western Plaguelands,51.2,53.3,70,0
    .goto Western Plaguelands,46.9,47.0,70,0
    .goto Western Plaguelands,50.4,35.0,70,0
    .goto Western Plaguelands,45.6,37.7,70,0
    .goto Western Plaguelands,42.8,56.7,70,0
    .goto Western Plaguelands,51.2,53.3
	>>病狼与腐烂潜伏者分享产卵。如果你找不到狼，也杀了他们。
    .complete 4984,1 --Kill Diseased Wolf (x8)
	.unitscan Diseased Wolf
step
    .goto Western Plaguelands,44.3,63.2
	>>在塔楼门口的袋子里使用信标火炬
    .complete 5097,3 --Tower Three marked (1)
step
    .goto Western Plaguelands,42.7,84.1
    .turnin 5097 >>沿望塔全部上缴
    .accept 5533 >>接受学校教育
step
    .goto Western Plaguelands,42.69,83.90
    .turnin 5533 >>交学费
    .accept 5537 >>接受骨骼碎片
step
    .goto Western Plaguelands,42.94,84.42
    .turnin 5220 >>返回奇风营地
    .accept 5222 >>接受目标：旋转幽灵
step
    .goto Western Plaguelands,42.94,84.42
    .turnin 9474 >>交出光明使者的标记
    .isQuestComplete 9474
step
    .goto Western Plaguelands,43.5,84.9
    .turnin 6389 >>向你倾诉瘟疫
step
    .goto Western Plaguelands,39.4,66.9
    .accept 4971 >>接受时间问题
step
    #completewith next
    >>在安多哈尔杀死骷髅。抢劫他们的碎片
    .goto Western Plaguelands,42.10,69.98,0
    .complete 5537,1 --Skeletal Fragments (15)
step
	>>使用Andorhal中发光筒仓旁边的临时置换器。杀死产卵的暂时寄生虫
    .goto Western Plaguelands,48.2,66.5
    .complete 4971,1 --Temporal Parasite (10)
step
    >>在安多哈尔杀死骷髅。抢劫他们的碎片
    .goto Western Plaguelands,42.10,69.98
    .complete 5537,1 --Skeletal Fragments (15)
step
    .goto Western Plaguelands,53.0,65.8
    .turnin 5222 >>上缴目标：恶作剧
    .accept 5223 >>接受返回奇风营地
step
    .goto Western Plaguelands,53.7,64.7
    .turnin 4984 >>交出野生动物的痛苦
    .accept 4985 >>接受野生动物的痛苦
step
    .goto Western Plaguelands,53.9,51.3
	>>患病灰熊与瘟疫潜伏者共享产卵。如果你找不到灰熊，也杀了他们。
    .complete 4985,1 --Diseased Grizzly (8)
	.unitscan Diseased Grizzly
step
    .goto Western Plaguelands,53.7,64.7
    .turnin 4985 >>交出野生动物的痛苦
    .accept 4986 >>接受雕纹Oaken Branch << !Shaman !Warlock !Paladin
step
    .goto Western Plaguelands,42.9,84.5
    .turnin 5223 >>返回奇风营地
    .accept 5225 >>接受目标：加伦的枯萎
step
    .goto Western Plaguelands,62.6,58.7
    .turnin 5225 >>上缴目标：Gahrron的枯萎
    .accept 5226 >>接受返回奇风营地
step
	>>去地下室的底部
    .goto Eastern Plaguelands,27.3,85.3
    .complete 6021,1 --Zaeldarr's Head (1)
step << skip
    .goto Eastern Plaguelands,28.8,79.8
	>>单击地面上的骨架。抢走徽章
    .complete 6185,2 --SI:7 Insignia (Rutger) (1)
step << skip
    .goto Eastern Plaguelands,28.8,74.9
	>>单击地面上的骨架。抢走徽章
    .complete 6185,4 --SI:7 Insignia (Turyen) (1)
step << skip
    .goto Eastern Plaguelands,27.2,75.0
	>>单击地面上的骨架。抢走徽章
    .complete 6185,3 --SI:7 Insignia (Fredo) (1)
    .complete 6185,1 --The Blightcaller Uncovered (1)
step
    .goto Eastern Plaguelands,36.5,90.9
    .turnin 5142 >>交给小帕梅拉
    .accept 5149 >>接受帕梅拉的玩偶
step
	#completewith next
    .goto Eastern Plaguelands,38.14,92.43,20,0
    .goto Eastern Plaguelands,39.61,92.60,20,0
    .goto Eastern Plaguelands,39.60,90.00
    >>抢劫达罗郡建筑物周围的3个玩偶部件。每次尝试抢劫时，都会生成一个鬼魂
	.collect 12886,1
	.collect 12887,1
	.collect 12888,1
step
    .goto Eastern Plaguelands,36.4,90.8
    >>点击任意一个玩偶部件，将其组合在一起
    .complete 5149,1 --Pamela's Doll (1)
step
    .goto Eastern Plaguelands,36.4,90.8
    .turnin 5149 >>交上帕梅拉的玩偶
    .accept 5152 >>接受玛琳阿姨
    .accept 5241 >>接受卡林叔叔
step
    #completewith next
    .hs >> Hearth到Southshore
step
    .goto Eastern Plaguelands,81.6,59.3
    .fly Chillwind Camp >>飞往奇风营地
step
    .goto Western Plaguelands,42.9,84.5
    .turnin 5226 >>返回奇风营地
step
    .goto Western Plaguelands,42.7,84.1
    .turnin 5237 >>交任务完成！
step
    .goto Western Plaguelands,42.7,83.8
    .turnin 5537 >>交出骨骼碎片
step << skip
    .goto Western Plaguelands,43.6,84.4
    .turnin 6185 >>东部瘟疫爆发
    .accept 6186 >>接受Blightcaller Cometh
step
    .goto Western Plaguelands,49.1,78.5
    .turnin 5152 >>交给玛琳阿姨
    .accept 5153 >>接受一位奇怪的历史学家
step
    .goto Western Plaguelands,49.6,76.7
	>>盗取房子外面的墓碑
    .complete 5153,1 --Joseph's Wedding Ring (1)
step
    .goto Western Plaguelands,39.46,66.90
    .turnin 4971 >>交上来只是时间问题
    .accept 4972 >>接受倒计时时间
    .turnin 5153 >>交一位奇怪的历史学家
    .accept 5154 >>接受《达罗郡年鉴》
step
    #completewith next
    .goto Western Plaguelands,40.4,66.5,0
    >>在被烧毁的房子里寻找小锁盒。每间房子应该有一个
    .complete 4972,1 --Andorhal Watch (5)
step
    .goto Western Plaguelands,43.4,69.6
	>>在安多哈尔市政厅内抢劫书籍，直到找到正确的书籍
    .complete 5154,1 --Collect Annals of Darrowshire (x1)
	*The correct book's pages has a lighter shade of grey and sometimes the correct book won't spawn
	*If you're unlucky, you have to keep looting bad tomes until a good one spawns
step
    .goto Western Plaguelands,40.4,66.5
    >>在被烧毁的房子里寻找小锁盒。每间房子应该有一个
    .complete 4972,1 --Andorhal Watch (5)
step
    .goto Western Plaguelands,39.45,66.88
    .turnin 4972 >>转入倒计时时间
    .turnin 5154 >>上交《达罗郡年鉴》
    .accept 5210 >>接受卡林兄弟
step
    .goto Western Plaguelands,42.9,85.0
    .fly Light's Hope Chapel >>飞向光明的希望教堂
step
    .goto Eastern Plaguelands,81.51,59.81
    >>与Carlin Redpath交谈
    .turnin 5241 >>交给卡林叔叔
    .turnin 5210 >>交给卡林兄弟
    .accept 5181 >>接受达罗郡的恶棍
step
    .goto Eastern Plaguelands,79.7,63.7
    .turnin 6021 >> 交给被放逐的扎尔达尔
step
    #completewith next
    .goto Eastern Plaguelands,51.41,49.70
    .xp 60-8750 >> 研磨xp直到距离60级8750xp
step
    >>如果你还需要xp，那么做达罗郡的恶棍
    .complete 5181,1 --Skull of Horgus (1)
    .goto Eastern Plaguelands,51.41,49.70
    .complete 5181,2 --Shattered Sword of Marduk (1)
    .goto Eastern Plaguelands,53.90,65.71
    .turnin 5181 >>移交达罗郡的恶棍
    .goto Eastern Plaguelands,81.52,59.87
step
    .goto Eastern Plaguelands,81.64,59.28
    .fly Stormwind >>飞到暴风城
step << skip
    .goto StormwindClassic,77.9,18.2
    .turnin 6186 >>交出《闪电客来了》
]])
