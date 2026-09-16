////////////////////////////////////////////////////////////////////
//
//  Multiplexor4a1de16bits.v
//
//  Este modulo sirve como multiplexor de 4 a 1 de 16 bits
//                
//  Pablo Navarro y Vladimir Gonzales
//
////////////////////////////////////////////////////////////////////

 module Multiplexor4a1de16bits (A, B, C, D, SEL, OUT);
    
    input [15:0] A, B, C, D;
    input [1:0] SEL;
    output reg [15:0] OUT;

    always @(A or B or SEL) begin
        case (SEL)
            2'd0: OUT = A;
            2'd1: OUT = B;
            2'd2: OUT = C;
            2'd3: OUT = D;
        endcase
    end

 endmodule

////////////////////////////////////////////////////////////////////z