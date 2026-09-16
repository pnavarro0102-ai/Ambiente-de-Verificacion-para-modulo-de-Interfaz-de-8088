////////////////////////////////////////////////////////////////////
//
//  queue.v
//
//  Este modulo sirve como queue
//                
//  Pablo Navarro y Vladimir Gonzales
//
////////////////////////////////////////////////////////////////////

//`include "Registro8BitEna.v"

module queue (CLK, RST, ENA, DATAIN, DATAOUT);

    input CLK, RST, ENA;
    input [7:0] DATAIN;
    output wire [31:0] DATAOUT;

//DATAIN -> R1 -> R2 -> R3 -> R4

    wire [7:0] DOUT1, DOUT2,  DOUT3, DOUT4;

    Registro8BitEna R4 (CLK, RST, ENA, DOUT3, DOUT4);
    Registro8BitEna R3 (CLK, RST, ENA, DOUT2, DOUT3);
    Registro8BitEna R2 (CLK, RST, ENA, DOUT1, DOUT2);
    Registro8BitEna R1 (CLK, RST, ENA, DATAIN, DOUT1);

    assign DATAOUT = {DOUT4, DOUT3, DOUT2, DOUT1};
    
endmodule

//Funcionamiento del queue

//DO4 , DO3 , DO2 , DO1
//00H , 00H , 00H , 00H
//00H , 00H , 00H , 0AH
//00H , 00H , 0AH , F0H
//00H , 0AH , F0H , D7H
//0AH , F0H , D7H , 51H

////////////////////////////////////////////////////////////////////
