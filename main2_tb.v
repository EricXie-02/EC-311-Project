`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2022 03:47:25 PM
// Design Name: 
// Module Name: main2_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module main2_tb();
    reg clk, reset, set, change, enter, attempt_unlock;
    reg [3:0] hex_in;
    wire [7:0] Anode_Activate;
    wire [6:0] LED_out;
    wire [1:0] state;
    wire [15:0] Current_4hex_Enter;
    wire [15:0] Current_Password;
    
    main2 m2(clk,hex_in,reset, set, change, enter, attempt_unlock, Anode_Activate,LED_out,state,Current_4hex_Enter,Current_Password);
    
    initial begin
        clk = 0;
        reset = 0;
        set = 0;
        change = 0;
        enter = 0;
        attempt_unlock = 0;
        hex_in = 4'b0000;
        
        #5 reset = 1'b1;
        #5 reset = 1'b0;
        
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        
        #5 change = 1'b1;
        #5 change = 1'b0;
        
        #5 set = 1'b1;
        #5 set = 1'b0;
        
        #5 hex_in = 4'b1111;
        
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        
        #5 attempt_unlock = 1'b1;
        #5 attempt_unlock = 1'b0;
        
        #5 hex_in = 4'b0000;
        
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        
        #5 attempt_unlock = 1'b1;
        #5 attempt_unlock = 1'b0;
        
        #5 hex_in = 4'b1010;
        
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        
        #5 change = 1'b1;
        #5 change = 1'b0;
        
        
    end

endmodule
