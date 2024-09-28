module cmos_inverter (a, y);
  input a;
  output y;
  supply1 vcc;
  supply0 gnd;
  pmos p1 (y, vcc, a);
  nmos n1 (y, gnd, a);
endmodule

// This code defines a CMOS inverter using PMOS and NMOS transistors.
// The pmos transistor connects the output y to the power supply vcc when the input a is low.
// The nmos transistor connects the output y to ground gnd when the input a is high1.
