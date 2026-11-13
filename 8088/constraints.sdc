# Constraints (OpenSTA / LibreLane, sky130), adapted from the SAED90 / DC constraints.tcl
# Keep `period` equal to CLOCK_PERIOD in config.json

set period 100.0
create_clock -name CLK -period $period [get_ports CLK]

# Uncertainty
set_clock_uncertainty -setup 0.25 [get_clocks CLK]
set_clock_uncertainty -hold  0.25 [get_clocks CLK]

# Input / output delays (20% of the period)
# remove_from_collection doesn't exist in OpenSTA, so drop CLK with lreplace
set clk_indx [lsearch [all_inputs] [get_ports CLK]]
set all_inputs_wo_clk [lreplace [all_inputs] $clk_indx $clk_indx ""]

set_input_delay -max 20.0 -clock [get_clocks CLK] $all_inputs_wo_clk
set_input_delay -min 0.0 -clock [get_clocks CLK] $all_inputs_wo_clk

set_output_delay -max 20.0 -clock [get_clocks CLK] [all_outputs]
set_output_delay -min 0.0 -clock [get_clocks CLK] [all_outputs]

# Max transition (0.2 ns from SAED90 is too tight for sky130_fd_sc_hd)
set_max_transition 1.5 [current_design]

# Fanout limit
set_max_fanout 10 [current_design]
