`timescale 1ns / 1ps

module tbb;

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end

  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

  tt_um_vedic_4x4 dut (
    .clk(clk),
    .rst_n(rst_n),
    .ena(ena),
    .ui_in(ui_in),
    .uio_in(uio_in),
    .uo_out(uo_out),
    .uio_out(uio_out),
    .uio_oe(uio_oe)
  );

  always #5 clk = ~clk;

  initial begin
    $monitor("Time = %0t | a = %d | b = %d | Product = %d", 
              $time, ui_in[3:0], ui_in[7:4], uo_out);

    clk = 0;
    rst_n = 0;
    ena = 1;
    ui_in = 8'b0;
    uio_in = 8'b0;

    #20;
    rst_n = 1;
    #10;

    ui_in = {4'd5, 4'd3};
    #10;

    ui_in = {4'd2, 4'd7};
    #10;

    ui_in = {4'd4, 4'd9};
    #10;

    ui_in = {4'd15, 4'd15};
    #10;

    ui_in = {4'd9, 4'd0};
    #10;

    $finish;
  end

endmodule
