module EXE_Stage (
  input         clk,
  input         rst,

  input [3:0] exe_cmd,
  input wb_en_in,
  input mem_r_en_in,
  input mem_w_en_in,
  input [31:0] pc_in,
  input [31:0] val_rn,
  input [31:0] val_rm,
  input        imm,
  input [11:0] shift_operand,
  input [23:0] imm_signed_24,
  input [3:0] sr,

  output wb_en,
  output mem_r_en,
  output mem_w_en,
  output [31:0] alu_result,
  output [31:0] br_addr,
  output [3:0] status
  );
  
  wire or_output;
  assign or_output = mem_r_en_in || mem_w_en_in;
  
  wire [31:0] val_2;
  
  Val2Generator val_2_generator (clk, rst, val_rm, shift_operand, imm, or_output, val_2);
  
  assign br_addr = pc_in + ({{8{imm_signed_24[23]}}, {imm_signed_24}} << 2);
  
  ALU alu (clk, rst, val_rn, val_2, exe_cmd, sr, alu_result, status);
  
  assign wb_en = wb_en_in;
  assign mem_r_en = mem_r_en_in;
  assign mem_w_en = mem_w_en_in;

endmodule
