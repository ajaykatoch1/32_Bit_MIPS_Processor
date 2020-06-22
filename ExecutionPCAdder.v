`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2019 02:29:28 PM
// Design Name: 
// Module Name: ExecutionPCAdder
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
module PCAdderJump(A, B, Out);
    input [31:0] A;
    input [25:0] B;
    output [31:0] Out;
    assign Out = {A[31:28], (B << 2)};
endmodule

