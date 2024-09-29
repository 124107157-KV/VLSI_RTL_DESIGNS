// Testbench for Full Subtractor
module tb_full_subtractor();

    // Declare inputs as reg and outputs as wire
    reg A;
    reg B;
    reg BIN;
    wire DIFF;
    wire BOUT;

    // Instantiate the Full Subtractor module
    full_subtractor uut (
        .A(A),
        .B(B),
        .BIN(BIN),
        .DIFF(DIFF),
        .BOUT(BOUT)
    );

    // Test procedure
    initial begin
        // Monitor output
        $monitor("A = %b, B = %b, BIN = %b, DIFF = %b, BOUT = %b", A, B, BIN, DIFF, BOUT);

        // Test cases
        A = 0; B = 0; BIN = 0; #10;   // 0 - 0 - 0
        A = 0; B = 1; BIN = 0; #10;   // 0 - 1 - 0
        A = 1; B = 0; BIN = 0; #10;   // 1 - 0 - 0
        A = 1; B = 1; BIN = 0; #10;   // 1 - 1 - 0
        A = 0; B = 0; BIN = 1; #10;   // 0 - 0 - 1
        A = 0; B = 1; BIN = 1; #10;   // 0 - 1 - 1
        A = 1; B = 0; BIN = 1; #10;   // 1 - 0 - 1
        A = 1; B = 1; BIN = 1; #10;   // 1 - 1 - 1

        // End the simulation
        $finish;
    end

endmodule

// The testbench applies all possible combinations of inputs A, B, and BIN to verify the Full Subtractor’s operation.
// The $monitor command prints the inputs and corresponding outputs (DIFF, BOUT) for each test case.
