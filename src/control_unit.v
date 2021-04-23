module ControlUnit (
  input [1:0]   mode,
  input [3:0]   op_code,
  input         s_in,
  
  output [3:0]  exe_cmd,
  output        mem_r_en, // mem_read
  output        mem_w_en  // mem_w_en
  output        wb_en,
  output        s,
  output        b
  );

endmodule
