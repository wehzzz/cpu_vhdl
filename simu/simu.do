# Simulation script for ModelSim

vlib work
vcom -93 ../src/ALU.vhd
vcom -93 ../src/memory.vhd
vcom -93 ../src/multiplexeur.vhd
vcom -93 ../src/register.vhd
vcom -93 ../src/sign_extension.vhd
vcom -93 ../src/UNITE_TRAITEMENT.vhd
vcom -93 tb_Unite_Traitement.vhd
vsim -novopt tb_Unite_Traitement

# Ajoute le signal interne "Banc" à l'instance Banc_Registres
add wave -hex -label "Registre" /tb_unite_traitement/DUT/U_Registre/Banc
add wave -hex -label "Mémoire" /tb_unite_traitement/DUT/U_memory/Banc
add wave *
run -a
