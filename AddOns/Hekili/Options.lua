-- Options.lua
-- Everything related to building/configuring options.

local addon, ns = ...
local Hekili = _G[ addon ]

local class = Hekili.Class
local scripts = Hekili.Scripts
local state = Hekili.State

local format, lower, match = string.format, string.lower, string.match
local insert, remove, sort, wipe = table.insert, table.remove, table.sort, table.wipe

local callHook = ns.callHook

local SpaceOut = ns.SpaceOut

local formatKey = ns.formatKey
local orderedPairs = ns.orderedPairs
local tableCopy = ns.tableCopy

local GetItemInfo = ns.CachedGetItemInfo

-- Atlas/Textures
local AtlasToString, GetAtlasFile, GetAtlasCoords = ns.AtlasToString, ns.GetAtlasFile, ns.GetAtlasCoords


local ACD = LibStub( "AceConfigDialog-3.0" )
local LDBIcon = LibStub( "LibDBIcon-1.0", true )


local NewFeature = "|TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0|t"
local GreenPlus = "Interface\\AddOns\\Hekili\\Textures\\GreenPlus"
local RedX = "Interface\\AddOns\\Hekili\\Textures\\RedX"
local BlizzBlue = "|cFF00B4FF"
local ClassColor = Hekili.IsWrath() and RAID_CLASS_COLORS[ class.file ] or C_ClassColor.GetClassColor( class.file )

-- Simple bypass for Wrath-friendliness.
local GetSpecialization = _G.GetSpecialization or function() return GetActiveTalentGroup() end
local GetSpecializationInfo = _G.GetSpecializationInfo or function()
    local name, baseName, id = UnitClass( "player" )
    return id, baseName, name
end
local IsTalentSpell = _G.IsTalentSpell or function() return false end
local IsPressHoldReleaseSpell = _G.IsPressHoldReleaseSpell or function() return false end
local UnitEffectiveLevel = _G.UnitEffectiveLevel or UnitLevel
local UnitSpellHaste = _G.UnitSpellHaste or function() return 0 end



--[[ Interrupts
do
    local db = {}

    -- Generate encounter DB.
    local function GenerateEncounterDB()
        local active = EJ_GetCurrentTier()
        wipe( db )

        for t = 1, EJ_GetNumTiers() do
            EJ_SelectTier( t )

            local i = 1
            while EJ_GetInstanceByIndex( i, true ) do
                local instanceID, name = EJ_GetInstanceByIndex( i, true )
                i = i + 1

                local j = 1
                while EJ_GetEncounterInfoByIndex( j, instanceID ) do
                    local name, _, encounterID = EJ_GetEncounterInfoByIndex( j, instanceID )
                    db[ encounterID ] = name
                    j = j + 1
                end
            end
        end
    end

    GenerateEncounterDB()

    function Hekili:GetEncounterList()
        return db
    end
end ]]


-- One Time Fixes
local oneTimeFixes = {
    --[[ refreshForBfA_II = function( p )
        for k, v in pairs( p.displays ) do
            if type( k ) == 'number' then
                p.displays[ k ] = nil
            end
        end

        p.runOnce.refreshForBfA_II = nil
        p.actionLists = nil
    end, ]]

    --[[ reviseDisplayModes_20180709 = function( p )
        if p.toggles.mode.type ~= "AutoDual" and p.toggles.mode.type ~= "AutoSingle" and p.toggles.mode.type ~= "SingleAOE" then
            p.toggles.mode.type = "AutoDual"
        end

        if p.toggles.mode.value ~= "automatic" and p.toggles.mode.value ~= "single" and p.toggles.mode.value ~= "aoe" and p.toggles.mode.value ~= "dual" then
            p.toggles.mode.value = "automatic"
        end
    end, ]]

    --[[ reviseDisplayQueueAnchors_20180718 = function( p )
        for name, display in pairs( p.displays ) do
            if display.queue.offset then
                if display.queue.anchor:sub( 1, 3 ) == "TOP" or display.queue.anchor:sub( 1, 6 ) == "BOTTOM" then
                    display.queue.offsetY = display.queue.offset
                    display.queue.offsetX = 0
                else
                    display.queue.offsetX = display.queue.offset
                    display.queue.offsetY = 0
                end
                display.queue.offset = nil
            end
        end

        p.runOnce.reviseDisplayQueueAnchors_20180718 = nil
    end,

    enableAllOfTheThings_20180820 = function( p )
        for name, spec in pairs( p.specs ) do
            spec.enabled = true
        end
    end,

    wipeSpecPotions_20180910_1 = function( p )
        local latestVersion = 20180919.1

        for id, spec in pairs( class.specs ) do
            if id > 0 and ( not p.specs[ id ].potionsReset or type( p.specs[ id ].potionsReset ) ~= 'number' or p.specs[ id ].potionsReset < latestVersion ) then
                p.specs[ id ].potion = spec.potion
                p.specs[ id ].potionsReset = latestVersion
            end
        end
        p.runOnce.wipeSpecPotions_20180910_1 = nil
    end,

    enabledArcaneMageOnce_20190309 = function( p )
        local arcane = class.specs[ 62 ]

        if arcane and not arcane.enabled then
            arcane.enabled = true
            return
        end

        -- Clears the flag if Arcane wasn't actually enabled.
        p.runOnce.enabledArcaneMageOnce_20190309 = nil
    end,

    autoconvertGlowsForCustomGlow_20190326 = function( p )
        for k, v in pairs( p.displays ) do
            if v.glow and v.glow.shine ~= nil then
                if v.glow.shine then
                    v.glow.mode = "autocast"
                else
                    v.glow.mode = "standard"
                end
                v.glow.shine = nil
            end
        end
    end,

    autoconvertDisplayToggle_20190621_1 = function( p )
        local m = p.toggles.mode
        local types = m.type

        if types then
            m.automatic = nil
            m.single = nil
            m.aoe = nil
            m.dual = nil
            m.reactive = nil
            m.type = nil

            if types == "AutoSingle" then
                m.automatic = true
                m.single = true
            elseif types == "SingleAOE" then
                m.single = true
                m.aoe = true
            elseif types == "AutoDual" then
                m.automatic = true
                m.dual = true
            elseif types == "ReactiveDual" then
                m.reactive = true
            end

            if not m[ m.value ] then
                if     m.automatic then m.value = "automatic"
                elseif m.single    then m.value = "single"
                elseif m.aoe       then m.value = "aoe"
                elseif m.dual      then m.value = "dual"
                elseif m.reactive  then m.value = "reactive" end
            end
        end
    end,

    resetPotionsToDefaults_20190717 = function( p )
        for _, v in pairs( p.specs ) do
            v.potion = nil
        end
    end, ]]

    resetAberrantPackageDates_20190728_1 = function( p )
        for _, v in pairs( p.packs ) do
            if type( v.date ) == 'string' then v.date = tonumber( v.date ) or 0 end
            if type( v.version ) == 'string' then v.date = tonumber( v.date ) or 0 end
            if v.date then while( v.date > 21000000 ) do v.date = v.date / 10 end end
            if v.version then while( v.version > 21000000 ) do v.version = v.version / 10 end end
        end
    end,

    --[[ autoconvertDelaySweepToExtend_20190729 = function( p )
        for k, v in pairs( p.displays ) do
            if v.delays.type == "CDSW" then
                v.delays.type = "__NA"
            end
        end
    end,

    autoconvertPSCDsToCBs_20190805 = function( p )
        for _, pack in pairs( p.packs ) do
            for _, list in pairs( pack.lists ) do
                for i, entry in ipairs( list ) do
                    if entry.action == "pocketsized_computation_device" then
                        entry.action = "cyclotronic_blast"
                    end
                end
            end
        end

        p.runOnce.autoconvertPSCDsToCBs_20190805 = nil -- repeat as needed.
    end,

    cleanupAnyPriorityVersionTypoes_20200124 = function ( p )
        for _, pack in pairs( p.packs ) do
            if pack.date    and pack.date    > 99999999 then pack.date    = 0 end
            if pack.version and pack.version > 99999999 then pack.version = 0 end
        end

        p.runOnce.cleanupAnyPriorityVersionTypoes_20200124 = nil -- repeat as needed.
    end,

    resetRogueMfDOption_20200226 = function( p )
        if class.file == "ROGUE" then
            p.specs[ 259 ].settings.mfd_waste = nil
            p.specs[ 260 ].settings.mfd_waste = nil
            p.specs[ 261 ].settings.mfd_waste = nil
        end
    end,

    resetAllPotions_20201209 = function( p )
        for id in pairs( p.specs ) do
            p.specs[ id ].potion = nil
        end
    end,

    resetGlobalCooldownSync_20210403 = function( p )
        for id, spec in pairs( p.specs ) do
            spec.gcdSync = nil
        end
    end, ]]

    forceEnableEnhancedRecheckBoomkin_20210712 = function( p )
        local s = rawget( p.specs, 102 )
        if s then s.enhancedRecheck = true end
    end,

    updateMaxRefreshToNewSpecOptions_20220222 = function( p )
        for id, spec in pairs( p.specs ) do
            if spec.settings.maxRefresh then
                spec.settings.combatRefresh = 1 / spec.settings.maxRefresh
                spec.settings.regularRefresh = min( 1, 5 * spec.settings.combatRefresh )
                spec.settings.maxRefresh = nil
            end
        end
    end,

    forceEnableAllClassesOnceDueToBug_20220225 = function( p )
        for id, spec in pairs( p.specs ) do
            spec.enabled = true
        end
    end,

    forceReloadAllDefaultPriorities_20220228 = function( p )
        for name, pack in pairs( p.packs ) do
            if pack.builtIn then
                Hekili.DB.profile.packs[ name ] = nil
                Hekili:RestoreDefault( name )
            end
        end
    end,

    forceReloadClassDefaultOptions_20220306 = function( p )
        local sendMsg = false
        for spec, data in pairs( class.specs ) do
            if spec > 0 and not p.runOnce[ 'forceReloadClassDefaultOptions_20220306_' .. spec ] then
                local cfg = p.specs[ spec ]
                for k, v in pairs( data.options ) do
                    if cfg[ k ] == ns.specTemplate[ k ] and cfg[ k ] ~= v then
                        cfg[ k ] = v
                        sendMsg = true
                    end
                end
                p.runOnce[ 'forceReloadClassDefaultOptions_20220306_' .. spec ] = true
            end
        end
        if sendMsg then
            C_Timer.After( 5, function()
                if Hekili.DB.profile.notifications.enabled then Hekili:Notify( "Some specialization options were reset.", 6 ) end
                Hekili:Print( "Some specialization options were reset to default; this can occur once per profile/specialization." )
            end )
        end
        p.runOnce.forceReloadClassDefaultOptions_20220306 = nil
    end,

    forceDeleteBrokenMultiDisplay_20220319 = function( p )
        if rawget( p.displays, "Multi" ) then
            p.displays.Multi = nil
        end

        p.runOnce.forceDeleteBrokenMultiDisplay_20220319 = nil
    end,
}


function Hekili:RunOneTimeFixes()
    local profile = Hekili.DB.profile
    if not profile then return end

    profile.runOnce = profile.runOnce or {}

    for k, v in pairs( oneTimeFixes ) do
        if not profile.runOnce[ k ] then
            profile.runOnce[k] = true
            local ok, err = pcall( v, profile )
            if err then
                Hekili:Error( "One-Time update failed: " .. k .. ": " .. err )
                profile.runOnce[ k ] = nil
            end
        end
    end
end


-- Display Controls
--    Single Display -- single vs. auto in one display.
--    Dual Display   -- single in one display, aoe in another.
--    Hybrid Display -- automatic in one display, can toggle to single/AOE.

local displayTemplate = {
    enabled = true,

    numIcons = 4,

    primaryWidth = 50,
    primaryHeight = 50,

    elvuiCooldown = false,

    keepAspectRatio = true,
    zoom = 30,

    frameStrata = "LOW",
    frameLevel = 10,

    queue = {
        anchor = 'RIGHT',
        direction = 'RIGHT',
        style = 'RIGHT',
        alignment = 'CENTER',

        width = 50,
        height = 50,

        -- offset = 5, -- deprecated.
        offsetX = 5,
        offsetY = 0,
        spacing = 5,

        elvuiCooldown = false,

        --[[ font = ElvUI and 'PT Sans Narrow' or 'Arial Narrow',
        fontSize = 12,
        fontStyle = "OUTLINE" ]]
    },

    visibility = {
        advanced = false,

        mode = {
            aoe = true,
            automatic = true,
            dual = true,
            single = true,
            reactive = true,
        },

        pve = {
            alpha = 1,
            always = 1,
            target = 1,
            combat = 1,
            combatTarget = 1,
            hideMounted = false,
        },

        pvp = {
            alpha = 1,
            always = 1,
            target = 1,
            combat = 1,
            combatTarget = 1,
            hideMounted = false,
        },
    },

    border = {
        enabled = true,
        width = 1,
        coloring = 'custom',
        color = { 0, 0, 0, 1 },
    },

    range = {
        enabled = true,
        type = 'ability',
    },

    glow = {
        enabled = false,
        queued = false,
        mode = "autocast",
        coloring = "default",
        color = { 0.95, 0.95, 0.32, 1 },
    },

    flash = {
        enabled = false,
        color = { 255/255, 215/255, 0, 1 }, -- gold.
        brightness = 100,
        size = 240,
        blink = false,
        suppress = false,
    },

    captions = {
        enabled = false,
        queued = false,

        align = "CENTER",
        anchor = "BOTTOM",
        x = 0,
        y = 0,

        font = ElvUI and 'PT Sans Narrow' or 'Arial Narrow',
        fontSize = 12,
        fontStyle = "OUTLINE",

        color = { 1, 1, 1, 1 },
    },

    indicators = {
        enabled = true,
        queued = true,

        anchor = "RIGHT",
        x = 0,
        y = 0,
    },

    targets = {
        enabled = true,

        font = ElvUI and 'PT Sans Narrow' or 'Arial Narrow',
        fontSize = 12,
        fontStyle = "OUTLINE",

        anchor = "BOTTOMRIGHT",
        x = 0,
        y = 0,

        color = { 1, 1, 1, 1 },
    },

    delays = {
        type = "__NA",
        fade = false,
        extend = true,
        elvuiCooldowns = false,

        font = ElvUI and 'PT Sans Narrow' or 'Arial Narrow',
        fontSize = 12,
        fontStyle = "OUTLINE",

        anchor = "TOPLEFT",
        x = 0,
        y = 0,

        color = { 1, 1, 1, 1 },
    },

    keybindings = {
        enabled = true,
        queued = true,

        font = ElvUI and "PT Sans Narrow" or "Arial Narrow",
        fontSize = 12,
        fontStyle = "OUTLINE",

        lowercase = false,

        queuedFont = ElvUI and "PT Sans Narrow" or "Arial Narrow",
        queuedFontSize = 12,
        queuedFontStyle = "OUTLINE",

        queuedLowercase = false,

        anchor = "TOPRIGHT",
        x = 1,
        y = -1,

        cPortOverride = true,
        cPortZoom = 0.6,

        color = { 1, 1, 1, 1 },
        queuedColor = { 1, 1, 1, 1 },
    },

}


local actionTemplate = {
    action = "heart_essence",
    enabled = true,
    criteria = "",
    caption = "",
    description = "",

    -- Shared Modifiers
    early_chain_if = "",  -- NYI

    cycle_targets = 0,
    max_cycle_targets = 3,
    max_energy = 0,

    interrupt = 0,  --NYI
    interrupt_if = "",  --NYI
    interrupt_immediate = 0,  -- NYI

    travel_speed = nil,

    enable_moving = false,
    moving = nil,
    sync = "",

    use_while_casting = 0,
    use_off_gcd = 0,

    wait_on_ready = 0, -- NYI

    -- Call/Run Action List
    list_name = nil,
    strict = nil,

    -- Pool Resource
    wait = "0.5",
    for_next = 0,
    extra_amount = "0",

    -- Potion
    potion = "default",

    -- Variable
    op = "set",
    condition = "",
    default = "",
    value = "",
    value_else = "",
    var_name = "unnamed",

    -- Wait
    sec = "1",
}


local packTemplate = {
    spec = 0,
    builtIn = false,

    author = UnitName("player"),
    desc = "这个技能优先级配置基于Hekili汉化版制作。",
    source = "",
    date = tonumber( date("%Y%M%D.%H%M") ),
    warnings = "",

    hidden = false,

    lists = {
        precombat = {
            {
                enabled = false,
                action = "heart_essence",
            },
        },
        default = {
            {
                enabled = false,
                action = "heart_essence",
            },
        },
    }
}

local specTemplate = ns.specTemplate


do
    local defaults

    -- Default Table
    function Hekili:GetDefaults()
        defaults = defaults or {
            global = {
                styles = {},
            },

            profile = {
                enabled = true,
                minimapIcon = false,
                autoSnapshot = true,
                screenshot = true,

                -- SpellFlash shared.
                flashTexture = "Interface\\Cooldown\\star4",
                fixedSize = false,
                fixedBrightness = false,

                toggles = {
                    pause = {
                        key = "ALT-SHIFT-P",
                    },

                    snapshot = {
                        key = "ALT-SHIFT-[",
                    },

                    mode = {
                        key = "ALT-SHIFT-N",
                        -- type = "AutoSingle",
                        automatic = true,
                        single = true,
                        value = "automatic",
                    },

                    cooldowns = {
                        key = "ALT-SHIFT-R",
                        value = false,
                        override = false,
                        separate = false,
                    },

                    defensives = {
                        key = "ALT-SHIFT-T",
                        value = false,
                        separate = false,
                    },

                    potions = {
                        key = "",
                        value = false,
                    },

                    interrupts = {
                        key = "ALT-SHIFT-I",
                        value = false,
                        separate = false,
                    },

                    essences = {
                        key = "ALT-SHIFT-G",
                        value = true,
                        override = true,
                    },

                    custom1 = {
                        key = "",
                        value = false,
                        name = "自定义#1"
                    },

                    custom2 = {
                        key = "",
                        value = false,
                        name = "自定义#2"
                    }
                },

                specs = {
                    ['**'] = specTemplate
                },

                packs = {
                    ['**'] = packTemplate
                },

                notifications = {
                    enabled = true,

                    x = 0,
                    y = 0,

                    font = ElvUI and "Expressway" or "Arial Narrow",
                    fontSize = 20,
                    fontStyle = "OUTLINE",

                    width = 600,
                    height = 40,
                },

                displays = {
                    Primary = {
                        enabled = true,
                        builtIn = true,

                    	name = "主显示",

                        relativeTo = "SCREEN",
                        displayPoint = "TOP",
                        anchorPoint = "BOTTOM",

                        x = 0,
                        y = -225,

                        numIcons = 3,
                        order = 1,

                        flash = {
                            color = { 1, 0, 0, 1 },
                        },

                        glow = {
                            enabled = true,
                            mode = "autocast"
                        },
                    },

                    AOE = {
                        enabled = true,
                        builtIn = true,

                        name = "AOE",

                        x = 0,
                        y = -170,

                        numIcons = 3,
                        order = 2,

                        flash = {
                            color = { 0, 1, 0, 1 },
                        },

                        glow = {
                            enabled = true,
                            mode = "autocast",
                        },
                    },

                    Cooldowns = {
                        enabled = true,
                        builtIn = true,

                        name = "爆发",
                        filter = 'cooldowns',

                        x = 0,
                        y = -280,

                        numIcons = 1,
                        order = 3,

                        flash = {
                            color = { 1, 0.82, 0, 1 },
                        },

                        glow = {
                            enabled = true,
                            mode = "autocast",
                        },
                    },

                    Defensives = {
                        enabled = true,
                        builtIn = true,

                        name = "防御",
                        filter = 'defensives',

                        x = -110,
                        y = -225,

                        numIcons = 1,
                        order = 4,

                        flash = {
                            color = { 0.522, 0.302, 1, 1 },
                        },

                        glow = {
                            enabled = true,
                            mode = "autocast",
                        },
                    },

                    Interrupts = {
                        enabled = true,
                        builtIn = true,

                        name = "打断",
                        filter = 'interrupts',

                        x = -55,
                        y = -225,

                        numIcons = 1,
                        order = 5,

                        flash = {
                            color = { 1, 1, 1, 1 },
                        },

                        glow = {
                            enabled = true,
                            mode = "autocast",
                        },
                    },

                    ['**'] = displayTemplate
                },

                -- STILL NEED TO REVISE.
                Clash = 0,
                -- (above)

                runOnce = {
                },

                clashes = {
                },
                trinkets = {
                    ['**'] = {
                        disabled = false,
                        minimum = 0,
                        maximum = 0,
                    }
                },

                interrupts = {
                    pvp = {},
                    encounters = {},
                },

                iconStore = {
                    hide = false,
                },
            },
        }

        for id, spec in pairs( class.specs ) do
            if id > 0 then
                defaults.profile.specs[ id ] = defaults.profile.specs[ id ] or tableCopy( specTemplate )
                for k, v in pairs( spec.options ) do
                    defaults.profile.specs[ id ][ k ] = v
                end
            end
        end

        return defaults
    end
end


do
    local shareDB = {
        displays = {},
        styleName = "",
        export = "",
        exportStage = 0,

        import = "",
        imported = {},
        importStage = 0
    }

    function Hekili:GetDisplayShareOption( info )
        local n = #info
        local option = info[ n ]

        if shareDB[ option ] then return shareDB[ option ] end
        return shareDB.displays[ option ]
    end


    function Hekili:SetDisplayShareOption( info, val, v2, v3, v4 )
        local n = #info
        local option = info[ n ]

        if type(val) == 'string' then val = val:trim() end
        if shareDB[ option ] then shareDB[ option ] = val; return end

        shareDB.displays[ option ] = val
        shareDB.export = ""
    end



    local multiDisplays = {
        Primary = true,
        AOE = true,
        Cooldowns = false,
        Defensives = false,
        Interrupts = false,
    }

    local frameStratas = ns.FrameStratas

    -- Display Config.
    function Hekili:GetDisplayOption( info )
        local n = #info
        local display, category, option = info[ 2 ], info[ 3 ], info[ n ]

        if category == "shareDisplays" then
            return self:GetDisplayShareOption( info )
        end

        local conf = self.DB.profile.displays[ display ]

        if category ~= option and category ~= "main" then
            conf = conf[ category ]
        end

        if option == "color" or option == "queuedColor" then return unpack( conf.color ) end
        if option == "frameStrata" then return frameStratas[ conf.frameStrata ] or 3 end
        if option == "name" then return display end

        return conf[ option ]
    end

    local multiSet = false
    local rebuild = false

    local function QueueRebuildUI()
        rebuild = true
        C_Timer.After( 0.5, function ()
            if rebuild then
                Hekili:BuildUI()
                rebuild = false
            end
        end )
    end

    function Hekili:SetDisplayOption( info, val, v2, v3, v4 )
        local n = #info
        local display, category, option = info[ 2 ], info[ 3 ], info[ n ]
        local set = false

        local all = false

        if category == "shareDisplays" then
            self:SetDisplayShareOption( info, val, v2, v3, v4 )
            return
        end

        local conf = self.DB.profile.displays[ display ]
        if category ~= option and category ~= 'main' then conf = conf[ category ] end

        if option == 'color' or option == 'queuedColor' then
            conf[ option ] = { val, v2, v3, v4 }
            set = true
        elseif option == 'frameStrata' then
            conf.frameStrata = frameStratas[ val ] or "LOW"
            set = true
        end

        if not set then
            val = type( val ) == 'string' and val:trim() or val
            conf[ option ] = val
        end

        if not multiSet then QueueRebuildUI() end
    end


    function Hekili:GetMultiDisplayOption( info )
        info[ 2 ] = "Primary"
        local val, v2, v3, v4 = self:GetDisplayOption( info )
        info[ 2 ] = "Multi"
        return val, v2, v3, v4
    end

    function Hekili:SetMultiDisplayOption( info, val, v2, v3, v4 )
        multiSet = true

        local orig = info[ 2 ]

        for display, active in pairs( multiDisplays ) do
            if active then
                info[ 2 ] = display
                self:SetDisplayOption( info, val, v2, v3, v4 )
            end
        end
        QueueRebuildUI()
        info[ 2 ] = orig

        multiSet = false
    end


    local function GetNotifOption( info )
        local n = #info
        local option = info[ n ]

        local conf = Hekili.DB.profile.notifications

        return conf[ option ]
    end

    local function SetNotifOption( info, val )
        local n = #info
        local option = info[ n ]

        local conf = Hekili.DB.profile.notifications

        conf[ option ] = val
        QueueRebuildUI()
    end

    local LSM = LibStub( "LibSharedMedia-3.0" )
    local SF = SpellFlashCore

    local fontStyles = {
        ["MONOCHROME"] = "单色",
        ["MONOCHROME,OUTLINE"] = "单色，描边",
        ["MONOCHROME,THICKOUTLINE"] = "单色，粗描边",
        ["NONE"] = "无",
        ["OUTLINE"] = "描边",
        ["THICKOUTLINE"] = "粗描边"
    }

    local fontElements = {
        font = {
            type = "select",
            name = "字体",
            order = 1,
            width = 1.49,
            dialogControl = 'LSM30_Font',
            values = LSM:HashTable("font"),
        },

        fontStyle = {
            type = "select",
            name = "样式",
            order = 2,
            values = fontStyles,
            width = 1.49
        },

        break01 = {
            type = "description",
            name = " ",
            order = 2.1,
            width = "full"
        },

        fontSize = {
            type = "range",
            name = "尺寸",
            order = 3,
            min = 8,
            max = 64,
            step = 1,
            width = 1.49
        },

        color = {
            type = "color",
            name = "颜色",
            order = 4,
            width = 1.49
        }
    }

    local anchorPositions = {
        TOP = '顶部',
        TOPLEFT = '顶部左侧',
        TOPRIGHT = '顶部右侧',
        BOTTOM = '底部',
        BOTTOMLEFT = '底部左侧',
        BOTTOMRIGHT = '底部右侧',
        LEFT = '左侧',
        LEFTTOP = '左侧上部',
        LEFTBOTTOM = '左侧下部',
        RIGHT = '右侧',
        RIGHTTOP = '右侧上部',
        RIGHTBOTTOM = '右侧下部',
    }


    local realAnchorPositions = {
        TOP = '顶部',
        TOPLEFT = '顶部左侧',
        TOPRIGHT = '顶部右侧',
        BOTTOM = '底部',
        BOTTOMLEFT = '底部左侧',
        BOTTOMRIGHT = '底部右侧',
        CENTER = "中间",
        LEFT = '左侧',
        RIGHT = '右侧',
    }


    local function getOptionTable( info, notif )
        local disp = info[2]
        local tab = Hekili.Options.args.displays

        if notif then
            tab = tab.args.nPanel
        else
            tab = tab.plugins[ disp ][ disp ]
        end

        for i = 3, #info do
            tab = tab.args[ info[i] ]
        end

        return tab
    end

    local function rangeXY( info, notif )
        local tab = getOptionTable( info, notif )

        local resolution = GetCVar( "gxWindowedResolution" ) or "1280x720"
        local width, height = resolution:match( "(%d+)x(%d+)" )

        width = tonumber( width )
        height = tonumber( height )

        tab.args.x.min = -1 * width
        tab.args.x.max = width
        tab.args.x.softMin = -1 * width * 0.5
        tab.args.x.softMax = width * 0.5

        tab.args.y.min = -1 * height
        tab.args.y.max = height
        tab.args.y.softMin = -1 * height * 0.5
        tab.args.y.softMax = height * 0.5
    end


    local function setWidth( info, field, condition, if_true, if_false )
        local tab = getOptionTable( info )

        if condition then
            tab.args[ field ].width = if_true or "full"
        else
            tab.args[ field ].width = if_false or "full"
        end
    end


    local function rangeIcon( info )
        local tab = getOptionTable( info )

        local display = info[2]
        display = display == "Multi" and "Primary" or display

        local data = display and Hekili.DB.profile.displays[ display ]

        if data then
            tab.args.x.min = -1 * max( data.primaryWidth, data.queue.width )
            tab.args.x.max = max( data.primaryWidth, data.queue.width )

            tab.args.y.min = -1 * max( data.primaryHeight, data.queue.height )
            tab.args.y.max = max( data.primaryHeight, data.queue.height )

            return
        end

        tab.args.x.min = -50
        tab.args.x.max = 50

        tab.args.y.min = -50
        tab.args.y.max = 50
    end


    local dispCycle = { "Primary", "AOE", "Cooldowns", "Defensives", "Interrupts" }

    local MakeMultiDisplayOption
    local modified = {}

    local function GetOptionData( db, info )
        local display = info[ 2 ]
        local option = db[ display ][ display ]
        local desc, set, get = nil, option.set, option.get

        for i = 3, #info do
            local category = info[ i ]

            if not option then
                break

            elseif option.args then
                if not option.args[ category ] then
                    break
                end
                option = option.args[ category ]

            else
                break
            end

            get = option and option.get or get
            set = option and option.set or set
            desc = option and option.desc or desc
        end

        return option, get, set, desc
    end

    local function WrapSetter( db, data )
        local _, _, setfunc = GetOptionData( db, data )
        if setfunc and modified[ setfunc ] then return setfunc end

        local newFunc = function( info, val, v2, v3, v4 )
            multiSet = true

            for display, active in pairs( multiDisplays ) do
                if active then
                    info[ 2 ] = display

                    _, _, setfunc = GetOptionData( db, info )

                    if type( setfunc ) == "string" then
                        Hekili[ setfunc ]( Hekili, info, val, v2, v3, v4 )
                    elseif type( setfunc ) == "function" then
                        setfunc( info, val, v2, v3, v4 )
                    end
                end
            end

            multiSet = false

            info[ 2 ] = "Multi"
            QueueRebuildUI()
        end

        modified[ newFunc ] = true
        return newFunc
    end

    local function WrapDesc( db, data )
        local option, _, _, descfunc = GetOptionData( db, data )
        if descfunc and modified[ descfunc ] then
            return descfunc
        end

        local newFunc = function( info )
            local output

            for _, display in ipairs( dispCycle ) do
                info[ 2 ] = display
                option, getfunc, _, descfunc = GetOptionData( db, info )

                if not output then
                    output = option and type( option.desc ) == "function" and ( option.desc( info ) or "" ) or ( option.desc or "" )
                    if output:len() > 0 then output = output .. "\n" end
                end

                local val, v2, v3, v4

                if not getfunc then
                    val, v2, v3, v4 = Hekili:GetDisplayOption( info )
                elseif type( getfunc ) == "function" then
                    val, v2, v3, v4 = getfunc( info )
                elseif type( getfunc ) == "string" then
                    val, v2, v3, v4 = Hekili[ getfunc ]( Hekili, info )
                end

                if val == nil then
                    Hekili:Error( "无法从WrapDesc获取%s的值。", table.concat( info, "：" ) )
                    info[ 2 ] = "Multi"
                    return output
                end

                -- Sanitize/format values.
                if type( val ) == "boolean" then
                    val = val and "|cFF00FF00勾选|r" or "|cFFFF0000未勾选|r"

                elseif option.type == "color" then
                    val = string.format( "|A:WhiteCircle-RaidBlips:16:16:0:0:%d:%d:%d|a |cFFFFD100#%02x%02x%02x|r", val * 255, v2 * 255, v3 * 255, val * 255, v2 * 255, v3 * 255 )

                elseif option.type == "select" and option.values and not option.dialogControl then
                    if type( option.values ) == "function" then
                        val = option.values( data )[ val ] or val
                    else
                        val = option.values[ val ] or val
                    end

                    if type( val ) == "number" then
                        if val % 1 == 0 then
                            val = format( "|cFFFFD100%d|r", val )
                        else
                            val = format( "|cFFFFD100%.2f|r", val )
                        end
                    else
                        val = format( "|cFFFFD100%s|r", tostring( val ) )
                    end

                elseif type( val ) == "number" then
                    if val % 1 == 0 then
                        val = format( "|cFFFFD100%d|r", val )
                    else
                        val = format( "|cFFFFD100%.2f|r", val )
                    end

                else
                    if val == nil then
                        Hekili:Error( "未找到%s的值，默认设置为'???'.", table.concat( data, "：" ))
                        val = "|cFFFF0000???|r"
                    else
                        val = "|cFFFFD100" .. val .. "|r"
                    end
                end

                output = format( "%s%s%s%s:|r %s", output, output:len() > 0 and "\n" or "", BlizzBlue, display, val )
            end

            info[ 2 ] = "Multi"
            return output
        end

        modified[ newFunc ] = true
        return newFunc
    end

    local function GetDeepestSetter( db, info )
        local position = db.Multi.Multi
        local setter

        for i = 3, #info - 1 do
            local key = info[ i ]
            position = position.args[ key ]

            local setfunc = rawget( position, "set" )

            if setfunc and type( setfunc ) == "function" then
                setter = setfunc
            end
        end

        return setter
    end

    MakeMultiDisplayOption = function( db, t, inf )
        local info = {}

        if not inf or #inf == 0 then
            info[1] = "displays"
            info[2] = "Multi"

            for k, v in pairs( t ) do
                -- Only load groups in the first level (bypasses selection for which display to edit).
                if v.type == "group" then
                    info[3] = k
                    MakeMultiDisplayOption( db, v.args, info )
                    info[3] = nil
                end
            end

            return

        else
            for i, v in ipairs( inf ) do
                info[ i ] = v
            end
        end

        for k, v in pairs( t ) do
            if k:match( "^MultiMod" ) then
                -- do nothing.
            elseif v.type == "group" then
                info[ #info + 1 ] = k
                MakeMultiDisplayOption( db, v.args, info )
                info[ #info ] = nil
            elseif inf and v.type ~= "description" then
                info[ #info + 1 ] = k
                v.desc = WrapDesc( db, info )

                if rawget( v, "set" ) then
                    v.set = WrapSetter( db, info )
                else
                    local setfunc = GetDeepestSetter( db, info )
                    if setfunc then v.set = WrapSetter( db, info ) end
                end

                info[ #info ] = nil
            end
        end
    end


    local function newDisplayOption( db, name, data, pos )
        name = tostring( name )

        local fancyName

        if name == "Multi" then fancyName = AtlasToString( "auctionhouse-icon-favorite" ) .. " 统一设置"
        elseif name == "Defensives" then fancyName = AtlasToString( "nameplates-InterruptShield" ) .. " 防御"
        elseif name == "Interrupts" then fancyName = AtlasToString( "voicechat-icon-speaker-mute" ) .. " 打断"
        elseif name == "Cooldowns" then fancyName = AtlasToString( "VignetteEventElite" ) .. " 爆发"
        else fancyName = name end

        local option = {
            ['btn'..name] = {
                type = 'execute',
                name = fancyName,
                desc = data.desc,
                order = 10 + pos,
                func = function () ACD:SelectGroup( "Hekili", "displays", name ) end,
            },

            [name] = {
                type = 'group',
                name = function ()
                    if name == "Multi" then return "|cFF00FF00" .. fancyName .. "|r"
                    elseif data.builtIn then return '|cFF00B4FF' .. fancyName .. '|r' end
                    return fancyName
                end,
                desc = function ()
                    if name == "Multi" then
                        return "同时对多个显示框架进行设置。当前显示的设置项来自主显示框架（其他框架的设置项显示在鼠标指向提示中）。\n\n部分选项不可在统一设置中使用。"
                    end
                    return data.desc
                end,
                set = name == "Multi" and "SetMultiDisplayOption" or "SetDisplayOption",
                get = name == "Multi" and "GetMultiDisplayOption" or "GetDisplayOption",
                childGroups = "tab",
                order = 100 + pos,

                args = {
                    MultiModPrimary = {
                        type = "toggle",
                        name = function() return multiDisplays.Primary and "|cFF00FF00主显示|r" or "|cFFFF0000主显示|r" end,
                        desc = function()
                            if multiDisplays.Primary then return "更改|cFF00FF00将会|r应用于主显示框架。" end
                            return "更改|cFFFF0000将不会|r应用于主显示框架。"
                        end,
                        order = 0.01,
                        width = 0.65,
                        get = function() return multiDisplays.Primary end,
                        set = function() multiDisplays.Primary = not multiDisplays.Primary end,
                        hidden = function () return name ~= "Multi" end,
                    },
                    MultiModAOE = {
                        type = "toggle",
                        name = function() return multiDisplays.AOE and "|cFF00FF00AOE|r" or "|cFFFF0000AOE|r" end,
                        desc = function()
                            if multiDisplays.AOE then return "更改|cFF00FF00将会|r应用于AOE显示框架。" end
                            return "更改|cFFFF0000将不会|r应用于AOE显示框架。"
                        end,
                        order = 0.02,
                        width = 0.65,
                        get = function() return multiDisplays.AOE end,
                        set = function() multiDisplays.AOE = not multiDisplays.AOE end,
                        hidden = function () return name ~= "Multi" end,
                    },
                    MultiModCooldowns = {
                        type = "toggle",
                        name = function () return AtlasToString( "VignetteEventElite" ) .. ( multiDisplays.Cooldowns and " |cFF00FF00爆发|r" or " |cFFFF0000爆发|r" ) end,
                        desc = function()
                            if multiDisplays.Cooldowns then return "更改|cFF00FF00将会|r应用于爆发显示框架。" end
                            return "更改|cFFFF0000将不会|r应用于爆发显示框架。"
                        end,
                        order = 0.03,
                        width = 0.65,
                        get = function() return multiDisplays.Cooldowns end,
                        set = function() multiDisplays.Cooldowns = not multiDisplays.Cooldowns end,
                        hidden = function () return name ~= "Multi" end,
                    },
                    MultiModDefensives = {
                        type = "toggle",
                        name = function () return AtlasToString( "nameplates-InterruptShield" ) .. ( multiDisplays.Defensives and " |cFF00FF00防御|r" or " |cFFFF0000防御|r" ) end,
                        desc = function()
                            if multiDisplays.Defensives then return "更改|cFF00FF00将会|r应用于防御显示框架。" end
                            return "更改|cFFFF0000将不会|r应用于爆发显示框架。"
                        end,
                        order = 0.04,
                        width = 0.65,
                        get = function() return multiDisplays.Defensives end,
                        set = function() multiDisplays.Defensives = not multiDisplays.Defensives end,
                        hidden = function () return name ~= "Multi" end,
                    },
                    MultiModInterrupts = {
                        type = "toggle",
                        name = function () return AtlasToString( "voicechat-icon-speaker-mute" ) .. ( multiDisplays.Interrupts and " |cFF00FF00打断|r" or " |cFFFF0000打断|r" ) end,
                        desc = function()
                            if multiDisplays.Interrupts then return "更改|cFF00FF00将会|r应用于打断显示框架。" end
                            return "更改|cFFFF0000将不会|r应用于打断显示框架。"
                        end,
                        order = 0.05,
                        width = 0.65,
                        get = function() return multiDisplays.Interrupts end,
                        set = function() multiDisplays.Interrupts = not multiDisplays.Interrupts end,
                        hidden = function () return name ~= "Multi" end,
                    },
                    main = {
                        type = 'group',
                        name = "主页",
                        desc = "包括显示位置、图标、图标大小和形状等等。",
                        order = 1,

                        args = {
                            enabled = {
                                type = "toggle",
                                name = "启用",
                                desc = "如果禁用，该显示区域在任何情况下都不会显示。",
                                order = 0.5,
                                hidden = function () return data.name == "Primary" or data.name == "AOE" or data.name == "Cooldowns"  or data.name == "Defensives" or data.name == "Interrupts" end
                            },

                            elvuiCooldown = {
                                type = "toggle",
                                name = "使用ElvUI的冷却样式",
                                desc = "如果安装了ElvUI，你可以在推荐队列中使用ElvUI的冷却样式。\n\n禁用此设置需要重新加载UI (|cFFFFD100/reload|r)。",
                                width = "full",
                                order = 0.51,
                                hidden = function () return _G["ElvUI"] == nil end,
                            },

                            numIcons = {
                                type = 'range',
                                name = "图标显示",
                                desc = "设置建议技能的显示数量。每个图标都会提前显示。",
                                min = 1,
                                max = 10,
                                step = 1,
                                width = "full",
                                order = 1,
                                disabled = function()
                                    return name == "Multi"
                                end,
                                hidden = function( info, val )
                                    local n = #info
                                    local display = info[2]

                                    if display == "Defensives" or display == "Interrupts" then
                                        return true
                                    end

                                    return false
                                end,
                            },

                            pos = {
                                type = "group",
                                inline = true,
                                name = function( info ) rangeXY( info ); return "位置" end,
                                order = 10,

                                args = {
                                    --[[
                                    relativeTo = {
                                        type = "select",
                                        name = "锚定到",
                                        values = {
                                            SCREEN = "屏幕",
                                            PERSONAL = "角色资源条",
                                            CUSTOM = "自定义"
                                        },
                                        order = 1,
                                        width = 1.49,
                                    },

                                    customFrame = {
                                        type = "input",
                                        name = "自定义框架",
                                        desc = "指定该自定义锚定位置框架的名称。\n" ..
                                                "如果框架不存在，则不会显示。",
                                        order = 1.1,
                                        width = 1.49,
                                        hidden = function() return data.relativeTo ~= "CUSTOM" end,
                                    },

                                    setParent = {
                                        type = "toggle",
                                        name = "设置父对象为锚点",
                                        desc = "如果勾选，则会在显示或隐藏锚点时同步显示隐藏。",
                                        order = 3.9,
                                        width = 1.49,
                                        hidden = function() return data.relativeTo == "SCREEN" end,
                                    },

                                    preXY = {
                                        type = "description",
                                        name = " ",
                                        width = "full",
                                        order = 97
                                    }, ]]

                                    x = {
                                        type = "range",
                                        name = "X",
                                        desc = "设置该显示区域主图标相对于屏幕中心的水平位置。" ..
                                            "负值代表显示区域向左移动，正值向右。",
                                        min = -512,
                                        max = 512,
                                        step = 1,

                                        order = 98,
                                        width = 1.49,

                                        disabled = function()
                                            return name == "Multi"
                                        end,
                                    },

                                    y = {
                                        type = "range",
                                        name = "Y",
                                        desc = "设置该显示区域主图标相对于屏幕中心的垂直位置。" ..
                                            "负值代表显示区域向下移动，正值向上。",
                                        min = -384,
                                        max = 384,
                                        step = 1,

                                        order = 99,
                                        width = 1.49,

                                        disabled = function()
                                            return name == "Multi"
                                        end,
                                    },
                                },
                            },

                            primaryIcon = {
                                type = "group",
                                name = "主图标",
                                inline = true,
                                order = 15,
                                args = {
                                    primaryWidth = {
                                        type = "range",
                                        name = "宽度",
                                        desc = "为你的" .. name .. "显示区域主图标设置显示宽度。",
                                        min = 10,
                                        max = 500,
                                        step = 1,

                                        width = 1.49,
                                        order = 1,
                                    },

                                    primaryHeight = {
                                        type = "range",
                                        name = "高度",
                                        desc = "为你的" .. name .. "显示区域主图标设置显示高度。",
                                        min = 10,
                                        max = 500,
                                        step = 1,

                                        width = 1.49,
                                        order = 2,
                                    },

                                    spacer01 = {
                                        type = "description",
                                        name = " ",
                                        width = "full",
                                        order = 3
                                    },

                                    zoom = {
                                        type = "range",
                                        name = "图标缩放",
                                        desc = "选择此显示区域中图标图案的缩放百分比（30%大约是暴雪的原始值）。",
                                        min = 0,
                                        softMax = 100,
                                        max = 200,
                                        step = 1,

                                        width = 1.49,
                                        order = 4,
                                    },

                                    keepAspectRatio = {
                                        type = "toggle",
                                        name = "保持纵横比",
                                        desc = "如果主图标或队列中的图标不是正方形，勾选此项将无法图标缩放，" ..
                                            "变为裁切部分图标图案。",
                                        disabled = function( info, val )
                                            return not ( data.primaryHeight ~= data.primaryWidth or ( data.numIcons > 1 and data.queue.height ~= data.queue.width ) )
                                        end,
                                        width = 1.49,
                                        order = 5,
                                    },
                                },
                            },

                            advancedFrame = {
                                type = "group",
                                name = "框架层级",
                                inline = true,
                                order = 16,
                                args = {
                                    frameStrata = {
                                        type = "select",
                                        name = "层级",
                                        desc =  "框架层级决定了在哪个图形层上绘制此显示区域。\n" ..
                                            "默认层级是中间层。",
                                        values = {
                                            "背景层",
                                            "底层",
                                            "中间层",
                                            "高层",
                                            "对话层",
                                            "全屏",
                                            "全屏对话层",
                                            "提示层"
                                        },
                                        width = 1.49,
                                        order = 1,
                                    },

                                    frameLevel = {
                                        type = "range",
                                        name = "优先级",
                                        desc = "框架优先级决定了显示区域在当前层中的显示优先级。.\n\n" ..
                                            "默认值是|cFFFFD10010|r.",
                                        min = 1,
                                        max = 10000,
                                        step = 1,
                                        width = 1.49,
                                        order = 2,
                                    }
                                }
                            },
                        },
                    },

                    queue = {
                        type = "group",
                        name = "队列",
                        desc = "当显示区域显示多个技能图标时，在此对定位、大小、形状和位置进行设置。",
                        order = 2,
                        disabled = function ()
                            return data.numIcons == 1
                        end,

                        args = {
                            elvuiCooldown = {
                                type = "toggle",
                                name = "使用ElvUI的冷却样式",
                                desc = "如果安装了ElvUI，你可以在推荐队列中使用ElvUI的冷却样式。\n\n禁用此设置需要重新加载UI (|cFFFFD100/reload|r)。",
                                width = "full",
                                order = 1,
                                hidden = function () return _G["ElvUI"] == nil end,
                            },

                            iconSizeGroup = {
                                type = "group",
                                inline = true,
                                name = "图标大小",
                                order = 2,
                                args = {
                                    width = {
                                        type = 'range',
                                        name = '宽度',
                                        desc = "设置队列中图标的宽度。",
                                        min = 10,
                                        max = 500,
                                        step = 1,
                                        bigStep = 1,
                                        order = 10,
                                        width = 1.49
                                    },

                                    height = {
                                        type = 'range',
                                        name = '高度',
                                        desc = "设置队列中图标的高度。",
                                        min = 10,
                                        max = 500,
                                        step = 1,
                                        bigStep = 1,
                                        order = 11,
                                        width = 1.49
                                    },
                                }
                            },

                            anchorGroup = {
                                type = "group",
                                inline = true,
                                name = "定位",
                                order = 3,
                                args = {
                                    anchor = {
                                        type = 'select',
                                        name = '锚定到',
                                        desc = "在主图标上选择队列图标附加到的位置。",
                                        values = anchorPositions,
                                        width = 1.49,
                                        order = 1,
                                    },

                                    direction = {
                                        type = 'select',
                                	name = '排列方向',
                                	desc = "设置队列图标的排列方向。",
                                        values = {
                                    		TOP = '向上',
                                    		BOTTOM = '向下',
                                    		LEFT = '向左',
                                    		RIGHT = '向右'
                                        },
                                        width = 1.49,
                                        order = 1.1,
                                    },

                                    spacer01 = {
                                        type = "description",
                                        name = " ",
                                        order = 1.2,
                                        width = "full",
                                    },

                                    offsetX = {
                                        type = 'range',
                                        name = '队列水平偏移',
                                        desc = '设置主图标后方队列图标显示位置的水平偏移量（单位为像素）。正数向右，负数向左。',
                                        min = -100,
                                        max = 500,
                                        step = 1,
                                        width = 1.49,
                                        order = 2,
                                    },

                                    offsetY = {
                                        type = 'range',
                                        name = '队列垂直偏移',
                                        desc = '设置主图标后方队列图标显示位置的垂直偏移量（单位为像素）。正数向上，负数向下。',
                                        min = -100,
                                        max = 500,
                                        step = 1,
                                        width = 1.49,
                                        order = 2.1,
                                    },

                                    spacer02 = {
                                        type = "description",
                                        name = " ",
                                        order = 2.2,
                                        width = "full",
                                    },

                                    spacing = {
                                        type = 'range',
                                	name = '间距',
	                                desc = "设置队列图标的间距像素。",
                                        softMin = ( data.queue.direction == "LEFT" or data.queue.direction == "RIGHT" ) and -data.queue.width or -data.queue.height,
                                        softMax = ( data.queue.direction == "LEFT" or data.queue.direction == "RIGHT" ) and data.queue.width or data.queue.height,
                                        min = -500,
                                        max = 500,
                                        step = 1,
                                        order = 3,
                                        width = 2.98
                                    },
                                }
                            },
                        },
                    },

                    visibility = {
                        type = 'group',
                        name = '透明度',
                        desc = "PvE和PvP模式下不同的透明度设置。",
                        order = 3,

                        args = {

                            advanced = {
                                type = "toggle",
                                name = "进阶设置",
                                desc = "如果勾选，将提供更多关于透明度的细节选项。",
                                width = "full",
                                order = 1,
                            },

                            simple = {
                                type = 'group',
                                inline = true,
                                name = "",
                                hidden = function() return data.visibility.advanced end,
                                get = function( info )
                                    local option = info[ #info ]

                                    if option == 'pveAlpha' then return data.visibility.pve.alpha
                                    elseif option == 'pvpAlpha' then return data.visibility.pvp.alpha end
                                end,
                                set = function( info, val )
                                    local option = info[ #info ]

                                    if option == 'pveAlpha' then data.visibility.pve.alpha = val
                                    elseif option == 'pvpAlpha' then data.visibility.pvp.alpha = val end

                                    QueueRebuildUI()
                                end,
                                order = 2,
                                args = {
                                    pveAlpha = {
                                        type = "range",
                                        name = "PvE透明度",
                                        desc = "设置在PvE战斗中显示区域的透明度。如果设置为0，该显示区域将不会在PvE战斗中显示。",
                                        min = 0,
                                        max = 1,
                                        step = 0.01,
                                        order = 1,
                                        width = 1.49,
                                    },
                                    pvpAlpha = {
                                        type = "range",
                                        name = "PvP透明度",
                                        desc = "设置在PvP战斗中显示区域的透明度。如果设置为0，该显示区域将不会在PvP战斗中显示。",
                                        min = 0,
                                        max = 1,
                                        step = 0.01,
                                        order = 1,
                                        width = 1.49,
                                    },
                                }
                            },

                            pveComplex = {
                                type = 'group',
                                inline = true,
                                name = "PvE",
                                get = function( info )
                                    local option = info[ #info ]

                                    return data.visibility.pve[ option ]
                                end,
                                set = function( info, val )
                                    local option = info[ #info ]

                                    data.visibility.pve[ option ] = val
                                    QueueRebuildUI()
                                end,
                                hidden = function() return not data.visibility.advanced end,
                                order = 2,
                                args = {
                                    always = {
                                        type = "range",
                                        name = "总是",
                                        desc = "如果此项不是0，则在PvE区域无论是否在战斗中，该显示区域都将始终显示。",
                                        min = 0,
                                        max = 1,
                                        step = 0.01,
                                        width = 1.49,
                                        order = 1,
                                    },

                                    combat = {
                                        type = "range",
                                        name = "战斗",
                                        desc = "如果此项不是0，则在PvE战斗中，该显示区域都将始终显示。",
                                        min = 0,
                                        max = 1,
                                        step = 0.01,
                                        width = 1.49,
                                        order = 3,
                                    },

                                    break01 = {
                                        type = "description",
                                        name = " ",
                                        width = "full",
                                        order = 2.1
                                    },

                                    target = {
                                        type = "range",
                                        name = "目标",
                                        desc = "如果此项不是0，则当你有可攻击的PvE目标时，该显示区域都将始终显示。",
                                        min = 0,
                                        max = 1,
                                        step = 0.01,
                                        width = 1.49,
                                        order = 2,
                                    },

                                    combatTarget = {
                                        type = "range",
                                        name = "战斗和目标",
                                        desc = "如果此项不是0，则当你处于战斗状态，且拥有可攻击的PvE目标时，该显示区域都将始终显示。",
                                        min = 0,
                                        max = 1,
                                        step = 0.01,
                                        width = 1.49,
                                        order = 4,
                                    },

                                    hideMounted = {
                                        type = "toggle",
                                        name = "骑乘时隐藏",
                                        desc = "如果勾选，则当你骑乘时，该显示区域隐藏（除非你在战斗中）。",
                                        width = "full",
                                        order = 0.5,
                                    }
                                },
                            },

                            pvpComplex = {
                                type = 'group',
                                inline = true,
                                name = "PvP",
                                get = function( info )
                                    local option = info[ #info ]

                                    return data.visibility.pvp[ option ]
                                end,
                                set = function( info, val )
                                    local option = info[ #info ]

                                    data.visibility.pvp[ option ] = val
                                    QueueRebuildUI()
                                    Hekili:UpdateDisplayVisibility()
                                end,
                                hidden = function() return not data.visibility.advanced end,
                                order = 2,
                                args = {
                                    always = {
                                        type = "range",
                                        name = "总是",
                                        desc = "如果此项不是0，则在PvP区域无论是否在战斗中，该显示区域都将始终显示。",
                                        min = 0,
                                        max = 1,
                                        step = 0.01,
                                        width = 1.49,
                                        order = 1,
                                    },

                                    combat = {
                                        type = "range",
                                        name = "战斗",
                                        desc = "如果此项不是0，则在PvP战斗中，该显示区域都将始终显示。",
                                        min = 0,
                                        max = 1,
                                        step = 0.01,
                                        width = 1.49,
                                        order = 3,
                                    },

                                    break01 = {
                                        type = "description",
                                        name = " ",
                                        width = "full",
                                        order = 2.1
                                    },

                                    target = {
                                        type = "range",
                                        name = "目标",
                                        desc = "如果此项不是0，则当你有可攻击的PvP目标时，该显示区域都将始终显示。",
                                        min = 0,
                                        max = 1,
                                        step = 0.01,
                                        width = 1.49,
                                        order = 2,
                                    },

                                    combatTarget = {
                                        type = "range",
                                        name = "战斗和目标",
                                        desc = "如果此项不是0，则当你处于战斗状态，且拥有可攻击的PvP目标时，该显示区域都将始终显示。",
                                        min = 0,
                                        max = 1,
                                        step = 0.01,
                                        width = 1.49,
                                        order = 4,
                                    },

                                    hideMounted = {
                                        type = "toggle",
                                        name = "骑乘时隐藏",
                                        desc = "如果勾选，则当你骑乘时，该显示区域隐藏（除非你在战斗中）。",
                                        width = "full",
                                        order = 0.5,
                                    }
                                },
                            },
                        },
                    },

                    keybindings = {
                        type = "group",
                        name = "绑定按键",
                        desc = "显示技能图标上绑定按键文本的选项。",
                        order = 7,

                        args = {
                            enabled = {
                                type = "toggle",
                                name = "启用",
                                order = 1,
                                width = 1.49,
                            },

                            queued = {
                                type = "toggle",
                                name = "为队列图标启用",
                                order = 2,
                                width = 1.49,
                                disabled = function () return data.keybindings.enabled == false end,
                            },

                            pos = {
                                type = "group",
                                inline = true,
                                name = function( info ) rangeIcon( info ); return "位置" end,
                                order = 3,
                                args = {
                                    anchor = {
                                        type = "select",
                                        name = '锚点',
                                        order = 2,
                                        width = 1,
                                        values = realAnchorPositions
                                    },

                                    x = {
                                        type = "range",
                                        name = "X轴偏移",
                                        order = 3,
                                        width = 0.99,
                                        min = -max( data.primaryWidth, data.queue.width ),
                                        max = max( data.primaryWidth, data.queue.width ),
                                        disabled = function( info )
                                            return false
                                        end,
                                        step = 1,
                                    },

                                    y = {
                                        type = "range",
                                        name = "Y轴偏移",
                                        order = 4,
                                        width = 0.99,
                                        min = -max( data.primaryHeight, data.queue.height ),
                                        max = max( data.primaryHeight, data.queue.height ),
                                        step = 1,
                                    }
                                }
                            },

                            textStyle = {
                                type = "group",
                                inline = true,
                                name = "文本样式",
                                order = 5,
                                args = tableCopy( fontElements ),
                            },

                            lowercase = {
                                type = "toggle",
                                name = "使用小写字母",
                                order = 5.1,
                                width = "full",
                            },

                            separateQueueStyle = {
                                type = "toggle",
                                name = "队列图标使用不同的设置",
                                order = 6,
                                width = "full",
                            },

                            queuedTextStyle = {
                                type = "group",
                                inline = true,
                                name = "队列图标文本样式",
                                order = 7,
                                hidden = function () return not data.keybindings.separateQueueStyle end,
                                args = {
                                    queuedFont = {
                                        type = "select",
                                        name = "字体",
                                        order = 1,
                                        width = 1.49,
                                        dialogControl = 'LSM30_Font',
                                        values = LSM:HashTable("font"),
                                    },

                                    queuedFontStyle = {
                                        type = "select",
                                        name = "样式",
                                        order = 2,
                                        values = fontStyles,
                                        width = 1.49
                                    },

                                    break01 = {
                                        type = "description",
                                        name = " ",
                                        width = "full",
                                        order = 2.1
                                    },

                                    queuedFontSize = {
                                        type = "range",
                                        name = "尺寸",
                                        order = 3,
                                        min = 8,
                                        max = 64,
                                        step = 1,
                                        width = 1.49
                                    },

                                    queuedColor = {
                                        type = "color",
                                        name = "颜色",
                                        order = 4,
                                        width = 1.49
                                    }
                                },
                            },

                            queuedLowercase = {
                                type = "toggle",
                                name = "队列图标使用小写字母",
                                order = 7.1,
                                width = 1.49,
                                hidden = function () return not data.keybindings.separateQueueStyle end,
                            },

                            cPort = {
                                name = "ConsolePort(一款手柄插件)",
                                type = "group",
                                inline = true,
                                order = 4,
                                args = {
                                    cPortOverride = {
                                        type = "toggle",
                                        name = "使用ConsolePort按键",
                                        order = 6,
                                        width = 1.49,
                                    },

                                    cPortZoom = {
                                        type = "range",
                                        name = "ConsolePort按键缩放",
                                        desc = "ConsolePort按键图标周围通常有大量空白填充。" ..
                                        "为了按键适配图标，放大会裁切一些图案。默认值为|cFFFFD1000.6|r。",
                                        order = 7,
                                        min = 0,
                                        max = 1,
                                        step = 0.01,
                                        width = 1.49,
                                    },
                                },
                                disabled = function() return ConsolePort == nil end,
                            },

                        }
                    },

                    border = {
                        type = "group",
                        name = "边框",
                        desc = "启用/禁用和设置图标边框的颜色。\n\n" ..
                        "如果使用了Masque或类似的图标美化插件，可能需要禁用此功能。",
                        order = 4,

                        args = {
                            enabled = {
                                type = "toggle",
                                name = "启用",
                                desc = "如果勾选，该显示区域中每个图标都会有窄边框。",
                                order = 1,
                                width = "full",
                            },

                            thickness = {
                                type = "range",
                                name = "边框粗细",
                                desc = "设置边框的厚度（粗细）。默认值为1。",
                                softMin = 1,
                                softMax = 20,
                                step = 1,
                                order = 2,
                                width = 1.49,
                            },

                            fit = {
                                type = "toggle",
                                name = "内边框",
                                desc = "如果勾选，当边框启用时，图标的边框将会描绘在按钮的内部（而不是外围）。",
                                order = 2.5,
                                width = 1.49
                            },

                            break01 = {
                                type = "description",
                                name = " ",
                                width = "full",
                                order = 2.6
                            },

                            coloring = {
                                type = "select",
                                name = "着色模式",
                                desc = "设置边框颜色是系统颜色或自定义颜色。",
                                width = 1.49,
                                order = 3,
                                values = {
                                    class = format( "Class |A:WhiteCircle-RaidBlips:16:16:0:0:%d:%d:%d|a #%s", ClassColor.r * 255, ClassColor.g * 255, ClassColor.b * 255, ClassColor:GenerateHexColor():sub( 3, 8 ) ),
                                    custom = "设置自定义颜色"
                                },
                                disabled = function() return data.border.enabled == false end,
                            },

                            color = {
                                type = "color",
                                name = "边框颜色",
                                desc = "当启用边框后，边框将使用此颜色。",
                                order = 4,
                                width = 1.49,
                                disabled = function () return data.border.enabled == false or data.border.coloring ~= "custom" end,
                            }
                        }
                    },

                    range = {
                        type = "group",
                        name = "范围",
                        desc = "设置范围检查警告的选项。",
                        order = 5,
                        args = {
                            enabled = {
                                type = "toggle",
                                name = "启用",
                                desc = "如果勾选，当你不在攻击距离内时，插件将进行红色高亮警告。",
                                width = 1.49,
                                order = 1,
                            },

                            type = {
                                type = "select",
                                name = '范围监测',
                                desc = "选择该显示区域使用的范围监测和警告提示类型。\n\n" ..
                                	"|cFFFFD100技能|r - 如果某个技能超出攻击范围，则该技能以红色高亮警告。\n\n" ..
                                	"|cFFFFD100近战|r - 如果你不在近战攻击范围，所有技能都以红色高亮警告。\n\n" ..
                                	"|cFFFFD100排除|r - 如果某个技能超出攻击范围，则不建议使用该技能。",
                                values = {
                                    ability = "每个技能",
                                    melee = "近战范围",
                                    xclude = "排除超出范围的技能"
                                },
                                width = 1.49,
                                order = 2,
                                disabled = function () return data.range.enabled == false end,
                            }
                        }
                    },

                    glow = {
                        type = "group",
                        name = "高亮",
                        desc = "设置高亮或覆盖的选项。",
                        order = 6,
                        args = {
                            enabled = {
                                type = "toggle",
                                name = "启用",
                                desc = "如果启用，当队列中第一个技能具有高亮（或覆盖）的功能，也将在显示区域中同步高亮。",
                                width = 1.49,
                                order = 1,
                            },

                            queued = {
                                type = "toggle",
                                name = "对队列图标启用",
                                desc = "如果启用，具有高亮（或覆盖）功能的队列技能图标也将在队列中同步高亮。\n\n" ..
                                "此项效果可能不理想，在未来的时间点，高亮状态可能不再正确。",
                                width = 1.49,
                                order = 2,
                                disabled = function() return data.glow.enabled == false end,
                            },

                            break01 = {
                                type = "description",
                                name = " ",
                                order = 2.1,
                                width = "full"
                            },

                            mode = {
                                type = "select",
                                name = "高亮样式",
                                desc = "设置显示区域的高亮样式。",
                                width = 1,
                                order = 3,
                                values = {
                                    default = "默认按钮高亮",
                                    autocast = "自动闪光",
                                    pixel = "像素发光",
                                },
                                disabled = function() return data.glow.enabled == false end,
                            },

                            coloring = {
                                type = "select",
                                name = "着色模式",
                                desc = "设置高亮效果的着色模式。",
                                width = 0.99,
                                order = 4,
                                values = {
                                    default = "使用默认颜色",
                                    class = "使用系统颜色",
                                    custom = "设置自定义颜色"
                                },
                                disabled = function() return data.glow.enabled == false end,
                            },

                            color = {
                                type = "color",
                                name = "高亮颜色",
                                desc = "设置该显示区域的高亮颜色。",
                                width = 0.99,
                                order = 5,
                                disabled = function() return data.glow.coloring ~= "custom" end,
                            },
                        },
                    },

                    flash = {
                        type = "group",
                        name = "技能高光",
                        desc = function ()
                            if SF then
                                return "如果勾选，插件可以在推荐使用某个技能时，在动作条技能图标上进行高光提示。"
                            end
                            return "此功能要求SpellFlash插件或库正常工作。"
                        end,
                        order = 8,
                        args = {
                            warning = {
                                type = "description",
                                name = "此页设置不可用。原因是SpellFlash插件没有安装或被禁用。",
                                order = 0,
                                fontSize = "medium",
                                width = "full",
                                hidden = function () return SF ~= nil end,
                            },

                            enabled = {
                                type = "toggle",
                                name = "启用",
                                desc = "如果勾选，插件将该显示区域的第一个推荐技能图标上显示彩色高光。",

                                width = "full",
                                order = 1,
                                hidden = function () return SF == nil end,
                            },

                            color = {
                                type = "color",
                                name = "颜色",
                                desc = "设置技能高亮的高光颜色。",
                                order = 2,

                                width = "full",
                                hidden = function () return SF == nil end,
                            },

                            size = {
                                type = "range",
                                name = "大小",
                                desc = "设置技能高光的光晕大小。默认大小为|cFFFFD100240|r。",
                                order = 3,
                                min = 0,
                                max = 240 * 8,
                                step = 1,
                                width = 1.49,
                                hidden = function () return SF == nil end,
                            },

                            brightness = {
                                type = "range",
                                name = "亮度",
                                desc = "设置技能高光的亮度。默认亮度为|cFFFFD100100|r。",
                                order = 4,
                                min = 0,
                                softMax = 100,
                                max = 200,
                                step = 1,
                                width = 1.49,
                                hidden = function () return SF == nil end,
                            },

                            break01 = {
                                type = "description",
                                name = " ",
                                order = 4.1,
                                width = "full",
                                hidden = function () return SF == nil end,
                            },

                            blink = {
                                type = "toggle",
                                name = "闪烁",
                                desc = "如果勾选，技能图标将以闪烁进行提示。默认值为|cFFFF0000禁用|r。",
                                order = 5,
                                width = 1.49,
                                hidden = function () return SF == nil end,
                            },

                            suppress = {
                                type = "toggle",
                                name = "显示区域隐藏",
                                desc = "如果勾选，显示区域将被隐藏，仅通过技能高光功能进行技能推荐。",
                                order = 10,
                                width = 1.49,
                                hidden = function () return SF == nil end,
                            },


                            globalHeader = {
                                type = "header",
                                name = "全局技能高光设置",
                                order = 20,
                                width = "full",
                                hidden = function () return SF == nil end,
                            },

                            texture = {
                                type = "select",
                                name = "纹理",
                                desc = "勾选此选项将由插件覆盖所有框架上的技能高光纹理。此设置对所有显示框都通用。",
                                order = 21,
                                width = 1,
                                get = function()
                                    return Hekili.DB.profile.flashTexture
                                end,
                                set = function( info, value )
                                    Hekili.DB.profile.flashTexture = value
                                end,
                                values = {
                                    ["Interface\\Cooldown\\star4"] = "星光（默认）",                                    
                                    ["Interface\\Cooldown\\ping4"] = "光环",
                                    ["Interface\\Cooldown\\starburst"] = "星爆",
                                    ["Interface\\AddOns\\Hekili\\Textures\\MonoCircle2"] = "单色细光环",
                                    ["Interface\\AddOns\\Hekili\\Textures\\MonoCircle5"] = "单色粗光环",
                                },
                                hidden = function () return SF == nil end,
                            },

                            fixedSize = {
                                type = "toggle",
                                name = "固定大小",
                                desc = "如果勾选，所有技能高光的缩放提示效果将被禁用。",
                                order = 22,
                                width = 0.99,
                                get = function()
                                    return Hekili.DB.profile.fixedSize
                                end,
                                set = function( info, value )
                                    Hekili.DB.profile.fixedSize = value
                                end,
                                hidden = function () return SF == nil end,
                            },

                            fixedBrightness = {
                                type = "toggle",
                                name = "固定亮度",
                                desc = "如果勾选，所有技能高光的明暗提示效果将被禁用。",
                                order = 23,
                                width = 0.99,
                                get = function()
                                    return Hekili.DB.profile.fixedBrightness
                                end,
                                set = function( info, value )
                                    Hekili.DB.profile.fixedBrightness = value
                                end,
                                hidden = function () return SF == nil end,
                            },
                        },
                    },

                    captions = {
                        type = "group",
                        name = "提示",
                        desc = "提示是动作条中偶尔使用的简短描述，用于该技能的说明。",
                        order = 9,
                        args = {
                            enabled = {
                                type = "toggle",
                                name = "启用",
                                desc = "如果勾选，当显示框中第一个技能具有说明时，将显示该说明。",
                                order = 1,
                                width = 1.49,
                            },

                            queued = {
                                type = "toggle",
                                name = "对队列图标启用",
                                desc = "如果勾选，将显示队列技能图标的说明（如果可用）。",
                                order = 2,
                                width = 1.49,
                                disabled = function () return data.captions.enabled == false end,
                            },

                            position = {
                                type = "group",
                                inline = true,
                                name = function( info ) rangeIcon( info ); return "位置" end,
                                order = 3,
                                args = {
                                    anchor = {
                                        type = "select",
                                        name = '锚点',
                                        order = 1,
                                        width = 1,
                                        values = {
                                            TOP = '顶部',
                                            BOTTOM = '底部',
                                        }
                                    },

                                    x = {
                                        type = "range",
                                        name = "X轴偏移",
                                        order = 2,
                                        width = 0.99,
                                        step = 1,
                                    },

                                    y = {
                                        type = "range",
                                        name = "Y轴偏移",
                                        order = 3,
                                        width = 0.99,
                                        step = 1,
                                    },

                                    break01 = {
                                        type = "description",
                                        name = " ",
                                        order = 3.1,
                                        width = "full",
                                    },

                                    align = {
                                        type = "select",
                                        name = "对齐",
                                        order = 4,
                                        width = 1.49,
                                        values = {
                                            LEFT = "左对齐",
                                            RIGHT = "右对齐",
                                            CENTER = "居中对齐"
                                        },
                                    },
                                }
                            },

                            textStyle = {
                                type = "group",
                                inline = true,
                                name = "文本",
                                order = 4,
                                args = tableCopy( fontElements ),
                            },
                        }
                    },

                    targets = {
                        type = "group",
                        name = "目标数",
                        desc = "目标数量统计可以在显示框的第一个技能图标上。",
                        order = 10,
                        args = {
                            enabled = {
                                type = "toggle",
                                name = "启用",
                                desc = "如果勾选，插件将在显示框上显示识别到的目标数。",
                                order = 1,
                                width = "full",
                            },

                            pos = {
                                type = "group",
                                inline = true,
                                name = function( info ) rangeIcon( info ); return "位置" end,
                                order = 2,
                                args = {
                                    anchor = {
                                        type = "select",
                                        name = "锚定到",
                                        values = realAnchorPositions,
                                        order = 1,
                                        width = 1,
                                    },

                                    x = {
                                        type = "range",
                                        name = "X轴偏移",
                                        min = -max( data.primaryWidth, data.queue.width ),
                                        max = max( data.primaryWidth, data.queue.width ),
                                        step = 1,
                                        order = 2,
                                        width = 0.99,
                                    },

                                    y = {
                                        type = "range",
                                        name = "Y轴偏移",
                                        min = -max( data.primaryHeight, data.queue.height ),
                                        max = max( data.primaryHeight, data.queue.height ),
                                        step = 1,
                                        order = 2,
                                        width = 0.99,
                                    }
                                }
                            },

                            textStyle = {
                                type = "group",
                                inline = true,
                                name = "文本",
                                order = 3,
                                args = tableCopy( fontElements ),
                            },
                        }
                    },

                    delays = {
                        type = "group",
                        name = "延时",
                        desc = "当未来某个时间点建议使用某个技能时，使用着色或倒计时进行延时提示。" ..
                            "",
                        order = 11,
                        args = {
                            extend = {
                                type = "toggle",
                                name = "扩展冷却扫描",
                                desc = "如果勾选，主图标的冷却扫描将不会刷新，直到该技能被使用。",
                                width = 1.49,
                                order = 1,
                            },

                            fade = {
                                type = "toggle",
                                name = "无法使用则淡化",
                                desc = "当你在施放该技能之前等待时，主图标将淡化，类似于某个技能缺少能量时。",
                                width = 1.49,
                                order = 1.1
                            },

                            break01 = {
                                type = "description",
                                name = " ",
                                order = 1.2,
                                width = "full",
                            },

                            type = {
                                type = "select",
                                name = "提示方式",
                                desc = "设置在施放该技能之前等待时间的提示方式。",
                                values = {
                                    __NA = "不提示",
                                    ICON = "显示图标（颜色）",
                                    TEXT = "显示文本（倒计时）",
                                },
                                width = 1.49,
                                order = 2,
                            },

                            pos = {
                                type = "group",
                                inline = true,
                                name = function( info ) rangeIcon( info ); return "位置" end,
                                order = 3,
                                args = {
                                    anchor = {
                                        type = "select",
                                        name = '锚点',
                                        order = 2,
                                        width = 1,
                                        values = realAnchorPositions
                                    },

                                    x = {
                                        type = "range",
                                        name = "X轴偏移",
                                        order = 3,
                                        width = 0.99,
                                        min = -max( data.primaryWidth, data.queue.width ),
                                        max = max( data.primaryWidth, data.queue.width ),
                                        step = 1,
                                    },

                                    y = {
                                        type = "range",
                                        name = "Y轴偏移",
                                        order = 4,
                                        width = 0.99,
                                        min = -max( data.primaryHeight, data.queue.height ),
                                        max = max( data.primaryHeight, data.queue.height ),
                                        step = 1,
                                    }
                                },
                                disabled = function () return data.delays.type == "__NA" end,
                            },

                            textStyle = {
                                type = "group",
                                inline = true,
                                name = "文本",
                                order = 4,
                                args = tableCopy( fontElements ),
                                disabled = function () return data.delays.type ~= "TEXT" end,
                            },
                        }
                    },

                    indicators = {
                        type = "group",
                        name = "扩展提示",
                        desc = "扩展提示是当需要切换目标时或取消增益效果时的小图标。",
                        order = 11,
                        args = {
                            enabled = {
                                type = "toggle",
                                name = "启用",
                                desc = "如果勾选，主图标上将会出现提示切换目标和取消效果的小图标。",
                                order = 1,
                                width = 1.49,
                            },

                            queued = {
                                type = "toggle",
                                name = "对队列图标启用",
                                desc = "如果勾选，扩展提示也将适时地出现在队列图标上。",
                                order = 2,
                                width = 1.49,
                                disabled = function () return data.indicators.enabled == false end,
                            },

                            pos = {
                                type = "group",
                                inline = true,
                                name = function( info ) rangeIcon( info ); return "位置" end,
                                order = 2,
                                args = {
                                    anchor = {
                                        type = "select",
                                        name = "锚点",
                                        values = realAnchorPositions,
                                        order = 1,
                                        width = 1,
                                    },

                                    x = {
                                        type = "range",
                                        name = "X轴偏移",
                                        min = -max( data.primaryWidth, data.queue.width ),
                                        max = max( data.primaryWidth, data.queue.width ),
                                        step = 1,
                                        order = 2,
                                        width = 0.99,
                                    },

                                    y = {
                                        type = "range",
                                        name = "Y轴偏移",
                                        min = -max( data.primaryHeight, data.queue.height ),
                                        max = max( data.primaryHeight, data.queue.height ),
                                        step = 1,
                                        order = 2,
                                        width = 0.99,
                                    }
                                }
                            },
                        }
                    },
                },
            },
        }

        return option
    end


    function Hekili:EmbedDisplayOptions( db )
        db = db or self.Options
        if not db then return end

        local section = db.args.displays or {
            type = "group",
            name = "显示框架",
            childGroups = "tree",
            cmdHidden = true,
            get = 'GetDisplayOption',
            set = 'SetDisplayOption',
            order = 30,

            args = {
                header = {
                    type = "description",
                    name = "Hekili拥有五个内置的显示框架（蓝色标识），以用于显示不同类型的建议。" ..
                        "插件的建议通常基于（但不完全）SimulationCraft模拟结果的技能优先级。" ..
                        "你可以将判断实际情况与模拟结果进行比较得到最优解。",
                    fontSize = "medium",
                    width = "full",
                    order = 1,
                },

                displays = {
                    type = "header",
                    name = "显示框架",
                    order = 10,                    
                },


                nPanelHeader = {
                    type = "header",
                    name = "通知栏",
                    order = 950,
                },

                nPanelBtn = {
                    type = "execute",
                    name = "通知栏",
                    desc = "当在战斗中更改或切换设置是，通知栏将提供简要的说明。" ..
                        "",
                    func = function ()
                        ACD:SelectGroup( "Hekili", "displays", "nPanel" )
                    end,
                    order = 951,
                },

                nPanel = {
                    type = "group",
                    name = "|cFF1EFF00通知栏|r",
                    desc = "当在战斗中更改或切换设置是，通知栏将提供简要的说明。" ..
                        "",
                    order = 952,
                    get = GetNotifOption,
                    set = SetNotifOption,
                    args = {
                        enabled = {
                            type = "toggle",
                            name = "启用",
                            order = 1,
                            width = "full",
                        },

                        posRow = {
                            type = "group",
                            name = function( info ) rangeXY( info, true ); return "位置" end,
                            inline = true,
                            order = 2,
                            args = {
                                x = {
                                    type = "range",
                                    name = "X",
                                    desc = "输入通知面板相对于屏幕中心的水平位置，" ..
                                        "负值向左偏移，正值向右。" ..
                                        "",
                                    min = -512,
                                    max = 512,
                                    step = 1,

                                    width = 1.49,
                                    order = 1,
                                },

                                y = {
                                    type = "range",
                                    name = "Y",
                                    desc = "输入通知面板相对于屏幕中心的垂直位置，" ..
                                        "负值向下偏移，正值向上。" ..
                                        "",
                                    min = -384,
                                    max = 384,
                                    step = 1,

                                    width = 1.49,
                                    order = 2,
                                },
                            }
                        },

                        sizeRow = {
                            type = "group",
                            name = "大小",
                            inline = true,
                            order = 3,
                            args = {
                                width = {
                                    type = "range",
                                    name = "宽度",
                                    min = 50,
                                    max = 1000,
                                    step = 1,

                                    width = "full",
                                    order = 1,
                                },

                                height = {
                                    type = "range",
                                    name = "高度",
                                    min = 20,
                                    max = 600,
                                    step = 1,

                                    width = "full",
                                    order = 2,
                                },
                            }
                        },

                        fontGroup = {
                            type = "group",
                            inline = true,
                            name = "文字",

                            order = 5,
                            args = tableCopy( fontElements ),
                        },
                    }
                },

                fontHeader = {
                    type = "header",
                    name = "字体",
                    order = 960,
                },

                fontWarn = {
                    type = "description",
                    name = "更改下面的字体将调整|cFFFF0000所有|r显示区域中的文字。\n" ..
                             "如果想修改单独显示区域的文字，请选择对应的显示区域（左侧）后再设置字体。",
                    order = 960.01,
                },

                font = {
                    type = "select",
                    name = "字体",
                    order = 960.1,
                    width = 1.5,
                    dialogControl = 'LSM30_Font',
                    values = LSM:HashTable("font"),
                    get = function( info )
                        -- Display the information from Primary, Keybinds.
                        return Hekili.DB.profile.displays.Primary.keybindings.font
                    end,
                    set = function( info, val )
                        -- Set all fonts in all displays.
                        for name, display in pairs( Hekili.DB.profile.displays ) do
                            display.captions.font = val
                            display.delays.font = val
                            display.keybindings.font = val
                            display.targets.font = val
                        end
                        QueueRebuildUI()
                    end,
                },

                fontSize = {
                    type = "range",
                    name = "大小",
                    order = 960.2,
                    min = 8,
                    max = 64,
                    step = 1,
                    get = function( info )
                        -- Display the information from Primary, Keybinds.
                        return Hekili.DB.profile.displays.Primary.keybindings.fontSize
                    end,
                    set = function( info, val )
                        -- Set all fonts in all displays.
                        for name, display in pairs( Hekili.DB.profile.displays ) do
                            display.captions.fontSize = val
                            display.delays.fontSize = val
                            display.keybindings.fontSize = val
                            display.targets.fontSize = val
                        end
                        QueueRebuildUI()
                    end,
                    width = 1.5,
                },

                fontStyle = {
                    type = "select",
                    name = "样式",
                    order = 960.3,
                    values = {
                        ["MONOCHROME"] = "单色",
                        ["MONOCHROME,OUTLINE"] = "单色，描边",
                        ["MONOCHROME,THICKOUTLINE"] = "单色，粗描边",
                        ["NONE"] = "无",
                        ["OUTLINE"] = "描边",
                        ["THICKOUTLINE"] = "粗描边"
                    },
                    get = function( info )
                        -- Display the information from Primary, Keybinds.
                        return Hekili.DB.profile.displays.Primary.keybindings.fontStyle
                    end,
                    set = function( info, val )
                        -- Set all fonts in all displays.
                        for name, display in pairs( Hekili.DB.profile.displays ) do
                            display.captions.fontStyle = val
                            display.delays.fontStyle = val
                            display.keybindings.fontStyle = val
                            display.targets.fontStyle = val
                        end
                        QueueRebuildUI()
                    end,
                    width = 1.5,
                },

                color = {
                    type = "color",
                    name = "颜色",
                    order = 960.4,
                    get = function( info )
                        return unpack( Hekili.DB.profile.displays.Primary.keybindings.color )
                    end,
                    set = function( info, ... )
                        for name, display in pairs( Hekili.DB.profile.displays ) do
                            display.captions.color = { ... }
                            display.delays.color = { ... }
                            display.keybindings.color = { ... }
                            display.targets.color = { ... }
                        end
                        QueueRebuildUI()
                    end,
                    width = 1.5
                },

                shareHeader = {
                    type = "header",
                    name = "分享",
                    order = 996,
                },

                shareBtn = {
                    type = "execute",
                    name = "分享样式",
                    desc = "你的显示样式可以通过导出这些字符串与其他插件用户分享。\n\n" ..
                        "你也可以在这里导入他人分享的字符串。",
                    func = function ()
                        ACD:SelectGroup( "Hekili", "displays", "shareDisplays" )
                    end,
                    order = 998,
                },

                shareDisplays = {
                    type = "group",
                    name = "|cFF1EFF00分享样式|r",
                    desc = "你的显示选项可以通过导出这些字符串与其他插件用户分享。\n\n" ..
                        "你也可以在这里导入他人分享的字符串。",
                    childGroups = "tab",
                    get = 'GetDisplayShareOption',
                    set = 'SetDisplayShareOption',
                    order = 999,
                    args = {
                        import = {
                            type = "group",
                            name = "导入",
                            order = 1,
                            args = {
                                stage0 = {
                                    type = "group",
                                    name = "",
                                    inline = true,
                                    order = 1,
                                    args = {
                                        guide = {
                                            type = "description",
                                            name = "选择保存的样式，或者在文本框中粘贴字符串。",
                                            order = 1,
                                            width = "full",
                                            fontSize = "medium",
                                        },

                                        separator = {
                                            type = "header",
                                            name = "导入字符串",
                                            order = 1.5,
                                        },

                                        selectExisting = {
                                            type = "select",
                                            name = "选择保存的样式",
                                            order = 2,
                                            width = "full",
                                            get = function()
                                                return "0000000000"
                                            end,
                                            set = function( info, val )
                                                local style = self.DB.global.styles[ val ]

                                                if style then shareDB.import = style.payload end
                                            end,
                                            values = function ()
                                                local db = self.DB.global.styles
                                                local values = {
                                                    ["0000000000"] = "选择保存的样式"
                                                }

                                                for k, v in pairs( db ) do
                                                    values[ k ] = k .. " (|cFF00FF00" .. v.date .. "|r)"
                                                end

                                                return values
                                            end,
                                        },

                                        importString = {
                                            type = "input",
                                            name = "导入字符串",
                                            get = function () return shareDB.import end,
                                            set = function( info, val )
                                                val = val:trim()
                                                shareDB.import = val
                                            end,
                                            order = 3,
                                            multiline = 5,
                                            width = "full",
                                        },

                                        btnSeparator = {
                                            type = "header",
                                            name = "导入",
                                            order = 4,
                                        },

                                        importBtn = {
                                            type = "execute",
                                            name = "导入样式",
                                            order = 5,
                                            func = function ()
                                                shareDB.imported, shareDB.error = self:DeserializeStyle( shareDB.import )

                                                if shareDB.error then
                                                    shareDB.import = "无法解析当前的导入字符串。\n" .. shareDB.error
                                                    shareDB.error = nil
                                                    shareDB.imported = {}
                                                else
                                                    shareDB.importStage = 1
                                                end
                                            end,
                                            disabled = function ()
                                                return shareDB.import == ""
                                            end,
                                        },
                                    },
                                    hidden = function () return shareDB.importStage ~= 0 end,
                                },

                                stage1 = {
                                    type = "group",
                                    inline = true,
                                    name = "",
                                    order = 1,
                                    args = {
                                        guide = {
                                            type = "description",
                                            name = function ()
                                                local creates, replaces = {}, {}

                                                for k, v in pairs( shareDB.imported ) do
                                                    if rawget( self.DB.profile.displays, k ) then
                                                        insert( replaces, k )
                                                    else
                                                        insert( creates, k )
                                                    end
                                                end

                                                local o = ""

                                                if #creates > 0 then
                                                    o = o .. "导入的样式将创建以下的显示区域样式："
                                                    for i, display in orderedPairs( creates ) do
                                                        if i == 1 then o = o .. display
                                                        else o = o .. ", " .. display end
                                                    end
                                                    o = o .. ".\n"
                                                end

                                                if #replaces > 0 then
                                                    o = o .. "导入的样式将覆盖以下的显示区域样式："
                                                    for i, display in orderedPairs( replaces ) do
                                                        if i == 1 then o = o .. display
                                                        else o = o .. ", " .. display end
                                                    end
                                                    o = o .. "."
                                                end

                                                return o
                                            end,
                                            order = 1,
                                            width = "full",
                                            fontSize = "medium",
                                        },

                                        separator = {
                                            type = "header",
                                            name = "应用更改",
                                            order = 2,
                                        },

                                        apply = {
                                            type = "execute",
                                            name = "应用更改",
                                            order = 3,
                                            confirm = true,
                                            func = function ()
                                                for k, v in pairs( shareDB.imported ) do
                                                    if type( v ) == "table" then self.DB.profile.displays[ k ] = v end
                                                end

                                                shareDB.import = ""
                                                shareDB.imported = {}
                                                shareDB.importStage = 2

                                                self:EmbedDisplayOptions()
                                                QueueRebuildUI()
                                            end,
                                        },

                                        reset = {
                                            type = "execute",
                                            name = "重置",
                                            order = 4,
                                            func = function ()
                                                shareDB.import = ""
                                                shareDB.imported = {}
                                                shareDB.importStage = 0
                                            end,
                                        },
                                    },
                                    hidden = function () return shareDB.importStage ~= 1 end,
                                },

                                stage2 = {
                                    type = "group",
                                    inline = true,
                                    name = "",
                                    order = 3,
                                    args = {
                                        note = {
                                            type = "description",
                                            name = "导入的设置已经成功应用！\n\n如果有必要，点击重置重新开始。",
                                            order = 1,
                                            fontSize = "medium",
                                            width = "full",
                                        },

                                        reset = {
                                            type = "execute",
                                            name = "重置",
                                            order = 2,
                                            func = function ()
                                                shareDB.import = ""
                                                shareDB.imported = {}
                                                shareDB.importStage = 0
                                            end,
                                        }
                                    },
                                    hidden = function () return shareDB.importStage ~= 2 end,
                                }
                            },
                            plugins = {
                            }
                        },

                        export = {
                            type = "group",
                            name = "导出",
                            order = 2,
                            args = {
                                stage0 = {
                                    type = "group",
                                    name = "",
                                    inline = true,
                                    order = 1,
                                    args = {
                                        guide = {
                                            type = "description",
                                            name = "选择要导出的显示样式，然后单击导出样式生成导出字符串。",
                                            order = 1,
                                            fontSize = "medium",
                                            width = "full",
                                        },

                                        displays = {
                                            type = "header",
                                            name = "显示框架",
                                            order = 2,
                                        },

                                        exportHeader = {
                                            type = "header",
                                            name = "导出",
                                            order = 1000,
                                        },

                                        exportBtn = {
                                            type = "execute",
                                            name = "导出样式",
                                            order = 1001,
                                            func = function ()
                                                local disps = {}
                                                for key, share in pairs( shareDB.displays ) do
                                                    if share then insert( disps, key ) end
                                                end

                                                shareDB.export = self:SerializeStyle( unpack( disps ) )
                                                shareDB.exportStage = 1
                                            end,
                                            disabled = function ()
                                                local hasDisplay = false

                                                for key, value in pairs( shareDB.displays ) do
                                                    if value then hasDisplay = true; break end
                                                end

                                                return not hasDisplay
                                            end,
                                        },
                                    },
                                    plugins = {
                                        displays = {}
                                    },
                                    hidden = function ()
                                        local plugins = self.Options.args.displays.args.shareDisplays.args.export.args.stage0.plugins.displays
                                        wipe( plugins )

                                        local i = 1
                                        for dispName, display in pairs( self.DB.profile.displays ) do
                                            local pos = 20 + ( display.builtIn and display.order or i )
                                            plugins[ dispName ] = {
                                                type = "toggle",
                                                name = function ()
                                                    if display.builtIn then return "|cFF00B4FF" .. dispName .. "|r" end
                                                    return dispName
                                                end,
                                                order = pos,
                                                width = "full"
                                            }
                                            i = i + 1
                                        end

                                        return shareDB.exportStage ~= 0
                                    end,
                                },

                                stage1 = {
                                    type = "group",
                                    name = "",
                                    inline = true,
                                    order = 1,
                                    args = {
                                        exportString = {
                                            type = "input",
                                            name = "样式字符串",
                                            order = 1,
                                            multiline = 8,
                                            get = function () return shareDB.export end,
                                            set = function () end,
                                            width = "full",
                                            hidden = function () return shareDB.export == "" end,
                                        },

                                        instructions = {
                                            type = "description",
                                            name = "你可以复制这些字符串用以分享所选的显示样式，" ..
                                                "或者使用下方选项保存所选的显示样式在以后使用。",
                                            order = 2,
                                            width = "full",
                                            fontSize = "medium"
                                        },

                                        store = {
                                            type = "group",
                                            inline = true,
                                            name = "",
                                            order = 3,
                                            hidden = function () return shareDB.export == "" end,
                                            args = {
                                                separator = {
                                                    type = "header",
                                                    name = "保存样式",
                                                    order = 1,
                                                },

                                                exportName = {
                                                    type = "input",
                                                    name = "样式名称",
                                                    get = function () return shareDB.styleName end,
                                                    set = function( info, val )
                                                        val = val:trim()
                                                        shareDB.styleName = val
                                                    end,
                                                    order = 2,
                                                    width = "double",
                                                },

                                                storeStyle = {
                                                    type = "execute",
                                                    name = "保存导出字符串",
                                                    desc = "通过保存导出字符串，你可以保存你的显示设置，并在以后需要时使用它们。\n\n" ..
                                                        "即使使用不同的配置文件，也可以调用任意一个存储的样式。",
                                                    order = 3,
                                                    confirm = function ()
                                                        if shareDB.styleName and self.DB.global.styles[ shareDB.styleName ] ~= nil then
                                                            return "已经存在名为'" .. shareDB.styleName .. "'的样式了 -- 覆盖它吗？"
                                                        end
                                                        return false
                                                    end,
                                                    func = function ()
                                                        local db = self.DB.global.styles
                                                        db[ shareDB.styleName ] = {
                                                            date = tonumber( date("%Y%m%d.%H%M%S") ),
                                                            payload = shareDB.export,
                                                        }
                                                        shareDB.styleName = ""
                                                    end,
                                                    disabled = function ()
                                                        return shareDB.export == "" or shareDB.styleName == ""
                                                    end,
                                                }
                                            }
                                        },


                                        restart = {
                                            type = "execute",
                                            name = "重新开始",
                                            order = 4,
                                            func = function ()
                                                shareDB.styleName = ""
                                                shareDB.export = ""
                                                wipe( shareDB.displays )
                                                shareDB.exportStage = 0
                                            end,
                                        }
                                    },
                                    hidden = function () return shareDB.exportStage ~= 1 end
                                }
                            },
                            plugins = {
                                displays = {}
                            },
                        }
                    }
                },
            },
            plugins = {},
        }
        db.args.displays = section
        wipe( section.plugins )

        local i = 1

        for name, data in pairs( self.DB.profile.displays ) do
            local pos = data.builtIn and data.order or i
            section.plugins[ name ] = newDisplayOption( db, name, data, pos )
            if not data.builtIn then i = i + 1 end
        end

        section.plugins[ "Multi" ] = newDisplayOption( db, "Multi", self.DB.profile.displays[ "Primary" ], 0 )
        MakeMultiDisplayOption( section.plugins, section.plugins.Multi.Multi.args )

    end
end


ns.ClassSettings = function ()

    local option = {
        type = 'group',
        name = "职业/专精",
        order = 20,
        args = {},
        childGroups = "select",
        hidden = function()
            return #class.toggles == 0 and #class.settings == 0
        end
    }

    option.args.toggles = {
        type = 'group',
        name = '切换',
        order = 10,
        inline = true,
        args = {
        },
        hidden = function()
            return #class.toggles == 0
        end
    }

    for i = 1, #class.toggles do
        option.args.toggles.args[ 'Bind: ' .. class.toggles[i].name ] = {
            type = 'keybinding',
            name = class.toggles[i].option,
            desc = class.toggles[i].oDesc,
            order = ( i - 1 ) * 2
        }
        option.args.toggles.args[ 'State: ' .. class.toggles[i].name ] = {
            type = 'toggle',
            name = class.toggles[i].option,
            desc = class.toggles[i].oDesc,
            width = 'double',
            order = 1 + ( i - 1 ) * 2
        }
    end

    option.args.settings = {
        type = 'group',
        name = '设置',
        order = 20,
        inline = true,
        args = {},
        hidden = function()
            return #class.settings == 0
        end
    }

    for i, setting in ipairs(class.settings) do
        option.args.settings.args[ setting.name ] = setting.option
        option.args.settings.args[ setting.name ].order = i
    end

    return option

end


local abilityToggles = {}

ns.AbilitySettings = function ()

    local option = {
        type = 'group',
        name = "技能和道具",
        order = 65,
        childGroups = 'select',
        args = {
            heading = {
                type = 'description',
                name = "这些设置可对影响插件如何进行技能推荐进行细微的调整。" ..
                    "请仔细阅读提示，因为如果滥用某些选项可能会导致奇怪或不希望发生的情况。\n",
                order = 1,
                width = "full",
            }
        }
    }

    local abilities = {}
    for k, v in pairs( class.abilities ) do
        if not v.unlisted and v.name and not abilities[ v.name ] and ( v.id > 0 or v.id < -99 ) then
            abilities[ v.name ] = v.key
        end
    end

    for k, v in pairs( abilities ) do
        local ability = class.abilities[ k ]

        local abOption = {
            type = 'group',
            name = ability.name or k or v,
            order = 2,
            -- childGroups = "inline",
            args = {
                exclude = {
                    type = 'toggle',
                    name = function () return '禁用' .. ( ability.item and ability.link or k ) end,
                    desc = function () return "如果勾选，此技能将|cFFFF0000永远|r不会被推荐。" ..
                        "如果其他技能依赖你使用" .. ( ability.item and ability.link or k ) .. "，这可能会导致该专精无法获得任何技能推荐。" end,
                    width = 'full',
                    order = 1
                },
                toggle = {
                    type = 'select',
                    name = '需要主动启用',
                    desc = "设置此项后，插件在技能列表中使用必须的开关切换。" ..
                        "当开关被关闭时，技能将被视为不可用，插件将假设它们处于冷却状态（除非另有设置）。",
                    width = 'full',
                    order = 2,
                    values = function ()
                        wipe( abilityToggles )

                        abilityToggles[ 'none' ] = 'None'
                        abilityToggles[ 'default' ] = 'Default' .. ( ability.toggle and ( ' |cFFFFD100(' .. ability.toggle .. ')|r' ) or ' |cFFFFD100(none)|r' )
                        abilityToggles[ 'cooldowns' ] = 'Cooldowns'
                        abilityToggles[ 'defensives' ] = 'Defensives'
                        abilityToggles[ 'interrupts' ] = 'Interrupts'
                        abilityToggles[ 'potions' ] = 'Potions'

                        return abilityToggles
                    end,
                },
                clash = {
                    type = 'range',
                    name = '缓冲数值',
                    desc = "如果设置大于0，插件将假设" .. k .. "拥有更快的冷却时间。" ..
                        "当一个技能的优先级非常高并且你希望插件在它实际准备好之前考虑它时，这可能会很有帮助。",
                    width = "full",
                    min = -1.5,
                    max = 1.5,
                    step = 0.05,
                    order = 3
                },

                spacer01 = {
                    type = "description",
                    name = " ",
                    width = "full",
                    order = 19,
                    hidden = function() return ability.item == nil end,
                },

                itemHeader = {
                    type = "description",
                    name = "|cFFFFD100可用道具|r",
                    order = 20,
                    fontSize = "medium",
                    width = "full",
                    hidden = function() return ability.item == nil end,
                },

                itemDescription = {
                    type = "description",
                    name = function () return "这个技能需要已装备" .. ( ability.link or ability.name ) .. "。这个道具可以在你的技能列表中使用|cFF00CCFF[使用道具]|r进行装备。" ..
                        "如果你不希望插件通过|cff00ccff[使用道具]|r来获取这个技能，可以在此处禁用它。" ..
                        "你还可以为要使用的项目设定最小或最大的目标数量。\n" end,
                    order = 21,
                    width = "full",
                    hidden = function() return ability.item == nil end,
                },

                spacer02 = {
                    type = "description",
                    name = " ",
                    width = "full",
                    order = 49
                },
            }
        }

        if ability and ability.item then
            if class.itemSettings[ ability.item ] then
                for setting, config in pairs( class.itemSettings[ ability.item ].options ) do
                    abOption.args[ setting ] = config
                end
            end
        end

        abOption.hidden = function( info )
            -- Hijack this function to build toggle list for action list entries.

            abOption.args.listHeader = abOption.args.listHeader or {
                type = "description",
                name = "|cFFFFD100技能列表|r",
                order = 50,
                fontSize = "medium",
                width = "full",
            }
            abOption.args.listHeader.hidden = true

            abOption.args.listDescription = abOption.args.listDescription or {
                type = "description",
                name = "此技能被罗列在下方的技能列表中。如果你认为必要，可以在此处禁用任何技能。",
                order = 51,
                width = "full",
            }
            abOption.args.listDescription.hidden = true

            for key, opt in pairs( abOption.args ) do
                if key:match( "^(%d+):(%d+)" ) then
                    opt.hidden = true
                end
            end

            local entries = 51

            for i, list in ipairs( Hekili.DB.profile.actionLists ) do
                if list.Name ~= "可用道具" then
                    for a, action in ipairs( list.Actions ) do
                        if action.Ability == v then
                            entries = entries + 1

                            local toggle = option.args[ v ].args[ i .. ':' .. a ] or {}

                            toggle.type = "toggle"
                            toggle.name = "禁用" .. ( list.Name or "无名列表" ) .. "中的" .. ( ability.item and ability.link or k ) .. " (#|cFFFFD100" .. a .. "|r)"
                            toggle.desc = "这个技能被使用在|cFFFFD100" .. list.Name .. "|r中的第" .. a .. "号。"
                            toggle.order = entries
                            toggle.width = "full"
                            toggle.hidden = false

                            abOption.args[ i .. ':' .. a ] = toggle
                        end
                    end
                end
            end

            if entries > 51 then
                abOption.args.listHeader.hidden = false
                abOption.args.listDescription.hidden = false
            end

            return false
        end

        option.args[ v ] = abOption
    end

    return option

end


ns.TrinketSettings = function ()

    local option = {
        type = 'group',
        name = "饰品/装备",
        order = 22,
        args = {
            heading = {
                type = 'description',
                name = "这些设置适用于通过技能列表中的[使用道具]指令使用饰品和装备。" ..
                    "除了手动编辑你的技能列表，你可以在这里启用或禁用特定的饰品，或者设置使用该饰品要求的最小或最大的敌人数量。" ..
                    "\n\n" ..
                    "|cFFFFD100如果你的技能列表中包含具有特定使用条件的特殊饰品，你可以在这里禁用这些饰品。|r",
                order = 1,
                width = "full",
            }
        },
        childGroups = 'select'
    }

    local trinkets = Hekili.DB.profile.trinkets

    for i, setting in pairs( class.itemSettings ) do
        option.args[ setting.key ] = {
            type = "group",
            name = setting.name,
            order = 10 + i,
            -- inline = true,
            args = setting.options
        }

        option.args[ setting.key ].hidden = function( info )

            -- Hide toggles in case they're outdated.
            for k, v in pairs( setting.options ) do
                if k:match( "^(%d+):(%d+)$") then
                    v.hidden = true
                end
            end

            for i, list in ipairs( Hekili.DB.profile.actionLists ) do
                local entries = 100

                if list.Name ~= '可用道具' then
                    for a, action in ipairs( list.Actions ) do
                        if action.Ability == setting.key then
                            entries = entries + 1
                            local toggle = option.args[ setting.key ].args[ i .. ':' .. a ] or {}

                            local name = type( setting.name ) == 'function' and setting.name() or setting.name

                            toggle.type = "toggle"
                            toggle.name = "禁用|cFFFFD100" .. ( list.Name or "(没有列表名称)" ) .. "|r中的第" .. a .. "号" .. name .. "。"
                            toggle.desc = "此道具位于技能列表|cFFFFD100" .. list.Name .. "|r中的第" .. a .. "号。\n\n" ..
                                "这通常意味着使用该道具需要特定条件或特殊区域等苛刻的条件。" ..
                                "如果你不想该技能列表推荐该道具，请勾选此框。"
                            toggle.order = entries
                            toggle.width = "full"
                            toggle.hidden = false

                            option.args[ setting.key ].args[ i .. ':' .. a ] = toggle
                        end
                    end
                end
            end

            return false
        end

        trinkets[ setting.key ] = trinkets[ setting.key ] or {
            disabled = false,
            minimum = 1,
            maximum = 0
        }

    end

    return option

end


do
    local impControl = {
        name = "",
        source = UnitName( "player" ) .. " @ " .. GetRealmName(),
        apl = "在此处粘贴您的SimulationCraft操作优先级列表或配置文件。",

        lists = {},
        warnings = ""
    }

    Hekili.ImporterData = impControl


    local function AddWarning( s )
        if impControl.warnings then
            impControl.warnings = impControl.warnings .. s .. "\n"
            return
        end

        impControl.warnings = s .. "\n"
    end


    function Hekili:GetImporterOption( info )
        return impControl[ info[ #info ] ]
    end


    function Hekili:SetImporterOption( info, value )
        if type( value ) == 'string' then value = value:trim() end
        impControl[ info[ #info ] ] = value
        impControl.warnings = nil
    end


    function Hekili:ImportSimcAPL( name, source, apl, pack )

        name = name or impControl.name
        source = source or impControl.source
        apl = apl or impControl.apl

        impControl.warnings = ""

        local lists = {
            precombat = "",
            default = "",
        }

        local count = 0

        -- Rename the default action list to 'default'
        apl = "\n" .. apl
        apl = apl:gsub( "actions(%+?)=", "actions.default%1=" )

        local comment

        for line in apl:gmatch( "\n([^\n^$]*)") do
            local newComment = line:match( "^# (.+)" )
            if newComment then comment = newComment end

            local list, action = line:match( "^actions%.(%S-)%+?=/?([^\n^$]*)" )

            if list and action then
                lists[ list ] = lists[ list ] or ""

                --[[ if action:sub( 1, 6 ) == "potion" then
                    local potion = action:match( ",name=(.-),") or action:match( ",name=(.-)$" ) or class.potion or ""
                    action = action:gsub( potion, "\"" .. potion .. "\"" )
                end ]]

                if action:sub( 1, 16 ) == "call_action_list" or action:sub( 1, 15 ) == "run_action_list" then
                    local name = action:match( ",name=(.-)," ) or action:match( ",name=(.-)$" )
                    if name then action:gsub( ",name=" .. name, ",name=\"" .. name .. "\"" ) end
                end

                if comment then
                    action = action .. ',description=' .. comment:gsub( ",", ";" )
                    comment = nil
                end

                lists[ list ] = lists[ list ] .. "actions+=/" .. action .. "\n"
            end
        end

        local count = 0
        local output = {}

        for name, list in pairs( lists ) do
            local import, warnings = self:ParseActionList( list )

            if warnings then
                AddWarning( "警告：导入'" .. name .. "'列表需要一些自动修改。" )

                for i, warning in ipairs( warnings ) do
                    AddWarning( warning )
                end

                AddWarning( "" )
            end

            if import then
                output[ name ] = import

                for i, entry in ipairs( import ) do
                    entry.enabled = not ( entry.action == 'heroism' or entry.action == 'bloodlust' )
                end

                count = count + 1
            end
        end

        local use_items_found = false
        local trinket1_found = false
        local trinket2_found = false

        for _, list in pairs( output ) do
            for i, entry in ipairs( list ) do
                if entry.action == "use_items" then use_items_found = true end
                if entry.action == "trinket1" then trinket1_found = true end
                if entry.action == "trinket2" then trinket2_found = true end
            end
        end

        if not use_items_found and not ( trinket1_found and trinket2_found ) then
            AddWarning( "此配置文件缺少对通用饰品的支持。建议每个优先级都需要包括：\n" ..
                " - [使用物品]，包含任何没有包含在优先级中的饰品，或者\n" ..
                " - [饰品1]和[饰品2]，这样做将推荐对应饰品装备栏中的饰品。" )
        end

        if not output.default then output.default = {} end
        if not output.precombat then output.precombat = {} end

        if count == 0 then
            AddWarning( "未能从当前配置文件导入任何技能列表。" )
        else
            AddWarning( "成功导入了" .. count .. "个技能列表。" )
        end

        return output, impControl.warnings
    end
end


local optionBuffer = {}

local buffer = function( msg )
    optionBuffer[ #optionBuffer + 1 ] = msg
end

local getBuffer = function()
    local output = table.concat( optionBuffer )
    wipe( optionBuffer )
    return output
end

local getColoredName = function( tab )
    if not tab then return '(none)'
    elseif tab.Default then return '|cFF00C0FF' .. tab.Name .. '|r'
else return '|cFFFFC000' .. tab.Name .. '|r' end
end


local snapshots = {
    snaps = {},
    empty = {},

    selected = 0
}


local config = {
    qsDisplay = 99999,

    qsShowTypeGroup = false,
    qsDisplayType = 99999,
    qsTargetsAOE = 3,

    displays = {}, -- auto-populated and recycled.
    displayTypes = {
        [1] = "Primary",
        [2] = "AOE",
        [3] = "Automatic",
        [99999] = " "
    },

    expanded = {
        cooldowns = true
    },
    adding = {},
}


function Hekili:NewGetOption( info )

    local depth = #info
    local option = depth and info[depth] or nil

    if not option then return end

    if config[ option ] then return config[ option ] end
end


function Hekili:NewSetOption( info, value )

    local depth = #info
    local option = depth and info[depth] or nil

    if not option then return end

    local nValue = tonumber( value )
    local sValue = tostring( value )

    if option == 'qsShowTypeGroup' then config[option] = value
    else config[option] = nValue end
end


local specs = {}
local activeSpec

local function GetCurrentSpec()
    activeSpec = activeSpec or GetSpecializationInfo( GetSpecialization() )
    return activeSpec
end

local function SetCurrentSpec( _, val )
    activeSpec = val
end

local function GetCurrentSpecList()
    return specs
end


do
    local packs = {}

    local specNameByID = {}
    local specIDByName = {}

    local ACD = LibStub( "AceConfigDialog-3.0" )

    local shareDB = {
        actionPack = "",
        packName = "",
        export = "",

        import = "",
        imported = {},
        importStage = 0
    }


    function Hekili:GetPackShareOption( info )
        local n = #info
        local option = info[ n ]

        return shareDB[ option ]
    end


    function Hekili:SetPackShareOption( info, val, v2, v3, v4 )
        local n = #info
        local option = info[ n ]

        if type(val) == 'string' then val = val:trim() end

        shareDB[ option ] = val

        if option == "actionPack" and rawget( self.DB.profile.packs, shareDB.actionPack ) then
            shareDB.export = self:SerializeActionPack( shareDB.actionPack )
        else
            shareDB.export = ""
        end
    end


    function Hekili:SetSpecOption( info, val )
        local n = #info
        local spec, option = info[1], info[n]

        spec = specIDByName[ spec ]
        if not spec then return end

        if type( val ) == 'string' then val = val:trim() end

        self.DB.profile.specs[ spec ] = self.DB.profile.specs[ spec ] or {}
        self.DB.profile.specs[ spec ][ option ] = val

        if option == "package" then self:UpdateUseItems(); self:ForceUpdate( "SPEC_PACKAGE_CHANGED" )
        elseif option == "potion" and state.spec[ info[1] ] then class.potion = val
        elseif option == "enabled" then ns.StartConfiguration() end

        Hekili:UpdateDamageDetectionForCLEU()
    end


    function Hekili:GetSpecOption( info )
        local n = #info
        local spec, option = info[1], info[n]

        spec = specIDByName[ spec ]
        if not spec then return end

        self.DB.profile.specs[ spec ] = self.DB.profile.specs[ spec ] or {}

        if option == "potion" then
            local p = self.DB.profile.specs[ spec ].potion

            if not class.potionList[ p ] then
                return class.potions[ p ] and class.potions[ p ].key or p
            end
        end

        return self.DB.profile.specs[ spec ][ option ]
    end


    function Hekili:SetSpecPref( info, val )
    end

    function Hekili:GetSpecPref( info )
    end


    function Hekili:SetAbilityOption( info, val )
        local n = #info
        local ability, option = info[2], info[n]

        local spec = GetCurrentSpec()

        self.DB.profile.specs[ spec ].abilities[ ability ][ option ] = val
        if option == "toggle" then Hekili:EmbedAbilityOption( nil, ability ) end
    end

    function Hekili:GetAbilityOption( info )
        local n = #info
        local ability, option = info[2], info[n]

        local spec = GetCurrentSpec()

        return self.DB.profile.specs[ spec ].abilities[ ability ][ option ]
    end


    function Hekili:SetItemOption( info, val )
        local n = #info
        local item, option = info[2], info[n]

        local spec = GetCurrentSpec()

        self.DB.profile.specs[ spec ].items[ item ][ option ] = val
        if option == "toggle" then Hekili:EmbedItemOption( nil, item ) end
    end

    function Hekili:GetItemOption( info )
        local n = #info
        local item, option = info[2], info[n]

        local spec = GetCurrentSpec()

        return self.DB.profile.specs[ spec ].items[ item ][ option ]
    end


    function Hekili:EmbedAbilityOption( db, key )
        db = db or self.Options
        if not db or not key then return end

        local ability = class.abilities[ key ]
        if not ability then return end

        local toggles = {}

        local k = class.abilityList[ ability.key ]
        local v = ability.key

        if not k or not v then return end

        local useName = class.abilityList[ v ] and class.abilityList[v]:match("|t (.+)$") or ability.name

        if not useName then
            Hekili:Error( "当前技能%s(id:%d)没有可用选项。", ability.key or "不存在此ID", ability.id or 0 )
            useName = ability.key or ability.id or "???"
        end

        local option = db.args.abilities.plugins.actions[ v ] or {}

        option.type = "group"
        option.name = function () return ( state:IsDisabled( v, true ) and "|cFFFF0000" or "" ) .. useName .. "|r" end
        option.order = 1
        option.set = "SetAbilityOption"
        option.get = "GetAbilityOption"
        option.args = {
            disabled = {
                type = "toggle",
                name = function () return "禁用" .. ( ability.item and ability.link or k ) end,
                desc = function () return "如果勾选，此技能将|cffff0000永远|r不会被插件推荐。" ..
                    "如果其他技能依赖此技能" .. ( ability.item and ability.link or k ) .. "，那么可能会出现问题。" end,
                width = 1.5,
                order = 1,
            },

            boss = {
                type = "toggle",
                name = "仅用于BOSS战",
                desc = "如果勾选，插件将不会推荐此技能" .. k .. "，除非你处于BOSS中。如果不勾选，" .. k .. "技能会在所有战斗中被推荐。",
                width = 1.5,
                order = 1.1,
            },

            keybind = {
                type = "input",
                name = "覆盖按键绑定文本",
                desc = "如果设置此项，当推荐此技能时，插件将显示此文本，而不是自动检测到的绑定按键提示。" ..
                "如果插件检测到错误的绑定按键，这将解决此问题。",
                validate = function( info, val )
                    val = val:trim()
                    if val:len() > 20 then return "绑定按键文本的长度不应超过20个字符。" end
                    return true
                end,
                width = 1.5,
                order = 2,
            },

            toggle = {
                type = "select",
                name = "开关状态切换",
                desc = "设置此项后，插件在技能列表中使用必须的开关切换。" ..
                "当开关被关闭时，技能将被视为不可用，插件将假装它们处于冷却状态（除非另有设置）。",
                width = 1.5,
                order = 3,
                values = function ()
                    table.wipe( toggles )

                    local t = class.abilities[ v ].toggle or "none"
                    if t == "精华" then t = "盟约" end

                    toggles.none = "无"
                    toggles.default = "默认|cffffd100(" .. t .. ")|r"
                    toggles.cooldowns = "爆发"
                    toggles.essences = "盟约"
                    toggles.defensives = "防御"
                    toggles.interrupts = "打断"
                    toggles.potions = "药剂"
                    toggles.custom1 = "自定义1"
                    toggles.custom2 = "自定义2"

                    return toggles
                end,
            },

            targetMin = {
                type = "range",
                name = "最小目标数",
                desc = "如果设置大于0，则只有监测到敌人数至少有" .. k .. "人的情况下，才会推荐此项。所有其他条件也必须满足。\n设置为0将忽略此项。",
                width = 1.5,
                min = 0,
                max = 15,
                step = 1,
                order = 3.1,
            },

            targetMax = {
                type = "range",
                name = "最大目标数",
                desc = "如果设置大于0，则只有监测到敌人数小于" .. k .. "人的情况下，才会推荐此项。所有其他条件也必须满足。.\n设置为0将忽略此项。",
                width = 1.5,
                min = 0,
                max = 15,
                step = 1,
                order = 3.2,
            },

            clash = {
                type = "range",
                name = "冲突",
                desc = "如果设置大于0，插件将假设" .. k .. "拥有更快的冷却时间。" ..
                "当某个技能的优先级非常高，并且你希望插件更多地推荐它，而不是其他更快的可能技能时，此项会很有效。",
                width = 3,
                min = -1.5,
                max = 1.5,
                step = 0.05,
                order = 4,
            },
        }

        db.args.abilities.plugins.actions[ v ] = option
    end



    local testFrame = CreateFrame( "Frame" )
    testFrame.Texture = testFrame:CreateTexture()

    function Hekili:EmbedAbilityOptions( db )
        db = db or self.Options
        if not db then return end

        local abilities = {}
        local toggles = {}

        for k, v in pairs( class.abilityList ) do
            local a = class.abilities[ k ]
            if a and ( a.id > 0 or a.id < -100 ) and a.id ~= state.cooldown.global_cooldown.id and not a.item then
                abilities[ v ] = k
            end
        end

        for k, v in orderedPairs( abilities ) do
            local ability = class.abilities[ v ]
            local useName = class.abilityList[ v ] and class.abilityList[v]:match("|t (.+)$") or ability.name

            if not useName then
                Hekili:Error( "No name available for %s (id:%d) in EmbedAbilityOptions.", ability.key or "no_id", ability.id or 0 )
                useName = ability.key or ability.id or "???"
            end

            local option = {
                type = "group",
                name = function () return ( state:IsDisabled( v, true ) and "|cFFFF0000" or "" ) .. useName .. "|r" end,
                order = 1,
                set = "SetAbilityOption",
                get = "GetAbilityOption",
                args = {
                    disabled = {
                        type = "toggle",
                        name = function () return "禁用" .. ( ability.item and ability.link or k ) end,
                        desc = function () return "如果勾选，此技能将|cffff0000永远|r不会被插件推荐。" ..
                            "如果其他技能依赖此技能" .. ( ability.item and ability.link or k ) .. "，那么可能会出现问题。" end,
                        width = 1.5,
                        order = 1,
                    },

                    boss = {
                        type = "toggle",
                        name = "仅用于BOSS战",
                        desc = "如果勾选，插件将不会推荐此技能" .. k .. "，除非你处于BOSS中。如果不勾选，" .. k .. "技能会在所有战斗中被推荐。",
                        width = 1,
                        order = 1.1,
                    },

                    toggle = {
                        type = "select",
                        name = "开关状态切换",
                        desc = "设置此项后，插件在技能列表中使用必须的开关切换。" ..
                            "当开关被关闭时，技能将被视为不可用，插件将假设它们处于冷却状态（除非另有设置）。",
                        width = 1,
                        order = 1.2,
                        values = function ()
                            table.wipe( toggles )

                            local t = class.abilities[ v ].toggle or "none"
                            if t == "essences" then t = "covenants" end

                            toggles.none = "None"
                            toggles.default = "默认|cffffd100(" .. t .. ")|r"
                            toggles.cooldowns = "爆发"
                            toggles.essences = "盟约"
                            toggles.defensives = "防御"
                            toggles.interrupts = "打断"
                            toggles.potions = "药剂"
                            toggles.custom1 = "自定义1"
                            toggles.custom2 = "自定义2"

                            return toggles
                        end,
                    },

                    lineBreak1 = {
                        type = "description",
                        name = " ",
                        width = "full",
                        order = 1.9
                    },

                    targetMin = {
                        type = "range",
                        name = "最小目标数",
                        desc = "如果设置大于0，则只有监测到敌人数至少有" .. k .. "人的情况下，才会推荐此项。所有其他条件也必须满足。\n设置为0将忽略此项。",
                        width = 1,
                        min = 0,
                        max = 15,
                        step = 1,
                        order = 2,
                    },

                    targetMax = {
                        type = "range",
                        name = "最大目标数",
                        desc = "如果设置大于0，则只有监测到敌人数小于" .. k .. "人的情况下，才会推荐此项。所有其他条件也必须满足。.\n设置为0将忽略此项。",
                        width = 1,
                        min = 0,
                        max = 15,
                        step = 1,
                        order = 2.1,
                    },

                    clash = {
                        type = "range",
                        name = "冲突",
                        desc = "如果设置大于0，插件将假设" .. k .. "拥有更快的冷却时间。" ..
                            "当某个技能的优先级非常高，并且你希望插件更多地推荐它，而不是其他更快的可能技能时，此项会很有效。",
                        width = 1,
                        min = -1.5,
                        max = 1.5,
                        step = 0.05,
                        order = 2.2,
                    },

                    lineBreak2 = {
                        type = "description",
                        name = "",
                        width = "full",
                        order = 2.9,
                    },

                    keybind = {
                        type = "input",
                        name = "技能按键文字",
                        desc = "如果设置此项，插件将在推荐此技能时显示此处的文字，替代自动检测到的技能绑定按键的名称。" ..
                            "如果插件检测你的按键绑定出现问题，此设置能够有所帮助。",
                        validate = function( info, val )
                            val = val:trim()
                            if val:len() > 6 then return "技能按键文字长度不应超过6个字符。" end
                            return true
                        end,
                        width = 1.5,
                        order = 3,
                    },

                    noIcon = {
                        type = "input",
                        name = "替换图标",
                        desc = "如果设置此项，插件将尝试加载此处的图像作为技能图标，替代默认图标。此处可设置图标ID或图像文件的路径。\n\n" ..
                            "此处留空后按下回车重置为默认图标。",
                        icon = function()
                            local options = Hekili:GetActiveSpecOption( "abilities" )
                            return options and options[ v ] and options[ v ].icon or nil
                        end,
                        validate = function( info, val )
                            val = val:trim()
                            testFrame.Texture:SetTexture( "?" )
                            testFrame.Texture:SetTexture( val )
                            return testFrame.Texture:GetTexture() ~= "?"
                        end,
                        set = function( info, val )
                            val = val:trim()
                            if val:len() == 0 then val = nil end

                            local options = Hekili:GetActiveSpecOption( "abilities" )
                            options[ v ].icon = val
                        end,
                        hidden = function()
                            local options = Hekili:GetActiveSpecOption( "abilities" )
                            return ( options and rawget( options, v ) and options[ v ].icon )
                        end,
                        width = 1.5,
                        order = 3.1,
                    },

                    hasIcon = {
                        type = "input",
                        name = "Icon Replacement",
                        desc = "If specified, the addon will attempt to load this texture instead of the default icon.  This can be a texture ID or a path to a texture file.\n\n" ..
                            "Leave blank and press Enter to reset to the default icon.",
                        icon = function()
                            local options = Hekili:GetActiveSpecOption( "abilities" )
                            return options and options[ v ] and options[ v ].icon or nil
                        end,
                        validate = function( info, val )
                            val = val:trim()
                            testFrame.Texture:SetTexture( "?" )
                            testFrame.Texture:SetTexture( val )
                            return testFrame.Texture:GetTexture() ~= "?"
                        end,
                        get = function()
                            local options = Hekili:GetActiveSpecOption( "abilities" )
                            return options and rawget( options, v ) and options[ v ].icon
                        end,
                        set = function( info, val )
                            val = val:trim()
                            if val:len() == 0 then val = nil end

                            local options = Hekili:GetActiveSpecOption( "abilities" )
                            options[ v ].icon = val
                        end,
                        hidden = function()
                            local options = Hekili:GetActiveSpecOption( "abilities" )
                            return not ( options and rawget( options, v ) and options[ v ].icon )
                        end,
                        width = 1.3,
                        order = 3.2,
                    },

                    showIcon = {
                        type = 'description',
                        name = "",
                        image = function()
                            local options = Hekili:GetActiveSpecOption( "abilities" )
                            return options and rawget( options, v ) and options[ v ].icon
                        end,
                        width = 0.2,
                        order = 3.3,
                    }
                }
            }

            db.args.abilities.plugins.actions[ v ] = option
        end
    end


    function Hekili:EmbedItemOption( db, item )
        db = db or self.Options
        if not db then return end

        local ability = class.abilities[ item ]
        local toggles = {}

        local k = class.itemList[ ability.item ] or ability.name
        local v = ability.itemKey or ability.key

        if not item or not ability.item or not k then
            Hekili:Error( "Unable to find %s / %s / %s in the itemlist.", item or "unknown", ability.item or "unknown", k or "unknown" )
            return
        end

        local option = db.args.items.plugins.equipment[ v ] or {}

        option.type = "group"
        option.name = function () return ( state:IsDisabled( v, true ) and "|cFFFF0000" or "" ) .. ability.name .. "|r" end
        option.order = 1
        option.set = "SetItemOption"
        option.get = "GetItemOption"
        option.args = {
            disabled = {
                type = "toggle",
                name = function () return "禁用" .. ( ability.item and ability.link or k ) end,
                desc = function () return "如果勾选，此技能将|cffff0000永远|r不会被插件推荐。" ..
                    "如果其他技能依赖此技能" .. ( ability.item and ability.link or k ) .. "，那么可能会出现问题。" end,
                width = 1.5,
                order = 1,
            },

            boss = {
                type = "toggle",
                name = "仅用于BOSS战",
                desc = "如果勾选，插件将不会推荐该物品" .. k .. "，除非你处于BOSS战。如果不选中，" .. k .. "物品会在所有战斗中被推荐。",
                width = 1.5,
                order = 1.1,
            },

            keybind = {
                type = "input",
                name = "技能按键文字",
                desc = "如果设置此项，插件将在推荐此技能时显示此处的文字，替代自动检测到的技能绑定按键的名称。" ..
                    "如果插件检测你的按键绑定出现问题，此设置能够有所帮助。",
                validate = function( info, val )
                    val = val:trim()
                    if val:len() > 6 then return "技能按键文字长度不应超过6个字符。" end
                    return true
                end,
                width = 1.5,
                order = 2,
            },

            toggle = {
                type = "select",
                name = "开关状态切换",
                desc = "设置此项后，插件在技能列表中使用必须的开关切换。" ..
                    "当开关被关闭时，技能将被视为不可用，插件将假设它们处于冷却状态（除非另有设置）。",
                width = 1.5,
                order = 3,
                values = function ()
                    table.wipe( toggles )

                    toggles.none = "无"
                    toggles.default = "默认" .. ( class.abilities[ v ].toggle and ( " |cffffd100(" .. class.abilities[ v ].toggle .. ")|r" ) or " |cffffd100（无）|r" )
                    toggles.cooldowns = "爆发"
                    toggles.essences = "盟约"
                    toggles.defensives = "防御"
                    toggles.interrupts = "打断"
                    toggles.potions = "药剂"
                    toggles.custom1 = "自定义1"
                    toggles.custom2 = "自定义2"

                    return toggles
                end,
            },

            --[[ clash = {
                type = "range",
                name = "Clash",
                desc = "If set above zero, the addon will pretend " .. k .. " has come off cooldown this much sooner than it actually has.  " ..
                    "当某个技能的优先级非常高，并且你希望插件更多地推荐它，而不是其他更快的可能技能时，此项会很有效。",
                width = "full",
                min = -1.5,
                max = 1.5,
                step = 0.05,
                order = 4,
            }, ]]

            targetMin = {
                type = "range",
                name = "最小目标数",
                desc = "如果设置大于0，则只有检测到敌人数至少有" .. k .. "人的情况下，才会推荐此道具。\n设置为0将忽略此项。",
                width = 1.5,
                min = 0,
                max = 15,
                step = 1,
                order = 5,
            },

            targetMax = {
                type = "range",
                name = "最大目标数",
                desc = "如果设置大于0，则只有监测到敌人数小于" .. k .. "人的情况下，才会推荐此道具。\n设置为0将忽略此项。",
                width = 1.5,
                min = 0,
                max = 15,
                step = 1,
                order = 6,
            },
        }

        db.args.items.plugins.equipment[ v ] = option
    end


    function Hekili:EmbedItemOptions( db )
        db = db or self.Options
        if not db then return end

        local abilities = {}
        local toggles = {}

        for k, v in pairs( class.abilities ) do
            if k == "potion" or v.item and not abilities[ v.itemKey or v.key ] then
                local name = class.itemList[ v.item ] or v.name
                if name then abilities[ name ] = v.itemKey or v.key end
            end
        end

        for k, v in orderedPairs( abilities ) do
            local ability = class.abilities[ v ]
            local option = {
                type = "group",
                name = function () return ( state:IsDisabled( v, true ) and "|cFFFF0000" or "" ) .. ability.name .. "|r" end,
                order = 1,
                set = "SetItemOption",
                get = "GetItemOption",
                args = {
                    multiItem = {
                        type = "description",
                        name = function ()
                            local output = "这些设置将应用于以下|cFF00FF00所有|r类似的PvP饰品：\n\n"

                            if ability.items then
                                for i, itemID in ipairs( ability.items ) do
                                    output = output .. "     " .. class.itemList[ itemID ] .. "\n"
                                end
                                output = output .. "\n"
                            end

                            return output
                        end,
                        fontSize = "medium",
                        width = "full",
                        order = 1,
                        hidden = function () return ability.key ~= "gladiators_badge" and ability.key ~= "gladiators_emblem" and ability.key ~= "gladiators_medallion" end,
                    },

                    disabled = {
                        type = "toggle",
                        name = function () return "禁用" .. ( ability.item and ability.link or k ) end,
                        desc = function () return "如果勾选，此技能将|cffff0000永远|r不会被插件推荐。" ..
                            "如果其他技能依赖此技能" .. ( ability.item and ability.link or k ) .. "，那么可能会出现问题。" end,
                        width = 1.5,
                        order = 1.05,
                    },

                    boss = {
                        type = "toggle",
                        name = "仅用于BOSS战",
                        desc = "如果勾选，插件将不会推荐该物品" .. k .. "，除非你处于BOSS战。如果不选中，" .. k .. "物品会在所有战斗中被推荐。",
                        width = 1.5,
                        order = 1.1,
                    },

                    keybind = {
                        type = "input",
                        name = "技能按键文字",
                        desc = "如果设置此项，插件将在推荐此技能时显示此处的文字，替代自动检测到的技能绑定按键的名称。" ..
                            "如果插件检测你的按键绑定出现问题，此设置能够有所帮助。",
                        validate = function( info, val )
                            val = val:trim()
                            if val:len() > 6 then return "技能按键文字长度不应超过6个字符。" end
                            return true
                        end,
                        width = 1.5,
                        order = 2,
                    },

                    toggle = {
                        type = "select",
                        name = "开关状态切换",
                        desc = "设置此项后，插件在技能列表中使用必须的开关切换。" ..
                            "当开关被关闭时，技能将被视为不可用，插件将假装它们处于冷却状态（除非另有设置）。",
                        width = 1.5,
                        order = 3,
                        values = function ()
                            table.wipe( toggles )

                            toggles.none = "无"
                            toggles.default = "默认" .. ( class.abilities[ v ].toggle and ( " |cffffd100(" .. class.abilities[ v ].toggle .. ")|r" ) or " |cffffd100（无）|r" )
                            toggles.cooldowns = "爆发"
                            toggles.essences = "盟约"
                            toggles.defensives = "防御"
                            toggles.interrupts = "打断"
                            toggles.potions = "药剂"
                            toggles.custom1 = "自定义1"
                            toggles.custom2 = "自定义2"

                            return toggles
                        end,
                    },

                    --[[ clash = {
                        type = "range",
                        name = "冲突",
                        desc = "If set above zero, the addon will pretend " .. k .. " has come off cooldown this much sooner than it actually has.  " ..
                            "当某个技能的优先级非常高，并且你希望插件更多地推荐它，而不是其他更快的可能技能时，此项会很有效。",
                        width = "full",
                        min = -1.5,
                        max = 1.5,
                        step = 0.05,
                        order = 4,
                    }, ]]

                    targetMin = {
                        type = "range",
                        name = "最小目标数",
                        desc = "如果设置大于0，则只有监测到敌人数至少有" .. k .. "人的情况下，才会推荐此道具。\n设置为0将忽略此项。",
                        width = 1.5,
                        min = 0,
                        max = 15,
                        step = 1,
                        order = 5,
                    },

                    targetMax = {
                        type = "range",
                        name = "最大目标数",
                        desc = "如果设置大于0，则只有监测到敌人数小于" .. k .. "人的情况下，才会推荐此道具。\n设置为0将忽略此项。",
                        width = 1.5,
                        min = 0,
                        max = 15,
                        step = 1,
                        order = 6,
                    },
                }
            }

            db.args.items.plugins.equipment[ v ] = option
        end

        self.NewItemInfo = false
    end


    local ToggleCount = {}
    local tAbilities = {}
    local tItems = {}


    local function BuildToggleList( options, specID, section, useName, description, extraOptions )
        local db = options.args.toggles.plugins[ section ]
        local e

        local function tlEntry( key )
            if db[ key ] then
                v.hidden = nil
                return db[ key ]
            end
            db[ key ] = {}
            return db[ key ]
        end

        if db then
            for k, v in pairs( db ) do
                v.hidden = true
            end
        else
            db = {}
        end

        local nToggles = ToggleCount[ specID ] or 0
        nToggles = nToggles + 1

        local hider = function()
            return not config.expanded[ section ]
        end

        local settings = Hekili.DB.profile.specs[ specID ]

        wipe( tAbilities )
        for k, v in pairs( class.abilityList ) do
            local a = class.abilities[ k ]
            if a and ( a.id > 0 or a.id < -100 ) and a.id ~= state.cooldown.global_cooldown.id and not a.item then
                if settings.abilities[ k ].toggle == section or a.toggle == section and settings.abilities[ k ].toggle == 'default' then
                    tAbilities[ k ] = class.abilityList[ k ] or v
                end
            end
        end

        e = tlEntry( section .. "Spacer" )
        e.type = "description"
        e.name = ""
        e.order = nToggles
        e.width = "full"

        e = tlEntry( section .. "Expander" )
        e.type = "execute"
        e.name = ""
        e.order = nToggles + 0.01
        e.width = 0.15
        e.image = function ()
            if not config.expanded[ section ] then return "Interface\\AddOns\\Hekili\\Textures\\WhiteRight" end
            return "Interface\\AddOns\\Hekili\\Textures\\WhiteDown"
        end
        e.imageWidth = 20
        e.imageHeight = 20
        e.func = function( info )
            config.expanded[ section ] = not config.expanded[ section ]
        end

        if type( useName ) == "function" then
            useName = useName()
        end

        e = tlEntry( section .. "Label" )
        e.type = "description"
        e.name = useName or section
        e.order = nToggles + 0.02
        e.width = 2.85
        e.fontSize = "large"

        if description then
            e = tlEntry( section .. "Description" )
            e.type = "description"
            e.name = description
            e.order = nToggles + 0.05
            e.width = "full"
            e.hidden = hider
        else
            if db[ section .. "Description" ] then db[ section .. "Description" ].hidden = true end
        end

        local count, offset = 0, 0

        for ability, isMember in orderedPairs( tAbilities ) do
            if isMember then
                if count % 2 == 0 then
                    e = tlEntry( section .. "LB" .. count )
                    e.type = "description"
                    e.name = ""
                    e.order = nToggles + 0.1 + offset
                    e.width = "full"
                    e.hidden = hider

                    offset = offset + 0.001
                end

                e = tlEntry( section .. "Remove" .. ability )
                e.type = "execute"
                e.name = ""
                e.desc = function ()
                    local a = class.abilities[ ability ]
                    local desc
                    if a then
                        if a.item then desc = a.link or a.name
                        else desc = class.abilityList[ a.key ] or a.name end
                    end
                    desc = desc or ability

                    return "Remove " .. desc .. " from " .. ( useName or section ) .. " toggle."
                end
                e.image = RedX
                e.imageHeight = 16
                e.imageWidth = 16
                e.order = nToggles + 0.1 + offset
                e.width = 0.15
                e.func = function ()
                    settings.abilities[ ability ].toggle = 'none'
                    -- e.hidden = true
                    Hekili:EmbedSpecOptions()
                end
                e.hidden = hider

                offset = offset + 0.001


                e = tlEntry( section .. ability .. "Name" )
                e.type = "description"
                e.name = function ()
                    local a = class.abilities[ ability ]
                    if a then
                        if a.item then return a.link or a.name end
                        return class.abilityList[ a.key ] or a.name
                    end
                    return ability
                end
                e.order = nToggles + 0.1 + offset
                e.fontSize = "medium"
                e.width = 1.35
                e.hidden = hider

                offset = offset + 0.001

                --[[ e = tlEntry( section .. "Toggle" .. ability )
                e.type = "toggle"
                e.icon = RedX
                e.name = function ()
                    local a = class.abilities[ ability ]
                    if a then
                        if a.item then return a.link or a.name end
                        return a.name
                    end
                    return ability
                end
                e.desc = "Remove this from " .. ( useName or section ) .. "?"
                e.order = nToggles + 0.1 + offset
                e.width = 1.5
                e.hidden = hider
                e.get = function() return true end
                e.set = function()
                    settings.abilities[ ability ].toggle = 'none'
                    Hekili:EmbedSpecOptions()
                end

                offset = offset + 0.001 ]]

                count = count + 1
            end
        end


        e = tlEntry( section .. "FinalLB" )
        e.type = "description"
        e.name = ""
        e.order = nToggles + 0.993
        e.width = "full"
        e.hidden = hider

        e = tlEntry( section .. "AddBtn" )
        e.type = "execute"
        e.name = ""
        e.image = "Interface\\AddOns\\Hekili\\Textures\\GreenPlus"
        e.imageHeight = 16
        e.imageWidth = 16
        e.order = nToggles + 0.995
        e.width = 0.15
        e.func = function ()
            config.adding[ section ]  = true
        end
        e.hidden = hider


        e = tlEntry( section .. "AddText" )
        e.type = "description"
        e.name = "添加技能"
        e.fontSize = "medium"
        e.width = 1.35
        e.order = nToggles + 0.996
        e.hidden = function ()
            return hider() or config.adding[ section ]
        end


        e = tlEntry( section .. "Add" )
        e.type = "select"
        e.name = ""
        e.values = function()
            local list = {}

            for k, v in pairs( class.abilityList ) do
                local a = class.abilities[ k ]
                if a and ( a.id > 0 or a.id < -100 ) and a.id ~= state.cooldown.global_cooldown.id and not a.item then
                    if settings.abilities[ k ].toggle == 'default' or settings.abilities[ k ].toggle == 'none' then
                        list[ k ] = class.abilityList[ k ] or v
                    end
                end
            end

            return list
        end
        e.order = nToggles + 0.997
        e.width = 1.35
        e.get = function () end
        e.set = function ( info, val )
            local a = class.abilities[ val ]
            if a then
                settings[ a.item and "items" or "abilities" ][ val ].toggle = section
                config.adding[ section ] = false
                Hekili:EmbedSpecOptions()
            end
        end
        e.hidden = function ()
            return hider() or not config.adding[ section ]
        end


        e = tlEntry( section .. "Reload" )
        e.type = "execute"
        e.name = ""
        e.order = nToggles + 0.998
        e.width = 0.15
        e.image = GetAtlasFile( "transmog-icon-revert" )
        e.imageCoords = GetAtlasCoords( "transmog-icon-revert" )
        e.imageWidth = 16
        e.imageHeight = 16
        e.func = function ()
            for k, v in pairs( settings.abilities ) do
                local a = class.abilities[ k ]
                if a and not a.item and v.toggle == section or ( class.abilities[ k ].toggle == section ) then v.toggle = 'default' end
            end
            for k, v in pairs( settings.items ) do
                local a = class.abilities[ k ]
                if a and a.item and v.toggle == section or ( class.abilities[ k ].toggle == section ) then v.toggle = 'default' end
            end
            Hekili:EmbedSpecOptions()
        end
        e.hidden = hider


        e = tlEntry( section .. "ReloadText" )
        e.type = "description"
        e.name = "重载默认值"
        e.fontSize = "medium"
        e.order = nToggles + 0.999
        e.width = 1.35
        e.hidden = hider


        if extraOptions then
            for k, v in pairs( extraOptions ) do
                e = tlEntry( section .. k )
                e.type = v.type or "description"
                e.name = v.name or ""
                e.desc = v.desc or ""
                e.order = v.order or ( nToggles + 1 )
                e.width = v.width or 1.35
                e.hidden = v.hidden or hider
                e.get = v.get
                e.set = v.set
                for opt, val in pairs( v ) do
                    if e[ opt ] == nil then
                        e[ opt ] = val
                    end
                end
            end
        end

        ToggleCount[ specID ] = nToggles
        options.args.toggles.plugins[ section ] = db
    end


    -- Options table constructors.
    function Hekili:EmbedSpecOptions( db )
        db = db or self.Options
        if not db then return end

        local i = 1

        while( true ) do
            local id, name, description, texture, baseName, coords

            if Hekili.IsWrath() then
                if i > 1 then break end
                name, baseName, id = UnitClass( "player" )
                coords = CLASS_ICON_TCOORDS[ baseName ]
                texture = "Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES"
            else
                id, name, description, texture = GetSpecializationInfo( i )
            end

            if not id then break end

            local spec = class.specs[ id ]

            if spec then
                local sName = lower( name )
                specNameByID[ id ] = sName
                specIDByName[ sName ] = id

                specs[ id ] = '|T' .. texture .. ':0|t ' .. name

                local options = {
                    type = "group",
                    -- name = specs[ id ],
                    name = name,
                    icon = texture,
                    iconCoords = coords,
                    desc = description,
                    order = 50 + i,
                    childGroups = "tab",
                    get = "GetSpecOption",
                    set = "SetSpecOption",

                    args = {
                        core = {
                            type = "group",
                            name = "核心",
                            desc = "对" .. specs[ id ] .. "职业专精的核心技能进行专门优化设置。",
                            order = 1,
                            args = {
                                enabled = {
                                    type = "toggle",
                                    name = "启用",
                                    desc = "如果勾选，插件将基于" .. name .. "职业专精的优先级进行技能推荐。",
                                    order = 0,
                                    width = "full",
                                },


                                --[[ packInfo = {
                                    type = 'group',
                                    name = "",
                                    inline = true,
                                    order = 1,
                                    args = {

                                    }
                                }, ]]

                                package = {
                                    type = "select",
                                    name = "优先级",
                                    desc = "插件在进行技能推荐时使用的优先级配置。",
                                    order = 1,
                                    width = 2.85,
                                    values = function( info, val )
                                        wipe( packs )

                                        for key, pkg in pairs( self.DB.profile.packs ) do
                                            local pname = pkg.builtIn and "|cFF00B4FF" .. key .. "|r" or key
                                            if pkg.spec == id then
                                                packs[ key ] = '|T' .. texture .. ':0|t ' .. pname
                                            end
                                        end

                                        packs[ '(none)' ] = '（无）'

                                        return packs
                                    end,
                                },

                                openPackage = {
                                    type = 'execute',
                                    name = "",
                                    desc = "打开查看该优先级配置和技能列表。",
                                    image = GetAtlasFile( "poi-door-right" ),
                                    imageCoords = GetAtlasCoords( "poi-door-right" ),
                                    imageHeight = 24,
                                    imageWidth = 24,
                                    disabled = function( info, val )
                                        local pack = self.DB.profile.specs[ id ].package
                                        return rawget( self.DB.profile.packs, pack ) == nil
                                    end,
                                    func = function ()
                                        ACD:SelectGroup( "Hekili", "packs", self.DB.profile.specs[ id ].package )
                                    end,
                                    order = 1.1,
                                    width = 0.15,
                                },

                                blankLine1 = {
                                    type = 'description',
                                    name = '',
                                    order = 1.2,
                                    width = 'full'
                                },

                                potion = {
                                    type = "select",
                                    name = "默认药剂",
                                    desc = "进行药剂推荐时，插件将推荐此药剂，除非优先级配置中另有推荐。",
                                    order = 2,
                                    width = 3,
                                    values = function ()
                                        local v = {}

                                        for k, p in pairs( class.potionList ) do
                                            if k ~= "default" then v[ k ] = p end
                                        end

                                        return v
                                    end,
                                },

                                blankLine2 = {
                                    type = 'description',
                                    name = '',
                                    order = 2.1,
                                    width = 'full'
                                }

                            },
                            plugins = {
                                settings = {}
                            },
                        },

                        targets = {
                            type = "group",
                            name = "目标识别",
                            desc = "设置插件如何识别和统计敌人的数量。",
                            order = 3,
                            args = {
                                -- Nameplate Quasi-Group
                                nameplates = {
                                    type = "toggle",
                                    name = "使用姓名板监测",
                                    desc = "如果勾选，插件将统计角色半径范围显示姓名板的所有敌人。" ..
                                    "此设置通常适用于|cFFFF0000近战|r职业。",
                                    width = "full",
                                    order = 1,
                                },

                                nameplateRange = {
                                    type = "range",
                                    name = "姓名板监测范围",
                                    desc = "如果勾选|cFFFFD100使用姓名板监测|r，插件将统计角色半径范围内显示姓名板的所有敌人。",
                                    width = "full",
                                    hidden = function()
                                        return self.DB.profile.specs[ id ].nameplates == false
                                    end,
                                    min = 5,
                                    max = 100,
                                    step = 1,
                                    order = 2,
                                },

                                nameplateSpace = {
                                    type = "description",
                                    name = " ",
                                    width = "full",
                                    hidden = function()
                                        return self.DB.profile.specs[ id ].nameplates == false
                                    end,
                                    order = 3,
                                },


                                -- Pet-Based Cluster Detection
                                petbased = {
                                    type = "toggle",
                                    name = "使用宠物范围监测",
                                    desc = function ()
                                        local msg = "如果勾选并配置正确，当目标处于你宠物的攻击范围内时，插件也会将宠物附近的目标一并统计。"

                                        if Hekili:HasPetBasedTargetSpell() then
                                            local spell = Hekili:GetPetBasedTargetSpell()
                                            local name, _, tex = GetSpellInfo( spell )

                                            msg = msg .. "\n\n|T" .. tex .. ":0|t |cFFFFD100" .. name .. "|r is on your action bar and will be used for all your " .. UnitClass("player") .. " pets."
                                        else
                                            msg = msg .. "\n\n|cFFFF0000必须在你的动作条上配置一个宠物技能。|r"
                                        end

                                        if GetCVar( "nameplateShowEnemies" ) == "1" then
                                            msg = msg .. "\n\n敌对姓名板已|cFF00FF00启用|r，将监测宠物附近的敌对目标。"
                                        else
                                            msg = msg .. "\n\n|cFFFF0000需要启用敌对姓名板。|r"
                                        end

                                        return msg
                                    end,
                                    width = "full",
                                    hidden = function ()
                                        return Hekili:GetPetBasedTargetSpells() == nil
                                    end,
                                    order = 3.1
                                },

                                petbasedGuidance = {
                                    type = "description",
                                    name = function ()
                                        local out

                                        if not self:HasPetBasedTargetSpell() then
                                            out = "想要基于宠物的监测生效，你必须将一个|cFF00FF00宠物技能|r配置到你的|cFF00FF00动作条|r上。\n\n"
                                            local spells = Hekili:GetPetBasedTargetSpells()

                                            if not spells then return " " end

                                            out = out .. "对于%s, 建议使用 |T%d:0|t |cFFFFD100%s|r，因为它的范围更广。它适用于你的所有宠物。"

                                            if spells.count > 1 then
                                                out = out .. "\n备选项："
                                            end

                                            local n = 0

                                            for spell in pairs( spells ) do
                                                if type( spell ) == "number" then
                                                    n = n + 1

                                                    local name, _, tex = GetSpellInfo( spell )

                                                    if n == 1 then
                                                        out = string.format( out, UnitClass( "player" ), tex, name )
                                                    elseif n == 2 and spells.count == 2 then
                                                        out = out .. "|T" .. tex .. ":0|t |cFFFFD100" .. name .. "|r."
                                                    elseif n ~= spells.count then
                                                        out = out .. "|T" .. tex .. ":0|t |cFFFFD100" .. name .. "|r, "
                                                    else
                                                        out = out .. "以及|T" .. tex .. ":0|t |cFFFFD100" .. name .. "|r."
                                                    end
                                                end
                                            end
                                        end

                                        if GetCVar( "nameplateShowEnemies" ) ~= "1" then
                                            if not out then
                                                out = "|cFFFF0000警报！|r 基于宠物的目标监测必须启用|cFFFFD100敌对姓名板|r。"
                                            else
                                                out = out .. "\n\n|cFFFF0000警报！|r 基于宠物的目标监测必须启用|cFFFFD100敌对姓名板|r。"
                                            end
                                        end

                                        return out
                                    end,
                                    fontSize = "medium",
                                    width = "full",
                                    hidden = function ( info, val )
                                        if Hekili:GetPetBasedTargetSpells() == nil then return true end
                                        if self.DB.profile.specs[ id ].petbased == false then return true end
                                        if self:HasPetBasedTargetSpell() and GetCVar( "nameplateShowEnemies" ) == "1" then return true end

                                        return false
                                    end,
                                    order = 3.11,
                                },

                                -- Damage Detection Quasi-Group
                                damage = {
                                    type = "toggle",
                                    name = "伤害敌人监测",
                                    desc = "如果勾选，插件将统计过去几秒内你攻击（或被攻击）的敌人。" ..
                                    "此项通常适用于|cFFFF0000远程|r职业。",
                                    width = "full",
                                    order = 4,
                                },

                                damageDots = {
                                    type = "toggle",
                                    name = "持续伤害敌人监测",
                                    desc = "如果勾选，插件将统计一段时间内受到来自你的持续伤害（流血、中毒等）的敌人，即使他们不在附近或受到你的其他伤害。\n\n" ..
                                    "此项可能不适用于近战职业专精，因为当你使用持续伤害技能后，敌人可能会超出攻击范围。如果同时使用|cFFFFD100姓名板监测|r，则不在姓名板监测范围内的敌人将被过滤。\n\n" ..
                                    "对于拥有持续伤害技能的远程职业专精，建议启用此项。",
                                    width = 1.49,
                                    hidden = function () return self.DB.profile.specs[ id ].damage == false end,
                                    order = 5,
                                },

                                damagePets = {
                                    type = "toggle",
                                    name = "宠物伤害敌人监测",
                                    desc = "如果勾选，插件将统计过去你秒内你的宠物或仆从攻击（或被攻击）的敌人。" ..
                                    "如果你的宠物或仆从分散在战场各处，统计的目标数可能会有误差。",
                                    width = 1.49,
                                    hidden = function () return self.DB.profile.specs[ id ].damage == false end,
                                    order = 5.1
                                },

                                damageRange = {
                                    type = "range",
                                    name = "过滤超出范围敌人",
                                    desc = "如果设置为大于0，插件将尝试过滤掉上次监测后，当前已经超出范围的目标。此项是基于缓存数据的，可能不够准确。",
                                    width = "full",
                                    hidden = function () return self.DB.profile.specs[ id ].damage == false end,
                                    min = 0,
                                    max = 100,
                                    step = 1,
                                    order = 5.2,
                                },

                                damageExpiration = {
                                    type = "range",
                                    name = "伤害监测有效时间",
                                    desc = "当勾选|cFFFFD100伤害敌人监测|r时，插件将在有效时间内持续标记受到伤害的敌人，直到他们被忽略或不再受到伤害。" ..
                                        "如果敌人死亡或消失，他们也会被忽略。此项在处理敌人分散或超出攻击范围时很有效。",
                                    width = "full",
                                    softMin = 3,
                                    min = 1,
                                    max = 10,
                                    step = 0.1,
                                    hidden = function() return self.DB.profile.specs[ id ].damage == false end,
                                    order = 5.3,
                                },

                                damageSpace = {
                                    type = "description",
                                    name = " ",
                                    width = "full",
                                    hidden = function() return self.DB.profile.specs[ id ].damage == false end,
                                    order = 7,
                                },

                                cycle = {
                                    type = "toggle",
                                    name = "推荐切换目标",
                                    desc = "当启用切换目标后，当你应该在不同的目标上使用某个技能是，插件会在技能图标上显示小图标(|TInterface\\Addons\\Hekili\\Textures\\Cycle:0|t)。" ..
                                        "此项对某些直接对另一个目标造成伤害的职业专精（如踏风）效果很好，但是对于" ..
                                        "某些需要保持对敌人持续伤害的职业专精（如痛苦）就效果稍差。此功能将在未来持续改进。",
                                    width = "full",
                                    order = 8
                                },

                                cycle_min = {
                                    type = "range",
                                    name = "最短死亡时间",
                                    desc = "当启用|cffffd100推荐切换目标|r后，此项将设置死亡时间小于此值的目标将不进行推荐。" ..
                                        "如果设置为5，插件将不推荐切换到将在5秒内死亡的目标。这将有助于避免对即将死亡的目标释放持续伤害技能。" ..
                                        "\n\n设置为0时将统计所有监测到的目标。",
                                    width = "full",
                                    min = 0,
                                    max = 15,
                                    step = 1,
                                    hidden = function() return not self.DB.profile.specs[ id ].cycle end,
                                    order = 9
                                },

                                aoe = {
                                    type = "range",
                                    name = "AOE显示框：最小目标数",
                                    desc = "当监测到满足该数量的目标数时，将启用AOE显示框进行技能推荐。",
                                    width = "full",
                                    min = 2,
                                    max = 10,
                                    step = 1,
                                    order = 10,
                                },
                            }
                        },

                        toggles = {
                            type = "group",
                            name = "开关",
                            desc = "设置快速开关部分具体控制哪些技能。",
                            order = 2,
                            args = {
                                toggleDesc = {
                                    type = "description",
                                    name = "此页对开关中定义的各项开关类型中包含的技能进行细节设置。装备和饰品可以通过它们自己的部分（左侧）进行调整。\n\n" ..
                                        "在开关中删除某个技能后，将使它|cFF00FF00启用|r，无论开关是否处于激活状态。",
                                    fontSize = "medium",
                                    order = 1,
                                    width = "full",
                                },
                            },
                            plugins = {
                                cooldowns = {},
                                essences = {},
                                defensives = {},
                                utility = {},
                                custom1 = {},
                                custom2 = {},
                            }
                        },

                        performance = {
                            type = "group",
                            name = NewFeature .. " 性能",
                            order = 10,
                            args = {
                                throttleRefresh = {
                                    type = "toggle",
                                    name = NewFeature .. " 调整刷新频率",
                                    desc = "默认情况下，插件将在|cffff0000关键|r战斗事件之后|cffffd1000.1秒|r，和常规战斗事件之后|cffffd1000.5|r秒内给出新的建议。\n" ..
                                        "如果勾选了|cffffd100调整刷新频率|r，你可以改变当前专精的|cffffd100战斗刷新频率|r和|cff00ff00常规刷新频率|r。",
                                    order = 1,
                                    width = "full",
                                },

                                perfSpace01 = {
                                    type = "description",
                                    name = " ",
                                    order = 1.05,
                                    width = "full"
                                },

                                regularRefresh = {
                                    type = "range",
                                    name = NewFeature .. " 常规刷新频率",
                                    desc = "在没有进入战斗时，插件将根据该处设置的时间间隔进行刷新。设置更高的频率能够降低CPU占用，但也会导致技能推荐的速度下降，" ..
                                        "不过进入战斗会强制插件更快的刷新。\n\n如果设置为|cffffd1001.0秒|r，插件将在1秒内将不会推荐新的技能（除非进入战斗）。\n\n" ..
                                        "默认值为：|cffffd1000.1秒|r。",
                                    order = 1.1,
                                    width = 1.5,
                                    min = 0.05,
                                    max = 1,
                                    step = 0.05,
                                    hidden = function () return self.DB.profile.specs[ id ].throttleRefresh == false end,
                                },

                                combatRefresh = {
                                    type = "range",
                                    name = NewFeature .. " 战斗刷新频率",
                                    desc = "当进入战斗后，插件将比常规刷新频率更加频繁地刷新推荐技能。设置更高的频率能够降低CPU占用，但也会导致技能推荐的速度下降，" ..
                                        "不过进入关键战斗会强制插件更快的刷新。\n\n如果设置为|cffffd1000.2秒|r，插件将在0.2秒内不会推荐新的技能（除非进入关键战斗）。\n\n" ..
                                        "默认值为：|cffffd1000.1秒|r。",
                                    order = 1.2,
                                    width = 1.5,
                                    min = 0.05,
                                    max = 0.5,
                                    step = 0.05,
                                    hidden = function () return self.DB.profile.specs[ id ].throttleRefresh == false end,
                                },

                                perfSpace = {
                                    type = "description",
                                    name = " ",
                                    order = 1.9,
                                    width = "full"
                                },

                                throttleTime = {
                                    type = "toggle",
                                    name = NewFeature .. " 调整刷新时间",
                                    desc = "默认情况下，当插件需要刷新推荐技能时，它将使用|cffffd10010毫秒|r到最多半帧的时间，以最低者为准。如果你拥有每秒60帧的游戏刷新率，那么则等于16.67毫秒。" ..
                                        "16.67毫秒的一半约等于|cffffd1008毫秒|r，因此插件在计算推荐技能时最多占用8毫秒。如果需要更多的时间，计算工作将分散在多个帧中。\n\n" ..
                                        "如果勾选了|cffffd100调整刷新时间|r，你可以设置插件每帧可以占用的|cffffd100最大计算时间|r。",
                                    order = 2,
                                    width = 1,
                                },

                                maxTime = {
                                    type = "range",
                                    name = NewFeature .. " 最大计算时间（毫秒）",
                                    desc = "设置插件在计算推荐技能时，可以在|cffffd100每帧|r占用的时间（以毫秒为单位）。\n\n" ..
                                        "如果设置为|cffffd10010|r，则不会影响刷新率为100帧的游戏（1秒/100帧=10毫秒）。\n" ..
                                        "如果设置为|cffffd10016|r，则不会影响刷新率为60帧的游戏（1秒/60帧=16.7毫秒）。\n\n" ..
                                        "如果你将该值设置的太低，插件可能会花费更多帧来计算推荐的技能，可能会使你感觉到延迟。" ..
                                        "如果设置的太高，插件在每帧会进行更多的计算，推荐技能更快，但可能会影响你的游戏刷新率。默认值为|cffffd10010毫秒|r。",
                                    order = 2.1,
                                    min = 2,
                                    max = 100,
                                    width = 2,
                                    hidden = function () return self.DB.profile.specs[ id ].throttleTime == false end,
                                },

                                throttleSpace = {
                                    type = "description",
                                    name = " ",
                                    order = 3,
                                    width = "full",
                                    hidden = function () return self.DB.profile.specs[ id ].throttleRefresh == false end,
                                },

                                --[[ gcdSync = {
                                    type = "toggle",
                                    name = "Start after Global Cooldown",
                                    desc = "If checked, the addon's first recommendation will be delayed to the start of the GCD in your Primary and AOE displays.  This can reduce flickering if trinkets or off-GCD abilities are appearing briefly during the global cooldown, " ..
                                        "but will cause abilities intended to be used while the GCD is active (i.e., Recklessness) to bounce backward in the queue.",
                                    width = "full",
                                    order = 4,
                                }, ]]

                                enhancedRecheck = {
                                    type = "toggle",
                                    name = "额外复检",
                                    desc = "当插件无法推荐某个技能时，则会在未来重新检查是否满足推荐条件。如果勾选，此项会在插件将对拥有变量的技能进行额外推荐检查。" ..
                                    "这可能会使用更多的CPU，但可以降低插件无法给出技能推荐的概率。",
                                    width = "full",
                                    order = 5,
                                }

                            }
                        }
                    },
                }

                local specCfg = class.specs[ id ] and class.specs[ id ].settings
                local specProf = self.DB.profile.specs[ id ]

                if #specCfg > 0 then
                    options.args.core.plugins.settings.prefSpacer = {
                        type = "description",
                        name = " ",
                        order = 100,
                        width = "full"
                    }

                    options.args.core.plugins.settings.prefHeader = {
                        type = "header",
                        name = "特殊选项",
                        order = 100.1,
                    }

                    for i, option in ipairs( specCfg ) do
                        if i > 1 and i % 2 == 1 then
                            -- Insert line break.
                            options.args.core.plugins.settings[ sName .. "LB" .. i ] = {
                                type = "description",
                                name = "",
                                width = "full",
                                order = option.info.order - 0.01
                            }
                        end

                        options.args.core.plugins.settings[ option.name ] = option.info
                        if self.DB.profile.specs[ id ].settings[ option.name ] == nil then
                            self.DB.profile.specs[ id ].settings[ option.name ] = option.default
                        end
                    end
                end

                -- Toggles
                BuildToggleList( options, id, "cooldowns",  "爆发", nil, {
                        -- Test Option for Separate Cooldowns
                        noFeignedCooldown = {
                            type = "toggle",
                            name = NewFeature .. "爆发：单独显示 - 使用真实冷却",
                            desc = "如果勾选，当启用单独的爆发技能显示窗体，且启用爆发时，插件|cFFFF0000不会|r假定你的爆发技能处于就绪状态。" ..
                                "这可能有助于解决爆发技能的冷却状态与实际不同步，而导致的推荐技能不准确的问题。" ..
                                "\n\n" ..
                                "需要开启|cFFFFD100快捷切换|r > |cFFFFD100爆发|r模块中的|cFFFFD100启用单独显示|r功能。",
                            order = 1.051,
                            width = "full",
                            disabled = function ()
                                return not self.DB.profile.toggles.cooldowns.separate
                            end,
                            set = function()
                                self.DB.profile.specs[ id ].noFeignedCooldown = not self.DB.profile.specs[ id ].noFeignedCooldown
                            end,
                            get = function()
                                return self.DB.profile.specs[ id ].noFeignedCooldown
                            end,
                        }
                 } )
                BuildToggleList( options, id, "essences",   "盟约" )
                BuildToggleList( options, id, "interrupts", "功能性/打断" )
                BuildToggleList( options, id, "defensives", "防御",   "防御开关通常用于坦克职业专精，" ..
                "在战斗中面对各种情况，你可能希望打开和关闭减伤技能的推荐。" ..
                "DPS玩家可能也希望增强自己的存活能力，可以将减伤技能添加到自己的自定义配置中。" ..
                                                                            "" ..
                                                                            "" )
                BuildToggleList( options, id, "custom1", function ()
                    return specProf.custom1Name or "自定义1"
                end )
                BuildToggleList( options, id, "custom2", function ()
                    return specProf.custom2Name or "自定义2"
                end )

                db.plugins.specializations[ sName ] = options
            end

            i = i + 1
        end

    end


    local packControl = {
        listName = "default",
        actionID = "0001",

        makingNew = false,
        newListName = nil,

        showModifiers = false,

        newPackName = "",
        newPackSpec = "",
    }


    local nameMap = {
        call_action_list = "list_name",
        run_action_list = "list_name",
        potion = "potion",
        variable = "var_name",
        op = "op"
    }


    local defaultNames = {
        list_name = "default",
        potion = "prolonged_power",
        var_name = "unnamed_var",
    }


    local toggleToNumber = {
        cycle_targets = true,
        for_next = true,
        max_energy = true,
        strict = true,
        use_off_gcd = true,
        use_while_casting = true,
    }


    local function GetListEntry( pack )
        local entry = rawget( Hekili.DB.profile.packs, pack )

        if rawget( entry.lists, packControl.listName ) == nil then
            packControl.listName = "default"
        end

        if entry then entry = entry.lists[ packControl.listName ] else return end

        if rawget( entry, tonumber( packControl.actionID ) ) == nil then
            packControl.actionID = "0001"
        end

        local listPos = tonumber( packControl.actionID )
        if entry and listPos > 0 then entry = entry[ listPos ] else return end

        return entry
    end


    function Hekili:GetActionOption( info )
        local n = #info
        local pack, option = info[ 2 ], info[ n ]

        if rawget( self.DB.profile.packs[ pack ].lists, packControl.listName ) == nil then
            packControl.listName = "default"
        end

        local actionID = tonumber( packControl.actionID )
        local data = self.DB.profile.packs[ pack ].lists[ packControl.listName ]

        if option == 'position' then return actionID
        elseif option == 'newListName' then return packControl.newListName end

        if not data then return end

        if not data[ actionID ] then
            actionID = 1
            packControl.actionID = "0001"
        end
        data = data[ actionID ]

        if option == "inputName" or option == "selectName" then
            option = nameMap[ data.action ]
            if not data[ option ] then data[ option ] = defaultNames[ option ] end
        end

        if option == "op" and not data.op then return "set" end

        if option == "potion" then
            if not data.potion then return "default" end
            if not class.potionList[ data.potion ] then
                return class.potions[ data.potion ] and class.potions[ data.potion ].key or data.potion
            end
        end

        if toggleToNumber[ option ] then return data[ option ] == 1 end
        return data[ option ]
    end


    function Hekili:SetActionOption( info, val )
        local n = #info
        local pack, option = info[ 2 ], info[ n ]

        local actionID = tonumber( packControl.actionID )
        local data = self.DB.profile.packs[ pack ].lists[ packControl.listName ]

        if option == 'newListName' then
            packControl.newListName = val:trim()
            return
        end

        if not data then return end
        data = data[ actionID ]

        if option == "inputName" or option == "selectName" then option = nameMap[ data.action ] end

        if toggleToNumber[ option ] then val = val and 1 or 0 end
        if type( val ) == 'string' then val = val:trim() end

        data[ option ] = val

        if option == "enable_moving" and not val then
            data.moving = nil
        end

        if option == "line_cd" and not val then
            data.line_cd = nil
        end

        if option == "use_off_gcd" and not val then
            data.use_off_gcd = nil
        end

        if option == "strict" and not val then
            data.strict = nil
        end

        if option == "use_while_casting" and not val then
            data.use_while_casting = nil
        end

        if option == "action" then
            self:LoadScripts()
        else
            self:LoadScript( pack, packControl.listName, actionID )
        end

        if option == "enabled" then
            Hekili:UpdateDisplayVisibility()
        end
    end


    function Hekili:GetPackOption( info )
        local n = #info
        local category, subcat, option = info[ 2 ], info[ 3 ], info[ n ]

        if rawget( self.DB.profile.packs, category ) and rawget( self.DB.profile.packs[ category ].lists, packControl.listName ) == nil then
            packControl.listName = "default"
        end

        if option == "newPackSpec" and packControl[ option ] == "" then
            packControl[ option ] = GetCurrentSpec()
        end

        if packControl[ option ] ~= nil then return packControl[ option ] end

        if subcat == 'lists' then return self:GetActionOption( info ) end

        local data = rawget( self.DB.profile.packs, category )
        if not data then return end

        if option == 'date' then return tostring( data.date ) end

        return data[ option ]
    end


    function Hekili:SetPackOption( info, val )
        local n = #info
        local category, subcat, option = info[ 2 ], info[ 3 ], info[ n ]

        if packControl[ option ] ~= nil then
            packControl[ option ] = val
            if option == "listName" then packControl.actionID = "0001" end
            return
        end

        if subcat == 'lists' then return self:SetActionOption( info, val ) end
        -- if subcat == 'newActionGroup' or ( subcat == 'actionGroup' and subtype == 'entry' ) then self:SetActionOption( info, val ); return end

        local data = rawget( self.DB.profile.packs, category )
        if not data then return end

        if type( val ) == 'string' then val = val:trim() end

        if option == "desc" then
            -- Auto-strip comments prefix
            val = val:gsub( "^#+ ", "" )
            val = val:gsub( "\n#+ ", "\n" )
        end

        data[ option ] = val
    end


    function Hekili:EmbedPackOptions( db )
        db = db or self.Options
        if not db then return end

        local packs = db.args.packs or {
            type = "group",
            name = "优先级配置",
            desc = "优先级配置（或指令集）是一组操作列表，基于每个职业专精提供技能推荐。",
            get = 'GetPackOption',
            set = 'SetPackOption',
            order = 65,
            childGroups = 'tree',
            args = {
                packDesc = {
                    type = "description",
                    name = "优先级配置（或指令集）是一组操作列表，基于每个职业专精提供技能推荐。" ..
                    "它们可以自定义和共享。|cFFFF0000导入SimulationCraft优先级通常需要在导入之前进行一些转换，" ..
                    "才能够应用于插件。不支持导入和自定义已过期的优先级配置。|r",
                    order = 1,
                    fontSize = "medium",
                },

                newPackHeader = {
                    type = "header",
                    name = "创建新的配置",
                    order = 200
                },

                newPackName = {
                    type = "input",
                    name = "配置名称",
                    desc = "输入唯一的配置名称。允许使用字母、数字、空格、下划线和撇号。（译者加入了中文支持）",
                    order = 201,
                    width = "full",
                    validate = function( info, val )
                        val = val:trim()
                        if rawget( Hekili.DB.profile.packs, val ) then return "请确保配置名称唯一。"
                        elseif val == "UseItems" then return "UseItems是系统保留名称。"
                        elseif val == "(none)" then return "别耍小聪明，你这愚蠢的土拨鼠。"
                        elseif val:find( "[^a-zA-Z0-9 _'()一-龥]" ) then return "配置名称允许使用字母、数字、空格、下划线和撇号。（译者加入了中文支持）" end
                        return true
                    end,
                },

                newPackSpec = {
                    type = "select",
                    name = "职业专精",
                    order = 202,
                    width = "full",
                    values = specs,
                },

                createNewPack = {
                    type = "execute",
                    name = "创建新配置",
                    order = 203,
                    disabled = function()
                        return packControl.newPackName == "" or packControl.newPackSpec == ""
                    end,
                    func = function ()
                        Hekili.DB.profile.packs[ packControl.newPackName ].spec = packControl.newPackSpec
                        Hekili:EmbedPackOptions()
                        ACD:SelectGroup( "Hekili", "packs", packControl.newPackName )
                        packControl.newPackName = ""
                        packControl.newPackSpec = ""
                    end,
                },

                shareHeader = {
                    type = "header",
                    name = "分享",
                    order = 100,
                },

                shareBtn = {
                    type = "execute",
                    name = "分享优先级配置",
                    desc = "每个优先级配置都可以使用导出字符串分享给其他本插件用户。\n\n" ..
                    "你也可以在这里导入他人分享的字符串。",
                    func = function ()
                        ACD:SelectGroup( "Hekili", "packs", "sharePacks" )
                    end,
                    order = 101,
                },

                sharePacks = {
                    type = "group",
                    name = "|cFF1EFF00分享优先级配置|r",
                    desc = "你的优先级配置可以通过导出字符串分享给其他本插件用户。\n\n" ..
                    "你也可以在这里导入他人分享的字符串。",
                    childGroups = "tab",
                    get = 'GetPackShareOption',
                    set = 'SetPackShareOption',
                    order = 1001,
                    args = {
                        import = {
                            type = "group",
                            name = "导入",
                            order = 1,
                            args = {
                                stage0 = {
                                    type = "group",
                                    name = "",
                                    inline = true,
                                    order = 1,
                                    args = {
                                        guide = {
                                            type = "description",
                                            name = "先将优先级配置的字符串粘贴到这里。",
                                            order = 1,
                                            width = "full",
                                            fontSize = "medium",
                                        },

                                        separator = {
                                            type = "header",
                                            name = "导入字符串",
                                            order = 1.5,
                                        },

                                        importString = {
                                            type = "input",
                                            name = "导入字符串",
                                            get = function () return shareDB.import end,
                                            set = function( info, val )
                                                val = val:trim()
                                                shareDB.import = val
                                            end,
                                            order = 3,
                                            multiline = 5,
                                            width = "full",
                                        },

                                        btnSeparator = {
                                            type = "header",
                                            name = "导入",
                                            order = 4,
                                        },

                                        importBtn = {
                                            type = "execute",
                                            name = "导入优先级配置",
                                            order = 5,
                                            func = function ()
                                                shareDB.imported, shareDB.error = self:DeserializeActionPack( shareDB.import )

                                                if shareDB.error then
                                                    shareDB.import = "无法解析当前的导入字符串。\n" .. shareDB.error
                                                    shareDB.error = nil
                                                    shareDB.imported = {}
                                                else
                                                    shareDB.importStage = 1
                                                end
                                            end,
                                            disabled = function ()
                                                return shareDB.import == ""
                                            end,
                                        },
                                    },
                                    hidden = function () return shareDB.importStage ~= 0 end,
                                },

                                stage1 = {
                                    type = "group",
                                    inline = true,
                                    name = "",
                                    order = 1,
                                    args = {
                                        packName = {
                                            type = "input",
                                            order = 1,
                                            name = "配置名称",
                                            get = function () return shareDB.imported.name end,
                                            set = function ( info, val ) shareDB.imported.name = val:trim() end,
                                            width = "full",
                                        },

                                        packDate = {
                                            type = "input",
                                            order = 2,
                                            name = "生成日期",
                                            get = function () return tostring( shareDB.imported.date ) end,
                                            set = function () end,
                                            width = "full",
                                            disabled = true,
                                        },

                                        packSpec = {
                                            type = "input",
                                            order = 3,
                                            name = "配置职业专精",
                                            get = function () return select( 2, GetSpecializationInfoByID( shareDB.imported.payload.spec or 0 ) ) or "无需对应职业专精" end,
                                            set = function () end,
                                            width = "full",
                                            disabled = true,
                                        },

                                        guide = {
                                            type = "description",
                                            name = function ()
                                                local listNames = {}

                                                for k, v in pairs( shareDB.imported.payload.lists ) do
                                                    insert( listNames, k )
                                                end

                                                table.sort( listNames )

                                                local o

                                                if #listNames == 0 then
                                                    o = "导入的优先级配置不包含任何技能列表。"
                                                elseif #listNames == 1 then
                                                    o = "导入的优先级配置含有一个技能列表：" .. listNames[1] .. "。"
                                                elseif #listNames == 2 then
                                                    o = "导入的优先级配置包含两个技能列表：" .. listNames[1] .. " 和 " .. listNames[2] .. "。"
                                                else
                                                    o = "导入的优先级配置包含以下技能列表："
                                                    for i, name in ipairs( listNames ) do
                                                        if i == 1 then o = o .. name
                                                        elseif i == #listNames then o = o .. "，和" .. name .. "。"
                                                        else o = o .. ", " .. name end
                                                    end
                                                end

                                                return o
                                            end,
                                            order = 4,
                                            width = "full",
                                            fontSize = "medium",
                                        },

                                        separator = {
                                            type = "header",
                                            name = "应用更改",
                                            order = 10,
                                        },

                                        apply = {
                                            type = "execute",
                                            name = "应用更改",
                                            order = 11,
                                            confirm = function ()
                                                if rawget( self.DB.profile.packs, shareDB.imported.name ) then
                                                    return "你已经拥有名为“" .. shareDB.imported.name .. "”的优先级配置。\n覆盖它吗？"
                                                end
                                                return "确定从导入的数据创建名为“" .. shareDB.imported.name .. "”的优先级配置吗？"
                                            end,
                                            func = function ()
                                                self.DB.profile.packs[ shareDB.imported.name ] = shareDB.imported.payload
                                                shareDB.imported.payload.date = shareDB.imported.date
                                                shareDB.imported.payload.version = shareDB.imported.date

                                                shareDB.import = ""
                                                shareDB.imported = {}
                                                shareDB.importStage = 2

                                                self:LoadScripts()
                                                self:EmbedPackOptions()
                                            end,
                                        },

                                        reset = {
                                            type = "execute",
                                            name = "重置",
                                            order = 12,
                                            func = function ()
                                                shareDB.import = ""
                                                shareDB.imported = {}
                                                shareDB.importStage = 0
                                            end,
                                        },
                                    },
                                    hidden = function () return shareDB.importStage ~= 1 end,
                                },

                                stage2 = {
                                    type = "group",
                                    inline = true,
                                    name = "",
                                    order = 3,
                                    args = {
                                        note = {
                                            type = "description",
                                            name = "导入的设置已经成功应用！\n\n如果有必要，点击重置重新开始。",
                                            order = 1,
                                            fontSize = "medium",
                                            width = "full",
                                        },

                                        reset = {
                                            type = "execute",
                                            name = "重置",
                                            order = 2,
                                            func = function ()
                                                shareDB.import = ""
                                                shareDB.imported = {}
                                                shareDB.importStage = 0
                                            end,
                                        }
                                    },
                                    hidden = function () return shareDB.importStage ~= 2 end,
                                }
                            },
                            plugins = {
                            }
                        },

                        export = {
                            type = "group",
                            name = "导出",
                            order = 2,
                            args = {
                                guide = {
                                    type = "description",
                                    name = "请选择要导出的优先级配置。",
                                    order = 1,
                                    fontSize = "medium",
                                    width = "full",
                                },

                                actionPack = {
                                    type = "select",
                                    name = "优先级配置",
                                    order = 2,
                                    values = function ()
                                        local v = {}

                                        for k, pack in pairs( Hekili.DB.profile.packs ) do
                                            if pack.spec and class.specs[ pack.spec ] then
                                                v[ k ] = k
                                            end
                                        end

                                        return v
                                    end,
                                    width = "full"
                                },

                                exportString = {
                                    type = "input",
                                    name = "导出优先级配置字符串（CTRL+A全选，CTRL+C复制）",
                                    order = 3,
                                    get = function ()
                                        if rawget( Hekili.DB.profile.packs, shareDB.actionPack ) then
                                            shareDB.export = self:SerializeActionPack( shareDB.actionPack )
                                        else
                                            shareDB.export = ""
                                        end
                                        return shareDB.export
                                    end,
                                    set = function () end,
                                    width = "full",
                                    hidden = function () return shareDB.export == "" end,
                                },
                            },
                        }
                    }
                },
            },
            plugins = {
                packages = {},
                links = {},
            }
        }

        wipe( packs.plugins.packages )
        wipe( packs.plugins.links )

        local count = 0

        for pack, data in orderedPairs( self.DB.profile.packs ) do
            if data.spec and class.specs[ data.spec ] and not data.hidden then
                packs.plugins.links.packButtons = packs.plugins.links.packButtons or {
                    type = "header",
                    name = "已安装的配置",
                    order = 10,
                }

                packs.plugins.links[ "btn" .. pack ] = {
                    type = "execute",
                    name = pack,
                    order = 11 + count,
                    func = function ()
                        ACD:SelectGroup( "Hekili", "packs", pack )
                    end,
                }

                local opts = packs.plugins.packages[ pack ] or {
                    type = "group",
                    name = function ()
                        local p = rawget( Hekili.DB.profile.packs, pack )
                        if p.builtIn then return '|cFF00B4FF' .. pack .. '|r' end
                        return pack
                    end,
                    childGroups = "tab",
                    order = 100 + count,
                    args = {
                        pack = {
                            type = "group",
                            name = data.builtIn and ( BlizzBlue .. "摘要|r" ) or "摘要",
                            order = 1,
                            args = {
                                isBuiltIn = {
                                    type = "description",
                                    name = function ()
                                        return BlizzBlue .. "这是个默认的优先级配置。当插件更新时，它将会自动更新。" ..
                                        "如果想要自定义调整技能优先级，请点击|TInterface\\Addons\\Hekili\\Textures\\WhiteCopy:0|t创建一个副本后操作|r。"
                                    end,
                                    fontSize = "medium",
                                    width = 3,
                                    order = 0.1,
                                    hidden = not data.builtIn
                                },

                                lb01 = {
                                    type = "description",
                                    name = "",
                                    order = 0.11,
                                    hidden = not data.builtIn
                                },

                                toggleActive = {
                                    type = "toggle",
                                    name = function ()
                                        local p = rawget( Hekili.DB.profile.packs, pack )
                                        if p and p.builtIn then return BlizzBlue .. "激活|r" end
                                        return "激活"
                                    end,
                                    desc = "如果勾选，插件将会在职业专精对应时使用该优先级配置进行技能推荐。",
                                    order = 0.2,
                                    width = 3,
                                    get = function ()
                                        local p = rawget( Hekili.DB.profile.packs, pack )
                                        return Hekili.DB.profile.specs[ p.spec ].package == pack
                                    end,
                                    set = function ()
                                        local p = rawget( Hekili.DB.profile.packs, pack )
                                        if Hekili.DB.profile.specs[ p.spec ].package == pack then
                                            if p.builtIn then
                                                Hekili.DB.profile.specs[ p.spec ].package = "(none)"
                                            else
                                                for def, data in pairs( Hekili.DB.profile.packs ) do
                                                    if data.spec == p.spec and data.builtIn then
                                                        Hekili.DB.profile.specs[ p.spec ].package = def
                                                        return
                                                    end
                                                end
                                            end
                                        else
                                            Hekili.DB.profile.specs[ p.spec ].package = pack
                                        end
                                    end,
                                },

                                lb04 = {
                                    type = "description",
                                    name = "",
                                    order = 0.21,
                                    width = "full"
                                },

                                packName = {
                                    type = "input",
                                    name = "配置名称",
                                    order = 0.25,
                                    width = 2.7,
                                    validate = function( info, val )
                                        val = val:trim()
                                        if rawget( Hekili.DB.profile.packs, val ) then return "请确保配置名称唯一。"
                                        elseif val == "UseItems" then return "UseItems是系统保留名称。"
                                        elseif val == "(none)" then return "别耍小聪明，你这愚蠢的土拨鼠。"
                                        elseif val:find( "[^a-zA-Z0-9 _'()一-龥]" ) then return "配置名称允许使用字母、数字、空格、下划线和撇号。（译者加入了中文支持）" end
                                        return true
                                    end,
                                    get = function() return pack end,
                                    set = function( info, val )
                                        local profile = Hekili.DB.profile

                                        local p = rawget( Hekili.DB.profile.packs, pack )
                                        Hekili.DB.profile.packs[ pack ] = nil

                                        val = val:trim()
                                        Hekili.DB.profile.packs[ val ] = p

                                        for _, spec in pairs( Hekili.DB.profile.specs ) do
                                            if spec.package == pack then spec.package = val end
                                        end

                                        Hekili:EmbedPackOptions()
                                        Hekili:LoadScripts()
                                        ACD:SelectGroup( "Hekili", "packs", val )
                                    end,
                                    disabled = data.builtIn
                                },

                                copyPack = {
                                    type = "execute",
                                    name = "",
                                    desc = "拷贝配置",
                                    order = 0.26,
                                    width = 0.15,
                                    image = [[Interface\AddOns\Hekili\Textures\WhiteCopy]],
                                    imageHeight = 20,
                                    imageWidth = 20,
                                    confirm = function () return "确定创建此优先级配置的副本吗？" end,
                                    func = function ()
                                        local p = rawget( Hekili.DB.profile.packs, pack )

                                        local newPack = tableCopy( p )
                                        newPack.builtIn = false
                                        newPack.basedOn = pack

                                        local newPackName, num = pack:match("^(.+) %((%d+)%)$")

                                        if not num then
                                            newPackName = pack
                                            num = 1
                                        end

                                        num = num + 1
                                        while( rawget( Hekili.DB.profile.packs, newPackName .. " (" .. num .. ")" ) ) do
                                            num = num + 1
                                        end
                                        newPackName = newPackName .. " (" .. num ..")"

                                        Hekili.DB.profile.packs[ newPackName ] = newPack
                                        Hekili:EmbedPackOptions()
                                        Hekili:LoadScripts()
                                        ACD:SelectGroup( "Hekili", "packs", newPackName )
                                    end
                                },

                                reloadPack = {
                                    type = "execute",
                                    name = "",
                                    desc = "重载配置",
                                    order = 0.27,
                                    width = 0.15,
                                    image = GetAtlasFile( "transmog-icon-revert" ),
                                    imageCoords = GetAtlasCoords( "transmog-icon-revert" ),
                                    imageWidth = 25,
                                    imageHeight = 24,
                                    confirm = function ()
                                        return "确定从默认值重载此优先级配置吗？"
                                    end,
                                    hidden = not data.builtIn,
                                    func = function ()
                                        Hekili.DB.profile.packs[ pack ] = nil
                                        Hekili:RestoreDefault( pack )
                                        Hekili:EmbedPackOptions()
                                        Hekili:LoadScripts()
                                        ACD:SelectGroup( "Hekili", "packs", pack )
                                    end
                                },

                                deletePack = {
                                    type = "execute",
                                    name = "",
                                    desc = "删除配置",
                                    order = 0.27,
                                    width = 0.15,
                                    image = GetAtlasFile( "communities-icon-redx" ),
                                    imageCoords = GetAtlasCoords( "communities-icon-redx" ),
                                    imageHeight = 24,
                                    imageWidth = 24,
                                    confirm = function () return "确定删除此优先级配置吗？" end,
                                    func = function ()
                                        local defPack

                                        local specId = data.spec
                                        local spec = specId and Hekili.DB.profile.specs[ specId ]

                                        if specId then
                                            for pId, pData in pairs( Hekili.DB.profile.packs ) do
                                                if pData.builtIn and pData.spec == specId then
                                                    defPack = pId
                                                    if spec.package == pack then spec.package = pId; break end
                                                end
                                            end
                                        end

                                        Hekili.DB.profile.packs[ pack ] = nil
                                        Hekili.Options.args.packs.plugins.packages[ pack ] = nil

                                        -- Hekili:EmbedPackOptions()
                                        ACD:SelectGroup( "Hekili", "packs" )
                                    end,
                                    hidden = data.builtIn
                                },

                                lb02 = {
                                    type = "description",
                                    name = "",
                                    order = 0.3,
                                    width = "full",
                                },

                                spec = {
                                    type = "select",
                                    name = "对应职业专精",
                                    order = 1,
                                    width = 3,
                                    values = specs,
                                    disabled = data.builtIn and not Hekili.Version:sub(1, 3) == "Dev"
                                },

                                lb03 = {
                                    type = "description",
                                    name = "",
                                    order = 1.01,
                                    width = "full",
                                    hidden = data.builtIn
                                },

                                --[[ applyPack = {
                                    type = "execute",
                                    name = "Use Priority",
                                    order = 1.5,
                                    width = 1,
                                    func = function ()
                                        local p = rawget( Hekili.DB.profile.packs, pack )
                                        Hekili.DB.profile.specs[ p.spec ].package = pack
                                    end,
                                    hidden = function ()
                                        local p = rawget( Hekili.DB.profile.packs, pack )
                                        return Hekili.DB.profile.specs[ p.spec ].package == pack
                                    end,
                                }, ]]

                                desc = {
                                    type = "input",
                                    name = "说明",
                                    multiline = 15,
                                    order = 2,
                                    width = "full",
                                },
                            }
                        },

                        profile = {
                            type = "group",
                            name = "文件",
                            desc = "如果此优先级配置是通过SimulationCraft配置文件生成的，则可以在这里保存和查看该配置文件。" ..
                            "还可以重新导入该配置文件，或使用较新的文件覆盖旧的文件。",
                            order = 2,
                            args = {
                                signature = {
                                    type = "group",
                                    inline = true,
                                    name = "",
                                    order = 3,
                                    args = {
                                        source = {
                                            type = "input",
                                            name = "来源",
                                            desc = "如果优先级配置基于SimulationCraft文件或职业指南，" ..
                                            "最好提供来源的链接（尤其是分享之前）。",
                                            order = 1,
                                            width = 3,
                                        },

                                        break1 = {
                                            type = "description",
                                            name = "",
                                            width = "full",
                                            order = 1.1,
                                        },

                                        author = {
                                            type = "input",
                                            name = "作者",
                                            desc = "创建新的优先级配置时，作业信息将自动填写。" ..
                                            "你可以在这里修改作者信息。",
                                            order = 2,
                                            width = 2,
                                        },

                                        date = {
                                            type = "input",
                                            name = "最后更新",
                                            desc = "调整此优先级配置的技能列表时，此日期将自动更新。",
                                            width = 1,
                                            order = 3,
                                            set = function () end,
                                            get = function ()
                                                local d = data.date or 0

                                                if type(d) == "string" then return d end
                                                return format( "%.4f", d )
                                            end,
                                        },
                                    },
                                },

                                profile = {
                                    type = "input",
                                    name = "文件",
                                    desc = "如果此优先级配置的技能列表是来自于SimulationCraft文件的，那么该文件就在这里。",
                                    order = 4,
                                    multiline = 20,
                                    width = "full",
                                },

                                warnings = {
                                    type = "description",
                                    name = function ()
                                        local p = rawget( Hekili.DB.profile.packs, pack )
                                        return "|cFFFFD100导入记录|r\n" .. ( p.warnings or "" ) .. "\n\n"
                                    end,
                                    order = 5,
                                    fontSize = "medium",
                                    width = "full",
                                    hidden = function ()
                                        local p = rawget( Hekili.DB.profile.packs, pack )
                                        return not p.warnings or p.warnings == ""
                                    end,
                                },

                                reimport = {
                                    type = "execute",
                                    name = "导入",
                                    desc = "从文件信息中重建技能列表。",
                                    order = 5,
                                    func = function ()
                                        local p = rawget( Hekili.DB.profile.packs, pack )
                                        local profile = p.profile:gsub( '"', '' )

                                        local result, warnings = Hekili:ImportSimcAPL( nil, nil, profile )

                                        wipe( p.lists )

                                        for k, v in pairs( result ) do
                                            p.lists[ k ] = v
                                        end

                                        p.warnings = warnings
                                        p.date = tonumber( date("%Y%m%d.%H%M%S") )

                                        if not p.lists[ packControl.listName ] then packControl.listName = "default" end

                                        local id = tonumber( packControl.actionID )
                                        if not p.lists[ packControl.listName ][ id ] then packControl.actionID = "zzzzzzzzzz" end

                                        self:LoadScripts()
                                    end,
                                },
                            }
                        },

                        lists = {
                            type = "group",
                            childGroups = "select",
                            name = "技能列表",
                            desc = "技能列表用于确定在合适的时机推荐使用正确的技能。",
                            order = 3,
                            args = {
                                listName = {
                                    type = "select",
                                    name = "技能列表",
                                    desc = "选择要查看或修改的技能列表。",
                                    order = 1,
                                    width = 2.7,
                                    values = function ()
                                        local v = {
                                            -- ["zzzzzzzzzz"] = "|cFF00FF00Add New Action List|r"
                                        }

                                        local p = rawget( Hekili.DB.profile.packs, pack )

                                        for k in pairs( p.lists ) do
                                            local err = false

                                            if Hekili.Scripts and Hekili.Scripts.DB then
                                                local scriptHead = "^" .. pack .. ":" .. k .. ":"
                                                for k, v in pairs( Hekili.Scripts.DB ) do
                                                    if k:match( scriptHead ) and v.Error then err = true; break end
                                                end
                                            end

                                            if err then
                                                v[ k ] = "|cFFFF0000" .. k .. "|r"
                                            elseif k == 'precombat' or k == 'default' then
                                                v[ k ] = "|cFF00B4FF" .. k .. "|r"
                                            else
                                                v[ k ] = k
                                            end
                                        end

                                        return v
                                    end,
                                },

                                newListBtn = {
                                    type = "execute",
                                    name = "",
                                    desc = "创建新的技能列表",
                                    order = 1.1,
                                    width = 0.15,
                                    image = "Interface\\AddOns\\Hekili\\Textures\\GreenPlus",
                                    -- image = GetAtlasFile( "communities-icon-addgroupplus" ),
                                    -- imageCoords = GetAtlasCoords( "communities-icon-addgroupplus" ),
                                    imageHeight = 20,
                                    imageWidth = 20,
                                    func = function ()
                                        packControl.makingNew = true
                                    end,
                                },

                                delListBtn = {
                                    type = "execute",
                                    name = "",
                                    desc = "删除当前技能列表",
                                    order = 1.2,
                                    width = 0.15,
                                    image = RedX,
                                    -- image = GetAtlasFile( "communities-icon-redx" ),
                                    -- imageCoords = GetAtlasCoords( "communities-icon-redx" ),
                                    imageHeight = 20,
                                    imageWidth = 20,
                                    confirm = function() return "确定删除这个技能列表吗？" end,
                                    disabled = function () return packControl.listName == "default" or packControl.listName == "precombat" end,
                                    func = function ()
                                        local p = rawget( Hekili.DB.profile.packs, pack )
                                        p.lists[ packControl.listName ] = nil
                                        Hekili:LoadScripts()
                                        packControl.listName = "default"
                                    end,
                                },

                                lineBreak = {
                                    type = "description",
                                    name = "",
                                    width = "full",
                                    order = 1.9
                                },

                                actionID = {
                                    type = "select",
                                    name = "项目",
                                    desc = "在此技能列表中选择要修改的项目。\n\n" ..
                                    "红色项目表示被禁用、没有技能列表、条件错误或执行指令被禁用/忽略的技能。",
                                    order = 2,
                                    width = 2.4,
                                    values = function ()
                                        local v = {}

                                        local data = rawget( Hekili.DB.profile.packs, pack )
                                        local list = rawget( data.lists, packControl.listName )

                                        if list then
                                            local last = 0

                                            for i, entry in ipairs( list ) do
                                                local key = format( "%04d", i )
                                                local action = entry.action
                                                local desc

                                                local warning, color = false

                                                if not action then
                                                    action = "Unassigned"
                                                    warning = true
                                                else
                                                    if not class.abilities[ action ] then warning = true
                                                    else
                                                        if state:IsDisabled( action, true ) then warning = true end
                                                        action = class.abilityList[ action ] and class.abilityList[ action ]:match( "|t (.+)$" ) or class.abilities[ action ] and class.abilities[ action ].name or action
                                                    end
                                                end

                                                local scriptID = pack .. ":" .. packControl.listName .. ":" .. i
                                                local script = Hekili.Scripts.DB[ scriptID ]

                                                if script and script.Error then warning = true end

                                                local cLen = entry.criteria and entry.criteria:len()

                                                if entry.caption and entry.caption:len() > 0 then
                                                    desc = entry.caption

                                                elseif entry.action == "variable" then
                                                    if entry.op == "reset" then
                                                        desc = format( "reset |cff00ccff%s|r", entry.var_name or "unassigned" )
                                                    elseif entry.op == "default" then
                                                        desc = format( "|cff00ccff%s|r default = |cffffd100%s|r", entry.var_name or "unassigned", entry.value or "0" )
                                                    elseif entry.op == "set" or entry.op == "setif" then
                                                        desc = format( "set |cff00ccff%s|r = |cffffd100%s|r", entry.var_name or "unassigned", entry.value or "nothing" )
                                                    else
                                                        desc = format( "%s |cff00ccff%s|r (|cffffd100%s|r)", entry.op or "set", entry.var_name or "unassigned", entry.value or "nothing" )
                                                    end

                                                    if cLen and cLen > 0 then
                                                        desc = format( "%s, if |cffffd100%s|r", desc, entry.criteria )
                                                    end

                                                elseif entry.action == "call_action_list" or entry.action == "run_action_list" then
                                                    if not entry.list_name or not rawget( data.lists, entry.list_name ) then
                                                        desc = "|cff00ccff（无设置）|r"
                                                        warning = true
                                                    else
                                                        desc = "|cff00ccff" .. entry.list_name .. "|r"
                                                    end

                                                    if cLen and cLen > 0 then
                                                        desc = desc .. ", if |cffffd100" .. entry.criteria .. "|r"
                                                    end

                                                elseif cLen and cLen > 0 then
                                                    desc = "|cffffd100" .. entry.criteria .. "|r"

                                                end

                                                if not entry.enabled then
                                                    warning = true
                                                    color = "|cFF808080"
                                                end

                                                if desc then desc = desc:gsub( "[\r\n]", "" ) end

                                                if not color then
                                                    color = warning and "|cFFFF0000" or "|cFFFFD100"
                                                end

                                                if desc then
                                                    v[ key ] = color .. i .. ".|r " .. action .. " - " .. "|cFFFFD100" .. desc .. "|r"
                                                else
                                                    v[ key ] = color .. i .. ".|r " .. action
                                                end

                                                last = i + 1
                                            end
                                        end

                                        return v
                                    end,
                                    hidden = function ()
                                        return packControl.makingNew == true
                                    end,
                                },

                                moveUpBtn = {
                                    type = "execute",
                                    name = "",
                                    image = "Interface\\AddOns\\Hekili\\Textures\\WhiteUp",
                                    -- image = GetAtlasFile( "hud-MainMenuBar-arrowup-up" ),
                                    -- imageCoords = GetAtlasCoords( "hud-MainMenuBar-arrowup-up" ),
                                    imageHeight = 20,
                                    imageWidth = 20,
                                    width = 0.15,
                                    order = 2.1,
                                    func = function( info )
                                        local p = rawget( Hekili.DB.profile.packs, pack )
                                        local data = p.lists[ packControl.listName ]
                                        local actionID = tonumber( packControl.actionID )

                                        local a = remove( data, actionID )
                                        insert( data, actionID - 1, a )
                                        packControl.actionID = format( "%04d", actionID - 1 )

                                        local listName = format( "%s:%s:", pack, packControl.listName )
                                        scripts:SwapScripts( listName .. actionID, listName .. ( actionID - 1 ) )
                                    end,
                                    disabled = function ()
                                        return tonumber( packControl.actionID ) == 1
                                    end,
                                    hidden = function () return packControl.makingNew end,
                                },

                                moveDownBtn = {
                                    type = "execute",
                                    name = "",
                                    image = "Interface\\AddOns\\Hekili\\Textures\\WhiteDown",
                                    -- image = GetAtlasFile( "hud-MainMenuBar-arrowdown-up" ),
                                    -- imageCoords = GetAtlasCoords( "hud-MainMenuBar-arrowdown-up" ),
                                    imageHeight = 20,
                                    imageWidth = 20,
                                    width = 0.15,
                                    order = 2.2,
                                    func = function ()
                                        local p = rawget( Hekili.DB.profile.packs, pack )
                                        local data = p.lists[ packControl.listName ]
                                        local actionID = tonumber( packControl.actionID )

                                        local a = remove( data, actionID )
                                        insert( data, actionID + 1, a )
                                        packControl.actionID = format( "%04d", actionID + 1 )

                                        local listName = format( "%s:%s:", pack, packControl.listName )
                                        scripts:SwapScripts( listName .. actionID, listName .. ( actionID + 1 ) )
                                    end,
                                    disabled = function()
                                        local p = rawget( Hekili.DB.profile.packs, pack )
                                        return not p.lists[ packControl.listName ] or tonumber( packControl.actionID ) == #p.lists[ packControl.listName ]
                                    end,
                                    hidden = function () return packControl.makingNew end,
                                },

                                newActionBtn = {
                                    type = "execute",
                                    name = "",
                                    image = "Interface\\AddOns\\Hekili\\Textures\\GreenPlus",
                                    -- image = GetAtlasFile( "communities-icon-addgroupplus" ),
                                    -- imageCoords = GetAtlasCoords( "communities-icon-addgroupplus" ),
                                    imageHeight = 20,
                                    imageWidth = 20,
                                    width = 0.15,
                                    order = 2.3,
                                    func = function()
                                        local data = rawget( self.DB.profile.packs, pack )
                                        if data then
                                            insert( data.lists[ packControl.listName ], { {} } )
                                            packControl.actionID = format( "%04d", #data.lists[ packControl.listName ] )
                                        else
                                            packControl.actionID = "0001"
                                        end
                                    end,
                                    hidden = function () return packControl.makingNew end,
                                },

                                delActionBtn = {
                                    type = "execute",
                                    name = "",
                                    image = RedX,
                                    -- image = GetAtlasFile( "communities-icon-redx" ),
                                    -- imageCoords = GetAtlasCoords( "communities-icon-redx" ),
                                    imageHeight = 20,
                                    imageWidth = 20,
                                    width = 0.15,
                                    order = 2.4,
                                    confirm = function() return "确定删除这个项目吗？" end,
                                    func = function ()
                                        local id = tonumber( packControl.actionID )
                                        local p = rawget( Hekili.DB.profile.packs, pack )

                                        remove( p.lists[ packControl.listName ], id )

                                        if not p.lists[ packControl.listName ][ id ] then id = id - 1; packControl.actionID = format( "%04d", id ) end
                                        if not p.lists[ packControl.listName ][ id ] then packControl.actionID = "zzzzzzzzzz" end

                                        self:LoadScripts()
                                    end,
                                    disabled = function ()
                                        local p = rawget( Hekili.DB.profile.packs, pack )
                                        return not p.lists[ packControl.listName ] or #p.lists[ packControl.listName ] < 2
                                    end,
                                    hidden = function () return packControl.makingNew end,
                                },

                                --[[ actionGroup = {
                                    type = "group",
                                    inline = true,
                                    name = "",
                                    order = 3,
                                    hidden = function ()
                                        local p = rawget( Hekili.DB.profile.packs, pack )

                                        if packControl.makingNew or rawget( p.lists, packControl.listName ) == nil or packControl.actionID == "zzzzzzzzzz" then
                                            return true
                                        end
                                        return false
                                    end,
                                    args = {
                                        entry = {
                                            type = "group",
                                            inline = true,
                                            name = "",
                                            order = 2,
                                            -- get = 'GetActionOption',
                                            -- set = 'SetActionOption',
                                            hidden = function( info )
                                                local id = tonumber( packControl.actionID )
                                                local p = rawget( Hekili.DB.profile.packs, pack )
                                                return not packControl.actionID or packControl.actionID == "zzzzzzzzzz" or not p.lists[ packControl.listName ][ id ]
                                            end,
                                            args = { ]]
                                                enabled = {
                                                    type = "toggle",
                                                    name = "启用",
                                                    desc = "如果禁用此项，即使满足条件，也不会显示此项目。",
                                                    order = 3.0,
                                                    width = "full",
                                                },

                                                action = {
                                                    type = "select",
                                                    name = "指令（技能）",
                                                    desc = "选择满足项目条件时推荐进行的操作指令。",
                                                    values = class.abilityList,
                                                    order = 3.1,
                                                    width = 1.5,
                                                },

                                                caption = {
                                                    type = "input",
                                                    name = "标题",
                                                    desc = "标题是|cFFFF0000非常简短|r的描述，可以出现在推荐技能的图标上。\n\n" ..
                                                    "这有助于理解为何在此刻推荐此技能。\n\n" ..
                                                    "需要在每个显示框上启用标题。",
                                                    order = 3.2,
                                                    width = 1.5,
                                                    validate = function( info, val )
                                                        val = val:trim()
                                                        if val:len() > 20 then return "Captions should be 20 characters or less." end
                                                        return true
                                                    end,
                                                    hidden = function()
                                                        local e = GetListEntry( pack )
                                                        local ability = e.action and class.abilities[ e.action ]

                                                        return not ability or ( ability.id < 0 and ability.id > -10 )
                                                    end,
                                                },

                                                list_name = {
                                                    type = "select",
                                                    name = "技能列表",
                                                    values = function ()
                                                        local e = GetListEntry( pack )
                                                        local v = {}

                                                        local p = rawget( Hekili.DB.profile.packs, pack )

                                                        for k in pairs( p.lists ) do
                                                            if k ~= packControl.listName then
                                                                if k == 'precombat' or k == 'default' then
                                                                    v[ k ] = "|cFF00B4FF" .. k .. "|r"
                                                                else
                                                                    v[ k ] = k
                                                                end
                                                            end
                                                        end

                                                        return v
                                                    end,
                                                    order = 3.2,
                                                    width = 1.2,
                                                    hidden = function ()
                                                        local e = GetListEntry( pack )
                                                        return not ( e.action == "call_action_list" or e.action == "run_action_list" )
                                                    end,
                                                },

                                                buff_name = {
                                                    type = "select",
                                                    name = "Buff名称",
                                                    order = 3.2,
                                                    width = 1.5,
                                                    desc = "选择要取消的Buff。",
                                                    values = class.auraList,
                                                    hidden = function ()
                                                        local e = GetListEntry( pack )
                                                        return e.action ~= "cancel_buff"
                                                    end,
                                                },

                                                potion = {
                                                    type = "select",
                                                    name = "位置",
                                                    order = 3.2,
                                                    -- width = "full",
                                                    values = class.potionList,
                                                    hidden = function ()
                                                        local e = GetListEntry( pack )
                                                        return e.action ~= "potion"
                                                    end,
                                                    width = 1.2,
                                                },

                                                sec = {
                                                    type = "input",
                                                    name = "秒",
                                                    order = 3.2,
                                                    width = 1.2,
                                                    hidden = function ()
                                                        local e = GetListEntry( pack )
                                                        return e.action ~= "wait"
                                                    end,
                                                },

                                                max_energy = {
                                                    type = "toggle",
                                                    name = "最大连击点数",
                                                    order = 3.2,
                                                    width = 1.2,
                                                    desc = "勾选后此项后，将要求玩家有足够大的连击点数激发凶猛撕咬的全部伤害加成。",
                                                    hidden = function ()
                                                        local e = GetListEntry( pack )
                                                        return e.action ~= "ferocious_bite"
                                                    end,
                                                },

                                                description = {
                                                    type = "input",
                                                    name = "说明",
                                                    desc = "这里允许你提供解释此项目的说明。当你暂停并用鼠标悬停时，将显示此处的文本，以便查看推荐此项目的原因。" ..
                                                        "",
                                                    order = 3.205,
                                                    width = "full",
                                                },

                                                lb01 = {
                                                    type = "description",
                                                    name = "",
                                                    order = 3.21,
                                                    width = "full"
                                                },

                                                var_name = {
                                                    type = "input",
                                                    name = "变量名",
                                                    order = 3.3,
                                                    width = 1.5,
                                                    desc = "指定此变量的名称。变量名必须使用小写字母，且除了下划线之外不允许其他符号。",
                                                    validate = function( info, val )
                                                        if val:len() < 3 then return "变量名的长度必须不少于3个字符。" end

                                                        local check = formatKey( val )
                                                        if check ~= val then return "输入的字符无效。请重试。" end

                                                        return true
                                                    end,
                                                    hidden = function ()
                                                        local e = GetListEntry( pack )
                                                        return e.action ~= "variable"
                                                    end,
                                                },

                                                op = {
                                                    type = "select",
                                                    name = "操作",
                                                    values = {
                                                        add = "数值加法",
                                                        ceil = "数值上限",
                                                        default = "设置默认值",
                                                        div = "数值除法",
                                                        floor = "数值下限",
                                                        max = "最大值",
                                                        min = "最小值",
                                                        mod = "数值取余",
                                                        mul = "数值乘法",
                                                        pow = "数值幂运算",
                                                        reset = "重置为默认值",
                                                        set = "设置数值为",
                                                        setif = "如果…设置数值为",
                                                        sub = "数值减法",
                                                    },
                                                    order = 3.31,
                                                    width = 1.5,
                                                    hidden = function ()
                                                        local e = GetListEntry( pack )
                                                        return e.action ~= "variable"
                                                    end,
                                                },

                                                modPooling = {
                                                    type = "group",
                                                    inline = true,
                                                    name = "",
                                                    order = 3.5,
                                                    args = {
                                                        for_next = {
                                                            type = "toggle",
                                                            name = function ()
                                                                local n = packControl.actionID; n = tonumber( n ) + 1
                                                                local e = Hekili.DB.profile.packs[ pack ].lists[ packControl.listName ][ n ]

                                                                local ability = e and e.action and class.abilities[ e.action ]
                                                                ability = ability and ability.name or "未设置"

                                                                return "归集到下一个项目(" .. ability ..")"
                                                            end,
                                                            desc = "如果勾选，插件将归集资源，直到下一个技能有足够的资源可供使用。",
                                                            order = 5,
                                                            width = 1.5,
                                                            hidden = function ()
                                                                local e = GetListEntry( pack )
                                                                return e.action ~= "pool_resource"
                                                            end,
                                                        },

                                                        wait = {
                                                            type = "input",
                                                            name = "归集时间",
                                                            desc = "以秒为单位指定时间，需要是数字或计算结果为数字的表达式。\n" ..
                                                            "默认值为|cFFFFD1000.5|r。表达式示例为|cFFFFD100energy.time_to_max|r。",
                                                            order = 6,
                                                            width = 1.5,
                                                            multiline = 3,
                                                            hidden = function ()
                                                                local e = GetListEntry( pack )
                                                                return e.action ~= "pool_resource" or e.for_next == 1
                                                            end,
                                                        },

                                                        extra_amount = {
                                                            type = "input",
                                                            name = "额外归集",
                                                            desc = "指定除了下一项目所需的资源外，还需要额外归集的资源量。",
                                                            order = 6,
                                                            width = 1.5,
                                                            hidden = function ()
                                                                local e = GetListEntry( pack )
                                                                return e.action ~= "pool_resource" or e.for_next ~= 1
                                                            end,
                                                        },
                                                    },
                                                    hidden = function ()
                                                        local e = GetListEntry( pack )
                                                        return e.action ~= 'pool_resource'
                                                    end,
                                                },

                                                criteria = {
                                                    type = "input",
                                                    name = "条件",
                                                    order = 3.6,
                                                    width = "full",
                                                    multiline = 6,
                                                    dialogControl = "HekiliCustomEditor",
                                                    arg = function( info )
                                                        local pack, list, action = info[ 2 ], packControl.listName, tonumber( packControl.actionID )
                                                        local results = {}

                                                        state.reset()

                                                        local apack = rawget( self.DB.profile.packs, pack )

                                                        -- Let's load variables, just in case.
                                                        for name, alist in pairs( apack.lists ) do
                                                            for i, entry in ipairs( alist ) do
                                                                if name ~= list or i ~= action then
                                                                    if entry.action == "variable" and entry.var_name then
                                                                        state:RegisterVariable( entry.var_name, pack .. ":" .. name .. ":" .. i, name )
                                                                    end
                                                                end
                                                            end
                                                        end

                                                        local entry = apack and apack.lists[ list ]
                                                        entry = entry and entry[ action ]

                                                        state.this_action = entry.action

                                                        local scriptID = pack .. ":" .. list .. ":" .. action
                                                        state.scriptID = scriptID
                                                        scripts:StoreValues( results, scriptID )

                                                        return results, list, action
                                                    end,
                                                },

                                                value = {
                                                    type = "input",
                                                    name = "数值",
                                                    desc = "提供调用此变量时要存储（或计算）的数值。",
                                                    order = 3.61,
                                                    width = "full",
                                                    multiline = 3,
                                                    dialogControl = "HekiliCustomEditor",
                                                    arg = function( info )
                                                        local pack, list, action = info[ 2 ], packControl.listName, tonumber( packControl.actionID )
                                                        local results = {}

                                                        state.reset()

                                                        local apack = rawget( self.DB.profile.packs, pack )

                                                        -- Let's load variables, just in case.
                                                        for name, alist in pairs( apack.lists ) do
                                                            for i, entry in ipairs( alist ) do
                                                                if name ~= list or i ~= action then
                                                                    if entry.action == "variable" and entry.var_name then
                                                                        state:RegisterVariable( entry.var_name, pack .. ":" .. name .. ":" .. i, name )
                                                                    end
                                                                end
                                                            end
                                                        end

                                                        local entry = apack and apack.lists[ list ]
                                                        entry = entry and entry[ action ]

                                                        state.this_action = entry.action

                                                        local scriptID = pack .. ":" .. list .. ":" .. action
                                                        state.scriptID = scriptID
                                                        scripts:StoreValues( results, scriptID, "value" )

                                                        return results, list, action
                                                    end,
                                                    hidden = function ()
                                                        local e = GetListEntry( pack )
                                                        return e.action ~= "variable" or e.op == "reset" or e.op == "ceil" or e.op == "floor"
                                                    end,
                                                },

                                                value_else = {
                                                    type = "input",
                                                    name = "不满足时数值",
                                                    desc = "提供不满足此变量条件时要存储（或计算）的数值。",
                                                    order = 3.62,
                                                    width = "full",
                                                    multiline = 3,
                                                    dialogControl = "HekiliCustomEditor",
                                                    arg = function( info )
                                                        local pack, list, action = info[ 2 ], packControl.listName, tonumber( packControl.actionID )
                                                        local results = {}

                                                        state.reset()

                                                        local apack = rawget( self.DB.profile.packs, pack )

                                                        -- Let's load variables, just in case.
                                                        for name, alist in pairs( apack.lists ) do
                                                            for i, entry in ipairs( alist ) do
                                                                if name ~= list or i ~= action then
                                                                    if entry.action == "variable" and entry.var_name then
                                                                        state:RegisterVariable( entry.var_name, pack .. ":" .. name .. ":" .. i, name )
                                                                    end
                                                                end
                                                            end
                                                        end

                                                        local entry = apack and apack.lists[ list ]
                                                        entry = entry and entry[ action ]

                                                        state.this_action = entry.action

                                                        local scriptID = pack .. ":" .. list .. ":" .. action
                                                        state.scriptID = scriptID
                                                        scripts:StoreValues( results, scriptID, "value_else" )

                                                        return results, list, action
                                                    end,
                                                    hidden = function ()
                                                        local e = GetListEntry( pack )
                                                        -- if not e.criteria or e.criteria:trim() == "" then return true end
                                                        return e.action ~= "variable" or e.op == "reset" or e.op == "ceil" or e.op == "floor"
                                                    end,
                                                },

                                                showModifiers = {
                                                    type = "toggle",
                                                    name = "显示设置项",
                                                    desc = "如果勾选，可以调整更多的设置项和条件。",
                                                    order = 20,
                                                    width = "full",
                                                    hidden = function ()
                                                        local e = GetListEntry( pack )
                                                        local ability = e.action and class.abilities[ e.action ]

                                                        return not ability -- or ( ability.id < 0 and ability.id > -100 )
                                                    end,
                                                },

                                                modCycle = {
                                                    type = "group",
                                                    inline = true,
                                                    name = "",
                                                    order = 21,
                                                    args = {
                                                        cycle_targets = {
                                                            type = "toggle",
                                                            name = "循环目标",
                                                            desc = "如果勾选，插件将检查每个可用目标，并提示切换目标。",
                                                            order = 1,
                                                            width = "single",
                                                        },

                                                        max_cycle_targets = {
                                                            type = "input",
                                                            name = "最大循环目标数",
                                                            desc = "如果勾选循环目标，插件将监测指定数量的目标。",
                                                            order = 2,
                                                            width = "double",
                                                            disabled = function( info )
                                                                local e = GetListEntry( pack )
                                                                return e.cycle_targets ~= 1
                                                            end,
                                                        }
                                                    },
                                                    hidden = function ()
                                                        local e = GetListEntry( pack )
                                                        local ability = e.action and class.abilities[ e.action ]

                                                        return not packControl.showModifiers or ( not ability or ( ability.id < 0 and ability.id > -100 ) )
                                                    end,
                                                },

                                                modMoving = {
                                                    type = "group",
                                                    inline = true,
                                                    name = "",
                                                    order = 22,
                                                    args = {
                                                        enable_moving = {
                                                            type = "toggle",
                                                            name = "监测移动",
                                                            desc = "如果勾选，仅当角色的移动状态与设置匹配时，才会推荐此项目。",
                                                            order = 1,
                                                        },

                                                        moving = {
                                                            type = "select",
                                                            name = "移动状态",
                                                            desc = "如果设置，仅当你的移动状态与设置匹配时，才会推荐此项目。",
                                                            order = 2,
                                                            width = "double",
                                                            values = {
                                                                 [0]  = "站立",
                                                                [1]  = "移动"
                                                            },
                                                            disabled = function( info )
                                                                local e = GetListEntry( pack )
                                                                return not e.enable_moving
                                                            end,
                                                        }
                                                    },
                                                    hidden = function ()
                                                        local e = GetListEntry( pack )
                                                        local ability = e.action and class.abilities[ e.action ]

                                                        return not packControl.showModifiers or ( not ability or ( ability.id < 0 and ability.id > -100 ) )
                                                    end,
                                                },

                                                modAsyncUsage = {
                                                    type = "group",
                                                    inline = true,
                                                    name = "",
                                                    order = 22.1,
                                                    args = {
                                                        use_off_gcd = {
                                                            type = "toggle",
                                                            name = "不占用GCD",
                                                            desc = "如果勾选，即使处于全局冷却（GCD）中，也可以监测此项目。",
                                                            order = 1,
                                                            width = 0.99,
                                                        },
                                                        use_while_casting = {
                                                            type = "toggle",
                                                            name = "施法中可用",
                                                            desc = "如果勾选，即使你已经在施法或引导，也可以监测此项目。",
                                                            order = 2,
                                                            width = 0.99
                                                        },
                                                        only_cwc = {
                                                            type = "toggle",
                                                            name = "引导时使用",
                                                            desc = "如果勾选，只有在你引导其他技能时才能使用此项目（如暗影牧师的灼烧梦魇）。",
                                                            order = 3,
                                                            width = 0.99
                                                        }
                                                    },
                                                    hidden = function ()
                                                        local e = GetListEntry( pack )
                                                        local ability = e.action and class.abilities[ e.action ]

                                                        return not packControl.showModifiers or ( not ability or ( ability.id < 0 and ability.id > -100 ) )
                                                    end,
                                                },

                                                modCooldown = {
                                                    type = "group",
                                                    inline = true,
                                                    name = "",
                                                    order = 23,
                                                    args = {
                                                        --[[ enable_line_cd = {
                                                            type = "toggle",
                                                            name = "Line Cooldown",
                                                            desc = "If enabled, this entry cannot be recommended unless the specified amount of time has passed since its last use.",
                                                            order = 1,
                                                        }, ]]

                                                        line_cd = {
                                                            type = "input",
                                                            name = "强制冷却时间",
                                                            desc = "如果设置，则强制在上次使用此项目后一定时间后，才会再次被推荐。",
                                                            order = 1,
                                                            width = "full",
                                                            --[[ disabled = function( info )
                                                                local e = GetListEntry( pack )
                                                                return not e.enable_line_cd
                                                            end, ]]
                                                        },
                                                    },
                                                    hidden = function ()
                                                        local e = GetListEntry( pack )
                                                        local ability = e.action and class.abilities[ e.action ]

                                                        return not packControl.showModifiers or ( not ability or ( ability.id < 0 and ability.id > -100 ) )
                                                    end,
                                                },

                                                modAPL = {
                                                    type = "group",
                                                    inline = true,
                                                    name = "",
                                                    order = 24,
                                                    args = {
                                                        strict = {
                                                            type = "toggle",
                                                            name = "严谨/时间不敏感",
                                                            desc = "如果勾选，插件将认为此项目不在乎时间，并且在不满足条件时，不会尝试推荐链接的技能列表中的操作。",
                                                            order = 1,
                                                            width = "full",
                                                        }
                                                    },
                                                    hidden = function ()
                                                        local e = GetListEntry( pack )
                                                        local ability = e.action and class.abilities[ e.action ]

                                                        return not packControl.showModifiers or ( not ability or not ( ability.key == "call_action_list" or ability.key == "run_action_list" ) )
                                                    end,
                                                },

                                                --[[ deleteHeader = {
                                                    type = "header",
                                                    name = "Delete Action",
                                                    order = 100,
                                                    hidden = function ()
                                                        local p = rawget( Hekili.DB.profile.packs, pack )
                                                        return #p.lists[ packControl.listName ] < 2 end
                                                },

                                                delete = {
                                                    type = "execute",
                                                    name = "Delete Entry",
                                                    order = 101,
                                                    confirm = true,
                                                    func = function ()
                                                        local id = tonumber( packControl.actionID )
                                                        local p = rawget( Hekili.DB.profile.packs, pack )

                                                        remove( p.lists[ packControl.listName ], id )

                                                        if not p.lists[ packControl.listName ][ id ] then id = id - 1; packControl.actionID = format( "%04d", id ) end
                                                        if not p.lists[ packControl.listName ][ id ] then packControl.actionID = "zzzzzzzzzz" end

                                                        self:LoadScripts()
                                                    end,
                                                    hidden = function ()
                                                        local p = rawget( Hekili.DB.profile.packs, pack )
                                                        return #p.lists[ packControl.listName ] < 2
                                                    end
                                                }
                                            },
                                        },
                                    }
                                }, ]]

                                newListGroup = {
                                    type = "group",
                                    inline = true,
                                    name = "",
                                    order = 2,
                                    hidden = function ()
                                        return not packControl.makingNew
                                    end,
                                    args = {
                                        newListName = {
                                            type = "input",
                                            name = "列表名",
                                            order = 1,
                                            validate = function( info, val )
                                                local p = rawget( Hekili.DB.profile.packs, pack )

                                                if val:len() < 2 then return "技能列表名的长度至少为2个字符。"
                                                elseif rawget( p.lists, val ) then return "已存在同名的技能列表。"
                                                elseif val:find( "[^a-zA-Z0-9一-龥_]" ) then return "技能列表仅能使用字母、数字、字符和下划线。" end
                                                return true
                                            end,
                                            width = 3,
                                        },

                                        lineBreak = {
                                            type = "description",
                                            name = "",
                                            order = 1.1,
                                            width = "full"
                                        },

                                        createList = {
                                            type = "execute",
                                            name = "添加列表",
                                            disabled = function() return packControl.newListName == nil end,
                                            func = function ()
                                                local p = rawget( Hekili.DB.profile.packs, pack )
                                                p.lists[ packControl.newListName ] = { {} }
                                                packControl.listName = packControl.newListName
                                                packControl.makingNew = false

                                                packControl.actionID = "0001"
                                                packControl.newListName = nil

                                                Hekili:LoadScript( pack, packControl.listName, 1 )
                                            end,
                                            width = 1,
                                            order = 2,
                                        },

                                        cancel = {
                                            type = "execute",
                                            name = "取消",
                                            func = function ()
                                                packControl.makingNew = false
                                            end,
                                        }
                                    }
                                },

                                newActionGroup = {
                                    type = "group",
                                    inline = true,
                                    name = "",
                                    order = 3,
                                    hidden = function ()
                                        return packControl.makingNew or packControl.actionID ~= "zzzzzzzzzz"
                                    end,
                                    args = {
                                        createEntry = {
                                            type = "execute",
                                            name = "创建新项目",
                                            order = 1,
                                            func = function ()
                                                local p = rawget( Hekili.DB.profile.packs, pack )
                                                insert( p.lists[ packControl.listName ], {} )
                                                packControl.actionID = format( "%04d", #p.lists[ packControl.listName ] )
                                            end,
                                        }
                                    }
                                }
                            },
                            plugins = {
                            }
                        },

                        export = {
                            type = "group",
                            name = "导出",
                            order = 4,
                            args = {
                                exportString = {
                                    type = "input",
                                    name = "导出字符串（CTRL+A全部选中，CTRL+C复制）",
                                    get = function( info )
                                        return self:SerializeActionPack( pack )
                                    end,
                                    set = function () end,
                                    order = 1,
                                    width = "full"
                                }
                            }
                        }
                    },
                }

                --[[ wipe( opts.args.lists.plugins.lists )

                local n = 10
                for list in pairs( data.lists ) do
                    opts.args.lists.plugins.lists[ list ] = EmbedActionListOptions( n, pack, list )
                    n = n + 1
                end ]]

                packs.plugins.packages[ pack ] = opts
                count = count + 1
            end
        end

        collectgarbage()
        db.args.packs = packs
    end

end


do
    do
        local completed = false
        local SetOverrideBinds

        SetOverrideBinds = function ()
            if InCombatLockdown() then
                C_Timer.After( 5, SetOverrideBinds )
                return
            end

            if completed then
                ClearOverrideBindings( Hekili_Keyhandler )
                completed = false
            end

            for name, toggle in pairs( Hekili.DB.profile.toggles ) do
                if toggle.key and toggle.key ~= "" then
                    SetOverrideBindingClick( Hekili_Keyhandler, true, toggle.key, "Hekili_Keyhandler", name )
                    completed = true
                end
            end
        end

        function Hekili:OverrideBinds()
            SetOverrideBinds()
        end
    end


    local modeTypes = {
        oneAuto = 1,
        oneSingle = 2,
        oneAOE = 3,
        twoDisplays = 4,
        reactive = 5,
    }

    local function SetToggle( info, val )
        local self = Hekili
        local p = self.DB.profile
        local n = #info
        local bind, option = info[ 2 ], info[ n ]

        local toggle = p.toggles[ bind ]
        if not toggle then return end

        if option == 'value' then
            if bind == 'pause' then self:TogglePause()
            elseif bind == 'mode' then toggle.value = val
            else self:FireToggle( bind ) end

        elseif option == 'type' then
            toggle.type = val

            if val == "AutoSingle" and not ( toggle.value == "automatic" or toggle.value == "single" ) then toggle.value = "automatic" end
            if val == "AutoDual" and not ( toggle.value == "automatic" or toggle.value == "dual" ) then toggle.value = "automatic" end
            if val == "SingleAOE" and not ( toggle.value == "single" or toggle.value == "aoe" ) then toggle.value = "single" end
            if val == "ReactiveDual" and toggle.value ~= "reactive" then toggle.value = "reactive" end

        elseif option == 'key' then
            for t, data in pairs( p.toggles ) do
                if data.key == val then data.key = "" end
            end

            toggle.key = val
            self:OverrideBinds()

        elseif option == 'override' then
            toggle[ option ] = val
            ns.UI.Minimap:RefreshDataText()

        else
            toggle[ option ] = val

        end
    end

    local function GetToggle( info )
        local self = Hekili
        local p = Hekili.DB.profile
        local n = #info
        local bind, option = info[2], info[ n ]

        local toggle = bind and p.toggles[ bind ]
        if not toggle then return end

        if bind == 'pause' and option == 'value' then return self.Pause end
        return toggle[ option ]
    end

    -- Bindings.
    function Hekili:EmbedToggleOptions( db )
        db = db or self.Options
        if not db then return end

        db.args.toggles = db.args.toggles or {
            type = 'group',
            name = '快捷切换',
            order = 20,
            get = GetToggle,
            set = SetToggle,
            args = {
                info = {
                    type = "description",
                    name = "设置不同的切换快捷键，可以让你在紧张的战斗中，在不同的输出建议和显示方式中进行切换。",
                    order = 0.5,
                    fontSize = "medium",
                },

                cooldowns = {
                    type = "group",
                    name = "",
                    inline = true,
                    order = 2,
                    args = {
                        key = {
                            type = "keybinding",
                            name = "爆发",
                            desc = "设置一个按键对爆发技能是否推荐进行开/关。",
                            order = 1,
                        },

                        value = {
                            type = "toggle",
                            name = "启用爆发技能",
                            desc = "如果勾选，将推荐标记为爆发的技能。",
                            order = 2,                            
                        },

                        separate = {
                            type = "toggle",
                            name = NewFeature .. "启用单独显示",
                            desc = "如果勾选，爆发技能将在爆发显示区域中单独显示。\n\n" ..
                                "这是一项实验性功能，可能对某些职业专精不起作用。",
                            order = 3,
                        },

                        lineBreak = {
                            type = "description",
                            name = "",
                            width = "full",
                            order = 3.1,
                        },

                        indent = {
                            type = "description",
                            name = "",
                            width = 1,
                            order = 3.2
                        },

                        override = {
                            type = "toggle",
                            name = "嗜血凌驾",
                            desc = "如果勾选，当嗜血（或类似效果）激活时，即使未启用爆发，插件也会推荐爆发技能。",
                            order = 4,
                        }
                    }
                },

                essences = {
                    type = "group",
                    name = "",
                    inline = true,
                    order = 2.1,
                    args = {
                        key = {
                            type = "keybinding",
                            name = "盟约",
                            desc = "设置一个按键对盟约建议进行开/关。",
                            order = 1,
                        },

                        value = {
                            type = "toggle",
                            name = "启用盟约技能",
                            desc = "如果勾选，将推荐来自盟约的技能。",
                            order = 2,                            
                        },

                        override = {
                            type = "toggle",
                            name = "爆发凌驾",
                            desc = "如果勾选，当爆发被启用，即使未勾选启用盟约，插件也会推荐盟约技能。",
                            order = 3,
                        },
                    }
                },

                defensives = {
                    type = "group",
                    name = "",
                    inline = true,
                    order = 5,
                    args = {
                        key = {
                            type = "keybinding",
                            name = "防御",
                            desc = "设置一个按键对防御/减伤建议进行开/关。\n" ..
                                "\n此项仅适用于坦克专精。",
                            order = 1,
                        },

                        value = {
                            type = "toggle",
                            name = "启用防御技能",
                            desc = "如果勾选，将推荐标记为防御的技能。\n" ..
                                "\n此项仅适用于坦克专精。",
                            order = 2,                            
                        },

                        separate = {
                            type = "toggle",
                            name = "启用单独显示",
                            desc = "如果勾选，防御/减伤技能建议将在防御显示区域中单独显示。\n" ..
                                "\n此项仅适用于坦克专精。",
                            order = 3,
                        }
                    }
                },

                interrupts = {
                    type = "group",
                    name = "",
                    inline = true,
                    order = 4,
                    args = {
                        key = {
                            type = "keybinding",
                            name = "打断",
                            desc = "设置一个按键对打断建议进行开/关。",
                            order = 1,                            
                        },

                        value = {
                            type = "toggle",
                            name = "启用打断技能",
                            desc = "如果勾选，将推荐标记为打断的技能。",
                            order = 2,
                        },

                        separate = {
                            type = "toggle",
                            name = "启用单独显示",
                            desc = "如果勾选，打断技能建议将在打断显示区域中单独显示（如果启用）。",
                            order = 3,
                        }
                    }
                },

                potions = {
                    type = "group",
                    name = "",
                    inline = true,
                    order = 6,
                    args = {
                        key = {
                            type = "keybinding",
                            name = "药剂",
                            desc = "设置一个按键对药剂建议进行开/关。",
                            order = 1,
                        },

                        value = {
                            type = "toggle",
                            name = "启用药剂",
                            desc = "如果勾选，将推荐药剂。",
                            order = 2,
                        },
                    }
                },

                displayModes = {
                    type = "header",
                    name = "显示模式",
                    order = 10,
                },

                mode = {
                    type = "group",
                    inline = true,
                    name = "",
                    order = 10.1,
                    args = {
                        key = {
                            type = 'keybinding',
                            name = '切换显示模式',
                            desc = "按下此快捷键将会循环启用你在下方勾选的显示模式。",
                            order = 1,
                            width = 1,
                        },

                        value = {
                            type = "select",
                            name = "当前显示模式",
                            desc = "选择你当前的显示模式。",
                            values = {
                                automatic = "自动",
                                single = "单目标",
                                aoe = "AOE（多目标）",
                                dual = "固定式双显",
                                reactive = "响应式双显"
                            },
                            width = 2,
                            order = 1.02,
                        },

                        modeLB2 = {
                            type = "description",
                            name = "勾选想要使用的 |cFFFFD100显示模式|r 。当你按下 |cFFFFD100切换显示模式|r 快捷键时，插件将切换到你下一个选中的显示模式。",
                            fontSize = "medium",
                            width = "full",
                            order = 1.03
                        },

                        automatic = {
                            type = "toggle",
                            name = "自动",
                            desc = "如果勾选，显示模式将切换到自动模式。\n\n主要显示区域将根据检测到的敌人数量进行技能建议（根据你的当前职业专精）。",
                            width = 1.5,
                            order = 1.1,
                        },

                        single = {
                            type = "toggle",
                            name = "单目标",
                            desc = "如果勾选，显示模式将切换到单目标模式。\n\n主要显示区域将以单目标输出进行技能建议（即使检测到多目标）。",
                            width = 1.5,
                            order = 1.2,
                        },

                        aoe = {
                            type = "toggle",
                            name = "AOE（多目标）",
                            desc = function ()
                                return format( "如果勾选，显示模式将切换到AOE模式。\n\n主要显示区域将以多(%d)目标输出进行技能建议（即使检测到的目标没那么多）。\n\n" ..
                                                "目标数量在专业化选项中进行设置。", self.DB.profile.specs[ state.spec.id ].aoe or 3 )
                            end,
                            width = 1.5,
                            order = 1.3,
                        },

                        dual = {
                            type = "toggle",
                            name = "固定式双显",
                            desc = function ()
                                return format( "如果勾选，显示模式切换到双显示模式。\n\n主显示区域显示单目标输出技能建议，同时AOE显示区域显示多目标输出技能建议（即使检测到的目标没那么多）。\n\n" ..
                                                "AOE目标数量在专业化选项中进行设置。", self.DB.profile.specs[ state.spec.id ].aoe or 3 )
                            end,
                            width = 1.5,
                            order = 1.4,
                        },

                        reactive = {
                            type = "toggle",
                            name = "响应式双显",
                            desc = function ()
                                return format( "如果勾选，显示模式将可以切换到响应模式。\n\n主显示区域显示单目标输出技能建议，AOE显示区域在检测到其他目标之前，都将保持隐藏。", self.DB.profile.specs[ state.spec.id ].aoe or 3 )
                            end,
                            width = 1.5,
                            order = 1.5,
                        },

                        --[[ type = {
                            type = "select",
                            name = "Modes",
                            desc = "Select the Display Modes that can be cycled using your Display Mode key.\n\n" ..
                                "|cFFFFD100Auto vs. Single|r - Using only the Primary display, toggle between automatic target counting and single-target recommendations.\n\n" ..
                                "|cFFFFD100Single vs. AOE|r - Using only the Primary display, toggle between single-target recommendations and AOE (multi-target) recommendations.\n\n" ..
                                "|cFFFFD100Auto vs. Dual|r - Toggle between one display using automatic target counting and two displays, with one showing single-target recommendations and the other showing AOE recommendations.  This will use additional CPU.\n\n" ..
                                "|cFFFFD100Reactive AOE|r - Use the Primary display for single-target recommendations, and when additional enemies are detected, show the AOE display.  (Disables Mode Toggle)",
                            values = {
                                AutoSingle = "Auto vs. Single",
                                SingleAOE = "Single vs. AOE",
                                AutoDual = "Auto vs. Dual",
                                ReactiveDual = "Reactive AOE",
                            },
                            order = 2,
                        }, ]]
                    },
                },

                troubleshooting = {
                    type = "header",
                    name = "故障排除",
                    order = 20,                    
                },

                pause = {
                    type = "group",
                    name = "",
                    inline = true,
                    order = 20.1,
                    args = {
                        key = {
                            type = 'keybinding',
                            name = function () return Hekili.Pause and "取消暂停" or "暂停" end,
                            desc =  "设置一个按键使你的技能列表暂停。当前显示区域将被冻结，" ..
                                    "你可以将鼠标悬停在每个技能图标上，查看有关该技能的操作信息。\n\n" ..
                                    "同时还将创建一个快照，可用于故障排除和错误报告。",
                            order = 1,
                        },
                        value = {
                            type = 'toggle',
                            name = '启用暂停',
                            order = 2,
                        },
                    }
                },

                snapshot = {
                    type = "group",
                    name = "",
                    inline = true,
                    order = 20.2,
                    args = {
                        key = {
                            type = 'keybinding',
                            name = '快照',
                            desc = "设置一个快捷键，生成一个可在快照页面中查看的快照（不暂停）。这对于测试和调试非常有用。",
                            order = 1,
                        },
                    }
                },

                customHeader = {
                    type = "header",
                    name = "自定义",
                    order = 30,
                },

                custom1 = {
                    type = "group",
                    name = "",
                    inline = true,
                    order = 30.1,
                    args = {
                        key = {
                            type = "keybinding",
                            name = "自定义#1",
                            desc = "设置一个按键切换自定义集。",
                            order = 1,
                        },

                        value = {
                            type = "toggle",
                            name = "启用自定义#1",
                            desc = "如果勾选，将推荐自定义#1中的技能。",
                            order = 2,
                        },

                        name = {
                            type = "input",
                            name = "自定义#1名称",
                            desc = "设置自定义的描述性名称。",
                            order = 3
                        }
                    }
                },

                custom2 = {
                    type = "group",
                    name = "",
                    inline = true,
                    order = 30.2,
                    args = {
                        key = {
                            type = "keybinding",
                            name = "自定义#2",
                            desc = "设置一个按键切换第二个自定义集合。",
                            order = 1,
                        },

                        value = {
                            type = "toggle",
                            name = "启用自定义#2",
                            desc = "如果勾选，将推荐自定义#2中的技能。",
                            order = 2,
                        },

                        name = {
                            type = "input",
                            name = "自定义#2名称",
                            desc = "设置自定义的描述性名称。",
                            order = 3
                        }
                    }
                },

                --[[ specLinks = {
                    type = "group",
                    inline = true,
                    name = "",
                    order = 10,
                    args = {
                        header = {
                            type = "header",
                            name = "Specializations",
                            order = 1,
                        },

                        specsInfo = {
                            type = "description",
                            name = "There may be additional toggles or settings for your specialization(s).  Use the buttons below to jump to that section.",
                            order = 2,
                            fontSize = "medium",
                        },
                    },
                    hidden = function( info )
                        local hide = true

                        for i = 1, 4 do
                            local id, name, desc = GetSpecializationInfo( i )
                            if not id then break end

                            local sName = lower( name )

                            if db.plugins.specializations[ sName ] then
                                db.args.toggles.args.specLinks.args[ sName ] = db.args.toggles.args.specLinks.args[ sName ] or {
                                    type = "execute",
                                    name = name,
                                    desc = desc,
                                    order = 5 + i,
                                    func = function ()
                                        ACD:SelectGroup( "Hekili", sName )
                                    end,
                                }
                                hide = false
                            end
                        end

                        return hide
                    end,
                } ]]
            }
        }
    end
end


do
    -- Generate a spec skeleton.
    local listener = CreateFrame( "Frame" )
    Hekili:ProfileFrame( "SkeletonListener", listener )

    local indent = ""
    local output = {}

    local function key( s )
        return ( lower( s or '' ):gsub( "[^a-z0-9_ ]", "" ):gsub( "%s", "_" ) )
    end

    local function increaseIndent()
        indent = indent .. "    "
    end

    local function decreaseIndent()
        indent = indent:sub( 1, indent:len() - 4 )
    end

    local function append( s )
        insert( output, indent .. s )
    end

    local function appendAttr( t, s )
        if t[ s ] ~= nil then
            if type( t[ s ] ) == 'string' then
                insert( output, indent .. s .. ' = "' .. tostring( t[s] ) .. '",' )
            else
                insert( output, indent .. s .. ' = ' .. tostring( t[s] ) .. ',' )
            end
        end
    end

    local spec = ""
    local specID = select( 3, UnitClass( "player" ) )

    local mastery_spell = 0

    local resources = {}
    local talents = {}
    local talentSpells = {}
    local pvptalents = {}
    local auras = {}
    local abilities = {}

    Hekili.skeleAuras = auras
    Hekili.skeleTalents = talents
    Hekili.skeleAbilities = abilities

    if Hekili.IsWrath() then
        listener:RegisterEvent( "ACTIVE_TALENT_GROUP_CHANGED" )
        listener:RegisterEvent( "PLAYER_TALENT_UPDATE" )
    else
        listener:RegisterEvent( "PLAYER_SPECIALIZATION_CHANGED" )
    end
    listener:RegisterEvent( "PLAYER_ENTERING_WORLD" )
    listener:RegisterEvent( "UNIT_AURA" )
    listener:RegisterEvent( "SPELLS_CHANGED" )
    listener:RegisterEvent( "UNIT_SPELLCAST_SUCCEEDED" )
    listener:RegisterEvent( "COMBAT_LOG_EVENT_UNFILTERED" )

    local applications = {}
    local removals = {}

    local lastAbility = nil
    local lastTime = 0

    local run = 0

    local function EmbedSpellData( spellID, token, talent, rank )
        local name, _, texture, castTime, minRange, maxRange, spellID = GetSpellInfo( spellID )

        local haste = UnitSpellHaste( "player" )
        haste = 1 + ( haste / 100 )

        if rank and rank > 1 and abilities[ token ] then
            abilities[ token ].copy = abilities[ token ].copy or {}
            insert( abilities[ token ].copy, spellID )
        elseif name then
            token = token or key( name )

            if castTime % 10 > 0 then
                -- We can catch hasted cast times 90% of the time...
                castTime = castTime * haste
            end
            castTime = castTime / 1000

            local costs = {}
            local gain, gainResource

            local powerCosts = GetSpellPowerCost( spellID )

            if powerCosts then
                for k, v in pairs( powerCosts ) do
                    if not v.hasRequiredAura or IsPlayerSpell( v.requiredAuraID ) then
                        if v.cost < 0 then
                            gain = -v.cost
                            gainResource = v.name
                            if v.name == "COMBAT_TEXT_RUNE_BLOOD" then gainResource = "blood_runes"
                            elseif v.name == "COMBAT_TEXT_RUNE_FROST" then gainResource = "frost_runes"
                            elseif v.name == "COMBAT_TEXT_RUNE_UNHOLY" then gainResource = "unholy_runes"
                            else gainResource = key( v.name ) end
                        else
                            insert( costs, {
                                cost = v.costPercent and v.costPercent > 0 and v.costPercent / 100 or v.cost,
                                spendPerSec = v.costPerSecond,
                                spendType = v.name
                            } )

                            local c = costs[ #costs ]

                            if c.spendType == "COMBAT_TEXT_RUNE_BLOOD" then c.spendType = "blood_runes"
                            elseif c.spendType == "COMBAT_TEXT_RUNE_FROST" then c.spendType = "frost_runes"
                            elseif c.spendType == "COMBAT_TEXT_RUNE_UNHOLY" then c.spendType = "unholy_runes"
                            else c.spendType = key( c.spendType ) end
                        end
                    end
                end
            end

            if not costs[1] and gain then
                costs[1] = {
                    cost = -gain,
                    spendType = gainResource
                }

                gain = nil
                gainResource = nil
            end

            local passive = IsPassiveSpell( spellID )
            local harmful = IsHarmfulSpell( spellID )
            local helpful = IsHelpfulSpell( spellID )

            local cooldown, gcd = GetSpellBaseCooldown( spellID )
            local _, charges, _, recharge = GetSpellCharges( spellID )
            if recharge then cooldown = recharge end
            if cooldown then cooldown = cooldown / 1000 end

            if gcd == 0 then gcd = "off"
            elseif gcd == 1000 then gcd = "totem"
            elseif gcd == 1500 then gcd = "spell" end
            if gcd == "off" and cooldown == 0 then passive = true end

            local selfbuff = SpellIsSelfBuff( spellID )
            local talent = talent or IsTalentSpell( spellID )

            if Hekili.IsWrath() then
                auras[ spellID ] = token
            else
                if selfbuff or passive then
                    auras[ token ] = auras[ token ] or {}
                    auras[ token ].id = spellID
                end
            end

            local empowered = IsPressHoldReleaseSpell( spellID )
            -- SpellIsTargeting ?

            if not passive then
                local a = abilities[ token ] or {}

                -- a.key = token
                a.desc = GetSpellDescription( spellID )
                if a.desc then a.desc = a.desc:gsub( "\n", " " ):gsub( "\r", " " ):gsub( " ", " " ) end
                a.id = spellID
                a.spend = costs
                a.gain = gain
                a.gainType = gainResource
                a.cast = castTime
                a.empowered = empowered
                a.gcd = gcd

                a.texture = texture

                if talent then a.talent = token end

                a.startsCombat = harmful or not helpful

                a.cooldown = cooldown
                a.charges = charges
                a.recharge = recharge

                abilities[ token ] = a
            end
        end
    end

    local function CLEU( event, _, subtype, _, sourceGUID, sourceName, _, _, destGUID, destName, destFlags, _, spellID, spellName )
        if sourceName and UnitIsUnit( sourceName, "player" ) and type( spellName ) == 'string' then
            local now = GetTime()
            local token = key( spellName )

            if subtype == "SPELL_AURA_APPLIED" or subtype == "SPELL_AURA_APPLIED_DOSE" or subtype == "SPELL_AURA_REFRESH" or
               subtype == "SPELL_PERIODIC_AURA_APPLIED" or subtype == "SPELL_PERIODIC_AURA_APPLIED_DOSE" or subtype == "SPELL_PERIODIC_AURA_REFRESH" then
                -- the last ability probably refreshed this aura.
                if lastAbility and now - lastTime < 0.25 then
                    -- Go ahead and attribute it to the last cast.
                    local a = abilities[ lastAbility ]

                    if a then
                        a.applies = a.applies or {}
                        a.applies[ token ] = spellID
                    end
                else
                    insert( applications, { s = token, i = spellID, t = now } )
                end
            elseif subtype == "SPELL_AURA_REMOVED" or subtype == "SPELL_AURA_REMOVED_DOSE" or subtype == "SPELL_AURA_REMOVED" or
                   subtype == "SPELL_PERIODIC_AURA_REMOVED" or subtype == "SPELL_PERIODIC_AURA_REMOVED_DOSE" or subtype == "SPELL_PERIODIC_AURA_BROKEN" then
                if lastAbility and now - lastTime < 0.25 then
                    -- Go ahead and attribute it to the last cast.
                    local a = abilities[ lastAbility ]

                    if a then
                        a.applies = a.applies or {}
                        a.applies[ token ] = spellID
                    end
                else
                    insert( removals, { s = token, i = spellID, t = now } )
                end
            end
        end
    end

    local function skeletonHandler( self, event, ... )
        local unit = select( 1, ... )

        if not Hekili.IsWrath() and ( event == "PLAYER_SPECIALIZATION_CHANGED" and UnitIsUnit( unit, "player" ) ) or event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_TALENT_UPDATE" or event == "ACTIVE_TALENT_GROUP_CHANGED" then
            for k, i in pairs( Enum.PowerType ) do
                if k ~= "NumPowerTypes" and i >= 0 then
                    if UnitPowerMax( "player", i ) > 0 then resources[ k ] = i end
                end
            end

            wipe( talents )
            if Hekili.IsDragonflight() then
                local sID, s = GetSpecializationInfo( GetSpecialization() )
                if specID ~= sID then
                    wipe( resources )
                    wipe( auras )
                    wipe( abilities )
                end
                specID = sID
                spec = s

                mastery_spell = GetSpecializationMasterySpells( GetSpecialization() )

                local configID = C_ClassTalents.GetActiveConfigID()
                local configInfo = C_Traits.GetConfigInfo( configID )
                for _, treeID in ipairs( configInfo.treeIDs ) do
                    local nodes = C_Traits.GetTreeNodes( treeID )
                    for _, nodeID in ipairs( nodes ) do
                        local node = C_Traits.GetNodeInfo( configID, nodeID )
                        if node.maxRanks > 0 then
                            for _, entryID in ipairs( node.entryIDs ) do
                                local entryInfo = C_Traits.GetEntryInfo( configID, entryID )
                                local definitionInfo = C_Traits.GetDefinitionInfo( entryInfo.definitionID )

                                local spellID = definitionInfo.spellID
                                local name = GetSpellInfo( spellID )
                                local key = key( name )

                                insert( talents, { name = key, talent = entryID, definition = entryInfo.definitionID, spell = spellID } )

                                if not IsPassiveSpell( spellID ) then
                                    EmbedSpellData( spellID, key, true )
                                end
                            end
                        end
                    end
                end
                wipe( pvptalents )
                local row = C_SpecializationInfo.GetPvpTalentSlotInfo( 1 )

                for i, tID in ipairs( row.availableTalentIDs ) do
                    local _, name, _, _, _, sID = GetPvpTalentInfoByID( tID )
                    name = key( name )
                    insert( pvptalents, { name = name, talent = tID, spell = sID } )
                end

            elseif Hekili.IsWrath() then
                wipe( resources )
                wipe( auras )
                wipe( abilities )

                for i = 1, GetNumTalentTabs() do
                    for n = 1, GetNumTalents( i ) do
                        local talentID = tonumber( GetTalentLink( i, n ):match( "talent:(%d+)" ) )
                        local name, _, _, _, _, ranks = GetTalentInfo( i, n )
                        local key = key( name )

                        insert( talents, { name = key, talent = talentID, ranks = ranks } )

                        local tToS = ns.WrathTalentToSpellID[ talentID ]

                        for rank, spell in ipairs( ns.WrathTalentToSpellID[ talentID ] ) do
                            EmbedSpellData( spell, key, true, rank )
                        end
                    end
                end
            else
                for j = 1, 7 do
                    for k = 1, 3 do
                        local tID, name, _, _, _, sID = GetTalentInfoBySpecialization( GetSpecialization(), j, k )
                        name = key( name )
                        insert( talents, { name = name, talent = tID, spell = sID } )
                    end
                end
            end

            for i = 2, GetNumSpellTabs() do
                local tab, _, offset, n = GetSpellTabInfo( i )

                for j = offset, offset + n - 1 do
                    local name, _, texture, castTime, minRange, maxRange, spellID = GetSpellInfo( j, "spell" )
                    if name then
                        if spellID == 1 then print( name, j ) end
                        local token = key( name )
                        local ability = abilities[ token ]
                        if ability then
                            ability.copy = ability.copy or {}
                            insert( ability.copy, spellID )
                        else
                            EmbedSpellData( spellID, key( name ) )
                        end
                    end
                end
            end
        elseif event == "SPELLS_CHANGED" then
            local haste = UnitSpellHaste( "player" )
            haste = 1 + ( haste / 100 )

            for i = 1, GetNumSpellTabs() do
                local tab, _, offset, n = GetSpellTabInfo( i )

                if i == 2 or tab == spec then
                    for j = offset, offset + n do
                        local name, _, texture, castTime, minRange, maxRange, spellID = GetSpellInfo( j, "spell" )
                        if name then EmbedSpellData( spellID, key( name ) ) end
                    end
                end
            end
        elseif event == "UNIT_AURA" then
            if UnitIsUnit( unit, "player" ) or UnitCanAttack( "player", unit ) then
                for i = 1, 40 do
                    local name, icon, count, debuffType, duration, expirationTime, caster, canStealOrPurge, _, spellID, canApplyAura, _, castByPlayer = UnitBuff( unit, i, "PLAYER" )

                    if not name then break end

                    local token = key( name )

                    local a = auras[ token ] or {}

                    if duration == 0 then duration = 3600 end

                    a.id = spellID
                    a.duration = duration
                    a.type = debuffType
                    a.max_stack = max( a.max_stack or 1, count )

                    auras[ token ] = a
                end

                for i = 1, 40 do
                    local name, icon, count, debuffType, duration, expirationTime, caster, canStealOrPurge, _, spellID, canApplyAura, _, castByPlayer = UnitDebuff( unit, i, "PLAYER" )

                    if not name then break end

                    local token = key( name )

                    local a = auras[ token ] or {}

                    if duration == 0 then duration = 3600 end

                    a.id = spellID
                    a.duration = duration
                    a.type = debuffType
                    a.max_stack = max( a.max_stack or 1, count )

                    auras[ token ] = a
                end
            end

        elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
            if UnitIsUnit( "player", unit ) then
                local spellID = select( 3, ... )
                local token = spellID and class.abilities[ spellID ] and class.abilities[ spellID ].key

                local now = GetTime()

                if not token then return end

                lastAbility = token
                lastTime = now

                local a = abilities[ token ]

                if not a then
                    return
                end

                for k, v in pairs( applications ) do
                    if now - v.t < 0.5 then
                        a.applies = a.applies or {}
                        a.applies[ v.s ] = v.i
                    end
                    applications[ k ] = nil
                end

                for k, v in pairs( removals ) do
                    if now - v.t < 0.5 then
                        a.removes = a.removes or {}
                        a.removes[ v.s ] = v.i
                    end
                    removals[ k ] = nil
                end
            end
        elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
            CLEU( event, CombatLogGetCurrentEventInfo() )
        end
    end

    function Hekili:StartListeningForSkeleton()
        listener:SetScript( "OnEvent", skeletonHandler )

        skeletonHandler( listener, "PLAYER_SPECIALIZATION_CHANGED", "player" )
        skeletonHandler( listener, "SPELLS_CHANGED" )
    end


    function Hekili:EmbedSkeletonOptions( db )
        db = db or self.Options
        if not db then return end

        db.args.skeleton = db.args.skeleton or {
            type = "group",
            name = "Skeleton",
            order = 100,
            args = {
                spooky = {
                    type = "input",
                    name = "Skeleton",
                    desc = "A rough skeleton of your current spec, for development purposes only.",
                    order = 1,
                    get = function( info )
                        return Hekili.Skeleton or ""
                    end,
                    multiline = 25,
                    width = "full"
                },
                regen = {
                    type = "execute",
                    name = "Generate Skeleton",
                    order = 2,
                    func = function()
                        run = run + 1

                        indent = ""
                        wipe( output )

                        if run % 2 > 0 then
                            append( "if UnitClassBase( 'player' ) ~= '" .. UnitClassBase( "player" ) .. "' then return end" )
                            append( "" )
                            append( "local addon, ns = ..." )
                            append( "local Hekili = _G[ addon ]" )
                            append( "local class, state = Hekili.Class, Hekili.State" )
                            append( "" )
                            append( "local spec = Hekili:NewSpecialization( " .. specID .. " )\n" )

                            if Hekili.IsWrath() then
                                for k, i in pairs( Enum.PowerType ) do
                                    if k ~= "NumPowerTypes" and i >= 0 then
                                        if UnitPowerMax( "player", i ) > 0 then resources[ k ] = i end
                                    end
                                end
                            end

                            for k, i in pairs( resources ) do
                                append( "spec:RegisterResource( Enum.PowerType." .. k .. " )" )
                            end

                            append( "" )
                            append( "-- Talents" )
                            append( "spec:RegisterTalents( {" )
                            increaseIndent()

                            if Hekili.IsDragonflight() then
                                table.sort( talents, function( a, b ) return a.name < b.name end )
                                for i, tal in ipairs( talents ) do
                                    append( tal.name .. " = { " .. ( tal.talent or "nil" ) .. ", " .. ( tal.spell or "nil" ) .. " }," )
                                end
                            elseif Hekili.IsWrath() then
                                local maxlength = 0
                                skeletonHandler( listener, "PLAYER_TALENT_UPDATE" )
                                table.sort( talents, function( a, b )
                                    maxlength = max( maxlength, a.name:len(), b.name:len() )
                                    return a.name < b.name
                                end )

                                for i, tal in ipairs( talents ) do
                                    local fmt = "%-" .. maxlength .. "s = { %5d, %d"
                                    for i = 1, #ns.WrathTalentToSpellID[ tal.talent ] do
                                        fmt = fmt .. ", %5d"
                                    end
                                    fmt = fmt .. " },"

                                    append( format( fmt, tal.name, tal.talent, tal.ranks, unpack( ns.WrathTalentToSpellID[ tal.talent ] ) ) )
                                end
                            else

                                for i, tal in ipairs( talents ) do
                                    append( tal.name .. " = " .. ( tal.talent or "nil" ) .. ", -- " .. ( tal.spell or "nil" ) .. ( i % 3 == 0 and "\n" or "" ) )
                                end
                            end


                            decreaseIndent()
                            append( "} )\n\n" )

                            if not Hekili.IsWrath() then
                                append( "-- PvP Talents" )
                                append( "spec:RegisterPvpTalents( { " )
                                increaseIndent()

                                for i, tal in ipairs( pvptalents ) do
                                    append( tal.name .. " = " .. ( tal.talent or "nil" ) .. ", -- " .. ( tal.spell or "nil" ) )
                                end
                                decreaseIndent()
                                append( "} )\n\n" )
                            end

                            append( "-- Auras" )
                            append( "spec:RegisterAuras( {" )
                            increaseIndent()



                            if Hekili.IsWrath() then
                                local auraTokenToSpellIDs = {}

                                for k, v in pairs( auras ) do
                                    auraTokenToSpellIDs[ v ] = auraTokenToSpellIDs[ v ] or {}
                                    insert( auraTokenToSpellIDs[ v ], k )
                                end

                                for k, v in pairs( auraTokenToSpellIDs ) do
                                    sort( v, function( a, b ) return a > b end )

                                    append( k .. " = {" )
                                    increaseIndent()
                                    append( "id = " .. v[1] .. "," )
                                    if #v > 1 then
                                        local copies = "" .. v[2]

                                        for rank = 3, #v, 1 do
                                            copies = copies .. ", " .. v[rank]
                                        end

                                        append( "copy = { " .. copies .. " }," )
                                    end
                                    decreaseIndent()
                                    append( "}," )
                                end
                            else
                                for k, aura in orderedPairs( auras ) do
                                    append( k .. " = {" )
                                    increaseIndent()
                                    append( "id = " .. aura.id .. "," )

                                    for key, value in pairs( aura ) do
                                        if key ~= "id" then
                                            if type(value) == 'string' then
                                                append( key .. ' = "' .. value .. '",' )
                                            else
                                                append( key .. " = " .. value .. "," )
                                            end
                                        end
                                    end

                                    decreaseIndent()
                                    append( "}," )
                                end
                            end

                            decreaseIndent()
                            append( "} )\n\n" )


                            append( "-- Abilities" )
                            append( "spec:RegisterAbilities( {" )
                            increaseIndent()

                            local count = 1
                            for k, a in orderedPairs( abilities ) do
                                if count > 1 then append( "\n" ) end
                                count = count + 1
                                local desc = GetSpellDescription( a.id )
                                if desc then
                                    append( "-- " .. desc:gsub( "\r", " " ):gsub( "\n", " " ) )
                                end
                                append( k .. " = {" )
                                increaseIndent()
                                appendAttr( a, "id" )
                                appendAttr( a, "cast" )
                                appendAttr( a, "charges" )
                                appendAttr( a, "cooldown" )
                                appendAttr( a, "recharge" )
                                appendAttr( a, "gcd" )
                                append( "" )

                                for i, spend in ipairs( a.spend ) do
                                    append( "spend" .. ( i > 1 and i or "" ) .. " = " .. spend.cost .. "," )
                                    if spend.spendPerSec then
                                        append( "spend" .. ( i > 1 and i or "" ) .. "PerSec = " .. spend.spendPerSec .. "," )
                                    end
                                    append( "spend" .. ( i > 1 and i or "" ) .. "Type = \"" .. spend.spendType .. "\"," )
                                end
                                if #a.spend > 0 then
                                    append( "" )
                                end

                                if a.gain ~= nil then
                                    appendAttr( a, "gain" )
                                    appendAttr( a, "gainType" )
                                    append( "" )
                                end
                                appendAttr( a, "talent" )
                                appendAttr( a, "startsCombat" )
                                appendAttr( a, "texture" )
                                append( "" )
                                if a.cooldown >= 60 then append( "toggle = \"cooldowns\",\n" ) end
                                append( "handler = function ()" )

                                if a.applies or a.removes then
                                    increaseIndent()
                                    if a.applies then
                                        for name, id in pairs( a.applies ) do
                                            append( "-- applies " .. name .. " (" .. id .. ")" )
                                        end
                                    end
                                    if a.removes then
                                        for name, id in pairs( a.removes ) do
                                            append( "-- removes " .. name .. " (" .. id .. ")" )
                                        end
                                    end
                                    decreaseIndent()
                                end
                                append( "end," )
                                if a.copy then
                                    append( "" )
                                    local copy = ""
                                    for rank, spell in ipairs( a.copy ) do
                                        if rank > 1 then copy = copy .. ", " .. spell
                                        else copy = copy .. spell end
                                    end
                                    append( "copy = { " .. copy .. " }," )
                                end
                                decreaseIndent()
                                append( "}," )
                            end

                            decreaseIndent()
                            append( "} )" )
                        else
                            local aggregate = {}

                            if Hekili.IsWrath() then
                                for k,v in pairs( auras ) do
                                    aggregate[v .. "_" .. k] = {
                                        id = k,
                                        aura = "Yes",
                                        ability = "No",
                                        talent = "No"
                                    }
                                end
                            else
                                for k,v in pairs( auras ) do
                                    if not aggregate[k] then aggregate[k] = {} end
                                    aggregate[k].id = v.id
                                    aggregate[k].aura = true
                                end
                            end

                            for k,v in pairs( abilities ) do
                                if not aggregate[k] then aggregate[k] = {} end
                                aggregate[k].id = v.id
                                aggregate[k].ability = true
                            end

                            for k,v in pairs( talents ) do
                                if not aggregate[v.name] then aggregate[v.name] = {} end
                                aggregate[v.name].id = v.spell
                                aggregate[v.name].talent = true
                            end

                            for k,v in orderedPairs( aggregate ) do
                                if v.id then
                                    append( k .. "\t" .. v.id .. "\t" .. ( v.aura and "Yes" or "No" ) .. "\t" .. ( v.ability and "Yes" or "No" ) .. "\t" .. ( v.talent and "Yes" or "No" ) )
                                end
                            end
                        end

                        Hekili.Skeleton = table.concat( output, "\n" )
                    end,
                }
            },
            hidden = function()
                return not Hekili.Skeleton
            end,
        }

    end
end


do
    local selectedError = nil
    local errList = {}

    function Hekili:EmbedErrorOptions( db )
        db = db or self.Options
        if not db then return end

        db.args.errors = {
            type = "group",
            name = "警告信息",
            order = 99,
            args = {
                errName = {
                    type = "select",
                    name = "警告标签",
                    width = "full",
                    order = 1,

                    values = function()
                        wipe( errList )

                        for i, err in ipairs( self.ErrorKeys ) do
                            local eInfo = self.ErrorDB[ err ]

                            errList[ i ] = "[" .. eInfo.last .. " (" .. eInfo.n .. "x)] " .. err
                        end

                        return errList
                    end,

                    get = function() return selectedError end,
                    set = function( info, val ) selectedError = val end,
                },

                errorInfo = {
                    type = "input",
                    name = "警告信息",
                    width = "full",
                    multiline = 10,
                    order = 2,

                    get = function ()
                        if selectedError == nil then return "" end
                        return Hekili.ErrorKeys[ selectedError ]
                    end,

                    dialogControl = "HekiliCustomEditor",
                }
            },
            disabled = function() return #self.ErrorKeys == 0 end,
        }
    end
end


function Hekili:GenerateProfile()
    local s = state

    local spec = s.spec.key

    local talents
    for k, v in orderedPairs( s.talent ) do
        if v.enabled then
            if talents then talents = format( "%s\n    %s", talents, k )
            else talents = k end
        end
    end

    local pvptalents
    for k,v in orderedPairs( s.pvptalent ) do
        if v.enabled then
            if pvptalents then pvptalents = format( "%s\n   %s", pvptalents, k )
            else pvptalents = k end
        end
    end

    local covenants = { "kyrian", "necrolord", "night_fae", "venthyr" }
    local covenant = "none"
    local conduits
    local soulbinds

    if not Hekili.IsWrath() then
        for i, v in ipairs( covenants ) do
            if state.covenant[ v ] then covenant = v; break end
        end

        for k,v in orderedPairs( s.conduit ) do
            if v.enabled then
                if conduits then conduits = format( "%s\n   %s = %d", conduits, k, v.rank )
                else conduits = format( "%s = %d", k, v.rank ) end
            end
        end


        local activeBind = C_Soulbinds.GetActiveSoulbindID()
        if activeBind then
            soulbinds = "[" .. formatKey( C_Soulbinds.GetSoulbindData( activeBind ).name ) .. "]"
        end

        for k,v in orderedPairs( s.soulbind ) do
            if v.enabled then
                if soulbinds then soulbinds = format( "%s\n   %s = %d", soulbinds, k, v.rank )
                else soulbinds = format( "%s = %d", k, v.rank ) end
            end
        end
    end

    local sets
    for k, v in orderedPairs( class.gear ) do
        if s.set_bonus[ k ] > 0 then
            if sets then sets = format( "%s\n    %s = %d", sets, k, s.set_bonus[k] )
            else sets = format( "%s = %d", k, s.set_bonus[k] ) end
        end
    end

    local gear, items
    for k, v in orderedPairs( state.set_bonus ) do
        if v > 0 then
            if type(k) == 'string' then
            if gear then gear = format( "%s\n    %s = %d", gear, k, v )
            else gear = format( "%s = %d", k, v ) end
            elseif type(k) == 'number' then
                if items then items = format( "%s, %d", items, k )
                else items = tostring(k) end
            end
        end
    end

    local legendaries
    for k, v in orderedPairs( state.legendary ) do
        if k ~= "no_trait" and v.rank > 0 then
            if legendaries then legendaries = format( "%s\n    %s = %d", legendaries, k, v.rank )
            else legendaries = format( "%s = %d", k, v.rank ) end
        end
    end

    local settings
    if state.settings.spec then
        for k, v in orderedPairs( state.settings.spec ) do
            if type( v ) ~= "table" then
                if settings then settings = format( "%s\n    %s = %s", settings, k, tostring( v ) )
                else settings = format( "%s = %s", k, tostring( v ) ) end
            end
        end
        for k, v in orderedPairs( state.settings.spec.settings ) do
            if type( v ) ~= "table" then
                if settings then settings = format( "%s\n    %s = %s", settings, k, tostring( v ) )
                else settings = format( "%s = %s", k, tostring( v ) ) end
            end
        end
    end

    local toggles = ""
    for k, v in orderedPairs( self.DB.profile.toggles ) do
        if type( v ) == "table" and rawget( v, "value" ) ~= nil then
            toggles = format( "%s%s    %s = %s %s", toggles, toggles:len() > 0 and "\n" or "", k, tostring( v.value ), ( v.separate and "[separate]" or ( k ~= "cooldowns" and v.override and self.DB.profile.toggles.cooldowns.value and "[overridden]" ) or "" ) )
        end
    end

    local keybinds = ""
    local bindLength = 1

    for name in pairs( Hekili.KeybindInfo ) do
        if name:len() > bindLength then
            bindLength = name:len()
        end
    end

    for name, data in orderedPairs( Hekili.KeybindInfo ) do
        local action = format( "%-" .. bindLength .. "s =", name )
        local count = 0
        for i = 1, 12 do
            local bar = data.upper[ i ]
            if bar then
                if count > 0 then action = action .. "," end
                action = format( "%s %-4s[%02d]", action, bar, i )
                count = count + 1
            end
        end
        keybinds = keybinds .. "\n    " .. action
    end


    return format( "build: %s\n" ..
        "level: %d (%d)\n" ..
        "class: %s\n" ..
        "spec: %s\n\n" ..
        "talents: %s\n\n" ..
        "pvptalents: %s\n\n" ..
        "covenant: %s\n\n" ..
        "conduits: %s\n\n" ..
        "soulbinds: %s\n\n" ..
        "sets: %s\n\n" ..
        "gear: %s\n\n" ..
        "legendaries: %s\n\n" ..
        "itemIDs: %s\n\n" ..
        "settings: %s\n\n" ..
        "toggles: %s\n\n" ..
        "keybinds: %s\n\n",
        Hekili.Version or "no info",
        UnitLevel( 'player' ) or 0, UnitEffectiveLevel( 'player' ) or 0,
        class.file or "NONE",
        spec or "none",
        talents or "none",
        pvptalents or "none",
        covenant or "none",
        conduits or "none",
        soulbinds or "none",
        sets or "none",
        gear or "none",
        legendaries or "none",
        items or "none",
        settings or "none",
        toggles or "none",
        keybinds or "none" )
end



do
    local Options = {
        name = "Hekili " .. Hekili.Version,
        type = "group",
        handler = Hekili,
        get = 'GetOption',
        set = 'SetOption',
        childGroups = "tree",
        args = {
            general = {
                type = "group",
                name = "通用",
                order = 10,
                childGroups = "tab",
                args = {
                    enabled = {
                        type = "toggle",
                        name = "启用",
                        desc = "启用或禁用插件。",
                        order = 1
                    },

                    minimapIcon = {
                        type = "toggle",
                        name = "隐藏小地图图标",
                        desc = "如果勾选，小地图旁的图标将被隐藏。",
                        order = 2,
                    },

                    monitorPerformance = {
                        type = "toggle",
                        name = "性能监控",
                        desc = "如果勾选，插件将会监控事件的处理时间和数量。",
                        order = 3,
                        hidden = function()
                            return not Hekili.Version:match("Dev")
                        end,
                    },

                    welcome = {
                        type = 'description',
                        name = "",
                        fontSize = "medium",
                        image = "Interface\\Addons\\Hekili\\Textures\\Taco256",
                        imageWidth = 192,
                        imageHeight = 192,
                        order = 5,
                        width = "full"
                    },

                    supporters = {
                        type = "description",
                        name = function ()
                            return "|cFF00CCFF感谢我们的支持者！|r\n\n" .. ns.Patrons .. ".\n\n" ..
                                "若提交Bug报告，请访问 |cFFFFD100Issue Reporting|r 页面。\n\n"
                        end,
                        fontSize = "medium",
                        order = 6,
                        width = "full"
                    },

                    curse = {
                        type = "input",
                        name = "Curse",
                        order = 10,
                        get = function () return "https://www.curseforge.com/wow/addons/hekili" end,
                        set = function () end,
                        width = "full",
                        dialogControl = "SFX-Info-URL",
                    },

                    github = {
                        type = "input",
                        name = "GitHub",
                        order = 11,
                        get = function () return "https://github.com/Hekili/hekili/" end,
                        set = function () end,
                        width = "full",
                        dialogControl = "SFX-Info-URL",
                    },

                    simulationcraft = {
                        type = "input",
                        name = "SimC",
                        order = 12,
                        get = function () return "https://github.com/simulationcraft/simc/wiki" end,
                        set = function () end,
                        width = "full",
                        dialogControl = "SFX-Info-URL",
                    }
                }
            },


            --[[ gettingStarted = {
                type = "group",
                name = "Getting Started",
                order = 11,
                childGroups = "tree",
                args = {
                    q1 = {
                        type = "header",
                        name = "Moving the Displays",
                        order = 1,
                        width = "full"
                    },
                    a1 = {
                        type = "description",
                        name = "When these options are open, all displays are visible and can be moved by clicking and dragging.  You can move this options screen out of the way by clicking the |cFFFFD100Hekili|r title and dragging it out of the way.\n\n" ..
                            "You can also set precise X/Y positioning in the |cFFFFD100Displays|r section, on each display's |cFFFFD100Main|r tab.\n\n" ..
                            "You can also move the displays by typing |cFFFFD100/hek move|r in chat.  Type |cFFFFD100/hek move|r again to lock the displays.\n",
                        order = 1.1,
                        width = "full",
                    },

                    q2 = {
                        type = "header",
                        name = "Using Toggles",
                        order = 2,
                        width = "full",
                    },
                    a2 = {
                        type = "description",
                        name = "The addon has several |cFFFFD100Toggles|r available that help you control the type of recommendations you receive while in combat.  See the |cFFFFD100Toggles|r section for specifics.\n\n" ..
                            "|cFFFFD100Mode|r:  By default, |cFFFFD100Automatic Mode|r automatically detects how many targets you are engaged with, and gives recommendations based on the number of targets detected.  In some circumstances, you may want the addon to pretend there is only 1 target, or that there are multiple targets, " ..
                            "or show recommendations for both scenarios.  You can use the |cFFFFD100Mode|r toggle to swap between Automatic, Single-Target, AOE, and Reactive modes.\n\n" ..
                            "|cFFFFD100Abilities|r:  Some of your abilities can be controlled by specific toggles.  For example, your major DPS cooldowns are assigned to the |cFFFFD100Cooldowns|r toggle.  This feature allows you to enable/disable these abilities in combat by using the assigned keybinding.  You can add abilities to (or remove abilities from) " ..
                            "these toggles in the |cFFFFD100Abilities|r or |cFFFFD100Gear and Trinkets|r sections.  When removed from a toggle, an ability can be recommended at any time, regardless of whether that toggle is on or off.\n\n" ..
                            "|cFFFFD100Displays|r:  Your Interrupts, Defensives, and Cooldowns toggles have a special relationship with the displays of the same names.  If |cFFFFD100Show Separately|r is checked for that toggle, those abilities will show in that toggle's display instead of the |cFFFFD100Primary|r or |cFFFFD100AOE|r display.\n",
                        order = 2.1,
                        width = "full",
                    },

                    q3 = {
                        type = "header",
                        name = "Importing a Profile",
                        order = 3,
                        width = "full",
                    },
                    a3 = {
                        type = "description",
                        name = "|cFFFF0000You do not need to import a SimulationCraft profile to use this addon.|r\n\n" ..
                            "Before trying to import a profile, please consider the following:\n\n" ..
                            " - SimulationCraft action lists tend not to change significantly for individual characters.  The profiles are written to include conditions that work for all gear, talent, and other factors combined.\n\n" ..
                            " - Most SimulationCraft action lists require some additional customization to work with the addon.  For example, |cFFFFD100target_if|r conditions don't translate directly to the addon and have to be rewritten.\n\n" ..
                            " - Some SimulationCraft action profiles are revised for the addon to be more efficient and use less processing time.\n\n" ..
                            "The default priorities included within the addon are kept up to date, are compatible with your character, and do not require additional changes.  |cFFFF0000No support is offered for custom or imported priorities from elsewhere.|r\n",
                        order = 3.1,
                        width = "full",
                    },

                    q4 = {
                        type = "header",
                        name = "Something's Wrong",
                        order = 4,
                        width = "full",
                    },
                    a4 = {
                        type = "description",
                        name = "You can submit questions, concerns, and ideas via the link found in the |cFFFFD100Issue Reporting|r section.\n\n" ..
                            "If you disagree with the addon's recommendations, the |cFFFFD100Snapshot|r feature allows you to capture a log of the addon's decision-making taken at the exact moment specific recommendations are shown.  " ..
                            "When you submit your question, be sure to take a snapshot (not a screenshot!), place the text on Pastebin, and include the link when you submit your issue ticket.",
                        order = 4.1,
                        width = "full",
                    }
                }
            }, ]]

            abilities = {
                type = "group",
                name = "技能",
                order = 80,
                childGroups = "select",
                args = {
                    spec = {
                        type = "select",
                        name = "职业专精",
                        desc = "这些选项对应你当前选择的职业专精。",
                        order = 0.1,
                        width = "full",
                        set = SetCurrentSpec,
                        get = GetCurrentSpec,
                        values = GetCurrentSpecList,
                    },
                },
                plugins = {
                    actions = {}
                }
            },

            items = {
                type = "group",
                name = "装备和饰品",
                order = 81,
                childGroups = "select",
                args = {
                    spec = {
                        type = "select",
                        name = "职业专精",
                        desc = "这些选项对应你当前选择的职业专精。",
                        order = 0.1,
                        width = "full",
                        set = SetCurrentSpec,
                        get = GetCurrentSpec,
                        values = GetCurrentSpecList,
                    },
                },
                plugins = {
                    equipment = {}
                }
            },

            issues = {
                type = "group",
                name = "报告问题",
                order = 85,
                args = {
                    header = {
                        type = "description",
                        name = "如果你发现了插件的技术问题，请通过下面的链接提交问题报告。" ..
                        "提交报告时，需要包含你的职业专精、职业专精、盟约和装备，下方文字可方便地复制和粘贴。" ..
                        "如果你提交对插件的建议，最好能提供快照（其中将包含以上信息）。",
                        order = 10,
                        fontSize = "medium",
                        width = "full",
                    },
                    profile = {
                        type = "input",
                        name = "角色信息数据",
                        order = 20,
                        width = "full",
                        multiline = 10,
                        get = 'GenerateProfile',
                        set = function () end,
                    },
                    link = {
                        type = "input",
                        name = "链接",
                        order = 30,
                        width = "full",
                        get = function() return "http://github.com/Hekili/hekili/issues" end,
                        set = function() end,
                        dialogControl = "SFX-Info-URL"
                    },
                }
            },

            snapshots = {
                type = "group",
                name = "快照",
                order = 86,
                args = {
                    autoSnapshot = {
                        type = "toggle",
                        name = "自动快照",
                        desc = "如果勾选，插件将在推荐技能失败时自动创建快照。\n\n" ..
                        "自动快照每次战斗只能创建一次。",
                        order = 1,
                        width = "full",
                    },

                    screenshot = {
                        type = "toggle",
                        name = "屏幕截图",
                        desc = "如果勾选，当你手动创建快照时，也将创建一张屏幕截图。\n\n" ..
                        "将这两个文件与问题报告一起提交，对为修正问题提供有用的信息。",
                        order = 2,
                        width = "full",
                    },

                    prefHeader = {
                        type = "header",
                        name = "快照/疑难解答",
                        order = 2.5,
                        width = "full"
                    },

                    header = {
                        type = "description",
                        name = function()
                            return "快照是插件对一组技能进行推荐的决策过程的日志。如果你对插件的推荐技能有疑问，可通过查看快照确认推荐给你的具体原因。" ..
                            "\n\n" ..                            
                            "快照只会捕获特定时间点的信息，因此你必须在看到推荐技能时创建快照。" ..
                            "你可以通过使用|cffffd100创建快照|r快捷键（|cffffd100" .. ( Hekili.DB.profile.toggles.snapshot.key or "尚未绑定" ) .. "|r）快速创建快照。\n\n" ..
                            "你还可以使用|cffffd100暂停|r快捷键（|cffffd100" .. ( Hekili.DB.profile.toggles.pause.key or "尚未绑定" ) .. "|r）冻结插件当前的推荐技能。" ..
                            "暂停后你可以鼠标悬停在显示框上，查看这些推荐技能的条件。再次按下暂停可以让插件继续运行。\n\n" ..
                            "最后，使用本页顶部的设置，你可以让插件在没有正确推荐技能时自动生成快照。\n"
                        end,
                        fontSize = "medium",
                        order = 10,
                        width = "full",
                    },

                    SnapID = {
                        type = "select",
                        name = "选择快照",
                        desc = "选择要导出的快照。",
                        values = function( info )
                            if #ns.snapshots == 0 then
                                snapshots.snaps[ 0 ] = "未生成任何快照。"
                            else
                                snapshots.snaps[ 0 ] = nil
                                for i, snapshot in ipairs( ns.snapshots ) do
                                    snapshots.snaps[ i ] = "|cFFFFD100" .. i .. ".|r " .. snapshot.header
                                end
                            end

                            return snapshots.snaps
                        end,
                        set = function( info, val )
                            snapshots.selected = val
                        end,
                        get = function( info )
                            return snapshots.selected
                        end,
                        order = 12,
                        width = "full",
                        disabled = function() return #ns.snapshots == 0 end,
                    },

                    Snapshot = {
                        type = 'input',
                        name = "导出快照",
                        desc = "点击此处后依次按下CTRL+A、CTRL+C复制快照。\n\n粘贴到文本编辑器后查看或者上传问题回报网站。",
                        order = 20,
                        get = function( info )
                            if snapshots.selected == 0 then return "" end
                            return ns.snapshots[ snapshots.selected ].log
                        end,
                        set = function() end,
                        width = "full",
                        hidden = function() return snapshots.selected == 0 or #ns.snapshots == 0 end,
                    },
                }
            },
        },

        plugins = {
            specializations = {},
        }
    }

    function Hekili:GetOptions()
        self:EmbedToggleOptions( Options )

        --[[ self:EmbedDisplayOptions( Options )

        self:EmbedPackOptions( Options )

        self:EmbedAbilityOptions( Options )

        self:EmbedItemOptions( Options )

        self:EmbedSpecOptions( Options ) ]]

        self:EmbedSkeletonOptions( Options )

        self:EmbedErrorOptions( Options )

        Hekili.OptionsReady = false

        return Options
    end
end


function Hekili:TotalRefresh( noOptions )
    if Hekili.PLAYER_ENTERING_WORLD then
        self:SpecializationChanged()
        self:RestoreDefaults()
    end

    for i, queue in pairs( ns.queue ) do
        for j, _ in pairs( queue ) do
            ns.queue[ i ][ j ] = nil
        end
        ns.queue[ i ] = nil
    end

    callHook( "onInitialize" )

    for specID, spec in pairs( class.specs ) do
        if specID > 0 then
            local options = self.DB.profile.specs[ specID ]

            for k, v in pairs( spec.options ) do
                if rawget( options, k ) == nil then options[ k ] = v end
            end
        end
    end

    self:RunOneTimeFixes()
    ns.checkImports()

    -- self:LoadScripts()
    if Hekili.OptionsReady then
        if Hekili.Config then
            self:RefreshOptions()
            ACD:SelectGroup( "Hekili", "profiles" )
        else Hekili.OptionsReady = false end
    end
    self:UpdateDisplayVisibility()
    self:BuildUI()

    self:OverrideBinds()

    -- LibStub("LibDBIcon-1.0"):Refresh( "Hekili", self.DB.profile.iconStore )

    if WeakAuras and WeakAuras.ScanEvents then
        for name, toggle in pairs( Hekili.DB.profile.toggles ) do
            WeakAuras.ScanEvents( "HEKILI_TOGGLE", name, toggle.value )
        end
    end

    if ns.UI.Minimap then ns.UI.Minimap:RefreshDataText() end
end


function Hekili:RefreshOptions()
    if not self.Options then return end

    self:EmbedDisplayOptions()
    self:EmbedPackOptions()
    self:EmbedSpecOptions()
    self:EmbedAbilityOptions()
    self:EmbedItemOptions()

    Hekili.OptionsReady = true

    -- Until I feel like making this better at managing memory.
    collectgarbage()
end


function Hekili:GetOption( info, input )
    local category, depth, option = info[1], #info, info[#info]
    local profile = Hekili.DB.profile

    if category == 'general' then
        return profile[ option ]

    elseif category == 'bindings' then

        if option:match( "TOGGLE" ) or option == "HEKILI_SNAPSHOT" then
            return select( 1, GetBindingKey( option ) )

        elseif option == 'Pause' then
            return self.Pause

        else
            return profile[ option ]

        end

    elseif category == 'displays' then

        -- This is a generic display option/function.
        if depth == 2 then
            return nil

            -- This is a display (or a hook).
        else
            local dispKey, dispID = info[2], tonumber( match( info[2], "^D(%d+)" ) )
            local hookKey, hookID = info[3], tonumber( match( info[3] or "", "^P(%d+)" ) )
            local display = profile.displays[ dispID ]

            -- This is a specific display's settings.
            if depth == 3 or not hookID then

                if option == 'x' or option == 'y' then
                    return tostring( display[ option ] )

                elseif option == 'spellFlashColor' or option == 'iconBorderColor' then
                    if type( display[option] ) ~= 'table' then display[option] = { r = 1, g = 1, b = 1, a = 1 } end
                    return display[option].r, display[option].g, display[option].b, display[option].a

                elseif option == 'Copy To' or option == 'Import' then
                    return nil

                else
                    return display[ option ]

                end

                -- This is a priority hook.
            else
                local hook = display.Queues[ hookID ]

                if option == 'Move' then
                    return hookID

                else
                    return hook[ option ]

                end

            end

        end

    elseif category == 'actionLists' then

        -- This is a general action list option.
        if depth == 2 then
            return nil

        else
            local listKey, listID = info[2], tonumber( match( info[2], "^L(%d+)" ) )
            local actKey, actID = info[3], tonumber( match( info[3], "^A(%d+)" ) )
            local list = listID and profile.actionLists[ listID ]

            -- This is a specific action list.
            if depth == 3 or not actID then
                return list[ option ]

                -- This is a specific action.
            elseif listID and actID then
                local action = list.Actions[ actID ]

                if option == 'ConsumableArgs' then option = 'Args' end

                if option == 'Move' then
                    return actID

                else
                    return action[ option ]

                end

            end

        end

    elseif category == "snapshots" then
        return profile[ option ]
    end

    ns.Error( "GetOption() - should never see." )

end


local getUniqueName = function( category, name )
    local numChecked, suffix, original = 0, 1, name

    while numChecked < #category do
        for i, instance in ipairs( category ) do
            if name == instance.Name then
                name = original .. ' (' .. suffix .. ')'
                suffix = suffix + 1
                numChecked = 0
            else
                numChecked = numChecked + 1
            end
        end
    end

    return name
end


function Hekili:SetOption( info, input, ... )
    local category, depth, option = info[1], #info, info[#info]
    local Rebuild, RebuildUI, RebuildScripts, RebuildOptions, RebuildCache, Select
    local profile = Hekili.DB.profile

    if category == 'general' then
        -- We'll preset the option here; works for most options.
        profile[ option ] = input

        if option == 'enabled' then
            for i, buttons in ipairs( ns.UI.Buttons ) do
                for j, _ in ipairs( buttons ) do
                    if input == false then
                        buttons[j]:Hide()
                    else
                        buttons[j]:Show()
                    end
                end
            end

            if input == true then self:Enable()
            else self:Disable() end

            return

        elseif option == 'minimapIcon' then
            profile.iconStore.hide = input

            if LDBIcon then
                if input then
                    LDBIcon:Hide( "Hekili" )
                else
                    LDBIcon:Show( "Hekili" )
                end
            end

        elseif option == 'Audit Targets' then
            return

        end

        -- General options do not need add'l handling.
        return

    elseif category == 'bindings' then

        local revert = profile[ option ]
        profile[ option ] = input

        if option:match( "TOGGLE" ) or option == "HEKILI_SNAPSHOT" then
            if GetBindingKey( option ) then
                SetBinding( GetBindingKey( option ) )
            end
            SetBinding( input, option )
            SaveBindings( GetCurrentBindingSet() )

        elseif option == 'Mode' then
            profile[option] = revert
            self:ToggleMode()

        elseif option == 'Pause' then
            profile[option] = revert
            self:TogglePause()
            return

        elseif option == 'Cooldowns' then
            profile[option] = revert
            self:ToggleCooldowns()
            return

        elseif option == 'Artifact' then
            profile[option] = revert
            self:ToggleArtifact()
            return

        elseif option == 'Potions' then
            profile[option] = revert
            self:TogglePotions()
            return

        elseif option == 'Hardcasts' then
            profile[option] = revert
            self:ToggleHardcasts()
            return

        elseif option == 'Interrupts' then
            profile[option] = revert
            self:ToggleInterrupts()
            return

        elseif option == 'Switch Type' then
            if input == 0 then
                if profile['Mode Status'] == 1 or profile['Mode Status'] == 2 then
                    -- Check that the current mode is supported.
                    profile['Mode Status'] = 0
                    self:Print("快捷键已更新；恢复到单目标。")
                end
            elseif input == 1 then
                if profile['Mode Status'] == 1 or profile['Mode Status'] == 3 then
                    profile['Mode Status'] = 0
                    self:Print("快捷键已更新；恢复到单目标。")
                end
            end

        elseif option == 'Mode Status' or option:match("Toggle_") or option == 'BloodlustCooldowns' or option == 'CooldownArtifact' then
            -- do nothing, we're good.

        else -- Toggle Names.
            if input:trim() == "" then
                profile[ option ] = nil
            end

        end

        -- Bindings do not need add'l handling.
        return



    elseif category == 'actionLists' then

        if depth == 2 then

            if option == 'New Action List' then
                local key = ns.newActionList( input )
                if key then
                    RebuildOptions, RebuildCache = true, true
                end

            elseif option == 'Import Action List' then
                local import = ns.deserializeActionList( input )

                if not import or type( import ) == 'string' then
                    Hekili:Print("无法从当前输入的字符串导入。")
                    return
                end

                import.Name = getUniqueName( profile.actionLists, import.Name )
                profile.actionLists[ #profile.actionLists + 1 ] = import
                Rebuild = true

            end

        else
            local listKey, listID = info[2], info[2] and tonumber( match( info[2], "^L(%d+)" ) )
            local actKey, actID = info[3], info[3] and tonumber( match( info[3], "^A(%d+)" ) )
            local list = profile.actionLists[ listID ]

            if depth == 3 or not actID then

                local revert = list[ option ]
                list[option] = input

                if option == 'Name' then
                    Hekili.Options.args.actionLists.args[ listKey ].name = input
                    if input ~= revert and list.Default then list.Default = false end

                elseif option == 'Enabled' or option == 'Specialization' then
                    RebuildCache = true

                elseif option == 'Script' then
                    list[ option ] = input:trim()
                    RebuildScripts = true

                    -- Import/Exports
                elseif option == 'Copy To' then
                    list[option] = nil

                    local index = #profile.actionLists + 1

                    profile.actionLists[ index ] = tableCopy( list )
                    profile.actionLists[ index ].Name = input
                    profile.actionLists[ index ].Default = false

                    Rebuild = true

                elseif option == 'Import Action List' then
                    list[option] = nil

                    local import = ns.deserializeActionList( input )

                    if not import or type( import ) == 'string' then
                        Hekili:Print("无法从当前的导入字符串导入。")
                        return
                    end

                    import.Name = list.Name
                    remove( profile.actionLists, listID )
                    insert( profile.actionLists, listID, import )
                    -- profile.actionLists[ listID ] = import
                    Rebuild = true

                elseif option == 'SimulationCraft' then
                    list[option] = nil

                    local import, warnings = self:ImportSimulationCraftActionList( input )

                    if warnings then
                        Hekili:Print( "|cFFFF0000警告：|r\n在导入技能列表时发生以下问题。" )
                        for i = 1, #warnings do
                            Hekili:Print( warnings[i] )
                        end
                    end

                    if not import then
                        Hekili:Print( "未成功导入任何指令。" )
                        return
                    end

                    wipe( list.Actions )

                    for i, entry in ipairs( import ) do

                        local key = ns.newAction( listID, class.abilities[ entry.Ability ].name )

                        local action = list.Actions[ i ]

                        action.Ability = entry.Ability
                        action.Args = entry.Args

                        action.CycleTargets = entry.CycleTargets
                        action.MaximumTargets = entry.MaximumTargets
                        action.CheckMovement = entry.CheckMovement or false
                        action.Movement = entry.Movement
                        action.ModName = entry.ModName or ''
                        action.ModVarName = entry.ModVarName or ''

                        action.Indicator = 'none'

                        action.Script = entry.Script
                        action.Enabled = true
                    end

                    Rebuild = true

                end

                -- This is a specific action.
            else
                local list = profile.actionLists[ listID ]
                local action = list.Actions[ actID ]

                action[ option ] = input

                if option == 'Name' then
                    Hekili.Options.args.actionLists.args[ listKey ].args[ actKey ].name = '|cFFFFD100' .. actID .. '.|r ' .. input

                elseif option == 'Enabled' then
                    RebuildCache = true

                elseif option == 'Move' then
                    action[ option ] = nil
                    local placeholder = remove( list.Actions, actID )
                    insert( list.Actions, input, placeholder )
                    Rebuild, Select = true, 'A'..input

                elseif option == 'Script' or option == 'Args' then
                    input = input:trim()
                    RebuildScripts = true

                elseif option == 'ReadyTime' then
                    list[ option ] = input:trim()
                    RebuildScripts = true

                elseif option == 'ConsumableArgs' then
                    action[ option ] = nil
                    action.Args = input
                    RebuildScripts = true

                end

            end
        end
    elseif category == "snapshots" then
        profile[ option ] = input
    end

    if Rebuild then
        ns.refreshOptions()
        ns.loadScripts()
        QueueRebuildUI()
    else
        if RebuildOptions then ns.refreshOptions() end
        if RebuildScripts then ns.loadScripts() end
        if RebuildCache and not RebuildUI then Hekili:UpdateDisplayVisibility() end
        if RebuildUI then QueueRebuildUI() end
    end

    if ns.UI.Minimap then ns.UI.Minimap:RefreshDataText() end

    if Select then
        LibStub( "AceConfigDialog-3.0" ):SelectGroup( "Hekili", category, info[2], Select )
    end

end



do
    local validCommands = {
        makedefaults = true,
        import = true,
        skeleton = true,
        recover = true,
        center = true,

        profile = true,
        set = true,
        enable = true,
        disable = true,
        move = true,
        unlock = true,
        lock = true,
        dotinfo = true,
    }

    local toggleToIndex = {
        cooldowns = 51,
        interrupts = 52,
        potions = 53,
        defensives = 54,
        covenants = 55,
        custom1 = 56,
        custom2 = 57,
    }

    local indexToToggle = {
        [51] = { "cooldowns", "Cooldowns" },
        [52] = { "interrupts", "Interrupts" },
        [53] = { "potions", "Potions" },
        [54] = { "defensives", "Defensives" },
        [55] = { "essences", "Covenants" },
        [56] = { "custom1", "Custom #1" },
        [57] = { "custom2", "Custom #2" },
    }

    local toggleInstructions = {
        "on|r (to enable)",
        "off|r (to disable)",
        "|r (to toggle)",
    }

    local info = {}
    local priorities = {}

    local function countPriorities()
        wipe( priorities )

        local spec = state.spec.id

        for priority, data in pairs( Hekili.DB.profile.packs ) do
            if data.spec == spec then
                insert( priorities, priority )
            end
        end

        sort( priorities )

        return #priorities
    end

    function Hekili:CmdLine( input )
        if not input or input:trim() == "" or input:trim() == "skeleton" then
            if input:trim() == 'skeleton' then
                self:StartListeningForSkeleton()
                self:Print( "插件现在将开始采集职业专精信息。选择所有职业专精并使用所有技能以获得最佳效果。" )
                self:Print( "更多的详细信息，请参见骨骼页面。")
                Hekili.Skeleton = ""
            end

            ns.StartConfiguration()
            return

        elseif input:trim() == "recover" then
            local defaults = self:GetDefaults()

            for k, v in pairs( self.DB.profile.displays ) do
                local default = defaults.profile.displays[ k ]
                if defaults.profile.displays[ k ] then
                    for key, value in pairs( default ) do
                        if type( value ) == "table" then v[ key ] = tableCopy( value )
                        else v[ key ] = value end

                        if type( value ) == "table" then
                            for innerKey, innerValue in pairs( value ) do
                                if v[ key ][ innerKey ] == nil then
                                    if type( innerValue ) == "table" then v[ key ][ innerKey ] = tableCopy( innerValue )
                                    else v[ key ][ innerKey ] = innerValue end
                                end
                            end
                        end
                    end

                    for key, value in pairs( self.DB.profile.displays["**"] ) do
                        if type( value ) == "table" then v[ key ] = tableCopy( value )
                        else v[ key ] = value end

                        if type( value ) == "table" then
                            for innerKey, innerValue in pairs( value ) do
                                if v[ key ][ innerKey ] == nil then
                                    if type( innerValue ) == "table" then v[ key ][ innerKey ] = tableCopy( innerValue )
                                    else v[ key ][ innerKey ] = innerValue end
                                end
                            end
                        end
                    end
                end
            end
            self:RestoreDefaults()
            self:RefreshOptions()
            self:BuildUI()
            self:Print("已恢复默认的显示框和技能列表。")
            return

        end

        if input then
            input = input:trim()
            local args = {}

            for arg in string.gmatch( input, "%S+" ) do
                insert( args, lower( arg ) )
            end

            if ( "set" ):match( "^" .. args[1] ) then
                local profile = Hekili.DB.profile
                local spec = profile.specs[ state.spec.id ]
                local prefs = spec.settings
                local settings = class.specs[ state.spec.id ].settings

                local index

                if args[2] then
                    if ( "target_swap" ):match( "^" .. args[2] ) or ( "swap" ):match( "^" .. args[2] ) or ( "cycle" ):match( "^" .. args[2] ) then
                        index = -1
                    elseif ( "mode" ):match( "^" .. args[2] ) then
                        index = -2
                    elseif ( "priority" ):match( "^" .. args[2] ) then
                        index = -3
                    else
                        for i, setting in ipairs( settings ) do
                            if setting.name:match( "^" .. args[2] ) then
                                index = i
                                break
                            end
                        end

                        if not index then
                            -- Check toggles instead.
                            for toggle, num in pairs( toggleToIndex ) do
                                if toggle:match( "^" .. args[2] ) then
                                    index = num
                                    break
                                end
                            end
                        end
                    end
                end

                if #args == 1 or not index then
                    -- No arguments, list options.
                    local output = "Use |cFFFFD100/hekili set|r to adjust your specialization options via chat or macros.\n\nOptions for " .. state.spec.name .. " are:"

                    local hasToggle, hasNumber = false, false
                    local exToggle, exNumber

                    for i, setting in ipairs( settings ) do
                        if not setting.info.arg or setting.info.arg() then
                            if setting.info.type == "toggle" then
                                output = format( "%s\n - |cFFFFD100%s|r = %s|r (%s)", output, setting.name, prefs[ setting.name ] and "|cFF00FF00ON" or "|cFFFF0000OFF", setting.info.name )
                                hasToggle = true
                                exToggle = setting.name
                            elseif setting.info.type == "range" then
                                output = format( "%s\n - |cFFFFD100%s|r = |cFF00FF00%.2f|r, min: %.2f, max: %.2f (%s)", output, setting.name, prefs[ setting.name ], ( setting.info.min and format( "%.2f", setting.info.min ) or "N/A" ), ( setting.info.max and format( "%.2f", setting.info.max ) or "N/A" ), setting.info.name )
                                hasNumber = true
                                exNumber = setting.name
                            end
                        end
                    end

                    output = format( "%s\n - |cFFFFD100cycle|r, |cFFFFD100swap|r, or |cFFFFD100target_swap|r = %s|r (%s)", output, spec.cycle and "|cFF00FF00ON" or "|cFFFF0000OFF", "Recommend Target Swaps" )

                    output = format( "%s\n\nTo control your toggles (|cFFFFD100cooldowns|r, |cFFFFD100covenants|r, |cFFFFD100defensives|r, |cFFFFD100interrupts|r, |cFFFFD100potions|r, |cFFFFD100custom1|r, and |cFFFFD100custom2|r):\n" ..
                        " - Enable Cooldowns:  |cFFFFD100/hek set cooldowns on|r\n" ..
                        " - Disable Interrupts:  |cFFFFD100/hek set interupts off|r\n" ..
                        " - Toggle Defensives:  |cFFFFD100/hek set defensives|r", output )

                    output = format( "%s\n\nTo control your display mode (currently |cFFFFD100%s|r):\n - Toggle Mode:  |cFFFFD100/hek set mode|r\n - Set Mode:  |cFFFFD100/hek set mode aoe|r (or |cFFFFD100automatic|r, |cFFFFD100single|r, |cFFFFD100dual|r, |cFFFFD100reactive|r)", output, self.DB.profile.toggles.mode.value or "unknown" )

                    if hasToggle then
                        output = format( "%s\n\nTo set a |cFFFFD100specialization toggle|r, use the following commands:\n" ..
                            " - Toggle On/Off:  |cFFFFD100/hek set %s|r\n" ..
                            " - Enable:  |cFFFFD100/hek set %s on|r\n" ..
                            " - Disable:  |cFFFFD100/hek set %s off|r\n" ..
                            " - Reset to Default:  |cFFFFD100/hek set %s default|r", output, exToggle, exToggle, exToggle, exToggle )
                    end

                    if hasNumber then
                        output = format( "%s\n\nTo set a |cFFFFD100number|r value, use the following commands:\n" ..
                            " - Set to #:  |cFFFFD100/hek set %s #|r\n" ..
                            " - Reset to Default:  |cFFFFD100/hek set %s default|r", output, exNumber, exNumber )
                    end

                    Hekili:Print( output )
                    return
                end

                local toggle = indexToToggle[ index ]

                if toggle then
                    local tab, text, to = toggle[ 1 ], toggle[ 2 ]

                    if args[3] then
                        if args[3] == "on" then to = true
                        elseif args[3] == "off" then to = false
                        elseif args[3] == "default" then to = false
                        else
                            Hekili:Print( format( "'%s' is not a valid option for |cFFFFD100%s|r.", args[3], text ) )
                            return
                        end
                    else
                        to = not profile.toggles[ tab ].value
                    end

                    Hekili:Print( format( "|cFFFFD100%s|r toggle set to %s.", text, ( to and "|cFF00FF00ON|r" or "|cFFFF0000OFF|r" ) ) )

                    profile.toggles[ tab ].value = to

                    Hekili:ForceUpdate( "HEKILI_TOGGLE", tab )
                    return
                end

                -- Two or more arguments, we're setting (or querying).
                if index == -1 then
                    local to

                    if args[3] then
                        if args[3] == "on" then to = true
                        elseif args[3] == "off" then to = false
                        elseif args[3] == "default" then to = false
                        else
                            Hekili:Print( format( "'%s' is not a valid option for |cFFFFD100%s|r.", args[3] ) )
                            return
                        end
                    else
                        to = not spec.cycle
                    end

                    Hekili:Print( format( "Recommend Target Swaps set to %s.", ( to and "|cFF00FF00ON|r" or "|cFFFF0000OFF|r" ) ) )

                    spec.cycle = to

                    Hekili:ForceUpdate( "CLI_TOGGLE" )
                    return
                elseif index == -2 then
                    if args[3] then
                        Hekili:SetMode( args[3] )
                    else
                        Hekili:FireToggle( "mode" )
                    end
                    return
                end

                local setting = settings[ index ]

                if setting.info.type == "toggle" then
                    local to

                    if args[3] then
                        if args[3] == "on" then to = true
                        elseif args[3] == "off" then to = false
                        elseif args[3] == "default" then to = setting.default
                        else
                            Hekili:Print( format( "'%s' is not a valid option for |cFFFFD100%s|r.", args[3] ) )
                            return
                        end
                    else
                        to = not setting.info.get( info )
                    end

                    Hekili:Print( format( "%s set to %s.", setting.info.name, ( to and "|cFF00FF00ON|r" or "|cFFFF0000OFF|r" ) ) )

                    info[ 1 ] = setting.name
                    setting.info.set( info, to )

                    Hekili:ForceUpdate( "CLI_TOGGLE" )
                    return

                elseif setting.info.type == "range" then
                    local to

                    if args[3] == "default" then
                        to = setting.default
                    else
                        to = tonumber( args[3] )
                    end

                    if to and ( ( setting.info.min and to < setting.info.min ) or ( setting.info.max and to > setting.info.max ) ) then
                        Hekili:Print( format( "The value for %s must be between %s and %s.", args[2], ( setting.info.min and format( "%.2f", setting.info.min ) or "N/A" ), ( setting.info.max and format( "%.2f", setting.info.max ) or "N/A" ) ) )
                        return
                    end

                    if not to then
                        Hekili:Print( format( "You must provide a number value for %s (or default).", args[2] ) )
                        return
                    end

                    Hekili:Print( format( "%s set to |cFF00B4FF%.2f|r.", setting.info.name, to ) )
                    prefs[ setting.name ] = to
                    Hekili:ForceUpdate( "CLI_NUMBER" )
                    return

                end


            elseif ( "profile" ):match( "^" .. args[1] ) then
                if not args[2] then
                    local output = "Use |cFFFFD100/hekili profile name|r to swap profiles via command-line or macro.\nValid profile |cFFFFD100name|rs are:"

                    for name, prof in ns.orderedPairs( Hekili.DB.profiles ) do
                        output = format( "%s\n - |cFFFFD100%s|r %s", output, name, Hekili.DB.profile == prof and "|cFF00FF00(current)|r" or "" )
                    end

                    output = format( "%s\nTo create a new profile, see |cFFFFD100/hekili|r > |cFFFFD100Profiles|r.", output )

                    Hekili:Print( output )
                    return
                end

                local profileName = input:match( "%s+(.+)$" )

                if not rawget( Hekili.DB.profiles, profileName ) then
                    local output = format( "'%s' is not a valid profile name.\nValid profile |cFFFFD100name|rs are:", profileName )

                    local count = 0

                    for name, prof in ns.orderedPairs( Hekili.DB.profiles ) do
                        count = count + 1
                        output = format( "%s\n - |cFFFFD100%s|r %s", output, name, Hekili.DB.profile == prof and "|cFF00FF00(current)|r" or "" )
                    end

                    output = format( "%s\n\nTo create a new profile, see |cFFFFD100/hekili|r > |cFFFFD100Profiles|r.", output )

                    Hekili:Notify( output )
                    return
                end

                Hekili:Print( format( "Set profile to |cFF00FF00%s|r.", profileName ) )
                self.DB:SetProfile( profileName )
                return

            elseif ( "priority" ):match( "^" .. args[1] ) then
                local n = countPriorities()

                if not args[2] then
                    local output = "Use |cFFFFD100/hekili priority name|r to change your current specialization's priority via command-line or macro."

                    if n < 2 then
                        output = output .. "\n\n|cFFFF0000You must have multiple priorities for your specialization to use this feature.|r"
                    else
                        output = output .. "\nValid priority |cFFFFD100name|rs are:"
                        for i, priority in ipairs( priorities ) do
                            output = format( "%s\n - %s%s|r %s", output, Hekili.DB.profile.packs[ priority ].builtIn and BlizzBlue or "|cFFFFD100", priority, Hekili.DB.profile.specs[ state.spec.id ].package == priority and "|cFF00FF00(current)|r" or "" )
                        end
                    end

                    output = format( "%s\n\nTo create a new priority, see |cFFFFD100/hekili|r > |cFFFFD100Priorities|r.", output )

                    if Hekili.DB.profile.notifications.enabled then Hekili:Notify( output ) end
                    Hekili:Print( output )
                    return
                end

                -- Setting priority via commandline.
                -- Requires multiple priorities loaded for one's specialization.
                -- This also prepares the priorities table with relevant priority names.

                if n < 2 then
                    Hekili:Print( "要使用此功能，你的职业专精下必须具有多个优先级配置。" )
                    return
                end

                if not args[2] then
                    local output = "你必须提供优先级配置的名称（区分大小写）。\n有效选项是"
                    for i, priority in ipairs( priorities ) do
                        output = output .. format( " %s%s|r%s", Hekili.DB.profile.packs[ priority ].builtIn and BlizzBlue or "|cFFFFD100", priority, i == #priorities and "." or "," )
                    end
                    Hekili:Print( output )
                    return
                end

                local raw = input:match( "^%S+%s+(.+)$" )
                local name = raw:gsub( "%%", "%%%%" ):gsub( "^%^", "%%^" ):gsub( "%$$", "%%$" ):gsub( "%(", "%%(" ):gsub( "%)", "%%)" ):gsub( "%.", "%%." ):gsub( "%[", "%%[" ):gsub( "%]", "%%]" ):gsub( "%*", "%%*" ):gsub( "%+", "%%+" ):gsub( "%-", "%%-" ):gsub( "%?", "%%?" )

                for i, priority in ipairs( priorities ) do
                    if priority:match( "^" .. name ) then
                        Hekili.DB.profile.specs[ state.spec.id ].package = priority
                        local output = format( "Priority set to %s%s|r.", Hekili.DB.profile.packs[ priority ].builtIn and BlizzBlue or "|cFFFFD100", priority )
                        if Hekili.DB.profile.notifications.enabled then Hekili:Notify( output ) end
                        Hekili:Print( output )
                        Hekili:ForceUpdate( "CLI_TOGGLE" )
                        return
                    end
                end

                local output = format( "未找到匹配的优先级配置'%s'。\n有效选项是", raw )

                for i, priority in ipairs( priorities ) do
                    output = output .. format( " %s%s|r%s", Hekili.DB.profile.packs[ priority ].builtIn and BlizzBlue or "|cFFFFD100", priority, i == #priorities and "." or "," )
                end

                if Hekili.DB.profile.notifications.enabled then Hekili:Notify( output ) end
                Hekili:Print( output )
                return

            elseif ( "enable" ):match( "^" .. args[1] ) or ( "disable" ):match( "^" .. args[1] ) then
                local enable = ( "enable" ):match( "^" .. args[1] ) or false

                for i, buttons in ipairs( ns.UI.Buttons ) do
                    for j, _ in ipairs( buttons ) do
                        if not enable then
                            buttons[j]:Hide()
                        else
                            buttons[j]:Show()
                        end
                    end
                end

                self.DB.profile.enabled = enable

                if enable then
                    Hekili:Print( "插件|cFFFFD100已启用|r。" )
                    self:Enable()
                else
                    Hekili:Print( "插件|cFFFFD100已禁用|r。" )
                    self:Disable()
                end

            elseif ( "move" ):match( "^" .. args[1] ) or ( "unlock" ):match( "^" .. args[1] ) then
                if InCombatLockdown() then
                    Hekili:Print( "在战斗中无法激活移动功能。" )
                    return
                end

                if not Hekili.Config then
                    ns.StartConfiguration( true )
                elseif ( "move" ):match( "^" .. args[1] ) and Hekili.Config then
                    ns.StopConfiguration()
                end
            elseif ( "lock" ):match( "^" .. args[1] ) then
                if Hekili.Config then
                    ns.StopConfiguration()
                else
                    Hekili:Print( "显示框未解锁。请使用|cFFFFD100/hek move|r或者|cFFFFD100/hek unlock|r指令允许拖动。" )
                end
            elseif ( "dotinfo" ):match( "^" .. args[1] ) then
                local aura = args[2] and args[2]:trim()
                Hekili:DumpDotInfo( aura )
            end
        else
            LibStub( "AceConfigCmd-3.0" ):HandleCommand( "hekili", "Hekili", input )
        end
    end
end


-- Import/Export
-- Nicer string encoding from WeakAuras, thanks to Stanzilla.

local bit_band, bit_lshift, bit_rshift = bit.band, bit.lshift, bit.rshift
local string_char = string.char

local bytetoB64 = {
    [0]="a","b","c","d","e","f","g","h",
    "i","j","k","l","m","n","o","p",
    "q","r","s","t","u","v","w","x",
    "y","z","A","B","C","D","E","F",
    "G","H","I","J","K","L","M","N",
    "O","P","Q","R","S","T","U","V",
    "W","X","Y","Z","0","1","2","3",
    "4","5","6","7","8","9","(",")"
}

local B64tobyte = {
    a = 0, b = 1, c = 2, d = 3, e = 4, f = 5, g = 6, h = 7,
    i = 8, j = 9, k = 10, l = 11, m = 12, n = 13, o = 14, p = 15,
    q = 16, r = 17, s = 18, t = 19, u = 20, v = 21, w = 22, x = 23,
    y = 24, z = 25, A = 26, B = 27, C = 28, D = 29, E = 30, F = 31,
    G = 32, H = 33, I = 34, J = 35, K = 36, L = 37, M = 38, N = 39,
    O = 40, P = 41, Q = 42, R = 43, S = 44, T = 45, U = 46, V = 47,
    W = 48, X = 49, Y = 50, Z = 51,["0"]=52,["1"]=53,["2"]=54,["3"]=55,
    ["4"]=56,["5"]=57,["6"]=58,["7"]=59,["8"]=60,["9"]=61,["("]=62,[")"]=63
}

-- This code is based on the Encode7Bit algorithm from LibCompress
-- Credit goes to Galmok (galmok@gmail.com)
local encodeB64Table = {};

local function encodeB64(str)
    local B64 = encodeB64Table;
    local remainder = 0;
    local remainder_length = 0;
    local encoded_size = 0;
    local l=#str
    local code
    for i=1,l do
        code = string.byte(str, i);
        remainder = remainder + bit_lshift(code, remainder_length);
        remainder_length = remainder_length + 8;
        while(remainder_length) >= 6 do
            encoded_size = encoded_size + 1;
            B64[encoded_size] = bytetoB64[bit_band(remainder, 63)];
            remainder = bit_rshift(remainder, 6);
            remainder_length = remainder_length - 6;
        end
    end
    if remainder_length > 0 then
        encoded_size = encoded_size + 1;
        B64[encoded_size] = bytetoB64[remainder];
    end
    return table.concat(B64, "", 1, encoded_size)
end

local decodeB64Table = {}

local function decodeB64(str)
    local bit8 = decodeB64Table;
    local decoded_size = 0;
    local ch;
    local i = 1;
    local bitfield_len = 0;
    local bitfield = 0;
    local l = #str;
    while true do
        if bitfield_len >= 8 then
            decoded_size = decoded_size + 1;
            bit8[decoded_size] = string_char(bit_band(bitfield, 255));
            bitfield = bit_rshift(bitfield, 8);
            bitfield_len = bitfield_len - 8;
        end
        ch = B64tobyte[str:sub(i, i)];
        bitfield = bitfield + bit_lshift(ch or 0, bitfield_len);
        bitfield_len = bitfield_len + 6;
        if i > l then
            break;
        end
        i = i + 1;
    end
    return table.concat(bit8, "", 1, decoded_size)
end


local Compresser = LibStub:GetLibrary("LibCompress")
local Encoder = Compresser:GetChatEncodeTable()

local LibDeflate = LibStub:GetLibrary("LibDeflate")
local ldConfig = { level = 5 }

local Serializer = LibStub:GetLibrary("AceSerializer-3.0")



local function TableToString(inTable, forChat)
    local serialized = Serializer:Serialize( inTable )
    local compressed = LibDeflate:CompressDeflate( serialized, ldConfig )

    return format( "Hekili:%s", forChat and ( LibDeflate:EncodeForPrint( compressed ) ) or ( LibDeflate:EncodeForWoWAddonChannel( compressed ) ) )
end


local function StringToTable(inString, fromChat)
    local modern = false
    if inString:sub( 1, 7 ) == "Hekili:" then
        modern = true
        inString = inString:sub( 8 )
    end

    local decoded, decompressed, errorMsg

    if modern then
        decoded = fromChat and LibDeflate:DecodeForPrint(inString) or LibDeflate:DecodeForWoWAddonChannel(inString)
        if not decoded then return "无法解码。" end

        decompressed = LibDeflate:DecompressDeflate(decoded)
        if not decompressed then return "无法解码该字符串。" end
    else
        decoded = fromChat and decodeB64(inString) or Encoder:Decode(inString)
        if not decoded then return "无法解码。" end

        decompressed, errorMsg = Compresser:Decompress(decoded);
        if not decompressed then return "无法解码的字符串：" .. errorMsg end
    end

    local success, deserialized = Serializer:Deserialize(decompressed);
    if not success then return "无法解码解压缩的字符串：" .. deserialized end

    return deserialized
end


function ns.serializeDisplay( display )
    if not rawget( Hekili.DB.profile.displays, display ) then return nil end
    local serial = tableCopy( Hekili.DB.profile.displays[ display ] )

    return TableToString( serial, true )
end

Hekili.SerializeDisplay = ns.serializeDisplay


function ns.deserializeDisplay( str )
    local display = StringToTable( str, true )

    if type( display.precombatAPL ) == 'string' then
        for i, list in ipairs( Hekili.DB.profile.actionLists ) do
            if display.precombatAPL == list.Name then
                display.precombatAPL = i
                break
            end
        end

        if type( display.precombatAPL ) == 'string' then
            display.precombatAPL = 0
        end
    end

    if type( display.defaultAPL ) == 'string' then
        for i, list in ipairs( Hekili.DB.profile.actionLists ) do
            if display.defaultAPL == list.Name then
                display.defaultAPL = i
                break
            end
        end

        if type( display.defaultAPL ) == 'string' then
            display.defaultAPL = 0
        end
    end

    return display
end

Hekili.DeserializeDisplay = ns.deserializeDisplay


function Hekili:SerializeActionPack( name )
    local pack = rawget( self.DB.profile.packs, name )
    if not pack then return end

    local serial = {
        type = "package",
        name = name,
        date = tonumber( date("%Y%m%d.%H%M%S") ),
        payload = tableCopy( pack )
    }

    serial.payload.builtIn = false

    return TableToString( serial, true )
end


function Hekili:DeserializeActionPack( str )
    local serial = StringToTable( str, true )

    if not serial or type( serial ) == "string" or serial.type ~= "package" then
        return serial or "无法从提供的字符串还原优先级配置。"
    end

    serial.payload.builtIn = false

    return serial
end


function Hekili:SerializeStyle( ... )
    local serial = {
        type = "style",
        date = tonumber( date("%Y%m%d.%H%M%S") ),
        payload = {}
    }

    local hasPayload = false

    for i = 1, select( "#", ... ) do
        local dispName = select( i, ... )
        local display = rawget( self.DB.profile.displays, dispName )

        if not display then return "尝试序列化无效的显示框（" .. dispName .. "）" end

        serial.payload[ dispName ] = tableCopy( display )
        hasPayload = true
    end

    if not hasPayload then return "没有选中用于导出的显示框架。" end
    return TableToString( serial, true )
end


function Hekili:DeserializeStyle( str )
    local serial = StringToTable( str, true )

    if not serial or type( serial ) == 'string' or not serial.type == "style" then
        return nil, serial
    end

    return serial.payload
end


function ns.serializeActionList( num )
    if not Hekili.DB.profile.actionLists[ num ] then return nil end
    local serial = tableCopy( Hekili.DB.profile.actionLists[ num ] )
    return TableToString( serial, true )
end


function ns.deserializeActionList( str )
    return StringToTable( str, true )
end



local ignore_actions = {
    -- call_action_list = 1,
    -- run_action_list = 1,
    snapshot_stats = 1,
    -- auto_attack = 1,
    -- use_item = 1,
    flask = 1,
    food = 1,
    augmentation = 1
}


local function make_substitutions( i, swaps, prefixes, postfixes )
    if not i then return nil end

    for k,v in pairs( swaps ) do

        for token in i:gmatch( k ) do

            local times = 0
            while (i:find(token)) do
                local strpos, strend = i:find(token)

                local pre = i:sub( strpos - 1, strpos - 1 )
                local j = 2

                while ( pre == '(' and strpos - j > 0 ) do
                    pre = i:sub( strpos - j, strpos - j )
                    j = j + 1
                end

                local post = i:sub( strend + 1, strend + 1 )
                j = 2

                while ( post == ')' and strend + j < i:len() ) do
                    post = i:sub( strend + j, strend + j )
                    j = j + 1
                end

                local start = strpos > 1 and i:sub( 1, strpos - 1 ) or ''
                local finish = strend < i:len() and i:sub( strend + 1 ) or ''

                if not ( prefixes and prefixes[ pre ] ) and pre ~= '.' and pre ~= '_' and not pre:match('%a') and not ( postfixes and postfixes[ post ] ) and post ~= '.' and post ~= '_' and not post:match('%a') then
                    i = start .. '\a' .. finish
                else
                    i = start .. '\v' .. finish
                end

            end

            i = i:gsub( '\v', token )
            i = i:gsub( '\a', v )

        end

    end

    return i

end


local function accommodate_targets( targets, ability, i, line, warnings )
    local insert_targets = targets
    local insert_ability = ability

    if ability == 'storm_earth_and_fire' then
        insert_targets = type( targets ) == 'number' and min( 2, ( targets - 1 ) ) or 2
        insert_ability = 'storm_earth_and_fire_target'
    elseif ability == 'windstrike' then
        insert_ability = 'stormstrike'
    end

    local swaps = {}

    swaps["d?e?buff%."..insert_ability.."%.up"] = "active_dot."..insert_ability.. ">=" ..insert_targets
    swaps["d?e?buff%."..insert_ability.."%.down"] = "active_dot."..insert_ability.. "<" ..insert_targets
    swaps["dot%."..insert_ability.."%.up"] = "active_dot."..insert_ability..'>=' ..insert_targets
    swaps["dot%."..insert_ability.."%.ticking"] = "active_dot."..insert_ability..'>=' ..insert_targets
    swaps["dot%."..insert_ability.."%.down"] = "active_dot."..insert_ability..'<' ..insert_targets
    swaps["up"] = "active_dot."..insert_ability..">=" ..insert_targets
    swaps["ticking"] = "active_dot."..insert_ability..">=" ..insert_targets
    swaps["down"] = "active_dot."..insert_ability.."<" ..insert_targets

    return make_substitutions( i, swaps )
end
ns.accomm = accommodate_targets


local function Sanitize( segment, i, line, warnings )
    if i == nil then return end

    local operators = {
        [">"] = true,
        ["<"] = true,
        ["="] = true,
        ["~"] = true,
        ["+"] = true,
        ["-"] = true,
        ["%%"] = true,
        ["*"] = true
    }

    local maths = {
        ['+'] = true,
        ['-'] = true,
        ['*'] = true,
        ['%%'] = true
    }

    for token in i:gmatch( "stealthed" ) do
        while( i:find(token) ) do
            local strpos, strend = i:find(token)

            local pre = strpos > 1 and i:sub( strpos - 1, strpos - 1 ) or ''
            local post = strend < i:len() and i:sub( strend + 1, strend + 1 ) or ''
            local start = strpos > 1 and i:sub( 1, strpos - 1 ) or ''
            local finish = strend < i:len() and i:sub( strend + 1 ) or ''

            if pre ~= '.' and pre ~= '_' and not pre:match('%a') and post ~= '.' and post ~= '_' and not post:match('%a') then
                i = start .. '\a' .. finish
            else
                i = start .. '\v' .. finish
            end

        end

        i = i:gsub( '\v', token )
        i = i:gsub( '\a', token..'.rogue' )
    end

    for token in i:gmatch( "cooldown" ) do
        while( i:find(token) ) do
            local strpos, strend = i:find(token)

            local pre = strpos > 1 and i:sub( strpos - 1, strpos - 1 ) or ''
            local post = strend < i:len() and i:sub( strend + 1, strend + 1 ) or ''
            local start = strpos > 1 and i:sub( 1, strpos - 1 ) or ''
            local finish = strend < i:len() and i:sub( strend + 1 ) or ''

            if pre ~= '.' and pre ~= '_' and not pre:match('%a') and post ~= '.' and post ~= '_' and not post:match('%a') then
                i = start .. '\a' .. finish
            else
                i = start .. '\v' .. finish
            end
        end

        i = i:gsub( '\v', token )
        i = i:gsub( '\a', 'action_cooldown' )
    end

    for token in i:gmatch( "equipped%.[0-9]+" ) do
        local itemID = tonumber( token:match( "([0-9]+)" ) )
        local itemName = GetItemInfo( itemID )
        local itemKey = formatKey( itemName )

        if itemKey and itemKey ~= '' then
            i = i:gsub( tostring( itemID ), itemKey )
        end

    end

    local times = 0

    i, times = i:gsub( "==", "=" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将相等的判定符号由'=='更改为'='(" .. times .. "次)。" )
    end

    i, times = i:gsub( "([^%%])[ ]*%%[ ]*([^%%])", "%1 / %2" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将SimC语法中的%转换为Lua语法的(/)(" .. times .. "次)。" )
    end

    i, times = i:gsub( "%%%%", "%%" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将Simc语法中的%%转换为Lua语法的(%)(" .. times .. "次)。" )
    end

    i, times = i:gsub( "covenant%.([%w_]+)%.enabled", "covenant.%1" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'covenant.X.enabled'转换为'covenant.X'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "talent%.([%w_]+)([%+%-%*%%/%&%|= ()<>])", "talent.%1.enabled%2" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'talent.X'转换为'talent.X.enabled'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "talent%.([%w_]+)$", "talent.%1.enabled" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'talent.X'转换为'talent.X.enabled'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "legendary%.([%w_]+)([%+%-%*%%/%&%|= ()<>])", "legendary.%1.enabled%2" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'legendary.X'转换为'legendary.X.enabled'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "legendary%.([%w_]+)$", "legendary.%1.enabled" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'legendary.X'转换为'legendary.X.enabled'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "([^%.])runeforge%.([%w_]+)([%+%-%*%%/=%&%| ()<>])", "%1runeforge.%2.enabled%3" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'runeforge.X'转换为'runeforge.X.enabled'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "([^%.])runeforge%.([%w_]+)$", "%1runeforge.%2.enabled" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'runeforge.X'转换为'runeforge.X.enabled'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "^runeforge%.([%w_]+)([%+%-%*%%/%&%|= ()<>)])", "runeforge.%1.enabled%2" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'runeforge.X'转换为'runeforge.X.enabled'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "^runeforge%.([%w_]+)$", "runeforge.%1.enabled" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'runeforge.X'转换为'runeforge.X.enabled'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "rune_word%.([%w_]+)([%+%-%*%%/%&%|= ()<>])", "buff.rune_word_%1.up%2" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'rune_word.X'转换为'buff.rune_word_X.up'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "rune_word%.([%w_]+)$", "buff.rune_word_%1.up" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'rune_word.X'转换为'buff.rune_word_X.up'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "rune_word%.([%w_]+)%.enabled([%+%-%*%%/%&%|= ()<>])", "buff.rune_word_%1.up%2" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'rune_word.X.enabled'转换为'buff.rune_word_X.up'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "rune_word%.([%w_]+)%.enabled$", "buff.rune_word_%1.up" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'rune_word.X.enabled'转换为'buff.rune_word_X.up'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "([^a-z0-9_])conduit%.([%w_]+)([%+%-%*%%/&|= ()<>)])", "%1conduit.%2.enabled%3" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'conduit.X'转换为'conduit.X.enabled'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "([^a-z0-9_])conduit%.([%w_]+)$", "%1conduit.%2.enabled" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'conduit.X'转换为'conduit.X.enabled'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "soulbind%.([%w_]+)([%+%-%*%%/&|= ()<>)])", "soulbind.%1.enabled%2" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'soulbind.X'转换为'soulbind.X.enabled'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "soulbind%.([%w_]+)$", "soulbind.%1.enabled" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'soulbind.X'转换为'soulbind.X.enabled'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "pet%.[%w_]+%.([%w_]+)%.", "%1." )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'pet.X.Y...'转换为'Y...'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "(essence%.[%w_]+)%.([%w_]+)%.rank(%d)", "(%1.%2&%1.rank>=%3)" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'essence.X.[major|minor].rank#'转换为'(essence.X.[major|minor]&essence.X.rank>=#)'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "pet%.[%w_]+%.[%w_]+%.([%w_]+)%.", "%1." )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'pet.X.Y.Z...'转换为'Z...'(" .. times .. "次)。" )
    end

    -- target.1.time_to_die is basically the end of an encounter.
    i, times = i:gsub( "target%.1%.time_to_die", "time_to_die" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'target.1.time_to_die'转换为'time_to_die' (" .. times .."x)." )
    end

    -- target.time_to_pct_XX.remains is redundant, Monks.
    i, times = i:gsub( "time_to_pct_(%d+)%.remains", "time_to_pct_%1" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'time_to_pct_XX.remains'转换为'time_to_pct_XX'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "trinket%.1%.", "trinket.t1." )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'trinket.1.X'转换为'trinket.t1.X'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "trinket%.2%.", "trinket.t2." )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'trinket.2.X'转换为'trinket.t2.X'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "trinket%.([%w_][%w_][%w_]+)%.cooldown", "cooldown.%1" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'trinket.abc.cooldown'转换为'cooldown.abc'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "%.(proc%.any)%.", ".has_buff." )
    if times > 0 then
        insert( warnings, "第 " .. line .. "行：将'proc.any'转换为'has_buff' (" .. times .. "次。" )
    end

    i, times = i:gsub( "min:[a-z0-9_%.]+(,?$?)", "%1" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：移除min:X检测（模拟中不可用）(" .. times .. "次)。" )
    end

    i, times = i:gsub( "([%|%&]position_back)", "" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：移除position_back检测（模拟中不可用）(" .. times .. "次)。" )
    end

    i, times = i:gsub( "(position_back[%|%&]?)", "" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：移除position_back检测（模拟中不可用）(" .. times .. "次)。" )
    end

    i, times = i:gsub( "max:[a-z0-9_%.]+(,?$?)", "%1" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：移除max:X检测（模拟中不可用）(" .. times .. "次)。" )
    end

    i, times = i:gsub( "(incanters_flow_time_to%.%d+)(^%.)", "%1.any%2")
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将不起效的'incanters_flow_time_to.X'转换为'incanters_flow_time_to.X.any'(" .. times .. "次)。" )
    end

    i, times = i:gsub( "exsanguinated%.([a-z0-9_]+)", "debuff.%1.exsanguinated" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'exsanguinated.X'转换为'debuff.X.exsanguinated'(" .. times .. "次)。")
    end

    i, times = i:gsub( "time_to_sht%.(%d+)%.plus", "time_to_sht_plus.%1" )
    if times > 0 then
        insert( warnings, "第" .. line .. "行：将'time_to_sht.X.plus'转换为'time_to_sht_plus.X'(" .. times .. "次)。")
    end

    if segment == 'c' then
        for token in i:gmatch( "target" ) do
            local times = 0
            while (i:find(token)) do
                local strpos, strend = i:find(token)

                local pre = i:sub( strpos - 1, strpos - 1 )
                local post = i:sub( strend + 1, strend + 1 )

                if pre ~= '_' and post ~= '.' then
                    i = i:sub( 1, strpos - 1 ) .. '\v.unit' .. i:sub( strend + 1 )
                    times = times + 1
                else
                    i = i:sub( 1, strpos - 1 ) .. '\v' .. i:sub( strend + 1 )
                end
            end

            if times > 0 then
                insert( warnings, "第" .. line .. "行：将不确定的'target'转换为'target.unit'(" .. times .. "次)。" )
            end
            i = i:gsub( '\v', token )
        end
    end


    for token in i:gmatch( "player" ) do
        local times = 0
        while (i:find(token)) do
            local strpos, strend = i:find(token)

            local pre = i:sub( strpos - 1, strpos - 1 )
            local post = i:sub( strend + 1, strend + 1 )

            if pre ~= '_' and post ~= '.' then
                i = i:sub( 1, strpos - 1 ) .. '\v.unit' .. i:sub( strend + 1 )
                times = times + 1
            else
                i = i:sub( 1, strpos - 1 ) .. '\v' .. i:sub( strend + 1 )
            end
        end

        if times > 0 then
            insert( warnings, "第" .. line .. "行：将不确定的'player'转换为'player.unit'(" .. times .. "次)。" )
        end
        i = i:gsub( '\v', token )
    end

    return i
end


local function strsplit( str, delimiter )
    local result = {}
    local from = 1

    if not delimiter or delimiter == "" then
        result[1] = str
        return result
    end

    local delim_from, delim_to = string.find( str, delimiter, from )

    while delim_from do
        insert( result, string.sub( str, from, delim_from - 1 ) )
        from = delim_to + 1
        delim_from, delim_to = string.find( str, delimiter, from )
    end

    insert( result, string.sub( str, from ) )
    return result
end


--[[ local function StoreModifier( entry, key, value )

    if key ~= 'if' and key ~= 'ability' then
        if not entry.Args then entry.Args = key .. '=' .. value
        else entry.Args = entry.Args .. "," .. key .. "=" .. value end
    end

    if key == 'if' then
        entry.Script = value

    elseif key == 'cycle_targets' then
        entry.CycleTargets = tonumber( value ) == 1 and true or false

    elseif key == 'max_cycle_targets' then
        entry.MaximumTargets = value

    elseif key == 'moving' then
        entry.CheckMovement = true
        entry.Moving = tonumber( value )

    elseif key == 'name' then
        local v = value:match( '"(.*)"'' ) or value
        entry.ModName = v
        entry.ModVarName = v

    elseif key == 'value' then -- for 'variable' type, overwrites Script
        entry.Script = value

    elseif key == 'target_if' then
        entry.TargetIf = value

    elseif key == 'pct_health' then
        entry.PctHealth = value

    elseif key == 'interval' then
        entry.Interval = value

    elseif key == 'for_next' then
        entry.PoolForNext = tonumber( value ) ~= 0

    elseif key == 'wait' then
        entry.PoolTime = tonumber( value ) or 0

    elseif key == 'extra_amount' then
        entry.PoolExtra = tonumber( value ) or 0

    elseif key == 'sec' then
        entry.WaitSeconds = value

    end

end ]]

do
    local parseData = {
        warnings = {},
        missing = {},
    }

    local nameMap = {
        call_action_list = "list_name",
        run_action_list = "list_name",
        potion = "potion",
        variable = "var_name",
        cancel_buff = "buff_name",
        op = "op",
    }

    function Hekili:ParseActionList( list )

        local line, times = 0, 0
        local output, warnings, missing = {}, parseData.warnings, parseData.missing

        wipe( warnings )
        wipe( missing )

        list = list:gsub( "(|)([^|])", "%1|%2" ):gsub( "|||", "||" )

        local n = 0
        for aura in list:gmatch( "buff%.([a-zA-Z0-9_]+)" ) do
            if not class.auras[ aura ] then
                missing[ aura ] = true
                n = n + 1
            end
        end

        for aura in list:gmatch( "active_dot%.([a-zA-Z0-9_]+)" ) do
            if not class.auras[ aura ] then
                missing[ aura ] = true
                n = n + 1
            end
        end

        for i in list:gmatch( "action.-=/?([^\n^$]*)") do
            line = line + 1

            if i:sub(1, 3) == 'jab' then
                for token in i:gmatch( 'cooldown%.expel_harm%.remains>=gcd' ) do

                    local times = 0
                    while (i:find(token)) do
                        local strpos, strend = i:find(token)

                        local pre = strpos > 1 and i:sub( strpos - 1, strpos - 1 ) or ''
                        local post = strend < i:len() and i:sub( strend + 1, strend + 1 ) or ''
                        local repl = ( ( strend < i:len() and pre ) and pre or post ) or ""

                        local start = strpos > 2 and i:sub( 1, strpos - 2 ) or ''
                        local finish = strend < i:len() - 1 and i:sub( strend + 2 ) or ''

                        i = start .. repl .. finish
                        times = times + 1
                    end
                    insert( warnings, "第" .. line .. "行：移除不必要的驱散伤害冷却检测(" .. times .. "次)。" )
                end
            end

            --[[ for token in i:gmatch( 'spell_targets[.%a_]-' ) do

                local times = 0
                while (i:find(token)) do
                    local strpos, strend = i:find(token)

                    local start = strpos > 2 and i:sub( 1, strpos - 1 ) or ''
                    local finish = strend < i:len() - 1 and i:sub( strend + 1 ) or ''

                    i = start .. enemies .. finish
                    times = times + 1
                end
                insert( warnings, "第 " .. line .. "行：转换'" .. token .. "'到'" .. enemies .. "'(" .. times .. "次)。" )
            end ]]

            if i:sub(1, 13) == 'fists_of_fury' then
                for token in i:gmatch( "energy.time_to_max>cast_time" ) do
                    local times = 0
                    while (i:find(token)) do
                        local strpos, strend = i:find(token)

                        local pre = strpos > 1 and i:sub( strpos - 1, strpos - 1 ) or ''
                        local post = strend < i:len() and i:sub( strend + 1, strend + 1 ) or ''
                        local repl = ( ( strend < i:len() and pre ) and pre or post ) or ""

                        local start = strpos > 2 and i:sub( 1, strpos - 2 ) or ''
                        local finish = strend < i:len() - 1 and i:sub( strend + 2 ) or ''

                        i = start .. repl .. finish
                        times = times + 1
                    end
                    insert( warnings, "第" .. line .. "行：移除不必要的能量上限检测(" .. times .. "次)。" )
                end
            end

            local components = strsplit( i, "," )
            local result = {}

            for a, str in ipairs( components ) do
                -- First element is the action, if supported.
                if a == 1 then
                    local ability = str:trim()

                    if ability and ( ability == "use_item" or class.abilities[ ability ] ) then
                        if ability == "pocketsized_computation_device" then ability = "cyclotronic_blast" end
                        -- Stub abilities that are replaced sometimes.
                        if ability == "any_dnd" or ability == "wound_spender" or ability == "summon_pet" then
                            result.action = ability
                        else
                            result.action = class.abilities[ ability ] and class.abilities[ ability ].key or ability
                        end
                    elseif not ignore_actions[ ability ] then
                        insert( warnings, "第" .. line .. "行：不支持的操作指令'" .. ability .. "'。" )
                        result.action = ability
                    end

                else
                    local key, value = str:match( "^(.-)=(.-)$" )

                    if key and value then
                        -- TODO:  Automerge multiple criteria.
                        if key == 'if' or key == 'condition' then key = 'criteria' end

                        if key == 'criteria' or key == 'target_if' or key == 'value' or key == 'value_else' or key == 'sec' or key == 'wait' then
                            value = Sanitize( 'c', value, line, warnings )
                            value = SpaceOut( value )
                        end

                        if key == 'description' then
                            value = value:gsub( ";", "," )
                        end

                        result[ key ] = value
                    end
                end
            end

            if nameMap[ result.action ] then
                result[ nameMap[ result.action ] ] = result.name
                result.name = nil
            end

            if result.target_if then result.target_if = result.target_if:gsub( "min:", "" ):gsub( "max:", "" ) end

            if result.for_next then result.for_next = tonumber( result.for_next ) end
            if result.cycle_targets then result.cycle_targets = tonumber( result.cycle_targets ) end
            if result.max_energy then result.max_energy = tonumber( result.max_energy ) end

            if result.use_off_gcd then result.use_off_gcd = tonumber( result.use_off_gcd ) end
            if result.use_while_casting then result.use_while_casting = tonumber( result.use_while_casting ) end
            if result.strict then result.strict = tonumber( result.strict ) end
            if result.moving then result.enable_moving = true; result.moving = tonumber( result.moving ) end

            if result.target_if and not result.criteria then
                result.criteria = result.target_if
                result.target_if = nil
            end

            if result.action == "use_item" then
                if result.effect_name and class.abilities[ result.effect_name ] then
                    result.action = class.abilities[ result.effect_name ].key
                elseif result.name and class.abilities[ result.name ] then
                    result.action = result.name
                elseif ( result.slot or result.slots ) and class.abilities[ result.slot or result.slots ] then
                    result.action = result.slot or result.slots
                end

                if result.action == "use_item" then
                    insert( warnings, "第" .. line .. "行：不支持的使用道具指令[ " .. ( result.effect_name or result.name or "未知" ) .. "]或没有权限。" )
                    result.action = nil
                    result.enabled = false
                end
            end

            if result.action == "wait_for_cooldown" then
                if result.name then
                    result.action = "wait"
                    result.sec = "cooldown." .. result.name .. ".remains"
                    result.name = nil
                else
                    insert( warnings, "第" .. line .. "行：无法转换wait_for_cooldown,name=X到wait,sec=cooldown.X.remains或没有权限。" )
                    result.action = "wait"
                    result.enabled = false
                end
            end

            if result.action == 'use_items' and ( result.slot or result.slots ) then
                result.action = result.slot or result.slots
            end

            if result.action == 'variable' and not result.op then
                result.op = 'set'
            end

            if result.cancel_if and not result.interrupt_if then
                result.interrupt_if = result.cancel_if
                result.cancel_if = nil
            end

            insert( output, result )
        end

        if n > 0 then
            insert( warnings, "以下效果已在技能列表中使用，但无法在插件数据库中找到：" )
            for k in orderedPairs( missing ) do
                insert( warnings, " - " .. k )
            end
        end

        return #output > 0 and output or nil, #warnings > 0 and warnings or nil
    end
end



local warnOnce = false

-- Key Bindings
function Hekili:TogglePause( ... )

    Hekili.btns = ns.UI.Buttons

    if not self.Pause then
        self:MakeSnapshot()
        self.Pause = true

        --[[ if self:SaveDebugSnapshot() then
            if not warnOnce then
                self:Print( "快照已保存；快照可通过/hekili查看（直到重载UI）。" )
                warnOnce = true
            else
                self:Print( "快照已保存。" )
            end
        end ]]

    else
        self.Pause = false
        self.ActiveDebug = false

        -- Discard the active update thread so we'll definitely start fresh at next update.
        Hekili:ForceUpdate( "TOGGLE_PAUSE", true )
    end

    local MouseInteract = self.Pause or self.Config

    for _, group in pairs( ns.UI.Buttons ) do
        for _, button in pairs( group ) do
            if button:IsShown() then
                button:EnableMouse( MouseInteract )
            end
        end
    end

    self:Print( ( not self.Pause and "解除" or "" ) .. "暂停。" )
    self:Notify( ( not self.Pause and "解除" or "" ) .. "暂停。" )

end


-- Key Bindings
function Hekili:MakeSnapshot( isAuto )
    if isAuto and not Hekili.DB.profile.autoSnapshot then
        return
    end

    self.ActiveDebug = true
    Hekili.Update()
    self.ActiveDebug = false

    HekiliDisplayPrimary.activeThread = nil
end



function Hekili:Notify( str, duration )
    if not self.DB.profile.notifications.enabled then
        self:Print( str )
        return
    end

    HekiliNotificationText:SetText( str )
    HekiliNotificationText:SetTextColor( 1, 0.8, 0, 1 )
    UIFrameFadeOut( HekiliNotificationText, duration or 3, 1, 0 )
end


do
    local modes = {
        "automatic", "single", "aoe", "dual", "reactive"
    }

    local modeIndex = {
        automatic = { 1, "自动" },
        single = { 2, "单目标" },
        aoe = { 3, "AOE（多目标）" },
        dual = { 4, "固定式双显" },
        reactive = { 5, "响应式双显" },
    }

    local toggles = setmetatable( {
        custom1 = "自定义#1",
        custom2 = "自定义#2",
    }, {
        __index = function( t, k )
            if k == "essences" then k = "covenants" end

            local name = k:gsub( "^(.)", strupper )
            t[k] = name
            return name
        end,
    } )


    function Hekili:SetMode( mode )
        mode = lower( mode:trim() )

        if not modeIndex[ mode ] then
            Hekili:Print( "切换模式失败：'%s'不是有效的显示模式。\n请尝试使用|cFFFFD100自动|r，|cFFFFD100单目标|r，|cFFFFD100AOE|r，|cFFFFD100双显|r，或者|cFFFFD100响应|r模式。" )
            return
        end

        self.DB.profile.toggles.mode.value = mode

        if self.DB.profile.notifications.enabled then
            self:Notify( "切换显示模式为：" .. modeIndex[ mode ][2] )
        else
            self:Print( modeIndex[ mode ][2] .. "模式已激活。" )
        end        
    end


    function Hekili:FireToggle( name )
        local toggle = name and self.DB.profile.toggles[ name ]

        if not toggle then return end

        if name == 'mode' then
            local current = toggle.value
            local c_index = modeIndex[ current ][ 1 ]

            local i = c_index + 1

            while true do
                if i > #modes then i = i % #modes end
                if i == c_index then break end

                local newMode = modes[ i ]

                if toggle[ newMode ] then
                    toggle.value = newMode
                    break
                end

                i = i + 1
            end

            if self.DB.profile.notifications.enabled then
                self:Notify( "切换显示模式为：" .. modeIndex[ toggle.value ][2] )
            else
                self:Print( modeIndex[ toggle.value ][2] .. "模式已激活。" )
            end

        elseif name == 'pause' then
            self:TogglePause()
            return

        elseif name == 'snapshot' then
            self:MakeSnapshot()
            return

        else
            toggle.value = not toggle.value

            if toggle.name then toggles[ name ] = toggle.name end

            if self.DB.profile.notifications.enabled then
                self:Notify( toggles[ name ] .. ": " .. ( toggle.value and "打开" or "关闭" ) )
            else
                self:Print( toggles[ name ].. ( toggle.value and " |cFF00FF00启用|r。" or " |cFFFF0000禁用|r。" ) )
            end
        end

        if WeakAuras and WeakAuras.ScanEvents then WeakAuras.ScanEvents( "HEKILI_TOGGLE", name, toggle.value ) end
        if ns.UI.Minimap then ns.UI.Minimap:RefreshDataText() end
        self:UpdateDisplayVisibility()

        self:ForceUpdate( "HEKILI_TOGGLE", true )
    end


    function Hekili:GetToggleState( name, class )
        local t = name and self.DB.profile.toggles[ name ]

        return t and t.value
    end
end
