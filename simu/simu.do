# Simulation script for ModelSim

vlib work
vcom -93 ../src/ALU.vhd
vcom -93 ../src/register.vhd
vcom -93 ../src/UNITE_TRAITEMENT.vhd
vcom -93 tb_Unite_Traitement.vhd
vsim -novopt tb_Unite_Traitement
add wave *
run -a
