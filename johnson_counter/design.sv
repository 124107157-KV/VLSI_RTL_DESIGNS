// Code your design here
`timescale 1ns/1ps
// Johnson (twisted-ring) counter
// SHIFT_LEFT = 1 : next = {count[W-2:0], ~count[W-1]}  (classic form)
// SHIFT_LEFT = 0 : next = {~count[0], count[W-1:1]}    (mirror)
module johnson_counter #(
    parameter int WIDTH = 4,
    parameter bit SHIFT_LEFT = 1'b1            // choose shift direction
)(
    input  wire                 clk,
    input  wire                 reset,         // active-high, synchronous
    output reg  [WIDTH-1:0]     count
);
    always @(posedge clk) begin
        if (reset) begin
            count <= '0;                         // start at 0...0
        end else begin
            if (SHIFT_LEFT)
                count <= {count[WIDTH-2:0], ~count[WIDTH-1]};
            else
                count <= {~count[0], count[WIDTH-1:1]};
        end
    end
endmodule
