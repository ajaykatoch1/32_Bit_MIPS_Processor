`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: N-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports all arithmetic operations 
// needed by the MIPS instructions given in Labs5-8.docx document. 
//   The 'ALUResult' will output the corresponding result of the operation 
//   based on the 32-Bit inputs, 'A', and 'B'. 
//   The 'Zero' flag is high when 'ALUResult' is '0'. 
//   The 'ALUControl' signal should determine the function of the ALU 
//   You need to determine the bitwidth of the ALUControl signal based on the number of 
//   operations needed to support. 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUInstruction, ALUhi, ALUlo, A, B, PC, ALUResult, ALUResult2,Zero);

	input [5:0] ALUInstruction; // control bits for ALU operation
	input [31:0] A, B;
	input [31:0] ALUlo;
	input [31:0] PC;
    output reg Zero;

	input [31:0] ALUhi;
	output reg [63:0] ALUResult;	// answer
	reg [31:0] tempReg;
    reg [63:0] tempreg2;
    reg [63:0] ALUResultTemp1;    // answer
    reg [31:0] ALUResultTemp2;
    output reg [63:0] ALUResult2;  
	//Start of Arithmetic Controls//
    always @(*)
        case (ALUInstruction)
        
        //ADD,ADDI, LW, SW, LB, SB, LH, SH
        'b000000:                            
        begin
            ALUResult = A+B;
            ALUResult2 = {ALUhi, ALUlo};
            Zero=0;
        end
        
        //SUB
        'b000001:
        begin
            ALUResult= A-B;    
            ALUResult2 = {ALUhi, ALUlo};
            Zero=0;
        end
        
        //AND (This is a bitwise AND)
        'b000010:
        begin
            ALUResult=A&B;
            ALUResult2 = {ALUhi, ALUlo};
            Zero=0;
        end
        
        //OR (This is a bitwise OR)
        'b000011:
        begin
            ALUResult=A|B;
            ALUResult2 = {ALUhi, ALUlo};
            Zero=0;
        end
        
        //NOR (This is a bitwise NOR)
        'b000100:
        begin
            tempReg = A|B;
            ALUResult= ~tempReg;
            ALUResult2 = {ALUhi, ALUlo};
            Zero=0;
        end
        
        //XOR (This is a bitwise XOR)
        'b000101:
        begin
            ALUResult=A^B;
            ALUResult2 = {ALUhi, ALUlo};
            Zero=0;
        end
        
        //SEH
        'b000110:
        begin
            ALUResult= {{16{B[15]}}, B[15:0]}; // I think this works, but i'm not sure, will have to test.
            ALUResult2 = {ALUhi, ALUlo};
            Zero=0;
        end
      
   		//SLL
        'b000111: //7
        begin
            ALUResult=B<<A;
            ALUResult2 = {ALUhi, ALUlo};
            Zero=0;
        end
        
        //SRL
        'b001000: //8
        begin
            ALUResult=B>>A;
            ALUResult2 = {ALUhi, ALUlo};
            Zero=0;
        end
        
        //SLT #ask
        'b001001: //9
        begin
        if($signed(A)<$signed(B))begin
            ALUResult<=1;
            ALUResult2 = {ALUhi, ALUlo};
            Zero=0;
        end
        else begin
            ALUResult<=0;
            ALUResult2 = {ALUhi, ALUlo};
            Zero=0;
        end
        end
        
        //MOVN
        'b001010: //10
        begin
        if(B != 'h00 )begin
            ALUResult = A;
            ALUResult2 = {ALUhi, ALUlo};
            Zero=0;
        end 
        else begin
            ALUResult2 = {ALUhi, ALUlo};
            Zero=0;
        end
        end
        
        //MOVZ
        'b001011: //11
        begin
        if(B=='h00)begin
            ALUResult = A;
            ALUResult2 = {ALUhi, ALUlo};
            Zero=0;
        end 
        else begin    
            ALUResult2 = {ALUhi, ALUlo};
            Zero=0;
        end           
        end
        
        //ROTRV,ROTR
        'b001100: //12
        begin
        tempReg = (B>>A);
        ALUResultTemp2 = B<<(32-A);
        ALUResult = ALUResultTemp2|tempReg;
        ALUResult2 = {ALUhi, ALUlo};
        Zero=0;
        end
        
        //SRA
        'b001101: //13
        begin
        if(B[31]==1)
        begin
        ALUResultTemp2 = B >>> A; 
        ALUResult=ALUResultTemp2;
        ALUResult2 = {ALUhi, ALUlo};
        Zero=0;
        end
        else
        begin
        ALUResultTemp2 = B >> A; 
        ALUResult=ALUResultTemp2;
        ALUResult2 = {ALUhi, ALUlo};
        Zero=0;
        end
        end
        
        //SRAV
        'b001110: //14
        begin
        ALUResult = B>>>A;
        ALUResult2 = {ALUhi, ALUlo};
        Zero=0;
        end
        
        //SEB
        'b001111: //15
        begin
        ALUResult = {{24{B[7]}}, B[7:0]};
        ALUResult2 = {ALUhi, ALUlo};
        Zero=0;
        end 
        
        //SLTIU
        'b010000: //16
        begin
        if($unsigned(A) < $unsigned(B))
        begin
        ALUResult = 1;
        ALUResult2 = {ALUhi, ALUlo};
        Zero=0;
        end
        else
        begin
        ALUResult = 0;
        ALUResult2 = {ALUhi, ALUlo};
        Zero=0;
        end
        end
        
        //SLTU
        'b010001: //17
        begin
        if($unsigned(A) < $unsigned(B))
        begin
        ALUResult = 1;
        ALUResult2 = {ALUhi, ALUlo};
        Zero=0;
        end
        else
        begin
        ALUResult = 0;
        ALUResult2 = {ALUhi, ALUlo};
        Zero=0;
        end
        end
        
        //MUL
        'b010010: //18
        begin
        ALUResult = A * B;
        ALUResult2 = {ALUhi, ALUlo};
        Zero=0;
        end  

        //MULTU
        'b010011: //19
         begin
         ALUResult2 = $unsigned(A)*$unsigned(B);
         Zero=0;
        end
        
        //MADD
        'b010100: //20
        begin
        tempreg2 = {ALUhi, ALUlo};
        ALUResultTemp1 = $signed(tempreg2) + $signed(A)*$signed(B);
        ALUResult2=ALUResultTemp1;
        Zero=0;
        end
        
        //MSUB
        'b010101: //21
        begin;
        Zero=0;
        ALUResult2 = $signed({ALUhi, ALUlo}) - $signed(A)*$signed(B);
        end 
        
        //MULT
        'b010110: //22
        begin
        Zero=0;
        ALUResult2 = $signed(A)*$signed(B);
        end  
        
        //ADDU, ADDIU
        'b010111:
        begin
        Zero=0;
        ALUResult = $unsigned(A) + $unsigned(B);
        ALUResult2 = {ALUhi, ALUlo};
        end
        
        //MFHI
        'b011011: //23
        begin
        Zero=0;
        ALUResult = ALUhi;
       // ALUResult = 64'h12;
        ALUResult2 = {ALUhi, ALUlo};
        end  
        
        //MFLO
        'b011000: //24
        begin
        Zero=0;
        ALUResult = ALUlo;
        ALUResult2 = {ALUhi, ALUlo};
        end  
        
        //MTHI
        'b011001: //25
        begin
        Zero=0;
        ALUResult2 = {A, ALUlo};
        end  
        
        //MTLO
        'b011010: //26
        begin
        Zero=0;
        ALUResult2 = {ALUhi, A};
        end 
        
        //next part of lab
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

//BLTZ
'b100101: //37
begin
if($signed(A)<0)
begin
Zero = 1;
end
else
begin
Zero=0;
end
ALUResult2 = {ALUhi, ALUlo};
end

//BEQ
'b011100: //28
begin
if(A==B)
begin
Zero = 1;
end
else
begin
Zero = 0;
end
ALUResult2 = {ALUhi, ALUlo};
end 

//BNE
'b011101: //29
begin
if($signed(A)!= $signed(B))
begin
Zero = 1;
end
else
begin
Zero = 0;
end
ALUResult2 = {ALUhi, ALUlo};
end


//BGTZ
'b011110: //30
begin
if($signed(A)>0)
begin
Zero = 1;
end
else
begin
Zero = 0;
end
ALUResult2 = {ALUhi, ALUlo};
end

//BLEZ
'b011111:  //31
begin
if($signed(A)<=0)
begin
Zero = 1;
end
else
begin
Zero=0;
end
ALUResult2 = {ALUhi, ALUlo};
end

//BGEZ
'b100000: //32
if(B==2'h01) //bgez
    begin
        if($signed(A)>= 0)
        begin
        Zero = 1;
        end
        else
        begin
        Zero = 0;
        end
    ALUResult2 = {ALUhi, ALUlo};
    end
    
 //lui   
'b100001: //33
begin
    Zero=0;
    ALUResultTemp2 = B<<16;
    ALUResult = {ALUResultTemp2[31:16], 16'b0000000000000000};
    ALUResult2 = {ALUhi, ALUlo};
end

//j
'b100110: //38
begin
    Zero=1;
    ALUResult2 = {ALUhi, ALUlo};
end

//jr
'b100010: //34
begin
    Zero=1;
    ALUResult2 = {ALUhi, ALUlo};
end

//jal
'b100011: //35
begin
    Zero=1;
    ALUResult = PC; 
    ALUResult2 = {ALUhi, ALUlo};
end

/* Start of Data Memory Operations*/
// lw, sw, lb, sb, lh, sh
'b100100: //36
    begin
        ALUResult = A + B;
        ALUResult2 = {ALUhi, ALUlo};
    end

/* End of Data Memory */
// Last used number is 38
endcase
endmodule

        
        
        
        

