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
    clock = Clock(dut.clk, 30, units="us")
    cocotb.fork(clock.start())

    dut.s_in.value = 0;

    # rest the shift reg
    await reset(dut)

    seq = [random.randint(0,1) for _ in range(20)]

    shift_reg_depth = 8;

    pre_feed = shift_reg_depth;
    for i in range(0, len(seq)-1):
        dut.s_in.value = seq[i]
        await RisingEdge(dut.clk)

        if pre_feed > 0:
            pre_feed = pre_feed -1
        else:
            assert(dut.s_out == seq[i -shift_reg_depth])


