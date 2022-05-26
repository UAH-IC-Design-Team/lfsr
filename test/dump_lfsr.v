module dump();
    initial begin 
        $dumpfile ("lfsr.vcd");
        $dumpvars (0, lfsr);
        #1;
    end
endmodule
