local TOCNAME,ADDON=...

ADDON.locales={
	enEN ={ --EN is Master/Fallback
		AboutInfo="A full raid and everyone needs water! Or Healthstone! - Automatic trade addon",
		AboutUsage="This addon fills the trade-window with full stacks of water or food (or every other consumable), depending of the class of your trading partner. When conjured drink, food or healthstones are missing, a cast-button is added right to the trade-window. WD checks the level of your trade partner, so it will only get useable water/food/healthstone.|nWD has predefined settings for water/food/healthstones, but you can change how many stacks each class will get in the options (type /wd config) or add new items for auto trade. The amount can be different for solo/strangers, group-members and raid-members. When you want to add new items, you need at least one item in the inventory before you open the configuration.|nWD should support any classic client.",
		AboutSlashCommand="<value> can be true, 1, enable, false, 0, disable. If <value> is omitted, the current status switches.",
		
		PanelAbout="About",
		HeaderInfo="Information",
		HeaderUsage="Usage",
		HeaderSlashCommand="Commands",
		HeaderCredits="Credits",		
		
		MissingStack="Missing stack:",
		Saved="Saved",
		Stored="Stored Settings",
		Available="Available Items",
		PlaceHolderSelect="Please select an item first",
		Removed="Removed:",
		
		cboxAutoFillSolo="Automatic fill trade window for solo/stranger.",
		cboxAutoFillGroup="Automatic fill trade window for group member.",
		cboxAutoFillRaid="Automatic fill trade window for raid member.",
		cboxUseNotFullStack="Use not complete full stack",
		cboxLocked="Trade locked items in untrade slot for rogues",
		
		SelectItem="Choose an item",
		Group="Group",
		Raid="Raid",
		Solo="Solo",
		
		Save="Save",
		Remove="Remove",
		slashAutoFillSolo ="Set automatic fill trade window for solo/stranger ",
		slashAutoFillGroup="Set automatic fill trade window for group member",
		slashAutoFillRaid ="Set automatic fill trade window for raid member",
		
		slashFill="Fill open trade window.",
		slashConfig="Open config",
		slashAbout="Open about",
		errNoTrade="No active trade!",
		inStacks="(in stacks)",
		ClearTrade="Clear",
		FillTrade="Fill",
		Config="Config",
		AcceptTrade="Accept trade",
		MageWater="Any conjured water",
		MageFood="Any conjured food",
		WarlockHealthstone="Any Healthstone",
		
	},
	deDE=  {
		["AboutInfo"] = "Ein voller Raid und jeder benötigt Wasser! Oder Gesundheitssteine! - Ein automatisches Handeln-Addon",
		["AboutSlashCommand"] = "<value> kann true, 1, enable, false, 0, disable sein. Wenn <value> fehlt, wird zwischen ein/aus hin. und hergeschaltet.",
		["AboutUsage"] = "Das Addon füllt das Handelsfenster mit vollen Stack Wasser, Essen, Gesundheitssteine (oder jedes andere nicht gebundene Verbrauchbares), abhängig von der Klasse des Handelspartners. Wenn herbeigezaubertes Wasser/Trinken/Gesundheitssteine fehlen, wird beim Handelsfenster ein Zauber-Button angeboten und neue vollständige Stacks in das Handelsfenster verschoben. Genauso wird das Level des Handelspartners beachtet, so das er nur das bekommt, was er auch nutzen kann.|nWD hat eine vordefinierte Einstellungen, wieviel jeder bekommt und kann einfach in den Einstellungen (einfach '/wd config' eintippen) ändern bzw. neue Gegenstände hinzufügen. Für Solo/Fremde, Gruppenmitglieder und Raidmitglieder können getrennte Werte eingestellt werden. Wenn man neue Gegenstände hinzufügen will, braucht man minimum eins davon im Inventar.|nWD sollte mit jeden Classic-Client laufen.",
		["AcceptTrade"] = "Handel abschließen",
		["Available"] = "Verfügbare Gegenstände",
		["cboxAutoFillGroup"] = "Handelsfenster automatisch ausfüllen bei Gruppenmitgliedern.",
		["cboxAutoFillRaid"] = "Handelsfenster automatisch ausfüllen bei Raidmitgliedern.",
		["cboxAutoFillSolo"] = "Handelsfenster automatisch ausfüllen bei Solo / Fremden.",
		["cboxUseNotFullStack"] = "Auch nicht komplette Stacks benutzen",
		["ClearTrade"] = "Leeren",
		["Config"] = "Einstellungen",
		["errNoTrade"] = "Kein Handelsfenster ist offen.",
		["FillTrade"] = "Ausfüllen",
		["Group"] = "Gruppe",
		["HeaderCredits"] = "Credits",
		["HeaderInfo"] = "Informationen",
		["HeaderSlashCommand"] = "Befehle",
		["HeaderUsage"] = "Benutzung",
		["inStacks"] = "(in Stacks)",
		["MageFood"] = "Jedes herbeigezaubertes Essen",
		["MageWater"] = "Jedes herbeigezaubertes Trinken",
		["MissingStack"] = "Fehlende Stacks:",
		["PanelAbout"] = "Über",
		["PlaceHolderSelect"] = "Bitte erst ein Gegenstand auswählen.",
		["Raid"] = "Raid",
		["Remove"] = "Entferne",
		["Removed"] = "Entfernt:",
		["Save"] = "Speichern",
		["Saved"] = "Gespeichert",
		["SelectItem"] = "Gegenstand auswählen",
		["slashAbout"] = "Öffnet Über",
		["slashAutoFillGroup"] = "Setzt automatisches ausfüllen für Gruppenmitglieder",
		["slashAutoFillRaid"] = "Setzt automatisches ausfüllen für Raidmitglieder",
		["slashAutoFillSolo"] = "Setzt automatisches ausfüllen bei Solo/Fremden",
		["slashConfig"] = "Öffnet Einstellungen",
		["slashFill"] = "Füllt Handelsfenster aus.",
		["Solo"] = "Solo",
		["Stored"] = "Gespeicherte Einstellungen",
		["WarlockHealthstone"] = "Jeder Gesundheitsstein"
	},
}

ADDON.L = ADDON.locales[GetLocale()] or {}
setmetatable(ADDON.L, {
	__index = ADDON.locales["enEN"]
})

ADDON.L.AboutCredits = ""
