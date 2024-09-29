// 4-BIT RIPPLE CARRY ADDER USING 4 1-BIT FULL ADDERS
// 1-bit Full Adder Module using Dataflow Modeling
module full_adder (
    input A,        // First input
    input B,        // Second input
    input CIN,      // Carry input
    output SUM,     // Sum output
    output COUT     // Carry output
);

    // Dataflow modeling for Sum and Carry out
    assign SUM = A ^ B ^ CIN;          // XOR for Sum
    assign COUT = (A & B) | (B & CIN) | (A & CIN); // Carry out logic

endmodule

// 4-bit Ripple Carry Adder using 1-bit Full Adders
module rca_4bit (
    input [3:0] A,     // 4-bit input A
    input [3:0] B,     // 4-bit input B
    input CIN,         // Carry input
    output [3:0] SUM,  // 4-bit sum output
    output COUT        // Final carry output
);

    wire C1, C2, C3;   // Internal carry wires

    // Instantiate 4 full adders
    full_adder FA0 (A[0], B[0], CIN,  SUM[0], C1);  // Full adder for bit 0
    full_adder FA1 (A[1], B[1], C1,   SUM[1], C2);  // Full adder for bit 1
    full_adder FA2 (A[2], B[2], C2,   SUM[2], C3);  // Full adder for bit 2
    full_adder FA3 (A[3], B[3], C3,   SUM[3], COUT);// Full adder for bit 3

endmodule

// Full Adder Module:
// Each 1-bit Full Adder computes the sum and carry out of two 1-bit inputs and a carry-in (CIN).
// SUM = A ^ B ^ CIN and COUT = (A & B) | (B & CIN) | (A & CIN).

//4-bit Ripple Carry Adder (RCA):
// Four instances of the 1-bit full adder are cascaded together to form a 4-bit ripple carry adder.
// The carry out from each full adder is connected to the carry in of the next full adder.
// The final carry out (COUT) is the carry out of the most significant bit.
