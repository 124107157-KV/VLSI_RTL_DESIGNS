module cmos_inverter_tb;
  reg a;
  wire y;

  // Instantiate the CMOS inverter
  cmos_inverter uut (
    .a(a),
    .y(y)
  );

  initial begin
    // Initialize input
    a = 0;
    #10; // Wait for 10 time units
    a = 1;
    #10; // Wait for 10 time units
    a = 0;
    #10; // Wait for 10 time units
    $finish; // End the simulation
  end

  initial begin
    $monitor("At time %t, a = %b, y = %b", $time, a, y);
  end
endmodule

// This test bench initializes the input a and toggles it between 0 and 1, while monitoring the output y.
// The $monitor statement prints the values of a and y at each time step.
