////////////////////////////////////////////////////////////////////
//
//  GenDir.v
//
//  Este modulo sirve como el generador de direcciones
//                
//  Pablo Navarro y Vladimir Gonzales
//
////////////////////////////////////////////////////////////////////

`include "Multiplexor2a1de16bits.v"
`include "Multiplexor4a1de16bits.v"
`include "Multiplexor6a1de16bits.v"
`include "Sumador16bits.v"
`include "Sumador20bits.v"

module GenDir (CLK, RST, OP, ENA, SEL_IP, SEL_SEG, 
               M1_SEL, M2_SEL, IN_REGS, 
               IN_SEGS, IN_IP, DESP, DIR,
               OUT_BX, OUT_DI, OUT_SI, OUT_BP, OUT_SP, 
               OUT_CS, OUT_SS, OUT_DS, OUT_ES, OUT_IP);

    input CLK, RST; 
    input OP; 
    input ENA;
    input SEL_IP;
    input [1:0] SEL_SEG;
    input [2:0] M1_SEL, M2_SEL;
	input [15:0] IN_REGS;        
    input [15:0] IN_SEGS;        
    input [15:0] IN_IP; 
    input [15:0] DESP;
    output wire [19:0] DIR;

    //Banco de registros
        input [15:0] OUT_BX, OUT_DI, OUT_SI, OUT_BP, OUT_SP;

    //Registros de segmento
        input [15:0] OUT_CS, OUT_SS, OUT_DS, OUT_ES;

    //Registro IP
        input [15:0] OUT_IP;

    //Multiplexores para Direccionar con registros
        wire [15:0] OUT_MUX1, OUT_MUX2;
        Multiplexor6a1de16bits M1 (OUT_BX, OUT_DI, OUT_SI, OUT_BP, OUT_SP, 16'b0, M1_SEL, OUT_MUX1);
        Multiplexor6a1de16bits M2 (OUT_BX, OUT_DI, OUT_SI, OUT_BP, OUT_SP, 16'b0, M2_SEL, OUT_MUX2);

    //Sumador 1 y 2 de los dos primeros multiplexores
        wire [15:0] OUT_SUM1, OUT_SUM2;
        Sumador16bits SUM1 (OUT_MUX1, OUT_MUX2, OUT_SUM1);
        Sumador16bits SUM2 (OUT_SUM1, DESP, OUT_SUM2);

    //Multiplexor para elegir entre DISP y IP
        wire [15:0] OUT_MUX3;
  		Multiplexor2a1de16bits M3 (OUT_IP, OUT_SUM2, OP, OUT_MUX3);

    //Multiplexor para elegir el segmento
        wire [15:0] OUT_MUX4;
        Multiplexor4a1de16bits M4 (OUT_CS, OUT_SS, OUT_DS, OUT_ES, SEL_SEG, OUT_MUX4);

    //Multiplexor para elegir segmento o CS 
        wire [15:0] OUT_MUX5;
        Multiplexor2a1de16bits M5 (OUT_CS, OUT_MUX4, OP, OUT_MUX5);

    //Sumador final
  		Sumador20bits SUM3 ({4'b0000, OUT_MUX3}, {OUT_MUX5,4'b0000}, DIR, CLK, ENA, RST);

endmodule

////////////////////////////////////////////////////////////////////