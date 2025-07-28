// SPDX-License-Identifier: Apache-2.0
// 4x4 Vedic Multiplier - Tiny Tapeout Compatible

module tt_um_vedic_4x4 (
    input  wire [7:0] ui_in,     // A[3:0], B[3:0]
    output wire [7:0] uo_out,    // Product P[7:0]
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire clk,
    input  wire rst_n,
    input  wire ena
);

    wire [3:0] a = ui_in[3:0];  // A[3:0]
    wire [3:0] b = ui_in[7:4];  // B[3:0]
    wire [7:0] p;

    assign uo_out = p;
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    wire [3:0] p0, p1, p2, p3;
    wire [7:0] sum1, sum2;

    vedic_2x2 u1 (.a(a[1:0]), .b(b[1:0]), .p(p0));
    vedic_2x2 u2 (.a(a[3:2]), .b(b[1:0]), .p(p1));
    vedic_2x2 u3 (.a(a[1:0]), .b(b[3:2]), .p(p2));
    vedic_2x2 u4 (.a(a[3:2]), .b(b[3:2]), .p(p3));

    assign sum1 = {p1, 2'b00} + {2'b00, p2};
    assign sum2 = sum1 + {p3, 4'b0000};
    assign p    = {4'b0000, p0} + sum2;

endmodule


module vedic_2x2 (
    input  [1:0] a,
    input  [1:0] b,
    output [3:0] p
);

    wire a0b0, a0b1, a1b0, a1b1;
    wire sum1, carry1, sum2, carry2;

    assign a0b0 = a[0] & b[0];
    assign a0b1 = a[0] & b[1];
    assign a1b0 = a[1] & b[0];
    assign a1b1 = a[1] & b[1];

    assign {carry1, sum1} = a0b1 + a1b0;
    assign {carry2, sum2} = a1b1 + carry1;

    assign p[0] = a0b0;
    assign p[1] = sum1;
    assign p[2] = sum2;
    assign p[3] = carry2;

endmodule
