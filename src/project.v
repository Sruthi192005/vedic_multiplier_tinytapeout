module tt_um_vedic_8x8 (
    input  [7:0] ui_in,
    output [7:0] uo_out,
    input  [7:0] uio_in,
    output [7:0] uio_out,
    output [7:0] uio_oe,
    input        clk,
    input        rst_n,
    input ena
);
    wire [3:0] a = ui_in[3:0];
    wire [3:0] b = ui_in[7:4];
    wire [7:0] p;

    vedic_4x4 mul (
        .a(a),
        .b(b),
        .p(p)
    );

    assign uo_out = p;
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;
endmodule

module vedic_4x4 (
    input  [3:0] a,
    input  [3:0] b,
    output [7:0] p
);
    wire [3:0] p0, p1, p2, p3;
    wire [7:0] temp1, temp2, temp3;

    vedic_2x2 m1 (.a(a[1:0]), .b(b[1:0]), .p(p0));
    vedic_2x2 m2 (.a(a[3:2]), .b(b[1:0]), .p(p1));
    vedic_2x2 m3 (.a(a[1:0]), .b(b[3:2]), .p(p2));
    vedic_2x2 m4 (.a(a[3:2]), .b(b[3:2]), .p(p3));

    assign temp1 = {4'b0000, p0};
    assign temp2 = {2'b00, p1} + {2'b00, p2, 2'b00};
    assign temp3 = {p3, 4'b0000};

    assign p = temp1 + temp2 + temp3;
endmodule

module vedic_2x2 (
    input  [1:0] a,
    input  [1:0] b,
    output [3:0] p
);
    wire a0b0 = a[0] & b[0];
    wire a0b1 = a[0] & b[1];
    wire a1b0 = a[1] & b[0];
    wire a1b1 = a[1] & b[1];

    wire s1 = a0b1 ^ a1b0;
    wire c1 = a0b1 & a1b0;

    wire s2 = a1b1 ^ c1;
    wire c2 = a1b1 & c1;

    assign p[0] = a0b0;
    assign p[1] = s1;
    assign p[2] = s2;
    assign p[3] = c2;
endmodule
