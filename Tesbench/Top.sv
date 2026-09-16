////////////////////////////////////////////////////////////////////
//
//  Top.sv
//
//  Este modulo sirve como modulo pricipal de testeo
//                
//  Pablo Navarro y Vladimir Gonzales
//
////////////////////////////////////////////////////////////////////

`include "Interface.sv"
`include "Tester.sv"
`include "Scoreboard.sv"

module Top;
  
  	initial begin
    	$dumpfile("Wavetb.vcd");
      $dumpvars(0, Top);   
    end

    //Interfaz
    Modulo_Interfaz8088_if bfm();

    //Tester
    Tester Test (bfm);

    //Scoreboard
    Scoreboard SCORE(bfm);

    //DUT
    Modulo_Interfaz8088 DUT (.CLK(bfm.CLK), 
                             .RST(bfm.RST),
                            //Entradas de GenDir
                             .ENA(bfm.ENA),  
                            .OP(bfm.OP),
                            .SEL_IP(bfm.SEL_IP), 
                            .SEL_SEG(bfm.SEL_SEG), 
                            .M1_SEL(bfm.M1_SEL), 
                            .M2_SEL(bfm.M2_SEL), 
                            .IN_REGS(bfm.IN_REGS), 
                            .IN_SEGS(bfm.IN_SEGS), 
                            .IN_IP(bfm.IN_IP), 
                            .DESP(bfm.DESP), 
                            .DIR(bfm.DIR),
                            //Entradas de BufferINOUT
                            .IWR(bfm.IWR), 
                            .IRD(bfm.IRD), 
                            .RD(bfm.RD), 
                            .WR(bfm.WR), 
                            .DataBus(bfm.DataBus),
                            .InternalBus(bfm.InternalBus),
                            //Entradas del queue 
                            .QUEUE_DATA(bfm.QUEUE_DATA),
                            .S_IP(bfm.S_IP)
                            );
    
endmodule

////////////////////////////////////////////////////////////////////
