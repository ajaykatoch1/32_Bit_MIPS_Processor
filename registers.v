`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2017 11:04:29 AM
// Design Name: 
// Module Name: registers
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


module RegisterFile( Clk, ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, ReadData1, ReadData2);
	input [4:0] ReadRegister1;
	input [4:0] ReadRegister2;
	input [31:0] WriteRegister;
	input [31:0] WriteData;
	
	input Clk, RegWrite;

	output reg [31:0] ReadData1;
	output reg [31:0] ReadData2;
    reg [31:0] Registers [0:31];
      // At falling edge of clk ReadRegister1 = ReadData1 (same applies for 2)
      // RegWrite = 1 @ rising edge of clk      
    
    initial begin
            Registers[0] <= 32'h0;
            Registers[1] <= 32'h0;
            Registers[2] <= 32'h0;
            Registers[3] <= 32'h0;
            Registers[4] <= 32'h0;
            Registers[5] <= 32'h0;
            Registers[6] <= 32'h0;
            Registers[7] <= 32'h0;
            Registers[8] <= 32'h0;
            Registers[9] <= 32'h0;
            Registers[10] <= 32'h0;
            Registers[11] <= 32'h0;
            Registers[12] <= 32'h0;
            Registers[13] <= 32'h0;
            Registers[14] <= 32'h0;
            Registers[15] <= 32'h0;
            Registers[16] <= 32'h0;
            Registers[17] <= 32'h0;
            Registers[18] <= 32'h0;
            Registers[19] <= 32'h0;
            Registers[20] <= 32'h0;
            Registers[21] <= 32'h0;
            Registers[22] <= 32'h0;
            Registers[23] <= 32'h0;
            Registers[24] <= 32'h0;
            Registers[25] <= 32'h0;
            Registers[26] <= 32'h0;
            Registers[27] <= 32'h0;
            Registers[28] <= 32'h0;
            Registers[29] <= 32'h0;
            Registers[30] <= 32'h0;
            Registers[31] <= 32'h0;
    end
    
    always @(posedge Clk)
        begin
            
            if (RegWrite == 1) 
            begin
                Registers[WriteRegister] <= WriteData;
            end
        end
        
        always @(negedge Clk)
        begin
            ReadData1 <= Registers[ReadRegister1];
            ReadData2 <= Registers[ReadRegister2];

        end

endmodule