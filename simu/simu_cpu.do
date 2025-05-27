vlib work
vcom -93 ../src/alu.vhd
vcom -93 ../src/command_register.vhd
vcom -93 ../src/instruction_decryptor.vhd
vcom -93 ../src/instruction_memory.vhd
vcom -93 ../src/memory.vhd
vcom -93 ../src/multiplexeur.vhd
vcom -93 ../src/pc.vhd
vcom -93 ../src/reg_aff.vhd
vcom -93 ../src/register_PSR.vhd
vcom -93 ../src/register.vhd
vcom -93 ../src/SEVEN_SEG.vhd
vcom -93 ../src/sign_extension.vhd
vcom -93 ../src/UNITE_GESTION_INSTRUCTIONS.vhd
vcom -93 ../src/UNITE_TRAITEMENT.vhd
vcom -93 ../src/cpu.vhd
vcom -93 tb_cpu.vhd
vsim -novopt tb_cpu

add wave -position insertpoint sim:/tb_cpu/*
add wave -position insertpoint sim:/tb_cpu/UUT/*
add wave -position insertpoint sim:/tb_cpu/UUT/U_Traitement/U_Registre/Banc
add wave -position insertpoint sim:/tb_cpu/UUT/U_Traitement/U_Registre/*
add wave -position insertpoint sim:/tb_cpu/UUT/U_Traitement/*
add wave -position insertpoint sim:/tb_cpu/UUT/U_Traitement/U_Memory/Banc
add wave -position insertpoint sim:/tb_cpu/UUT/U_Traitement/U_Memory/*
run -a