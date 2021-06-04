module Test_Bench ();
 
  integer i;
  reg clk, rst;
  
  integer j;
  reg mem_clk, mem_rst;
  
  wire sram_we_n;
  wire [16:0] sram_address;
  wire [31:0] sram_dq;
 
  ARM arm (clk, rst, sram_dq, sram_we_n, sram_address);
  
  SRAM sram (mem_clk, mem_rst, sram_we_n, sram_address, sram_dq);

  initial begin
    rst = 1'b0;
    #35 rst = 1'b1;
    #35 rst = 1'b0;
    for (i = 0; i < 550; i=i+1) begin
      #10 clk = 1'b0;
      #10 clk = 1'b1;
    end
  end
  
  initial begin
    rst = 1'b0;
    #35 mem_rst = 1'b1;
    #35 mem_rst = 1'b0;
    for (j = 0; j < 550; j=j+1) begin
      #20 mem_clk = 1'b0;
      #20 mem_clk = 1'b1;
    end
  end

endmodule
