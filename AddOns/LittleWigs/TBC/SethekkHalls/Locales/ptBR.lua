local L = BigWigs:NewBossLocale("Darkweaver Syth", "ptBR")
if not L then return end
if L then
	L.elementals = "Evocar Elementais"
	L.elementals_desc = "Quando o Tecetrevas Syth chega a 90%, 55% e 15% de vida, ele evoca 4 elementais para defendê-lo."
end

L = BigWigs:NewBossLocale("Anzu", "ptBR")
if L then
	L.cyclone = "Ciclone de Plumas"
	L.cyclone_desc = "Anzu envolve um jogador num ciclone, impedindo que realizem quaisquer ações, mas tornando-os invulneráveis por 6 s."

	L.brood = "Prole de Anzu"
	L.brood_desc = "Quando Anzu chega a 75% e 35% dos pontos de vida, ele bane a si mesmo por 1 minuto, ficando imune a todos os danos e incapaz de se mover. Enquanto estiver banido, Anzu continuará a usar habilidades e evocará a Prole de Anzu para defendê-lo. Derrotar toda a Prole de Anzu fará com que o efeito do banimento seja cancelado mais cedo."
end
