SetActiveLib -work
comp -include "$dsn\src\Sources\intro.vhd" 
comp -include "$dsn\src\TestBench\intro_TB.vhd" 
asim TESTBENCH_FOR_intro 
wave 
wave -noreg in1_tb
wave -noreg out1_tb
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\intro_TB_tim_cfg.vhd" 
# asim TIMING_FOR_intro 
