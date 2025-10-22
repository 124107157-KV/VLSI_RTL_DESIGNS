// Code your design here
// STRUCTURAL: 5-input majority = OR of all 3-way ANDs
module majority_ckt_struct(input  [5:1] x, output z);
  wire [9:0] w;

  and a0 (w[0], x[1], x[2], x[3]);
  and a1 (w[1], x[1], x[2], x[4]);
  and a2 (w[2], x[1], x[2], x[5]);
  and a3 (w[3], x[1], x[3], x[4]);
  and a4 (w[4], x[1], x[3], x[5]);
  and a5 (w[5], x[1], x[4], x[5]);
  and a6 (w[6], x[2], x[3], x[4]);
  and a7 (w[7], x[2], x[3], x[5]);
  and a8 (w[8], x[2], x[4], x[5]);
  and a9 (w[9], x[3], x[4], x[5]);

  or  o0 (z, w[0], w[1], w[2], w[3], w[4], w[5], w[6], w[7], w[8], w[9]);
endmodule


module majority_ckt_gate(input  [4:0] x, output z);
  assign z = (x[0] + x[1] + x[2] + x[3] + x[4]) >= 3;
endmodule
