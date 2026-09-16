////////////////////////////////////////////////////////////////////
//
//  Reg_BX.v
//
//  Este modulo sirve como registro BX de 16 bits
//                
//  Pablo Navarro y Vladimir Gonzales
//
////////////////////////////////////////////////////////////////////
module Reg_BX (
    input wire CLK,
    input wire RST,
    input wire ENA,
    input wire [15:0] IN,
    output reg [15:0] OUT
    );

  always @(posedge CLK or posedge RST) begin
        if (RST) begin
            OUT <= 16'h0000;  
        end else if (ENA) begin
            OUT <= IN;
        end
    end


endmodule

//////////////////////////////////////////////////////////////////////
