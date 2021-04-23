module ID_Stage_Reg (
  input              clk,
  input              rst,
  
  // From Instruction Decode Stage
  input              wb_en_in,
  input              mem_r_en_in,
  input              mem_w_en_in,
  input [3:0]        exe_cmd_in,
  input              b_in,
  input              s_in,
  input              pc_in,
  input [31:0]       value_rn_in,
  input [31:0]       value_rm_in,
  input [11:0]       shift_operand_in,
  input              imm_in,
  input [23:0]       imm_signed_24_in,
  input [3:0]        dest_in,
  
  // From Executaion Stage
  input              flush,
  
  output             wb_en,
  output             mem_r_en,
  output             mem_w_en,
  output [3:0]       exe_cmd,
  output             b,
  output             s,
  output             pc,
  output [31:0]      value_rn,
  output [31:0]      value_rm,
  output [11:0]      shift_operand,
  output             imm,
  output [23:0]      imm_signed_24,
  output [3:0]       dest 
  );

endmodule
