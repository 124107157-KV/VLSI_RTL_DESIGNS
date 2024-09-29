// Adder Cum Subtractor using Dataflow Modeling
module adder_subtractor (
    input [3:0] A,       // First 4-bit operand
    input [3:0] B,       // Second 4-bit operand
    input MODE,          // Mode: 0 for Add, 1 for Subtract
    output [3:0] RESULT, // 4-bit Result of Add or Subtract
    output CARRY,        // Carry for Addition or Borrow for Subtraction
    output OVERFLOW      // Overflow flag
);

    wire [3:0] B_complement;  // Complement of B when subtracting
    wire CARRY_INTERNAL;      // Internal carry
    
    // Two's complement of B when subtracting (MODE=1), otherwise B
    assign B_complement = B ^ {4{MODE}};  // XOR B with MODE to complement B when subtracting
    
    // Perform addition of A and (B_complement + MODE)
    assign {CARRY_INTERNAL, RESULT} = A + B_complement + MODE;
    
    // Carry is borrow in case of subtraction (MODE=1)
    assign CARRY = (MODE) ? ~CARRY_INTERNAL : CARRY_INTERNAL;
    
    // Overflow detection logic
    assign OVERFLOW = (A[3] ^ B_complement[3]) & (A[3] ^ RESULT[3]);

endmodule

// MODE: This is the control signal that selects between addition (MODE = 0) and subtraction (MODE = 1).
// B_complement: For subtraction, B is XORed with MODE, effectively complementing B when MODE = 1.
// Addition/Subtraction Logic: The operation A + B_complement + MODE performs the required addition or subtraction.
// Carry/Borrow: In addition mode (MODE = 0), the carry is directly generated. In subtraction mode (MODE = 1),
// the borrow is determined based on the internal carry.
// Overflow Detection: The overflow is detected by comparing the signs of the operands and the result.
