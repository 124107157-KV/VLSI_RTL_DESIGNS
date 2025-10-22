`timescale 1ns/1ps

module clockdivider_tb;

  localparam int CLK_PERIOD_NS = 10;    // 100 MHz
  localparam int WINDOW_CYCLES = 160;   // multiple of 16

  reg  clk = 1'b0;
  reg  rst;                              // active-low
  wire divideby2, divideby4, divideby8, divideby16;

  // DUT
  clockdivider dut (
    .clk(clk),
    .divideby2(divideby2),
    .divideby4(divideby4),
    .divideby8(divideby8),
    .divideby16(divideby16),
    .rst(rst)
  );

  // 100 MHz clock
  always #(CLK_PERIOD_NS/2) clk = ~clk;

  // ---- Measurement control (SYNC to clk)
  reg measuring = 1'b0;
  integer cycles_left = 0;

  // Edge counters (all gated by measuring)
  integer clk_edges   = 0;
  integer div2_edges  = 0;
  integer div4_edges  = 0;
  integer div8_edges  = 0;
  integer div16_edges = 0;

  always @(posedge clk)        if (measuring) clk_edges   <= clk_edges + 1;
  always @(posedge divideby2)  if (measuring) div2_edges  <= div2_edges + 1;
  always @(posedge divideby4)  if (measuring) div4_edges  <= div4_edges + 1;
  always @(posedge divideby8)  if (measuring) div8_edges  <= div8_edges + 1;
  always @(posedge divideby16) if (measuring) div16_edges <= div16_edges + 1;

  // Duty tracking (sampled on clk)
  integer div2_high = 0, div4_high = 0, div8_high = 0, div16_high = 0;
  always @(posedge clk) if (measuring) begin
    if (divideby2)  div2_high  <= div2_high  + 1;
    if (divideby4)  div4_high  <= div4_high  + 1;
    if (divideby8)  div8_high  <= div8_high  + 1;
    if (divideby16) div16_high <= div16_high + 1;
  end

  // Synchronous start/stop of the window
  always @(posedge clk) begin
    if (start_window_pulse) begin
      measuring    <= 1'b1;
      cycles_left  <= WINDOW_CYCLES;
      // clear counters exactly on the first measured edge
      clk_edges    <= 0;
      div2_edges   <= 0;
      div4_edges   <= 0;
      div8_edges   <= 0;
      div16_edges  <= 0;
      div2_high    <= 0;
      div4_high    <= 0;
      div8_high    <= 0;
      div16_high   <= 0;
    end else if (measuring) begin
      cycles_left <= cycles_left - 1;
      if (cycles_left == 1) begin
        // After this very posedge is counted, drop measuring
        measuring <= 1'b0;
      end
    end
  end

  // One-cycle pulse to start the window (generated in the initial)
  reg start_window_pulse = 1'b0;

  // ---- Stimulus
  initial begin
    $dumpfile("clockdivider_tb.vcd");
    $dumpvars(0, clockdivider_tb);

    // Reset (active-low)
    rst = 1'b0;
    repeat (4) @(posedge clk);
    rst = 1'b1;

    // Align a bit
    repeat (2) @(posedge clk);

    // Kick off a perfectly framed window on the next posedge
    @(posedge clk);
    start_window_pulse = 1'b1;
    @(posedge clk);
    start_window_pulse = 1'b0;

    // Wait until measurement completes cleanly
    wait (measuring == 1'b0);

    // Now clk_edges MUST equal WINDOW_CYCLES exactly.
    if (clk_edges !== WINDOW_CYCLES) begin
      $display("[FAIL] clk_edges=%0d expected=%0d", clk_edges, WINDOW_CYCLES);
      $fatal;
    end

    // Ratio checks
    check_ratio("/2",  div2_edges,  clk_edges/2);
    check_ratio("/4",  div4_edges,  clk_edges/4);
    check_ratio("/8",  div8_edges,  clk_edges/8);
    check_ratio("/16", div16_edges, clk_edges/16);

    // Duty checks (±1 tolerance)
    // Duty checks (±1–2 tolerance is fine)
    check_duty("divideby2",  div2_high,  WINDOW_CYCLES/2,  2);
    check_duty("divideby4",  div4_high,  WINDOW_CYCLES/2,  2);
    check_duty("divideby8",  div8_high,  WINDOW_CYCLES/2,  2);
    check_duty("divideby16", div16_high, WINDOW_CYCLES/2,  2);


    $display("[PASS] Ratios and duty cycles OK over %0d input cycles.", clk_edges);

    // Mid-run reset for waveform sanity check
    repeat (10) @(posedge clk);
    rst = 1'b0; repeat (3) @(posedge clk); rst = 1'b1;
    repeat (20) @(posedge clk);

    $display("[INFO] Test completed. Open clockdivider_tb.vcd in EPWave.");
    $finish;
  end

  // ---- Helpers
  task automatic check_ratio(input string name, input integer got, input integer exp);
    begin
      if (got !== exp) begin
        $display("[FAIL] %s edges=%0d expected=%0d", name, got, exp);
        $fatal;
      end else begin
        $display("[OK]   %s edges=%0d", name, got);
      end
    end
  endtask

  task automatic check_duty
    (input string name, input integer highs, input integer expected, input integer tol);
    begin
      if ((highs < expected - tol) || (highs > expected + tol)) begin
        $display("[FAIL] %s duty: highs=%0d, expected≈%0d±%0d", name, highs, expected, tol);
        $fatal;
      end else begin
        $display("[OK]   %s duty: highs=%0d (expected≈%0d±%0d)", name, highs, expected, tol);
      end
    end
  endtask

endmodule
