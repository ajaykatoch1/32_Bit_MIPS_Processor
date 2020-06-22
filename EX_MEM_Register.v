module EX_MEM_Register(Clock, EX_MEM_Signal, InstructionIn, ReadData2In, MemWriteIn, MemReadIn, MemToRegIn, RegWriteIn, WriteRegisterIn, ALUResultIn, 
                                             InstructionOut, ReadData2Out, MemWriteOut, MemReadOut, MemToRegOut, RegWriteOut, WriteRegisterOut, ALUResultOut);

input Clock, RegWriteIn, MemToRegIn;
input [1:0] EX_MEM_Signal;
input [1:0] MemWriteIn, MemReadIn;
input [31:0] WriteRegisterIn;
input [31:0] ALUResultIn;
input [31:0] ReadData2In;
input [31:0] InstructionIn;

output reg [1:0] MemWriteOut, MemReadOut;
output reg [31:0] WriteRegisterOut;
output reg [31:0] ALUResultOut;
output reg [31:0] ReadData2Out;
output reg [31:0] InstructionOut;
output reg RegWriteOut, MemToRegOut;

reg PreviousRegWriteIn, PreviousMemToRegIn;
reg [1:0] PreviousEX_MEM_Signal;
reg [1:0] PreviousMemWriteIn, PreviousMemReadIn;
reg [31:0] PreviousWriteRegisterIn;
reg [31:0] PreviousALUResultIn;
reg [31:0] PreviousReadData2In;
reg [31:0] PreviousInstructionIn;

always @(posedge Clock)begin
    if(EX_MEM_Signal == 1)begin
    WriteRegisterOut = PreviousWriteRegisterIn;
    ALUResultOut = PreviousALUResultIn;
    RegWriteOut = PreviousRegWriteIn;
    MemWriteOut = PreviousMemWriteIn;
    MemReadOut = PreviousMemReadIn;
    MemToRegOut = PreviousMemToRegIn;
    ReadData2Out = PreviousReadData2In;
    InstructionOut = PreviousInstructionIn;
    end
    else if(EX_MEM_Signal == 2)begin
    WriteRegisterOut = 0;
    ALUResultOut = 0;
    RegWriteOut = 0;
    MemWriteOut = 0;
    MemReadOut = 0;
    MemToRegOut = 1;
    ReadData2Out = 0;
    InstructionOut = 0;
    end
    else begin
    //PreviousWriteRegisterIn = WriteRegisterOut;
    WriteRegisterOut = WriteRegisterIn;
    //PreviousALUResultIn = ALUResultOut;
    ALUResultOut = ALUResultIn;
    //PreviousRegWriteIn = RegWriteOut;
    RegWriteOut = RegWriteIn;
    //PreviousMemWriteIn = MemWriteOut;
    MemWriteOut = MemWriteIn;
    //PreviousMemReadIn = MemReadOut;
    MemReadOut = MemReadIn;
    //PreviousMemToRegIn =  MemToRegOut;
    MemToRegOut = MemToRegIn;
    //PreviousReadData2In = ReadData2Out;
    ReadData2Out = ReadData2In;
    //PreviousInstructionIn = InstructionOut;
    InstructionOut = InstructionIn;
    end
    end
always @(negedge Clock) begin
    if(EX_MEM_Signal == 1)begin/*This is currently not stalling correctly*/
        PreviousWriteRegisterIn = WriteRegisterOut;
        PreviousALUResultIn = ALUResultOut;
        PreviousRegWriteIn = RegWriteOut;
        PreviousMemWriteIn = MemWriteOut;
        PreviousMemReadIn = MemReadOut;
        PreviousMemToRegIn =  MemToRegOut;
        PreviousReadData2In = ReadData2Out;
        PreviousInstructionIn = InstructionOut;
        end
    end
endmodule