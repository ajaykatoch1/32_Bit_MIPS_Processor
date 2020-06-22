module LO_Register(Clock, LO_In, LO_Out);
input [31:0] LO_In;
input Clock;
reg [31:0]LO;
output [31:0] LO_Out;

always @(posedge Clock)
    begin
        LO <= LO_In; 
    end 
assign LO_Out = LO;
endmodule