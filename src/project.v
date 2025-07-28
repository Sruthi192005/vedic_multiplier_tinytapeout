//vedic 16*16
module vedic16 (
    input [15:0] a,
    input [15:0] b,
    output [31:0] r
);
    wire [15:0] p0, p1, p2, p3;
    wire [31:0] temp1, temp2, temp3;

    vedic8 v0 (a[7:0],  b[7:0],  p0);
    vedic8 v1 (a[15:8], b[7:0],  p1);
    vedic8 v2 (a[7:0],  b[15:8], p2);
    vedic8 v3 (a[15:8], b[15:8], p3);

    assign temp1 = ({16'b0, p1}) << 8;
    assign temp2 = ({16'b0, p2}) << 8;
    assign temp3 = (p3 << 16);

    assign r = p0 + temp1 + temp2 + temp3;
endmodule

//vedic 8*8
module vedic8 (
    input [7:0] a,
    input [7:0] b,
    output [15:0] r
);
    wire [7:0] p0, p1, p2, p3;
    wire [15:0] temp1, temp2, temp3;

    vedic4 v0 (a[3:0],  b[3:0],  p0);
    vedic4 v1 (a[7:4],  b[3:0],  p1);
    vedic4 v2 (a[3:0],  b[7:4],  p2);
    vedic4 v3 (a[7:4],  b[7:4],  p3);

    assign temp1 = {8'b0, p1} << 4;
    assign temp2 = {8'b0, p2} << 4;
    assign temp3 = {p3, 8'b0};

    assign r = p0 + temp1 + temp2 + temp3;
endmodule

//vedic 4*4
module vedic4 (
    input [3:0] a,
    input [3:0] b,
    output [7:0] r
);
    wire [3:0] p0, p1, p2, p3;
    wire [7:0] temp1, temp2, temp3;

    vedic2 v0 (a[1:0], b[1:0], p0);
    vedic2 v1 (a[3:2], b[1:0], p1);
    vedic2 v2 (a[1:0], b[3:2], p2);
    vedic2 v3 (a[3:2], b[3:2], p3);

    assign temp1 = {4'b0, p1} << 2;
    assign temp2 = {4'b0, p2} << 2;
    assign temp3 = {p3, 4'b0};

    assign r = p0 + temp1 + temp2 + temp3;
endmodule

// vedic 2*2
module vedic2 (
    input [1:0] a,
    input [1:0] b,
    output [3:0] r
);
    wire p0, p1, p2, p3;
    wire s1, c1, s2, c2;

    assign p0 = a[0] & b[0];
    assign p1 = a[1] & b[0];
    assign p2 = a[0] & b[1];
    assign p3 = a[1] & b[1];

    assign s1 = p1 ^ p2;
    assign c1 = p1 & p2;
    assign s2 = p3 ^ c1;
    assign c2 = p3 & c1;

    assign r[0] = p0;
    assign r[1] = s1;
    assign r[2] = s2;
    assign r[3] = c2;
endmodule
