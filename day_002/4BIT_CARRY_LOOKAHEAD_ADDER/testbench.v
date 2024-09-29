// Testbench for 4-bit Carry Lookahead Adder
module tb_cla_4bit();

    // Declare inputs as reg and outputs as wire
    reg [3:0] A;
    reg [3:0] B;
    reg CIN;
    wire [3:0] SUM;
    wire COUT;

    // Instantiate the CLA module
    cla_4bit uut (
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
        A = 4'b0000; B = 4'b0000; CIN = 0; #10;   // 0 + 0
        A = 4'b0001; B = 4'b0001; CIN = 0; #10;   // 1 + 1
        A = 4'b0010; B = 4'b0011; CIN = 0; #10;   // 2 + 3
        A = 4'b0100; B = 4'b0101; CIN = 0; #10;   // 4 + 5
        A = 4'b0110; B = 4'b0111; CIN = 1; #10;   // 6 + 7 + carry-in
        A = 4'b1000; B = 4'b1001; CIN = 1; #10;   // 8 + 9 + carry-in
        A = 4'b1111; B = 4'b1111; CIN = 0; #10;   // 15 + 15

        // End the simulation
        $finish;
    end

endmodule

// The testbench applies different input values to test the operation of the 4-bit CLA.
// $monitor prints the values of A, B, CIN, SUM, and COUT for each test case.
