module ID_Stage_Reg (
  input             clk,
  input             rst,
  output [31:0]     pc_in,
  output reg [31:0] pc
  );

  always @ (posedge clk, posedge rst) begin
    if (rst) begin
      pc <= 32'b00000000000000000000000000000000;
    end else begin
      pc <= pc_in;
    end
  end

endmodule
