`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2022 08:58:06 PM
// Design Name: 
// Module Name: Main
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


module Main(
    input clk,
    input [3:0] hex_in,
    input reset,
    input set,
    input change,
    input enter,
    output reg [15:0] Current_Password,
    
    // SSD outputs
    output wire [7:0] Anode_Activate,
    output wire [6:0] LED_out
    
    
    //test outputs
    //output reg [1:0] state
    //,reg local_reset,
    //output wire [3:0] hex_guess1, hex_guess2, hex_guess3, hex_guess4, hex_set1, hex_set2, hex_set3, hex_set4
    );
    
    reg [1:0] state; //stores the current state of the lock (initial,locked,unlocked
    
    //Sets parameters of the states of the lock
    parameter INITIAL = 2'b00,
              LOCKED = 2'b01,
              UNLOCKED = 2'b10;    
    
    //stores 1 if the user is guessing a password, 0 if the user is setting the password
    reg IsGuessing_NotIsSetting; //enable for store hex
    
    //Stores the user's guess of the password
    wire [15:0] Guess_Password;
    
    //Stores what the user wants to change the password to
    wire [15:0] Password_Set;
    
    //Stores what the current password is
    //reg [15:0] Current_Password;
    
    //Stays as a 16 bit long undefined bus, used for resetting Current_Password
    reg [15:0] Undefined_16bit;
    
    //Reg used to reset guess_password and Password_Set to 
    reg local_reset;
    
    //Stores the most recent hex inputs of the guessing and setting mode
    wire [3:0] hex_guess1, hex_guess2, hex_guess3, hex_guess4, hex_set1, hex_set2, hex_set3, hex_set4;
    
    //Stores the number of hex numbers entered of the current guess or set
    reg [1:0] counter_guess, counter_set;

    
    Store_2_Hex S2H(hex_in,IsGuessing_NotIsSetting,local_reset,enter,Guess_Password,Password_Set,hex_guess1,hex_guess2,hex_guess3,hex_guess4,hex_set1,hex_set2,hex_set3,hex_set4);
    
    //always @(posedge reset, posedge set, posedge change, posedge enter) begin
    
    always @(*) begin
    
    //resets the state, counter, and is_setting_password
    if (reset == 1'b1) begin
        state = INITIAL;
        local_reset = 1'b1;
        IsGuessing_NotIsSetting = 1'b0;
        Current_Password = Undefined_16bit;
        
    end
    
    if (local_reset) begin
        local_reset = 1'b0;
    end
    
    case (state)
        //In initial state, we should be able to set the password
        INITIAL: begin
           if (change && Password_Set) begin //If the user presses change and Password_Set exists
                Current_Password = Password_Set;
           end
           else if(set && Current_Password) begin//If the user presses the set button and Password_Set exists
                state = LOCKED; 
                local_reset = 1'b1;
                IsGuessing_NotIsSetting = 1'b1; //User will begin to guess the password
           end
        end
        
        LOCKED: begin
        //In locked state, we should only be able to guess the password
            if(Guess_Password == Current_Password) begin
                state = UNLOCKED;
                local_reset = 1'b1;
                IsGuessing_NotIsSetting = 1'b0;
            end
        end
        
        UNLOCKED: begin
        //Basically behaves the same as initial state
            if(change && Password_Set) begin
                Current_Password = Password_Set;
            end
            if(set && Current_Password) begin
                state = LOCKED;
                local_reset = 1'b1;
                IsGuessing_NotIsSetting = 1'b1;
            end
        end
            
    endcase
    
    end
    
    /*
    always@(posedge clk) begin
        if(local_reset) begin
            local_reset = 1'b0;
        end
    end
    */
    
    hex_number_ssd ssd1(clk, reset, Anode_Activate, LED_out, state, hex_set1, hex_set2, hex_set3, hex_set4);//fill in to add the 4 hex numbers in setting mode
    
    
    
    
endmodule
