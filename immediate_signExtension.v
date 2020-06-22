`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2019 06:42:36 PM
// Design Name: 
// Module Name: immediate_signExtension
// Project Name: 
// Target Devices: 
// Tool Versions: 
`timescale 1ns / 1ps
module immediate_signExtension(in, out);

    /* A 16-Bit input word */
    input [15:0] in;
    
    /* A 32-Bit output word */
    output reg [31:0] out;   //using always @
    //output [31:0] out;   //using assign statement
    
    parameter ZEROES = 16'd0;
    
    always @(in) begin   
            out <= {ZEROES, in};
        end
  

endmodule