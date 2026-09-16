////////////////////////////////////////////////////////////////////
//
//  Interface.sv
//
//  Este modulo sirve como interfaz
//                
//  Pablo Navarro y Vladimir Gonzales
//
////////////////////////////////////////////////////////////////////

interface Modulo_Interfaz8088_if;
    

//Definición de señales
    bit CLK, RST;
    bit ENA, SEL_IP, OP;                            
    bit [1:0]  SEL_SEG;                          
    bit [2:0]  M1_SEL, M2_SEL;                   
    bit [15:0] DESP, IN_REGS, IN_SEGS, IN_IP, S_IP;                            
    bit WR, RD;  
  	tri IRD, IWR;
    bit [19:0] DIR;
    logic [31:0] QUEUE_DATA;
  
  	logic [7:0]  DataBus_drv, Internal_Bus_drv;        
  	tri   [7:0]  DataBus;     
  	tri   [7:0]  InternalBus ;        
  
  
   
//Declaratoria inicial de reloj 
    initial begin
        CLK = 0;
        forever
            #10 CLK = ~CLK;
    end
  
// Reset y valores por defecto
  initial begin
    // Inicializa control DUT para no interferir
    force IWR  = 0;
    force IRD  = 0;
    RD   = 0;
    WR   = 0;
    // Inicializa queue/desplazamiento
    ENA = 0;
    // Inicializa GenDir
    OP = 0; SEL_IP = 0;
    SEL_SEG = 0; M1_SEL = 0; M2_SEL = 0;
    IN_REGS = 0; IN_SEGS = 0; IN_IP = 0; DESP = 0;
    // Inicializa buses
    DataBus_drv = 8'h00;
  end

task Reset_Modulo_Interfaz8088();
        RST = 0;
        @(negedge CLK);
        RST = 1;
  		@(posedge CLK); 
        RST = 0;
    endtask
//Señales de control de GenDir
  task Random_GenDir_Control();
     SEL_IP   = $urandom_range(0,1);
     OP       = $urandom_range(0,1);
     SEL_SEG  = $urandom_range(0,3);
     M1_SEL   = $urandom_range(0,5);
     M2_SEL   = $urandom_range(0,5);
  endtask : Random_GenDir_Control
  
  
  task ENABLE();
     @(posedge CLK);
     ENA = 1'b1;
     @(negedge CLK); 
     @(negedge CLK);
     ENA = 1'b0;
     @(negedge CLK);
  endtask
  
  
  
  
  
  
//Señales de control de BufINOUT  
  task Random_BufINOUT_Control();
     release RD;
    
     force IRD = $urandom_range(0,1);
     WR  = $urandom_range(0,1);
    
     release IWR;

     force  IWR = WR;

     RD  = IRD;
  endtask : Random_BufINOUT_Control 
  
//Datos para registros
  task Random_Data_Regs();
     IN_REGS = $urandom_range(0,16'hFFFF);
     IN_SEGS = $urandom_range(0,16'hFFFF);
     IN_IP   = $urandom_range(0,16'hFFFF);
  endtask : Random_Data_Regs

//Desplazamiento
  task Random_Desp();
     DESP = $urandom_range(0,16'hFFFF);
  endtask

  
//Datos del Bus
  task Random_DataBus();
    
     release InternalBus;
     release DataBus;

   	 force DataBus = $urandom_range(8'h00, 8'hFF);
     force InternalBus = $urandom_range(8'h00, 8'hFF);
    
  endtask : Random_DataBus
         

endinterface //Modulo_Interfaz8088_if

////////////////////////////////////////////////////////////////////
