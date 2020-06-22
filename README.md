# Computer-Architecture

This project was for me and my partner's ECE369 course. We created a 32 Bit Processor which interprets and processes MIPS instructions utilizing pipelining, data forwarding, and data hazards. This was created using Verilog, to setup the processor create a Verilog project and import the files, add the MIPS instruction in data memory (in hex) to be processed, a converter program from MIPS instructions to hex can be used to accomplish this. 

# 10/26/19 - Saturday

# Goals
	- [x] Fix Pipeline Registers
		- Removie temp register in the pipelines
	- [x] Remove delayed components
		- [x] Removed delayed wires
		- [x] Remove modules that delay wires
	- [x] Connected almost all wires to top for datapath to work in labs 15-18
		- [x] Pipeline are being implemented correctly
	- [x] Add `AND` module for branch to execute correctly.
	- [x] Implement `jump` instructions
		- [x] Create another `ADDER` in Execution stage for `jump` instrucitons.
		
# Issues
	- May need to change bit width for ALUOp that goes from `Control` to `ALU`
		- switch from 5 bits to 6 bits.

# Notes
	- Added *MemWrite, MemRead, MemToReg and Branch* to Pipeline registers
	- Initialized `DataMemory` , but still have to add `Address` port.
	- Final mux that `MemToReg` connects to, to send the final result.
	
# 10/30/19 - Wednesday

# Goals
	
# Issues
	Ask him about flushing
		- is it neccessary for this lab
	Ask Sahil about jumping instructions
		- ask if he can explain again about jr MIPS instruction

# Notes
	- Will need to flush pipeline registers when jumping
		- Flush signal should be coming from branch(AND module)
	- jal is 2 instructions
		- jump to address
		- store return address in memory
	- jr
		- should be stored in the 32nd register

	**Project Phase 1**
	
# 11/06/19 - Wednesday
	- Reset the clock after jr is executed in jal jr test case.
		- This is when there is a jal instruction, the following instruction is a jr instruction
	- Move `branch` module to `execute` stage to avoid errors MFHI/MFLO instructions
** Will ask in demo**
	- the little endian system and how it affects the Address
		- least significant bits go to least significant address.
		
# 11/18/19 - Monday
	Hazard Unit:
		- If a load word, then an addi there will need to be a delay.
	Forwarding Unit:
		- The forwarding unit has been initialized
			- 2 3-input Muxe's have been created. 1 for input A, the other for input B
			- If statements have Mem stage as priority, so if there are 2 dependencies on rs for example, the code should be able to handle it.
			- 6 `if statments`, 1 `else statement`
			- first 3 if statements check:
				- rs dependent in mem stage && rt dependent on write statge
				- rs dependent in mem stage && rt not dependent on write statge
				- rs not dependent in mem stage && rt dependent on write statge
			- next 3 if statements check:
				- rt dependent in mem stage && rs dependent on write statge
				- rt dependent in mem stage && rs not dependent on write statge
				- rt not dependent in mem stage && rs dependent on write statge
			- else statement:
				- if none of the previous statements are true
				
# 11/19/19 - Tuesday
	Hazard Unit:
		- If a load word, then an addi there will need to be a delay.
	Forwarding Unit:
		- The forwarding unit @ 610 ns is not working, 
		- addi instruction isn't working, rt field is matching the WB register destination.
		
# 11/20/19 - Wednesday

## Issue
	add *$s0*, $s1, $s2
	sub $t1, $t2, $t3
	mult $s1, $t2, $t3
	add $s1, *$s0*, $s2
	
	In this situation there is a dependency on $s0
	Because the value will be sent from WB, and the current add is in decode stage,<br>
	the value will not be forwarded in time to be read from the register file

## Labs 15-18 Demo
	jal is jumping correctly, but not storing the return address correctly.
		-	Because of this, jr isn't working properly,
	
	Store byte isn't working
	Load byte isn't working
	
	Store half isn't working
	Load half isn't working
	
	Need to create better logic for both halve and byte instructions
	
	**Example written by Sahil**
	if(2_LSB's of address == 00 or 01)
	
## Solution
	Hazard detection unit checks rs and rt in decode and compare to rd in WB (This will stall one clock cycle)
	- or -
	Create muxes to properly forward the updated value from WB to (execute or decode stage) unsure
# 11/24/19 - Sunday

## Issue
	lw instruction on line 67 at 1350 ns is not getting right address
	ADDI   $s2, $s2, 4						$s2 = 4
	SW     $s4, 12($s2)						Store Mem[16(0)] with 255 ($s2 dependent)
	LW     $s2, 12($s2)						Load Mem[16(0)] into ??$s2 = 255??
	
# 11/24/19 - Tuesday

## Goals
	- [x] Continue writing for data hazard
		- [x] add in wires from writeback stage `WB.rd`
		- [x] pass the following instructions:
		addi $s2, $s2, 4
		addi $s2, $s2, 4
		sw $s4, 16($s2)
		lw $s2, 16($s2)
		
## Issue

# 11/27/19 - Wednesday

## Goals
	- [x] sll instruction not working, fix it.
## Issue

# 11/27/19 - Thursday

## Goals
	- [ ] 
## Issue
	- at 590 ns, line 27 is repeating twice, then line 28 repeats twice for some reason.
	
### List of Dependencies need to be fixed
	- lw $s4, 0($s5)
	  sw $s4, 0($s7)
	  dependency on $s4

# 11/30/19 - Saturday

## Goals
	- [ ] Fix load words dependencies,
		- [ ] all *Register_Signal* should be made 2 bits wide
		- [ ] all registers should be made to handle flushing and stalling
		- [ ] Have 1 be a stall
		- [ ] Have 2 be a flush
	
	- [ ] Pass testcase on lines 173 and 174, this is a lw dependency
		- [ ] This is at 3410 ns
## Issue
	- at 590 ns, line 27 is repeating twice, then line 28 repeats twice for some reason.
	
# 12/01/19 - Sunday

## Goals
	- [ ] Will need to checks for lw.
		- [ ] One to compare from the *Memory* stage to the *Execute* stage.
		- [ ] One to compare from the *Memory* to the *Instruction Fetch* stage??
			- Current logic may already support this
	
	- [ ] Pass testcase on lines 173 and 174, this is a lw dependency
		- [ ] This is at 3410 ns
	
	- [ ] Left off at 5480 ns on line 273
## Issue
	- at 590 ns, line 27 is repeating twice, then line 28 repeats twice for some reason.
	
# 12/02/19 - Monday

## Notes
	- Last day of regular lab session
	- Proper office hours this week
	- Demo starts on Wednesday
	- For those looking to compete, sign up by Friday this week.
	
## Phase 1
	-
	
## Phase 2
	- Using vbsme on FPGA
	- Using vbsme for Instruction Memory
	- Procedure will be released on d2l
	- Using 7 segment display
	- Phase 2 demonstration will start Monday and there will still be some on Wednesday
	- Due on Monday at 2:00
	- takes 2 16 bit for 7 segment display
	- 8 lsb off x, 8 lsb off y
	- 16 from the min SAD
	- You discard the MSB's from the x and y coordinates

## Questions?
	- When does Phase 2 need to be submitted?
	
# 12/03/19 - Tuesday

## Goals
	- set register 29 to 32000 in registerfile
	- set DataMemory size 0:8000
		- reg [31:0] memory[0:8000]
## Issue
	- at 590 ns, line 27 is repeating twice, then line 28 repeats twice for some reason.
	
