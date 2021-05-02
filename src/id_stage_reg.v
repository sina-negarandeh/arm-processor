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
  
  output reg        wb_en,
  output reg        mem_r_en,
  output reg        mem_w_en,
  output reg [3:0]  exe_cmd,
  output reg        b,
  output reg        s,
  output reg [31:0] pc,
  output reg [31:0] value_rn,
  output reg [31:0] value_rm,
  output reg [11:0] shift_operand,
  output reg        imm,
  output reg [23:0] imm_signed_24,
  output reg [3:0]  dest 
  );
  
  always @ (posedge clk, posedge rst) begin
    if (rst) begin
      wb_en <= 1'b0;
      mem_r_en <= 1'b0;
      mem_w_en <= 1'b0;
      exe_cmd <= 4'b0000;
      b <= 1'b0;
      s <= 1'b0;
      pc <= 32'b00000000000000000000000000000000;
      value_rn <= 32'b00000000000000000000000000000000;
      value_rm <= 32'b00000000000000000000000000000000;
      shift_operand <= 12'b000000000000;
      imm <= 1'b0;
      imm_signed_24 <= 24'b000000000000000000000000;
      dest <= 4'b0000;
    end else begin
      wb_en <= wb_en_in;
      mem_r_en <= mem_r_en_in;
      mem_w_en <= mem_w_en_in;
      exe_cmd <= exe_cmd_in;
      b <= b_in;
      s <= s_in;
      pc <= pc_in;
      value_rn <= value_rn_in;
      value_rm <= value_rm_in;
      shift_operand <= shift_operand_in;
      imm <= imm_in;
      imm_signed_24 <= imm_signed_24_in;
      dest <= dest_in;
    end
  end

endmodule
