////////////////////////////////////////////////////////////////////
//
//  BuffINOUT.v
//
//  Este modulo sirve como buffer IN OUT
//                
//  Pablo Navarro y Vladimir Gonzales
//
////////////////////////////////////////////////////////////////////

`include "Multiplexor2a1de8bits.v"
`include "Registro8BitEna.v"
`include "BufferTri8bits.v"

module BuffINOUT (CLK, RST, IWR, IRD, RD, WR, DataBus, InternalBus);

    input CLK, RST;
    input IWR, IRD, RD, WR;
    inout wire [7:0] DataBus;
    inout wire [7:0] InternalBus;

//Mux
  wire [7:0] OUT_MUX;
  Multiplexor2a1de8bits M1 (InternalBus, DataBus, WR, OUT_MUX);
    
//Registros
  wire [7:0] OUT_R1;    
  Registro8BitEna R1 (CLK, RST, (IRD | WR), OUT_MUX, OUT_R1);

//Buffers
  BufferTri8bits T1 (OUT_R1, IWR, DataBus);
  BufferTri8bits T2 (OUT_R1, RD, InternalBus);

endmodule

////////////////////////////////////////////////////////////////////