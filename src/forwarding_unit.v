module ForwardingUnit (
  input            clk,
  input            rst,
  
  // From Executaion Stage
  input [3:0]      src_1,
  input [3:0]      src_2,
  
  // From Memory Stage
  input            mem_wb_en,
  input [3:0]      mem_dest,
  
  // From Write Back Stage
  input            wb_wb_en,
  input [3:0]      wb_dest,
  
  output reg [1:0] sel_src_1,
  output reg [1:0] sel_src_2
  );

  always @ (src_1, src_2, mem_dest, mem_wb_en, wb_dest, wb_wb_en) begin
    if ((src_1 == mem_dest) && (mem_wb_en)) sel_src_1 = 2'b01;
    else if ((src_1 == wb_dest) && (wb_wb_en)) sel_src_1 = 2'b10;
    else sel_src_1 = 2'b00;
      
    if ((src_2 == mem_dest) && (mem_wb_en)) sel_src_2 = 2'b01;
    else if ((src_2 == wb_dest) && (wb_wb_en)) sel_src_2 = 2'b10;
    else sel_src_2 = 2'b00;
  end
  
endmodule
