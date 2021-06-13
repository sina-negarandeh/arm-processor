module SRAM_Controller (
  input             clk,
  input             rst,
  
  input             read_en,
  input             write_en,
  input [31:0]      address,
  input [31:0]      write_data,
  
  inout [63:0]      sram_dq,
  output            sram_w_en, // SRAM Write Enable
  output [63:0]     read_data,   
  output [16:0]     sram_address,
  output            ready
  );
  
  reg [1:0] ns;
  reg [1:0] ps;
  reg [2:0] counter;

  always @ (posedge clk, posedge rst) begin
    if (rst) counter <= 3'b000;
    else begin
      if (((ps == 2'b01) || (ps == 2'b10)) && (counter < 3'b100)) counter <= counter + 3'b001;
      else counter <= 3'b000;
    end
  end

  always @ (posedge clk, posedge rst) begin    // Sequential
    if (rst) ps <= 2'b00;
    else ps <= ns;
  end
  
  always @ (ps, read_en, write_en, counter) begin // Produce next state
    case (ps)
        2'b00: ns = read_en ? 2'b01 : (write_en ? 2'b10 : 2'b00);
        2'b01: ns = (counter < 3'b100) ? 2'b01 : 2'b00;
        2'b10: ns = (counter < 3'b100) ? 2'b10 : 2'b00;
    endcase
  end
  
  assign ready = ((ns == 2'b01) && (counter < 3'b100)) ? 1'b0 :
                 ((ns == 2'b10) && (counter < 3'b100)) ? 1'b0 :
                 1'b1;
  
  wire [31:0] data_address;
  assign data_address = address - 1024;
  assign sram_address = data_address[18:2];
  
  // LDR
  assign read_data = sram_dq;
  
  // STR
  assign sram_w_en = ((ns == 2'b10) && (counter < 3'b100)) ? 1'b0 : 1'b1;
  assign sram_dq = ((ns == 2'b10) && (counter < 3'b100)) ? write_data : 64'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;

endmodule
