// Testbench for Full Adder
module tb_full_adder();

    // Declare inputs as reg and outputs as wire
    reg A;
    reg B;
    reg CIN;
    wire SUM;
    wire COUT;

    // Instantiate the full_adder module
    full_adder uut (
        .A(A),
        .B(B),
        .CIN(CIN),
        .SUM(SUM),
        .COUT(COUT)
    );

    // Test procedure
    initial begin
        // Monitor output
        $monitor("A = %b, B = %b, CIN = %b, SUM = %b, COUT = %b", A, B, CIN, SUM, COUT);

        // Test cases
        A = 0; B = 0; CIN = 0; #10;  // 0 + 0 + 0
        A = 0; B = 0; CIN = 1; #10;  // 0 + 0 + 1
        A = 0; B = 1; CIN = 0; #10;  // 0 + 1 + 0
        A = 0; B = 1; CIN = 1; #10;  // 0 + 1 + 1
        A = 1; B = 0; CIN = 0; #10;  // 1 + 0 + 0
        A = 1; B = 0; CIN = 1; #10;  // 1 + 0 + 1
        A = 1; B = 1; CIN = 0; #10;  // 1 + 1 + 0
        A = 1; B = 1; CIN = 1; #10;  // 1 + 1 + 1

        // End the simulation
        $finish;
    end

endmodule

// Inputs (A, B, CIN) are tested with all possible combinations of 0s and 1s.
// The $monitor command prints the inputs and the corresponding outputs SUM and COUT.
// Each combination is simulated for 10 time units (#10) to observe the result before moving to the next test case.
