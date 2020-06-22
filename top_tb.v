`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Ariel Villasenor: 50%
// Ajay Katoch: 50%
// 
// Create Date: 10/16/2019 10:38:45 PM
// Design Name: 
// Module Name: top_tb
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


module top_tb();

reg Reset, Clk;
wire [31:0] Result, PC, LO, HI; 
wire RegWrite;

top Test(
    .Clk(Clk),
    .Reset(Reset),
    .MEMWB_DataResult(Result),
    .PCResult(PC),
    .ALUlo(LO),
    .ALUhi(HI),
    .MEMWB_RegWrite(RegWrite)
);

initial begin
   Reset = 0;
    Clk <= 1'b0;
    forever #10 Clk <= ~Clk;
end

always @(posedge Clk) begin
            // Start Test @ Reset = 0
            Reset = 0;
            #5;
            //Start Test @ Reset = 1
            //Reset = 1;
            //#10;
       end

endmodule
