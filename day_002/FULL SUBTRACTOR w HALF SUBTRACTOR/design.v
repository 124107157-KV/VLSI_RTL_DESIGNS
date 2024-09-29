// Half Subtractor Module
module half_subtractor (
    input A,        // Minuend
    input B,        // Subtrahend
    output DIFF,    // Difference
    output BORROW   // Borrow output
);

    // Dataflow modeling for Difference and Borrow
    assign DIFF = A ^ B;        // XOR for Difference
    assign BORROW = ~A & B;     // Borrow occurs when A is 0 and B is 1

endmodule

// Full Subtractor using two Half Subtractors
module full_subtractor (
    input A,        // Minuend
    input B,        // Subtrahend
    input BIN,      // Borrow in
    output DIFF,    // Difference
    output BOUT     // Borrow out
);

    wire D1, B1, B2;   // Intermediate wires

    // Instantiate the first half subtractor
    half_subtractor HS1 (
        .A(A),
        .B(B),
        .DIFF(D1),
        .BORROW(B1)
    );

    // Instantiate the second half subtractor
    half_subtractor HS2 (
        .A(D1),
        .B(BIN),
        .DIFF(DIFF),
        .BORROW(B2)
    );

    // Borrow out logic: if either B1 or B2 has a borrow, output borrow
    assign BOUT = B1 | B2;

endmodule

// The Half Subtractor calculates the difference and borrow between two inputs: A and B.
// DIFF = A ^ B (XOR for difference).
// BORROW = ~A & B (Borrow occurs when A is 0 and B is 1).

// The first Half Subtractor computes the difference (D1) and the borrow (B1) between A and B.
// The second Half Subtractor takes the intermediate difference (D1) and subtracts the borrow-in (BIN), 
// producing the final difference (DIFF) and a second borrow (B2).
// The final borrow-out (BOUT) is calculated by OR-ing the two borrow signals (BOUT = B1 | B2).
