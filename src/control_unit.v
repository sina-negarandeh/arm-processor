module ControlUnit (
  input [1:0]      mode,
  input [3:0]      op_code,
  input            s_in,
  
  output reg [3:0] exe_cmd,
  output reg       mem_r_en,  // mem_read
  output reg       mem_w_en,  // mem_w_en
  output reg       wb_en,
  output reg       s,
  output reg       b
  );
  
  
  always @ (mode, op_code, s_in) begin
    
    exe_cmd = 4'b0000;
    mem_r_en = 1'b0;
    mem_w_en = 1'b0;
    wb_en = 1'b0;
    s = 1'b0;
    b = 1'b0;
    
    case (mode)
      2'b00: begin  // logical or arithmetic
        case (op_code)
          4'b1101: begin  // R-type Instruction: MOV Description: Move
            exe_cmd = 4'b0001;
            wb_en = 1'b1;
            s = s_in;
          end
          4'b1111: begin  // R-type Instruction: MVN Description: Move NOT
            exe_cmd = 4'b1001;
            wb_en = 1'b1;
            s = s_in;
          end
          4'b0100: begin  // R-type Instruction: ADD Description: Add
            exe_cmd = 4'b0010;
            wb_en = 1'b1;
            s = s_in;
          end
          4'b0101: begin  // R-type Instruction: ADC Description: Add with Carry
            exe_cmd = 4'b0011;
            wb_en = 1'b1;
            s = s_in;
          end
          4'b0010: begin  // R-type Instruction: SUB Description: Subtraction
            exe_cmd = 4'b0100;
            wb_en = 1'b1;
            s = s_in;
          end
          4'b0110: begin  // R-type Instruction: SBC Description: Subtract with Carry
            exe_cmd = 4'b0101;
            wb_en = 1'b1;
            s = s_in;
          end
          4'b0000: begin  // R-type Instruction: AND Description: And
            exe_cmd = 4'b0110;
            wb_en = 1'b1;
            s = s_in;
          end
          4'b1100: begin  // R-type Instruction: ORR Description: Or
            exe_cmd = 4'b0111;
            wb_en = 1'b1;
            s = s_in;
          end
          4'b0001: begin  // R-type Instruction: EOR Description: Exclusive OR
            exe_cmd = 4'b1000;
            wb_en = 1'b1;
            s = s_in;
          end
          4'b1010: begin  // R-type Instruction: CMP Description: Compare
            exe_cmd = 4'b0100;
            s = s_in;
          end
          4'b1000: begin  // R-type Instruction: TST Description: Test
            exe_cmd = 4'b0110;
            s = s_in;
          end
          default: begin
            //
          end
        endcase
      end
      2'b01: begin  // memory access
        case (s)
          1'b1: begin // R-type Instruction: LDR Description: Load Register
            exe_cmd = 4'b0010;
            wb_en = 1'b1;
            mem_r_en = 1'b1;
          end
          1'b0: begin // R-type Instruction: STR Description: Store Register
            exe_cmd = 4'b0010;
            mem_w_en = 1'b1;
          end
          default: begin
            //
          end
        endcase
      end
      2'b10: begin  // branch
        exe_cmd = 4'bxxxx;
        s = s_in;
        b = 1'b1;
      end
      default: begin
        //
      end
    endcase
  end

endmodule
