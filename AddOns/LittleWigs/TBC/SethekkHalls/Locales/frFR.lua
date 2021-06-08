local L = BigWigs:NewBossLocale("Darkweaver Syth", "frFR")
if not L then return end
if L then
	L.elementals = "Invocation d'élémentaires"
	L.elementals_desc = "Quand le sombre tisseur Syth n’a plus que 90%, 55% ou 15% de ses points de vie, il invoque 4 élémentaires pour le défendre."
end

L = BigWigs:NewBossLocale("Anzu", "frFR")
if L then
	L.cyclone = "Cyclone de plumes"
	L.cyclone_desc = "Anzu enveloppe un personnage-joueur d'un cyclone, l’empêchant d’agir mais le rendant invulnérable pendant 6 s."

	L.brood = "Progéniture d'Anzu"
	L.brood_desc = "Quand Anzu n’a plus que 75% ou 35% de ses points de vie, il se bannit lui-même pendant 1 minute, ce qui l’immunise contre tous les dégâts, mais l’empêche de se déplacer. Tant qu’il est banni, Anzu continue à utiliser ses techniques et invoque la progéniture d’Anzu pour le défendre.Si toute la progéniture d’Anzu est éliminée, Anzu annule son bannissement plus tôt."
end
