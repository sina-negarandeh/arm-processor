module Instruction_Memory (
  input             clk,
  input             rst,
  input [31:0]      pc,
  output reg [31:0] instruction
  );

  reg [7:0] instructions[0:27];
  
  always @ (*) begin
    if (rst) begin
      {instructions[0],  instructions[1],  instructions[2],  instructions[3]} =  32'b000000_00001_00010_00000_00000000000;
      {instructions[4],  instructions[5],  instructions[6],  instructions[7]} =  32'b000000_00011_00100_00000_00000000000;
      {instructions[8],  instructions[9],  instructions[10], instructions[11]} = 32'b000000_00101_00110_00000_00000000000;
      {instructions[12], instructions[13], instructions[14], instructions[15]} = 32'b000000_00111_01000_00010_00000000000;
      {instructions[16], instructions[17], instructions[18], instructions[19]} = 32'b000000_01001_01010_00011_00000000000;
      {instructions[20], instructions[21], instructions[22], instructions[23]} = 32'b000000_01011_01100_00000_00000000000;
      {instructions[24], instructions[25], instructions[26], instructions[27]} = 32'b000000_01101_01110_00000_00000000000;
    end else begin
      instruction <= {instructions[pc+2'b00], instructions[pc+2'b01], instructions[pc+2'b10], instructions[pc+2'b11]};  
    end
  end

endmodule
