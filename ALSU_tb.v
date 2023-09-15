module ALSU_tb();
    reg clk_tb,rst_tb,cin_tb,serial_in_tb,red_op_A_tb,red_op_B_tb,bypass_A_tb,bypass_B_tb,direction_tb;
    reg[2:0] A_tb,B_tb,opcode_tb;
    wire[15:0] leds_tb;
    wire[5:0] out_tb;
    integer i;

    ALUS DUT(clk_tb,rst_tb,A_tb,B_tb,opcode_tb,cin_tb,serial_in_tb,red_op_A_tb,
    	      red_op_B_tb,bypass_A_tb,bypass_B_tb,direction_tb,out_tb,leds_tb);

    initial begin
    	clk_tb=0;
    	forever
    	#1 clk_tb=~clk_tb;
    end
    initial begin
    	//test reset
    	rst_tb=1;
        for(i=0;i<20;i=i+1)begin
        	A_tb=$random;
        	B_tb=$random;
        	opcode_tb=$random;
        	#4;
        end

        //test bypass
        rst_tb=0;
        bypass_A_tb=1;
        bypass_B_tb=1;
        for(i=0;i<20;i=i+1)begin
        	A_tb=$random;
        	B_tb=$random;
        	opcode_tb=$random;
        	#4;
        end
        bypass_A_tb=0;
        for(i=0;i<20;i=i+1)begin
        	A_tb=$random;
        	B_tb=$random;
        	opcode_tb=$random;
        	#4;
        end


        //test AND operation
        bypass_B_tb=0;
        opcode_tb=0;
        for(i=0;i<60;i=i+1)begin
            if(i<20)begin
            red_op_A_tb=1;
            red_op_B_tb=1;
            A_tb=$random;
            B_tb=$random;
            #4;
            end
            else if (i<40) begin
            red_op_A_tb=0;
            red_op_B_tb=1;
            A_tb=$random;
            B_tb=$random;
            #4;
            end
            else begin
            red_op_A_tb=0;
            red_op_B_tb=0;
            A_tb=$random;
            B_tb=$random;
            #4;  
            end
        end
        //test XOR operation
        opcode_tb=1;
        for(i=0;i<60;i=i+1)begin
            if(i<20)begin
            red_op_A_tb=1;
            red_op_B_tb=1;
            A_tb=$random;
            B_tb=$random;
            #4;
            end
            else if (i<40) begin
            red_op_A_tb=0;
            red_op_B_tb=1;
            A_tb=$random;
            B_tb=$random;
            #4;
            end
            else begin
            red_op_A_tb=0;
            red_op_B_tb=0;
            A_tb=$random;
            B_tb=$random;
            #4;  
            end
        end  
        //test addition operation
        opcode_tb=2;
        for(i=0;i<100;i=i+1)begin
            A_tb=$random;
            B_tb=$random;
            cin_tb=$random;
            #4;
        end   
         //test multiplication operation
        opcode_tb=3;
        for(i=0;i<100;i=i+1)begin
            A_tb=$random;
            B_tb=$random;
            #4;
        end 
        //test shifting operation
        opcode_tb=4;
        for(i=0;i<100;i=i+1)begin
            if(i<50)begin
             direction_tb=1;
             serial_in_tb=$random;
            #4;
            end
            else begin
            direction_tb=0;
            serial_in_tb=$random;
            #4;  
            end
        end 
        //test rotation operation
        opcode_tb=5;
        for(i=0;i<100;i=i+1)begin
            if(i<50)begin
             direction_tb=1;
            #4;
            end
            else begin
             direction_tb=0;
            #4;  
            end
        end 
         //test Invalid cases
        for(i=0;i<100;i=i+1)begin
            opcode_tb=$urandom_range(6,7);
            A_tb=$random;
            B_tb=$random;
            #4;  
        end 
        for(i=0;i<100;i=i+1)begin
            red_op_A_tb=1;
            opcode_tb=$urandom_range(2,7);
            A_tb=$random;
            B_tb=$random;
            #4;  
        end 
        $stop;
    end
endmodule

