# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Start the clock
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset and enable
    dut.ena.value = 1
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    # Test case 1: 3 * 2 = 6
    dut.a.value = 3
    dut.b.value = 2
    await ClockCycles(dut.clk, 2)
    assert dut.p.value == 6, f"Expected 6, got {dut.p.value.integer}"

    # Test case 2: 5 * 4 = 20
    dut.a.value = 5
    dut.b.value = 4
    await ClockCycles(dut.clk, 2)
    assert dut.p.value == 20, f"Expected 20, got {dut.p.value.integer}"

    # Test case 3: 15 * 15 = 225
    dut.a.value = 15
    dut.b.value = 15
    await ClockCycles(dut.clk, 2)
    assert dut.p.value == 225, f"Expected 225, got {dut.p.value.integer}"

    dut._log.info("All test cases passed.")
