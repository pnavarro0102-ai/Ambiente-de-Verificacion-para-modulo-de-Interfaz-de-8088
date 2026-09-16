////////////////////////////////////////////////////////////////////
//
//  Modulo_Interfaz8088.v
//
//  Este modulo sirve como modulo principal 
//                
//  Pablo Navarro y Vladimir Gonzales
//
////////////////////////////////////////////////////////////////////

`include "GenDir.v"
`include "BuffINOUT.v"
`include "queue.v"

`include "Reg_BX.v"
`include "Reg_DI.v"
`include "Reg_SI.v"
`include "Reg_BP.v"
`include "Reg_SP.v"
`include "Reg_CS.v"
`include "Reg_SS.v"
`include "Reg_DS.v"
`include "Reg_ES.v"
`include "Reg_IP.v"

module Modulo_Interfaz8088 (CLK, RST, OP,
                            //Entradas de GenDir
                            ENA, SEL_IP, SEL_SEG, M1_SEL, M2_SEL, 
                            IN_REGS, IN_SEGS, IN_IP, DESP, DIR,
                            //Entradas de BufferINOUT
                            IWR, IRD, RD, WR, DataBus, InternalBus,
                            //Entradas del queue
                            QUEUE_DATA, S_IP);

    input CLK, RST;                        
    
//Señales de GenDir
    input         OP;             
    input         ENA; 
    input         SEL_IP;         
    input  [1:0]  SEL_SEG;
    input  [2:0]  M1_SEL;
    input  [2:0]  M2_SEL;
    input  [15:0] DESP;          
    input  [15:0] IN_REGS;        
    input  [15:0] IN_SEGS;        
    input  [15:0] IN_IP;          
    output wire [19:0] DIR;       
	output [15:0] S_IP;
  
//Señales de BufferINOUT
    inout IWR;                   
    inout IRD;                    
    input RD;                    
    input WR;                     
    inout wire [7:0] DataBus;     
    inout wire [7:0] InternalBus;
	
  

//Banco de registros
    wire [15:0] OUT_BX, OUT_DI, OUT_SI, OUT_BP, OUT_SP;
    Reg_BX BX (CLK, RST, ENA, IN_REGS, OUT_BX);
    Reg_DI DI (CLK, RST, ENA, IN_REGS, OUT_DI);
    Reg_SI SI (CLK, RST, ENA, IN_REGS, OUT_SI);
    Reg_BP BP (CLK, RST, ENA, IN_REGS, OUT_BP);
    Reg_SP SP (CLK, RST, ENA, IN_REGS, OUT_SP);

//Registros de segmento
    wire [15:0] OUT_CS, OUT_SS, OUT_DS, OUT_ES;
    Reg_CS CS (CLK, RST, ENA, IN_SEGS, OUT_CS);
    Reg_SS SS (CLK, RST, ENA, IN_SEGS, OUT_SS);
    Reg_DS DS (CLK, RST, ENA, IN_SEGS, OUT_DS);
    Reg_ES ES (CLK, RST, ENA, IN_SEGS, OUT_ES);
    
//Registro IP
    wire [15:0] OUT_IP;
    Reg_IP IP (CLK, RST, ENA, SEL_IP, IN_IP, OUT_IP);
    assign S_IP = OUT_IP;

//Instancia de GenDir
  GenDir Gendir (CLK, RST, OP, ENA, SEL_IP,SEL_SEG, 
                 M1_SEL, M2_SEL, IN_REGS, IN_SEGS, 
                 IN_IP, DESP, DIR, OUT_BX, OUT_DI, 
                 OUT_SI, OUT_BP, OUT_SP, OUT_CS, 
                 OUT_SS, OUT_DS, OUT_ES, OUT_IP);

//Instancia de BufferINOUT
  BuffINOUT Buffer (CLK, RST, IWR, IRD, RD, WR, DataBus, InternalBus);

//Señales de queue
  output wire [31:0] QUEUE_DATA;
  
//Instancia de queue
  queue QUEUE (CLK, RST, ENA, DataBus, QUEUE_DATA); 

endmodule

////////////////////////////////////////////////////////////////////
