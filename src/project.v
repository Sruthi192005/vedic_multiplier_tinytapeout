//2*2 vedic multiplier
module vedic2(
    input [1:0] a,
    input [1:0] b,
    output [3:0] s
);
    wire w1, w2, w3, w4, w5;

    and(w1, a[0], b[0]);
    and(w2, a[0], b[1]);
    and(w3, a[1], b[0]);
    and(w4, a[1], b[1]);

    assign s[0] = w1;

    wire sum1, carry1;
    ha h1(w2, w3, sum1, carry1);

    wire sum2, carry2;
    ha h2(w4, carry1, sum2, carry2);

    assign s[1] = sum1;
    assign s[2] = sum2;
    assign s[3] = carry2;
endmodule

//4*4 vedic multiplier
module vedic4(
    input [3:0] a,
    input [3:0] b,
    output [7:0] r
);
    wire [3:0] p0, p1, p2, p3;
    wire [7:0] temp1, temp2;
    wire [7:0] sum1, sum2;

    
    vedic2 u0(a[1:0], b[1:0], p0); // LSB: lower A, lower B
    vedic2 u1(a[3:2], b[1:0], p1); // upper A, lower B
    vedic2 u2(a[1:0], b[3:2], p2); // lower A, upper B
    vedic2 u3(a[3:2], b[3:2], p3); // upper A, upper B

    assign temp1 = ({4'b0000, p1} << 2) + ({4'b0000, p2} << 2);  // shifted by 2
    assign temp2 = {4'b0000, p3} << 4;                           // shifted by 4

    assign sum1 = {4'b0000, p0} + temp1; // Add LSB and middle
    assign sum2 = sum1 + temp2;          // Add MSB part

    assign r = sum2; // Final result
endmodule

//8*8 vedic multiplier
module vedic8(input [7:0] a, input [7:0] b, output [15:0] r);
    wire [7:0] p0, p1, p2, p3;
    wire [15:0] temp1, temp2, sum1, sum2;

    vedic4 v0(a[3:0], b[3:0], p0);
    vedic4 v1(a[7:4], b[3:0], p1);
    vedic4 v2(a[3:0], b[7:4], p2);
    vedic4 v3(a[7:4], b[7:4], p3);

    assign temp1 = (p1 << 4) + (p2 << 4);
    assign temp2 = p3 << 8;
    assign sum1 = {8'b0, p0} + temp1;
    assign sum2 = sum1 + temp2;

    assign r = sum2;
endmodule


// 16*16 vedic mulitplier
`timescale 1ns / 1ps
module vedic16(
    input [15:0] a,
    input [15:0] b,
    output [31:0] r
);
    wire [15:0] p0, p1, p2, p3;
    wire [31:0] temp1, temp2, sum1, sum2;

    vedicc8 u0(a[7:0],  b[7:0],  p0);  // LSB parts
    vedicc8 u1(a[15:8], b[7:0],  p1);  // upper A, lower B
    vedicc8 u2(a[7:0],  b[15:8], p2);  // lower A, upper B
    vedicc8 u3(a[15:8], b[15:8], p3);  // upper A, upper B

    assign temp1 = (p1 << 8) + (p2 << 8);  // both shifted by 8 bits
    assign temp2 = p3 << 16;               // shifted by 16 bits


    assign sum1 = p0 + temp1;
    assign sum2 = sum1 + temp2;

    assign r = sum2;
endmodule



