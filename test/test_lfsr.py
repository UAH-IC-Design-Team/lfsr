import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles
import random

def red_xor(x):
    k = 0
    d = x
    while d != 0:
        k = k + 1
        d = d & (d - 1)
    return k % 2

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
    dut.load_s_reg.value = 0
    dut.reg_in.value = 0
    dut.load_tap_reg.value = 0

    # reset the shift register
    await reset(dut)

    # Initialize the shift register with random values
    shift_reg_depth = 8;
    seq1 = [random.randint(0,1) for _ in range(shift_reg_depth)]
    seq2 = [random.randint(0,1) for _ in range(shift_reg_depth)]


    # load the shift reg with some random values
    dut.load_s_reg.value = 1
    for i in range(0, len(seq1) -1):
        dut.reg_in.value = seq1[i]
        await RisingEdge(dut.clk)
    dut.load_s_reg.value = 0

    # load the tap with another set of values
    dut.load_tap_reg.value = 1
    for i in range(0, len(seq1) -1):
        dut.reg_in.value = seq2[i]
        await RisingEdge(dut.clk)
    dut.load_tap_reg.value = 0


    # Test the lfsr

    # Need to test that the feedback XOR is working properly
    for i in range(0, cycles-shift_reg_depth -1):
        await RisingEdge(dut.clk)


# TODO Need to write asertions!!!


