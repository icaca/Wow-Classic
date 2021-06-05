local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "ptBR")
if not L then return end
if L then
	L.despawn_message = "Aparições Etéreas desaparecendo em breve"
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "ptBR")
if L then
	L.bossName = "Vigia do Portal Mão-de-ferro"
end

L = BigWigs:NewBossLocale("Gatewatcher Gyro-Kill", "ptBR")
if L then
	L.bossName = "Vigia do Portal Matagiros"
end

L = BigWigs:NewBossLocale("Nethermancer Sepethrea", "ptBR")
if L then
	L.inferno = "Inferno"
	L.inferno_desc = "Kael'thas Andassol evoca um pilar de fogo, queimando todos os jogadores em um raio de 6 metros da área alvejada e causando dano de fogo a cada segundo por 8 s."
end
