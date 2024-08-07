# Create clock constraints for write clock domain
create_clock -name w_clk -period 10.0 [get_ports w_clk]
# w_clk is 100 MHz

# Create clock constraints for read clock domain
create_clock -name r_clk -period 20.0 [get_ports r_clk]
# r_clk is 50 MHz

# Define input delays
#set_input_delay -clock w_clk -max 2.0 [get_ports w_en]
#set_input_delay -clock r_clk -max 2.0 [get_ports r_en]

# Define output delays
#set_output_delay -clock w_clk -max 2.0 [get_ports full]
#set_output_delay -clock r_clk -max 2.0 [get_ports empty]
#set_output_delay -clock r_clk -max 2.0 [get_ports r_data]

# Define false paths between different clock domains
set_false_path -from [get_clocks w_clk] -to [get_clocks r_clk]
set_false_path -from [get_clocks r_clk] -to [get_clocks w_clk]

# Set timing exceptions if needed (e.g., multicycle paths)
#set_multicycle_path -setup 2 -from [get_clocks w_clk] -to [get_clocks r_clk]
#set_multicycle_path -hold 1 -from [get_clocks w_clk] -to [get_clocks r_clk]
