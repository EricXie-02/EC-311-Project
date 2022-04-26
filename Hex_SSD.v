`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2022 02:34:12 PM
// Design Name: 
// Module Name: hex_number_ssd
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


module Hex_SSD(
    input clock,
    input reset,
    output reg [7:0] Anode_Activate, // 8 anode signals for the SSD
    output reg [6:0] LED_out, // cathode patterns
    
    input [3:0] hex1,
    input [3:0] hex2,
    input [3:0] hex3,
    input [3:0] hex4,
    
    input enter,
    input lock,
    input unlock
//    input counter
    
    );
    reg [5:0] enumerated_state;
    reg [5:0] LED_BCD;
    reg [19:0] refresh_counter;
    
    wire [2:0] LED_activating_counter;
    
    reg [4:0] h1, h2, h3, h4;
    
    reg [1:0] state;
    
    
    
    
    
    
    always @(posedge clock)
    begin
        h1 <= {1'b0, hex1};
        h2 <= {1'b0, hex2};
        h3 <= {1'b0, hex3};
        h4 <= {1'b0, hex4};
    end
    
    
//    always @(posedge clock)
//    begin
//        if(state == 2'b00 || state == 2'b10)
//        begin
//            h1 <= 5'b10100;
//            h2 <= 5'b10100;
//            h3 <= 5'b10100;
//            h4 <= 5'b10100;
//        end
//        else if(state == 2'b00 && count == 2'b01)
//        begin
//            h1 <= {1'b0, hex1};
//            h2 <= 5'b10100;
//            h3 <= 5'b10100;
//            h4 <= 5'b10100;
//        end
//        else if(state == 2'b00 && count == 2'b01)
//        begin
//            h1 <= {1'b0, hex1};
//            h2 <= {1'b0, hex2};
//            h3 <= 5'b10100;
//            h4 <= 5'b10100;
//        end
//        else if(state == 2'b00 && count == 2'b10)
//        begin
//            h1 <= {1'b0, hex1};
//            h2 <= {1'b0, hex2};
//            h3 <= {1'b0, hex3};
//            h4 <= 5'b10100;
//        end
//        else if(state == 2'b00 && count == 2'b11)
//        begin
//            h1 <= {1'b0, hex1};
//            h2 <= {1'b0, hex2};
//            h3 <= {1'b0, hex3};
//            h4 <= {1'b0, hex4};
//        end
        
//    end

    
    
    always @(posedge clock)
    begin
        if(lock)
        begin
            state <= 2'b10;
            
        end
        else if(unlock)
        begin
            state <= 2'b01;
        end
        else if(enter)
        begin
            state <= 2'b00;
        end
    end
    
    
    always @(posedge clock, posedge reset)
    begin
        if(reset)
        begin
            refresh_counter <= 0;
            state <= 2'b00;
            
        end
        else
            refresh_counter <= refresh_counter + 1; 
    end
    
    assign LED_activating_counter = refresh_counter[19:17];
    
    always @(*)
    begin
        case(state)
            2'b00: enumerated_state <= 5'b10001; // initial
            2'b01: enumerated_state <= 5'b10011; // unlocked
            2'b10: enumerated_state <= 5'b10010; // locked
        endcase
    end
    
    
    
    always @(*)
    begin
        case(LED_activating_counter)
        3'b000: begin
            Anode_Activate = 8'b11101111; 
            // activate LED1 and Deactivate LED2, LED3, LED4
            LED_BCD = enumerated_state;
            // the first digit of the 16-bit number
              end
        3'b001: begin
            Anode_Activate = 8'b11110111; 
            // activate LED2 and Deactivate LED1, LED3, LED4
            LED_BCD = h1;
            // the second digit of the 16-bit number
              end
        3'b010: begin
            Anode_Activate = 8'b11111011; 
            // activate LED3 and Deactivate LED2, LED1, LED4
            LED_BCD = h2;
            // the third digit of the 16-bit number
                end
        3'b011: begin
            Anode_Activate = 8'b11111101; 
            // activate LED4 and Deactivate LED2, LED3, LED1
            LED_BCD = h3;
            // the fourth digit of the 16-bit number    
               end
        3'b100: begin
            Anode_Activate = 8'b11111110; 
            // activate LED4 and Deactivate LED2, LED3, LED1
            LED_BCD = h4;
            // the fourth digit of the 16-bit number    
               end
               
        3'b101: begin
            Anode_Activate = 8'b01111111; 
            // activate LED4 and Deactivate LED2, LED3, LED1
            LED_BCD = 5'b10100;
            // the fourth digit of the 16-bit number    
               end
        3'b110: begin
            Anode_Activate = 8'b10111111; 
            // activate LED4 and Deactivate LED2, LED3, LED1
            LED_BCD = 5'b10100;
            // the fourth digit of the 16-bit number    
               end
        3'b111: begin
            Anode_Activate = 8'b11011111; 
            // activate LED4 and Deactivate LED2, LED3, LED1
            LED_BCD = 5'b10100;
            // the fourth digit of the 16-bit number    
               end               
        endcase
    end
    // Cathode patterns of the 7-segment LED display 
    always @(*)
    begin
        case(LED_BCD)
        5'b00000: LED_out = 7'b0000001; // "0"     
        5'b00001: LED_out = 7'b1001111; // "1" 
        5'b00010: LED_out = 7'b0010010; // "2" 
        5'b00011: LED_out = 7'b0000110; // "3" 
        5'b00100: LED_out = 7'b1001100; // "4" 
        5'b00101: LED_out = 7'b0100100; // "5" 
        5'b00110: LED_out = 7'b0100000; // "6" 
        5'b00111: LED_out = 7'b0001111; // "7" 
        5'b01000: LED_out = 7'b0000000; // "8"     
        5'b01001: LED_out = 7'b0000100; // "9"
        
        5'b01010: LED_out = 7'b0001000; // "10-A"
        5'b01011: LED_out = 7'b1100000; // "11-B"
        5'b01100: LED_out = 7'b0110001; // "12-C"
        5'b01101: LED_out = 7'b1000010; // "13-D"
        5'b01110: LED_out = 7'b0110000; // "14-E"
        5'b01111: LED_out = 7'b0111000; // "15-F"
        
        5'b10001: LED_out = 7'b1111001; // "I"
        5'b10010: LED_out = 7'b1000001; // "U"
        5'b10011: LED_out = 7'b1110001; // "L"
        
        5'b10100: LED_out = 7'b1111111; // "turned off"
        
        default: LED_out = 7'b0000001; // "0"
        endcase
    end
    
    
endmodule

