# ALSU-using-Verilog-HDL
ALSU is a logic unit that can perform logical, arithmetic, and shift operations on input ports. 
Input ports A and B have various operations that can take place depending on the value of the opcode.
Each input bit except for the clk and rst will be sampled at the rising edge before any processing so a D-FF is expected for each input bit at the design entry.
The output of the ALSU is registered and is available at the rising edge of the clock.

![ALSU](https://github.com/Ahmed-Yahya-Mohammed/ALSU-using-Verilog-HDL/assets/131712865/3903a55d-dd96-4442-8188-8b192714498e)

Each input bit except for the clk and rst will have a DFF in front of its port. Any processing will take place from the DFF output.

![Inputs](https://github.com/Ahmed-Yahya-Mohammed/ALSU-using-Verilog-HDL/assets/131712865/12ed0883-7b87-4394-8a01-8d3c02e8c2f3)

Outputs and parameters.

![Outputs](https://github.com/Ahmed-Yahya-Mohammed/ALSU-using-Verilog-HDL/assets/131712865/4cce21e0-ef31-43a4-87dc-57aca7daa7c1)
![Parameters](https://github.com/Ahmed-Yahya-Mohammed/ALSU-using-Verilog-HDL/assets/131712865/55b4e32a-72b1-4b81-94f8-673750482edd)

Opcode.

![Opcode](https://github.com/Ahmed-Yahya-Mohammed/ALSU-using-Verilog-HDL/assets/131712865/037782c1-fac2-453b-94e2-3c32dfbf741d)

Invalid cases
1. Opcode bits are set to 110 or 111
2. red_op_A or red_op_B are set to high and the opcode is not AND or XOR operation

Output when invalid cases occurs
1. leds are blinking
2. out bits are set to low
