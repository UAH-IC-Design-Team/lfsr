import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles
import random

@cocotb.test()
async def test_dflop(dut):
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())


    seq = [random.randint(0,1) for _ in range(10)]

    first = 1
    for i in range(0,len(seq)-1):
        dut.D.value = seq[i]
        await RisingEdge(dut.clk)

        if first:
            first = 0
        else:
            assert(dut.Q == seq[i-1])
            # print("Q = ", dut.Q, "and D_-1 = ", seq[i-1])

