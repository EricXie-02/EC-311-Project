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
    output reg [15:0] Guess_Password,
    output reg [15:0] Password_Set,
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
    reg [2:0] counter_guess, counter_set;
    
    always@(*) begin
        if (reset) begin
            state = INITIAL;
            Guess_Password = Undefined_16bit;
            Password_Set = Undefined_16bit;
            Current_Password = Undefined_16bit;
            counter_guess = 3'b000;
            counter_set = 3'b000;
        end
        
        case (state)
            LOCKED: begin
                
                if(attempt_unlock) begin
                    if(Guess_Password == Current_Password) begin
                        state = UNLOCKED;
                        counter_guess = 3'b000;
                    end
                    Guess_Password = Undefined_16bit;
                end
                
                else if(enter) begin
                    case (counter_guess)
                        3'b000: begin
                            Guess_Password[15:12] = hex_in;
                            counter_guess = 3'b001;
                        end
                        3'b001: begin
                            Guess_Password[11:8] = hex_in;
                            counter_guess = 3'b010;
                        end
                        3'b010: begin
                            Guess_Password[7:4] = hex_in;
                            counter_guess = 3'b011;
                        end
                        3'b011: begin
                            Guess_Password[3:0] = hex_in;
                            counter_guess = 3'b100;
                        end
                        3'b100: begin
                            Guess_Password[3:0] = hex_in;
                            counter_guess = 3'b001;
                        end
                        
                        
                    endcase
            end
            end
            
            default: begin //UNLOCKED OR INITIAL
                if(change) begin
                    if(Password_Set || Password_Set == 16'b000000000000) begin
                        Current_Password = Password_Set;
                        counter_set = 3'b000;
                        Password_Set = Undefined_16bit;
                    end
                end
                else if(set) begin
                    if(Current_Password || Current_Password == 16'b000000000000) begin
                        state = LOCKED;
                    end
                end  
                
                else if(enter) begin
                    case(counter_set)
                        3'b000: begin
                            Password_Set[15:12] = hex_in;
                            counter_set = 3'b001;
                        end
                        3'b001: begin
                            Password_Set[11:8] = hex_in;
                            counter_set = 3'b010;
                        end
                        3'b010: begin
                            Password_Set[7:4] = hex_in;
                            counter_set = 3'b011;
                        end
                        3'b011: begin
                            Password_Set[3:0] = hex_in;
                            counter_set = 3'b100;
                        end
                        3'b100: begin
                            Password_Set[3:0] = hex_in;
                            counter_set = 3'b001;
                        end
                    endcase
                end 
            end
            
        endcase
    end
    
    
    
endmodule
