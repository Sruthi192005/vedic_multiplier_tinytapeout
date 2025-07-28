# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles
import random

@cocotb.test()
async def test_project(dut):
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut.ena.value = 1
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1

    for _ in range(10):
        a = random.randint(0, 15)
        b = random.randint(0, 15)

        # Format: lower 4 bits = a, upper 4 bits = b
        dut.ui_in.value = (b << 4) | a
        await ClockCycles(dut.clk, 1)

        expected = a * b
        actual = dut.uo_out.value.integer

        assert actual == expected, f"{a} * {b} = {expected}, got {actual}"
