module ALSU(clk,rst,A,B,opcode,cin,serial_in,red_op_A,red_op_B,bypass_A,bypass_B,direction,out,leds);
    parameter INPUT_PRIORITY="A";
    parameter FULL_ADDER="ON";
    input clk,rst,cin,serial_in,red_op_A,red_op_B,bypass_A,bypass_B,direction;
    input[2:0] A,B,opcode;
    output reg[15:0] leds;
    output reg[5:0] out;
    reg[2:0] A_samp,B_samp,opcode_samp;
    reg cin_samp,serial_in_samp,red_op_A_samp,red_op_B_samp,bypass_A_samp,bypass_B_samp,direction_samp;
    
    always @(posedge clk or posedge rst) begin
    	if (rst) begin
      A_samp<=0;
      B_samp<=0;
      opcode_samp<=0;
      cin_samp<=0;
      serial_in_samp<=0;
      red_op_A_samp<=0;
      red_op_B_samp<=0;
      bypass_A_samp<=0;
      bypass_B_samp<=0;
      direction_samp<=0;
      end
      else begin
      A_samp<=A;
    	B_samp<=B;
    	opcode_samp<=opcode;
    	cin_samp<=cin;
    	serial_in_samp<=serial_in;
    	red_op_A_samp<=red_op_A;
    	red_op_B_samp<=red_op_B;
    	bypass_A_samp<=bypass_A;
    	bypass_B_samp<=bypass_B;
    	direction_samp<=direction;
      end
    end

    always @(posedge clk or posedge rst) begin
    	if (rst)begin 
    	    out<=6'b000_000;
          leds<=16'b0000_0000_0000_0000;
          end	
    	else begin
    	    if (bypass_A_samp&&bypass_B_samp)begin 
    	        if(INPUT_PRIORITY=="A")
    	        out<=A_samp;
    	        else if(INPUT_PRIORITY=="B")
    	        out<=B_samp;
    	        end
    	    else if(bypass_A_samp)
    	        out<=A_samp;
    	    else if(bypass_B_samp)
    	        out<=B_samp;
    	    else             
    		case(opcode_samp)
    		3'b000:
    		begin
    			if(red_op_A_samp && red_op_B_samp)begin
    			  if(INPUT_PRIORITY=="A")
    			  out<=&A_samp;
    			  else if(INPUT_PRIORITY=="B")
    			  out<=&B_samp;
            end
    			else if(red_op_A_samp)
    			  out<=&A_samp;
    			else if(red_op_B_samp)
    			  out<=&B_samp;
    			else 
    			  out<=A_samp&B_samp;   
    		end
    		3'b001:
    		begin
    			if(red_op_A_samp && red_op_B_samp)begin
    			  if(INPUT_PRIORITY=="A")
    			  out<=^A_samp;
    			  else if(INPUT_PRIORITY=="B")
    			  out<=^B_samp;
            end
    			else if(red_op_A_samp)
    			  out<=^A_samp;
    			else if(red_op_B_samp)
    			  out<=^B_samp;
    			else 
    			  out<=A_samp^B_samp; 
    		end
    		3'b010:
    		begin
          if(red_op_A_samp || red_op_B_samp)begin
            out<=6'b000_000;
            leds<=16'b1111_1111_1111_1111;
            leds<=~leds;
          end
          else begin
    			if(FULL_ADDER=="ON")
    			  out<=A_samp+B_samp+cin_samp;
    			else if(FULL_ADDER=="OFF")  
    			  out<=A_samp+B_samp;
          end  
        end
    		3'b011:
    		begin
          if(red_op_A_samp || red_op_B_samp)begin
            out<=6'b000_000;
            leds<=16'b1111_1111_1111_1111;
            leds<=~leds;
          end
          else
    			out<=A_samp*B_samp;
    		end
    		3'b100:
    		begin
          if(red_op_A_samp || red_op_B_samp)begin
            out<=6'b000_000;
            leds<=16'b1111_1111_1111_1111;
            leds<=~leds;
          end
          else begin
    			if(direction_samp)
            out<={out[4:0],serial_in_samp};
          else
            out<={serial_in_samp,out[5:1]};
          end        
    		end
    		3'b101:
    		begin
            if(red_op_A_samp || red_op_B_samp)begin
             out<=6'b000_000;
             leds<=16'b1111_1111_1111_1111;
             leds<=~leds;
            end 
            else begin
    		    if(direction_samp)
              out<={out[4:0],out[5]};
            else
              out<={out[0],out[5:1]};	
            end  
    		end
    		default:
    		begin
    			out<=6'b000_000;
    			leds<=16'b1111_1111_1111_1111;
    			leds<=~leds;
    		end
    		endcase
    	end
  end    
endmodule