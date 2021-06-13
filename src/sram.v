module SRAM (
  input             clk,
  input             rst,
  
  input             sram_we_n,
  input [16:0]      sram_address,
  inout [63:0]      sram_dq
  );
  
  reg [31:0] memory[0:511]; //  65535
  
  wire [31:0] first;
  wire [31:0] second;
  
  assign first = memory[{{sram_address[16:1]}, {1'b0}}];
  assign second = memory[{{sram_address[16:1]}, {1'b1}}];
  
  assign #30 sram_dq = sram_we_n ? {{first}, {second}} : 64'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;
  
  always @ (posedge clk) begin
    if (~sram_we_n) memory[sram_address] = sram_dq[31:0];
  end

endmodule
