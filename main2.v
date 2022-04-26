`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2022 03:27:03 PM
// Design Name: 
// Module Name: main2
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


module main2(
    input clk,
    input [3:0] hex_in,
    input reset,
    input set,
    input change,
    input enter,
    input attempt_unlock,
    //output reg [15:0] Current_Password,
    
    // SSD outputs
    output wire [7:0] Anode_Activate,
    output wire [6:0] LED_out,
    
    output reg [1:0] state,
    output reg [15:0] Current_4hex_Enter,
    output reg [15:0] Current_Password
    
    
    );
    
    //Stores represents the state of the lock
    //reg [1:0] state;
    
    //Sets parameters of the states of the lock
    parameter INITIAL = 2'b00,
              LOCKED = 2'b01,
              UNLOCKED = 2'b10; 
              
        //Stores the user's guess of the password
    //reg [15:0] Guess_Password;
    
    //Stores what the user wants to change the password to
    //reg [15:0] Password_Set;
    
    //Stores what the current password is
    //reg [15:0] Current_Password;
    
    //Stays as a 16 bit long undefined bus, used for resetting Current_Password
    reg [15:0] Undefined_16bit;
    
    //Stores the number of hex numbers entered of the current guess or set
    reg [2:0] counter;
    
    wire hex1,hex2,hex3,hex4;
    
    always@(*) begin
        if (reset) begin
            state = INITIAL;
            Current_4hex_Enter = Undefined_16bit;
            Current_Password = Undefined_16bit;
            counter = 3'b000;
        end
        
        case (state)
            LOCKED: begin
                
                if(attempt_unlock && counter == 3'b100) begin
                    if(Current_4hex_Enter == Current_Password) begin
                        state = UNLOCKED;
                    end
                    Current_4hex_Enter = Undefined_16bit;
                    counter = 3'b000;
                end
                
                else if(enter) begin
                    case (counter)
                        3'b000: begin
                            Current_4hex_Enter[15:12] = hex_in;
                            counter = 3'b001;
                        end
                        3'b001: begin
                            Current_4hex_Enter[11:8] = hex_in;
                            counter = 3'b010;
                        end
                        3'b010: begin
                            Current_4hex_Enter[7:4] = hex_in;
                            counter = 3'b011;
                        end
                        3'b011: begin
                            Current_4hex_Enter[3:0] = hex_in;
                            counter = 3'b100;
                        end
                        3'b100: begin
                            Current_4hex_Enter[3:0] = hex_in;
                            counter = 3'b001;
                        end
                        
                        
                    endcase
            end
            end
            
            default: begin //UNLOCKED OR INITIAL
                if(change && counter == 3'b100) begin
                     Current_Password = Current_4hex_Enter;
                     counter = 3'b000;
                     Current_4hex_Enter = Undefined_16bit;
                end
                else if(set) begin
                    if(Current_Password || Current_Password == 16'b000000000000) begin
                        state = LOCKED;
                    end
                end  
                
                else if(enter) begin
                    case(counter)
                        3'b000: begin
                            Current_4hex_Enter[15:12] = hex_in;
                            counter = 3'b001;
                        end
                        3'b001: begin
                            Current_4hex_Enter[11:8] = hex_in;
                            counter = 3'b010;
                        end
                        3'b010: begin
                            Current_4hex_Enter[7:4] = hex_in;
                            counter = 3'b011;
                        end
                        3'b011: begin
                            Current_4hex_Enter[3:0] = hex_in;
                            counter = 3'b100;
                        end
                        3'b100: begin
                            Current_4hex_Enter[3:0] = hex_in;
                            counter = 3'b001;
                        end
                    endcase
                end 
            end
            
        endcase
    end
    
    assign hex1 = Current_4hex_Enter[15:12];
    assign hex2 = Current_4hex_Enter[11:8];
    assign hex3 = Current_4hex_Enter[7:4];
    assign hex4 = Current_4hex_Enter[3:0];
    
    
    
endmodule
