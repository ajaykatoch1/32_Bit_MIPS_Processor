module MEM_WB_Register(Clock, MEM_WB_Signal, InstructionIn,MemToRegIn, RegWriteIn, WriteRegisterIn, ALUResultIn, DataMemoryIn,
                                            InstructionOut,MemToRegOut, RegWriteOut, WriteRegisterOut, ALUResultOut, DataMemoryOut);
input Clock, RegWriteIn, MemToRegIn;
input MEM_WB_Signal;
input [31:0] WriteRegisterIn;
input [31:0] ALUResultIn;
input [31:0] DataMemoryIn;
input [31:0] InstructionIn;

output reg [31:0] WriteRegisterOut;
output reg [31:0] ALUResultOut;
output reg [31:0] DataMemoryOut;
output reg RegWriteOut, MemToRegOut;
output reg [31:0] InstructionOut;

always @(posedge Clock)begin
    if(MEM_WB_Signal == 1)begin
    WriteRegisterOut = 0;
    ALUResultOut = 0;
    RegWriteOut = 0;
    MemToRegOut = 1;
    DataMemoryOut = 0;
    InstructionOut = 0;
    end
    else begin
    WriteRegisterOut = WriteRegisterIn;
    ALUResultOut = ALUResultIn;
    RegWriteOut = RegWriteIn;
    MemToRegOut = MemToRegIn;
    DataMemoryOut = DataMemoryIn;
    InstructionOut = InstructionIn;
    end
    end

endmodule