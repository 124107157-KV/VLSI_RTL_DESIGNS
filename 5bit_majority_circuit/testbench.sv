// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module tb_majority_ckt;

  reg  [4:0] x;
  wire z;
  reg  expected;
  integer i, ones;

  // DUT
  majority_ckt_struct dut(.x(x), .z(z));

  initial begin
    $dumpfile("majority_tb.vcd");
    $dumpvars(0, tb_majority_ckt);

    $display("---- 5-Input Majority Logic Test ----");
    $display(" x[4:0] | ones | expected | z | result");
    $display("--------------------------------------");

    // Loop through all 32 combinations
    for (i = 0; i < 32; i = i + 1) begin
      x = i[4:0];
      ones = x[0] + x[1] + x[2] + x[3] + x[4];
      expected = (ones >= 3);
      #1; // small delay for propagation

      if (z !== expected)
        $display("%b | %0d | %b | %b | FAIL ❌", x, ones, expected, z);
      else
        $display("%b | %0d | %b | %b | PASS ✅", x, ones, expected, z);
    end

    $display("--------------------------------------");
    $display("Simulation completed.");
    $finish;
  end
endmodule
