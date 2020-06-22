module DataHazard(PCSrc, IF_Instruction, ID_Instruction, EX_Instruction, MEM_Rd, WB_Rd, WB_RegWrite, MEM_RegWrite, MemRead,IF_ID_Signal, ID_EX_Signal, EX_MEM_Signal, MEM_WB_Signal, PC_Write);

	input PCSrc;
	input [31:0] IF_Instruction;
	input [31:0] EX_Instruction;
	input [31:0] ID_Instruction;
	input [31:0] MEM_Rd;
	input [31:0] WB_Rd;
	input [1:0] MemRead;
	input WB_RegWrite, MEM_RegWrite;
	output reg [1:0]IF_ID_Signal;
	output reg [1:0]ID_EX_Signal;
	output reg [1:0]EX_MEM_Signal;
	output reg MEM_WB_Signal;
	output reg [1:0]PC_Write;
	reg [5:0]EX_Opcode;
	reg [5:0]ID_Opcode;
	reg [5:0]IF_Opcode;
	reg [5:0]IF_Rt;
	reg [5:0]IF_Rs;
	reg [31:0]ID_Rt; // Bits 20-16
    reg [31:0]ID_Rs; // Bits 25-21
    reg [31:0]EX_Rt;
    reg [31:0]EX_Rs;
	
	always @(*)begin
	EX_Opcode = EX_Instruction[31:26];
	ID_Opcode = ID_Instruction[31:26];
	IF_Opcode = IF_Instruction[31:26];
	ID_Rs = ID_Instruction[25:21];
	ID_Rt = ID_Instruction[20:16];
	IF_Rs = IF_Instruction[25:21];
	IF_Rt = IF_Instruction[20:16];
	EX_Rs = EX_Instruction[25:21];
	EX_Rt = EX_Instruction[20:16];
	
	/*Data hazard is organized based on the stage of the dependency*/
	//If there is a dependency in the execution stage, this will be towards the top of the "if" statements.
	//A dependency in the execution stage will stall all the other following instructions as well
	/*Branching & jumping*/
	if((PCSrc==1) && !((MemRead != 0) && (EX_Rs == MEM_Rd)) && !((MemRead != 0) && (EX_Rt == MEM_Rd) && (EX_Opcode=='b101011 || EX_Opcode=='b101000 || EX_Opcode=='b101001 || EX_Opcode=='b000000 || EX_Opcode=='b011100 || EX_Opcode=='b011111)))begin //no addi lw occrurring
        IF_ID_Signal = 2;
        ID_EX_Signal = 2;
        EX_MEM_Signal = 0;
        MEM_WB_Signal = 0;
        PC_Write = 0;
	end
	/**/
    else if((MemRead != 0) && (EX_Rt == MEM_Rd) && (EX_Opcode=='b101011 || EX_Opcode=='b101000 || EX_Opcode=='b101001 || EX_Opcode=='b000000 || EX_Opcode=='b011100 || EX_Opcode=='b011111 || EX_Opcode=='b000100||EX_Opcode=='b000101))begin
       IF_ID_Signal = 1; // Stalling IF_ID register //This is stalling correctly because the PCWrite is sending the same instruction
       ID_EX_Signal = 1; // Stalling ID_EX register
       EX_MEM_Signal = 'b10;
       MEM_WB_Signal = 0;      
       PC_Write = 1;
    end
    else if((MemRead != 0) && (EX_Rs == MEM_Rd))begin
       IF_ID_Signal = 1; // Stalling IF_ID register
       ID_EX_Signal = 1; // Stalling ID_EX register
       EX_MEM_Signal = 'b10;
       MEM_WB_Signal = 0;    
       PC_Write = 1;       
    end
    else if((ID_Rs == WB_Rd) && (WB_RegWrite == 1))begin
       IF_ID_Signal = 1; // Stalling IF_ID register
       ID_EX_Signal = 'b10; // Flushing ID_EX register
       EX_MEM_Signal = 0;
       MEM_WB_Signal = 0;
       PC_Write = 1;
    end
	else if((IF_Rs == MEM_Rd) && (MEM_RegWrite ==1))begin //This should handle all dependencies from Memory, addi's should work as well as load's
        IF_ID_Signal = 'b10; // Flushing IF_ID register
        ID_EX_Signal = 0;
        EX_MEM_Signal = 0;
        MEM_WB_Signal = 0;
        PC_Write = 1;
	end
	else if(((IF_Rt == MEM_Rd) && (MEM_RegWrite == 1)) && (IF_Opcode=='b101011 || IF_Opcode=='b101000 || IF_Opcode=='b101001))begin// sw, sh, sb
        IF_ID_Signal = 'b10; // Flushing IF_ID register 
        ID_EX_Signal = 0;
        EX_MEM_Signal = 0;
        MEM_WB_Signal = 0;
        PC_Write = 1;
	end
	else if(((IF_Rt == MEM_Rd) && (MEM_RegWrite == 1))&&(IF_Opcode=='b000000 || IF_Opcode=='b011100 || IF_Opcode=='b011111 || IF_Opcode=='b000101 || IF_Opcode=='b000100))begin //arithmetic
	    IF_ID_Signal = 'b10;  // Flushing IF_ID register 
        ID_EX_Signal = 0;
        EX_MEM_Signal = 0;
        MEM_WB_Signal = 0;
        PC_Write = 1;
	end
	else begin
	IF_ID_Signal=0;
	ID_EX_Signal=0;
	EX_MEM_Signal=0;
    MEM_WB_Signal=0;
    PC_Write = 0;
	end
    end

endmodule
	
