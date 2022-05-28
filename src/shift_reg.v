`default_nettype none
`timescale 1ns/1ns

module shift_reg #(
    parameter REG_SIZE = 8
    ) (
    clk, 
    reset,
    s_in,
    s_reg,
    s_out
);

    input   wire                clk;
    input   wire                reset;
    input   wire                s_in;
    output  reg     [REG_SIZE-1:0]     s_reg;
    output  wire                s_out;

   
    // Attach the output
    assign s_out = s_reg[0];

    // Shift it all down.
    always @(posedge clk, posedge reset) 
    begin
        if (reset)
            s_reg <= {REG_SIZE{1'b0}} ;
        else
            s_reg <= {s_in, s_reg[REG_SIZE-1:1]};
    end


endmodule

