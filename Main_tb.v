`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2022 09:35:01 PM
// Design Name: 
// Module Name: Main_tb
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


module Main_tb(); 
    reg clk;
    reg [3:0] hex_in;
    reg reset,set,change,enter;
    wire [15:0] current_password;
    //wire [1:0] state;
    //wire local_reset;
    //wire [3:0] hex_guess1, hex_guess2, hex_guess3, hex_guess4, hex_set1, hex_set2, hex_set3, hex_set4;
    wire [7:0] Anode_Activate;
    wire [6:0] LED_out;
    
    Main main1(clk,hex_in,reset,set,change,enter,current_password, Anode_Activate, LED_out);
    
    initial begin
        clk = 1'b0;
        reset = 1'b0;
        set = 1'b0;
        change = 1'b0;
        enter = 1'b0;
        
        #3 reset = 1'b1;
        #10 reset = 1'b0;
        #5 hex_in = 4'b1111;
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
        #5 hex_in = 4'b0000;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 hex_in = 4'b1111;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 hex_in = 4'b1010;
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
        #5 hex_in = 4'b0101;
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
        #5 hex_in = 4'b0000;
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
        #5 hex_in = 4'b0101;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 set = 1'b1;
        #5 set = 1'b0;
        #5 reset = 1'b1;
        #5 reset = 1'b0;
        #5 change = 1'b1;
        #5 change = 1'b0;
        #5 set = 1'b1;
        #5 set = 1'b0;
        
    
    
    end
    
    always begin
        #5 clk = ~clk;
    end

endmodule
