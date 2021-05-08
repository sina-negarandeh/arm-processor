module DataMemory (
  input             clk,
  input             rst,
  
  input             mem_r_en,
  input             mem_w_en,
  input [31:0]      address,  //  alu_result
  input [31:0]      data,     // val_rm
  
  output reg [31:0] data_memory_out
  );
  
  reg [7:0] memory[0:255];
  
  wire [31:0] aligned_address;
  assign aligned_address = ((address - 1024) >> 2);
  //32'b00000000000000000000010000000000
  
  /*
  assign data_memory_out[7:0]   = memory[{{aligned_address}, {2'b11}}];
  assign data_memory_out[15:8]  = memory[{{aligned_address}, {2'b10}}];
  assign data_memory_out[23:16] = memory[{{aligned_address}, {2'b01}}];
  assign data_memory_out[31:24] = memory[{{aligned_address}, {2'b00}}];
  */
  always @ (*) begin
    if (mem_r_en) begin
      data_memory_out = {memory[{{aligned_address}, {2'b00}}], memory[{{aligned_address}, {2'b01}}], memory[{{aligned_address}, {2'b10}}], memory[{{aligned_address}, {2'b11}}]};
    end
  end
  
  always @ (posedge clk, posedge rst) begin
    if (mem_w_en) begin
      memory[aligned_address]     <= data[31:24];
      memory[aligned_address + 1] <= data[23:16];
      memory[aligned_address + 2] <= data[15:8];
      memory[aligned_address + 3] <= data[7:0];
    end
  end

endmodule
