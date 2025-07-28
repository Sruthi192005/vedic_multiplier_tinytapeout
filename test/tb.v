`timescale 1ns / 1ps

module tbb;

  // Declare testbench signals
  reg clk;
  reg rst_n;
 
  reg [3:0] a, b;
  wire [7:0] p;

  // Instantiate the DUT (Device Under Test)
  tt_um_vedic_4x4 dut (
    .clk(clk),
    .rst_n(rst_n),
   
    .a(a),
    .b(b),
    .p(p)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Test sequence
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tbb);
    $monitor("Time = %0t | a = %d | b = %d | Product = %d", 
              $time, a, b, p);

    // Initialize inputs
    clk = 0;
    rst_n = 0;
    ena = 1;
    a = 0;
    b = 0;

    #20;
    rst_n = 1;  // Release reset
    #10;

    a = 4'd5; b = 4'd3; #10;
    a = 4'd2; b = 4'd7; #10;
    a = 4'd4; b = 4'd9; #10;
    a = 4'd15; b = 4'd15; #10;
    a = 4'd9; b = 4'd0; #10;

    $finish;
  end

endmodule
