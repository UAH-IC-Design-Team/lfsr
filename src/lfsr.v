// lfsr
`default_nettype none
`timescale 1ns/1ns

module lfsr(
    `ifdef USE_POWER_PINS
        inout vccd1,	// User area 1 1.8V supply
        inout vssd1,	// User area 1 digital ground
    `endif

    input   wire            clk,
    input   wire            reset,
    input   wire            load,
    input   wire            s_reg_in,
    output  wire            lfsr_out,
    output  wire            io_oeb
);
        parameter n = 8;

    wire                    new_bit;
    wire        [n-1:0]     s_reg;

    assign io_oeb = 1'b0;

    shift_reg shift_reg0(
        .clk(clk),
        .reset(reset),
        .s_in(new_bit),
        .s_reg(s_reg),
        .s_out(lfsr_out)
    );

    assign new_bit = load ? s_reg_in : s_reg[n-1] ^ s_reg[n-3] ^ s_reg[n-5];

endmodule

