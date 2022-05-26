module dump();
    initial begin 
        $dumpfile ("dflop.vcd");
        $dumpvars (0, dflop);
        #1;
    end
endmodule
