`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2019 05:52:12 PM
// Design Name: 
// Module Name: Mux32Bit3To1
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


module Mux32Bit3To1(inA, inB, inC, select, out);
    input [31:0] inA;
    input [31:0] inB;
    input [31:0] inC;
    input [1:0] select;
    output reg [31:0] out;
    
    always @(select, inA, inB, inC) begin
            if (select == 'b10 ) begin
                out <= inC;
            end 
            else if (select == 'b01) begin
                out <= inB;
            end
            else begin
                out <= inA;
            end
        end
    
endmodule
