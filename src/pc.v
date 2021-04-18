module PC (
  input             clk,
  input             rst,
  
  input [31:0]      pc_in,
  
  // Hazard Detection Unit
  input             freeze,
  
  output reg [31:0] pc_out
  );
  
  always @ (posedge clk, posedge rst) begin
    if (rst) pc_out <= 32'b0;
    else begin
      if (freeze) pc_out <= pc_out;
      else pc_out <= pc_in;
    end
  end

endmodule
