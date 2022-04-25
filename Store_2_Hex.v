`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2022 02:42:50 PM
// Design Name: 
// Module Name: Store_2_Hex
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

//This module instantiates two Store_Hex modules
//These modules share the same hex_in,reset, and enter
//They have seperate outputs, Four_hex1 and Four_hex2
//They have opposite enables meaning we will only store to one module at a time
module Store_2_Hex(
    input [3:0] hex_in,
    input enable,reset,enter,
    output [15:0] Four_hex1,
    output [15:0] Four_hex2,
    output [3:0] hex_guess1, hex_guess2, hex_guess3, hex_guess4, hex_set1, hex_set2, hex_set3, hex_set4,
    output [1:0] counter_guess, counter_set
    );
    
    Store_Hex store_guess(hex_in,reset,enter,enable,Four_hex1, hex_guess1, hex_guess2, hex_guess3, hex_guess4,counter_guess);
    Store_Hex store_set(hex_in,reset,enter,~enable,Four_hex2, hex_set1, hex_set2, hex_set3, hex_set4,counter_set);
endmodule
