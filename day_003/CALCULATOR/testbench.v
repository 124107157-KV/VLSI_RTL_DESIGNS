module tb_calculator();

    // Inputs
    reg [3:0] A;
    reg [3:0] B;
    reg [1:0] op;
    
    // Outputs
    wire [7:0] result;
    wire divide_by_zero;
    
    // Instantiate the calculator module
    calculator uut (
        .A(A),
        .B(B),
        .op(op),
        .result(result),
        .divide_by_zero(divide_by_zero)
    );
    
    // Test procedure
    initial begin
        // Monitor the changes in inputs and outputs
        $monitor("Time: %0t | A = %b | B = %b | op = %b | result = %b | divide_by_zero = %b", $time, A, B, op, result, divide_by_zero);
        
        // Test case 1: Add (3 + 2)
        A = 4'b0011; B = 4'b0010; op = 2'b00; #10;
        
        // Test case 2: Subtract (5 - 3)
        A = 4'b0101; B = 4'b0011; op = 2'b01; #10;
        
        // Test case 3: Multiply (2 * 4)
        A = 4'b0010; B = 4'b0100; op = 2'b10; #10;
        
        // Test case 4: Divide (8 / 2)
        A = 4'b1000; B = 4'b0010; op = 2'b11; #10;
        
        // Test case 5: Divide by zero (8 / 0)
        A = 4'b1000; B = 4'b0000; op = 2'b11; #10;
        
        // Finish simulation
        $finish;
    end
endmodule

// The testbench drives various values of A, B, and op to the calculator module and prints the result.
// It tests all four operations (add, subtract, multiply, divide) and checks for a divide-by-zero condition.
