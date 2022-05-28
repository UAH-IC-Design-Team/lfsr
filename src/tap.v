`default_nettype none
`timescale 1ns/1ns

module tap #(
    parameter REG_SIZE = 8
) (
    clk, 
    load,
    reset,
    tap_in,
    tap_reg
);
    input   wire                clk;
    input   wire                load;
    input   wire                reset;
    input   wire                tap_in;
    output  reg  [REG_SIZE-1:0] tap_reg;

    wire    sr_clk;

    assign sr_clk = clk & load;

    shift_reg #(
        .REG_SIZE(REG_SIZE)
    ) lfsr_tap_reg (
        .clk(sr_clk),
        .reset(reset),
        .s_in(tap_in),
        .s_reg(tap_reg)
    );

endmodule
 
