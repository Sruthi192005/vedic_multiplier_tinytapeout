`timescale 1ns/1ps

module vedic16_tb;
    reg [15:0] a, b;
    wire [31:0] r;

    // Instantiate the design under test (DUT)
    vedic16 uut (
        .a(a),
        .b(b),
        .r(r)
    );

    initial begin
        $display("Time\t\ta\tb\tProduct");
        $monitor("%0dns\t%0d\t%0d\t%0d", $time, a, b, r);

        // Test 1
        a = 16'd5;
        b = 16'd10;
        #10;

        // Test 2
        a = 16'd123;
        b = 16'd456;
        #10;

        // Test 3
        a = 16'd1024;
        b = 16'd64;
        #10;

        // Test 4
        a = 16'd255;
        b = 16'd255;
        #10;

        // Test 5
        a = 16'd65535;
        b = 16'd1;
        #10;

        // Test 6
        a = 16'd0;
        b = 16'd12345;
        #10;

        // Test 7
        a = 16'd43210;
        b = 16'd12345;
        #10;

        // Test 8: Max value × Max value
        a = 16'hFFFF;
        b = 16'hFFFF;
        #10;

        $finish;
    end
endmodule
