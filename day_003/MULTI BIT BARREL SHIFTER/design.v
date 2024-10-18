// 8 BIT BARREL SHIFTER
module barrel_shifter (
    input [7:0] data_in,        // 8-bit input data
    input [2:0] shift_amount,   // Amount of shift (3-bit for 0-7 shifts)
    input [1:0] shift_type,     // 00: Logical Left, 01: Logical Right, 10: Circular Left, 11: Circular Right
    output reg [7:0] data_out   // 8-bit shifted output
);

always @(*) begin
    case (shift_type)
        2'b00: data_out = data_in << shift_amount;  // Logical Left Shift
        2'b01: data_out = data_in >> shift_amount;  // Logical Right Shift
        2'b10: data_out = (data_in << shift_amount) | (data_in >> (8 - shift_amount)); // Circular Left Shift
        2'b11: data_out = (data_in >> shift_amount) | (data_in << (8 - shift_amount)); // Circular Right Shift
        default: data_out = data_in;                // Default case (no shift)
    endcase
end

endmodule
