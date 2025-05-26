# Simulation script for ModelSim

vlib work
vcom -93 ../src/instruction_memory.vhd
vcom -93 ../src/multiplexeur.vhd
vcom -93 ../src/pc.vhd
vcom -93 ../src/sign_extension.vhd
vcom -93 ../src/UNITE_GESTION_INSTRUCTIONS.vhd
vcom -93 tb_Unite_Instructions.vhd
vsim -novopt tb_Unite_Instructions

add wave *
run -a
