// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module johnson_counter_tb;

  localparam int WIDTH = 4;
  localparam int STATES = 2*WIDTH;
  localparam int CLK_NS = 10;

  reg  clk = 1'b0;
  reg  reset;
  wire [WIDTH-1:0] count;

  // DUT: classic left-shift Johnson
  johnson_counter #(.WIDTH(WIDTH), .SHIFT_LEFT(1)) dut (
    .clk(clk), .reset(reset), .count(count)
  );

  // clock
  always #(CLK_NS/2) clk = ~clk;

  // helper: next-state function (must match SHIFT_LEFT=1)
  function automatic [WIDTH-1:0] next_johnson(input [WIDTH-1:0] c);
    next_johnson = {c[WIDTH-2:0], ~c[WIDTH-1]};
  endfunction

  // waveform
  initial begin
    $dumpfile("johnson_tb.vcd");
    $dumpvars(0, johnson_counter_tb);
  end

  // stimulus + checks
  integer i;
  reg [WIDTH-1:0] seen [0:STATES-1];

  initial begin
    // reset
    reset = 1'b1;
    repeat (3) @(posedge clk);
    reset = 1'b0;

    // Expect sequence starting from 0...0
    seen[0] = count;
    for (i = 1; i < STATES; i = i + 1) begin
      @(posedge clk);
      seen[i] = count;
      if (count !== next_johnson(seen[i-1])) begin
        $display("[FAIL] step %0d: got %b expected %b",
                 i, count, next_johnson(seen[i-1]));
        $fatal;
      end
    end

    // uniqueness over 2*WIDTH states
    for (int a = 0; a < STATES; a++) begin
      for (int b = a+1; b < STATES; b++) begin
        if (seen[a] === seen[b]) begin
          $display("[FAIL] duplicate state at %0d and %0d: %b", a, b, seen[a]);
          $fatal;
        end
      end
    end

    // wrap check: next should return to initial after 2*WIDTH steps
    @(posedge clk);
    if (count !== seen[0]) begin
      $display("[FAIL] wrap: after %0d steps got %b expected %b",
               STATES, count, seen[0]);
      $fatal;
    end

    $display("[PASS] Johnson counter WIDTH=%0d produced %0d unique states and wrapped correctly.",
             WIDTH, STATES);
    # (5*CLK_NS);
    $finish;
  end

endmodule
