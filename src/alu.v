module ALU (
  input             clk,
  input             rst,
  
  input [31:0]      val_1,
  input [31:0]      val_2,
  input [3:0]       exe_cmd,
  input [3:0]       sr_in,
  
  output reg [31:0] alu_result,
  output reg [3:0]  sr
  );
  
  wire z_in; // zero
  wire c_in; // carry
  wire n_in; // negative
  wire v_in; // overflow
  
  assign {z_in, c_in, n_in, v_in} = sr_in;
  
  reg z; // zero
  reg c; // carry
  reg n; // negative
  reg v; // overflow
  
  always @ (val_1, val_2, exe_cmd, z_in, c_in, n_in, v_in) begin
    
    alu_result = 32'b00000000000000000000000000000000;
    sr = 4'b0000;
    
    z = 1'b0;
    c = 1'b0;
    n = 1'b0;
    v = 1'b0;
    
    case (exe_cmd) // ALU Command
      4'b0001: begin  // Instruction: MOV Operation:  result = in2
        alu_result = val_2;
      end
      4'b1001: begin  // Instruction: MVN Operation:  result = ~in2
        alu_result = ~val_2;
      end
      // Instruction: ADD Operation:  result = in1 + in2
      // Instruction: LDR Operation:  result = in1 + in2
      // Instruction: STR Operation:  result = in1 + in2
      4'b0010: begin
        {c, alu_result} = val_1 + val_2;
        if ((val_1[31] == val_2[31]) && (val_1[31] == (~alu_result[31]))) v = 1'b1;
      end
      4'b0011: begin  // Instruction: ADC Operation:  result = result = in1 + in2 + C
        {c, alu_result} = val_1 + val_2 + c_in;
        if ((val_1[31] == val_2[31]) && (val_1[31] == (~alu_result[31]))) v = 1'b1;
      end
      // Instruction: SUB Operation:  result = in1 - in2
      // Instruction: CMP Operation:  result = in1 - in2
      4'b0100: begin
        {c, alu_result} = val_1 - val_2;
        if ((val_1[31] == (~val_2[31])) && (val_1[31] == (~alu_result[31]))) v = 1'b1;
      end
      4'b0101: begin  // Instruction: SBC Operation:  result = in1 - in2 - ~C
        {c, alu_result} = val_1 - val_2 - {{31'b0000000000000000000000000000000}, ~(c_in)};
        if ((val_1[31] == (~val_2[31])) && (val_1[31] == (~alu_result[31]))) v = 1'b1;
      end
      // Instruction: AND Operation:  result = in1 & in2
      // Instruction: TST Operation:  result = in1 & in2
      4'b0110: begin
        alu_result = val_1 & val_2;
      end
      4'b0111: begin  // Instruction: ORR Operation:  result = in1 | in2
        alu_result = val_1 | val_2;
      end
      4'b1000: begin  // Instruction: EOR Operation:  result = in1 ^ in2
        alu_result = val_1 ^ val_2;
      end
      /*
      4'b0100: begin  // Instruction: CMP Operation:  result = in1 - in2
        alu_result = val_1 - val_2;
      end
      4'b0110: begin  // Instruction: TST Operation:  result = in1 & in2
        alu_result = val_1 & val_2;
      end
      4'b0010: begin  // Instruction: LDR Operation:  result = in1 + in2
        alu_result = val_1 + val_2;
      end
      4'b0010: begin  // Instruction: STR Operation:  result = in1 + in2
        alu_result = val_1 + val_2;
      end
      */
      4'bxxxx: begin  // Instruction: B   Operation:
        //
      end
      default: begin
        //
      end
    endcase

    n = alu_result[31];    
    z = alu_result == 32'b00000000000000000000000000000000 ? 1'b1 : 1'b0;
    
    sr = {z, c, n, v};
  end
  
endmodule
