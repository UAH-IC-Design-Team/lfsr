module dump();
    initial begin 
        $dumpfile ("shift_reg.vcd");
        $dumpvars (0, shift_reg);
        #1;
    end
endmodule
