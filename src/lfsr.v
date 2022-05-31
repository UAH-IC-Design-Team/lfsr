// lfsr
`default_nettype none
`timescale 1ns/1ns

module lfsr(
    clk, 
    reset,
    load,
    s_reg_in,
    s_reg,
    lfsr_out,
    taps
);
    input   wire            clk;
    input   wire            reset;
    input   wire            load;
    input   wire [n-1:0]    taps;
    input   wire            s_reg_in;
    output  wire [n-1:0]    s_reg;
    output  wire            lfsr_out;

    parameter n = 8;

    wire                    new_bit;

    shift_reg shift_reg0(
        .clk(clk),
        .reset(reset),
        .s_in(new_bit),
        .s_reg(s_reg),
        .s_out(lfsr_out)
    );

    reg [n-1:0] taps = 8'b10101000;
    //reg [n-1:0] taps = 8'b00010101;

    wire test_output;

    assign test_output = ^(s_reg&taps);

    assign new_bit = load ? s_reg_in : s_reg[n-1] ^ s_reg[n-3] ^ s_reg[n-5];

endmodule

