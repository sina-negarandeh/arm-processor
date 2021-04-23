module ConditionCheck (
  input [3:0]   cond,
  input [3:0]   sr,
  
  output reg    result
  );
  
  wire z; // zero
  wire c; // carry
  wire n; // negative
  wire v; // overflow
  
  assign {z, c, n, v} = sr;
  
  always @ (cond, sr) begin
    
    result = 1'b0;

    case (cond) // Opcode [31:28]
      4'b0000: begin  // Mnemonic extension: EQ  Meaning: Equal
        if (z == 1'b1) result = 1'b1;
      end
      4'b0001: begin  // Mnemonic extension: NE  Meaning: Not equal
        if (z == 1'b0) result = 1'b1;
      end
      4'b0010: begin  // Mnemonic extension: CS/HS  Meaning: Carry set/unsigned higher or same
        if (c == 1'b1) result = 1'b1;
      end
      4'b0011: begin  // Mnemonic extension: CC/LO  Meaning: Carry clear/unsigned lower
        if (c == 1'b0) result = 1'b1;
      end
      4'b0100: begin  // Mnemonic extension: MI  Meaning: Minus/negative
        if (n == 1'b1) result = 1'b1;
      end
      4'b0101: begin  // Mnemonic extension: PL  Meaning: Plus/positive or zero
        if (n == 1'b0) result = 1'b1;
      end
      4'b0110: begin  // Mnemonic extension: VS  Meaning: Overflow
        if (v == 1'b1) result = 1'b1;
      end
      4'b0111: begin  // Mnemonic extension: VC  Meaning: No overflow
        if (v == 1'b0) result = 1'b1;
      end
      4'b1000: begin  // Mnemonic extension: HI  Meaning: Unsigned higher
        if ((c == 1'b1) && (z == 1'b0)) result = 1'b1;
      end
      4'b1001: begin  // Mnemonic extension: LS  Meaning: Unsigned lower or same
        if ((c == 1'b0) && (z == 1'b1)) result = 1'b1;
      end
      4'b1010: begin  // Mnemonic extension: GE  Meaning: Signed greater than or equal
        if (n == v) result = 1'b1;
      end
      4'b1011: begin  // Mnemonic extension: LT  Meaning: Signed less than
        if (n != v) result = 1'b1;
      end
      4'b1100: begin  // Mnemonic extension: GT  Meaning: Signed greater than
        if ((z == 1'b0) && (n == v)) result = 1'b1;
      end
      4'b1101: begin  // Mnemonic extension: LE  Meaning: Signed less than or equal
        if ((z == 1'b1) && (n != v)) result = 1'b1;
      end
      4'b1110: begin  // Mnemonic extension: AL  Meaning: Always (unconditional)
        result = 1'b1;
      end
      4'b1111: begin
        /*
        If the condition field is 0b1111, the behavior depends on the architecture version:
          * In ARMv4, any instruction with a condition field of 0b1111 is UNPREDICTABLE.
          * In ARMv5 and above, a condition field of 0b1111 is used to encode various additional instructions
            which can only be executed unconditionally (see Unconditional instruction extension space on
            page A3-41). All instruction encoding diagrams which show bits[31:28] as cond only match
            instructions in which these bits are not equal to 0b1111.
        */      
      end
      default: result = 1'b0;
    endcase

  end
  
endmodule

