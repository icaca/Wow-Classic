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
	L.inferno_desc = "A Chamas Enraivecidas se protegem com um incêndio por 8 s, causando dano de Fogo a todos os jogadores em um raio de 10 m a cada segundo. Durante o incêndio as Chamas Enraivecidas não podem se mover ou usar habilidades. Quando o incêndio termina, as Chamas Enraivecidas escolhem um novo alvo para perseguir."

	L.fixate_desc = "Faz com que o lançador fixe a atenção em um alvo aleatório."
end
