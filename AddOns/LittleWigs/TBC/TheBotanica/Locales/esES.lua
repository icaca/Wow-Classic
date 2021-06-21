local L = BigWigs:NewBossLocale("Commander Sarannis", "esES") or BigWigs:NewBossLocale("Commander Sarannis", "esMX")
if not L then return end
if L then
	L.mender = "Ensalmador Depositario de sangre"

	L.reinforcements = "Invocar refuerzos"
	L.reinforcements_desc = "La comandante Sarannis invoca a 3 reservistas Depositario de sangre y a 1 ensalmador Depositario de sangre cada minuto."
end

L = BigWigs:NewBossLocale("High Botanist Freywinn", "esES") or BigWigs:NewBossLocale("High Botanist Freywinn", "esMX")
if L then
	L.white_seedling = "Esqueje blanco"
end

L = BigWigs:NewBossLocale("Warp Splinter", "esES") or BigWigs:NewBossLocale("Warp Splinter", "esMX")
if L then
	L.mender = "Ensalmador Depositario de sangre"

	L.saplings = "Invocar pimpollos"
	L.saplings_desc = "El disidente de distorsión alza 6 pimpollos para que le ayuden en la batalla. Tras 25 s, los pimpollos se sacrifican y sanan al disidente de distorsión una cantidad equivalente a su salud restante."
end
