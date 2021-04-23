module IF_Stage (
  input         clk,
  input         rst,
  
  // From Executaion Stage
  input         branch_tacken,
  input [31:0]  branch_address,
  
  // From Hazard Detection Unit
  input         freeze,
  
  output [31:0] pc,
  output [31:0] instruction
  );
  
  wire [31:0] mux;
  wire [31:0] pc_out;
  
  assign mux = branch_tacken ? branch_address : pc;
  
  PC pc_reg (clk, rst, mux, freeze, pc_out);
  
  assign pc = pc_out + 4;
  
  Instruction_Memory instruction_memory (clk, rst, pc_out, instruction);

endmodule
