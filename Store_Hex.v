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


module Store_Hex(
    input [3:0] hex_in,
    input reset,
    input enter,
    output reg [15:0] password
    );
    
    reg [1:0] counter;
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
