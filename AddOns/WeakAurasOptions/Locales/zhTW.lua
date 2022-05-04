if not WeakAuras.IsCorrectVersion() then return end

if GetLocale() ~= "zhTW" then
  return
end

local L = WeakAuras.L

-- WeakAuras/Options
	L[" and |cFFFF0000mirrored|r"] = "和 |cFFFF0000鏡射|r"
	L["-- Do not remove this comment, it is part of this aura: "] = "-- 不要刪除此註解，這是此提醒效果的一部分: "
	L[" rotated |cFFFF0000%s|r degrees"] = "旋轉 |cFFFF0000%s|r 度"
	L["% of Progress"] = "進度%"
	L["%i auras selected"] = "已選擇 %i 個提醒效果"
	L["%i Matches"] = "%i 個符合"
	L["%s - Option #%i has the key %s. Please choose a different option key."] = "%s - 選項 #%i 已經有 key %s。請選擇另一個不同的選項 key。"
	L["%s %s, Lines: %d, Frequency: %0.2f, Length: %d, Thickness: %d"] = "%s %s, 直線: %d, 頻率: %0.2f, 長度: %d, 粗細: %d"
	L["%s %s, Particles: %d, Frequency: %0.2f, Scale: %0.2f"] = "%s %s, 粒子: %d, 頻率: %0.2f, 縮放大小: %0.2f"
	L["%s Alpha: %d%%"] = "%s透明度: %d%%"
	L["%s Color"] = "%s 顏色"
	L["%s Default Alpha, Zoom, Icon Inset, Aspect Ratio"] = "%s預設透明度, 檢視大小, 圖示內縮, 保持比例"
	L["%s Inset: %d%%"] = "%s內縮: %d%%"
	L["%s is not a valid SubEvent for COMBAT_LOG_EVENT_UNFILTERED"] = "%s 不是 COMBAT_LOG_EVENT_UNFILTERED 的有效 SubEvent"
	L["%s Keep Aspect Ratio"] = "%s保持寬高比例"
	L["%s Texture"] = "%s 材質"
	L["%s total auras"] = "總共 %s 個提醒效果"
	L["%s Zoom: %d%%"] = "%s檢視大小: %d%%"
	L["%s, Border"] = "%s, 邊框"
	L["%s, Offset: %0.2f;%0.2f"] = "%s, 位置偏移: %0.2f;%0.2f"
	L["%s, offset: %0.2f;%0.2f"] = "%s, 位置偏移: %0.2f;%0.2f"
	L["%s|cFFFF0000custom|r texture with |cFFFF0000%s|r blend mode%s%s"] = "%s|cFFFF0000自訂|r材質，|cFFFF0000%s|r混合模式%s%s"
	L["(Right click to rename)"] = "(點一下右鍵重新命名)"
	L["|c%02x%02x%02x%02xCustom Color|r"] = "|c%02x%02x%02x%02x自訂顏色|r"
	L["|cFFE0E000Note:|r This sets the description only on '%s'"] = "|cFFE0E000注意:|r 只會設定 '%s' 的說明"
	L["|cFFE0E000Note:|r This sets the URL on all selected auras"] = "|cFFE0E000注意:|r 這會設定所有選擇提醒效果的 URL"
	L["|cFFE0E000Note:|r This sets the URL on this group and all its members."] = "|cFFE0E000注意:|r 這會設定此群組和所有子成員的 URL"
	L["|cFFFF0000Automatic|r length"] = "|cFFFF0000自動|r長度"
	L["|cFFFF0000default|r texture"] = "|cFFFF0000預設|r材質"
	L["|cFFFF0000desaturated|r "] = "|cFFFF0000去色|r "
	L["|cFFFF0000Note:|r The unit '%s' is not a trackable unit."] = "|cFFFF0000注意:|r 單位 '%s' 不是可以監控的單位。"
	L["|cFFffcc00Anchors:|r Anchored |cFFFF0000%s|r to frame's |cFFFF0000%s|r"] = "|cFFffcc00對齊:|r |cFFFF0000%s|r對齊到框架的|cFFFF0000%s|r"
	L["|cFFffcc00Anchors:|r Anchored |cFFFF0000%s|r to frame's |cFFFF0000%s|r with offset |cFFFF0000%s/%s|r"] = "|cFFffcc00對齊:|r |cFFFF0000%s|r對齊到框架的|cFFFF0000%s|r，偏移|cFFFF0000%s/%s|r"
	L["|cFFffcc00Anchors:|r Anchored to frame's |cFFFF0000%s|r"] = "|cFFffcc00對齊:|r 對齊到框架的|cFFFF0000%s|r"
	L["|cFFffcc00Anchors:|r Anchored to frame's |cFFFF0000%s|r with offset |cFFFF0000%s/%s|r"] = "|cFFffcc00對齊:|r 對齊到框架的|cFFFF0000%s|r，偏移|cFFFF0000%s/%s|r"
	L["|cFFffcc00Extra Options:|r"] = "|cFFffcc00額外選項:|r"
	L["|cFFffcc00Extra:|r %s and %s %s"] = "|cFFffcc00額外:|r %s和%s%s"
	L["|cFFffcc00Font Flags:|r |cFFFF0000%s|r and shadow |c%sColor|r with offset |cFFFF0000%s/%s|r%s%s"] = "|cFFffcc00文字樣式:|r |cFFFF0000%s|r和陰影|c%s顏色|r，偏移|cFFFF0000%s/%s|r%s%s"
	L["|cFFffcc00Font Flags:|r |cFFFF0000%s|r and shadow |c%sColor|r with offset |cFFFF0000%s/%s|r%s%s%s"] = "|cFFffcc00文字樣式:|r |cFFFF0000%s|r和陰影|c%s顏色|r，偏移|cFFFF0000%s/%s|r%s%s%s"
	L["|cFFffcc00Format Options|r"] = "|cFFffcc00格式選項|r"
	L[ [=[• |cff00ff00Player|r, |cff00ff00Target|r, |cff00ff00Focus|r, and |cff00ff00Pet|r correspond directly to those individual unitIDs.
• |cff00ff00Specific Unit|r lets you provide a specific valid unitID to watch.
|cffff0000Note|r: The game will not fire events for all valid unitIDs, making some untrackable by this trigger.
• |cffffff00Party|r, |cffffff00Raid|r, |cffffff00Boss|r, |cffffff00Arena|r, and |cffffff00Nameplate|r can match multiple corresponding unitIDs.
• |cffffff00Smart Group|r adjusts to your current group type, matching just the "player" when solo, "party" units (including "player") in a party or "raid" units in a raid.
• |cffffff00Multi-target|r attempts to use the Combat Log events, rather than unitID, to track affected units.
|cffff0000Note|r: Without a direct relationship to actual unitIDs, results may vary.

|cffffff00*|r Yellow Unit settings can match multiple units and will default to being active even while no affected units are found without a Unit Count or Match Count setting.]=] ] = "|cff00ff00玩家|r，|cff00ff00目標|r，|cff00ff00焦點|r，以及|cff00ff00寵物|r直接對應於那些單獨的單位ID。 •|cff00ff00指定單位|r讓您提供一個特定的有效單位ID來觀看。|cffff0000注意|r：遊戲不會為所有有效的單位ID觸發事件，從而使該觸發器無法跟踪某些事件。•|cffffff00隊伍|r，|cffffff00團隊|r，|cffffff00首領|r，|cffffff00競技場|r，以及|cffffff00名條|r可以匹配多個對應的單位ID。•|cffffff00智能團體|r調整為您當前的隊伍類型，僅匹配單人時的“玩家”、組隊中的“小隊”單位（包括“玩家”）或團隊中的“團隊”單位。• |cffffff00多重目標r嘗試使用戰鬥日誌事件而不是單位ID來追踪受影響的單位。cffff0000注意|r：如果與實際的單位ID沒有直接關係，結果可能會有所不同。 |cffffff00*|r黃色單位設置可以匹配多個單位，並且即使在沒有單位計數或匹配計數設置的情況下找不到受影響的單位時也會預設為活動狀態。"
	L["1 Match"] = "1 個符合"
	L["A 20x20 pixels icon"] = "20x20 大小的圖示"
	L["A 32x32 pixels icon"] = "32x32 大小的圖示"
	L["A 40x40 pixels icon"] = "40x40 大小的圖示"
	L["A 48x48 pixels icon"] = "48x48 大小的圖示"
	L["A 64x64 pixels icon"] = "64x64 大小的圖示"
	L["A group that dynamically controls the positioning of its children"] = "可動態控制子項目位置的群組"
	L[ [=[A timer will automatically be displayed according to default Interface Settings (overridden by some addons).
Enable this setting if you want this timer to be hidden, or when using a WeakAuras text to display the timer]=] ] = "計時器將根據預設界面設置自動顯示（被某些插件覆蓋）。如果您希望隱藏此計時器，或使用Wea​​kAuras文字顯示計時器，請啟用此設置"
	L["A Unit ID (e.g., party1)."] = "單位 ID (例如 party1)。"
	L["Actions"] = "動作"
	L["Add"] = "新增"
	L["Add %s"] = "新增%s"
	L["Add a new display"] = "新增提醒效果"
	L["Add Condition"] = "新增條件"
	L["Add Entry"] = "新增項目"
	L["Add Extra Elements"] = "新增額外元素"
	L["Add Option"] = "新增選項"
	L["Add Overlay"] = "新增疊加圖層"
	L["Add Property Change"] = "新增屬性變化"
	L["Add Raid Mark Information"] = "新增團隊標記資訊"
	L["Add Role Information"] = "新增角色職責資訊"
	L["Add Snippet"] = "新增程式碼片段"
	L["Add Sub Option"] = "新增子選項"
	L["Add to group %s"] = "加入到群組 %s"
	L["Add to new Dynamic Group"] = "加入到新的動態群組"
	L["Add to new Group"] = "加入到新的群組"
	L["Add Trigger"] = "新增觸發"
	L["Additional Events"] = "其他事件"
	L["Advanced"] = "進階"
	L["Align"] = "置中"
	L["Alignment"] = "對齊方式"
	L["All of"] = "全部的"
	L["Allow Full Rotation"] = "允許完整旋轉"
	L["Alpha"] = "透明度"
	L["Anchor"] = "對齊"
	L["Anchor Point"] = "對齊點"
	L["Anchored To"] = "對齊到"
	L["And "] = "和 "
	L["and"] = "和"
	L["and aligned left"] = "和靠左對齊"
	L["and aligned right"] = "和靠右對齊"
	L["and rotated left"] = "和向左旋轉"
	L["and rotated right"] = "和向右旋轉"
	L["and Trigger %s"] = "和觸發 %s"
	L["and with width |cFFFF0000%s|r and %s"] = "、寬度 |cFFFF0000%s|r 和 %s"
	L["Angle"] = "角度"
	L["Animate"] = "閃爍"
	L["Animated Expand and Collapse"] = "展開和收合的動畫效果"
	L["Animates progress changes"] = "進度變化動畫效果"
	L["Animation End"] = "動畫結束"
	L["Animation Mode"] = "動畫模式"
	L["Animation relative duration description"] = [=[動畫的持續時間是相對於提醒效果的持續時間，使用分數 (1/2)、百分比 (50%) 或小數 (0.5) 來表示。
|cFFFF0000特別注意:|r 如果提醒效果沒有進度 (是非時間性的事件觸發，或沒有時間的光環...等)，動畫將不會播放。

|cFF4444FF例如:|r
如果動畫的持續時間設為 |cFF00CC0010%|r，提醒效果的觸發是 20 秒的光環，那麼開始動畫將會播放 2 秒。
如果動畫的持續時間設為 |cFF00CC0010%|r，提醒效果的觸發沒有設定持續時間，將不會播放開始動畫 (儘管你有設定持續時間的秒數)。]=]
	L["Animation Sequence"] = "動畫序列"
	L["Animation Start"] = "動畫開始"
	L["Animations"] = "動畫"
	L["Any of"] = "任何的"
	L["Apply Template"] = "套用範本"
	L["Arcane Orb"] = "祕法光球"
	L["At a position a bit left of Left HUD position."] = "比左方 HUD 更左一點的位置"
	L["At a position a bit left of Right HUD position"] = "比右方 HUD 更右一點的位置"
	L["At the same position as Blizzard's spell alert"] = "和暴雪法術警告效果相同的位置"
	L[ [=[Aura is
Off Screen]=] ] = [=[提醒效果
跑出畫面]=]
	L["Aura Name"] = "光環名稱"
	L["Aura Name Pattern"] = "光環名稱模式 (Pattern)"
	L["Aura Type"] = "光環類型"
	L["Aura(s)"] = "光環"
	L["Author Options"] = "作者選項"
	L["Auto-Clone (Show All Matches)"] = "自動複製 (顯示所有符合的)"
	L["Auto-cloning enabled"] = "自動複製已啟用"
	L["Automatic"] = "自動"
	L["Automatic length"] = "自動長度"
	L["Available Voices are system specific"] = "可用語音為系統指定"
	L["Backdrop Color"] = "背景顏色"
	L["Backdrop in Front"] = "背景在前面"
	L["Backdrop Style"] = "背景類型"
	L["Background"] = "背景"
	L["Background Color"] = "背景顏色"
	L["Background Inner"] = "背景內部"
	L["Background Offset"] = "背景位置"
	L["Background Texture"] = "背景材質"
	L["Bar Alpha"] = "進度條透明度"
	L["Bar Color"] = "進度條顏色"
	L["Bar Color Settings"] = "進度條顏色設定"
	L["Bar Texture"] = "進度條材質"
	L["Big Icon"] = "大圖示"
	L["Blend Mode"] = "混合模式"
	L["Blue Rune"] = "藍色符文"
	L["Blue Sparkle Orb"] = "藍色光球"
	L["Border"] = "邊框"
	L["Border %s"] = "邊框 %s"
	L["Border Anchor"] = "邊框對齊"
	L["Border Color"] = "邊框顏色"
	L["Border in Front"] = "邊框在前面"
	L["Border Inset"] = "邊框內縮"
	L["Border Offset"] = "邊框位置"
	L["Border Settings"] = "邊框設定"
	L["Border Size"] = "邊框大小"
	L["Border Style"] = "邊框樣式"
	L["Bottom"] = "下"
	L["Bottom Left"] = "左下"
	L["Bottom Right"] = "右下"
	L["Bracket Matching"] = "括號配對符合"
	L["Browse Wago, the largest collection of auras."] = "請瀏覽 Wago 網站，有大量的提醒效果。"
	L["Can be a Name or a Unit ID (e.g. party1). A name only works on friendly players in your group."] = "可以是名字或單位 ID (例如 party1)。只有同隊伍中的友方玩家才能使用名字。"
	L["Can be a UID (e.g., party1)."] = "可以是單位 ID (例如 party1) 。"
	L["Can set to 0 if Columns * Width equal File Width"] = "無法設置為0如果欄*寬等同列寬"
	L["Can set to 0 if Rows * Height equal File Height"] = "無法設置為0如果行*高等同列高"
	L["Cancel"] = "取消"
	L["Cast by Player Character"] = "玩家角色施放"
	L["Cast by Players"] = "玩家施放"
	L["Center"] = "中"
	L["Chat Message"] = "聊天訊息文字"
	L["Chat with WeakAuras experts on our Discord server."] = "在我們的 Discord 伺服器和 WeakAuras 專家們聊天。"
	L["Check On..."] = "檢查..."
	L["Check out our wiki for a large collection of examples and snippets."] = "看看我們的 wiki，有大量的範例和程式碼片段。"
	L["Children:"] = "子項目:"
	L["Choose"] = "選擇"
	L["Class"] = "職業"
	L["Clip Overlays"] = "裁剪疊加圖層"
	L["Clipped by Progress"] = "被進度縮減"
	L["Close"] = "關閉"
	L["Collapse"] = "收合"
	L["Collapse all loaded displays"] = "收合所有已載入的提醒效果"
	L["Collapse all non-loaded displays"] = "收合所有未載入的提醒效果"
	L["Collapse all pending Import"] = "收合所有等待匯入的內容"
	L["Collapsible Group"] = "可收合群組"
	L["color"] = "顏色"
	L["Color"] = "顏色"
	L["Column Height"] = "行高度"
	L["Column Space"] = "行間距"
	L["Columns"] = "行"
	L["Combinations"] = "組合"
	L["Combine Matches Per Unit"] = "合併每個單位符合的"
	L["Common Text"] = "普通文字"
	L["Compare against the number of units affected."] = "與受影響的單位數量進行比較。"
	L["Compatibility Options"] = "相容性選項"
	L["Compress"] = "精簡"
	L["Condition %i"] = "條件 %i"
	L["Conditions"] = "條件"
	L["Configure what options appear on this panel."] = "設定這個面板中要出現哪些選項。"
	L["Constant Factor"] = "常數因子"
	L["Control-click to select multiple displays"] = "按住 Ctrl 鍵點擊可選擇多個提醒效果"
	L["Controls the positioning and configuration of multiple displays at the same time"] = "同時控制多個提醒效果的位置和設定"
	L["Convert to New Aura Trigger"] = "轉換成新的光環觸發"
	L["Convert to..."] = "轉換成..."
	L["Copy"] = "複製"
	L["Copy settings..."] = "複製設定..."
	L["Copy to all auras"] = "複製到全部的光環"
	L["Could not parse '%s'. Expected a table."] = "無法分析 '%s'，需要 table。"
	L["Count"] = "數量"
	L["Counts the number of matches over all units."] = "計算所有單位中符合的數量。"
	L["Creating buttons: "] = "建立按鈕: "
	L["Creating options: "] = "建立選項: "
	L["Crop X"] = "裁剪X"
	L["Crop Y"] = "裁剪Y"
	L["Custom"] = "自訂"
	L["Custom Anchor"] = "自訂對齊"
	L["Custom Check"] = "自訂檢查"
	L["Custom Code"] = "自訂程式碼"
	L["Custom Color"] = "自訂顏色"
	L["Custom Configuration"] = "自訂設定選項"
	L["Custom Frames"] = "自訂框架"
	L["Custom Function"] = "自訂函數"
	L["Custom Grow"] = "自訂增長"
	L["Custom Options"] = "自訂選項"
	L["Custom Sort"] = "自訂排序"
	L["Custom Trigger"] = "自訂觸發"
	L["Custom trigger event tooltip"] = [=[選擇自訂觸發要檢查的事件。
可用逗號分隔多個事件。

|cFF4444FF例如:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED]=]
	L["Custom trigger status tooltip"] = [=[選擇自訂觸發要檢查的事件。
因為這是狀態類型的觸發，所指定的事件必須不用加參數就能夠被 WeakAuras 呼叫。
可用逗號分隔多個事件。

|cFF4444FF例如:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED]=]
	L["Custom Untrigger"] = "自訂取消觸發"
	L["Custom Variables"] = "自訂變數"
	L["Debuff Type"] = "減益類型"
	L["Default"] = "預設"
	L["Default Color"] = "減益顏色"
	L["Delete"] = "刪除"
	L["Delete all"] = "全部刪除"
	L["Delete children and group"] = "刪除子項目和群組"
	L["Delete Entry"] = "刪除項目"
	L["Desaturate"] = "去色"
	L["Description"] = "說明"
	L["Description Text"] = "說明文字"
	L["Determines how many entries can be in the table."] = "決定表格中可以有多少項目。"
	L["Differences"] = "差異"
	L["Disabled"] = "停用"
	L["Disallow Entry Reordering"] = "不允許重新排序項目"
	L["Discrete Rotation"] = "分離旋轉"
	L["Display"] = "提醒效果"
	L["Display Name"] = "顯示名稱"
	L["Display Text"] = "提醒效果文字"
	L["Displays a text, works best in combination with other displays"] = "顯示文字，最適合和其他顯示效果一起搭配使用"
	L["Distribute Horizontally"] = "水平分佈"
	L["Distribute Vertically"] = "垂直分佈"
	L["Do not group this display"] = "不要群組這個提醒效果"
	L["Do you want to ignore all future updates for this aura"] = "是否要忽略此提醒效果未來的所有更新"
	L["Documentation"] = "文件"
	L["Done"] = "完成"
	L["Drag to move"] = "滑鼠拖曳來移動"
	L["Duplicate"] = "多複製一份"
	L["Duplicate All"] = "全部多複製一份"
	L["Duration (s)"] = "持續時間 (秒)"
	L["Duration Info"] = "持續時間訊息"
	L["Dynamic Duration"] = "動態持續時間"
	L["Dynamic Group"] = "動態群組"
	L["Dynamic Group Settings"] = "動態群組設定"
	L["Dynamic Information"] = "動態資訊"
	L["Dynamic information from first active trigger"] = "來自最先被觸發的動態資訊"
	L["Dynamic information from Trigger %i"] = "來自觸發 %i 的動態資訊"
	L["Dynamic text tooltip"] = [=[有幾種特別的代碼可以讓文字顯示為動態的:

|cFFFF0000%p|r - 進度 - 剩餘的時間，或是非時間的數值。
|cFFFF0000%t|r - 總共 - 持續時間的最大值，或是非時間的最大值。
|cFFFF0000%n|r - 名稱 - 提醒效果的名稱 (通常是光環的名稱)，沒有動態名稱時會顯示提醒效果的 ID。
|cFFFF0000%i|r - 圖示 - 和這個提醒效果關聯的圖示。
|cFFFF0000%s|r - 堆疊 - 通常是光環的堆疊層數。
|cFFFF0000%c|r - 自訂 - 允許自訂 Lua 函數傳回要顯示的文字字串。]=]
	L["Ease Strength"] = "淡出強度"
	L["Ease type"] = "淡出類型"
	L["Edge"] = "邊緣"
	L["eliding"] = "符合寬度"
	L["Else If"] = "(Else If) 否則，當"
	L["Else If Trigger %s"] = "否則，當觸發 %s"
	L["Enable \"Edge\" part of the overlay"] = "啟用疊層的\"邊緣\"部分"
	L["Enable \"swipe\" part of the overlay"] = "啟用疊層的\"揮打\"部分"
	L["Enable Swipe"] = "啟用揮打"
	L["Enable the \"Swipe\" radial overlay"] = "啟用\"揮打\"徑向疊層"
	L["Enabled"] = "啟用"
	L["End Angle"] = "結束角度"
	L["End of %s"] = "%s 的結尾"
	L["Enter a Spell ID"] = "輸入法術 ID"
	L["Enter an aura name, partial aura name, or spell id"] = "輸入光環名稱、光環部分名稱，或是法術 ID"
	L["Enter an Aura Name, partial Aura Name, or Spell ID. A Spell ID will match any spells with the same name."] = "輸入光環名稱、光環部分名稱，或是法術 ID。法術 ID 會找出名稱相同的任何法術。"
	L["Enter Author Mode"] = "進入作者模式"
	L["Enter in a value for the tick's placement."] = "輸入每次進度指示位置的數值。"
	L["Enter User Mode"] = "進入使用者模式"
	L["Enter user mode."] = "進入使用者模式。"
	L["Entry %i"] = "項目 %i"
	L["Entry limit"] = "項目限制"
	L["Entry Name Source"] = "項目名稱來源"
	L["Event Type"] = "事件類型"
	L["Event(s)"] = "事件"
	L["Everything"] = "全部"
	L["Exact Spell ID(s)"] = "正確的法術 ID"
	L["Exact Spell Match"] = "完全符合法術"
	L["Expand"] = "展開"
	L["Expand all loaded displays"] = "展開所有已載入的提醒效果"
	L["Expand all non-loaded displays"] = "展開所有未載入的提醒效果"
	L["Expand all pending Import"] = "展開所有等待匯入的內容"
	L["Expansion is disabled because this group has no children"] = "無法展開，因為這個群組沒有子項目"
	L["Export to Lua table..."] = "匯出成 Lua table..."
	L["Export to string..."] = "匯出成文字字串..."
	L["External"] = "外部"
	L["Extra Height"] = "額外高度"
	L["Extra Width"] = "額外寬度"
	L["Fade"] = "淡化"
	L["Fade In"] = "淡入"
	L["Fade Out"] = "淡出"
	L["Fallback"] = "Fallback"
	L["Fallback Icon"] = "缺少圖示時要顯示的圖示"
	L["False"] = "否 (False)"
	L["Fetch Affected/Unaffected Names"] = "取得受影響/未受影響的名字"
	L["File Height"] = "列高"
	L["File Width"] = "列寬"
	L["Filter by Arena Spec"] = "依競技場專精過濾"
	L["Filter by Class"] = "依職業過濾"
	L["Filter by Group Role"] = "依角色職責過濾"
	L["Filter by Nameplate Type"] = "依名條類型過濾"
	L["Filter by Raid Role"] = "依團隊角色職責過濾"
	L[ [=[Filter formats: 'Name', 'Name-Realm', '-Realm'.

Supports multiple entries, separated by commas
]=] ] = "過濾格式: '名字', '名字-伺服器', '-伺服器'。支援多個項目，使用逗號分隔。"
	L["Find Auras"] = "尋找提醒效果"
	L["Finish"] = "結束"
	L["Fire Orb"] = "火球"
	L["Font"] = "文字"
	L["Font Size"] = "文字大小"
	L["Foreground"] = "前景"
	L["Foreground Color"] = "前景顏色"
	L["Foreground Texture"] = "前景材質"
	L["Format"] = "格式"
	L["Format for %s"] = "%s 的格式"
	L["Found a Bug?"] = "發現 Bug?"
	L["Frame"] = "框架"
	L["Frame Count"] = "影格數量"
	L["Frame Height"] = "框架高度"
	L["Frame Rate"] = "影格幀數"
	L["Frame Selector"] = "框架選擇器"
	L["Frame Strata"] = "框架層級"
	L["Frame Width"] = "框架寬度"
	L["Frequency"] = "頻率"
	L["From Template"] = "從範本建立 (**推薦**)"
	L["Full Circle"] = "完整循環"
	L["Get Help"] = "取得說明"
	L["Global Conditions"] = "整體條件"
	L["Glow %s"] = "發光 %s"
	L["Glow Action"] = "發光動作"
	L["Glow Anchor"] = "發光對齊位置"
	L["Glow Color"] = "發光顏色"
	L["Glow External Element"] = "發光外部元素"
	L["Glow Frame Type"] = "發光框架類型"
	L["Glow Type"] = "發光類型"
	L["Green Rune"] = "綠色符文"
	L["Grid direction"] = "網格方向"
	L["Group"] = "群組"
	L["Group (verb)"] = "群組"
	L[ [=[Group and anchor each auras by frame.

- Nameplates: attach to nameplates per unit.
- Unit Frames: attach to unit frame buttons per unit.
- Custom Frames: choose which frame each region should be anchored to.]=] ] = "按框架對每個光環進行分組和定位。 - 名條：附在每個單位的名條上。 - 單元框架：每個單元附加到單元框架按鈕。 - 自定義框架：選擇每個區域應定位到哪個框架。"
	L["Group aura count description"] = [=[要觸發這個提醒效果，必須有 %s 個成員受到一個或多個指定光環的影響。
如果輸入的數字是整數 (例如 5)，受到影響的團隊成員數量會和輸入的數字做比較。
如果輸入的數字是小數 (例如 0.5)、分數 (例如 1/2) 或百分比 (例如 50%%)，那麼 %s 的部分必須受到影響。

|cFF4444FF舉例來說:|r
|cFF00CC00> 0|r 當 %s 中的任何人受到影響時會觸發
|cFF00CC00= 100%%|r 當 %s 中的任何人受到影響時會觸發
|cFF00CC00!= 2|r 當 %s 中受到影響的人數不剛好為 2 的時候會觸發
|cFF00CC00<= 0.8|r 當 %s 中受到影響的人數少於 80%% 的時候會觸發 (5人隊伍時為4人、10人團隊時為8人、25人團隊時為20人)
|cFF00CC00> 1/2|r 當 %s 中受到影響的人數超過一半時會觸發
|cFF00CC00>= 0|r 無論如何永遠都會觸發]=]
	L["Group by Frame"] = "依框架分群組"
	L["Group Description"] = "群組說明"
	L["Group Icon"] = "群組圖示"
	L["Group key"] = "群組 key"
	L["Group Member Count"] = "群組成員總數"
	L["Group Options"] = "群組選項"
	L["Group Role"] = "角色職責"
	L["Group Scale"] = "群組縮放大小"
	L["Group Settings"] = "群組設定"
	L["Group Type"] = "群組類型"
	L["Grow"] = "增長"
	L["Hawk"] = "老鷹"
	L["Height"] = "高度"
	L["Help"] = "說明"
	L["Hide"] = "隱藏"
	L["Hide Background"] = "隱藏背景"
	L["Hide Glows applied by this aura"] = "隱藏這個光環所套用的發光效果"
	L["Hide on"] = "隱藏"
	L["Hide this group's children"] = "隱藏這個群組的子項目"
	L["Hide Timer Text"] = "隱藏計時器文字"
	L["Hide When Not In Group"] = "不在隊伍中時隱藏"
	L["Horizontal Align"] = "水平對齊"
	L["Horizontal Bar"] = "水平進度條"
	L["Hostility"] = "敵對"
	L["Huge Icon"] = "超大圖示"
	L["Hybrid Position"] = "混合位置"
	L["Hybrid Sort Mode"] = "混合模式"
	L["Icon"] = "圖示"
	L["Icon Info"] = "圖示訊息"
	L["Icon Inset"] = "圖示內縮"
	L["Icon Position"] = "圖示位置"
	L["Icon Settings"] = "圖示設定"
	L["Icon Source"] = "圖示來源"
	L["If"] = "(if) 當"
	L["If checked, then the user will see a multi line edit box. This is useful for inputting large amounts of text."] = "勾選時，使用者會看到多行的文字編輯方塊，適用於輸入大量文字。"
	L["If checked, then this option group can be temporarily collapsed by the user."] = "勾選時，使用者可以將群組暫時摺疊收起來。"
	L["If checked, then this option group will start collapsed."] = "勾選時，這個選項群組一開始就會呈現摺疊收起來的狀態。"
	L["If checked, then this separator will include text. Otherwise, it will be just a horizontal line."] = "勾選時，分隔線會包含文字，否則只會有水平線。"
	L["If checked, then this separator will not merge with other separators when selecting multiple auras."] = "勾選時，選擇多個提醒效果的時候，這個分隔線不會和其他分隔線合併。"
	L["If checked, then this space will span across multiple lines."] = "勾選時，此間距將會跨越多行。"
	L["If Trigger %s"] = "(if) 當觸發 %s"
	L["If unchecked, then a default color will be used (usually yellow)"] = "不勾選時會使用預設的顏色 (通常是黃色)"
	L["If unchecked, then this space will fill the entire line it is on in User Mode."] = "取消勾選時，會用這個空格填滿使用者模式中的整行。"
	L["Ignore Dead"] = "忽略死者"
	L["Ignore Disconnected"] = "忽略離線者"
	L["Ignore Lua Errors on OPTIONS event"] = "忽略 OPTIONS 事件的 Lua 錯誤"
	L["Ignore out of checking range"] = "忽略超出檢查範圍"
	L["Ignore Self"] = "忽略自己"
	L["Ignore self"] = "忽略自己"
	L["Ignore updates"] = "忽略更新"
	L["Ignored"] = "忽略"
	L["Ignored Aura Name"] = "忽略的光環名稱"
	L["Ignored Exact Spell ID(s)"] = "忽略的正確法術 ID"
	L["Ignored Name(s)"] = "忽略的名稱"
	L["Ignored Spell ID"] = "忽略的法術 ID"
	L["Import"] = "匯入"
	L["Import a display from an encoded string"] = "從編碼字串匯入提醒效果"
	L["Include Pets"] = "包含寵物"
	L["Indent Size"] = "內縮大小"
	L["Information"] = "資訊"
	L["Inner"] = "內部"
	L["Invalid Item Name/ID/Link"] = "無效的物品名稱/ID/連結"
	L["Invalid Spell ID"] = "無效的法術 ID"
	L["Invalid Spell Name/ID/Link"] = "無效的法術名稱/ID/連結"
	L["Invalid type for '%s'. Expected 'bool', 'number', 'select', 'string', 'timer' or 'elapsedTimer'."] = "'%s' 的類型無效，需要  'bool', 'number', 'select', 'string', 'timer' 或 'elapsedTimer'。"
	L["Invalid type for property '%s' in '%s'. Expected '%s'"] = "屬性 '%s' 的類型無效 (在 '%s')，需要  '%s'。"
	L["Inverse"] = "反向"
	L["Inverse Slant"] = "反向傾斜"
	L["Invert the direction of progress"] = "反轉進度增長方向"
	L["Is Boss Debuff"] = "首領的減益"
	L["Is Stealable"] = "可偷取"
	L["Justify"] = "左右對齊"
	L["Keep Aspect Ratio"] = "保持長寬比例"
	L["Keep your Wago imports up to date with the Companion App."] = "使用 Companion App 讓從 Wago 匯入的字串保持更新。"
	L["Large Input"] = "大量輸入"
	L["Leaf"] = "葉子"
	L["Left"] = "左"
	L["Left 2 HUD position"] = "左2 HUD 位置"
	L["Left HUD position"] = "左方 HUD 位置"
	L["Length"] = "長度"
	L["Length of |cFFFF0000%s|r"] = "|cFFFF0000%s|r的長度"
	L["Limit"] = "限制"
	L["Lines & Particles"] = "直線 & 粒子"
	L["Linked aura: "] = "已連結光環: "
	L["Load"] = "載入"
	L["Loaded"] = "已載入"
	L["Lock Positions"] = "鎖定位置"
	L["Loop"] = "重複循環"
	L["Low Mana"] = "低法力"
	L["Magnetically Align"] = "磁吸式對齊"
	L["Main"] = "主要"
	L["Match Count"] = "符合的數量"
	L["Matches the height setting of a horizontal bar or width for a vertical bar."] = "符合水平進度條的高度設定，或垂直進度條的寬度。"
	L["Max"] = "最大"
	L["Max Length"] = "最大長度"
	L["Medium Icon"] = "中圖示"
	L["Message"] = "訊息"
	L["Message Prefix"] = "訊息字首"
	L["Message Suffix"] = "訊息字尾"
	L["Message Type"] = "訊息類型"
	L["Min"] = "最小"
	L["Mirror"] = "鏡像"
	L["Model"] = "模組"
	L["Model %s"] = "模組 %s"
	L["Model Settings"] = "模組設定"
	L["Move Above Group"] = "移至群組上方"
	L["Move Below Group"] = "移至群組下方"
	L["Move Down"] = "往下移動"
	L["Move Entry Down"] = "項目往下移"
	L["Move Entry Up"] = "項目往上移動"
	L["Move Into Above Group"] = "移動至上方的群組內"
	L["Move Into Below Group"] = "移動至下方的群組內"
	L["Move this display down in its group's order"] = "將這個提醒效果在群組中的順序往下移動"
	L["Move this display up in its group's order"] = "將這個提醒效果在群組中的順序往上移動"
	L["Move Up"] = "往上移動"
	L["Multiple Displays"] = "多個提醒效果"
	L["Multiselect ignored tooltip"] = [=[|cFFFF0000忽略|r - |cFF777777單一|r - |cFF777777多個|r
這個選項將不會用來決定何時該載入這個顯示效果]=]
	L["Multiselect multiple tooltip"] = [=[|cFF777777忽略|r - |cFF777777單一|r - |cFF00FF00多個|r
只要符合其中任何一個都會被載入]=]
	L["Multiselect single tooltip"] = [=[|cFF777777忽略|r - |cFF00FF00單一|r - |cFF777777多個|r
只有符合這一個值的時候會被載入]=]
	L["Must be a power of 2"] = "必須是2的倍數"
	L["Name Info"] = "名稱訊息"
	L["Name Pattern Match"] = "名稱模式符合"
	L["Name(s)"] = "名稱"
	L["Name:"] = "名稱:"
	L["Nameplate"] = "血條/名條"
	L["Nameplates"] = "血條/名條"
	L["Negator"] = "不"
	L["New Aura"] = "新增提醒效果"
	L["New Value"] = "新的值"
	L["No Children"] = "沒有子項目"
	L["None"] = "無"
	L["Not a table"] = "不是 table"
	L["Not all children have the same value for this option"] = "並非所有子項目的這個設定都使用相同的數值"
	L["Not Loaded"] = "未載入"
	L["Note: Automated Messages to SAY and YELL are blocked outside of Instances."] = "注意: 副本外面無法在 '說' 和 '大喊' 頻道自動發送訊息，會被阻擋。"
	L["Note: The legacy buff trigger is now permanently disabled. It will be removed in the near future."] = "注意: 現在已經永久性的停用舊的增益觸發，將會在近期改版中全面移除。"
	L["Number of Entries"] = "項目數量"
	L["Offer a guided way to create auras for your character"] = "用步驟導引的方式替角色建立提醒效果"
	L["Offset by |cFFFF0000%s|r/|cFFFF0000%s|r"] = "偏移|cFFFF0000%s|r/|cFFFF0000%s|r"
	L["Offset by 1px"] = "偏移 1px"
	L["Okay"] = "確認"
	L["On Hide"] = "消失時"
	L["On Init"] = "初始化時"
	L["On Show"] = "出現時"
	L["Only Match auras cast by a player (not an npc)"] = "只符合玩家 (非 NPC) 施放的光環"
	L["Only match auras cast by people other than the player"] = "只符合其他玩家施放的光環"
	L["Only match auras cast by people other than the player or his pet"] = "只符合其他玩家施放的光環"
	L["Only match auras cast by the player"] = "只符合玩家自己施放的光環"
	L["Only match auras cast by the player or his pet"] = "只符合玩家自己或寵物施放的光環"
	L["Operator"] = "運算符"
	L["Option %i"] = "選項 %i"
	L["Option key"] = "選項 key"
	L["Option Type"] = "選項類型"
	L["Options will open after combat ends."] = "設定選項會在戰鬥結束後開啟。"
	L["or"] = "或"
	L["or Trigger %s"] = "或觸發 %s"
	L["Orange Rune"] = "橘色符文"
	L["Orientation"] = "方向"
	L["Outer"] = "外部"
	L["Outline"] = "外框"
	L["Overflow"] = "超出範圍"
	L["Overlay %s Info"] = "疊加%s資訊"
	L["Overlays"] = "疊加圖層"
	L["Own Only"] = "只顯示自己的"
	L["Paste Action Settings"] = "貼上動作設定"
	L["Paste Animations Settings"] = "貼上動畫設定"
	L["Paste Author Options Settings"] = "貼上作者選項設定"
	L["Paste Condition Settings"] = "貼上條件設定"
	L["Paste Custom Configuration"] = "貼上自訂設定選項"
	L["Paste Display Settings"] = "貼上顯示設定"
	L["Paste Group Settings"] = "貼上群組設定"
	L["Paste Load Settings"] = "貼上載入設定"
	L["Paste Settings"] = "貼上設定"
	L["Paste text below"] = "在下面貼上文字"
	L["Paste Trigger Settings"] = "貼上觸發設定"
	L["Places a tick on the bar"] = "在進度條上顯示每次進度指示"
	L["Play Sound"] = "播放音效"
	L["Portrait Zoom"] = "人像變焦"
	L["Position Settings"] = "位置設定"
	L["Preferred Match"] = "優先選擇符合"
	L["Premade Snippets"] = "預先寫好的程式碼片段"
	L["Preset"] = "預設配置"
	L["Press Ctrl+C to copy"] = "按下 Ctrl+C 複製"
	L["Press Ctrl+C to copy the URL"] = "按 Ctrl+C 複製 URL"
	L["Prevent Merging"] = "防止合併"
	L["Progress Bar"] = "進度條"
	L["Progress Bar Settings"] = "進度條設定"
	L["Progress Texture"] = "進度材質"
	L["Progress Texture Settings"] = "進度材質設定"
	L["Purple Rune"] = "紫色符文"
	L["Put this display in a group"] = "將這個提醒效果放入群組中"
	L["Radius"] = "半徑"
	L["Raid Role"] = "團隊角色職責"
	L["Ready for Install"] = "準備好安裝了"
	L["Ready for Update"] = "準備好更新了"
	L["Re-center X"] = "重新水平置中"
	L["Re-center Y"] = "重新垂直置中"
	L["Regions of type \"%s\" are not supported."] = "不支援區域類型 \"%s\"。"
	L["Remaining Time"] = "剩餘時間"
	L["Remove"] = "移除"
	L["Remove this display from its group"] = "將這個提醒效果從群組中移除"
	L["Remove this property"] = "移除這個屬性"
	L["Rename"] = "重新命名"
	L["Repeat After"] = "之後重複"
	L["Repeat every"] = "每次重複"
	L["Report bugs on our issue tracker."] = "請在我們的問題追蹤網頁回報 bug。"
	L["Require unit from trigger"] = "需要來自觸發的單位"
	L["Required for Activation"] = "啟用需要"
	L["Reset all options to their default values."] = "重置所有選項，恢復成預設值。"
	L["Reset Entry"] = "重置項目"
	L["Reset to Defaults"] = "重置為預設值"
	L["Right"] = "右"
	L["Right 2 HUD position"] = "右2 HUD 位置"
	L["Right HUD position"] = "右方 HUD 位置"
	L["Right-click for more options"] = "右鍵點擊顯示更多設定"
	L["Rotate"] = "旋轉"
	L["Rotate In"] = "旋轉進入"
	L["Rotate Out"] = "旋轉退出"
	L["Rotate Text"] = "旋轉文字"
	L["Rotation"] = "旋轉"
	L["Rotation Mode"] = "旋轉模式"
	L["Row Space"] = "列間距"
	L["Row Width"] = "列寬度"
	L["Rows"] = "列"
	L["Same"] = "相同"
	L["Same texture as Foreground"] = "與前景相同的材質"
	L["Scale"] = "縮放大小"
	L["Search"] = "搜尋"
	L["Select the auras you always want to be listed first"] = "選擇永遠要列在前面的特效"
	L["Selected Frame"] = "已選框架"
	L["Send To"] = "發送到"
	L["Separator Text"] = "分隔線文字"
	L["Separator text"] = "分隔線文字"
	L["Set Parent to Anchor"] = "對齊到上一層"
	L["Set Thumbnail Icon"] = "設定縮圖圖示"
	L["Sets the anchored frame as the aura's parent, causing the aura to inherit attributes such as visibility and scale."] = "將對齊到的框架設為提醒效果的上一層框架，讓提醒效果能夠繼承像是顯示和縮放大小等屬性。"
	L["Settings"] = "設定"
	L["Shadow Color"] = "陰影顏色"
	L["Shadow X Offset"] = "陰影水平偏移"
	L["Shadow Y Offset"] = "陰影垂直偏移"
	L["Shift-click to create chat link"] = "Shift-左鍵點擊建立 |cFF8800FF[聊天連結]"
	L["Show \"Edge\""] = "顯示\"邊緣\""
	L["Show \"Swipe\""] = "顯示\"揮打\""
	L["Show all matches (Auto-clone)"] = "顯示所有符合的 (自動複製)"
	L["Show Border"] = "顯示邊框"
	L["Show Glow"] = "顯示發光"
	L["Show Icon"] = "顯示圖示"
	L["Show If Unit Does Not Exist"] = "單位不存在時要顯示"
	L["Show If Unit Is Invalid"] = "單位無效時要顯示"
	L["Show Matches for"] = "顯示符合的"
	L["Show Matches for Units"] = "顯示單位符合的"
	L["Show Model"] = "顯示模組"
	L["Show model of unit "] = "顯示單位的模組"
	L["Show On"] = "顯示於"
	L["Show Spark"] = "顯示亮點"
	L["Show Text"] = "顯示文字"
	L["Show this group's children"] = "顯示這個群組的子項目"
	L["Show Tick"] = "顯示每次進度指示"
	L["Shows a 3D model from the game files"] = "顯示遊戲檔案中的3D模組"
	L["Shows a border"] = "顯示邊框"
	L["Shows a custom texture"] = "顯示自訂材質"
	L["Shows a glow"] = "顯示發光效果"
	L["Shows a model"] = "顯示模組"
	L["Shows a progress bar with name, timer, and icon"] = "顯示一個包含名稱、時間和圖示的進度條"
	L["Shows a spell icon with an optional cooldown overlay"] = "顯示法術圖示，可選擇是否要在上面顯示冷卻時間。"
	L["Shows a stop motion texture"] = "顯示定格材質"
	L["Shows a texture that changes based on duration"] = "顯示根據時間變化的材質"
	L["Shows one or more lines of text, which can include dynamic information such as progress or stacks"] = "顯示包含動態資訊的文字 (例如進度或是堆疊層數，允許一行或多行)"
	L["Simple"] = "簡單"
	L["Size"] = "大小"
	L["Slant Amount"] = "傾斜大小"
	L["Slant Mode"] = "傾斜模式"
	L["Slanted"] = "已傾斜"
	L["Slide"] = "滑動"
	L["Slide In"] = "滑入"
	L["Slide Out"] = "滑出"
	L["Slider Step Size"] = "滑桿數值間距"
	L["Small Icon"] = "小圖示"
	L["Smooth Progress"] = "平順顯示進度"
	L["Snippets"] = "程式碼片段"
	L["Soft Max"] = "最大軟上限"
	L["Soft Min"] = "最小軟上限"
	L["Sort"] = "排序"
	L["Sound"] = "音效"
	L["Sound Channel"] = "音效頻道"
	L["Sound File Path"] = "音效檔案路徑"
	L["Sound Kit ID"] = "Sound Kit ID"
	L["Source"] = "來源"
	L["Space"] = "間距"
	L["Space Horizontally"] = "橫向間隔"
	L["Space Vertically"] = "縱向間隔"
	L["Spark"] = "亮點"
	L["Spark Settings"] = "亮點設定"
	L["Spark Texture"] = "亮點材質"
	L["Specialization"] = "專精"
	L["Specific Unit"] = "指定單位"
	L["Spell ID"] = "法術 ID"
	L["Stack Count"] = "堆疊層數"
	L["Stack Info"] = "堆疊層數資訊"
	L["Stagger"] = "交錯"
	L["Star"] = "星星"
	L["Start"] = "開始"
	L["Start Angle"] = "開始時的角度"
	L["Start Collapsed"] = "開始先收合"
	L["Start of %s"] = "%s 的開始"
	L["Stealable"] = "可法術竊取"
	L["Step Size"] = "數值間距"
	L["Stop Motion"] = "定格"
	L["Stop Motion Settings"] = "定格設定"
	L["Stop Sound"] = "停止音效"
	L["Sub Elements"] = "子元素"
	L["Sub Option %i"] = "子選項 %i"
	L["Swipe Overlay Settings"] = "揮動疊層設定"
	L["Temporary Group"] = "暫時性的群組"
	L["Text"] = "文字"
	L["Text %s"] = "文字 %s"
	L["Text Color"] = "文字顏色"
	L["Text Settings"] = "文字設定"
	L["Texture"] = "材質"
	L["Texture Info"] = "材質資訊"
	L["Texture Settings"] = "材質設定"
	L["Texture Wrap"] = "材質包覆"
	L["The duration of the animation in seconds."] = "動畫的持續時間(秒)。"
	L["The duration of the animation in seconds. The finish animation does not start playing until after the display would normally be hidden."] = "動畫的持續時間 (秒)。直到提醒效果正常隱藏後，才會播放結束時的動畫。"
	L["The type of trigger"] = "觸發類型"
	L["Then "] = "(then) 則 "
	L["Thickness"] = "粗細"
	L["This adds %raidMark as text replacements."] = "這會加入 %raidMark 作為替換用的文字。"
	L["This adds %role, %roleIcon as text replacements."] = "這會加入 %role、%roleIcon 作為替換用的文字。"
	L["This adds %tooltip, %tooltip1, %tooltip2, %tooltip3 as text replacements."] = "這會加入 %tooltip、%tooltip1、%tooltip2、%tooltip3 作為替換用的文字。"
	L["This display is currently loaded"] = "這個提醒效果已經載入"
	L["This display is not currently loaded"] = "這個提醒效果尚未載入"
	L["This region of type \"%s\" is not supported."] = "不支援的地區類型 \"%s\"。"
	L["This setting controls what widget is generated in user mode."] = "這個設定控制使用者模式中會產生什麼控制項。"
	L["Tick %s"] = "每次進度指示 %s"
	L["Tick Mode"] = "每次進度指示模式"
	L["Tick Placement"] = "每次進度指示位置"
	L["Time in"] = "時間"
	L["Tiny Icon"] = "小小圖示"
	L["To Frame's"] = "對齊框架的"
	L["To Group's"] = "到群組的"
	L["To Personal Ressource Display's"] = "對齊個人資源條的"
	L["To Screen's"] = "對齊螢幕的"
	L["Toggle the visibility of all loaded displays"] = "切換顯示所有已載入的提醒效果"
	L["Toggle the visibility of all non-loaded displays"] = "切換顯示所有未載入的提醒效果"
	L["Toggle the visibility of this display"] = "切換顯示這個提醒效果"
	L["Tooltip"] = "滑鼠提示"
	L["Tooltip Content"] = "滑鼠提示內容"
	L["Tooltip on Mouseover"] = "顯示滑鼠提示說明"
	L["Tooltip Pattern Match"] = "滑鼠提示模式符合"
	L["Tooltip Text"] = "滑鼠提示文字"
	L["Tooltip Value"] = "滑鼠提示值"
	L["Tooltip Value #"] = "滑鼠提示值 #"
	L["Top"] = "上"
	L["Top HUD position"] = "上方 HUD 位置"
	L["Top Left"] = "左上"
	L["Top Right"] = "右上"
	L["Total Angle"] = "總角度"
	L["Total Time"] = "總共時間"
	L["Trigger"] = "觸發"
	L["Trigger %d"] = "觸發 %d"
	L["Trigger %s"] = "觸發 %s"
	L["Trigger Combination"] = "觸發組合"
	L["True"] = "是 (True)"
	L["Type"] = "類型"
	L["Type 'select' for '%s' requires a values member'"] = "'%s' 的類型 'select' 需要 values member"
	L["Ungroup"] = "解散群組"
	L["Unit"] = "單位"
	L["Unit %s is not a valid unit for RegisterUnitEvent"] = "%s 不是 RegisterUnitEvent 的有效單位"
	L["Unit Count"] = "單位數量"
	L["Unit Frame"] = "單位框架"
	L["Unit Frames"] = "單位框架"
	L["Unit Name Filter"] = "單位名字過濾方式"
	L["UnitName Filter"] = "單位名字過濾方式"
	L["Unknown property '%s' found in '%s'"] = "發現未知屬性 '%s'，在 '%s'"
	L["Unlike the start or finish animations, the main animation will loop over and over until the display is hidden."] = "不同於開始或結束時的動畫，主要動畫將重複循環直到提醒效果被隱藏。"
	L["Update"] = "更新"
	L["Update Auras"] = "更新提醒效果"
	L["Update Custom Text On..."] = "更新自訂文字於..."
	L["URL"] = "URL"
	L["Use Custom Color"] = "使用自訂顏色"
	L["Use Display Info Id"] = "使用顯示資訊 ID"
	L["Use Full Scan (High CPU)"] = "使用完整掃描 (高 CPU)"
	L["Use nth value from tooltip:"] = "使用滑鼠提示中的第 N 個值:"
	L["Use SetTransform"] = "使用 SetTransform"
	L["Use Texture"] = "使用材質"
	L["Use tooltip \"size\" instead of stacks"] = "使用滑鼠提示的 \"大小\" 而不是堆疊"
	L["Use Tooltip Information"] = "使用滑鼠提示中的資訊"
	L["Used in Auras:"] = "使用的提醒效果:"
	L["Used in auras:"] = "用於光環:"
	L["Uses UnitIsVisible() to check if in range. This is polled every second."] = "使用 UnitIsVisible() 來檢查是否在範圍內，每秒都會檢查一次。"
	L["Value %i"] = "數值 %i"
	L["Values are in normalized rgba format."] = "數值為標準化的 rgba  格式。"
	L["Values:"] = "數值:"
	L["Version: "] = "版本: "
	L["Vertical Align"] = "垂直對齊"
	L["Vertical Bar"] = "垂直進度條"
	L["View"] = "檢視"
	L["Voice"] = "語音"
	L["Whole Area"] = "整個區域"
	L["Width"] = "寬度"
	L["wrapping"] = "自動換行"
	L["X Offset"] = "水平位置"
	L["X Rotation"] = "水平旋轉"
	L["X Scale"] = "水平縮放"
	L["X-Offset"] = "水平位置"
	L["x-Offset"] = "水平位置偏移"
	L["Y Offset"] = "垂直位置"
	L["Y Rotation"] = "垂直旋轉"
	L["Y Scale"] = "垂直縮放"
	L["Yellow Rune"] = "黃色符文"
	L["Yes"] = "是"
	L["y-Offset"] = "垂直位置偏移"
	L["Y-Offset"] = "垂直位置"
	L["You are about to delete %d aura(s). |cFFFF0000This cannot be undone!|r Would you like to continue?"] = "你正準備要刪除 %d 個提醒效果，刪除後將|cFFFF0000無法還原!|r 請問是否要繼續?"
	L["You are about to delete a trigger. |cFFFF0000This cannot be undone!|r Would you like to continue?"] = "你正要刪除觸發。 |cFFFF0000刪除後將無法還原!|r 是否確定要繼續?"
	L["Your Saved Snippets"] = "已儲存的程式碼片段"
	L["Z Offset"] = "Z軸位置"
	L["Z Rotation"] = "Z軸旋轉"
	L["Zoom"] = "縮放"
	L["Zoom In"] = "放大"
	L["Zoom Out"] = "縮小"

