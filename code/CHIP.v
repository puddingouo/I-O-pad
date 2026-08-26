`timescale 1ns/10ps

module CHIP (
    input         clk,
    input         rst_n,
    input         valid_i,
    input  [15:0] a,
    input  [15:0] b,
    output [31:0] ans,
    output        valid_o
);

    // =======================================================
    // Internal Wires (Connecting Pads to Core)
    // =======================================================
    wire         core_clk;
    wire         core_rst_n;
    wire         core_valid_i;
    wire  [15:0] core_a;
    wire  [15:0] core_b;
    wire  [31:0] core_ans;
    wire         core_valid_o;

    // =======================================================
    // Core Module Instantiation
    // =======================================================
    booth_radix4 u_core (
        .clk     (core_clk),
        .rst_n   (core_rst_n),
        .valid_i (core_valid_i),
        .a       (core_a),
        .b       (core_b),
        .ans     (core_ans),
        .valid_o (core_valid_o)
    );

    // =======================================================
    // Input Pads (Standard TSMC 0.18um Input Pad: PDIDGZ)
    // =======================================================
    PDIDGZ ipad_clk     ( .PAD(clk),     .C(core_clk) );
    PDIDGZ ipad_rst_n   ( .PAD(rst_n),   .C(core_rst_n) );
    PDIDGZ ipad_valid_i ( .PAD(valid_i), .C(core_valid_i) );

    PDIDGZ ipad_a_0    ( .PAD(a[0 ]),  .C(core_a[0 ]) );
    PDIDGZ ipad_a_1    ( .PAD(a[1 ]),  .C(core_a[1 ]) );
    PDIDGZ ipad_a_2    ( .PAD(a[2 ]),  .C(core_a[2 ]) );
    PDIDGZ ipad_a_3    ( .PAD(a[3 ]),  .C(core_a[3 ]) );
    PDIDGZ ipad_a_4    ( .PAD(a[4 ]),  .C(core_a[4 ]) );
    PDIDGZ ipad_a_5    ( .PAD(a[5 ]),  .C(core_a[5 ]) );
    PDIDGZ ipad_a_6    ( .PAD(a[6 ]),  .C(core_a[6 ]) );
    PDIDGZ ipad_a_7    ( .PAD(a[7 ]),  .C(core_a[7 ]) );
    PDIDGZ ipad_a_8    ( .PAD(a[8 ]),  .C(core_a[8 ]) );
    PDIDGZ ipad_a_9    ( .PAD(a[9 ]),  .C(core_a[9 ]) );
    PDIDGZ ipad_a_10   ( .PAD(a[10]),  .C(core_a[10]) );
    PDIDGZ ipad_a_11   ( .PAD(a[11]),  .C(core_a[11]) );
    PDIDGZ ipad_a_12   ( .PAD(a[12]),  .C(core_a[12]) );
    PDIDGZ ipad_a_13   ( .PAD(a[13]),  .C(core_a[13]) );
    PDIDGZ ipad_a_14   ( .PAD(a[14]),  .C(core_a[14]) );
    PDIDGZ ipad_a_15   ( .PAD(a[15]),  .C(core_a[15]) );

    PDIDGZ ipad_b_0    ( .PAD(b[0 ]),  .C(core_b[0 ]) );
    PDIDGZ ipad_b_1    ( .PAD(b[1 ]),  .C(core_b[1 ]) );
    PDIDGZ ipad_b_2    ( .PAD(b[2 ]),  .C(core_b[2 ]) );
    PDIDGZ ipad_b_3    ( .PAD(b[3 ]),  .C(core_b[3 ]) );
    PDIDGZ ipad_b_4    ( .PAD(b[4 ]),  .C(core_b[4 ]) );
    PDIDGZ ipad_b_5    ( .PAD(b[5 ]),  .C(core_b[5 ]) );
    PDIDGZ ipad_b_6    ( .PAD(b[6 ]),  .C(core_b[6 ]) );
    PDIDGZ ipad_b_7    ( .PAD(b[7 ]),  .C(core_b[7 ]) );
    PDIDGZ ipad_b_8    ( .PAD(b[8 ]),  .C(core_b[8 ]) );
    PDIDGZ ipad_b_9    ( .PAD(b[9 ]),  .C(core_b[9 ]) );
    PDIDGZ ipad_b_10   ( .PAD(b[10]),  .C(core_b[10]) );
    PDIDGZ ipad_b_11   ( .PAD(b[11]),  .C(core_b[11]) );
    PDIDGZ ipad_b_12   ( .PAD(b[12]),  .C(core_b[12]) );
    PDIDGZ ipad_b_13   ( .PAD(b[13]),  .C(core_b[13]) );
    PDIDGZ ipad_b_14   ( .PAD(b[14]),  .C(core_b[14]) );
    PDIDGZ ipad_b_15   ( .PAD(b[15]),  .C(core_b[15]) );

    // =======================================================
    // Output Pads (TSMC 0.18um Output Pad: PDO16CDG)
    // =======================================================
    PDO16CDG opad_valid_o ( .I(core_valid_o), .PAD(valid_o) );

    PDO16CDG opad_ans_0  ( .I(core_ans[0 ]), .PAD(ans[0 ]) );
    PDO16CDG opad_ans_1  ( .I(core_ans[1 ]), .PAD(ans[1 ]) );
    PDO16CDG opad_ans_2  ( .I(core_ans[2 ]), .PAD(ans[2 ]) );
    PDO16CDG opad_ans_3  ( .I(core_ans[3 ]), .PAD(ans[3 ]) );
    PDO16CDG opad_ans_4  ( .I(core_ans[4 ]), .PAD(ans[4 ]) );
    PDO16CDG opad_ans_5  ( .I(core_ans[5 ]), .PAD(ans[5 ]) );
    PDO16CDG opad_ans_6  ( .I(core_ans[6 ]), .PAD(ans[6 ]) );
    PDO16CDG opad_ans_7  ( .I(core_ans[7 ]), .PAD(ans[7 ]) );
    PDO16CDG opad_ans_8  ( .I(core_ans[8 ]), .PAD(ans[8 ]) );
    PDO16CDG opad_ans_9  ( .I(core_ans[9 ]), .PAD(ans[9 ]) );
    PDO16CDG opad_ans_10 ( .I(core_ans[10]), .PAD(ans[10]) );
    PDO16CDG opad_ans_11 ( .I(core_ans[11]), .PAD(ans[11]) );
    PDO16CDG opad_ans_12 ( .I(core_ans[12]), .PAD(ans[12]) );
    PDO16CDG opad_ans_13 ( .I(core_ans[13]), .PAD(ans[13]) );
    PDO16CDG opad_ans_14 ( .I(core_ans[14]), .PAD(ans[14]) );
    PDO16CDG opad_ans_15 ( .I(core_ans[15]), .PAD(ans[15]) );
    PDO16CDG opad_ans_16 ( .I(core_ans[16]), .PAD(ans[16]) );
    PDO16CDG opad_ans_17 ( .I(core_ans[17]), .PAD(ans[17]) );
    PDO16CDG opad_ans_18 ( .I(core_ans[18]), .PAD(ans[18]) );
    PDO16CDG opad_ans_19 ( .I(core_ans[19]), .PAD(ans[19]) );
    PDO16CDG opad_ans_20 ( .I(core_ans[20]), .PAD(ans[20]) );
    PDO16CDG opad_ans_21 ( .I(core_ans[21]), .PAD(ans[21]) );
    PDO16CDG opad_ans_22 ( .I(core_ans[22]), .PAD(ans[22]) );
    PDO16CDG opad_ans_23 ( .I(core_ans[23]), .PAD(ans[23]) );
    PDO16CDG opad_ans_24 ( .I(core_ans[24]), .PAD(ans[24]) );
    PDO16CDG opad_ans_25 ( .I(core_ans[25]), .PAD(ans[25]) );
    PDO16CDG opad_ans_26 ( .I(core_ans[26]), .PAD(ans[26]) );
    PDO16CDG opad_ans_27 ( .I(core_ans[27]), .PAD(ans[27]) );
    PDO16CDG opad_ans_28 ( .I(core_ans[28]), .PAD(ans[28]) );
    PDO16CDG opad_ans_29 ( .I(core_ans[29]), .PAD(ans[29]) );
    PDO16CDG opad_ans_30 ( .I(core_ans[30]), .PAD(ans[30]) );
    PDO16CDG opad_ans_31 ( .I(core_ans[31]), .PAD(ans[31]) );

endmodule
