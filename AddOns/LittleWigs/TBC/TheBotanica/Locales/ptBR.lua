local L = BigWigs:NewBossLocale("Commander Sarannis", "ptBR")
if not L then return end
if L then
	L.mender = "Reparador da Falange Sangrenta"

	L.reinforcements = "Evocar Reforços"
	L.reinforcements_desc = "O Comandante Sarannis evoca 3 Reservistas da Falange Sangrenta e um Reparador da Falange Sangrenta a cada minuto."
end

L = BigWigs:NewBossLocale("High Botanist Freywinn", "ptBR")
if L then
	L.white_seedling = "Sementino Branco"
end

L = BigWigs:NewBossLocale("Warp Splinter", "ptBR")
if L then
	L.mender = "Reparador da Falange Sangrenta"

	L.saplings = "Evocar Brotos"
	L.saplings_desc = "O Estilhaço Dimensional dá vida a 6 Brotos para ajudá-lo em batalha. Após 25 s, os Brotos se sacrificam, curando o Estilhaço Dimensional na mesma quantidade da sua vida restante."
end
