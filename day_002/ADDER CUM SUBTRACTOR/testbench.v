// Testbench for Adder Cum Subtractor
module tb_adder_subtractor();

    // Declare inputs as reg and outputs as wire
    reg [3:0] A;
    reg [3:0] B;
    reg MODE;
    wire [3:0] RESULT;
    wire CARRY;
    wire OVERFLOW;

    // Instantiate the Adder Cum Subtractor module
    adder_subtractor uut (
        .A(A),
        .B(B),
        .MODE(MODE),
        .RESULT(RESULT),
        .CARRY(CARRY),
        .OVERFLOW(OVERFLOW)
    );

    // Test procedure
    initial begin
        // Monitor output
        $monitor("A = %b, B = %b, MODE = %b, RESULT = %b, CARRY = %b, OVERFLOW = %b", A, B, MODE, RESULT, CARRY, OVERFLOW);

        // Test cases for addition (MODE=0)
        A = 4'b0011; B = 4'b0001; MODE = 0; #10;   // 3 + 1
        A = 4'b1010; B = 4'b0101; MODE = 0; #10;   // 10 + 5
        A = 4'b1111; B = 4'b0001; MODE = 0; #10;   // 15 + 1
        
        // Test cases for subtraction (MODE=1)
        A = 4'b1001; B = 4'b0011; MODE = 1; #10;   // 9 - 3
        A = 4'b0111; B = 4'b0101; MODE = 1; #10;   // 7 - 5
        A = 4'b0001; B = 4'b0011; MODE = 1; #10;   // 1 - 3
        
        // Test cases for overflow
        A = 4'b0111; B = 4'b0101; MODE = 0; #10;   // 7 + 5 (overflow case)
        A = 4'b1000; B = 4'b1001; MODE = 1; #10;   // 8 - 9 (overflow case)

        // End the simulation
        $finish;
    end

endmodule

// The testbench tests both addition (MODE = 0) and subtraction (MODE = 1) for different 4-bit inputs A and B.
// It also includes cases to check the overflow condition (when the result exceeds the range of a 4-bit signed number).
