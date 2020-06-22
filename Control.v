`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2019 04:02:32 PM
// Design Name: 
// Module Name: Control
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


module Control(Instruction, RegWrite, ALUInstruction, InputA_MuxSignal, InputB_MuxSignal, RegDst, signExtendSignal, MemWrite, MemRead, Branch, MemToReg, PCAdder_MuxSignal, jal_signal, JumpReturnSignal);
input [31:0] Instruction;
reg [5:0] OpCode;
reg [5:0] Funct;
reg [4:0] Special;
output reg [1:0] MemWrite, MemRead;
output reg RegDst, Branch, MemToReg, jal_signal;
output reg signExtendSignal; //used for signextending 0's in logical xori,ori,andi
output reg [5:0] ALUInstruction;
output reg RegWrite, InputA_MuxSignal, InputB_MuxSignal, PCAdder_MuxSignal, JumpReturnSignal;

always @(Instruction) begin
	Special=Instruction[10:6]; //check seh
	OpCode= Instruction [31:26];
	Funct=Instruction[5:0];
	
	/* Start of Arithmetic, Logical and HI/LO */
	if(Instruction == 32'b00000000000000000000000000000000)begin
	    MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        MemToReg = 1;
        RegWrite = 0;
        InputB_MuxSignal = 0;
        InputA_MuxSignal=0;
        ALUInstruction = 'b000000;
        RegDst = 0;
        signExtendSignal=0;
        jal_signal = 0;
        JumpReturnSignal = 0;
	end
    else if((OpCode == 'b000000) && (Funct == 'b100000))//ADD 
        begin
        MemRead = 0;
        MemWrite = 0;
        RegWrite = 1;
        InputB_MuxSignal = 0;
		InputA_MuxSignal=0;
		ALUInstruction = 'b000000;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
        jal_signal = 0;
        JumpReturnSignal = 0;
        end
    else if(OpCode == 'b001000)//ADDI 
        begin
        MemRead = 0;
        MemWrite = 0;
        RegWrite = 1;
        InputB_MuxSignal = 1;
		InputA_MuxSignal=0;
		ALUInstruction = 'b000000;
		RegDst = 0;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
        end
	else if(OpCode=='b001001)//ADDIU							
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=1;
		InputA_MuxSignal=0;
		ALUInstruction = 'b010111;
		RegDst = 0;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b00000)&&(Funct=='b100010))//SUB 
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b000001;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b000000)&&(Funct=='b100100))//AND
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b000010;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if(OpCode=='b001100)//ANDI
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=1;
		InputA_MuxSignal=0;
		ALUInstruction='b000010;
        RegDst = 0;
        signExtendSignal=1;
        MemToReg = 1;
        Branch=0;
        jal_signal = 0;
        JumpReturnSignal = 0;
		end
	else if((OpCode=='b000000)&&(Funct=='b100101))//OR
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b000011;
        RegDst = 1;
        signExtendSignal=0;
        MemToReg = 1;
        Branch=0;
        jal_signal = 0;
        JumpReturnSignal = 0;
		end
	else if(OpCode=='b001101)//ORI
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=1;
		InputA_MuxSignal=0;
		ALUInstruction='b000011;
		RegDst = 0;
		signExtendSignal=1;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b000000)&&(Funct=='b100111))//NOR
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b000100;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b000000)&&(Funct=='b100110))//XOR
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b000101;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if(OpCode=='b001110)//XORI
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=1;
		InputA_MuxSignal=0;
		ALUInstruction='b000101;
		RegDst = 0;
		signExtendSignal=1;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b011111)&&(Special=='b11000)&&(Funct=='b100000))//SEH
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b000110;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b000000)&&(Funct=='b000000))//SLL #ask
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=1;
		ALUInstruction='b000111;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b000000)&&(Funct=='b000010) && (Instruction[21]=='b0))//SRL #ask
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=1;
		ALUInstruction='b001000;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b000000)&&(Funct=='b000100))//SLLV #ask
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b000111;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b000000)&&(Funct=='b000110) && (Instruction[6] == 'b0))//SRLV #ask
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b001000;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b000000)&&(Funct=='b101010))//SLT
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b001001;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if(OpCode=='b001010)//SLTI
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=1;
		InputA_MuxSignal=0;
		ALUInstruction='b001001;
		RegDst = 0;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b000000)&&(Funct=='b001011))//MOVN
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b001010;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b000000)&&(Funct=='b001010))//MOVZ
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b001011;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b000000)&&(Funct=='b000110) && (Instruction[6] == 'b1))//ROTRV
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b001100;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b000000)&&(Funct=='b000010)&&(Instruction[21]=='b1))//ROTR
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=1;
		ALUInstruction='b001100;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b000000)&&(Funct=='b000011))//SRA
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=1;
		ALUInstruction='b001101;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b000000)&&(Funct=='b000111))//SRAV
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b001110;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b011111)&&(Funct=='b100000)&&(Special=='b10000))//SEB
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b001111;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end	
	else if(OpCode=='b001011)//SLTIU
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=1;
		InputA_MuxSignal=0;
		ALUInstruction='b010000;
		RegDst = 0;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b000000)&&(Funct=='b101011))//SLTU
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b010001;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b011100)&&(Funct=='b000010))//MUL
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=1;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b010010;
		RegDst = 1;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b000000)&&(Funct=='b011001))//MULTU
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=0;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b010011;
		RegDst = 0;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b011100)&&(Funct=='b000000))//MADD
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=0;
		RegDst = 0;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b010100;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b011100)&&(Funct=='b000100))//MSUB
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=0;
		RegDst = 0;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b010101;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
	else if((OpCode=='b000000)&&(Funct=='b011000))//MULT
		begin
        MemRead = 0;
        MemWrite = 0;
		RegWrite=0;
		InputB_MuxSignal=0;
		InputA_MuxSignal=0;
		ALUInstruction='b010110;
		RegDst = 0;
		signExtendSignal=0;
		MemToReg = 1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
		end
    else if((OpCode=='b000000)&&(Funct=='b100001))//ADDU
        begin
        MemRead = 0;
        MemWrite = 0;
        RegWrite=1;
        InputB_MuxSignal=0;
        InputA_MuxSignal=0;
        ALUInstruction = 'b010111;
        RegDst = 0;
        signExtendSignal=0;
        MemToReg = 1;
        Branch=0;
        jal_signal = 0;
        JumpReturnSignal = 0;
        end
	else if((OpCode=='b000000)&&(Funct=='b010000))//MFHI
        begin
        MemRead = 0;
        MemWrite = 0;
        RegWrite=1;
        RegDst=1;
        InputB_MuxSignal=0;
        InputA_MuxSignal=0;
        ALUInstruction='b011011;
        signExtendSignal=0;
        MemToReg = 1;
        Branch=0;
        jal_signal = 0;
        JumpReturnSignal = 0;
        end
    else if((OpCode=='b000000)&&(Funct=='b010010))//MFLO
        begin
        MemRead = 0;
        MemWrite = 0;
        RegWrite=1;
        RegDst=1;
        InputB_MuxSignal=0;
        InputA_MuxSignal=0;
        ALUInstruction='b011000;
        signExtendSignal=0;
        MemToReg = 1;
        Branch=0;
        jal_signal = 0;
        JumpReturnSignal = 0;
        end
    else if((OpCode=='b000000)&&(Funct=='b010001))//MTHI
        begin
        MemRead = 0;
        MemWrite = 0;
        RegWrite=0;
        RegDst=1;
        InputB_MuxSignal=0;
        InputA_MuxSignal=0;
        ALUInstruction='b011001;
        signExtendSignal=0;
        MemToReg = 1;
        Branch=0;
        jal_signal = 0;
        JumpReturnSignal = 0;
        end
    else if((OpCode=='b000000)&&(Funct=='b010011))//MTLO
        begin
        MemRead = 0;
        MemWrite = 0;
        RegWrite=0;
        RegDst=1;
        InputB_MuxSignal=0;
        InputA_MuxSignal=0;
        ALUInstruction='b011010;
        signExtendSignal=0;
        MemToReg = 1;
        Branch=0;
        jal_signal = 0;
        JumpReturnSignal = 0;
        end
        
    /* End of Arithmetic, Logical and HI/LO */

//next part of lab^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    
    
    /* Start of Data */
    
    else if(OpCode=='b100011)// load word
        begin
        MemRead = 2'b01;
        MemWrite = 0;
        MemToReg = 0;
        RegWrite = 1;
        InputB_MuxSignal = 1;
		InputA_MuxSignal=0;
		ALUInstruction = 'b100100;
		RegDst = 0;
		signExtendSignal=0;
		Branch=0;
        jal_signal = 0;
        JumpReturnSignal = 0;
        end
    
    else if(OpCode=='b101011)// store word
        begin
        MemRead = 0;
        MemWrite = 2'b01;
        MemToReg = 1;
        RegWrite = 0;
        InputB_MuxSignal = 1;
		InputA_MuxSignal=0;
		ALUInstruction = 'b100100;
		RegDst = 0;
		signExtendSignal=0;
        Branch=0;
        jal_signal = 0;
        JumpReturnSignal = 0;
        end
    else if(OpCode=='b101000)// store byte
        begin
        MemRead = 0;
        MemWrite = 2'b11;
        MemToReg = 1;
        RegWrite = 0;
        InputB_MuxSignal = 1;
		InputA_MuxSignal=0;
		ALUInstruction = 'b100100;
		RegDst = 0;
		signExtendSignal=0;
		Branch=0;
        jal_signal = 0;
        JumpReturnSignal = 0;
        end
    else if(OpCode=='b100001)// load half
        begin
        MemRead = 2'b10;
        MemWrite = 0;
        MemToReg = 0;
        RegWrite = 1;
        InputB_MuxSignal = 1;
		InputA_MuxSignal=0;
		ALUInstruction = 'b100100;
		RegDst = 0;
		signExtendSignal=0;
		Branch=0;
        jal_signal = 0;
        JumpReturnSignal = 0;
        end
    else if(OpCode=='b100000)// load byte
        begin
        MemRead = 2'b11;
        MemWrite = 0;
        MemToReg = 0;
        RegWrite = 1;
        InputB_MuxSignal = 1;
		InputA_MuxSignal=0;
		ALUInstruction = 'b100100;
		RegDst = 0;
		signExtendSignal=0;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
        end
        
    else if(OpCode=='b101001)// store half
        begin
        MemRead = 0;
        MemWrite = 2'b10;
        MemToReg = 1;
        RegWrite = 0;
        InputB_MuxSignal = 1;
		InputA_MuxSignal=0;
		ALUInstruction = 'b100100;
		RegDst = 0;
		signExtendSignal=0;
		Branch=0;
        jal_signal = 0;
        JumpReturnSignal = 0;
        end
    
    else if(OpCode=='b001111)// load upper immediate
        begin
        MemRead = 1;
        MemWrite = 0;
        MemToReg = 1;
        RegWrite = 1;
        InputB_MuxSignal = 1;
		InputA_MuxSignal=0;
		ALUInstruction = 'b100001;
		RegDst = 0;
		signExtendSignal=1;
		Branch=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
        
        end
    
    /* End of Data */
    
    /* Start of Branch Instructions */
    
    else if((OpCode=='b000001)&&(Instruction[20:16]=='b00001))  // bgez
        begin
        MemRead = 0;
        MemWrite = 0;
        Branch = 1;
        MemToReg = 1;
        RegWrite = 0;
        InputB_MuxSignal = 1;
		InputA_MuxSignal=0;
		ALUInstruction = 'b100000;
		RegDst = 0;
		signExtendSignal=1;
		PCAdder_MuxSignal = 1;
		jal_signal = 0;
		JumpReturnSignal = 0;
        end
        
    else if((OpCode=='b000001)&&(Instruction[20:16]=='b00000))  // BLTZ
        begin
        MemRead = 0;
        MemWrite = 0;
        Branch = 1;
        MemToReg = 1;
        RegWrite = 0;
        InputB_MuxSignal = 0;
        InputA_MuxSignal=0;
        ALUInstruction = 'b100101;
        RegDst = 0;
        signExtendSignal=0;
        PCAdder_MuxSignal = 1;
        jal_signal = 0;
        JumpReturnSignal = 0;
        end 
    
    else if(OpCode=='b000100)   // beq
        begin
        MemRead = 0;
        MemWrite = 0;
        Branch = 1;
        MemToReg = 1;   
        RegWrite = 0;
        InputB_MuxSignal = 0;
		InputA_MuxSignal=0;
		PCAdder_MuxSignal = 1;
		ALUInstruction = 'b011100;
		RegDst = 0;
		signExtendSignal=0;
		jal_signal = 0;  
		JumpReturnSignal = 0;
        end
    
    else if(OpCode=='b000101)   // bne
        begin
        MemRead = 0;
        MemWrite = 0;
        Branch = 1;
        MemToReg = 1;
        PCAdder_MuxSignal = 1;
        RegWrite = 0;
        InputB_MuxSignal = 0;
		InputA_MuxSignal=0;
		ALUInstruction = 'b011101;
		RegDst = 0;
		signExtendSignal=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
        end
    
    else if(OpCode=='b000111)   // bgtz
        begin
        MemRead = 0;
        MemWrite = 0;
        Branch = 1;
        MemToReg = 1;
        PCAdder_MuxSignal = 1;
        RegWrite = 0;
        InputB_MuxSignal = 0;
		InputA_MuxSignal=0;
		ALUInstruction = 'b011110;
		RegDst = 0;
		signExtendSignal=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
        end
    else if((OpCode=='b000110)&&(Instruction[20:16]=='b00000))  // blez
        begin
        MemRead = 0;
        MemWrite = 0;
        Branch = 1;
        MemToReg = 1;
        PCAdder_MuxSignal = 1;
        RegWrite = 0;
        InputB_MuxSignal = 0;
		InputA_MuxSignal=0;
		ALUInstruction = 'b011111;
		RegDst = 0;
		signExtendSignal=0;
		jal_signal = 0;
		JumpReturnSignal = 0;
        end
    
    else if(OpCode=='b000010)   //j
        begin
        MemRead = 0;
        MemWrite = 0;
        Branch = 1;
        MemToReg = 1;
        RegWrite = 0;
        InputB_MuxSignal = 0;
		InputA_MuxSignal=0;
		ALUInstruction = 'b100110;
		RegDst = 0;
		signExtendSignal=0;
		PCAdder_MuxSignal = 0;
		jal_signal = 0;
		JumpReturnSignal = 0;
        end
    
    else if((OpCode=='b000000)&&(Funct=='b001000))  // jr
        begin
        MemRead = 0;
        MemWrite = 0;
        Branch = 1;
        MemToReg = 1;
        RegWrite = 0;
        InputB_MuxSignal = 0;
		InputA_MuxSignal=0;
		ALUInstruction = 'b100010;
		RegDst = 0;
		signExtendSignal=0;
		jal_signal = 0;
		JumpReturnSignal = 1;
        end
    
    else if(OpCode=='b000011)   // jal
        begin
        MemRead = 0;
        MemWrite = 0;
        Branch = 1;
        MemToReg = 1; //This may need to change     
        RegWrite = 1;
        PCAdder_MuxSignal = 0;
        InputB_MuxSignal = 0;
		InputA_MuxSignal=0;
		ALUInstruction = 'b100011;
		RegDst = 0;
		signExtendSignal=0;
		Branch=1;
		jal_signal = 1;
		JumpReturnSignal = 0;
        end
    
    /* End of Branch Instructions*/
    //last used number in ALU32bit is 38
    
	
	end
endmodule
