module MEM_Stage (
  input         clk,
  input         rst,

  // From Execution Stage
  input         wb_en_in,
  input         mem_r_en_in,
  input         mem_w_en_in,
  input [31:0]  alu_result,
  input [31:0]  rm_val,
  input [3:0]   dest_in,

  // To Memory Stage Reg
  output        wb_en,
  output        mem_r_en,
  output        mem_w_en,
  output [31:0] alu_result_out,
  output [31:0] data_memory_out,
  output [3:0]  dest,
  
  // To SRAM
  inout [63:0]  sram_dq,
  output        sram_w_en,   
  output [16:0] sram_address,
  
  // To ARM
  output        ready
  );

  assign wb_en = wb_en_in;
  assign mem_r_en = mem_r_en_in;
  assign mem_w_en = mem_w_en_in;
  assign alu_result_out = alu_result;  
  
  wire hit;
  wire sram_ready;
  wire [31:0] cache_out;
  wire [63:0] sram_out;
  
  wire sram_signal;
  wire sram_mem_r_en;
  assign sram_mem_r_en = mem_r_en_in & sram_signal;
  assign sram_mem_w_en = mem_w_en_in & sram_signal;
  
  Cache_Controller cache_controller (clk, rst, mem_r_en_in, mem_w_en_in, rm_val, alu_result, cache_out, ready, hit, sram_dq, sram_w_en, sram_address, sram_ready, sram_signal);
  
  SRAM_Controller sram_controller (clk, rst, sram_mem_r_en, sram_mem_w_en, alu_result, rm_val, sram_dq, sram_w_en, sram_out, sram_address, sram_ready);
  
  assign data_memory_out = hit ? cache_out : (alu_result[2] ? sram_out[31:0] : sram_out[63:32]);
  
  // assign data_memory_out = alu_result[2] ? sram_out[31:0] : sram_out[63:32];

  assign dest = dest_in;

endmodule
