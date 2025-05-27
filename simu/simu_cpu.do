vcom -work work src/*.vhd
vcom -work work simu/tb_cpu.vhd
vsim work.tb_cpu
add wave -position insertpoint sim:/tb_cpu/*
add wave -position insertpoint sim:/tb_cpu/UUT/*
run -a