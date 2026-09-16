////////////////////////////////////////////////////////////////////
//
//  Reg_IP.v
//
//  Este modulo sirve como registro IP
//                
//  Pablo Navarro y Vladimir Gonzales
//
////////////////////////////////////////////////////////////////////

module Reg_IP (CLK, RST, ENA, SEL, D, Q);

    input CLK, RST, ENA, SEL;
    input [15:0] D;
    output reg [15:0] Q;

    reg [15:0] RIN;
  always @(Q or D or SEL) begin
        case (SEL)
            1'b0: RIN = Q + 1;
            1'b1: RIN = D; 
        endcase
        
    end

  always @(posedge CLK or posedge RST) begin
        if (RST)
            Q = 8'h00; 
        else if (ENA)
            Q = RIN;
        else
            Q = Q;
    end
 
    
endmodule
////////////////////////////////////////////////////////////////////