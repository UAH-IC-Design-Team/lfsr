module dump();
    initial begin 
        $dumpfile ("tap.vcd");
        $dumpvars (0, tap);
        #1;
    end
endmodule
