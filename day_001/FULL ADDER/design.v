// Full Adder Module using Dataflow Modeling
module full_adder (
    input A,       // First input
    input B,       // Second input
    input CIN,     // Carry input
    output SUM,    // Sum output
    output COUT    // Carry output
);

    // Dataflow modeling for Sum and Carry out
    assign SUM = A ^ B ^ CIN;          // XOR for Sum
    assign COUT = (A & B) | (B & CIN) | (A & CIN); // Carry output logic

endmodule

// The full adder adds three 1-bit inputs: A, B, and CIN (carry-in).
// The output SUM is the sum of the three inputs, while COUT (carry-out) is the carry resulting from the addition.
// The SUM is calculated using the XOR operation between A, B, and CIN (A ^ B ^ CIN).
// The COUT is determined by the equation (A & B) | (B & CIN) | (A & CIN).
