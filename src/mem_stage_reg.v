module MEM_Stage_Reg (
  input             clk,
  input             rst,
  
  input             freeze,

  input             wb_en_in,
  input             mem_r_en_in,
  input [31:0]      alu_result_in,
  input [31:0]      data_memory_out_in,
  input [3:0]       dest_in,

  output reg        wb_en,
  output reg        mem_r_en,
  output reg [31:0] alu_result,
  output reg [31:0] data_memory_out,
  output reg [3:0]  dest
  );

  always @ (posedge clk, posedge rst) begin
    if (rst) begin
      wb_en <= 1'b0;
      mem_r_en <= 1'b0;
      alu_result <= 32'b00000000000000000000000000000000;
      data_memory_out <= 32'b00000000000000000000000000000000;
      dest <= 4'b0000;
    end else if (!freeze) begin
      wb_en <= wb_en_in;
      mem_r_en <= mem_r_en_in;
      alu_result <= alu_result_in;
      data_memory_out <= data_memory_out_in;
      dest <= dest_in;
    end
  end

endmodule
