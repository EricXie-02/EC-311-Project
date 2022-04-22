`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2022 02:55:47 PM
// Design Name: 
// Module Name: Store_2_Hex_tb
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


module Store_2_Hex_tb();
    reg [3:0] hex_in;
    reg is_guessing_pw,reset,enter;
    wire [15:0] guess_pw;
    wire [15:0] actual_pw;
    
    Store_2_Hex s2h_1(hex_in,is_guessing_pw,reset,enter,guess_pw,actual_pw);
    
    initial begin
        reset = 1'b1;
        is_guessing_pw = 1'b1;
        #5 reset = 1'b0;
        #5 hex_in = 4'b1111;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 is_guessing_pw = 1'b0;
        #5 hex_in = 4'b0000;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 is_guessing_pw = 1'b1;
        #5 hex_in = 4'b1010;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
     end
endmodule
