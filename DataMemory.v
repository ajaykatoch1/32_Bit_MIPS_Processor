module DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData); 

    input [31:0] Address; 	// Input Address 
    input [31:0] WriteData; // Data that needs to be written into the address 
    input Clk;
    input [1:0]MemWrite; 		// Control signal for memory write 
    input [1:0]MemRead; 			// Control signal for memory read 

    integer i;
    output reg[31:0] ReadData; // Contents of memory location at Address
   //MemRead should be sensitive to when Address||WriteData||ReadData changes
   //Later on, we will probably want to make it sensitive to the clock but not now.
    reg[31:0] memory [0:1023];
    
    initial begin
    //$readmemh("lab15-18testcasesDataMemory.txt",memory);
        end
    
    always @(posedge Clk) begin
    case(MemWrite)
    2'b01://will need to change the wire for MemWrite from 1 bit, to 2 bits, will need to handle multiple instructions.
    begin
    memory[Address[11:2]] <= WriteData;//storeword
    end
    
    2'b10:
    begin
    if(Address[1:0] == 'b00)begin
    memory[Address[11:2]][15:0] <= WriteData[15:0];		//{memory[Address[11:2]][31:16],WriteData[15:0]}; // store as least significant half
    end
    else if(Address[1:0] == 'b10)begin
    memory[Address[11:2]][31:16] <= WriteData[15:0]; //{WriteData[15:0], memory[Address[11:2]][15:0]}; // store as most significant half
    end
    end
       
    2'b11:
    begin
    if(Address[1:0] == 'b00)begin
    memory[Address[11:2]][7:0] <= WriteData[7:0]; //store as least significant byte
    end
    else if(Address[1:0] == 'b01)begin
    memory[Address[11:2]][15:8] <= WriteData[7:0]; //store as middle least significant byte
    end
    else if(Address[1:0] == 'b10)begin
    memory[Address[11:2]][23:16] <= WriteData[7:0]; //store as middle most significant byte
    end
    else if(Address[1:0] == 'b11)begin
    memory[Address[11:2]][31:24] <= WriteData[7:0]; //store as most significant byte
    end
    end        
    
    endcase
    
    end
    
    
   

    
    always @(negedge Clk) 
    begin
    case (MemRead)
    2'b01:
    begin
    ReadData <= memory[Address[11:2]];//loadword
    // then it will read the 32 bits that is at the memory location
    end
    
    2'b10:
    begin  
    if(Address[1:0] == 'b00)begin
    ReadData <= {{16{memory[Address[11:2]][15]}}, memory[Address[11:2]][15:0]};//load lower half
    end
    else if(Address[1:0] == 'b10)begin
    ReadData <= {{16{memory[Address[11:2]][31]}}, memory[Address[11:2]][31:16]};//load upper half
    end
    end
    
    2'b11:
    begin
    if(Address[1:0] == 'b00)begin
    ReadData <= {{24{memory[Address[11:2]][7]}}, memory[Address[11:2]][7:0]};//load least significant byte
    end
    else if(Address[1:0] == 'b01)begin
    ReadData <= {{24{memory[Address[11:2]][15]}}, memory[Address[11:2]][15:8]};//load middle least significant byte
    end
    else if(Address[1:0] == 'b10)begin
    ReadData <= {{24{memory[Address[11:2]][23]}}, memory[Address[11:2]][23:16]};//load middle most significant byte
    end
    else if(Address[1:0] == 'b11)begin
    ReadData <= {{24{memory[Address[11:2]][31]}}, memory[Address[11:2]][31:24]};//load most significant byte
    end
    end 

    endcase
    end
    
endmodule