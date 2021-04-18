module IF_Stage_Reg (
  input             clk,
  input             rst,
  
  // Instruction Fetch Stage
  input [31:0]      pc_in,
  input [31:0]      instruction_in,
  
  // Executaion Stage
  input             flush,
  
  // Hazard Detection Unit
  input             freeze,
  
  output reg [31:0] pc,
  output reg [31:0] instruction
  );

endmodule
