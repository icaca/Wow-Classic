local L = LibStub("AceLocale-3.0"):NewLocale( "DataStore_Auctions", "ruRU" )

if not L then return end

L["CLEAR_EXPIRED_ITEMS_DISABLED"] = "Истёкшие предметы остануться в базе данных, пока игрок не посетит аукцион."
L["CLEAR_EXPIRED_ITEMS_ENABLED"] = "Истёкшие предметы автоматически удалены из базы данных."
L["CLEAR_EXPIRED_ITEMS_LABEL"] = "Автоматически удалять истёкшие ставки и аукционы"
L["CLEAR_EXPIRED_ITEMS_TITLE"] = "Удалять информацию о предметах в аукционе"
