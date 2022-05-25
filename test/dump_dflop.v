module dump();
    initial begin 
        $dumpfile ("dflop.vcf");
        $dumpvars (0, dflop);
        #1;
    end
endmodule
