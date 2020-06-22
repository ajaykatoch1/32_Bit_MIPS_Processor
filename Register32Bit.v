`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2019 07:49:10 PM
// Design Name: 
// Module Name: Register32Bit
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


module Register32Bit(Clk, In, Out);
input Clk; 
input [31:0]In;
reg [31:0] temp;
output reg [31:0] Out;

always @(posedge Clk)
        begin
            temp = In;
        end
always @(negedge Clk)
        begin
            Out = temp;
        end
endmodule
