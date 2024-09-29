// Testbench for Half Subtractor
module tb_half_subtractor();

    // Declare inputs as reg and outputs as wire
    reg A;
    reg B;
    wire DIFF;
    wire BORROW;

    // Instantiate the Half Subtractor module
    half_subtractor uut (
        .A(A),
        .B(B),
        .DIFF(DIFF),
        .BORROW(BORROW)
    );

    // Test procedure
    initial begin
        // Monitor output
        $monitor("A = %b, B = %b, DIFF = %b, BORROW = %b", A, B, DIFF, BORROW);

        // Test cases
        A = 0; B = 0; #10;   // 0 - 0
        A = 0; B = 1; #10;   // 0 - 1 (borrow)
        A = 1; B = 0; #10;   // 1 - 0
        A = 1; B = 1; #10;   // 1 - 1

        // End the simulation
        $finish;
    end

endmodule

// The testbench applies different input combinations of A and B and monitors the output of the half subtractor.
// $monitor prints the values of A, B, DIFF, and BORROW at each step.
