// Half Adder Module
module half_adder (
    input A,       // First input
    input B,       // Second input
    output SUM,    // Sum output
    output CARRY   // Carry output
);

    // Logic for Sum and Carry
    assign SUM = A ^ B;   // XOR for Sum
    assign CARRY = A & B; // AND for Carry

endmodule
// This module takes two inputs A and B and produces the SUM and CARRY outputs based on the logic:
// SUM is the XOR (^) of the two inputs.
// CARRY is the AND (&) of the two inputs.
