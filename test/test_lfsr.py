import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles
import random

async def reset(dut):
    dut.reset.value = 1;
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    dut.reset.value = 0
    await RisingEdge(dut.clk)



@cocotb.test()
async def test_shift_reg(dut):
    cycles = 30;
    clock = Clock(dut.clk, cycles, units="us")
    cocotb.fork(clock.start())

    # set starting variables
    dut.load.value = 0;
    dut.s_reg_in.value = 0;

    # reset the shift register
    await reset(dut)

    # Initialize the shift register with random values
    shift_reg_depth = 8;
    seq = [random.randint(0,1) for _ in range(shift_reg_depth)]
    dut.load.value = 1

    for i in range(0, len(seq) -1):
        dut.s_reg_in.value = seq[i]
        await RisingEdge(dut.clk)

    # Test the lfsr

    pre_feed = shift_reg_depth;
    # Need to test that the feedback XOR is working properly
    dut.load.value = 0
    for i in range(0, cycles-shift_reg_depth -1):
        await RisingEdge(dut.clk)

        if pre_feed > 0:
            pre_feed = pre_feed -1
        # else:
        #     assert(dut.s_out == seq[i -shift_reg_depth])



