module Instruction_Memory (
  input             clk,
  input             rst,
  input [31:0]      pc,
  output reg [31:0] instruction
  );

  reg [7:0] instructions[0:187];
  
  always @ (*) begin
    if (rst) begin
      {instructions[0],  instructions[1],  instructions[2],  instructions[3]}      = 32'b1110_00_1_1101_0_0000_0000_000000010100;
      {instructions[4],  instructions[5],  instructions[6],  instructions[7]}      = 32'b1110_00_1_1101_0_0000_0001_101000000001;
      {instructions[8],  instructions[9],  instructions[10], instructions[11]}     = 32'b1110_00_1_1101_0_0000_0010_000100000011;
      {instructions[12], instructions[13], instructions[14], instructions[15]}     = 32'b1110_00_0_0100_1_0010_0011_000000000010;
      {instructions[16], instructions[17], instructions[18], instructions[19]}     = 32'b1110_00_0_0101_0_0000_0100_000000000000;
      {instructions[20], instructions[21], instructions[22], instructions[23]}     = 32'b1110_00_0_0010_0_0100_0101_000100000100;
      {instructions[24], instructions[25], instructions[26], instructions[27]}     = 32'b1110_00_0_0110_0_0000_0110_000010100000;
      {instructions[28], instructions[29], instructions[30], instructions[31]}     = 32'b1110_00_0_1100_0_0101_0111_000101000010;
      {instructions[32], instructions[33], instructions[34], instructions[35]}     = 32'b1110_00_0_0000_0_0111_1000_000000000011;
      {instructions[36], instructions[37], instructions[38], instructions[39]}     = 32'b1110_00_0_1111_0_0000_1001_000000000110;
      
      {instructions[40], instructions[41], instructions[42], instructions[43]}     = 32'b1110_00_0_0001_0_0100_1010_000000000101;
      {instructions[44], instructions[45], instructions[46], instructions[47]}     = 32'b1110_00_0_1010_1_1000_0000_000000000110;
      {instructions[48], instructions[49], instructions[50], instructions[51]}     = 32'b0001_00_0_0100_0_0001_0001_000000000001;
      {instructions[52], instructions[53], instructions[54], instructions[55]}     = 32'b1110_00_0_1000_1_1001_0000_000000001000;
      {instructions[56], instructions[57], instructions[58], instructions[59]}     = 32'b0000_00_0_0100_0_0010_0010_000000000010;
      {instructions[60], instructions[61], instructions[62], instructions[63]}     = 32'b1110_00_1_1101_0_0000_0000_101100000001;
      {instructions[64], instructions[65], instructions[66], instructions[67]}     = 32'b1110_01_0_0100_0_0000_0001_000000000000;
      {instructions[68], instructions[69], instructions[70], instructions[71]}     = 32'b1110_01_0_0100_1_0000_1011_000000000000;
      {instructions[72], instructions[73], instructions[74], instructions[75]}     = 32'b1110_01_0_0100_0_0000_0010_000000000100;
      {instructions[76], instructions[77], instructions[78], instructions[79]}    	= 32'b1110_01_0_0100_0_0000_0011_000000001000;
      
      {instructions[80], instructions[81], instructions[82], instructions[83]}     = 32'b1110_01_0_0100_0_0000_0100_000000001101;
      {instructions[84], instructions[85], instructions[86], instructions[87]}     = 32'b1110_01_0_0100_0_0000_0101_000000010000;
      {instructions[88], instructions[89], instructions[90], instructions[91]}     = 32'b1110_01_0_0100_0_0000_0110_000000010100;
      {instructions[92], instructions[93], instructions[94], instructions[95]}     = 32'b1110_01_0_0100_1_0000_1010_000000000100;
      {instructions[96], instructions[97], instructions[98], instructions[99]}     = 32'b1110_01_0_0100_0_0000_0111_000000011000;
      {instructions[100], instructions[101], instructions[102], instructions[103]} = 32'b1110_00_1_1101_0_0000_0001_000000000100;
      {instructions[104], instructions[105], instructions[106], instructions[107]} = 32'b1110_00_1_1101_0_0000_0010_000000000000;
      {instructions[108], instructions[109], instructions[110], instructions[111]} = 32'b1110_00_1_1101_0_0000_0011_000000000000;
      {instructions[112], instructions[113], instructions[114], instructions[115]} = 32'b1110_00_0_0100_0_0000_0100_000100000011;
      {instructions[116], instructions[117], instructions[118], instructions[119]} = 32'b1110_01_0_0100_1_0100_0101_000000000000;
      
      {instructions[120], instructions[121], instructions[122], instructions[123]} = 32'b1110_01_0_0100_1_0100_0110_000000000100;
      {instructions[124], instructions[125], instructions[126], instructions[127]} = 32'b1110_00_0_1010_1_0101_0000_000000000110;
      {instructions[128], instructions[129], instructions[130], instructions[131]} = 32'b1100_01_0_0100_0_0100_0110_000000000000;
      {instructions[132], instructions[133], instructions[134], instructions[135]} = 32'b1100_01_0_0100_0_0100_0101_000000000100;
      {instructions[136], instructions[137], instructions[138], instructions[139]} = 32'b1110_00_1_0100_0_0011_0011_000000000001;
      {instructions[140], instructions[141], instructions[142], instructions[143]} = 32'b1110_00_1_1010_1_0011_0000_000000000011;
      {instructions[144], instructions[145], instructions[146], instructions[147]} = 32'b1011_10_1_0_111111111111111111110111;
      {instructions[148], instructions[149], instructions[150], instructions[151]} = 32'b1110_00_1_0100_0_0010_0010_000000000001;
      {instructions[152], instructions[153], instructions[154], instructions[155]} = 32'b1110_00_0_1010_1_0010_0000_000000000001;
      {instructions[156], instructions[157], instructions[158], instructions[159]} = 32'b1011_10_1_0_111111111111111111110011;
      
      {instructions[160], instructions[161], instructions[162], instructions[163]} = 32'b1110_01_0_0100_1_0000_0001_000000000000; 
      {instructions[164], instructions[165], instructions[166], instructions[167]} = 32'b1110_01_0_0100_1_0000_0010_000000000100;
      {instructions[168], instructions[169], instructions[170], instructions[171]} = 32'b1110_01_0_0100_1_0000_0011_000000001000;
      {instructions[172], instructions[173], instructions[174], instructions[175]} = 32'b1110_01_0_0100_1_0000_0100_000000001100;
      {instructions[176], instructions[177], instructions[178], instructions[179]} = 32'b1110_01_0_0100_1_0000_0101_000000010000;
      {instructions[180], instructions[181], instructions[182], instructions[183]} = 32'b1110_01_0_0100_1_0000_0110_000000010100;
      {instructions[184], instructions[185], instructions[186], instructions[187]} = 32'b1110_10_1_0_111111111111111111111111;
    end else begin
      instruction <= {instructions[pc+2'b00], instructions[pc+2'b01], instructions[pc+2'b10], instructions[pc+2'b11]};  
    end
  end

endmodule
