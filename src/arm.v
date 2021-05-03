module ARM (
  input clk,
  input rst
  );
  
  // Instrucntion Fetch Stage

  wire branch_tacken;
  wire [31:0] branch_address;
  wire freeze;
  wire [31:0] pc;
  wire [31:0] instruction;
  
  // Instruction Festch Stage Reg
  
  wire flush;
  wire [31:0] pc_if_reg;
  wire [31:0] instruction_if_reg;
  
    // Instruction Decode Stage
  
  wire hazard;
  wire [3:0]   sr;
  wire [3:0]   wb_dest;
  wire [31:0]  wb_value;
  wire         wb_wb_en;
  
  wire        wb_en_id;
  wire        mem_r_en_id;
  wire        mem_w_en_id;
  wire [3:0]  exe_cmd_id;
  wire        b_id;
  wire        s_id;
  wire [31:0] pc_id;
  wire [31:0] value_rn_id;
  wire [31:0] value_rm_id;
  wire [11:0] shift_operand_id;
  wire imm_id;
  wire [23:0] imm_signed_24_id;
  wire [3:0]  dest_id;
  
  wire        two_src_id;
  wire [3:0]  src_1_id;
  wire [3:0]  src_2_id;
  
  // ID STAGE REG

  wire        wb_en_id_reg;
  wire        mem_r_en_id_reg;
  wire        mem_w_en_id_reg;
  wire [3:0]  exe_cmd_id_reg;
  wire        b_id_reg;
  wire        s_id_reg;
  wire [31:0] pc_id_reg;
  wire [31:0] value_rn_id_reg;
  wire [31:0] value_rm_id_reg;
  wire [11:0] shift_operand_id_reg;
  wire        imm_id_reg;
  wire [23:0] imm_signed_24_id_reg;
  wire [3:0]  dest_id_reg;
  
  // Other Stages
  
  wire [31:0] pc_exe;
  wire [31:0] pc_exe_reg;
  wire [31:0] pc_mem;
  wire [31:0] pc_mem_reg;
  wire [31:0] pc_wb;
  
  assign branch_tacken = 1'b0;
  assign branch_address = 32'b00000000000000000000000000000000;
  assign freeze = 1'b0;
  
  assign flush = 1'b0;
  
  assign hazard = 1'b0;
  assign sr = 4'b0000;
  assign wb_dest = 4'b0000;
  assign wb_value = 32'b00000000000000000000000000000000;
  assign wb_wb_en = 1'b0;
  
  IF_Stage if_stage (clk, rst, branch_tacken, branch_address, freeze, pc, instruction);
  IF_Stage_Reg if_stage_reg (clk, rst, pc, instruction, flush, freeze, pc_if_reg, instruction_if_reg);
  
  ID_Stage id_stage (clk, rst, pc_if_reg, instruction_if_reg, hazard, sr, wb_dest, wb_value, wb_wb_en, wb_en_id,
    mem_r_en_id, mem_w_en_id, exe_cmd_id, b_id, s_id, pc_id, value_rn_id, value_rm_id, shift_operand_id, imm_id, imm_signed_24_id, dest_id, two_src_id, src_1_id, src_2_id);
  
  ID_Stage_Reg id_stage_reg (clk, rst, wb_en_id, mem_r_en_id, mem_w_en_id, exe_cmd_id, b_id, s_id, pc_id,
    value_rn_id, value_rm_id, shift_operand_id, imm_id, imm_signed_24_id, dest_id, flush,
    wb_en_id_reg, mem_r_en_id_reg, mem_w_en_id_reg, exe_cmd_id_reg, b_id_reg, s_id_reg, pc_id_reg, value_rn_id_reg, value_rm_id_reg, shift_operand_id_reg, imm_id_reg, imm_signed_24_id_reg, dest_id_reg);
  
  EXE_Stage exe_stage (clk, rst, pc_id_reg, pc_exe);  
  EXE_Stage_Reg exe_stage_reg (clk, rst, pc_exe, pc_exe_reg);
  MEM_Stage mem_stage (clk, rst, pc_exe_reg, pc_mem);
  MEM_Stage_Reg mem_stage_reg (clk, rst, pc_mem, pc_mem_reg);
  WB_Stage wb_stage (clk, rst, pc_mem_reg, pc_wb);

endmodule
