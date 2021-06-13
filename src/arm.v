module ARM (
  input           clk,
  input           rst,
  
  inout [63:0]    sram_dq,
  output          sram_we_n,  
  output [16:0]   sram_address
  );
  
  // Instrucntion Fetch Stage

  wire branch_tacken;
  wire [31:0] branch_address;
  wire [31:0] pc;
  wire [31:0] instruction;
  
  // Instruction Festch Stage Reg
  
  wire flush;
  wire [31:0] pc_if_reg;
  wire [31:0] instruction_if_reg;
  
    // Instruction Decode Stage
  
  wire hazard;
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
  
  // Instruction Decode Stage Reg

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
  wire [3:0] sr_id_reg;
  
  // Execution Stage
  
  wire wb_en_exe;
  wire mem_r_en_exe;
  wire mem_w_en_exe;
  wire [31:0] alu_result_exe;
  wire [31:0] br_addr_exe;
  wire [3:0] status_exe;
  wire [31:0] val_rm_exe;
  wire [3:0] dest_exe;
  
  // Status Register
  
  wire [3:0]   sr;
  
  // Execution Stage Reg
  
  wire        wb_en_exe_reg;
  wire        mem_r_en_exe_reg;
  wire        mem_w_en_exe_reg;
  wire [31:0] alu_result_exe_reg;
  wire [31:0] st_val_exe_reg;
  wire [3:0]  dest_exe_reg;
  wire [31:0] val_rm_exe_reg;
  
  // Memory Stage
  
  wire wb_en_mem;
  wire mem_r_en_mem;
  wire mem_w_en_mem;
  wire [31:0] alu_result_mem;
  wire [31:0] data_memory_mem;
  wire [3:0] dest_mem;
  
  wire            ready;
  
  // Memory Stage Reg
  
  wire         wb_en_mem_reg;
  wire         mem_r_en_mem_reg;
  wire [31:0]  alu_result_mem_reg;
  wire [31:0]  data_memory_out_mem_reg;
  wire [3:0]   dest_mem_reg;
  
  wire [3:0] src_1;
  wire [3:0] src_2;
  
  wire forwarding_bit;
  assign forwarding_bit = 1'b1;
  
  wire [1:0] sel_src_1;  
  wire [1:0] sel_src_2;
  
  wire freeze;
  assign freeze = hazard | (~ready);
  
  IF_Stage if_stage (clk, rst, b_id_reg, br_addr_exe, freeze, pc, instruction);
  IF_Stage_Reg if_stage_reg (clk, rst, pc, instruction, b_id_reg, freeze, pc_if_reg, instruction_if_reg);
  
  HazardDetectionUnit hazard_detection_unit (clk, rst, src_1_id, src_2_id, dest_exe, wb_en_exe,
    dest_mem, wb_en_mem, two_src_id, forwarding_bit, mem_r_en_id_reg, hazard);
  
  ID_Stage id_stage (clk, rst, pc_if_reg, instruction_if_reg, hazard, sr, wb_dest, wb_value, wb_wb_en, wb_en_id,
    mem_r_en_id, mem_w_en_id, exe_cmd_id, b_id, s_id, pc_id, value_rn_id, value_rm_id, shift_operand_id, imm_id, imm_signed_24_id, dest_id, two_src_id, src_1_id, src_2_id);
  
  ID_Stage_Reg id_stage_reg (clk, rst, wb_en_id, mem_r_en_id, mem_w_en_id, exe_cmd_id, b_id, s_id, pc_id,
    value_rn_id, value_rm_id, shift_operand_id, imm_id, imm_signed_24_id, dest_id, src_1_id, src_2_id, b_id_reg, ~ready, sr,
    wb_en_id_reg, mem_r_en_id_reg, mem_w_en_id_reg, exe_cmd_id_reg, b_id_reg, s_id_reg, pc_id_reg, value_rn_id_reg, value_rm_id_reg, shift_operand_id_reg, imm_id_reg, imm_signed_24_id_reg, dest_id_reg, sr_id_reg, src_1, src_2);
  
  EXE_Stage exe_stage (clk, rst, exe_cmd_id_reg, wb_en_id_reg, mem_r_en_id_reg, mem_w_en_id_reg,
    pc_id_reg, value_rn_id_reg, value_rm_id_reg, imm_id_reg, shift_operand_id_reg, imm_signed_24_id_reg,
    sr_id_reg, dest_id_reg, sel_src_1, sel_src_2, alu_result_exe_reg, wb_value, wb_en_exe, mem_r_en_exe, mem_w_en_exe, alu_result_exe, br_addr_exe, status_exe, val_rm_exe, dest_exe);
    
  StatusRegister status_register (clk, rst, s_id_reg, status_exe, sr);
   
  EXE_Stage_Reg exe_stage_reg (clk, rst, ~ready, wb_en_exe, mem_r_en_exe, mem_w_en_exe, alu_result_exe,
    dest_exe, val_rm_exe, wb_en_exe_reg, mem_r_en_exe_reg, mem_w_en_exe_reg, alu_result_exe_reg,
    dest_exe_reg, val_rm_exe_reg);

  MEM_Stage mem_stage (clk, rst, wb_en_exe_reg, mem_r_en_exe_reg, mem_w_en_exe_reg, alu_result_exe_reg,
    val_rm_exe_reg, dest_exe_reg, wb_en_mem, mem_r_en_mem, mem_w_en_mem, alu_result_mem, data_memory_mem, dest_mem,
    sram_dq, sram_we_n, sram_address, ready);
  
  ForwardingUnit forwarding_unit (clk, rst, src_1, src_2, wb_en_mem, dest_mem, wb_wb_en, wb_dest, sel_src_1, sel_src_2);

  MEM_Stage_Reg mem_stage_reg (clk, rst, ~ready, wb_en_mem, mem_r_en_mem, alu_result_mem, data_memory_mem, dest_mem,
    wb_en_mem_reg, mem_r_en_mem_reg, alu_result_mem_reg, data_memory_out_mem_reg, dest_mem_reg);

  //wire [31:0] mem_result;
  //assign mem_result = 32'b00000000000000000000000000000000;

  WB_Stage wb_stage (clk, rst, alu_result_mem_reg, data_memory_out_mem_reg, mem_r_en_mem_reg, dest_mem_reg, wb_en_mem_reg,
    wb_dest, wb_value, wb_wb_en);
endmodule
