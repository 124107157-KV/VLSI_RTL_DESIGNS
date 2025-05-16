`timescale 1ns/1ps

module tb_sync_fifo;

    parameter WIDTH = 32;
    parameter DEPTH = 8;

    reg clk, rst, wr_en, rd_en;
    reg [WIDTH-1:0] din;
    wire [WIDTH-1:0] dout;
    wire full, empty;

    sync_fifo #(WIDTH, DEPTH) uut (
        .clk(clk), .rst(rst), .wr_en(wr_en), .rd_en(rd_en),
        .din(din), .dout(dout), .full(full), .empty(empty)
    );

    // Clock
    always #5 clk = ~clk;

    // Scoreboard using SystemVerilog queue
    reg [WIDTH-1:0] scb[$];
    integer error_count = 0;
    integer total_rd = 0, total_wr = 0;
    integer seed_wr, seed_rd, seed_data;

    // For delayed checking
    reg prev_rd_en;
    reg [WIDTH-1:0] expected_dout;

    initial begin
        $dumpfile("fifo_wave.vcd");
        $dumpvars(0, tb_sync_fifo);

        clk = 0; rst = 1; wr_en = 0; rd_en = 0; din = 0;
        prev_rd_en = 0;
        expected_dout = 0;
        seed_wr = 32'hA5A5_A5A5;
        seed_rd = 32'h5A5A_5A5A;
        seed_data = 32'h1234_5678;

        // Reset
        repeat (2) @(negedge clk);
        rst = 0;

        // Main random test: 100 cycles
        repeat (100) begin
            @(negedge clk);

            // Randomly decide to write or read (seeded, safe)
            wr_en = $urandom(seed_wr) % 2;
            rd_en = $urandom(seed_rd) % 2;

            // Apply full/empty rules
            if (full) wr_en = 0;
            if (empty) rd_en = 0;

            // Prepare input data and scoreboard
            if (wr_en) begin
                din = $urandom(seed_data);
                scb.push_back(din);
                total_wr = total_wr + 1;
            end

            // Set up delayed check if read is happening
            if (rd_en) begin
                if (scb.size() == 0) begin
                    $display("ERROR: Scoreboard empty but read occurred!");
                    error_count = error_count + 1;
                    expected_dout = 'x;
                end else begin
                    expected_dout = scb[0];
                end
            end else begin
                expected_dout = 'x;
            end

            // Move the scoreboard pointer only after read is acknowledged (on next cycle)
            prev_rd_en = rd_en;
        end

        // Give last delayed check a chance to fire
        @(negedge clk);

        // Final state check
        if (scb.size() !== uut.count) begin
            $display("ERROR: Scoreboard count %0d != FIFO count %0d", scb.size(), uut.count);
            error_count = error_count + 1;
        end

        if (error_count == 0)
            $display("TEST PASSED! %0d writes, %0d reads, FIFO survived random torture!", total_wr, total_rd);
        else
            $display("TEST FAILED! %0d errors detected.", error_count);

        $stop;
    end

    // Scoreboard check: on every posedge, if previous cycle had read
    always @(posedge clk) begin
        if (prev_rd_en) begin
            if (expected_dout !== 'x) begin
                if (dout !== expected_dout) begin
                    $display("ERROR @ %0t: Expected %h, got %h", $time, expected_dout, dout);
                    error_count = error_count + 1;
                end
                if (scb.size() > 0) begin
                    scb.pop_front();
                    total_rd = total_rd + 1;
                end
            end
        end

        $display("t=%0t | wr_en=%b, rd_en=%b, din=%h, dout=%h, full=%b, empty=%b, count=%0d",
            $time, wr_en, rd_en, din, dout, full, empty, uut.count);
    end

endmodule
