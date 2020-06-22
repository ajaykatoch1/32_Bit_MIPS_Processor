`timescale 1ns / 1ps
module SignExtension(in, out);

    /* A 16-Bit input word */
    input [15:0] in;
    
    /* A 32-Bit output word */
    output reg [31:0] out;   //using always @
    //output [31:0] out;   //using assign statement
    
    parameter ONES = 16'b1111111111111111, ZEROES = 16'b0000000000000000;
    
    always @(in) begin
        if ((in[15]) == 0) begin
            out <= {ZEROES, in};
        end
        else begin
            out <= {ONES, in};
        end
    end

endmodule
