// Full Subtractor using Dataflow Modeling
module full_subtractor (
    input A,        // Minuend
    input B,        // Subtrahend
    input BIN,      // Borrow in
    output DIFF,    // Difference
    output BOUT     // Borrow out
);

    // Dataflow modeling for Difference and Borrow out
    assign DIFF = A ^ B ^ BIN;         // XOR for Difference
    assign BOUT = (~A & B) | (BIN & (~A ^ B));  // Borrow logic

endmodule

// The Difference (DIFF) is computed using the XOR operation: DIFF = A ^ B ^ BIN. It gives the result of subtracting B and BIN from A.
// The Borrow out (BOUT) occurs when a borrow is needed from the next higher bit.
// The borrow logic is: BOUT = (~A & B) | (BIN & (~A ^ B)), which handles cases where either A < B or there’s a borrow in (BIN).
