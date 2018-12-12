`timescale 1ns/1ps
module multiplexer_tb;

  // Make reset high
  reg reset = 1;
  initial begin
     $dumpfile("multiplexer_tb.vcd");
     $dumpvars;
     #1680000 $finish;
  end


  //Make our pixel clock
  reg pixel_clk = 0;
  always #19.85 pixel_clk = !pixel_clk;


  multiplexer DUT ( 
        .PIXEL_CLK(pixel_clk),       // Pixel clock: 25Mhz (or 25.125MHz) for VGA
        .row0(5'b11111),
        .row1(5'b00000),
        .row2(5'b10001),
        .row3(5'b00100),
        .row4(5'b00000)
        );
endmodule // test