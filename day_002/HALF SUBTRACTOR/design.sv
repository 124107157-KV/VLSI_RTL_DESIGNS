// Half Subtractor using Dataflow Modeling
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

// The Difference (DIFF) is calculated using the XOR operation: DIFF = A ^ B, which gives the result of subtraction.
// The Borrow occurs when A is 0 and B is 1: BORROW = ~A & B.
