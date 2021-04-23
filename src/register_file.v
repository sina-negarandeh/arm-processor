module RegisterFile (
  input         clk,
  input         rst,
  input [3:0]   src_1,
  input [3:0]   src_2,
  input [3:0]   dest_wb,
  input [31:0]  result_wb,
  input         write_back_en,
  output [31:0] reg_1,
  output [31:0] reg_2
  );
  
  reg [31:0] registers [0:14]; // Two-dimensional array
  integer i;

  assign reg_1 = registers[src_1];
  assign reg_2 = registers[src_2];
  
  always @ (posedge rst) begin
    if (rst) begin
      for (i = 0; i < 15; i=i+1) begin
        registers[i] <= i;
      end
    end
  end
  
  always @ (negedge clk) begin
    if (write_back_en) begin
      registers[dest_wb] <= result_wb;
    end
  end

endmodule
