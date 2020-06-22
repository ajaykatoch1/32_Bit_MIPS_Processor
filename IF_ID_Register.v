`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2019 03:20:25 PM
// Design Name: 
// Module Name: IF_ID_Register
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


module IF_ID_Register(Clock, IF_ID_Signal, InstructionIn, PCResultIn, InstructionOut, PCResultOut);
input Clock;
input [1:0] IF_ID_Signal;
input [31:0] InstructionIn;
input [31:0] PCResultIn;
reg [31:0]PreviousInstruction;
reg [31:0]PreviousPCResultOut;
output reg [31:0] InstructionOut;
output reg [31:0] PCResultOut;

always @( posedge Clock)
    begin
    if(IF_ID_Signal == 1)begin //This is for stalling
    InstructionOut = PreviousInstruction;
    PCResultOut = PreviousPCResultOut;
    end
    else if(IF_ID_Signal == 2)begin //This is for flushing
    InstructionOut = 0;
    PCResultOut = 0;
    end
    else begin
    //PreviousInstruction = InstructionOut;
    InstructionOut = InstructionIn;
    //PreviousPCResultOut = PCResultOut;
    PCResultOut = PCResultIn;
    end
    end
always @( negedge Clock) begin
    PreviousInstruction = InstructionOut;
    PreviousPCResultOut = PCResultOut;
    end
endmodule
