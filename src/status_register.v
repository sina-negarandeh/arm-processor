module StatusRegister (
  input            clk,
  input            rst,
  
  // From Execution Stage
  input            s,
  input [3:0]      status_bits,
  
  output reg [3:0] sr
  );
  
  always @ (negedge clk, posedge rst) begin
    if (rst) begin
      sr <= 4'b0000;
    end else if (s) begin
      sr <= status_bits;
    end
  end

endmodule
