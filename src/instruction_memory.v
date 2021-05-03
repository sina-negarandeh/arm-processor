module Instruction_Memory (
  input             clk,
  input             rst,
  input [31:0]      pc,
  output reg [31:0] instruction
  );

  reg [7:0] instructions[0:71];
  
  always @ (*) begin
    if (rst) begin
      {instructions[0],  instructions[1],  instructions[2],  instructions[3]}  = 32'b1110_00_1_1101_0_0000_0000_000000010100;
      {instructions[4],  instructions[5],  instructions[6],  instructions[7]}  = 32'b1110_00_1_1101_0_0000_0001_101000000001;
      {instructions[8],  instructions[9],  instructions[10], instructions[11]} = 32'b1110_00_1_1101_0_0000_0010_000100000011;
      {instructions[12], instructions[13], instructions[14], instructions[15]} = 32'b1110_00_0_0100_1_0010_0011_000000000010;
      {instructions[16], instructions[17], instructions[18], instructions[19]} = 32'b1110_00_0_0101_0_0000_0100_000000000000;
      {instructions[20], instructions[21], instructions[22], instructions[23]} = 32'b1110_00_0_0010_0_0100_0101_000100000100;
      {instructions[24], instructions[25], instructions[26], instructions[27]} = 32'b1110_00_0_0110_0_0000_0110_000010100000;
      {instructions[28], instructions[29], instructions[30], instructions[31]} = 32'b1110_00_0_1100_0_0101_0111_000101000010;
      {instructions[32], instructions[33], instructions[34], instructions[35]} = 32'b1110_00_0_0000_0_0111_1000_000000000011;
      {instructions[36], instructions[37], instructions[38], instructions[39]} = 32'b1110_00_0_1111_0_0000_1001_000000000110;
      {instructions[40], instructions[41], instructions[42], instructions[43]} = 32'b1110_00_0_0001_0_0100_1010_000000000101;
      {instructions[44], instructions[45], instructions[46], instructions[47]} = 32'b1110_00_0_1010_1_1000_0000_000000000110;
      {instructions[48], instructions[49], instructions[50], instructions[51]} = 32'b0001_00_0_0100_0_0001_0001_000000000001;
      {instructions[52], instructions[53], instructions[54], instructions[55]} = 32'b1110_00_0_1000_1_1001_0000_000000001000;
      {instructions[56], instructions[57], instructions[58], instructions[59]} = 32'b0000_00_0_0100_0_0010_0010_000000000010;
      {instructions[60], instructions[61], instructions[62], instructions[63]} = 32'b1110_00_1_1101_0_0000_0000_101100000001;
      {instructions[64], instructions[65], instructions[66], instructions[67]} = 32'b1110_01_0_0100_0_0000_0001_000000000000;
      {instructions[68], instructions[69], instructions[70], instructions[71]} = 32'b1110_01_0_0100_1_0000_1011_000000000000;    end else begin
      instruction <= {instructions[pc+2'b00], instructions[pc+2'b01], instructions[pc+2'b10], instructions[pc+2'b11]};  
    end
  end

endmodule
