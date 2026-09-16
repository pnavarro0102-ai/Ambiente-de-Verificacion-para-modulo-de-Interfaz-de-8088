////////////////////////////////////////////////////////////////////
//
//  Tester.sv
//
//  Este modulo sirve como tester
//                
//  Pablo Navarro y Vladimir Gonzales
//
////////////////////////////////////////////////////////////////////


module Tester (Modulo_Interfaz8088_if bfm);
    
    initial begin
      
      bfm.Reset_Modulo_Interfaz8088();
      
      repeat(1000) begin
        
        @(negedge bfm.CLK);
        
        bfm.Random_BufINOUT_Control();
        bfm.Random_DataBus();
        bfm.Random_GenDir_Control();
        bfm.Random_Data_Regs();
        bfm.Random_Desp();
        bfm.ENABLE();
		
      end
      
       $stop;
      
    end

endmodule : Tester

////////////////////////////////////////////////////////////////////