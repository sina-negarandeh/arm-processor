module Cache_Controller (
  input             clk,
  input             rst,
  
  // Memory Stage
  input             mem_r_en,
  input             mem_w_en,
  input [31:0]      write_data,
  input [31:0]      address,  
  
  output [31:0]     read_data,
  output            ready,
  output            hit,
  
  // SRAM Controller
  inout [63:0]  sram_dq,
  input         sram_w_en,   
  input [16:0]  sram_address,
  input         sram_ready,
  output reg sram_signal
  );
  
  wire [31:0] cache_read_data;
  //wire hit;
  
  wire [63:0] sram_read_data;
  //wire sram_ready;
  reg sram_read_en;
  reg sram_write_en;
  reg cache_read_en;
  reg cache_write_en;
  reg cache_update_en;
  reg cash_invalid;
  
  assign sram_read_data = sram_dq;
  
  Cache cache (clk, rst, cache_read_en, cache_write_en, cache_update_en, cash_invalid, address, sram_read_data, sram_ready, read_data, hit);
  
  reg [2:0] ns;
  reg [2:0] ps;

  always @ (posedge clk, posedge rst) begin    // Sequential
    if (rst) ps <= 3'b000;
    else ps <= ns;
  end
  
  reg [2:0] count;
  always @ (posedge clk, posedge rst) begin
    if (rst) count <= 3'b000;
    else if ((ps == 3'b100) || (ps == 3'b010)) count <= count + 1'b1;
    else count <= 3'b000;
  end
  
  always @ (*) begin // Produce next state
    case (ps)
        3'b000: ns = mem_r_en ? 3'b001 : (mem_w_en ? 3'b011 : 3'b000);  // idle
        3'b001: ns = hit ? 3'b000 : 3'b010;  // read from cache
        3'b010: ns = (count == 3'b100) ? 3'b000 : 3'b010; // read from sram
        3'b011: ns = 3'b100;
        3'b100: ns = (count == 3'b100) ? 3'b000 : 3'b100;
    endcase
  end
    
  always @ (*) begin
    cache_read_en = 1'b0;
    cache_write_en = 1'b0;
    cash_invalid = 1'b0;
    sram_signal = 1'b0;
    case (ps)
      3'b000: begin
        //
      end
      3'b001: begin
        cache_read_en = 1'b1;
      end
      3'b010: begin
        sram_signal = 1'b1;
        cache_update_en = (count == 3'b011) ? 1'b1 : 1'b0;
      end
      3'b011: begin
        cash_invalid = 1'b1;
      end
      3'b100: begin
        sram_signal = 1'b1;
      end
    endcase
  end
                  
  assign ready = (ns == 3'b000 && sram_ready) ? 1'b1 : 
                 (ns != 3'b000) ? 1'b0 : 1'b1;
endmodule

