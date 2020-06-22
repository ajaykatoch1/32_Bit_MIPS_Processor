`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2019 09:28:51 PM
// Design Name: 
// Module Name: Mux5Bit2To1
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


module Mux5Bit2To1(inA, inB, sel, out);

    output reg [31:0] out;
    
    input [4:0] inA;
    input [4:0] inB;
    input sel;

    always @(sel, inA, inB) begin
        if (sel == 0) begin
            out <= inA;
        end 
        else begin
            out <= inB;
        end
    end

endmodule
