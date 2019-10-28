-- See: http://wow.curseforge.com/addons/xloot/localization/ to create or fix translations
local locales = {
	enUS = {
		Core = {
			panel_title = "全局设置",
			details = "皮肤应用于所有xloot模块。大多数其他设置当前需要输入 /reload \n如果要关闭单个模块，请像禁用任何普通插件一样禁用它.",
			skin = "皮肤",
			skin_desc = "选择要使用的皮肤。包括Masque皮肤",
			skin_anchors = "应用于锚点",
			skin_anchors_desc = "应用于锚点",
			module_header = "模块选项",
		},
		Frame = {
			panel_title = "拾取框架",
			panel_desc = "提供一个可调整的战利品框架",
			-- Group labels
			frame_options = "框架设置",
			slot_options = "拾取槽",
			link_button = "链接按钮",
			autolooting = "自动拾取",
			colors = "颜色",

			-- Option labels
			autoloot_currency = "自动拾取货币",
			autoloot_currency_desc = "何时自动拾取货币",
			autoloot_quest = "自动拾取任务物品",
			autoloot_quest_desc = "何时自动拾取任务物品",
			autoloot_tradegoods = "自动拾取商品",
			autoloot_tradegoods_desc = "何时自动拾取任何商品类型的物品",
			autoloot_all = "自动拾取任何物品",
			autoloot_list = "自动拾取列表中的物品",
			autoloot_list_desc = "何时自动拾取列表中的物品",
			autoloot_item_list = "物品列表",
			-- frame_scale = "Frame scale",
			-- frame_alpha = "Frame alpha",
			frame_color_border = "框架边框颜色",
			frame_color_backdrop = "框架背景颜色",
			frame_color_gradient = "框架渐变颜色",
			frame_width_automatic = "自动展开框架",
			frame_width = "框架宽度",
			old_close_button = "使用旧的关闭按钮",
			loot_highlight = "鼠标悬停时高亮插槽",
			-- loot_alpha = "Slot alpha",
			loot_color_border = "拾取边框颜色",
			loot_color_backdrop = "拾取背景颜色",
			loot_color_gradient = "拾取渐变颜色",
			loot_color_info = "信息文本颜色",
			loot_collapse = "折叠拾取过的插槽",
			loot_icon_size = "拾取图标大小",
			loot_row_height = "拾取行高度",
			quality_color_frame = "由最高品质着色框架边框",
			quality_color_slot = "由品质着色拾取边框",
			loot_texts_info = "显示详细信息",
			loot_texts_bind = "显示拾绑类型",
			loot_texts_lock = "显示锁定的状态",
			loot_buttons_auto = "自动拾取快捷方式",
			loot_buttons_auto_desc = "一个按钮，添加任何物品到您的自动拾取名单（见下文）\n仅在物品什么时候会被自动拾取时显示",
			font_size_info = "拾取信息",
			font_size_bottombuttons = "链接/关闭",
			frame_snap = "框架跟随鼠标",
			frame_snap_offset_x = "水平捕捉偏移",
			frame_snap_offset_y = "垂直捕捉偏移",
			frame_grow_upwards = "向上展开框架",
			frame_draggable = "可拖动拾取框架",
			linkall_threshold = "聊天链接最低品质",
			linkall_channel = "默认链接频道",
			linkall_show = "链接按钮可见性",

			autolooting_text = "XLoot的自动拾取功能独立于默认系统的'自动拾取'. 因此，如果两者都启用，则可能会收到“该对象正忙”之类的警告..建议只启用一个自动拾取",

			autolooting_list = "自动拾取指定物品.请在下方输入\n  例如: 亚麻布,破烂的毛皮,铜矿",

			autolooting_details = "XLoot当决定拾取一槽时将选择最高设置. 例如，单人时自动拾取所有东西，但在一个团队中只拾取物品和金钱。",

			show_slot_errors = "聊天框显示拾取错误",
			show_slot_errors_details = "当战利品由于某种原因无法显示时，打印聊天信息。其中大部分应该可以被安全地忽略.",
		},
		Group = {
			panel_title = "队伍拾取",
			-- Group labels
			anchors = "锚点",
			rolls = "Roll(骰子)框架",
			other_frames = "其他框架",
			roll_tracking = "Roll点显示设置",
			alerts = "拾取警报",
			extra_info = "额外信息",

			-- Header labels
			expiration = "过期（秒）",

			-- Option labels
			text_outline = "轮廓文字",
			text_outline_desc = "在Roll框上的文本周围绘制深色轮廓",
			text_time = "显示剩余时间",
			text_time_desc = "显示Roll物品图标的剩余秒数",
			text_ilvl = "显示物品等级",
			role_icon = "显示角色图标",
			win_icon = "显示获胜者类型图标",
			show_decided = "显示已决定的",
			show_undecided = "列出还未决定的玩家",
			show_undecided_desc = "列出没有选择如何掷骰子的玩家",
			hook_alert = "战利品警报",
			hook_alert_desc = "(弹出'你胜利..')\n在可移动的锚上附加战利品警报.\n\n禁用此选项可以提高与其他战利品插件的兼容性. \n\n(需要重载)",
			alert_skin = "战利品警戒框着肤",
			alert_offset = "垂直间距",
			alert_background = "显示背景",
			alert_icon_frame = "显示图标框",
			hook_bonus = "战利品Roll点框",
			hook_bonus_desc = "在可移动的锚上附加额外的战利品Roll点框.\n\n禁用此选项可以提高与其他战利品插件的兼容性. \n\n(需要重载)",
			bonus_skin = "战利品Roll点框着肤",
			roll_width = "Roll点框宽度",
			roll_button_size = "Roll按钮大小",
			roll_anchor_visible = "解锁",
			alert_anchor_visible = "战利品警报锚点可见",
			alert_anchor_visible_desc = "指的是“你赢了…”弹窗",
			track_all = "监视所有Roll点",
			track_player_roll = "只监视你Roll的物品",
			track_by_threshold = "按最低质量监视物品",
			expire_won = "胜利Roll点",
			expire_lost = "失去/放弃Roll点",
			preview_show = "显示预览",
			equip_prefix = "显示可装备前缀",
			equip_prefix_desc = "在物品名称前面加上前缀，表示物品是否可以装备或升级. (升级前缀需要Pawn插件)",
			prefix_equippable = "可装备前缀",
			prefix_upgrade = "升级前缀",

			hook_warning_text = "战利品警报和掷骰框很少被报告会导致诸如看不到奖励掷骰之类的问题.\n\n通过启用这些选项，您承认您理解并接受该风险.\n",
		},
		Monitor = {
			panel_title = "战利品监视器",
			-- Group labels
			testing = "测试",
			anchor = "锚点",
			thresholds = "品质阈值",
			fading = "衰落时间（以秒为单位）",
			details = "细节",
			-- Option labels
			test_settings = "点击测试",
			visible = "解锁",
			show_crafted = "制作物",
			show_totals = "显示背包中的总物品数",
			use_altoholic = "包括银行 (小号)",
			show_ilvl = "显示物品等级",
			name_width = "玩家姓名宽度",
		},
		Master = {
			panel_title = "战利品管理",
			-- Group labels
			specialrecipients = "特殊接受人菜单",
			raidroll = "特殊Roll点菜单",
			awardannounce = "通告物品分发",
			-- Option labels
			confirm_qualitythreshold = "最低确认质量",
			menu_roll = "显示团队roll点",
			menu_disenchant = "显示团队分解者",
 			menu_disenchanters = "团队分解者名字",
			menu_bank = "显示团队银行角色",
			menu_bankers = "团队银行角色名字",
			menu_self = "显示自己",
			award_qualitythreshold = "最低通告质量",
			award_channel = "默认通告频道",
			award_guildannounce = "公会频道通告",
			award_special = "通告特殊收件人",
		},
		font = "字体",
		font_sizes = "大小",
		font_size_loot = "拾取",
		font_size_quantity = "数量",
		font_flag = "标志",
		desc_channel_auto = "最高可用",
		growth_direction = "增长方向",
		alignment = "对齐",
		scale = "大小",
		width = "宽度",
		alpha = "透明度",
		spacing = "间距",
		offset = "偏移",
		visible = "可见",
		padding = "填充",
		items_others = "其他人的物品",
		items_own = "自己的物品",
		up = "上",
		down = "下",
		left = "左",
		right = "右",
		top = "顶部",
		bottom = "底部",
		minimum_quality = "最低质",
		when_never = "从不",
		when_solo = "单人",
		when_always = "总是",
		when_auto = "自动",
		when_group = "队伍中",
		when_party = "队伍/团队中",
		when_raid = "团队中",
		confirm_reset_profile = "T这将重置此配置文件的所有选项。你确定吗？",
		profile = "配置",
		message_reloadui_warning = "|c2244dd22%s|r: Changing |c2244dd22%s|r requires you to reload your UI before continuing to play: |c2244dd22/reload ui|r",
	},
	-- Possibly localized
	ptBR = {

	},
	frFR = {

	},
	deDE = {

	},
	koKR = {

	},
	esMX = {

	},
	ruRU = {

	},
	zhCN = {

	},
	esES = {

	},
	zhTW = {

	},
}

-- Automatically inserted translations
locales.ptBR["Options"] = {
}

locales.frFR["Options"] = {
}

locales.deDE["Options"] = {
	["alpha"] = "Transparenz",
	["confirm_reset_profile"] = "Dies wird alle Einstellungen für dieses Profil auf den Standard zurücksetzen. Bist du sicher?",
	["desc_channel_auto"] = "Höchste Verfügbare",
	["down"] = "Ab",
	["font"] = "Schriftart",
	["font_size_loot"] = "Beute",
	["font_size_quantity"] = "Menge",
	["font_sizes"] = "Größen",
	["growth_direction"] = "Wachstumsrichtung",
	["items_others"] = "Gegenstand anderer",
	["items_own"] = "Eigene Gegenstände",
	["minimum_quality"] = "Minimale Qualität",
	["profile"] = "Profil",
	["scale"] = "Skalierung",
	["up"] = "Hoch",
	["visible"] = "Sichtbar",
	["when_always"] = "Immer",
	["when_auto"] = "Automatisch",
	["when_group"] = "In Gruppe",
	["when_never"] = "Niemals",
	["when_party"] = "In Gruppen",
	["when_raid"] = "In Schlachtzügen",
	["when_solo"] = "Solo",
	["width"] = "Breite",
}

locales.koKR["Options"] = {
	["alpha"] = "투명도",
	["confirm_reset_profile"] = "이 프로필에 대한 모든 옵션을 초기화합니다. 계속할까요?",
	["down"] = "아래",
	["font"] = "글꼴",
	["font_flag"] = "속성",
	["font_size_loot"] = "전리품",
	["font_size_quantity"] = "수량",
	["font_sizes"] = "크기",
	["growth_direction"] = "확장 방향",
	["items_others"] = "기타 아이템",
	["items_own"] = "자기 아이템",
	["minimum_quality"] = "최소 품질",
	["profile"] = "프로필",
	["scale"] = "크기 비율",
	["up"] = "위",
	["visible"] = "보기",
	["when_always"] = "항상",
	["when_auto"] = "자동",
	["when_group"] = "그룹에서",
	["when_never"] = "안 함",
	["when_party"] = "파티에서",
	["when_raid"] = "공격대에서",
	["when_solo"] = "혼자일 때",
	["width"] = "너비",
}

locales.esMX["Options"] = {
}

locales.ruRU["Options"] = {
	["alpha"] = "Прозрачность",
	["bottom"] = "Внизу",
	["confirm_reset_profile"] = "Это сбросит все параметры этого профиля. Вы уверены?",
	["desc_channel_auto"] = "Наивысший из доступных",
	["down"] = "Вниз",
	["font"] = "Шрифт ",
	["font_flag"] = "Флажок",
	["font_size_loot"] = "Добыча ",
	["font_size_quantity"] = "Количество ",
	["font_sizes"] = "Размеры ",
	["growth_direction"] = "Добавлять новые строки",
	["items_others"] = "Остальные вещи",
	["items_own"] = "Ваши вещи",
	["minimum_quality"] = "Минимальное качество",
	["padding"] = "Заполнение",
	["profile"] = "Профиль",
	["scale"] = "Масштаб",
	["top"] = "Вверх",
	["up"] = "Вверх",
	["visible"] = "Видимый",
	["when_always"] = "Всегда",
	["when_auto"] = "Автоматически",
	["when_group"] = "В группе ",
	["when_never"] = "Никогда",
	["when_party"] = "В группе ",
	["when_raid"] = "В рейде ",
	["when_solo"] = "Соло",
	["width"] = "Ширина",
}

locales.zhCN["Options"] = {
	["alpha"] = "透明度",
	["confirm_reset_profile"] = "这将重置此配置文件的全部选项。确定？",
	["desc_channel_auto"] = "最高可得",
	["down"] = "下",
	["font"] = "字体",
	["font_flag"] = "轮廓",
	["font_size_loot"] = "战利品",
	["font_size_quantity"] = "品质",
	["font_sizes"] = "大小",
	["growth_direction"] = "扩展方向",
	["items_others"] = "其他人的物品",
	["items_own"] = "自己的物品",
	["minimum_quality"] = "最低品质",
	["profile"] = "配置文件",
	["scale"] = "比例",
	["up"] = "上",
	["visible"] = "可见",
	["when_always"] = "总是",
	["when_auto"] = "自动",
	["when_group"] = "在队伍/团队中",
	["when_never"] = "从不",
	["when_party"] = "在队伍中",
	["when_raid"] = "在团队中",
	["when_solo"] = "单人",
	["width"] = "宽度",
}

locales.esES["Options"] = {
	["confirm_reset_profile"] = "Esto reseteará todas las opciones de este perfil. ¿Estás seguro?",
	["font"] = "Fuente",
	["font_size_loot"] = "Botín",
	["font_size_quantity"] = "Cantidad",
	["font_sizes"] = "Tamaños",
	["profile"] = "Perfil",
	["when_always"] = "Siempre",
	["when_auto"] = "Automático",
	["when_never"] = "Nunca",
	["when_solo"] = "Solo",
}

locales.zhTW["Options"] = {
	["alpha"] = "透明度",
	["confirm_reset_profile"] = "將會重置此設定檔的所有設定。你確定要重置嗎？",
	["desc_channel_auto"] = "最高可得",
	["down"] = "下",
	["font"] = "字型",
	["font_flag"] = "標示",
	["font_size_loot"] = "戰利品",
	["font_size_quantity"] = "品質",
	["font_sizes"] = "大小",
	["growth_direction"] = "擴展方向",
	["items_others"] = "他人物品",
	["items_own"] = "自己物品",
	["minimum_quality"] = "最低品質",
	["profile"] = "設定檔",
	["scale"] = "比例",
	["up"] = "上",
	["visible"] = "可見",
	["when_always"] = "總是",
	["when_auto"] = "自動",
	["when_group"] = "隊伍/團隊中",
	["when_never"] = "從不",
	["when_party"] = "隊伍中",
	["when_raid"] = "團隊中",
	["when_solo"] = "單人",
	["width"] = "寬度",
}


-- Manually express subtables because apparently I'm the only one who thought to use namespaces the simple way

locales.ptBR["Core"] = {
}

locales.frFR["Core"] = {
}

locales.deDE["Core"] = {
	["anchor_hide"] = "verstecken",
	["skin_legacy"] = "XLoot: Legacy",
	["skin_smooth"] = "XLoot: Smooth",
	["skin_svelte"] = "XLoot: Svelte",
}

locales.koKR["Core"] = {
	["anchor_hide"] = "감춤",
	["anchor_hide_desc"] = [=[이 모듈을 제 위치에 잠급니다.
이는 표시기를 숨기지만,
옵션에서 다시 표시할 수 있습니다.]=],
	["skin_legacy"] = "XLoot: Legacy",
	["skin_smooth"] = "XLoot: Smooth",
	["skin_svelte"] = "XLoot: Svelte",
}

locales.esMX["Core"] = {
}

locales.ruRU["Core"] = {
	["anchor_hide"] = "скрыть ",
	["anchor_hide_desc"] = [=[Заблокируйте положение этого модуля
Это позволит скрыть якорь,
но он может быть показан еще раз в настройках]=],
	["skin_legacy"] = "XLoot: Legacy",
	["skin_smooth"] = "XLoot: Smooth",
	["skin_svelte"] = "XLoot: Svelte",
}

locales.zhCN["Core"] = {
	["anchor_hide"] = "隐藏",
	["anchor_hide_desc"] = [=[在此位置锁定此模块
这将隐藏锚点
但可通过选项重新显示]=],
	["skin_legacy"] = "XLoot: Legacy",
	["skin_smooth"] = "XLoot: Smooth",
	["skin_svelte"] = "XLoot: Svelte",
}

locales.esES["Core"] = {
}

locales.zhTW["Core"] = {
	["anchor_hide"] = "隱藏",
	["anchor_hide_desc"] = [=[鎖定此模組在此位置上
這會隱藏此錨點,
但它可以藉由選項再次顯示]=],
	["skin_legacy"] = "XLoot: 傳統",
	["skin_smooth"] = "XLoot: 滑順",
	["skin_svelte"] = "XLoot: 苗條",
}


locales.ptBR["Frame"] = {
}

locales.frFR["Frame"] = {
	["bind_on_equip_short"] = "LqE",
	["bind_on_pickup_short"] = "LqR",
	["bind_on_use_short"] = "LqU",
	["button_close"] = "Fermer",
	["button_link"] = "Lien",
	["linkall_threshold_missed"] = "Aucun butin ne correspond à votre seuil de qualité",
}

locales.deDE["Frame"] = {
	["bind_on_equip_short"] = "BoE",
	["bind_on_pickup_short"] = "BoP",
	["bind_on_use_short"] = "BoU",
	["button_close"] = "Schließen",
	["button_link"] = "Senden",
	["linkall_threshold_missed"] = "Beute entspricht nicht deinen Qualitätsansprüchen",
}

locales.koKR["Frame"] = {
	["bind_on_equip_short"] = "착귀",
	["bind_on_pickup_short"] = "획귀",
	["bind_on_use_short"] = "사귀",
	["button_close"] = "닫기",
	["button_link"] = "링크",
	["linkall_threshold_missed"] = "당신의 품질 기준을 만족하는 전리품 없음",
}

locales.esMX["Frame"] = {
}

locales.ruRU["Frame"] = {
	["bind_on_equip_short"] = "БоЕ",
	["bind_on_pickup_short"] = "БоП",
	["bind_on_use_short"] = "Становится персональным при использовании",
	["button_close"] = "Закрыть",
	["button_link"] = "Ссылка",
	["linkall_threshold_missed"] = "Нет добычи, удовлетворяющей установленному порогу качества",
}

locales.zhCN["Frame"] = {
	["bind_on_equip_short"] = "装备后绑定",
	["bind_on_pickup_short"] = "拾取后绑定",
	["bind_on_use_short"] = "使用后绑定",
	["button_close"] = "关闭",
	["button_link"] = "链接",
	["linkall_threshold_missed"] = "没有达到拾取品质门槛的物品",
}

locales.esES["Frame"] = {
}

locales.zhTW["Frame"] = {
	["bind_on_equip_short"] = "裝綁",
	["bind_on_pickup_short"] = "拾榜",
	["bind_on_use_short"] = "使綁",
	["button_close"] = "關閉",
	["button_link"] = "連結",
	["linkall_threshold_missed"] = "沒有達到品質門檻的戰利品",
}


locales.ptBR["Group"] = {
	["alert_anchor"] = "Aparecer Saques",
}

locales.frFR["Group"] = {
}

locales.deDE["Group"] = {
	["alert_anchor"] = "Beute Popups",
	["anchor"] = "Gruppenwürfe",
	["undecided"] = "Unentschlossen",
}

locales.koKR["Group"] = {
	["alert_anchor"] = "전리품 팝업",
	["anchor"] = "그룹 주사위",
	["undecided"] = "미결정",
}

locales.esMX["Group"] = {
}

locales.ruRU["Group"] = {
	["alert_anchor"] = "Всплывающие фреймы добычи",
	["anchor"] = "Броски группы",
	["undecided"] = "Не принял решения",
}

locales.zhCN["Group"] = {
	["alert_anchor"] = "掷骰弹窗锚点",
	["anchor"] = "团队掷骰锚点",
	["undecided"] = "未决定的",
}

locales.esES["Group"] = {
}

locales.zhTW["Group"] = {
	["alert_anchor"] = "拾取彈出視窗定位",
	["anchor"] = "團體擲骰定位",
	["undecided"] = "未決",
}


locales.ptBR["Monitor"] = {
}

locales.frFR["Monitor"] = {
}

locales.deDE["Monitor"] = {
	["anchor"] = "Beutemonitor",
}

locales.koKR["Monitor"] = {
	["anchor"] = "전리품 모니터",
}

locales.esMX["Monitor"] = {
}

locales.ruRU["Monitor"] = {
	["anchor"] = "Монитор добычи",
}

locales.zhCN["Monitor"] = {
	["anchor"] = "掷骰监控",
}

locales.esES["Monitor"] = {
}

locales.zhTW["Monitor"] = {
	["anchor"] = "拾取監控",
}


locales.ptBR["Master"] = {
}

locales.frFR["Master"] = {
}

locales.deDE["Master"] = {
	["BINDING_BANKER"] = "Setze Bankier",
	["BINDING_DISENCHANTER"] = "Setze Entzauberer",
	["ITEM_AWARDED"] = "%s erhielt: %s",
	["ML_BANKER"] = "Bankier",
	["ML_DISENCHANTER"] = "Entzauberer",
	["ML_RANDOM"] = "Schlachtzugswurf",
	["ML_SELF"] = "Eigenständiges Plündern",
	["RECIPIENTS"] = "Spezieller Empfänger",
	["SPECIALROLLS"] = "Spezielle Würfe",
}

locales.koKR["Master"] = {
	["BINDING_BANKER"] = "은행원 설정",
	["BINDING_DISENCHANTER"] = "마법부여사 설정",
	["ITEM_AWARDED"] = "%s |1을;를; 획득했습니다: %s",
	["ML_BANKER"] = "은행인",
	["ML_DISENCHANTER"] = "마법부여사",
	["ML_RANDOM"] = "공격대 주사위",
	["RECIPIENTS"] = "특별 수령인",
	["SPECIALROLLS"] = "특별 주사위",
}

locales.esMX["Master"] = {
}

locales.ruRU["Master"] = {
	["BINDING_BANKER"] = "Назначить банкира",
	["BINDING_DISENCHANTER"] = "Назначить дизенчантера",
	["ITEM_AWARDED"] = "%s получает: %s",
	["ML_BANKER"] = "Банкир",
	["ML_DISENCHANTER"] = "Дизенчантер",
	["ML_RANDOM"] = "Raid Roll",
	["ML_SELF"] = "Своя добыча",
	["RECIPIENTS"] = "Особые получатели",
	["SPECIALROLLS"] = "Особые броски",
}

locales.zhCN["Master"] = {
	["BINDING_BANKER"] = "设置银行存放者",
	["BINDING_DISENCHANTER"] = "设置附魔分解者",
	["ITEM_AWARDED"] = "%s 获得了： %s",
	["ML_BANKER"] = "银行存放者",
	["ML_DISENCHANTER"] = "附魔分解者",
	["ML_RANDOM"] = "团队掷骰",
	["ML_SELF"] = "自己掷骰",
	["RECIPIENTS"] = "特殊接收者",
	["SPECIALROLLS"] = "特殊掷骰",
}

locales.esES["Master"] = {
}

locales.zhTW["Master"] = {
	["BINDING_BANKER"] = "設定存放銀行者",
	["BINDING_DISENCHANTER"] = "設定附魔分解者",
	["ITEM_AWARDED"] = "%s 給與: %s",
	["ML_BANKER"] = "銀行存放者",
	["ML_DISENCHANTER"] = "附魔分解者",
	["ML_RANDOM"] = "團隊擲骰",
	["ML_SELF"] = "自己拾取",
	["RECIPIENTS"] = "特殊接受者",
	["SPECIALROLLS"] = "特殊擲骰",
}


XLoot:Localize("Options", locales)
