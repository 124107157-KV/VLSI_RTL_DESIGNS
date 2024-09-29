// Half Adder Module
module half_adder (
    input A,        // First input
    input B,        // Second input
    output SUM,     // Sum output
    output CARRY    // Carry output
);

    // Logic for Sum and Carry
    assign SUM = A ^ B;     // XOR for Sum
    assign CARRY = A & B;   // AND for Carry

endmodule

// Full Adder Module using Two Half Adders
module full_adder (
    input A,        // First input
    input B,        // Second input
    input CIN,      // Carry input
    output SUM,     // Sum output
    output COUT     // Carry output
);

    wire S1, C1, C2;

    // First half adder instance
    half_adder HA1 (
        .A(A),
        .B(B),
        .SUM(S1),
        .CARRY(C1)
    );

    // Second half adder instance
    half_adder HA2 (
        .A(S1),
        .B(CIN),
        .SUM(SUM),
        .CARRY(C2)
    );

    // Final carry output logic
    assign COUT = C1 | C2;  // OR gate for carry out

endmodule


// Half Adder Module:
// The half adder adds two 1-bit inputs (A, B) and produces a sum (SUM) and a carry output (CARRY).
// SUM = A ^ B (XOR gate) and CARRY = A & B (AND gate).

//Full Adder Using Two Half Adders:
// First Half Adder: Adds the two inputs A and B, producing a sum S1 and a carry C1.
// Second Half Adder: Adds the sum S1 from the first half adder and the carry input (CIN), producing the final sum (SUM) and an intermediate carry C2.
// Carry Output: The final carry out (COUT) is the OR of the two intermediate carries (C1 | C2).
