// Verilog
`default_nettype none
`timescale 1ns/1ns
module dflop (
    clk,
    D,
    Q
);
    // probably need a reset...
    input   wire    clk;
    input   wire    D;
    output  reg     Q;

    always @(posedge clk)
    begin
        Q <= D;
    end

endmodule
