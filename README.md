# ALSU-using-Verilog-HDL
ALSU is a logic unit that can perform logical, arithmetic, and shift operations on input ports. 
Input ports A and B have various operations that can take place depending on the value of the opcode.
Each input bit except for the clk and rst will be sampled at the rising edge before any processing so a D-FF is expected for each input bit at the design entry.
The output of the ALSU is registered and is available at the rising edge of the clock.

![ALSU](https://github.com/Ahmed-Yahya-Mohammed/ALSU-using-Verilog-HDL/assets/131712865/3903a55d-dd96-4442-8188-8b192714498e)

Each input bit except for the clk and rst will have a DFF in front of its port. Any processing will take place from the DFF output.

![Inputs](https://github.com/Ahmed-Yahya-Mohammed/ALSU-using-Verilog-HDL/assets/131712865/12ed0883-7b87-4394-8a01-8d3c02e8c2f3)
