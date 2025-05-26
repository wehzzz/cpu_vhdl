# Simulation script for ModelSim

vlib work
vcom -93 ../src/ALU.vhd
vcom -93 ../src/register.vhd
vcom -93 ../src/UNITE_TRAITEMENT.vhd
vcom -93 tb_Unite_Traitement.vhd
vsim -novopt tb_Unite_Traitement
# Ajoute le signal interne "Banc" à l'instance Banc_Registres
add wave -hex -label "Registre_0" /tb_unite_traitement/DUT/U_Registre/Banc(0)
add wave -hex -label "Registre_1" /tb_unite_traitement/DUT/U_Registre/Banc(1)
add wave -hex -label "Registre_2" /tb_unite_traitement/DUT/U_Registre/Banc(2)
add wave -hex -label "Registre_3" /tb_unite_traitement/DUT/U_Registre/Banc(3)
add wave -hex -label "Registre_4" /tb_unite_traitement/DUT/U_Registre/Banc(4)
add wave -hex -label "Registre_5" /tb_unite_traitement/DUT/U_Registre/Banc(5)
add wave -hex -label "Registre_6" /tb_unite_traitement/DUT/U_Registre/Banc(6)
add wave -hex -label "Registre_7" /tb_unite_traitement/DUT/U_Registre/Banc(7)
add wave -hex -label "Registre_8" /tb_unite_traitement/DUT/U_Registre/Banc(8)
add wave -hex -label "Registre_9" /tb_unite_traitement/DUT/U_Registre/Banc(9)
add wave -hex -label "Registre_10" /tb_unite_traitement/DUT/U_Registre/Banc(10)
add wave -hex -label "Registre_11" /tb_unite_traitement/DUT/U_Registre/Banc(11)
add wave -hex -label "Registre_12" /tb_unite_traitement/DUT/U_Registre/Banc(12)
add wave -hex -label "Registre_13" /tb_unite_traitement/DUT/U_Registre/Banc(13)
add wave -hex -label "Registre_14" /tb_unite_traitement/DUT/U_Registre/Banc(14)
add wave -hex -label "Registre_15" /tb_unite_traitement/DUT/U_Registre/Banc(15)
add wave -hex -label "S" /tb_unite_traitement/DUT/U_alu/F
add wave -position insertpoint sim:/tb_Unite_Traitement/DUT/A
add wave -position insertpoint sim:/tb_Unite_Traitement/DUT/B

add wave *
run -a
