`timescale 1ns/1ps

module clockdivider (
    input  clk,
    input  rst,
    output reg divideby2,
    output reg divideby4,
    output reg divideby8,
    output reg divideby16
);

    reg [3:0] count;

    always @(posedge clk) begin
        if (rst == 0)
            count <= 4'b0000;
        else
            count <= count + 1'b1;

        divideby2  <= count[0];
        divideby4  <= count[1];
        divideby8  <= count[2];
        divideby16 <= count[3];
    end

endmodule
