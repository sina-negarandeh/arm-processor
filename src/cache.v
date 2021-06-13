module Cache (
  input             clk,
  input             rst,
  
  input             mem_r_en,
  input             mem_w_en,
  input             mem_u_en,
  input             cash_invalid,
  input [31:0]      address,
  
  // sram
  input [63:0]      sram_read_data,
  input             sram_ready,
  
  output [31:0]     data,
  output            hit
  );
  
  /*
  Cache
  ---------------------------------------------------------------
  |           set 0           |           set 1           | lru |
  ---------------------------------------------------------------
  | data | data | tag | valid | data | data | tag | valid | lru |
  ---------------------------------------------------------------
  |  32  |  32  | 10  |   1   |  32  |  32  | 10  |   1   |  1  |
  ---------------------------------------------------------------
  |                            151                              |
  ---------------------------------------------------------------
  */
  
  /*
  Address
  -----------------------
  | tag | index | offset|
  -----------------------
  | 10  |   6   |   3   |
  -----------------------
  |         19          |
  -----------------------
  */
  
  reg [31:0] fst_data_set_0[0:63];
  reg [31:0] sec_data_set_0[0:63];
  reg [9:0] tag_set_0[0:63];
  reg valid_set_0[0:63];
  
  reg [31:0] fst_data_set_1[0:63];
  reg [31:0] sec_data_set_1[0:63];
  reg [9:0] tag_set_1[0:63];
  reg valid_set_1[0:63];
  
  reg lru[0:63];
  
  integer i;
  
  // valid bit should be initialized with 0
  
  initial begin
    for (i = 0; i < 64; i = i + 1) begin
        valid_set_0[i] <= 1'b0;
        valid_set_1[i] <= 1'b0;
        lru[i] <= 1'b0;
    end
  end
  
  wire [31:0] data_address;
  wire [18:0] cache_address;
  assign data_address = address - 1024;
  assign cache_address = data_address[18:0];
  
  wire [9:0] tag;
  wire [5:0] index;
  wire [2:0] offset;
  
  assign tag = cache_address[18:9];
  assign index = cache_address[8:3];
  assign offset = cache_address[2:0];
  
  reg select_set_0;
  reg select_set_1;
  
  always @ (*) begin
    if (tag_set_0[index] == tag) begin
      if (valid_set_0[index] == 1'b1) select_set_0 = 1'b1;
      else  select_set_0 = 1'b0;
    end else if (tag_set_1[index] == tag) begin
      if (valid_set_1[index] == 1'b1) select_set_1 = 1'b1;
      else  select_set_1 = 1'b0;
    end else begin
       select_set_0 = 1'b0;
       select_set_1 = 1'b0;
    end
    
  end
  
  wire [31:0] data_set_0;
  wire [31:0] data_set_1;
  
  assign data_set_0 = offset[2] ? sec_data_set_0[index] : fst_data_set_0[index];
  assign data_set_1 = offset[2] ? sec_data_set_1[index] : fst_data_set_1[index];
  
  assign data = select_set_0 ? data_set_0 : (select_set_1 ? data_set_1 : 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  
  assign hit = (select_set_0 | select_set_1);
  
  // if hit = 0 then we should go to sram -> sram_r_en = 1 -> after 6 clk give result -> write it in cache and next stage
  
    // Read
  always @ (posedge clk) begin
    if (mem_u_en) begin
      if (lru[index]) begin
        fst_data_set_0[index] <= sram_read_data[63:32];
        sec_data_set_0[index] <= sram_read_data[31:0];
        tag_set_0[index] <= tag;
        valid_set_0[index] <= 1'b1;
      end else begin
       	fst_data_set_1[index] <= sram_read_data[63:32];
        sec_data_set_1[index] <= sram_read_data[31:0];
        tag_set_1[index] <= tag;
        valid_set_1[index] <= 1'b1;
      end
      lru[index] <= select_set_0;
    end
  end
  
  // Write
  always @ (posedge clk) begin
    if (cash_invalid) begin
      if (select_set_0) valid_set_0[index] <= 1'b0;
      else valid_set_1[index] <= 1'b0;
    end
  end

endmodule
