`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2022 04:28:38 PM
// Design Name: 
// Module Name: Store_Hex
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

//Takes in a 4 bit binary number and stores the number when enter is high, when four 4 bit numbers are entered
//the module then concatenates the 4 numbers into the output password
module Store_Hex(
    //Input hex_in takes in a 4 bit binary number representing the position of the switches
    input [3:0] hex_in,
    //Input reset resets the hex input process by resetting the counter
    input reset,
    //Input enter stores the current hex_in into hex[i]
    input enter,
    //Output of the 4 hex number inputs as a 16 bit password
    output reg [15:0] password
    );
    
    //Counts the number of hex numbers the user has entered, when it reaches 2'b11 and the user presses enter,
    //the 4 stored hex numbers are concatenated into password
    reg [1:0] counter;
    //hex[i] stores the past inputted hex numbers
    reg [3:0] hex1,hex2,hex3,hex4;
    
    always @(enter or reset)begin
        if(reset) begin
            counter = 2'b00;
        end
        else if(enter) begin
            case(counter)
                2'b00: begin
                    hex1 = hex_in;
                    counter = counter + 2'b01;
                end
                2'b01: begin
                    hex2 = hex_in;
                    counter = counter + 2'b01;
                end
                2'b10: begin
                    hex3 = hex_in;
                    counter = counter + 2'b01;
                end
                2'b11: begin
                    hex4 = hex_in;
                    counter = 2'b00;
                    password = {hex1,hex2,hex3,hex4};
                end
            
            endcase
        end
    end
    
    
    
endmodule
