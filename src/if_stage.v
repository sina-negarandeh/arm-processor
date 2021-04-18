module IF_Stage (
  input         clk,
  input         rst,
  
  // Executaion Stage
  input         branch_tacken,
  input [31:0]  branch_address,
  
  // Hazard Detection Unit
  input         freeze,
  
  output [31:0] pc,
  output [31:0] instruction
  );

endmodule
