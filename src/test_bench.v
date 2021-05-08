module Test_Bench ();
 
  integer i;
  reg clk, rst;
 
  ARM arm (clk, rst);

  initial begin
    rst = 1'b0;
    #35 rst = 1'b1;
    #35 rst = 1'b0;
    for (i = 0; i < 40; i=i+1) begin
      #100 clk = 1'b0;
      #100 clk = 1'b1;
    end
  end

endmodule
