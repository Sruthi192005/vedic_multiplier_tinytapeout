module user_module_0 (
    input  [7:0] io_in,
    output [7:0] io_out
);
    wire [3:0] a = io_in[7:4];  // upper 4 bits
    wire [3:0] b = io_in[3:0];  // lower 4 bits
    wire [7:0] result;

    vedic_4x4 uut (
        .a(a),
        .b(b),
        .p(result)
    );

    assign io_out = result;  // output result directly
endmodule
