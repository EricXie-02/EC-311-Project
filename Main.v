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
    input [3:0] hex_in,
    input reset,
    input set,
    input change,
    input enter,
    output reg [15:0] current_password
    );
    
    reg state; //stores the current state of the lock (initial,locked,unlocked
    
    //Sets parameters of the states of the lock
    parameter INITIAL = 2'b00;
    parameter LOCKED = 2'b01;
    parameter UNLOCKED = 2'b10;    
    
    //stores 1 if the user is guessing a password, 0 if the user is setting the password
    reg IsGuessing_NotIsSetting;
    
    //Stores the user's guess of the password
    reg [15:0] Guess_Password;
    
    //Stores what the user wants to change the password to
    reg [15:0] Password_Set;
    
    //Stores what the current password is
    reg [15:0] Current_Password;
    
    //Stays as a 16 bit long undefined bus, used for resetting, Guess_Password,Password_Set, and Current_Password
    reg [15:0] Undefined_16bit;
    
    
    Store_2_Hex S2H(hex_in,IsGuessing_NotIsSetting,reset,enter,Guess_Password,Password_Set);
    
    
    
    always @(posedge reset, posedge set, posedge change, Guess_Password) begin
    
    //resets the state, counter, and is_setting_password
    if (reset == 1'b1) begin
        state = INITIAL;
        IsGuessing_NotIsSetting = 1'b0;
        Guess_Password = Undefined_16bit;
        Current_Password = Undefined_16bit;
        Current_Password = Undefined_16bit;
    end
    
    case (state)
        //In initial state, we should be able to set the password
        INITIAL: begin
           if (change && Password_Set) begin //If the user presses change and Password_Set exists
                Current_Password = Password_Set;
           end
           else if(set && Current_Password) begin//If the user presses the set button and Password_Set exists
                state = LOCKED; 
                Password_Set = Undefined_16bit; //Reset PassWord_Set for later
                IsGuessing_NotIsSetting = 1'b1; //User will begin to guess the password
           end
        end
        
        LOCKED: begin
        //In locked state, we should only be able to guess the password
            if(Guess_Password == Current_Password) begin
                state = UNLOCKED;
                Guess_Password = Undefined_16bit;
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
                Password_Set = Undefined_16bit;
                IsGuessing_NotIsSetting = 1'b1;
            end
        end
            
            
    endcase
    
    end
endmodule
