////////////////////////////////////////////////////////////////////
//
//  Multiplexor6a1de16bits.v
//
//  Este modulo sirve como multiplexor de 6 a 1 de 16 bits
//                
//  Pablo Navarro y Vladimir Gonzales
//
////////////////////////////////////////////////////////////////////

 module Multiplexor6a1de16bits (A, B, C, D, E, F, SEL, OUT);
    
    input [15:0] A, B, C, D, E, F;
    input [2:0] SEL;
    output reg [15:0] OUT;

    always @(A or B or SEL) begin
        case (SEL)
            3'd0: OUT = A;
            3'd1: OUT = B;
            3'd2: OUT = C;
            3'd3: OUT = D;
            3'd4: OUT = E;
            3'd5: OUT = F;
            default: OUT = 16'd0;
        endcase
    end

 endmodule

////////////////////////////////////////////////////////////////////