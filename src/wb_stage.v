module WB_Stage (
  input         clk,
  input         rst,

  input [31:0]  alu_result,
  input [31:0]  mem_result,
  input         mem_r_en,
  input [3:0]   wb_dest_in,
  input         wb_wb_en_in,
  
  
  output [3:0]  wb_dest,
  output [31:0] wb_value,
  output        wb_wb_en
  );

  assign wb_dest = wb_dest_in;
  assign wb_value = mem_r_en ? mem_result : alu_result;
  assign wb_wb_en = wb_wb_en_in;

endmodule
