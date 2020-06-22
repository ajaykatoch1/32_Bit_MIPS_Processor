`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2019 05:03:18 PM
// Design Name: 
// Module Name: PCAdderBranch
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


module PCAdderBranch(A, B, Out);
    input [31:0] A;
    input [15:0] B;
    output reg [31:0] Out;
    reg [17:0] temp;
    
    always @(*)
    begin
        temp = B << 2;
        Out = A + temp;
    end
endmodule
