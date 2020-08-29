TF_RAIDS = {
    { zone = TF_ZONE.STRANGLETHORN_VALE, x = 0.5408, y = 0.1757, name = "Zul'Gurub", raidSize = 20 },
    { zone = TF_ZONE.DUSTWALLOW_MARSH, x = 0.5294, y = 0.778, name = "Onyxia's Lair", raidSize = 40, attunement = { item = 16309, name = "Drakefire Amulet" }, altEntrance = { zone = TF_ZONE.KALIMDOR, x = 0.5658, y = 0.7156 } },
    { zone = TF_ZONE.SILITHUS, x = 0.362, y = 0.842, name = "Ruins of Ahn'Qiraj", raidSize = 20 },
    { zone = TF_ZONE.SILITHUS, x = 0.235, y = 0.862, name = "Temple of Ahn'Qiraj", raidSize = 40 },
    { zone = TF_ZONE.EASTERN_PLAGUELANDS, x = 0.3995, y = 0.2586, name = "Naxxramas", raidSize = 40, attunement = { quest = { 9121, 9122, 9123 }, name = "The Dread Citadel - Naxxramas" } },

    -- Blackrock Mountain instances
    {
        zone = TF_ZONE.BURNING_STEPPES,
        x = 0.295,
        y = 0.384,
        name = "Blackrock Mountain",
        group = {
            dungeons = {
                { name = "Blackrock Depths", minLevel = 40, recommendedLevel = { 52, 60 } },
                { name = "Lower Blackrock Spire", minLevel = 45, recommendedLevel = { 55, 60 } },
                { name = "Upper Blackrock Spire", minLevel = 57, recommendedLevel = { 55, 60 }, attunement = { item = 12344, name = "Seal of Ascension" } },
            },
            raids = {
                { name = "Molten Core", raidSize = 40, zone = TF_ZONE.EASTERN_KINGDOMS, x = 0.4841, y = 0.6381, attunement = { quest = 7848, name = "Attunement to the Core" } },
                { name = "Blackwing Lair", raidSize = 40, zone = TF_ZONE.EASTERN_KINGDOMS, x = 0.4892, y = 0.6447, attunement = { quest = 7761, name = "Blackhand's Command" } },
            }
        },
        altEntrance = { zone = TF_ZONE.SEARING_GORGE, x = 0.349, y = 0.854 },
        distance = 0.04,
    },
}
