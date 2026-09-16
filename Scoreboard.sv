////////////////////////////////////////////////////////////////////
//
//  Scoreboard.sv
//
//  Este modulo sirve como Scoreboard
//                
//  Pablo Navarro y Vladimir Gonzales
//
////////////////////////////////////////////////////////////////////


module Scoreboard (Modulo_Interfaz8088_if bfm);


  reg [7:0]  sb_R1, sb_R2, sb_R3, sb_R4;
  reg [31:0] expected_queue;
  
  initial begin
    sb_R1 = 0; sb_R2 = 0; sb_R3 = 0; sb_R4 = 0;
    expected_queue = 0;
  end

  always @(posedge bfm.CLK) begin
    if (bfm.ENA) begin
      sb_R4 = sb_R3;
      sb_R3 = sb_R2;
      sb_R2 = sb_R1;
      sb_R1 = bfm.DataBus;
      #1;
      expected_queue = {sb_R4, sb_R3, sb_R2, sb_R1};
      $display("@%0t | QUEUE_EXPECTED=%h | QUEUE_ACTUAL=%h",
               $time, expected_queue, bfm.QUEUE_DATA);
      if (expected_queue !== bfm.QUEUE_DATA)
        $error("MISMATCH en queue: esperado=%h, obtenido=%h",
               expected_queue, bfm.QUEUE_DATA);
    end
  end

  reg [15:0] reg1, reg2;
  reg [15:0] sum1, sum2;
  reg [19:0] expected, dir_now;

  
  initial begin
    reg1 = 0;
    reg2 = 0;
    sum1 = 0;
    sum2 = 0;
  end
  
  always @(negedge bfm.ENA) begin

    case(bfm.M1_SEL)
      5: reg1 = 0;
      default: reg1 = bfm.IN_REGS;
    endcase

    case(bfm.M2_SEL)
      5: reg2 = 0;
      default: reg2 = bfm.IN_REGS;
    endcase

    sum1 = reg1 + reg2;
    sum2 = bfm.DESP + sum1;

    if(bfm.OP)
      expected = {4'b0000, sum2} + {bfm.IN_SEGS, 4'b000};
    else 
      expected = {4'b0000,bfm.S_IP } + {bfm.IN_SEGS, 4'b000};

    dir_now = bfm.DIR;
    if (expected !== dir_now) begin
        $error("Mismatch DIR @%0t ns: exp=%h got=%h", $time, expected, dir_now);
    end else
        $display("Check OK @%0t ns: DIR=%h", $time, dir_now);
   
  end


endmodule : Scoreboard
