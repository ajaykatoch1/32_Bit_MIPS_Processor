module ID_EX_Register(Clk, ID_EX_Signal, JumpReturnSignalIn, jal_signalIn, PCAdder_MuxSignalIn, InstructionIn, RegWriteIn, ReadData1In, ReadData2In, SignExtendOutIn, ALUInstructionIn, PCResultIn, InputA_MuxSignalIn, InputB_MuxSignalIn, RegDstIn, MemWriteIn, MemReadIn, BranchIn, MemToRegIn,
                          EX_JumpReturnSignal, EX_jal_signal, EX_PCAdder_MuxSignal, EX_Instruction, EX_RegWrite, EX_ReadData1, EX_ReadData2, EX_SignExtendOut, EX_ALUInstruction, EX_PCResult, EX_InputA_MuxSignal, EX_InputB_MuxSignal, EX_RegDst, EX_MemWrite, EX_MemRead, EX_Branch, EX_MemToReg);
input Clk, RegWriteIn, InputA_MuxSignalIn, InputB_MuxSignalIn, BranchIn, MemToRegIn, PCAdder_MuxSignalIn, jal_signalIn, JumpReturnSignalIn;
input [1:0] ID_EX_Signal;
input [1:0] MemWriteIn, MemReadIn;
input [31:0] ReadData1In;
input [31:0] ReadData2In;
input [31:0] SignExtendOutIn;
input [5:0] ALUInstructionIn;
input [31:0] PCResultIn;
input [31:0] InstructionIn;
input [31:0] RegDstIn;

output reg EX_RegWrite, EX_InputA_MuxSignal, EX_InputB_MuxSignal, EX_Branch, EX_MemToReg, EX_PCAdder_MuxSignal, EX_jal_signal, EX_JumpReturnSignal; //convert EX_AluSRC to exALU_Inputbs
output reg [31:0] EX_ReadData1;
output reg [1:0] EX_MemWrite, EX_MemRead;
output reg [31:0] EX_ReadData2;
output reg [31:0] EX_SignExtendOut;
output reg [5:0] EX_ALUInstruction;
output reg [31:0] EX_PCResult;
output reg [31:0] EX_Instruction;
output reg [31:0] EX_RegDst;
reg PreviousEX_RegWrite, PreviousEX_InputA_MuxSignal, PreviousEX_InputB_MuxSignal, PreviousEX_Branch, PreviousEX_MemToReg, PreviousEX_PCAdder_MuxSignal, PreviousEX_jal_signal, PreviousEX_JumpReturnSignal;
reg [31:0] PreviousEX_ReadData1;
reg [1:0] PreviousEX_MemWrite, PreviousEX_MemRead;
reg [31:0] PreviousEX_ReadData2;
reg [31:0] PreviousEX_SignExtendOut;
reg [5:0] PreviousEX_ALUInstruction;
reg [31:0] PreviousEX_PCResult;
reg [31:0] PreviousEX_Instruction;
reg [31:0] PreviousEX_RegDst;

always @(posedge Clk) begin
    if(ID_EX_Signal == 1)begin/*This is currently not stalling correctly*/
    EX_RegWrite = PreviousEX_RegWrite; 
    EX_InputA_MuxSignal = PreviousEX_InputA_MuxSignal; 
    EX_InputB_MuxSignal = PreviousEX_InputB_MuxSignal; 
    EX_Branch = PreviousEX_Branch; 
    EX_MemToReg = PreviousEX_MemToReg; 
    EX_PCAdder_MuxSignal = PreviousEX_PCAdder_MuxSignal; 
    EX_jal_signal = PreviousEX_jal_signal; 
    EX_JumpReturnSignal = PreviousEX_JumpReturnSignal; 
    EX_ReadData1 = PreviousEX_ReadData1; 
    EX_MemWrite = PreviousEX_MemWrite; 
    EX_MemRead = PreviousEX_MemRead; 
    EX_ReadData2 = PreviousEX_ReadData2; 
    EX_SignExtendOut = PreviousEX_SignExtendOut; 
    EX_ALUInstruction = PreviousEX_ALUInstruction; 
    EX_PCResult = PreviousEX_PCResult; 
    EX_Instruction = PreviousEX_Instruction;
    EX_RegDst = PreviousEX_RegDst;
    end
    else if(ID_EX_Signal == 2)begin
    EX_RegWrite = 0;
    EX_ReadData1 =0;
    EX_ReadData2 = 0;
    EX_SignExtendOut = 0;
    EX_ALUInstruction = 0;
    EX_PCResult = 0;
    EX_InputA_MuxSignal = 0;
    EX_InputB_MuxSignal = 0;
    EX_RegDst = 0;
    EX_Instruction= 0;
    EX_MemRead= 0;
    EX_Branch = 0;
    EX_MemToReg = 1;
    EX_MemWrite = 0;
    EX_PCAdder_MuxSignal =0;
    EX_jal_signal = 0;
    EX_JumpReturnSignal = 0;
    end
    else begin
    //PreviousEX_RegWrite = EX_RegWrite;
    EX_RegWrite = RegWriteIn;
    //PreviousEX_ReadData1 = EX_ReadData1;
    EX_ReadData1 = ReadData1In;
    //PreviousEX_ReadData2 = EX_ReadData2;
    EX_ReadData2 = ReadData2In;
    //PreviousEX_SignExtendOut = EX_SignExtendOut;
    EX_SignExtendOut = SignExtendOutIn;
    //PreviousEX_ALUInstruction = EX_ALUInstruction;
    EX_ALUInstruction = ALUInstructionIn;
    //PreviousEX_PCResult = EX_PCResult;
    EX_PCResult = PCResultIn;
    //PreviousEX_InputA_MuxSignal = EX_InputA_MuxSignal;
    EX_InputA_MuxSignal = InputA_MuxSignalIn;
    //PreviousEX_InputB_MuxSignal = EX_InputB_MuxSignal;
    EX_InputB_MuxSignal = InputB_MuxSignalIn;
    //PreviousEX_RegDst = EX_RegDst;
    EX_RegDst = RegDstIn;
    //PreviousEX_Instruction = EX_Instruction;
    EX_Instruction = InstructionIn;
    //PreviousEX_MemRead = EX_MemRead;
    EX_MemRead = MemReadIn;
    //PreviousEX_Branch = EX_Branch;
    EX_Branch = BranchIn;
    //PreviousEX_MemToReg = EX_MemToReg;
    EX_MemToReg = MemToRegIn;
    //PreviousEX_MemWrite = EX_MemWrite;
    EX_MemWrite =MemWriteIn;
    //PreviousEX_PCAdder_MuxSignal = EX_PCAdder_MuxSignal;
    EX_PCAdder_MuxSignal = PCAdder_MuxSignalIn;
    //PreviousEX_jal_signal = EX_jal_signal;
    EX_jal_signal = jal_signalIn;
    //PreviousEX_JumpReturnSignal = EX_JumpReturnSignal;
    EX_JumpReturnSignal = JumpReturnSignalIn;
    end  
    end     
always @(negedge Clk) begin
if(ID_EX_Signal == 1)begin/*This is currently not stalling correctly*/
    PreviousEX_RegWrite = EX_RegWrite;
    PreviousEX_ReadData1 = EX_ReadData1;
    PreviousEX_ReadData2 = EX_ReadData2;
    PreviousEX_SignExtendOut = EX_SignExtendOut;
    PreviousEX_ALUInstruction = EX_ALUInstruction;
    PreviousEX_PCResult = EX_PCResult;
    PreviousEX_InputA_MuxSignal = EX_InputA_MuxSignal;
    PreviousEX_InputB_MuxSignal = EX_InputB_MuxSignal;
    PreviousEX_RegDst = EX_RegDst;
    PreviousEX_Instruction = EX_Instruction;
    PreviousEX_MemRead = EX_MemRead;
    PreviousEX_Branch = EX_Branch;
    PreviousEX_MemToReg = EX_MemToReg;
    PreviousEX_MemWrite = EX_MemWrite;
    PreviousEX_PCAdder_MuxSignal = EX_PCAdder_MuxSignal;
    PreviousEX_jal_signal = EX_jal_signal;
    PreviousEX_JumpReturnSignal = EX_JumpReturnSignal;
    end
end         
endmodule