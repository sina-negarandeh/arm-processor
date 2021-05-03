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
  output [31:0] pc,
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
  
  wire [3:0] rn;
  wire [3:0] rm;
  wire [3:0] rd;
  
  assign rn = instruction[19:16];
  assign rm = instruction[3:0];
  assign rd = instruction[15:12];
  
  wire [3:0] register_file_src_2;
  assign register_file_src_2 = mem_w_en ? rd : rm;
  RegisterFile register_file(clk, rst, rn, register_file_src_2, wb_dest, wb_value, wb_wb_en, value_rn, value_rm);

  wire [3:0] cond;
  wire condition_check_result;
  
  assign cond = instruction[31:28];
  
  ConditionCheck condition_check(cond, sr, condition_check_result);
  
  wire or_output;
  wire [3:0] exe_cmd_ouput;
  wire mem_r_en_output;
  wire mem_w_en_output;
  wire wb_en_output;
  wire s_output;
  wire b_output;
  
  assign or_output = (hazard || (~condition_check_result));
  assign {exe_cmd, mem_r_en, mem_w_en, wb_en, s, b} = or_output ? 9'b000000000 : {exe_cmd_ouput, mem_r_en_output, mem_w_en_output, wb_en_output, s_output, b_output};
  
  wire [1:0] mode;
  wire [3:0] op_code;
  wire s_in;
  
  assign mode = instruction[27:26];
  assign op_code = instruction[24:21];
  assign s_in = instruction[20];
  
  ControlUnit control_unit(mode, op_code, s_in, exe_cmd_ouput, mem_r_en_output, mem_w_en_output, wb_en_output, s_output, b_output);

  assign pc = pc_in;
  assign shift_operand = instruction[11:0];
  assign imm = instruction[25];
  assign imm_signed_24 = instruction[23:0];
  assign dest = instruction[15:12];

  assign two_src = ((~instruction[25]) || mem_w_en);

  assign src_1 = rn;
  assign src_2 = register_file_src_2;

endmodule
