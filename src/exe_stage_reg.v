module EXE_Stage_Reg (
  input             clk,
  input             rst,
  
  input             wb_en_in,
  input             mem_r_en_in,
  input             mem_w_en_in,
  input [31:0]      alu_result_in,
  //input [31:0]      st_val_in,
  input [3:0]       dest_in,
  input [31:0]      val_rm_in,
  
  output reg             wb_en,
  output reg             mem_r_en,
  output reg             mem_w_en,
  output reg [31:0]      alu_result,
  //output reg [31:0]      st_val,
  output reg [3:0]       dest,
  output reg [31:0]      val_rm
  );

  always @ (posedge clk, posedge rst) begin
    if (rst) begin      
      wb_en <= 1'b0;
      mem_r_en <= 1'b0;
      mem_w_en <= 1'b0;
      alu_result <= 32'b00000000000000000000000000000000;
      //st_val <= 32'b00000000000000000000000000000000;
      dest <= 4'b0000;
      val_rm <= 32'b00000000000000000000000000000000;
    end else begin
      wb_en <= wb_en_in;
      mem_r_en <= mem_r_en_in;
      mem_w_en <= mem_w_en_in;
      alu_result <= alu_result_in;
      //st_val <= st_val_in;
      dest <= dest_in;
      val_rm <= val_rm_in;
    end
  end

endmodule
