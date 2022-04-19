`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2022 06:51:10 PM
// Design Name: 
// Module Name: Store_Hex_tb
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


module Store_Hex_tb();
    reg [3:0] hex_in;
    reg reset, enter;
    wire [15:0] password;
    
    Store_Hex sh1(hex_in,reset,enter,password);
    
    initial begin
        hex_in = 4'b1100;
        #5 reset = 1'b1;
        #5 reset = 1'b0;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 hex_in = 4'b1111;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 hex_in = 4'b0000;
        #5 enter = 1'b1;
        #5 enter = 1'b0;
        #5 hex_in = 4'b0011;
        #5 enter = 1'b1;
    end
endmodule
