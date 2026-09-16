////////////////////////////////////////////////////////////////////
//
//  Registro8BitsEna.v
//
//  Este modulo como registro de 8 bits
//                
//  Pablo Navarro y Vladimir Gonzales
//
////////////////////////////////////////////////////////////////////

module Registro8BitEna (CLK, RST, ENA, D, Q);

    input CLK, RST, ENA;
    input [7:0] D;
    output reg [7:0] Q;

    always @(posedge CLK or posedge RST) begin
        if (RST)
            Q = 8'h00;
        else if (ENA)
            Q = D;
        else
            Q = Q;
    end
    
endmodule

////////////////////////////////////////////////////////////////////
