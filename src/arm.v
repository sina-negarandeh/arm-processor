module ARM (
  input clk,
  input rst
  );

  wire branch_tacken;
  wire [31:0] branch_address;
  wire freeze;
  wire [31:0] pc;
  wire [31:0] instruction;
  
  wire flush;
  wire [31:0] pc_if_reg;
  wire [31:0] instruction_if_reg;
  
  wire [31:0] pc_id;
  wire [31:0] pc_id_reg; 
  wire [31:0] pc_exe;
  wire [31:0] pc_exe_reg;
  wire [31:0] pc_mem;
  wire [31:0] pc_mem_reg;
  wire [31:0] pc_wb;
  
  assign branch_tacken = 1'b0;
  assign branch_address = 32'b00000000000000000000000000000000;
  assign freeze = 1'b0;
  
  IF_Stage if_stage (clk, rst, branch_tacken, branch_address, freeze, pc, instruction);
  IF_Stage_Reg if_stage_reg (clk, rst, pc, instruction, flush, freeze, pc_if_reg, instruction_if_reg);
  ID_Stage id_stage (clk, rst, pc_if_reg, pc_id);
  ID_Stage_Reg id_stage_reg (clk, rst, pc_id, pc_id_reg);
  EXE_Stage exe_stage (clk, rst, pc_id_reg, pc_exe);  
  EXE_Stage_Reg exe_stage_reg (clk, rst, pc_exe, pc_exe_reg);
  MEM_Stage mem_stage (clk, rst, pc_exe_reg, pc_mem);
  MEM_Stage_Reg mem_stage_reg (clk, rst, pc_mem, pc_mem_reg);
  WB_Stage wb_stage (clk, rst, pc_mem_reg, pc_wb);

endmodule
