module HI_Register(Clock, HI_In, HI_Out);
input [31:0] HI_In;
input Clock;
reg [31:0]HI;
output [31:0] HI_Out;

always @(posedge Clock)
    begin
        HI <= HI_In; 
    end 
assign HI_Out = HI;
endmodule
