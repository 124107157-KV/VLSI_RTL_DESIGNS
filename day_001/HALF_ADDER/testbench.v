// Testbench for Half Adder
module tb_half_adder();

    // Declare inputs as reg and outputs as wire
    reg A;
    reg B;
    wire SUM;
    wire CARRY;

    // Instantiate the half_adder module
    half_adder uut (
        .A(A),
        .B(B),
        .SUM(SUM),
        .CARRY(CARRY)
    );

    // Test procedure
    initial begin
        // Monitor output
        $monitor("A = %b, B = %b, SUM = %b, CARRY = %b", A, B, SUM, CARRY);

        // Test cases
        A = 0; B = 0; #10;  // 0 + 0
        A = 0; B = 1; #10;  // 0 + 1
        A = 1; B = 0; #10;  // 1 + 0
        A = 1; B = 1; #10;  // 1 + 1

        // End the simulation
        $finish;
    end

endmodule

// The testbench instantiates the half_adder module.
// The inputs A and B are tested with all possible combinations (00, 01, 10, 11).
// The $monitor statement prints the values of A, B, SUM, and CARRY at each step.
// After applying all test cases, the simulation ends with $finish
