`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Ariel Villasenor: 50%
// Ajay Katoch: 50%
//Branch Decision and resolution stage: EX Stage is where we are making our branch decision

// Create Date: 
// Design Name: 
// Module Name: top
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
module top(Clk, Reset, PCResult, MEMWB_DataResult, ALUhi, ALUlo, MEMWB_RegWrite);
    input Clk, Reset;
    output wire [31:0] MEMWB_DataResult;
    output wire MEMWB_RegWrite;
    wire [63:0] ALUResult;
    wire [63:0] ALUResult2;
    wire [31:0] ALUInputA;
    wire [31:0] ALUInputB;
    wire [31:0] Address;
    
    /*Instruction Fetch Unit Stage Wires*/
    output wire [31:0] PCResult;
    wire PC_Write;
    wire [31:0] PCAddResult;
    wire [31:0] Instruction;
    
    wire [1:0]IF_ID_Signal;
    
    /*Instrucion Decode Stage Wires*/
    wire [31:0] RegDst_1;
    wire [31:0] ID_Instruction;
    wire [31:0] ID_PCResult;
    wire [31:0] ReadData1;
    wire [31:0] ReadData2;
    wire [31:0] SignExtendOut;
    wire [31:0] ArithmeticSignExtendOut;
    wire [31:0] LogicalSignExtendOut;
    wire [5:0] ALUInstruction;
    wire RegWrite, RegDst, InputA_MuxSignal, InputB_MuxSignal, SignExtendSignal, Branch, MemToReg, PCAdder_MuxSignal, jal_signal, JumpReturnSignal;
    wire [1:0] MemRead, MemWrite;
    
    wire [1:0]ID_EX_Signal;
    
    /*Execution Stage Wires*/
    wire [31:0] EX_ReadData1;
    wire [31:0] EX_ReadData2;
    wire [31:0] EX_SignExtendOut;
    wire [31:0] EX_PCResult;
    wire [31:0] EX_PCAddResult;
    wire [31:0] EX_Instruction;
    wire [31:0] PCAdderJump, PCAdderBranch;
    wire [31:0] EX_RegDst_1;
    wire [31:0] EX_WriteData;
    output wire [31:0] ALUlo;
    output wire [31:0] ALUhi;
    wire [5:0] EX_ALUInstruction;
    wire EX_RegWrite, EX_RegDst, EX_InputA_MuxSignal, EX_InputB_MuxSignal, EX_Branch, EX_MemToReg;
    wire EX_PCAdder_MuxSignal;
    wire [1:0] EX_MemWrite, EX_MemRead;
    wire [31:0] ShiftAmount;
    wire [31:0] WriteRegister;
    wire [31:0] PCAdder_MuxResult;
    wire [31:0] InputToForwardMuxA;
    wire [31:0] InputToForwardMuxB;
    wire [1:0] ForwardAMuxSignal, ForwardBMuxSignal, ForwardWriteDataSignal;
    wire Zero, EX_jal_signal, EX_JumpReturnSignal;
    
    wire [1:0]EX_MEM_Signal;
    
    /*Memory Access Stage Wires*/
    wire [31:0] MEM_WriteRegister;
    wire [31:0] MEM_ALUResult, MEM_ReadData2;
    wire [1:0] MEM_MemWrite, MEM_MemRead;
    wire [31:0] MEMWB_ALUResult;
    wire MEM_RegWrite, MEM_MemToReg, PCSrc;
    wire [31:0] DataMemoryOut;
    wire [31:0] MEM_Instruction;
    
    wire MEM_WB_Signal;
    
    /*Memory Write Back Stage*/
    wire [31:0] MEMWB_WriteRegister, MEMWB_DataMemoryOut;
    wire MEMWB_MemToReg;
    wire [31:0] WB_Instruction;
    
    /* Start of Instruction Fetch Stage*/
    PCAdder PCAdder_1(PCResult, PCAddResult);
    
    Mux32Bit2To1 NextAddress( PCAddResult, EX_PCAddResult, PCSrc, Address );
        
    ProgramCounter ProgramCounter_1(PC_Write, Address, Reset, Clk, PCResult);
        
    InstructionMemory InstructionMemory_1(PCResult, Instruction);
  
    IF_ID_Register Instruction_Fetch_Decode_Register(Clk, IF_ID_Signal, Instruction, PCAddResult, ID_Instruction, ID_PCResult);
    /* End of Instruction Fetch Stage*/
    
    /* Decode Stage*/  
    DataHazard DataHazardUnit(PCSrc, Instruction, ID_Instruction, EX_Instruction, MEM_WriteRegister, MEMWB_WriteRegister, MEMWB_RegWrite, MEM_RegWrite, MEM_MemRead, IF_ID_Signal, ID_EX_Signal, EX_MEM_Signal, MEM_WB_Signal, PC_Write);
    
    RegisterFile RegisterFile_1( Clk, ID_Instruction[25:21], ID_Instruction[20:16], MEMWB_WriteRegister, MEMWB_DataResult, MEMWB_RegWrite, ReadData1, ReadData2); 
    
    SignExtension SignExtension_1(ID_Instruction[15:0], ArithmeticSignExtendOut);
    
    immediate_signExtension immediate_signExtension_1(ID_Instruction[15:0], LogicalSignExtendOut);
    
    Mux32Bit2To1 ChooseSignExtend(ArithmeticSignExtendOut, LogicalSignExtendOut, SignExtendSignal, SignExtendOut);
        
    Control Control_1(ID_Instruction, RegWrite, ALUInstruction, InputA_MuxSignal, InputB_MuxSignal, RegDst, SignExtendSignal, MemWrite, MemRead, Branch, MemToReg, PCAdder_MuxSignal, jal_signal, JumpReturnSignal);// Add signal for SignExtendSignal
    
    Mux5Bit2To1 Mux5Bit2To1_1(ID_Instruction[20:16], ID_Instruction[15:11], RegDst, RegDst_1 ); //Moves this into Execute Stages  
    
    ID_EX_Register Instruction_Decode_Execute_Register(Clk, ID_EX_Signal, JumpReturnSignal, jal_signal, PCAdder_MuxSignal, ID_Instruction, RegWrite, ReadData1, ReadData2, SignExtendOut, ALUInstruction, ID_PCResult, InputA_MuxSignal, InputB_MuxSignal, RegDst_1, MemWrite, MemRead, Branch, MemToReg,
                                                                        EX_JumpReturnSignal , EX_jal_signal, EX_PCAdder_MuxSignal, EX_Instruction, EX_RegWrite, EX_ReadData1, EX_ReadData2, EX_SignExtendOut, EX_ALUInstruction, EX_PCResult, EX_InputA_MuxSignal, EX_InputB_MuxSignal, EX_RegDst_1, EX_MemWrite, EX_MemRead, EX_Branch, EX_MemToReg);
    /* End of Decode Stage*/
   
    /* Start of Execution Stage*/
    ForwardingUnit ForwardingUnit_1(EX_RegDst_1, EX_RegWrite, EX_Instruction, MEM_WriteRegister, MEM_RegWrite, MEMWB_WriteRegister, MEMWB_RegWrite, ForwardAMuxSignal, ForwardBMuxSignal, ForwardWriteDataSignal);// Need to figure out how to add the mux signals to input A and input B
    
    AND AND_1( EX_Branch, Zero, PCSrc);
    
    PCAdderJump PCAdder_Jump(EX_PCResult, EX_Instruction[25:0], PCAdderJump);
    
    PCAdderBranch PCAdder_Branch(EX_PCResult, EX_Instruction[15:0], PCAdderBranch);
    
    Mux32Bit2To1 PCAdderMux( PCAdderJump, PCAdderBranch, EX_PCAdder_MuxSignal, PCAdder_MuxResult);
    
    Mux32Bit2To1 JumpReturn( PCAdder_MuxResult, EX_ReadData1, EX_JumpReturnSignal, EX_PCAddResult );
    
    SignExtensionShiftAmount SignExtension_2( EX_Instruction[10:6], ShiftAmount );
    
    Mux32Bit2To1 InputA_Mux( EX_ReadData1, ShiftAmount, EX_InputA_MuxSignal, InputToForwardMuxA); // ShiftAmount used for SLL, SRL, ROTR, SRA
   
    Mux32Bit3To1 InputA_ForwardMux(InputToForwardMuxA, MEM_ALUResult, MEMWB_DataResult, ForwardAMuxSignal, ALUInputA);
   
    Mux32Bit2To1 InputB_Mux( EX_ReadData2, EX_SignExtendOut, EX_InputB_MuxSignal, InputToForwardMuxB);
    
    Mux32Bit3To1 InputB_ForwardMux(InputToForwardMuxB, MEM_ALUResult, MEMWB_DataResult, ForwardBMuxSignal, ALUInputB);
    
    Mux32Bit3To1 WriteData_ForwardMux(EX_ReadData2, MEM_ALUResult, MEMWB_DataResult, ForwardWriteDataSignal, EX_WriteData);
    
    ALU32Bit ALU32Bit_1(EX_ALUInstruction, ALUhi, ALUlo, ALUInputA, ALUInputB, EX_PCResult, ALUResult, ALUResult2, Zero);
    
    HI_Register HI(Clk, ALUResult2[63:32], ALUhi);
    
    LO_Register LO(Clk, ALUResult2[31:0], ALUlo);
    
    Mux32Bit2To1 RegisterDestination(EX_RegDst_1, 'h1f, EX_jal_signal, WriteRegister);
    /* End of Execution Stage*/
    
    /* Start of Memory Access Stage */
    EX_MEM_Register Execution_Mem_Access_Register(Clk, EX_MEM_Signal, EX_Instruction,EX_WriteData, EX_MemWrite, EX_MemRead, EX_MemToReg, EX_RegWrite, WriteRegister, ALUResult[31:0], 
                                                                      MEM_Instruction,  MEM_ReadData2, MEM_MemWrite, MEM_MemRead, MEM_MemToReg, MEM_RegWrite, MEM_WriteRegister, MEM_ALUResult);
    
    DataMemory DataMemory_1( MEM_ALUResult, MEM_ReadData2, Clk, MEM_MemWrite, MEM_MemRead, DataMemoryOut);
    /* End of Memory Access Stage */                                                   
    
    
    /* Start of Memory Writeback stage */
    MEM_WB_Register Memory_Writeback_Register(Clk, MEM_WB_Signal, MEM_Instruction,MEM_MemToReg, MEM_RegWrite, MEM_WriteRegister, MEM_ALUResult, DataMemoryOut,
                                                                 WB_Instruction, MEMWB_MemToReg, MEMWB_RegWrite, MEMWB_WriteRegister, MEMWB_ALUResult, MEMWB_DataMemoryOut);
                                                   
    Mux32Bit2To1 DataResult_Mux( MEMWB_DataMemoryOut, MEMWB_ALUResult, MEMWB_MemToReg, MEMWB_DataResult);
    /* End of Memory Writeback stage */
    
    
    //InstructionFetchUnit InstructionFetchUnit_1(Reset, ClkOut, Instruction);
    
    //Two4DigitDisplay Two4DigitDisplay(Clk, Instruction[15:0], Instruction[31:16], out7, en_out);
  
endmodule