# synth.ys
read_verilog your_design.v
synth -top your_top_module
write_verilog -noattr gate_level_netlist.v
