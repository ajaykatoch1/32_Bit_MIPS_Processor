`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2018 08:19:45 PM
// Design Name: 
// Module Name: ForwardingUnit
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


module ForwardingUnit(RegisterDestination, EX_RegisterWrite, Instruction, MEM_RegisterRd, MEM_RegisterWrite, WB_RegisterRd, WB_RegisterWrite, InputAMuxSignal, InputBMuxSignal, WriteDataMuxSignal);
input [31:0] RegisterDestination;
input [31:0]Instruction;
input [31:0]MEM_RegisterRd;
input [31:0]WB_RegisterRd;
input EX_RegisterWrite, MEM_RegisterWrite, WB_RegisterWrite;
output reg [1:0] InputAMuxSignal, InputBMuxSignal, WriteDataMuxSignal;
reg [31:0]EX_Rt; // Bits 20-16
reg [31:0]EX_Rs; // Bits 25-21
reg [5:0]Opcode;
reg [5:0]Function;

always @(*)begin
EX_Rt <= Instruction[20:16];
EX_Rs <= Instruction[25:21];
Opcode <= Instruction[31:26];
Function <= Instruction[5:0];

/*Checks if rs regsiter rs equal to register desination in Memory stage*/
if(((EX_Rs == MEM_RegisterRd) && (MEM_RegisterWrite == 'b1)) && ((EX_Rt == WB_RegisterRd) && (WB_RegisterWrite == 'b1)))begin
    if(Opcode=='b101011 || Opcode=='b101000 || Opcode=='b101001)begin
    WriteDataMuxSignal <= 'b10;
    end
    else begin
    WriteDataMuxSignal <= 'b00;
    end
    InputAMuxSignal <= 'b01;
    InputBMuxSignal <= 'b10;
end
else if(((EX_Rs == MEM_RegisterRd) && (MEM_RegisterWrite == 'b1)) && !((EX_Rt == WB_RegisterRd) && (WB_RegisterWrite == 'b1)))begin
    InputAMuxSignal <= 'b01;
    InputBMuxSignal <='b00;
end
else if(!((EX_Rs == MEM_RegisterRd) && (MEM_RegisterWrite == 1)) && ((EX_Rt == WB_RegisterRd) && (WB_RegisterWrite == 1)))begin
    if(Opcode=='b101011 || Opcode=='b101000 || Opcode=='b101001)begin // sw, sh, sb
    if(RegisterDestination == WB_RegisterRd)begin
    InputAMuxSignal <= 'b00;
    InputBMuxSignal <='b00;
    WriteDataMuxSignal <= 'b10;
    end
    else begin
    InputAMuxSignal <= 'b00;
    InputBMuxSignal <='b10;
    WriteDataMuxSignal <= 'b00;
    end
    end
    //loads
    else if((Opcode == 'b100011 || Opcode == 'b100001 || Opcode == 'b100000))begin //lw, lh, lb
    InputAMuxSignal <= 'b10;
    InputBMuxSignal <='b00;
    WriteDataMuxSignal <= 'b00;
    end
    
    //Arithmetic
    else begin
    if((RegisterDestination == WB_RegisterRd) && (EX_RegisterWrite == 1))begin //This should work, may need to include second RegDst signal that is used for JAL
    InputAMuxSignal <='b00;
    InputBMuxSignal <='b00;
    WriteDataMuxSignal <= 'b00;
    end
    else begin
    InputAMuxSignal <='b00;
    InputBMuxSignal <='b10;
    WriteDataMuxSignal <= 'b00;
    end
    end
end
// RT dependencies
else if(((EX_Rt == MEM_RegisterRd) && (MEM_RegisterWrite == 'b1)) && ((EX_Rs == WB_RegisterRd) && (WB_RegisterWrite == 'b1)))begin
    if(Opcode=='b101011 || Opcode=='b101000 || Opcode=='b101001)begin
    WriteDataMuxSignal <= 'b01;
    end
    else begin
    WriteDataMuxSignal <= 'b00;
    end
    InputAMuxSignal <='b10;
    InputBMuxSignal <='b01;
end
else if(((EX_Rt == MEM_RegisterRd) && (MEM_RegisterWrite == 'b1)) && !((EX_Rs == WB_RegisterRd) && (WB_RegisterWrite == 'b1)))begin
    if(Opcode=='b101011 || Opcode=='b101000 || Opcode=='b101001)begin // sw, sh, sb
        if(RegisterDestination == MEM_RegisterRd)begin
            InputAMuxSignal <= 'b00;
            InputBMuxSignal <='b00;
            WriteDataMuxSignal <= 'b01;
        end
        else begin
            InputAMuxSignal <= 'b00;
            InputBMuxSignal <='b01;
            WriteDataMuxSignal <= 'b00;
        end
    end
    //loads
    else if(!(Opcode=='b000000 || Opcode=='b011100 || Opcode=='b011111 || Opcode=='b000101 || Opcode=='b000100))begin //if not rd, rs, rt or rs, rt (arithmetic, beq, bne)
        InputAMuxSignal <= 'b00;
        InputBMuxSignal <='b00;
        WriteDataMuxSignal <= 'b00;
    end
    //Arithmetic
    /*else begin
    if((RegisterDestination == MEM_RegisterRd) && (EX_RegisterWrite == 1))begin //This should work, may need to include second RegDst signal that is used for JAL
    InputAMuxSignal <='b00;
    InputBMuxSignal <='b00;
    WriteDataMuxSignal <= 'b00;
    end*/
    else begin
    InputAMuxSignal <='b00;
    InputBMuxSignal <='b01;
    WriteDataMuxSignal <= 'b00;
    end
    //end
end
else if(!((EX_Rt == MEM_RegisterRd) /*&& (MEM_RegisterWrite == 'b1)*/) && ((EX_Rs == WB_RegisterRd) && (WB_RegisterWrite == 'b1)))begin
    InputAMuxSignal <='b10;
    InputBMuxSignal <='b00;
end
/**/
else begin
    WriteDataMuxSignal <= 'b00;
    InputAMuxSignal <= 'b00;
    InputBMuxSignal <= 'b00;
end

end

endmodule