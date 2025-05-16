`timescale 1ns/1ps

module sync_fifo #(
    parameter WIDTH = 32,
    parameter DEPTH = 8
)(
    input wire clk,
    input wire rst,
    input wire wr_en,
    input wire rd_en,
    input wire [WIDTH-1:0] din,
    output reg [WIDTH-1:0] dout,
    output reg full,
    output reg empty
);

    reg [WIDTH-1:0] mem [0:DEPTH-1];
    reg [$clog2(DEPTH)-1:0] wptr, rptr;
    reg [$clog2(DEPTH):0] count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wptr  <= 0;
            rptr  <= 0;
            count <= 0;
            full  <= 0;
            empty <= 1;
            dout  <= 0;
        end else begin
            // Read logic
            if (rd_en && !empty) begin
                dout <= mem[rptr];
                rptr <= (rptr + 1) % DEPTH;
            end

            // Write logic
            if (wr_en && !full) begin
                mem[wptr] <= din;
                wptr <= (wptr + 1) % DEPTH;
            end

            // Update count
            case ({wr_en && !full, rd_en && !empty})
                2'b10: count <= count + 1;   // Write only
                2'b01: count <= count - 1;   // Read only
                default: count <= count;     // Both/no op
            endcase

            // Update status flags
            full  <= (count == DEPTH-1) && (wr_en && !full) && !(rd_en && !empty)
                   ? 1'b1 : (count == DEPTH) && !(rd_en && !empty) ? 1'b1 : 1'b0;
            empty <= (count == 1) && (rd_en && !empty) && !(wr_en && !full)
                   ? 1'b1 : (count == 0) && !(wr_en && !full) ? 1'b1 : 1'b0;
        end
    end

endmodule
