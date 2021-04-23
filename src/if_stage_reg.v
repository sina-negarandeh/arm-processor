module IF_Stage_Reg (
  input             clk,
  input             rst,
  
  // From Instruction Fetch Stage
  input [31:0]      pc_in,
  input [31:0]      instruction_in,
  
  // From Executaion Stage
  input             flush,
  
  // From Hazard Detection Unit
  input             freeze,
  
  output reg [31:0] pc,
  output reg [31:0] instruction
  );
  
  always @ (posedge clk, posedge rst) begin
    if (rst) begin
      pc <= 32'b00000000000000000000000000000000;
      instruction <= 32'b00000000000000000000000000000000;
    end else begin
      pc <= pc_in;
      instruction <= instruction_in;
    end
  end

endmodule
