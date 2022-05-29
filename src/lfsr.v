// lfsr
`default_nettype none
`timescale 1ns/1ns

module lfsr(
    clk, 
    reset,
    load_s_reg,
    load_tap_reg,
    reg_in,
    lfsr_out
);
    input   wire            clk;
    input   wire            reset;
    input   wire            load_s_reg;
    input   wire            load_tap_reg;
    input   wire            reg_in;
    output  wire            lfsr_out;

    parameter n = 8; // register size

    wire                    new_bit;
    wire        [n-1:0]     s_reg;
    wire        [n-1:0]     tap_reg;

    shift_reg shift_reg0(
        .clk(clk),
        .reset(reset),
        .s_in(new_bit),
        .s_reg(s_reg),
        .s_out(lfsr_out)
    );

    tap tap0(
        .clk(clk),
        .reset(reset),
        .load(load_tap_reg),
        .tap_in(reg_in),
        .tap_reg(tap_reg)
    );

    assign new_bit = load_s_reg ? reg_in : ^(s_reg&tap_reg);

    //  assign new_bit = load ? s_reg_in : s_reg[n-1] ^ s_reg[n-3] ^ s_reg[n-5];

endmodule

