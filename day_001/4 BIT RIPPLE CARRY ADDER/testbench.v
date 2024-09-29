// Testbench for 4-bit Ripple Carry Adder
module tb_rca_4bit();

    // Declare inputs as reg and outputs as wire
    reg [3:0] A;
    reg [3:0] B;
    reg CIN;
    wire [3:0] SUM;
    wire COUT;

    // Instantiate the rca_4bit module
    rca_4bit uut (
        .A(A),
        .B(B),
        .CIN(CIN),
        .SUM(SUM),
        .COUT(COUT)
    );

    // Test procedure
    initial begin
        // Monitor output
        $monitor("A = %b, B = %b, CIN = %b, SUM = %b, COUT = %b", A, B, CIN, SUM, COUT);

        // Test cases
        A = 4'b0000; B = 4'b0000; CIN = 0; #10;  // 0 + 0
        A = 4'b0001; B = 4'b0001; CIN = 0; #10;  // 1 + 1
        A = 4'b0011; B = 4'b0010; CIN = 0; #10;  // 3 + 2
        A = 4'b0110; B = 4'b0101; CIN = 0; #10;  // 6 + 5
        A = 4'b1111; B = 4'b1111; CIN = 0; #10;  // 15 + 15
        A = 4'b0101; B = 4'b1010; CIN = 1; #10;  // 5 + 10 + carry in = 1
        A = 4'b1001; B = 4'b0110; CIN = 1; #10;  // 9 + 6 + carry in = 1

        // End the simulation
        $finish;
    end

endmodule

// The testbench applies various input combinations to verify the operation of the 4-bit RCA.
// The $monitor command tracks the values of A, B, CIN, SUM, and COUT for every test case.

// To generate all possible test cases for a 4-bit Ripple Carry Adder (RCA), 
// we need to consider all combinations of the two 4-bit inputs (A and B) and the carry-in (CIN).
// Since A and B are 4-bit numbers, each has 16 possible values (0000 to 1111), and CIN can be either 0 or 1.

// The total number of test cases will be 16 × 16 × 2 = 512 combinations (I/O).
//
//
// TESTBENCH CODE FOR LOOPING THROUGH ALL TEST CASES
// Testbench for 4-bit Ripple Carry Adder
module tb_rca_4bit();

    // Declare inputs as reg and outputs as wire
    reg [3:0] A;
    reg [3:0] B;
    reg CIN;
    wire [3:0] SUM;
    wire COUT;

    // Instantiate the rca_4bit module
    rca_4bit uut (
        .A(A),
        .B(B),
        .CIN(CIN),
        .SUM(SUM),
        .COUT(COUT)
    );

    // Test procedure
    initial begin
        // Monitor output
        $monitor("A = %b, B = %b, CIN = %b, SUM = %b, COUT = %b", A, B, CIN, SUM, COUT);

        // Loop through all possible values of A, B, and CIN
        for (A = 4'b0000; A <= 4'b1111; A = A + 1) begin
            for (B = 4'b0000; B <= 4'b1111; B = B + 1) begin
                // Test with CIN = 0
                CIN = 0;
                #10;
                
                // Test with CIN = 1
                CIN = 1;
                #10;
            end
        end

        // End the simulation
        $finish;
    end

endmodule

// Two nested for loops iterate through all possible 4-bit combinations of A and B. These loops cover values from 0000 to 1111.
// Inside these loops, the carry-in (CIN) is first set to 0, and after a delay (#10), it's set to 1.

// Since A has 16 possible values (0000 to 1111), and B also has 16 possible values, and for each combination of A and B,
// CIN can be either 0 or 1, we get a total of 16×16×2=512 test cases.

// The $monitor statement will print out the values of A, B, CIN, SUM, and COUT for each test case, allowing us to verify
// the correctness of the 4-bit ripple carry adder.
