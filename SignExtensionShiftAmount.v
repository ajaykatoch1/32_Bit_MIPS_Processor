`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2019 12:17:20 PM
// Design Name: 
// Module Name: SignExtensionShiftAmount
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


module SignExtensionShiftAmount(Input, Output );
    /* A 16-Bit input word */
input [4:0] Input;

/* A 32-Bit output word */
output reg [31:0] Output;   //using always @
//output [31:0] out;   //using assign stateme
parameter ONES = 27'b111111111111111111111111111, ZEROES = 27'b000000000000000000000000000;

always @(Input) 
    begin
        Output <= {ZEROES, Input};
    end
endmodule
