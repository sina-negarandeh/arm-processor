module ID_Stage (
  input         clk,
  input         rst,
  
  // From Instruction Fetch Stage
  input [31:0]  pc_in,
  input [31:0]  instruction,
  
  // From Hazard Detection Unit
  input         hazard,
  
  // From Status Register
  input [3:0]   sr,
  
  // From Write Back Stage
  input [3:0]   wb_dest,
  input [31:0]  wb_value,
  input         wb_wb_en,
  
  output        wb_en,
  output        mem_r_en,
  output        mem_w_en,
  output [3:0]  exe_cmd,
  output        b,
  output        s,
  output        pc,
  output [31:0] value_rn,
  output [31:0] value_rm,
  output [11:0] shift_operand,
  output imm,
  output [23:0] imm_signed_24,
  output [3:0]  dest,
  
  // To Hazard Detection Unit
  
  output        two_src,
  output [3:0]  src_1,
  output [3:0]  src_2
  );

endmodule
